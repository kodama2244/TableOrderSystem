package model.service;

import java.util.List;

import database.OrderDAO;
import model.dto.OrderDTO;
import model.dto.TableInfoDTO;
import viewmodel.TableBillViewModel;

public class TableBillService {

    public TableBillViewModel createViewModel(int tableNumber) {

        // 卓情報（例：席番号だけなら DTO を直接生成）
        TableInfoDTO tableInfo = new TableInfoDTO();
        tableInfo.setTableNumber(tableNumber);

        // 注文一覧を取得
        OrderDAO dao = new OrderDAO();
        List<OrderDTO> orderList = dao.findByTableNumber(tableNumber);

        // 合計金額を計算
        int total = 0;
        for (OrderDTO order : orderList) {
            total += order.getPrice() * order.getStock(); // 金額 × 個数
        }

        // ViewModel にセット
        TableBillViewModel vm = new TableBillViewModel();
        vm.setTableNumber(tableNumber);
        vm.setOrderList(orderList);

        return vm;
    }
}
