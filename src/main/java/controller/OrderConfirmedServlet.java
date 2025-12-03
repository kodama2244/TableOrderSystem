package controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.service.OrderHistoryService;

/**
 * Servlet implementation class OrderConfirmedServlet
 */
public class OrderConfirmedServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//response.getWriter().append("Served at: ").append(request.getContextPath());
		
		
//		RequestDispatcher dispatcher = request.getRequestDispatcher("WEB-INF/view/orderConfirmed.jsp");
//		dispatcher.forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//doGet(request, response);
		//注文確定されたセッションスコープに保存されてる商品を注文履歴に保存する
		String[] productId = request.getParameterValues("productId");
		String[] quantity = request.getParameterValues("quantity");
		List<String> orderList = new ArrayList<>();
		if (productId != null && quantity != null) {
		    for (int i = 0; i < productId.length; i++) {
		        orderList.add(productId[i]);
		        orderList.add(quantity[i]);
		    }
		}

		//DBに保存する処理
		OrderHistoryService ohs = new OrderHistoryService();
		ohs.setOrderHistory(orderList);
		request.getSession().removeAttribute("cvm");
		request.getSession().removeAttribute("totalAmount");
		//cartのセッションスコープを消す
		
		RequestDispatcher dispatcher = request.getRequestDispatcher("WEB-INF/view/orderConfirmed.jsp");
		dispatcher.forward(request, response);
	}

}
