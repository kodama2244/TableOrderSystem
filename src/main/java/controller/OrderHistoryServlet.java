package controller;

import java.io.IOException;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.dto.OrderHistoryDTO;
import model.service.OrderHistoryService;
import viewmodel.OrderHistoryViewModel;

/**
 * Servlet implementation class OrderHistoryServlet
 */
public class OrderHistoryServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//response.getWriter().append("Served at: ").append(request.getContextPath());
		Object tableObj = request.getSession().getAttribute("tableNumber");
		int tableNumber = Integer.parseInt(tableObj.toString());
		
		OrderHistoryService ohs = new OrderHistoryService();
		List<OrderHistoryDTO> history = ohs.getOrderHistory(tableNumber);
		OrderHistoryViewModel ovm = new OrderHistoryViewModel();
		ovm.setOrderHistorys(history);
		request.setAttribute("ovm", ovm);
		request.getRequestDispatcher("/WEB-INF/views/orderHistory.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//doGet(request, response);
	}

}
