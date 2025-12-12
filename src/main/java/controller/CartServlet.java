package controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.dto.ProductOptionDTO;
import model.service.MenuService;
import viewmodel.CartViewModel;
import viewmodel.MenuViewModel;

/**
 * Servlet implementation class CartServlet
 */
public class CartServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//response.getWriter().append("Served at: ").append(request.getContextPath());
		
		//セッションスコープに保存されてる商品を表示
		String category = request.getParameter("category");
		request.setAttribute("category", category);
		RequestDispatcher dispatcher = request.getRequestDispatcher("WEB-INF/view/cart.jsp");
		dispatcher.forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//doGet(request, response);
		String category = request.getParameter("category");
		String id = request.getParameter("productId");
		String name = request.getParameter("productName");
		String price = request.getParameter("productPrice");
		String optionId = request.getParameter("optionId");
		String optionName = request.getParameter("optionName");
		String optionPrice = request.getParameter("optionPrice");
		String quantity = request.getParameter("quantity");
		
		CartViewModel cvm = new CartViewModel();
		cvm.setProductId(Integer.parseInt(id));
		cvm.setProductName(name);
		cvm.setProductPrice(Integer.parseInt(price));
		cvm.setOptionName(optionName);
		cvm.setOptionPrice(Integer.parseInt(optionPrice));
		cvm.setQuantity(Integer.parseInt(quantity));
		cvm.setOptionId(Integer.parseInt(optionId));
		
		HttpSession session = request.getSession();
		List<CartViewModel> cart = (List<CartViewModel>) session.getAttribute("cvm");
		if (cart == null) {
			cart = new ArrayList<>();
		}
		cart.add(cvm);
		session.setAttribute("cvm", cart);
		int totalAmount = 0;
		for (CartViewModel item : cart) {
		    int itemTotal = (item.getProductPrice() + item.getOptionPrice()) * item.getQuantity();
		    totalAmount += itemTotal;
		}
		session.setAttribute("totalAmount", totalAmount);
		MenuService ms = new MenuService();
		List<ProductOptionDTO> products = ms.getProducts(category);
		MenuViewModel mvm = new MenuViewModel();
		mvm.setProducts(products);
		request.setAttribute("mvm", mvm);
		RequestDispatcher dispatcher = request.getRequestDispatcher("WEB-INF/view/menu.jsp");
		dispatcher.forward(request, response);
	}

}
