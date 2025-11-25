package controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.dto.ProductOptionDTO;
import model.service.MenuManagementService;
import model.service.MenuService;
import viewmodel.MenuViewModel;

/**
 * Servlet implementation class MenuManagementServlet
 */
public class MenuManagementServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		//response.getWriter().append("Served at: ").append(request.getContextPath());
		String category = request.getParameter("category");
//		String category = "1";
		MenuService ms = new MenuService();
		List<ProductOptionDTO> products = ms.getProducts(category);
		MenuViewModel mvm = new MenuViewModel();
		mvm.setProducts(products);
		//DBからメニューとってくる
		request.setAttribute("mvm", mvm);
		
		RequestDispatcher dispatcher = request.getRequestDispatcher("WEB-INF/view/menuManagement.jsp");
		dispatcher.forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		//doGet(request, response);
		String id = request.getParameter("productId");
		String name = request.getParameter("productName");
		String price = request.getParameter("productPrice");
		String image = request.getParameter("productImage");
		String categoryId = request.getParameter("categoryId");
		String description = request.getParameter("productDescription");
		String allergy = request.getParameter("productAllergy");
		
		List<String> plist = new ArrayList<>();
		plist.add(id);
		plist.add(categoryId);
		plist.add(name);
		plist.add(price);
		plist.add(description);	
		plist.add(image);
		plist.add(allergy);
		
		MenuManagementService mms = new MenuManagementService();
		mms.setProduct(plist);

		//追加削除
	}

}
