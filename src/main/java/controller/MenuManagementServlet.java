package controller;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import model.dto.ProductOptionDTO;
import model.service.MenuManagementService;
import model.service.MenuService;
import viewmodel.MenuViewModel;

@MultipartConfig
public class MenuManagementServlet extends HttpServlet {
	private static final String UPLOAD_DIR = "assets/img";
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String category = request.getParameter("category");
		if (category == null || category.isEmpty()) {
			category = "1";
		}

		MenuService ms = new MenuService();
		List<ProductOptionDTO> products = ms.getProducts(category);
		MenuViewModel mvm = new MenuViewModel();
		mvm.setProducts(products);

		request.setAttribute("mvm", mvm);
		request.setAttribute("currentCategory", category);

		RequestDispatcher dispatcher = request.getRequestDispatcher("WEB-INF/view/menuManagement.jsp");
		dispatcher.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		request.setCharacterEncoding("UTF-8");
		String action = request.getParameter("action");
		String category = request.getParameter("category"); // 画面戻り用のカテゴリ

		if (category == null || category.isEmpty()) {
			category = "1";
		}

		if ("delete".equals(action)) {
			// ========== 削除処理 ==========
			String productIdToDelete = request.getParameter("id");
			if (productIdToDelete != null && !productIdToDelete.isEmpty()) {
				try {
					MenuManagementService mms = new MenuManagementService();
					mms.DeleteProduct(productIdToDelete);
					request.setAttribute("message", "商品ID: " + productIdToDelete + " を削除しました。");
				} catch (Exception e) {
					request.setAttribute("error", "削除失敗: " + e.getMessage());
					e.printStackTrace();
				}
			}

		} else {
			// ========== 追加（アップロード）処理 ==========
			String applicationPath = request.getServletContext().getRealPath("");
			String uploadPath = applicationPath + File.separator + UPLOAD_DIR;
			File uploadDir = new File(uploadPath);
			if (!uploadDir.exists()) {
				uploadDir.mkdir();
			}

			try {
				Part filePart = request.getPart("image");
				String fileName = getFileName(filePart);

				if (fileName != null && !fileName.isEmpty()) {
					// 画像の保存
					filePart.write(uploadPath + File.separator + fileName);

					// パラメータ取得
					String id = request.getParameter("productId");
					String name = request.getParameter("productName");
					String price = request.getParameter("productPrice");
					String categoryId = request.getParameter("categoryId");
					String description = request.getParameter("productDescription");
					String allergy = request.getParameter("productAllergy");

					// --- オプションID判定ロジック ---
					// カテゴリーが 1(そば), 2(うどん), 3(丼もの) なら大盛り(1)、それ以外は(0)
					String optionId = "0";
					if (categoryId != null
							&& (categoryId.equals("1") || categoryId.equals("2") || categoryId.equals("3"))) {
						optionId = "1";
					}

					// DAOに渡すリスト作成
					List<String> plist = new ArrayList<>();
					plist.add(id); // index 0: product_id
					plist.add(categoryId); // index 1: category_id
					plist.add(name); // index 2: product_name
					plist.add(price); // index 3: product_price
					plist.add(description); // index 4: product_description
					plist.add(fileName); // index 5: product_image
					plist.add(allergy); // index 6: product_allergy
					plist.add(optionId); // index 7: option_id

					MenuManagementService mms = new MenuManagementService();
					mms.setProduct(plist);

					category = categoryId; // 追加した商品のカテゴリを表示するように更新
					request.setAttribute("message", "アップロード成功: " + fileName);

				} else {
					request.setAttribute("error", "ファイルが選択されていません。");
				}
			} catch (Exception e) {
				request.setAttribute("error", "アップロード失敗: " + e.getMessage());
				e.printStackTrace();
			}
		}

		// 最新のリストを取得して再表示
		MenuService ms = new MenuService();
		List<ProductOptionDTO> products = ms.getProducts(category);
		MenuViewModel mvm = new MenuViewModel();
		mvm.setProducts(products);

		request.setAttribute("mvm", mvm);
		request.setAttribute("currentCategory", category);

		RequestDispatcher dispatcher = request.getRequestDispatcher("WEB-INF/view/menuManagement.jsp");
		dispatcher.forward(request, response);
	}

	private String getFileName(Part part) {
		String contentDisp = part.getHeader("content-disposition");
		for (String token : contentDisp.split(";")) {
			if (token.trim().startsWith("filename")) {
				String fullPath = token.substring(token.indexOf('=') + 1).replace("\"", "").trim();
				return new File(fullPath).getName();
			}
		}
		return null;
	}
}