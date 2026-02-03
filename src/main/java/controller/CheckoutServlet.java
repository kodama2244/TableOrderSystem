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

/**
 * お会計処理を担当するサーブレット
 */
public class CheckoutServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    /**
     * お会計確認画面の表示（DBから現在の注文合計を計算）
     */
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
        // 1. セッションから卓番号を取得
        HttpSession session = request.getSession();
        Integer tableNumber = (Integer) session.getAttribute("tableNumber");

        int totalAmount = 0;

        // --------------------------------------------------
        // 【確定済みの注文分のみ】DBから取得して加算
        // --------------------------------------------------
        if (tableNumber != null) {
            OrderService orderService = new OrderService();
            // DBに保存されている（＝注文確定ボタンを押した後の）リストを取得
            List<OrderDTO> dbOrders = orderService.getOrdersByTable(tableNumber);
            
            if (dbOrders != null) {
                for (OrderDTO order : dbOrders) {
                    // DBの単価 × 数量を累計
                    totalAmount += order.getPrice() * order.getStock();
                }
            }
        }

        // --------------------------------------------------
        // 2. 画面に渡す
        // --------------------------------------------------
        // カート（session内の"cvm"）は無視して、DBの合計のみをセット
        request.setAttribute("totalAmount", totalAmount);
        
        // ログ確認用
        System.out.println("確定済み注文の合計金額（卓番 " + tableNumber + "）: " + totalAmount);

        RequestDispatcher dispatcher = request.getRequestDispatcher("WEB-INF/view/checkout.jsp");
        dispatcher.forward(request, response);
    }

    /**
     * お会計完了処理（支払ボタン押下後）
     */
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        
        // --- お会計完了後の後処理 ---
        // 1. カートの中身を空にする
        session.removeAttribute("cvm");
        
        // 2. 必要であれば卓番号もクリアする（退店扱い）
        // session.removeAttribute("tableNumber");
        
        // 3. 完了画面へ遷移
        RequestDispatcher dispatcher = request.getRequestDispatcher("WEB-INF/view/thankyou.jsp");
        dispatcher.forward(request, response);
    }
}