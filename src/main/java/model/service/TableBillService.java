package model.service;

import java.util.List;

import database.OrderDAO;
import model.dto.OrderDTO;
import viewmodel.TableBillViewModel;

public class TableBillService {

    public TableBillViewModel createViewModel(int tableNumber) {
        OrderDAO dao = new OrderDAO();
        
        // 1. 指定テーブルの注文一覧を取得
        List<OrderDTO> orderList = dao.findByTableNumber(tableNumber);

        // 2. 合計金額を計算（ビジネスロジックはServiceの担当）
        int total = 0;
        if (orderList != null) {
            for (OrderDTO order : orderList) {
                total += order.getPrice() * order.getStock();
            }
        }

        // 3. ViewModelの構築
        TableBillViewModel vm = new TableBillViewModel();
        vm.setTableNumber(tableNumber);
        vm.setOrderList(orderList);
        vm.setTotalPrice(total);

        return vm;
    }
}