package controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.dto.OrderItemDTO;
import model.service.OrderHistoryService;

/**
 * Servlet implementation class OrderConfirmedServlet
 */
public class OrderConfirmedServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		//response.getWriter().append("Served at: ").append(request.getContextPath());

		//		RequestDispatcher dispatcher = request.getRequestDispatcher("WEB-INF/view/orderConfirmed.jsp");
		//		dispatcher.forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		//doGet(request, response);
		//注文確定されたセッションスコープに保存されてる商品を注文履歴に保存する
		String[] productId = request.getParameterValues("productId");
		String[] optionId = request.getParameterValues("optionId");
		String[] quantity = request.getParameterValues("quantity");
		List<OrderItemDTO> orderItems = new ArrayList<>();

		if (productId != null && quantity != null) {
			for (int i = 0; i < productId.length; i++) {

				OrderItemDTO dto = new OrderItemDTO();
				dto.setProductId(Integer.parseInt(productId[i]));
				dto.setQuantity(Integer.parseInt(quantity[i]));
			    if (optionId != null && optionId.length > i) {
			        dto.setOptionId(Integer.parseInt(optionId[i]));
			    } else {
			        dto.setOptionId(0); // オプションなし
			    }
				orderItems.add(dto);
			}	
		}
		Object peopleObj = request.getSession().getAttribute("numberCustomer");
		int people = Integer.parseInt(peopleObj.toString());

		Object tableObj = request.getSession().getAttribute("tableNumber");
		int tableNumber = Integer.parseInt(tableObj.toString());
		
		Object totalObj = request.getSession().getAttribute("totalAmount");
		int totalAmount = Integer.parseInt(totalObj.toString());
		

		// DB保存処理
		OrderHistoryService ohs = new OrderHistoryService();
		ohs.setOrderHistory(orderItems, people, tableNumber,totalAmount);
		request.getSession().removeAttribute("cvm");
		request.getSession().removeAttribute("totalAmount");
		//cartのセッションスコープを消す

		RequestDispatcher dispatcher = request.getRequestDispatcher("WEB-INF/view/orderConfirmed.jsp");
		dispatcher.forward(request, response);
	}

}
