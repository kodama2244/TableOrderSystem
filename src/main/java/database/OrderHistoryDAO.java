package database;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import model.dto.OrderHistoryDTO;
import model.dto.OrderItemDTO;

public class OrderHistoryDAO {

	public void setOrderHistory(List<OrderItemDTO> orderItems, int people, int tableNumber, int totalPrice) {
		DBManager manager = DBManager.getInstance();

		String sqlOrder = "INSERT INTO orders(order_id, order_datetime, customer_count, table_id, status_id, created_at, updated_at,order_total) "
				+ "VALUES (order_seq.NEXTVAL, SYSDATE, ?, ?, ?, SYSDATE, SYSDATE, ?)";

		String sqlDetail = "INSERT INTO order_history(order_history_id, order_id, product_id, quantity, status_id, created_at, updated_at, option_id) "
				+ "VALUES (order_detail_seq.NEXTVAL, ?, ?, ?, ?, SYSDATE, SYSDATE, ?)";

		try (Connection cn = manager.getConnection()) {

			cn.setAutoCommit(false); // トランザクション開始
			int orderId = 0; // 注文IDを保持

			// --- ① 注文テーブル INSERT ---
			try (PreparedStatement ps = cn.prepareStatement(sqlOrder, new String[] { "order_id" })) {
				ps.setInt(1, people);
				ps.setInt(2, tableNumber);
				ps.setInt(3, 1);// status_id 初期値 1
				ps.setInt(4, totalPrice);
				ps.executeUpdate();

				// 自動採番された注文IDを取得
				try (ResultSet rs = ps.getGeneratedKeys()) {
					if (rs.next()) {
						orderId = rs.getInt(1);
					} else {
						throw new SQLException("注文IDの取得に失敗しました。");
					}
				}
			}

			// --- ② 注文明細テーブル INSERT（商品ごと） ---
			try (PreparedStatement ps = cn.prepareStatement(sqlDetail)) {
				for (OrderItemDTO item : orderItems) {
					ps.setInt(1, orderId); // 注文ID
					ps.setInt(2, item.getProductId()); // 商品ID
					ps.setInt(3, item.getQuantity()); // 数量
					ps.setInt(4, 1); // status_id 初期値 1
					ps.setInt(5, item.getOptionId()); // オプションID)
					ps.addBatch();
				}
				ps.executeBatch();
			}

			cn.commit(); // コミット

		} catch (SQLException e) {
			e.printStackTrace();

		}
	}

