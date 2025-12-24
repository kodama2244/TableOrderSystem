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

	    String sql = 
	        "SELECT " +
	        "  P.PRODUCT_NAME  AS NAME, " +
	        "  P.PRODUCT_PRICE AS PRICE, " +
	        "  OH.QUANTITY     AS AMOUNT, " +
	        "  OH.STATUS_ID    AS STATUS_ID " + 
	        "FROM ORDERS O " +
	        "  INNER JOIN ORDER_HISTORY OH ON O.ORDER_ID = OH.ORDER_ID " +
	        "  INNER JOIN PRODUCT P        ON OH.PRODUCT_ID = P.PRODUCT_ID " +
	        "  INNER JOIN TABLE_INFO T     ON O.TABLE_ID = T.TABLE_ID " +
	        "WHERE " +
	        "  T.TABLE_NUMBER = ? " +
	        "  AND OH.STATUS_ID != 4 " + // ★親(O)ではなく、明細(OH)の状態を見る
	        "ORDER BY OH.ORDER_HISTORY_ID"; // 追加：表示順を安定させる

	    try (Connection con = manager.getConnection();
	         PreparedStatement ps = con.prepareStatement(sql)) {

	        ps.setInt(1, tableNumber);
	        ResultSet rs = ps.executeQuery();

	        while (rs.next()) {
	            OrderDTO dto = new OrderDTO();
	            dto.setOrderName(rs.getString("NAME"));
	            dto.setPrice(rs.getInt("PRICE"));
	            dto.setStock(rs.getInt("AMOUNT"));
	            
	            // 明細ごとの状態IDを取得
	            int statusId = rs.getInt("STATUS_ID");
	            String statusName = "";
	            
	            switch(statusId) {
	                case 1: statusName = "注文済"; break;
	                case 2: statusName = "調理済"; break;
	                case 3: statusName = "配膳済"; break;
	                default: statusName = "不明"; break;
	            }
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