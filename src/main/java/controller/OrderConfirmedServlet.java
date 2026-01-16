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
	    
	    request.setCharacterEncoding("UTF-8"); // 文字化け防止

	    String[] productId = request.getParameterValues("productId");
	    String[] optionId = request.getParameterValues("optionId"); // JSP側でnameを修正したので取れるようになります
	    String[] quantity = request.getParameterValues("quantity");
	    
	    List<OrderItemDTO> orderItems = new ArrayList<>();

	    if (productId != null && quantity != null) {
	        for (int i = 0; i < productId.length; i++) {
	            OrderItemDTO dto = new OrderItemDTO();
	            dto.setProductId(Integer.parseInt(productId[i]));
	            dto.setQuantity(Integer.parseInt(quantity[i]));
	            
	            // オプションIDの取得（nullチェックと配列サイズの確認）
	            if (optionId != null && optionId.length > i) {
	                dto.setOptionId(Integer.parseInt(optionId[i]));
	            } else {
	                dto.setOptionId(0); 
	            }
	            orderItems.add(dto);
	        }   
	    }

	    // セッションから情報の取得
	    HttpSession session = request.getSession();
	    int people = Integer.parseInt(session.getAttribute("numberCustomer").toString());
	    int tableNumber = Integer.parseInt(session.getAttribute("tableNumber").toString());
	    int totalAmount = Integer.parseInt(session.getAttribute("totalAmount").toString());

	    // DB保存処理
	    OrderHistoryService ohs = new OrderHistoryService();
	    ohs.setOrderHistory(orderItems, people, tableNumber, totalAmount);
	    
	    // カート情報の削除
	    session.removeAttribute("cvm");
	    session.removeAttribute("totalAmount");

	    RequestDispatcher dispatcher = request.getRequestDispatcher("WEB-INF/view/orderConfirmed.jsp");
	    dispatcher.forward(request, response);
	}

}