	// --- ① テーブル番号指定の履歴取得（合算版） ---
	public List<OrderHistoryDTO> getOrderHistory(int tableNumber) {
		List<OrderHistoryDTO> list = new ArrayList<>();
		DBManager manager = DBManager.getInstance();

		try (Connection cn = manager.getConnection()) {
			String sql = "SELECT\n"
					+ "    OH.QUANTITY AS productQuantity,\n"
					+ "    P.PRODUCT_NAME AS productName,\n"
					+ "    S.STATUS_NAME AS statusName,\n"
					+ "    COALESCE(O.OPTION_NAME, 'なし') AS optionName,\n"
					+ "    COALESCE(O.OPTION_PRICE, 0) AS optionPrice,\n" // ★オプション価格を取得
					+ "    P.PRODUCT_PRICE AS productPrice\n"
					+ "FROM\n"
					+ "    ORDERS ORDS\n"
					+ "JOIN\n"
					+ "    ORDER_HISTORY OH ON ORDS.ORDER_ID = OH.ORDER_ID\n"
					+ "JOIN\n"
					+ "    PRODUCT P ON OH.PRODUCT_ID = P.PRODUCT_ID\n"
					+ "JOIN\n"
					+ "    STATUS S ON OH.STATUS_ID = S.STATUS_ID\n"
					+ "LEFT JOIN\n"
					+ "    OPTIONS O ON OH.OPTION_ID = O.OPTION_ID\n"
					+ "WHERE\n"
					+ "    ORDS.TABLE_ID = ?\n"
					+ "    AND OH.STATUS_ID != 4";

			try (PreparedStatement ps = cn.prepareStatement(sql)) {
				ps.setInt(1, tableNumber);
				try (ResultSet rs = ps.executeQuery()) {
					while (rs.next()) {
						OrderHistoryDTO dto = new OrderHistoryDTO();
						// 各フィールドに個別にセット
						dto.setProductQuantity(rs.getInt("productQuantity"));
						dto.setProductName(rs.getString("productName"));
						dto.setStatusName(rs.getString("statusName"));
						dto.setOptionName(rs.getString("optionName"));
						dto.setOptionPrice(rs.getInt("optionPrice")); // ★DTOの新しいフィールドへ
						dto.setProductPrice(rs.getInt("productPrice"));

						list.add(dto);
					}
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return list;
	}

	// --- ② 全体の注文履歴取得（合算版） ---
	public List<OrderHistoryDTO> getOrderHistory() {
		List<OrderHistoryDTO> list = new ArrayList<>();
		DBManager manager = DBManager.getInstance();

		try (Connection cn = manager.getConnection()) {
			String sql = "SELECT\n"
					+ "    OH.QUANTITY AS productQuantity,\n"
					+ "    OH.ORDER_HISTORY_ID AS orderHistoryId,\n"
					+ "    P.PRODUCT_NAME AS productName,\n"
					+ "    ORDS.TABLE_ID AS tableNumber,\n"
					+ "    S.STATUS_NAME AS statusName,\n"
					+ "    COALESCE(O.OPTION_NAME, 'オプションなし') AS optionName,\n"
					+ "    (P.PRODUCT_PRICE + COALESCE(O.OPTION_PRICE, 0)) AS totalPriceWithOption\n" // ★SQLで合算
					+ "FROM\n"
					+ "    ORDERS ORDS\n"
					+ "JOIN\n"
					+ "    ORDER_HISTORY OH ON ORDS.ORDER_ID = OH.ORDER_ID\n"
					+ "JOIN\n"
					+ "    PRODUCT P ON OH.PRODUCT_ID = P.PRODUCT_ID\n"
					+ "JOIN\n"
					+ "    STATUS S ON OH.STATUS_ID = S.STATUS_ID\n"
					+ "LEFT JOIN\n"
					+ "    OPTIONS O ON OH.OPTION_ID = O.OPTION_ID\n"
					+ "WHERE\n"
					+ "    OH.STATUS_ID NOT IN (3, 4)";

			try (PreparedStatement ps = cn.prepareStatement(sql)) {
				try (ResultSet rs = ps.executeQuery()) {
					while (rs.next()) {
						OrderHistoryDTO dto = new OrderHistoryDTO();
						dto.setTableNumber(rs.getInt("tableNumber"));
						dto.setOrderHistoryId(rs.getInt("orderHistoryId"));
						dto.setProductQuantity(rs.getInt("productQuantity"));

						String name = rs.getString("productName");
						String optName = rs.getString("optionName");
						if (!optName.equals("オプションなし")) {
							name += " (" + optName + ")";
						}
						dto.setProductName(name);

						dto.setStatusName(rs.getString("statusName"));
						// ★ここでも合算価格をセット
						dto.setProductPrice(rs.getInt("totalPriceWithOption"));

						list.add(dto);
					}
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return list;
	}

	public void changeStatus(int orderHistoryId, int status) {
		if (status != 2 && status != 3) {
			return;
		}

		DBManager manager = DBManager.getInstance();
		String sql = "UPDATE ORDER_HISTORY "
				+ "SET STATUS_ID = ?, UPDATED_AT = SYSDATE "
				+ "WHERE ORDER_HISTORY_ID = ?";

		try (Connection cn = manager.getConnection();
				PreparedStatement ps = cn.prepareStatement(sql)) {

			ps.setInt(1, status);
			ps.setInt(2, orderHistoryId);

			int count = ps.executeUpdate();
			System.out.println("更新件数: " + count);

		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	public List<OrderHistoryDTO> getSalesByDate(String targetDate) {
	    List<OrderHistoryDTO> list = new ArrayList<>();
	    DBManager manager = DBManager.getInstance();

	    // 文字列の結合部分の空白をすべて半角スペースに修正
	    String sql = "SELECT OH.QUANTITY, P.PRODUCT_NAME, P.PRODUCT_PRICE, "
	               + "COALESCE(O.OPTION_NAME, 'なし') AS OPTION_NAME, "
	               + "COALESCE(O.OPTION_PRICE, 0) AS OPTION_PRICE, "
	               + "TO_CHAR(OH.UPDATED_AT, 'HH24:MI') AS SALE_TIME "
	               + "FROM ORDER_HISTORY OH "
	               + "JOIN PRODUCT P ON OH.PRODUCT_ID = P.PRODUCT_ID "
	               + "LEFT JOIN OPTIONS O ON OH.OPTION_ID = O.OPTION_ID "
	               + "WHERE OH.STATUS_ID = 4 "
	               + "AND TO_CHAR(OH.UPDATED_AT, 'YYYY-MM-DD') = ? "
	               + "ORDER BY OH.UPDATED_AT DESC";

	    try (Connection cn = manager.getConnection();
	         PreparedStatement ps = cn.prepareStatement(sql)) {
	        
	        ps.setString(1, targetDate);
	        
	        try (ResultSet rs = ps.executeQuery()) {
	            while (rs.next()) {
	                OrderHistoryDTO dto = new OrderHistoryDTO();
	                dto.setProductName(rs.getString("PRODUCT_NAME"));
	                dto.setProductPrice(rs.getInt("PRODUCT_PRICE"));
	                dto.setOptionName(rs.getString("OPTION_NAME"));
	                dto.setOptionPrice(rs.getInt("OPTION_PRICE"));
	                dto.setProductQuantity(rs.getInt("QUANTITY"));
	                dto.setOrderDate(rs.getString("SALE_TIME"));

	                list.add(dto);
	            }
	        }
	    } catch (SQLException e) {
	        // コンソールでエラー内容を確認できるようにする
	        System.err.println("SQLエラー: " + e.getMessage());
	        e.printStackTrace();
	    }
	    return list;
	}
}
