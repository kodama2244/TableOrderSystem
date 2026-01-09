package model.service;

import database.OrderDAO;
import database.TableDAO;

public class PaymentService {

    private OrderDAO orderDAO = new OrderDAO();
    private TableDAO tableDAO = new TableDAO();

    /**
     * 会計処理：注文ステータスの更新とテーブルの解放を一つの処理として実行
     */
    public void payBill(int tableNumber, int payAmount, int totalAmount) {

        // ① 注文をすべて「会計済」に更新
        // ※ 本来はここでDBのトランザクション管理を行うのが望ましい
        orderDAO.updateStatusToPaid(tableNumber);

        // ② テーブルを「案内可能」状態に戻す
        tableDAO.updateToEmpty(tableNumber);
    }
}