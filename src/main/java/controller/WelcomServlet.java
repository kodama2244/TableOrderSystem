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

@WebServlet("/welcom")
public class WelcomServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
        String tableNumberStr = request.getParameter("tableNumber");
        
        if (tableNumberStr != null && !tableNumberStr.isEmpty()) {
            int tableNumber = Integer.parseInt(tableNumberStr);
            
            // 1. セッションに保存
            HttpSession session = request.getSession();
            session.setAttribute("tableNumber", tableNumber);
            
            // 2. ★追加：テーブル状態を「利用中」に更新する
            TabletNumberService service = new TabletNumberService();
            service.updateTableStatus(tableNumber); 
        }

        RequestDispatcher dispatcher = request.getRequestDispatcher("WEB-INF/view/welcom.jsp");
        dispatcher.forward(request, response);
    }
}