package model.service;

import java.util.List;

import database.ProductOptionDAO;
import model.dto.ProductDTO;

public class MenuManagementService {
	public void setProduct(List<String> plist) {
		ProductOptionDAO poDAO = new ProductOptionDAO();
		poDAO.setProduct(plist);
	}
	public void DeleteProduct(String id) {
		ProductOptionDAO poDAO = new ProductOptionDAO();
		poDAO.DeleteProduct(id);
	}

	public void updateProduct(ProductDTO dto) {
		ProductOptionDAO DAO = new ProductOptionDAO();
		DAO.updateProduct(dto);
	}
}
