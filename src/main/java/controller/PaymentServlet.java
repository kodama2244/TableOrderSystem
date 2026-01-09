package controller;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.service.PaymentService;

public class PaymentServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            // 1. パラメータ取得
            String tableNumberStr = request.getParameter("tableNumber");
            String payAmountStr   = request.getParameter("payAmount");
            String totalAmountStr = request.getParameter("totalAmount");

            // 数値変換とバリデーション
            if (tableNumberStr == null || payAmountStr == null || totalAmountStr == null) {
                throw new IllegalArgumentException("必要なパラメータが不足しています。");
            }

            int tableNumber = Integer.parseInt(tableNumberStr);
            int payAmount   = Integer.parseInt(payAmountStr);
            int totalAmount = Integer.parseInt(totalAmountStr);

            // 2. 決済処理の実行（Service呼び出し）
            PaymentService service = new PaymentService();
            service.payBill(tableNumber, payAmount, totalAmount);

            // 3. お釣りの計算
            int change = payAmount - totalAmount;

            // 4. 決済完了画面へフォワード（お釣りを渡す）
            request.setAttribute("change", change);
            request.getRequestDispatcher("/WEB-INF/view/paymentDone.jsp")
                   .forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            // エラー時は安全に一覧へ戻す
            response.sendRedirect(request.getContextPath() + "/TableListServlet");
        }
    }
}