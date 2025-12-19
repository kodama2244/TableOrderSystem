package viewmodel;

import java.util.List;

import model.dto.OrderDTO;

public class TableBillViewModel {
    private int tableNumber;
    private int totalPrice;
    private List<OrderDTO> orderList;

    public int getTableNumber() {
    	return tableNumber;
    }
    
    public void setTableNumber(int tableNumber) {
    	this.tableNumber = tableNumber;
    }

    public int getTotalPrice() {
    	return totalPrice;
    }
    
    public void setTotalPrice(int totalPrice) {
    	this.totalPrice = totalPrice;
    }

    public List<OrderDTO> getOrderList() {
    	return orderList;
    }
    
    public void setOrderList(List<OrderDTO> orderList) {
    	this.orderList = orderList;
    }
}
