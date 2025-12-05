package model.service;

import java.util.List;

import database.ProductDAO;
import database.ProductOptionDAO;
import model.dto.ProductDTO;
import model.dto.ProductOptionDTO;

public class MenuService {
	public List<ProductOptionDTO> getProducts(String category) {
		ProductOptionDAO poDAO = new ProductOptionDAO();
		return poDAO.getProducts(category);
	}
	
	public List<ProductOptionDTO> getProductOption(String productId) {
		ProductOptionDAO poDAO = new ProductOptionDAO();
		return poDAO.getProduct(productId);
	}

	public List<ProductDTO> getProduct(String productId) {
		ProductDAO DAO = new ProductDAO();
		return DAO.getProduct(productId);
	}
}
