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
                       + "FROM product p LEFT JOIN options o ON p.option_id = o.option_id "
                       + "WHERE p.product_id = ?";

            PreparedStatement stmt = cn.prepareStatement(sql);
            stmt.setInt(1, Integer.parseInt(productId));
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

    /**
     * 商品登録：option_id も保存するように修正
     */
    public void setProduct(List<String> plist) {
        DBManager manager = DBManager.getInstance();

        // 1. product_id をカラムリストから削除
        // 2. VALUES の ? を 1つ減らして 7個 にする
        String sql = "INSERT INTO product("
                + "category_id, product_name, product_price, " // product_id は書かない
                + "product_description, product_image, product_allergy, option_id, created_at, updated_at"
                + ") VALUES (?, ?, ?, ?, ?, ?, ?, SYSDATE, SYSDATE)";

        try (Connection cn = manager.getConnection();
                PreparedStatement ps = cn.prepareStatement(sql)) {
            
            // plist.get(0) が product_id だった場合、それは使わずに get(1) から開始する
        	ps.setInt(1, Integer.parseInt(plist.get(0))); // categoryId
        	ps.setString(2, plist.get(1));                // name
        	ps.setInt(3, Integer.parseInt(plist.get(2))); // price
        	ps.setString(4, plist.get(3));                // description
        	ps.setString(5, plist.get(4));                // fileName
        	ps.setString(6, plist.get(5));                // allergy
        	ps.setInt(7, Integer.parseInt(plist.get(6))); // optionId // option_id

            ps.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void DeleteProduct(String id) {
        DBManager manager = DBManager.getInstance();
        String sql = "DELETE FROM product WHERE product_id = ?";

        try (Connection cn = manager.getConnection();
                PreparedStatement ps = cn.prepareStatement(sql)) {
            ps.setInt(1, Integer.parseInt(id)); 
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

            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}