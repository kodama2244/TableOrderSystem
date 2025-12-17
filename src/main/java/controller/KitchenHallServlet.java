package controller;

import java.io.IOException;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.dto.OrderHistoryDTO;
import model.service.KitchenHallService;
import viewmodel.KitchenHallViewModel;

/**
 * Servlet implementation class KitchenHallServlet
 */
public class KitchenHallServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//response.getWriter().append("Served at: ").append(request.getContextPath());
		KitchenHallService khs = new KitchenHallService();
		List<OrderHistoryDTO> orderHistoryList = khs.getOrderHistory();
		KitchenHallViewModel khvm = new KitchenHallViewModel();
		khvm.setOrderHistorys(orderHistoryList);
		request.setAttribute("khvm", khvm);
		request.getRequestDispatcher("/WEB-INF/view/kitchenHall.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//doGet(request, response);
		String status = request.getParameter("status");
		String orderHistoryId = request.getParameter("orderHistoryId");
		KitchenHallService khs = new KitchenHallService();
		khs.changeStatus(Integer.parseInt(orderHistoryId), Integer.parseInt(status));
		doGet(request, response);
	}

}
