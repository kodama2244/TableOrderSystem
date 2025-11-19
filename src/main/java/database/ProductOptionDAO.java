package database;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import model.dto.ProductOptionDTO;

public class ProductOptionDAO {
	public List<ProductOptionDTO> getProducts(String category){
		ArrayList<ProductOptionDTO> list = new ArrayList<ProductOptionDTO>();
		DBManager manager = DBManager.getInstance();
		try (Connection cn = manager.getConnection()) {
			String sql = "";
			PreparedStatement stmt = cn.prepareStatement(sql);
			ResultSet rs = stmt.executeQuery();
			while (rs.next()) {
				ProductOptionDTO dto = new ProductOptionDTO();
				dto.setProductName(rs.getString("product_name"));
				dto.setProductPrice(rs.getInt("product_price"));
				dto.setProductDescription(rs.getString("product_description"));
				dto.setProductImage(rs.getString("product_image"));
				dto.setProductAllergy(rs.getString("product_allergy"));
				dto.setOptionName(rs.getString("option_name"));
				dto.setOptionPrice(rs.getInt("option_price"));
				dto.setOptionDescription(rs.getString("option_description"));
				list.add(dto);
			}
			// データをリストに格納
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return list;
	}
	
	public List<ProductOptionDTO> getProduct(String productId){
		ArrayList<ProductOptionDTO> list = new ArrayList<ProductOptionDTO>();
		
		
		
		return list;
	}
}
