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
		    String sql = "SELECT product_name, product_price, product_image FROM product WHERE category_id = ?"; 

			PreparedStatement stmt = cn.prepareStatement(sql);
			stmt.setString(1,category);
			ResultSet rs = stmt.executeQuery();
			while (rs.next()) {
				ProductOptionDTO dto = new ProductOptionDTO();
				dto.setProductName(rs.getString("product_name"));
				dto.setProductPrice(rs.getInt("product_price"));
				dto.setProductImage(rs.getString("product_image"));
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
	
	public void setProduct(List<String> plist) {
	    DBManager manager = DBManager.getInstance();

	    String sql = "INSERT INTO product("
	            + "product_id, category_id, product_name, product_price, "
	            + "product_description, product_image, product_allergy, created_at, updated_at"
	            + ") VALUES (?, ?, ?, ?, ?, ?, ?, SYSDATE, SYSDATE)";

	    try (Connection cn = manager.getConnection();
	         PreparedStatement ps = cn.prepareStatement(sql)) {

	        ps.setInt(1, Integer.parseInt(plist.get(0))); // product_id
	        ps.setInt(2, Integer.parseInt(plist.get(1))); // category_id
	        ps.setString(3, plist.get(2));                // product_name
	        ps.setInt(4, Integer.parseInt(plist.get(3))); // product_price
	        ps.setString(5, plist.get(4));                // product_description
	        ps.setString(6, plist.get(5));                // product_image
	        ps.setString(7, plist.get(6));                // product_allergy

	        ps.executeUpdate();
	        System.out.println("商品を登録しました。");

	    } catch (SQLException e) {
	        e.printStackTrace();
	    }
	}
}