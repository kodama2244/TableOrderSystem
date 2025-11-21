package database;

import java.sql.Connection;
import java.sql.SQLException;

public class TestDBConnection {
    public static void main(String[] args) {
        DBManager db = DBManager.getInstance();
        try (Connection con = db.getConnection()) {
            if (con != null && !con.isClosed()) {
                System.out.println("接続成功！");
            } else {
                System.out.println("接続失敗…");
            }
        } catch (SQLException e) {
            System.out.println("接続エラー！");
            e.printStackTrace();
        }
    }
}
