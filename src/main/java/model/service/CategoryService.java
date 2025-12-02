package model.service;

import java.util.List;

import database.categoryDAO;
import model.dto.categoryDTO;

public class CategoryService {
	public List<categoryDTO> getCategory(){
		categoryDAO category = new categoryDAO();
		return category.getCategory();
	}
}
