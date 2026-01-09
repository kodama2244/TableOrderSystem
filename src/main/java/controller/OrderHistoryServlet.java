package controller;

import java.io.IOException;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession; // 追加
import model.dto.OrderHistoryDTO;
import model.service.OrderHistoryService;
import viewmodel.OrderHistoryViewModel;

/**
 * Servlet implementation class OrderHistoryServlet
 */
public class OrderHistoryServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
        // 1. セッションから卓番号を取得（安全な変換を追加）
        HttpSession session = request.getSession();
        Object tableObj = session.getAttribute("tableNumber");
        
        if (tableObj == null) {
            // セッション切れの場合は入店画面へリダイレクト等の対策
            response.sendRedirect("welcom");
            return;
        }
        
        int tableNumber = Integer.parseInt(tableObj.toString());
        
        // 2. 履歴リストを取得
        OrderHistoryService ohs = new OrderHistoryService();
        List<OrderHistoryDTO> history = ohs.getOrderHistory(tableNumber);
        
        // 3. ★追加：合計金額を計算する
        int totalAmount = 0;
        if (history != null) {
            for (OrderHistoryDTO dto : history) {
                // 単価 × 数量 を加算
                totalAmount += dto.getProductPrice() * dto.getProductQuantity();
            }
        }
        
        // 4. ViewModelにセット
        OrderHistoryViewModel ovm = new OrderHistoryViewModel();
        ovm.setOrderHistorys(history);
        
        // 5. データをリクエストスコープにセット
        request.setAttribute("ovm", ovm);
        request.setAttribute("totalAmount", totalAmount); // ★合計金額を渡す
        
        request.getRequestDispatcher("/WEB-INF/view/orderHistory.jsp").forward(request, response);
    }

}