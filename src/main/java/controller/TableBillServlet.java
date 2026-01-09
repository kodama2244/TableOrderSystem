package controller;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.service.TableBillService;
import viewmodel.TableBillViewModel;

public class TableBillServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // ブラウザバック対策（キャッシュ無効化）
        response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
        response.setHeader("Pragma", "no-cache");
        response.setDateHeader("Expires", 0);

        String tableNumberStr = request.getParameter("tableNumber");
        int tableNumber;

        try {
            // パラメータチェック
            if (tableNumberStr == null || tableNumberStr.isEmpty()) {
                throw new IllegalArgumentException("テーブル番号が指定されていません。");
            }
            tableNumber = Integer.parseInt(tableNumberStr);
        } catch (Exception e) {
            // 数値以外や空の場合は一覧へ戻す
            response.sendRedirect(request.getContextPath() + "/TableListServlet");
            return;
        }

        // Service呼び出し
        TableBillService service = new TableBillService();
        TableBillViewModel vm = service.createViewModel(tableNumber);

        // 会計対象（注文）がない場合は一覧へ戻す
        if (vm.getOrderList() == null || vm.getOrderList().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/TableListServlet");
            return;
        }

        // JSPへ渡す
        request.setAttribute("vm", vm);
        request.getRequestDispatcher("/WEB-INF/view/tableBill.jsp")
               .forward(request, response);
    }
}