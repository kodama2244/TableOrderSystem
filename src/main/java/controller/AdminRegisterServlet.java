package controller;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.service.AdminService;

public class AdminRegisterServlet extends HttpServlet {
			 
    // GET: 登録画面を表示する
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // セッションチェック（未ログインなら登録画面を見せない）
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("adminLogin") == null) {
            response.sendRedirect("AdminLoginServlet");
            return;
        }
        
        request.getRequestDispatcher("/WEB-INF/view/adminregister.jsp").forward(request, response);
    }

    // POST: 実際の登録処理を行う
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        try {
            String loginId = request.getParameter("loginId");
            String password = request.getParameter("password");

            AdminService as = new AdminService();
            if (as.registerAdmin(loginId, password)) {
                // 登録成功：管理メニューへ戻る（成功メッセージを添えて）
                response.sendRedirect("AdminMenuServlet?reg=success");
            } else {
                // 失敗：エラーメッセージを表示して登録画面へ戻る
                request.setAttribute("adminError", "そのログインIDは既に使用されています。");
                request.getRequestDispatcher("/WEB-INF/view/adminRegister.jsp").forward(request, response);
            }
        } catch (NumberFormatException e) {
            request.setAttribute("adminError", "管理者IDには数値を入力してください。");
            request.getRequestDispatcher("/WEB-INF/view/adminRegister.jsp").forward(request, response);
        }
    }
}