package model.service;

import java.util.List;

import database.OrderHistoryDAO;
import model.dto.OrderHistoryDTO;

public class OrderHistoryService {
	public void setOrderHistory(List<String> productIds) {
		OrderHistoryDAO ohd = new OrderHistoryDAO();
		ohd.setOrderHistory(productIds);
	}
	public List<OrderHistoryDTO> getOrderHistory(){
		OrderHistoryDAO dao = new OrderHistoryDAO();
		return dao.getOrderHistory();
	}
	
}
