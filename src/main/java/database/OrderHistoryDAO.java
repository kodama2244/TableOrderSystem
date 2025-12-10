package database;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import model.dto.OrderHistoryDTO;

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

	public List<OrderHistoryDTO> getOrderHistory() {
		 List<OrderHistoryDTO> list = new ArrayList<>();
		    DBManager manager = DBManager.getInstance();

		    try (Connection cn = manager.getConnection()) {
		        String sql = "SELECT * FROM ORDER_HISTORY";

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
