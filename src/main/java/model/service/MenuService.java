package model.service;

import java.util.List;

import database.ProductOptionDAO;
import model.dto.ProductOptionDTO;

public class MenuService {
	public List<ProductOptionDTO> getProducts(String category) {
		ProductOptionDAO poDAO = new ProductOptionDAO();
		return poDAO.getProducts(category);
	}
	
	public List<ProductOptionDTO> getProduct(String productId) {
		ProductOptionDAO poDAO = new ProductOptionDAO();
		return poDAO.getProduct(productId);
	}
}
