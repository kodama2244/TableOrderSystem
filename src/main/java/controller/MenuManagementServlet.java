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

/**
 * Servlet implementation class MenuManagementServlet
 */
@MultipartConfig
public class MenuManagementServlet extends HttpServlet {
	private static final String UPLOAD_DIR = "assets/img";
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		//response.getWriter().append("Served at: ").append(request.getContextPath());
		String category = request.getParameter("category");
		//		String category = "1";
		if (category == null) {
			category = "1";
		}
		MenuService ms = new MenuService();
		List<ProductOptionDTO> products = ms.getProducts(category);
		MenuViewModel mvm = new MenuViewModel();
		mvm.setProducts(products);
		//DBからメニューとってくる
		request.setAttribute("mvm", mvm);
		RequestDispatcher dispatcher = request.getRequestDispatcher("WEB-INF/view/menuManagement.jsp");
		dispatcher.forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		//doGet(request, response);
		String action = request.getParameter("action");

		// 削除後の画面表示用に、現在のカテゴリIDを取得（JSPから渡されていると仮定）
		String category = request.getParameter("category");
		if (category == null || category.isEmpty()) {
			category = "1"; // デフォルトカテゴリ
		}

		if ("delete".equals(action)) {
			// ========== 削除処理 ==========
			String productIdToDelete = request.getParameter("id");
			if (productIdToDelete != null && !productIdToDelete.isEmpty()) {
				try {
					MenuManagementService mms = new MenuManagementService();
					mms.DeleteProduct(productIdToDelete);
					// ★ 削除メソッドの実行 (DAO/Service層で実装が必要です)
					// mms.deleteProduct(productIdToDelete);

					request.setAttribute("message", "商品ID: " + productIdToDelete + " を削除しました。");
				} catch (Exception e) {
					request.setAttribute("error", "削除失敗: " + e.getMessage());
					e.printStackTrace();
				}
			}

		} else {
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
					filePart.write(uploadPath + File.separator + fileName);
					String id = request.getParameter("productId");
					String name = request.getParameter("productName");
					String price = request.getParameter("productPrice");
					String categoryId = request.getParameter("categoryId");
					String description = request.getParameter("productDescription");
					String allergy = request.getParameter("productAllergy");
					String imageFileNameToSave = fileName;
					List<String> plist = new ArrayList<>();
					plist.add(id);
					plist.add(categoryId);
					plist.add(name);
					plist.add(price);
					plist.add(description);
					plist.add(imageFileNameToSave);
					plist.add(allergy);

					MenuManagementService mms = new MenuManagementService();
					mms.setProduct(plist);
					request.setAttribute("message", "アップロード成功: " + fileName);

				} else {
					request.setAttribute("error", "ファイルが選択されていません。");
				}
			} catch (Exception e) {
				request.setAttribute("error", "アップロード失敗: " + e.getMessage());
				e.printStackTrace();
			}
		}
		MenuService ms = new MenuService();
	    // 削除/追加処理で確定したカテゴリIDを使用
	    List<ProductOptionDTO> products = ms.getProducts(category); 
	    MenuViewModel mvm = new MenuViewModel();
	    mvm.setProducts(products);
	    
	    request.setAttribute("mvm", mvm);
	    // JSP側で現在のカテゴリを判別できるように渡す（JSP側でカテゴリを動的に渡すために推奨）
	    request.setAttribute("currentCategory", category); 
	    // ★★★ ★★★ ★★★ ★★★ ★★★ ★★★ ★★★

		RequestDispatcher dispatcher = request.getRequestDispatcher("WEB-INF/view/menuManagement.jsp");
		dispatcher.forward(request, response);
	}

	private List<String> getUploadedImages(String path) {
		List<String> images = new ArrayList<>();
		File folder = new File(path);
		if (folder.exists() && folder.isDirectory()) {
			for (File file : folder.listFiles()) {
				if (file.isFile()) {
					images.add(file.getName());
				}
			}
		}
		return images;
	}

	private String getFileName(Part part) {
	    String contentDisp = part.getHeader("content-disposition");
	    for (String token : contentDisp.split(";")) {
	        if (token.trim().startsWith("filename")) {
	            String fullPath = token.substring(token.indexOf('=') + 1).replace("\"", "").trim();
	            return new File(fullPath).getName(); // ファイル名だけ取り出す
	        }
	    }
	    return null;
	}
}
