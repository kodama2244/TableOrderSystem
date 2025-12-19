package model.service;

import database.OrderDAO;
import database.TableDAO;

public class PaymentService {

    private OrderDAO orderDAO = new OrderDAO();
    private TableDAO tableDAO = new TableDAO();

    public void payBill(int tableNumber, int payAmount, int totalAmount) {

        // ① 注文をすべて「会計済」に更新
        orderDAO.updateStatusToPaid(tableNumber);

        // ② テーブルを「空席状態」に戻す
        tableDAO.updateToEmpty(tableNumber);
    }
}
