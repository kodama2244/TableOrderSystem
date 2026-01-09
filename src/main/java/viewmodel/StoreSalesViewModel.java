package viewmodel;

import java.util.List;

import model.dto.OrderHistoryDTO;

/**
 * 店舗売上管理画面用の表示用データモデル
 */
public class StoreSalesViewModel {
    
    private String targetDate;           // 検索対象の日付 (yyyy-MM-dd)
    private int totalSales;              // その日の総売上金額
    private List<OrderHistoryDTO> salesList; // 会計済みの注文明細リスト

    // ゲッターとセッター
    public String getTargetDate() {
        return targetDate;
    }

    public void setTargetDate(String targetDate) {
        this.targetDate = targetDate;
    }

    public int getTotalSales() {
        return totalSales;
    }

    public void setTotalSales(int totalSales) {
        this.totalSales = totalSales;
    }

    public List<OrderHistoryDTO> getSalesList() {
        return salesList;
    }

    public void setSalesList(List<OrderHistoryDTO> salesList) {
        this.salesList = salesList;
    }
}