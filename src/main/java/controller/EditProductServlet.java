package controller;

import java.io.File;
import java.io.IOException;
import java.util.List;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import model.dto.ProductDTO;
import model.service.MenuManagementService;
import model.service.MenuService;
import viewmodel.EditProductViewModel;

/**
 * Servlet implementation class EditProductServlet
 */
@MultipartConfig(fileSizeThreshold = 1024 * 1024, maxFileSize = 1024 * 1024 * 10, maxRequestSize = 1024 * 1024 * 50)
public class EditProductServlet extends HttpServlet {
	private static final String UPLOAD_DIR = "assets/img";
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		//response.getWriter().append("Served at: ").append(request.getContextPath());
		String productId = request.getParameter("id");
		MenuService ms = new MenuService();
		EditProductViewModel epvm = new EditProductViewModel();
		List<ProductDTO> plist = ms.getProduct(productId);

		if (plist != null && !plist.isEmpty()) {
			ProductDTO dto = plist.get(0);
			epvm.setProductId(dto.getProductId());
			epvm.setProductName(dto.getProductName());
			epvm.setCategory(dto.getCategory());
			epvm.setProductPrice(dto.getProductPrice());
			epvm.setProductImage(dto.getProductImage());
			epvm.setProductDescription(dto.getProductDescription());
			epvm.setProductAllergy(dto.getProductAllergy());
		} else {
			String msg = "指定された商品ID (" + productId + ") の商品が見つかりませんでした。";
			request.setAttribute("msg", msg);
		}
		request.setAttribute("product", epvm);
		RequestDispatcher dispatcher = request.getRequestDispatcher("WEB-INF/view/editProduct.jsp");
		dispatcher.forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String applicationPath = request.getServletContext().getRealPath("");
		String uploadPath = applicationPath + File.separator + UPLOAD_DIR;
		File uploadDir = new File(uploadPath);
		if (!uploadDir.exists()) {
			uploadDir.mkdir();
		}

		try {
			Part filePart = request.getPart("image");
			String fileName = getFileName(filePart);

			String id = request.getParameter("productId");
			String name = request.getParameter("productName");
			String price = request.getParameter("productPrice");
			String categoryId = request.getParameter("categoryId");
			String description = request.getParameter("productDescription");
			String allergy = request.getParameter("productAllergy");

			ProductDTO dto = new ProductDTO();
			dto.setProductId(Integer.parseInt(id));
			dto.setProductName(name);
			dto.setProductPrice(Integer.parseInt(price));
			dto.setCategory(Integer.parseInt(categoryId));
			dto.setProductDescription(description);
			dto.setProductAllergy(allergy);

			if (fileName != null && !fileName.isEmpty()) {
			    filePart.write(uploadPath + File.separator + fileName);
			    dto.setProductImage(fileName); // 新しい画像
			} else {
				MenuService ms = new MenuService();
				ProductDTO existing = ms.getProduct(id).get(0);
			    dto.setProductImage(existing.getProductImage()); // 既存画像を保持
			}

			MenuManagementService mms = new MenuManagementService();
			mms.updateProduct(dto);
			request.setAttribute("message", "商品ID: " + id + " を更新しました。");
			request.setAttribute("product", dto);
		    RequestDispatcher dispatcher = request.getRequestDispatcher("WEB-INF/view/editProduct.jsp");
		    dispatcher.forward(request, response);
			
		} catch (Exception e) {
			request.setAttribute("error", "更新失敗: " + e.getMessage());
			e.printStackTrace();
			RequestDispatcher dispatcher = request.getRequestDispatcher("WEB-INF/view/editProduct.jsp");
			dispatcher.forward(request, response);
			
		}

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
