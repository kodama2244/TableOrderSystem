<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>メニュー編集画面</title>
</head>
<body>
	<h1>メニュー編集</h1>

	<c:if test="${not empty message}">
		<p style="color: green">${message}</p>
	</c:if>

	<c:if test="${not empty error}">
		<p style="color: red">${error}</p>
	</c:if>
	<form action="EditProductServlet" method="post"
		enctype="multipart/form-data">


		<label>商品ID</label><br> <input type="text" name="productId"
			value="${product.productId}"><br> <label>商品名</label><br>
		<input type="text" name="productName" value="${product.productName}"><br>


		<label>商品価格</label><br> <input type="text" name="productPrice"
			value="${product.productPrice}"><br> <label>商品画像（変更する場合のみ選択）</label><br>
		<c:if test="${not empty product.productImage}">
			<img src='assets/img/${product.productImage}' alt="商品画像" width="150">
		</c:if>
		<br> <input type="file" name="image" accept="image/*"><br>
		<label>商品カテゴリー</label><br> <select name="categoryId"
			id="category-select">
			<option value="">カテゴリーを選択してください</option>
			<option value="1" ${product.category == 1 ? "selected" : ""}>そば</option>
			<option value="2" ${product.category == 2 ? "selected" : ""}>うどん</option>
			<option value="3" ${product.category == 3 ? "selected" : ""}>丼もの</option>
			<option value="4" ${product.category == 4 ? "selected" : ""}>おすすめ</option>
			<option value="5" ${product.category == 5 ? "selected" : ""}>サイドメニュー</option>
			<option value="6" ${product.category == 6 ? "selected" : ""}>飲み物</option>
		</select><br> <label>商品説明</label><br>
		<textarea name="productDescription" rows="10" cols="20">${product.productDescription}</textarea>
		<br> <label>商品アレルギー説明</label><br>
		<textarea name="productAllergy" rows="10" cols="20">${product.productAllergy}</textarea>
		<br> <input type="submit" value="更新"><a
			href="MenuManagementServlet">戻る</a>
	</form>

</body>
</html>