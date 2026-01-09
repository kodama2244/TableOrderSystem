package controller;

import java.io.IOException;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.service.TableBillService;
import viewmodel.TableBillViewModel;

public class TableBillServlet extends HttpServlet {

    private TableBillService service = new TableBillService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // 卓番号を取得
        String strTableNumber = request.getParameter("tableNumber");
        int tableNumber = Integer.parseInt(strTableNumber);

        // ViewModelを作成
        TableBillViewModel vm = service.createViewModel(tableNumber);
        
        // 確認用ログ
        System.out.println("卓番: " + vm.getTableNumber());
        System.out.println("合計: " + vm.getTotalPrice());

        request.setAttribute("viewModel", vm);

        RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/view/tableBill.jsp");
        dispatcher.forward(request, response);
    }
}