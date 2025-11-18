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
import viewmodel.SingleItemViewModel;

/**
 * Servlet implementation class SingleItemServlet
 */
public class SingleItemServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//response.getWriter().append("Served at: ").append(request.getContextPath());
		String productId = request.getParameter("id");
		MenuService ms = new MenuService();
		List<ProductOptionDTO> products = ms.getProduct(productId);
		SingleItemViewModel sivm = new SingleItemViewModel();
		sivm.setProducts(products);
		request.setAttribute("sivm", sivm);
		RequestDispatcher dispatcher = request.getRequestDispatcher("WEB-INF/view/menu.jsp");
		dispatcher.forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//doGet(request, response);

	}

}
