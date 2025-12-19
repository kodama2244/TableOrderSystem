package controller;

import java.io.IOException;
import java.util.List;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.dto.OrderDTO;
import model.dto.TableInfoDTO;
import model.service.OrderService;
import viewmodel.TableBillViewModel;


public class TableBillServlet extends HttpServlet {

    private OrderService service = new OrderService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 卓番号を取得
        int tableNumber = Integer.parseInt(request.getParameter("tableNumber"));

        // 注文一覧取得
        List<OrderDTO> orders = service.getOrdersByTable(tableNumber);

        // 合計金額などをまとめた情報を取得
        TableInfoDTO info = service.getTableInfo(tableNumber, orders);

        // ViewModel に詰める
        TableBillViewModel vm = new TableBillViewModel();
        vm.setTableNumber(info.getTableNumber());
        vm.setTotalPrice(info.getTotalPrice());
        vm.setOrderList(orders);
        
        //確認用
        System.out.println("tableNumber = " + tableNumber);
        System.out.println("orders      = " + orders);
        System.out.println("info        = " + info);
        System.out.println("viewModel   = " + vm);     
        System.out.println("==============================");

        request.setAttribute("viewModel", vm);

        RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/view/tableBill.jsp");
        dispatcher.forward(request, response);
    }
}
