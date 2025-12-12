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

	public void setOrderHistory(List<OrderItemDTO> orderItems, int people, int tableNumber,int totalPrice) {
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

	public List<OrderHistoryDTO> getOrderHistory(int tableNumber) {
		List<OrderHistoryDTO> list = new ArrayList<>();
		DBManager manager = DBManager.getInstance();

		try (Connection cn = manager.getConnection()) {
			String sql = "";

			PreparedStatement stmt = cn.prepareStatement(sql);
			ResultSet rs = stmt.executeQuery();

			while (rs.next()) {
				OrderHistoryDTO dto = new OrderHistoryDTO();

				list.add(dto);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return list;
	}
}
