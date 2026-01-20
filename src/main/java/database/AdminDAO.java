package database;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class AdminDAO {
    public boolean Logincheck(String loginId, String password) {
        DBManager manager = DBManager.getInstance();
        // 設計図通りのカラム名を使用
        String sql = "SELECT * FROM admins WHERE login_id = ? AND password = ?";

        try (Connection cn = manager.getConnection();
             PreparedStatement ps = cn.prepareStatement(sql)) {
            
            ps.setString(1, loginId);
            ps.setString(2, password);

            try (ResultSet rs = ps.executeQuery()) {
                return rs.next(); // レコードが存在すればtrue
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    public boolean registerAdmin(String loginId, String password) {
        DBManager manager = DBManager.getInstance();
        String sql = "INSERT INTO admins (login_id, password) VALUES (?, ?)";
        try (Connection cn = manager.getConnection();
             PreparedStatement ps = cn.prepareStatement(sql)) {
            ps.setString(1, loginId);
            ps.setString(2, password);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}
