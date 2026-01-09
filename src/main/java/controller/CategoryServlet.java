package controller;

import java.io.IOException;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.service.TabletNumberService; // ★追加

/**
 * Servlet implementation class CategoryServlet
 */
@WebServlet("/category")
public class CategoryServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
        // 人数を取得
        String numberCustomer = request.getParameter("numberCustomer");
        
        HttpSession session = request.getSession();
        session.setAttribute("numberCustomer", numberCustomer);

        // ==========================================
        // ★追加修正: ここで2周目以降のお客様のために
        // テーブル状態を再度「利用中」に更新する
        // ==========================================
        Object tableNumberObj = session.getAttribute("tableNumber");
        if (tableNumberObj != null) {
            int tableNumber = (int) tableNumberObj;
            
            // サービスを呼んでDBを「利用中」に変更
            TabletNumberService service = new TabletNumberService();
            service.setNumber(tableNumber);
            
            // ログ確認用
            System.out.println("2周目以降対応: " + tableNumber + "卓を利用中に更新しました。");
        }
        // ==========================================

        RequestDispatcher dispatcher = request.getRequestDispatcher("WEB-INF/view/category.jsp");
        dispatcher.forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}