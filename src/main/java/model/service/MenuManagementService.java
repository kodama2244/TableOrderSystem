package model.service;

import java.util.List;

import database.ProductOptionDAO;

public class MenuManagementService {
	public void setProduct(List<String> plist) {
		ProductOptionDAO poDAO = new ProductOptionDAO();
		poDAO.setProduct(plist);
	}
}
