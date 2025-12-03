package database;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.List;

public class OrderHistoryDAO {
	public void setOrderHistory(List<String> productIds) {
		DBManager manager = DBManager.getInstance();

		String sql = "INSERT INTO product("
				+ "product_id, category_id, product_name, product_price, "
				+ "product_description, product_image, product_allergy, created_at, updated_at"
				+ ") VALUES (?, ?, ?, ?, ?, ?, ?, SYSDATE, SYSDATE)";

		try (Connection cn = manager.getConnection();
				PreparedStatement ps = cn.prepareStatement(sql)) {


		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
}
