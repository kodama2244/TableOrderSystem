<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html>
<head>
<style>
img {
	width: 60%;
	height: auto;
}

table {
	width: 60%;
	border-collapse: collapse;
	margin: 10px 0;
	font-size: 14px;
}

th, td {
	padding: 4px 8px;
	text-align: center;
	word-wrap: break-word;
}

th {
	background-color: #f2f2f2;
}

td img {
	max-width: 100px;
	height: auto;
}
</style>
<meta charset="UTF-8">
<title>商品追加削除画面</title>
</head>
<body>
	<h1>メニュー追加・オプション設定</h1>
	<c:if test="${not empty message}">
		<p>${message}</p>
	</c:if>
	<c:if test="${not empty error}">
		<p>${error}</p>
	</c:if>
	<form action="MenuManagementServlet" method="post"
		enctype="multipart/form-data">

		<label>商品ID</label><br> <input type="text" name="productId"
			placeholder="商品ID"><br> <label>商品名</label><br> <input
			type="text" name="productName" placeholder="商品名"><br> <label>商品価格</label><br>
		<input type="text" name="productPrice" placeholder="商品価格"><br>

		<label>商品画像</label><br> <input type="file" name="image"
			accept="image/*" required><br> <label>商品カテゴリー</label><br>
		<select name="categoryId" id="category-select">
			<option value="">カテゴリーを選択してください</option>
			<option value="1">そば</option>
			<option value="2">うどん</option>
			<option value="3">丼もの</option>
			<option value="4">おすすめ</option>
			<option value="5">サイドメニュー</option>
			<option value="6">飲み物</option>
		</select><br> <label>商品説明</label><br>
		<textarea name="productDescription" rows="10" cols="20"></textarea>
		<br> <label>商品アレルギー説明</label><br>
		<textarea name="productAllergy" rows="10" cols="20"></textarea>
		<br> <input type="submit" value="追加">

	</form>
	<h1>メニュー削除</h1>
	<c:if test="${not empty message}">
		<p>${message}</p>
	</c:if>
	<c:if test="${not empty error}">
		<p>${error}</p>
	</c:if>
	<form action="MenuManagementServlet" method="get">
		<table border="1">
			<tr>
				<td><button type="submit" name="category" value="1">そば</button></td>
				<td><button type="submit" name="category" value="2">うどん</button></td>
				<td><button type="submit" name="category" value="3">丼もの</button></td>
				<td><button type="submit" name="category" value="4">おすすめ</button></td>
				<td><button type="submit" name="category" value="5">サイドメニュー</button></td>
				<td><button type="submit" name="category" value="6">飲み物</button></td>
			</tr>
		</table>
	</form>
	<table border="1">
		<c:forEach var="list" items="${mvm.products}">
			<tr>
				<td>${list.productId}</td>
				<td><img alt="イメージ画像" src='assets/img/${list.productImage}'
					width="100" height="100"></td>
				<td>${list.productName}</td>
				<td>${list.productPrice}円</td>
				<td>
					<form action="MenuManagementServlet" method="post">
						<button type="submit" name="id" value="${list.productId}">削除</button>

						<input type="hidden" name="action" value="delete"> <input
							type="hidden" name="category" value="1">
					</form>
				</td>
			</tr>
		</c:forEach>
	</table>
</body>
</html>