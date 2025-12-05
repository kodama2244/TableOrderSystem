package database;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import model.dto.ProductDTO;
import model.dto.ProductOptionDTO;

public class ProductOptionDAO {
	public List<ProductOptionDTO> getProducts(String category) {
		ArrayList<ProductOptionDTO> list = new ArrayList<ProductOptionDTO>();
		DBManager manager = DBManager.getInstance();
		try (Connection cn = manager.getConnection()) {
			String sql = "SELECT product_id, product_name, product_price, product_image, product_description, product_allergy FROM product WHERE category_id = ?";

			PreparedStatement stmt = cn.prepareStatement(sql);
			stmt.setString(1, category);
			ResultSet rs = stmt.executeQuery();
			while (rs.next()) {
				ProductOptionDTO dto = new ProductOptionDTO();
				dto.setProductId(rs.getInt("product_id"));
				dto.setProductName(rs.getString("product_name"));
				dto.setProductPrice(rs.getInt("product_price"));
				dto.setProductImage(rs.getString("product_image"));
				dto.setProductDescription(rs.getString("product_description"));
				dto.setProductAllergy(rs.getString("product_allergy"));
				list.add(dto);
			}
			// データをリストに格納
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return list;
	}

	public List<ProductOptionDTO> getProduct(String productId) {
	    List<ProductOptionDTO> list = new ArrayList<>();
	    DBManager manager = DBManager.getInstance();

	    try (Connection cn = manager.getConnection()) {
	        String sql = "SELECT p.product_id, p.product_name, p.product_price, p.product_image, p.product_description, "
	                   + "p.product_allergy, o.option_id, o.option_name, o.option_price "
	                   + "FROM product p JOIN options o ON p.option_id = o.option_id "
	                   + "WHERE p.product_id = ?";

	        PreparedStatement stmt = cn.prepareStatement(sql);
	        stmt.setString(1, productId);
	        ResultSet rs = stmt.executeQuery();

	        while (rs.next()) {
	            ProductOptionDTO dto = new ProductOptionDTO();
	            dto.setProductId(rs.getInt("product_id"));
	            dto.setProductName(rs.getString("product_name"));
	            dto.setProductPrice(rs.getInt("product_price"));
	            dto.setProductImage(rs.getString("product_image"));
	            dto.setProductDescription(rs.getString("product_description"));
	            dto.setProductAllergy(rs.getString("product_allergy"));
	            dto.setOptionId(rs.getInt("option_id"));
	            dto.setOptionName(rs.getString("option_name"));
	            dto.setOptionPrice(rs.getInt("option_price"));

	            list.add(dto);
	        }
	    } catch (SQLException e) {
	        e.printStackTrace();
	    }
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
			ps.setString(3, plist.get(2)); // product_name
			ps.setInt(4, Integer.parseInt(plist.get(3))); // product_price
			ps.setString(5, plist.get(4)); // product_description
			ps.setString(6, plist.get(5)); // product_image
			ps.setString(7, plist.get(6)); // product_allergy

			ps.executeUpdate();
			System.out.println("商品を登録しました。");

		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	public void DeleteProduct(String id) {
		DBManager manager = DBManager.getInstance();
		String sql = "DELETE FROM product WHERE product_id = ?";

		try (Connection cn = manager.getConnection();
				PreparedStatement ps = cn.prepareStatement(sql)) {
			ps.setInt(1, Integer.parseInt(id)); // product_id
		
			ps.executeUpdate();
			System.out.println("商品を削除しました。");

		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	public void updateProduct(ProductDTO dto) {
	    DBManager manager = DBManager.getInstance();
	    boolean hasImage = dto.getProductImage() != null && !dto.getProductImage().isEmpty();

	    String sql;
	    if (hasImage) {
	        sql = "UPDATE product SET category_id = ?, product_name = ?, product_price = ?, "
	            + "product_description = ?, product_image = ?, product_allergy = ?, updated_at = SYSDATE "
	            + "WHERE product_id = ?";
	    } else {
	        sql = "UPDATE product SET category_id = ?, product_name = ?, product_price = ?, "
	            + "product_description = ?, product_allergy = ?, updated_at = SYSDATE "
	            + "WHERE product_id = ?";
	    }

	    try (Connection cn = manager.getConnection();
	         PreparedStatement ps = cn.prepareStatement(sql)) {

	        ps.setInt(1, dto.getCategory());
	        ps.setString(2, dto.getProductName());
	        ps.setInt(3, dto.getProductPrice());
	        ps.setString(4, dto.getProductDescription());

	        if (hasImage) {
	            ps.setString(5, dto.getProductImage());
	            ps.setString(6, dto.getProductAllergy());
	            ps.setInt(7, dto.getProductId());
	        } else {
	            ps.setString(5, dto.getProductAllergy());
	            ps.setInt(6, dto.getProductId());
	        }

	        int updatedRows = ps.executeUpdate();
	        if (updatedRows > 0) {
	            System.out.println("商品を更新しました。更新件数: " + updatedRows);
	        } else {
	            System.out.println("更新対象がありません。productId=" + dto.getProductId());
	        }

	    } catch (SQLException e) {
	        e.printStackTrace();
	    }
	}
}