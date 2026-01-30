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
	    
	    String category = request.getParameter("category");

	    // null または 空文字 の場合にデフォルト値 "1" をセット
	    if (category == null || category.isEmpty()) {
	        category = "1";
	    }

	    MenuService ms = new MenuService();
	    List<ProductOptionDTO> products = ms.getProducts(category);
	    
	    MenuViewModel mvm = new MenuViewModel();
	    mvm.setProducts(products);
	    
	    request.setAttribute("mvm", mvm);
	    request.setAttribute("category", category);

	    RequestDispatcher dispatcher = request.getRequestDispatcher("WEB-INF/view/menu.jsp");
	    dispatcher.forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */ 
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//doGet(request, response);
		
		//カートに入れるを押された商品をセッションに保存して、全体メニュー画面に遷移
		
		RequestDispatcher dispatcher = request.getRequestDispatcher("WEB-INF/view/menu.jsp");
		dispatcher.forward(request, response);
		
	}

}
