package controller;

import java.io.IOException;
import java.util.List;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.dto.ProductOptionDTO;
import model.service.MenuService;
import viewmodel.SingleItemViewModel;

/**
 * Servlet implementation class SingleItemServlet
 */
public class SingleItemServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	// controller.SingleItemServlet.java

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
	        throws ServletException, IOException {
	    
	    String productId = request.getParameter("id");
	    System.out.print(productId);
	    MenuService ms = new MenuService();
	    List<ProductOptionDTO> products = ms.getProduct(productId); // 単品1件取得

	    // ★★★ ここから修正/追加 ★★★
	    if (products != null && !products.isEmpty()) { 
	        // 31行目で発生していたエラーを回避するためのチェック
	        
	        ProductOptionDTO dto = products.get(0);
	        SingleItemViewModel vm = new SingleItemViewModel();
	        
	        // DTOからVMへのマッピング処理
	        vm.setProductId(dto.getProductId());
	        vm.setProductName(dto.getProductName());
	        vm.setProductPrice(dto.getProductPrice());
	        vm.setProductImage(dto.getProductImage());
	        vm.setProductDescription(dto.getProductDescription());
	        vm.setProductAllergy(dto.getProductAllergy());
	        vm.setOptionId(dto.getOptionId());
	        vm.setOptionName(dto.getOptionName());
	        vm.setOptionPrice(dto.getOptionPrice());

	        request.setAttribute("sivm", vm);
	        RequestDispatcher dispatcher = request.getRequestDispatcher("WEB-INF/view/singleItem.jsp");
	        dispatcher.forward(request, response);
	        
	    } else {
	        // ★★★ 商品が見つからなかった場合の適切なエラー処理 ★★★
	        request.setAttribute("msg", "指定された商品ID (" + productId + ") の商品が見つかりませんでした。");
	        // エラーページにフォワードする (例: error.jsp)
	        RequestDispatcher dispatcher = request.getRequestDispatcher("WEB-INF/view/singleItem.jsp"); 
	        dispatcher.forward(request, response);
	    }
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		//doGet(request, response);

	}

}
