package database;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import model.dto.OrderDTO;

public class OrderDAO {

	public List<OrderDTO> findByTableNumber(int tableNumber) {
		List<OrderDTO> list = new ArrayList<>();
		DBManager manager = DBManager.getInstance();

		// SQLを修正：オプション名、オプション価格、オプションIDを追加
		String sql = "SELECT " +
				"  O.ORDER_ID, " +
				"  OH.ORDER_HISTORY_ID, " +
				"  P.PRODUCT_NAME  AS NAME, " +
				"  P.PRODUCT_PRICE AS PRICE, " +
				"  OH.QUANTITY      AS AMOUNT, " +
				"  OH.STATUS_ID     AS STATUS_ID, " +
				"  OH.OPTION_ID, " + // ★追加
				"  COALESCE(OPT.OPTION_NAME, '') AS OPTION_NAME, " + // ★追加（オプション名）
				"  COALESCE(OPT.OPTION_PRICE, 0) AS OPTION_PRICE " + // ★追加（オプション価格）
				"FROM ORDERS O " +
				"  INNER JOIN ORDER_HISTORY OH ON O.ORDER_ID = OH.ORDER_ID " +
				"  INNER JOIN PRODUCT P        ON OH.PRODUCT_ID = P.PRODUCT_ID " +
				"  INNER JOIN TABLE_INFO T      ON O.TABLE_ID = T.TABLE_ID " +
				"  LEFT JOIN OPTIONS OPT       ON OH.OPTION_ID = OPT.OPTION_ID " + // ★JOINを追加
				"WHERE " +
				"  T.TABLE_NUMBER = ? " +
				"  AND OH.STATUS_ID != 4 " +
				"ORDER BY OH.ORDER_HISTORY_ID";

		try (Connection con = manager.getConnection();
				PreparedStatement ps = con.prepareStatement(sql)) {

			ps.setInt(1, tableNumber);
			ResultSet rs = ps.executeQuery();

			while (rs.next()) {
				OrderDTO dto = new OrderDTO();
				dto.setOrderId(rs.getInt("ORDER_ID"));

				// --- 商品名とオプション名を合わせる処理 ---
				String productName = rs.getString("NAME");
				String optionName = rs.getString("OPTION_NAME");
				if (optionName != null && !optionName.isEmpty() && !optionName.equals("なし")) {
					productName += " (" + optionName + ")"; // 例：「かけそば (大盛)」
				}
				dto.setOrderName(productName);

				// --- 価格計算（本体 + オプション） ---
				int unitPrice = rs.getInt("PRICE") + rs.getInt("OPTION_PRICE");
				dto.setPrice(unitPrice);

				dto.setStock(rs.getInt("AMOUNT"));

				int statusId = rs.getInt("STATUS_ID");
				String statusName = (statusId == 1) ? "注文済" : (statusId == 2) ? "調理済" : (statusId == 3) ? "配膳済" : "不明";
				dto.setOrderStatus(statusName);

				list.add(dto);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return list;
	}

	// updateStatusToPaid メソッドなどはそのままでOK
	public void updateStatusToPaid(int tableNumber) {
		DBManager manager = DBManager.getInstance();

		// 1. 注文明細をすべて「4:会計済」にするSQL
		String sqlHistory = "UPDATE ORDER_HISTORY SET STATUS_ID = 4 WHERE ORDER_ID IN " +
				"(SELECT ORDER_ID FROM ORDERS WHERE TABLE_ID = " +
				"(SELECT TABLE_ID FROM TABLE_INFO WHERE TABLE_NUMBER = ?) AND STATUS_ID != 4)";

		// 2. 注文親データを「4:会計済」にするSQL
		String sqlOrder = "UPDATE ORDERS SET STATUS_ID = 4 WHERE TABLE_ID = " +
				"(SELECT TABLE_ID FROM TABLE_INFO WHERE TABLE_NUMBER = ?) AND STATUS_ID != 4";

		try (Connection con = manager.getConnection()) {
			con.setAutoCommit(false); // トランザクション開始

			try (PreparedStatement ps1 = con.prepareStatement(sqlHistory);
					PreparedStatement ps2 = con.prepareStatement(sqlOrder)) {

				ps1.setInt(1, tableNumber);
				ps1.executeUpdate();

				ps2.setInt(1, tableNumber);
				ps2.executeUpdate();

				con.commit();
			} catch (Exception e) {
				con.rollback();
				throw e;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
}