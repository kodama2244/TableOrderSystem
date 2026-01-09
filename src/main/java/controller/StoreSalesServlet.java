package controller;

import java.io.IOException;
import java.time.LocalDate;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.service.StoreSalesService;
import viewmodel.StoreSalesViewModel;

/**
 * 店舗売上管理サーブレット
 */

public class StoreSalesServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * 売上画面の表示（日付選択含む）
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		// 1. カレンダーから送られてくる日付を取得 (yyyy-MM-dd)
		String selectedDate = request.getParameter("targetDate");
		
		// 日付が選択されていない場合は「今日」の日付をデフォルトにする
		if (selectedDate == null || selectedDate.isEmpty()) {
			selectedDate = LocalDate.now().toString();
		}

		// 2. Serviceを介して指定された日の売上データを取得
		// ※StoreSalesServiceに getSalesByDate(String date) メソッドがある前提
		StoreSalesService service = new StoreSalesService();
		StoreSalesViewModel vm = service.getSalesByDate(selectedDate);
		
		// 3. ViewModelと選択された日付をリクエストスコープにセット
		request.setAttribute("vm", vm);
		request.setAttribute("selectedDate", selectedDate);

		// 4. JSPへフォワード
		RequestDispatcher dispatcher = request.getRequestDispatcher("WEB-INF/view/storeSales.jsp");
		dispatcher.forward(request, response);
	}

}