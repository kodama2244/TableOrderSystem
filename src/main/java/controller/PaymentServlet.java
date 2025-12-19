package controller;

import java.io.IOException;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.service.PaymentService;

public class PaymentServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // パラメータ取得
        String tableNumberStr = request.getParameter("tableNumber");
        String payAmountStr 	= request.getParameter("payAmount");
        String totalAmountStr = request.getParameter("totalAmount");

        // null/空チェックしつつ変換
        int tableNumber = (tableNumberStr == null || tableNumberStr.isEmpty())
                ? 0 : Integer.parseInt(tableNumberStr);
        int payAmount = (payAmountStr == null || payAmountStr.isEmpty())
                ? 0 : Integer.parseInt(payAmountStr);
        int totalAmount = (totalAmountStr == null || totalAmountStr.isEmpty())
                ? 0 : Integer.parseInt(totalAmountStr);
        int change = payAmount - totalAmount;
        
        // 確認用
        System.out.println("tableNumber = " + tableNumber);
        System.out.println("payAmount   = " + payAmount);
        System.out.println("totalAmount = " + totalAmount);
        System.out.println("change      = " + change );
        System.out.println(tableNumber + "卓_会計完了");
        System.out.println("==============================");

        // 決済処理
        PaymentService service = new PaymentService();
        service.payBill(tableNumber, payAmount, totalAmount);

        request.setAttribute("tableNumber", tableNumber);
        request.setAttribute("payAmount", payAmount);
        request.setAttribute("totalAmount", totalAmount);
        request.setAttribute("change", payAmount - totalAmount);

        RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/view/paymentDone.jsp");
        dispatcher.forward(request, response);
    }
}
