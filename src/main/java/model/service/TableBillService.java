package model.service;

import java.util.List;

import database.OrderDAO;
import model.dto.OrderDTO;
import viewmodel.TableBillViewModel;

public class TableBillService {

    public TableBillViewModel createViewModel(int tableNumber) {

        // 1. 注文一覧を取得
        OrderDAO dao = new OrderDAO();
        List<OrderDTO> orderList = dao.findByTableNumber(tableNumber);

        // 2. 合計金額を計算
        int total = 0;
        for (OrderDTO order : orderList) {
            total += order.getPrice() * order.getStock();
        }

        // 3. ViewModel にセット
        TableBillViewModel vm = new TableBillViewModel();
        vm.setTableNumber(tableNumber);
        vm.setOrderList(orderList);
        vm.setTotalPrice(total); // ★ここを追加しました！

        return vm;
    }
}