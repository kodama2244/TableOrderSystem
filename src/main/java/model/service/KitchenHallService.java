package model.service;

import java.util.List;

import database.OrderHistoryDAO;
import model.dto.OrderHistoryDTO;

public class KitchenHallService {
	public List<OrderHistoryDTO> getOrderHistory(){
		OrderHistoryDAO oDAO = new OrderHistoryDAO();
		return oDAO.getOrderHistory();
	}
	public void changeStatus(int orderHistoryId, int status) {
		OrderHistoryDAO oDAO = new OrderHistoryDAO();
		oDAO.changeStatus(orderHistoryId, status);
	}
}
