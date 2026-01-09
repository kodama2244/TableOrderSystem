package model.service;

import java.util.List;

import database.OrderHistoryDAO;
import model.dto.OrderHistoryDTO;
import viewmodel.StoreSalesViewModel;

public class StoreSalesService {

    /**
     * 指定された日付の売上情報を取得してViewModelにまとめる
     * @param targetDate 検索対象日 (yyyy-MM-dd)
     * @return 画面表示用データ(ViewModel)
     */
    public StoreSalesViewModel getSalesByDate(String targetDate) {
        OrderHistoryDAO dao = new OrderHistoryDAO();
        StoreSalesViewModel vm = new StoreSalesViewModel();

        // 1. DAOから指定日の「会計済(status_id=4)」の明細を取得
        // ※DAOに別途このメソッドを作成する必要があります（下記参照）
        List<OrderHistoryDTO> salesList = dao.getSalesByDate(targetDate);

        // 2. 合計金額の算出
        int totalSales = 0;
        if (salesList != null) {
            for (OrderHistoryDTO item : salesList) {
                // (商品単価 + オプション価格) * 数量
                totalSales += (item.getProductPrice() + item.getOptionPrice()) * item.getProductQuantity();
            }
        }

        // 3. ViewModelにセット
        vm.setSalesList(salesList);
        vm.setTotalSales(totalSales);
        vm.setTargetDate(targetDate);

        return vm;
    }
}
