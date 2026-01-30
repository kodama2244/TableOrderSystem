package model.service;

import database.TableDAO;

public class TabletNumberService {
    
    private TableDAO tableDAO = new TableDAO();

    /**
     * 指定されたテーブル番号の状態を「利用中」にする
     */
    public void updateTableStatus(int tableNumber) {
        // DAOの更新メソッドを呼び出す
        tableDAO.updateTableStatus(tableNumber);
    }
}