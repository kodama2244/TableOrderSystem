package model.service;

import java.util.List;

import database.OrderHistoryDAO;

public class OrderHistoryService {
	public void setOrderHistory(List<String> productIds) {
		OrderHistoryDAO ohd = new OrderHistoryDAO();
		ohd.setOrderHistory(productIds);
	}
}
