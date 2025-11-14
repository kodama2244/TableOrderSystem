package controller;

import java.io.IOException;
import java.util.List;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.dto.ProductOptionDTO;
import model.service.MenuService;
import viewmodel.MenuViewModel;

/**
 * Servlet implementation class MenuServlet
 */
public class MenuServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//response.getWriter().append("Served at: ").append(request.getContextPath());
		
		String category = request.getParameter("category");
		MenuService ms = new MenuService();
		List<ProductOptionDTO> products = ms.getProduct(category);
		MenuViewModel mvm = new MenuViewModel();
		mvm.setProducts(products);
		//DBからメニューとってくる
		request.setAttribute("mvm", mvm);
		//メニューとカテゴリー情報をスコープに保存
		RequestDispatcher dispatcher = request.getRequestDispatcher("WEB-INF/view/menu.jsp");
		dispatcher.forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */ 
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//doGet(request, response);

		
		//カテゴリー情報をgetする
		//DBからメニューとってくる
		//メニューとカテゴリー情報をスコープに保存
		
		
		
		RequestDispatcher dispatcher = request.getRequestDispatcher("WEB-INF/view/menu.jsp");
		dispatcher.forward(request, response);
		
	}

}
