package database;

import java.util.HashMap;
import java.util.Map;

public class TableDAO {

    // 仮テーブル状態管理（本番は DB）
    private static Map<Integer, Boolean> tableStatus = new HashMap<>();

    static {
        for (int i = 1; i <= 16; i++) {
            tableStatus.put(i, true); // true = 空席
        }
    }

    public void updateToEmpty(int tableNumber) {
        tableStatus.put(tableNumber, true); // 空席に戻す
    }
}
