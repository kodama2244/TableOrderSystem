package controller;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.service.AdminService;

/**
 * Servlet implementation class AdminLoginServlet
 */

public class AdminLoginServlet extends HttpServlet {

	// ログイン画面を表示する
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.getRequestDispatcher("/WEB-INF/view/adminlogin.jsp").forward(request, response);
	}

	// ログイン処理を実行する
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String loginId = request.getParameter("loginId");
		String password = request.getParameter("password");

		AdminService as = new AdminService();

		if (as.Logincheck(loginId, password)) {
			// セッション開始
			HttpSession session = request.getSession();
			session.setAttribute("adminLogin", true); // ログイン状態を保持

			// 管理者メニュー画面へ
			response.sendRedirect("AdminMenuServlet");
		} else {
			// 失敗時はエラーメッセージを持ってログイン画面に戻る
			request.setAttribute("error", "ログインIDまたはパスワードが違います。");
			request.getRequestDispatcher("/WEB-INF/view/adminlogin.jsp").forward(request, response);
		}
	}
}
