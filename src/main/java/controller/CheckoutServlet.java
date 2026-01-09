package controller;

import java.io.IOException;
import java.util.List;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.dto.OrderDTO;
import model.service.OrderService;
import viewmodel.CartViewModel;

public class CheckoutServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
        // 1. セッションから卓番号とカートを取得
        HttpSession session = request.getSession();
        Integer tableNumber = (Integer) session.getAttribute("tableNumber");
        List<CartViewModel> cart = (List<CartViewModel>) session.getAttribute("cvm");

        int totalAmount = 0;

        // --------------------------------------------------
        // A. 【過去の注文分】DBから取得して加算
        // --------------------------------------------------
        if (tableNumber != null) {
            OrderService orderService = new OrderService();
            // 既に注文済みの商品リストを取得
            List<OrderDTO> dbOrders = orderService.getOrdersByTable(tableNumber);
            
            if (dbOrders != null) {
                for (OrderDTO order : dbOrders) {
                    // 単価 × 数量
                    totalAmount += order.getPrice() * order.getStock();
                }
            }
        }

        // --------------------------------------------------
        // B. 【今回の注文分】カート内から加算（まだDBに入っていない分）
        // --------------------------------------------------
        // ※「注文確認」ではなく「食後の会計」なら、カート分は足さなくても良い場合があります
        if (cart != null) {
            for (CartViewModel item : cart) {
                totalAmount += (item.getProductPrice() + item.getOptionPrice()) * item.getQuantity();
            }
        }

        // --------------------------------------------------
        // 3. 画面に渡す
        // --------------------------------------------------
        // JSP側で ${totalAmount} として表示できるようセット
        request.setAttribute("totalAmount", totalAmount);
        
        // ログで確認
        System.out.println("卓番: " + tableNumber + " の合計金額: " + totalAmount);

        RequestDispatcher dispatcher = request.getRequestDispatcher("WEB-INF/view/checkout.jsp");
        dispatcher.forward(request, response);
    }
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//doGet(request, response);
		
		
		
		RequestDispatcher dispatcher = request.getRequestDispatcher("WEB-INF/view/thankyou.jsp");
		dispatcher.forward(request, response);
	}

}
