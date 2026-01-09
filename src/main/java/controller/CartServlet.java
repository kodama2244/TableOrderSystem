package controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.dto.ProductOptionDTO;
import model.service.MenuService;
import viewmodel.CartViewModel;
import viewmodel.MenuViewModel;

/**
 * カート機能を制御するサーブレット
 */
public class CartServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * カート画面の表示処理
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// メニュー画面に戻る際などに必要なカテゴリ情報を保持
		String category = request.getParameter("category");
		request.setAttribute("category", category);
		
		// カート画面（cart.jsp）へフォワード
		RequestDispatcher dispatcher = request.getRequestDispatcher("WEB-INF/view/cart.jsp");
		dispatcher.forward(request, response);
	}

	/**
	 * カートへの追加、およびカートからの削除処理
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		HttpSession session = request.getSession();
		
		// アクションの判定（追加 or 削除）
		String action = request.getParameter("action");
		// セッションから現在のカートを取得（なければ新規作成）
		List<CartViewModel> cart = (List<CartViewModel>) session.getAttribute("cvm");
		if (cart == null) {
			cart = new ArrayList<>();
		}

		if ("delete".equals(action)) {
			// --- 【削除処理】 ---
			String indexStr = request.getParameter("index");
			if (indexStr != null) {
				int index = Integer.parseInt(indexStr);
				// インデックスが範囲内かチェックして削除
				if (index >= 0 && index < cart.size()) {
					cart.remove(index);
				}
			}
		} else {
			// --- 【追加処理】 ---
			String id = request.getParameter("productId");
			String name = request.getParameter("productName");
			String price = request.getParameter("productPrice");
			String optionId = request.getParameter("optionId");
			String optionName = request.getParameter("optionName");
			String optionPrice = request.getParameter("optionPrice");
			String quantity = request.getParameter("quantity");

			CartViewModel newItem = new CartViewModel();
			newItem.setProductId(Integer.parseInt(id));
			newItem.setProductName(name);
			newItem.setProductPrice(Integer.parseInt(price));
			newItem.setOptionId(Integer.parseInt(optionId));
			newItem.setOptionName(optionName);
			newItem.setOptionPrice(Integer.parseInt(optionPrice));
			newItem.setQuantity(Integer.parseInt(quantity));

			cart.add(newItem);
		}

		// --- 【共通処理：合計金額の計算】 ---
		int totalAmount = 0;
		for (CartViewModel item : cart) {
			totalAmount += (item.getProductPrice() + item.getOptionPrice()) * item.getQuantity();
		}

		// セッションを更新
		session.setAttribute("cvm", cart);
		session.setAttribute("totalAmount", totalAmount);

		// 処理後の遷移先決定
		if ("delete".equals(action)) {
			// 削除後はカート画面を再表示
			response.sendRedirect("CartServlet");
		} else {
			// 追加後はメニュー画面を再表示するための準備
			String category = request.getParameter("category");
			MenuService ms = new MenuService();
			List<ProductOptionDTO> products = ms.getProducts(category);
			
			MenuViewModel mvm = new MenuViewModel();
			mvm.setProducts(products);
			
			request.setAttribute("mvm", mvm);
			request.setAttribute("category", category);
			
			// メニュー画面へ戻る（または設計に合わせてカートへ飛ばす）
			RequestDispatcher dispatcher = request.getRequestDispatcher("WEB-INF/view/menu.jsp");
			dispatcher.forward(request, response);
		}
	}
}