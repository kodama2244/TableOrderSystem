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
import viewmodel.CartViewModel;

public class CartServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        
        String category = request.getParameter("category");
        
        if (category == null || category.isEmpty()) {
            // セッションから復元。キー名を "category" に統一
            category = (String) session.getAttribute("category");
        } else {
            // セッションに保存。キー名を "category" に統一
            session.setAttribute("category", category);
        }

        request.setAttribute("category", category);

        RequestDispatcher dispatcher = request.getRequestDispatcher("WEB-INF/view/cart.jsp");
        dispatcher.forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession();

        String action = request.getParameter("action");
        // 削除時などに送られてくるカテゴリIDを取得
        String category = request.getParameter("category");
        
        // パラメータがなければセッションから取得
        if (category == null || category.isEmpty()) {
            category = (String) session.getAttribute("savedCategory");
        }

        List<CartViewModel> cart = (List<CartViewModel>) session.getAttribute("cvm");
        if (cart == null) { cart = new ArrayList<>(); }

        if ("delete".equals(action)) {
            String indexStr = request.getParameter("index");
            if (indexStr != null) {
                int index = Integer.parseInt(indexStr);
                if (index >= 0 && index < cart.size()) {
                    cart.remove(index);
                }
            }
            
            if (category == null || category.isEmpty()) {
                category = (String) session.getAttribute("category");
            }
            // 削除後は「カテゴリID付き」で自分自身にリダイレクト
            response.sendRedirect("CartServlet?category=" + category);
        } else {
            // --- 【追加処理：ここを復活させました】 ---
            String id = request.getParameter("productId");
            String name = request.getParameter("productName");
            String price = request.getParameter("productPrice");
            String optionId = request.getParameter("optionId");
            String optionName = request.getParameter("optionName");
            String optionPrice = request.getParameter("optionPrice");
            String quantity = request.getParameter("quantity");

            // 必須項目があるかチェック（null回避）
            if (id != null && name != null) {
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

            // 合計金額の計算
            int totalAmount = 0;
            for (CartViewModel item : cart) {
                totalAmount += (item.getProductPrice() + item.getOptionPrice()) * item.getQuantity();
            }

            // セッション情報を更新
            session.setAttribute("cvm", cart);
            session.setAttribute("totalAmount", totalAmount);

            // 【重要】追加後はメニュー画面へリダイレクト（categoryを忘れずに付ける）
            response.sendRedirect("MenuServlet?category=" + category);
        }
    }
}