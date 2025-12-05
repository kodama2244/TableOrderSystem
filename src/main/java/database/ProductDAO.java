package database;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import model.dto.ProductDTO;

public class ProductDAO {
	public List<ProductDTO> getProduct(String productId) {
	    List<ProductDTO> list = new ArrayList<>();
	    DBManager manager = DBManager.getInstance();

	    try (Connection cn = manager.getConnection()) {
	        String sql = "SELECT product_id,product_name,product_price,category_id,product_image,product_description,product_allergy FROM product WHERE product_id = ?";

	        PreparedStatement stmt = cn.prepareStatement(sql);
	        stmt.setString(1, productId);
	        ResultSet rs = stmt.executeQuery();

	        while (rs.next()) {
	            ProductDTO dto = new ProductDTO();
	            dto.setProductId(rs.getInt("product_id"));
	            dto.setProductName(rs.getString("product_name"));
	            dto.setProductPrice(rs.getInt("product_price"));
	            dto.setCategory(rs.getInt("category_id"));
	            dto.setProductImage(rs.getString("product_image"));
	            dto.setProductDescription(rs.getString("product_description"));
	            dto.setProductAllergy(rs.getString("product_allergy"));

	            list.add(dto);
	        }
	    } catch (SQLException e) {
	        e.printStackTrace();
	    }
	    return list;
	}
}
