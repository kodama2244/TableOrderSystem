package database;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import model.dto.TableListDTO;

public class TableDAO {

    /**
     * DBから全テーブルの状態を取得するメソッド
     */
    public List<TableListDTO> getAllTables() {
        List<TableListDTO> list = new ArrayList<>();
        
        // ★DBManagerのインスタンスを取得
        DBManager manager = DBManager.getInstance();

        // SQL: テーブル番号順に取得
        String sql = "SELECT TABLE_NUMBER, TABLE_STATUS FROM TABLE_INFO ORDER BY TABLE_NUMBER";

        // ★manager.getConnection() を使用して接続を取得
        try (Connection con = manager.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                TableListDTO dto = new TableListDTO();
                
                // 1. 卓番号をセット
                dto.setTableNumber(rs.getInt("TABLE_NUMBER"));

                // 2. 状態（文字列）を取得し、booleanに変換する
                String status = rs.getString("TABLE_STATUS");
                
                // DBが「案内可能」なら false(客なし)、それ以外なら true(客あり)
                boolean hasCustomer = !"案内可能".equals(status);
                dto.setHasCustomer(hasCustomer);

                list.add(dto);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return list;
    }

    /**
     * 会計完了後に空席に戻すメソッド
     */
    public void updateToEmpty(int tableNumber) {
        // ★DBManagerのインスタンスを取得
        DBManager manager = DBManager.getInstance();
        
        String sql = "UPDATE TABLE_INFO SET TABLE_STATUS = '案内可能', UPDATED_AT = SYSDATE WHERE TABLE_NUMBER = ?";
        
        // ★manager.getConnection() を使用
        try (Connection con = manager.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, tableNumber);
            ps.executeUpdate();

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    
    public void updateToOccupied(int tableNumber) {
        DBManager manager = DBManager.getInstance();
        // 画像の「テーブル」定義に合わせて SQL を作成
        String sql = "UPDATE TABLE_INFO SET TABLE_STATUS = '利用中', UPDATED_AT = SYSDATE WHERE TABLE_NUMBER = ?";

        try (Connection con = manager.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, tableNumber);
            ps.executeUpdate();
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}