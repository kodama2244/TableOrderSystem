package model.service;

import java.util.List;

import database.OrderHistoryDAO;
import model.dto.OrderHistoryDTO;
import model.dto.OrderItemDTO;

public class OrderHistoryService {
	public void setOrderHistory(List<OrderItemDTO> orderItems, int people, int tableNumber, int totalPrice) {
		OrderHistoryDAO ohd = new OrderHistoryDAO();
		ohd.setOrderHistory(orderItems, people, tableNumber, totalPrice);
	}
	public List<OrderHistoryDTO> getOrderHistory(int tableNumber){
		OrderHistoryDAO dao = new OrderHistoryDAO();
		return dao.getOrderHistory(tableNumber);
	}
	
}
