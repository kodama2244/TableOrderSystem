package model.service;

import database.AdminDAO;

public class AdminService {
	public boolean Logincheck(String loginId, String password) {
		AdminDAO dao = new AdminDAO();
		return dao.Logincheck(loginId, password);
	}
	public boolean registerAdmin(String loginId, String password) {
		AdminDAO dao = new AdminDAO();
        return dao.registerAdmin(loginId, password);
    }
}
