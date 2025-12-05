<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>メニュー単品表示</title>
</head>
<body>
	<img src="assets/img/${sivm.productImage}" alt="商品画像">
	<p>${sivm.productName}</p>
	<p>${sivm.productPrice}円</p>
	<p>${sivm.productDescription}</p>
	<p>アレルギー情報: ${sivm.productAllergy}</p>

	<h3>オプション</h3>
	<table border="1">
		<tr>
			<th>オプション名</th>
			<th>価格</th>
		</tr>
		<tr>
			<td>${sivm.optionName}</td>
			<td>${sivm.optionPrice }</td>
		</tr>
	</table>
	<form action="CartServlet" method="post">
		<h3>数量</h3>
		<select name="quantity">
			<option value="1">1</option>
			<option value="2">2</option>
			<option value="3">3</option>
			<option value="4">4</option>
			<option value="5">5</option>
		</select><br> <input type="hidden" name="productId"value="${sivm.productId}">
		 <input type="hidden"name="productName" value="${sivm.productName}"> 
		 <input type="hidden" name="productPrice" value="${sivm.productPrice}">
		<input type="hidden" name="optionName" value="${sivm.optionName}">
		<input type="hidden" name="optionPrice" value="${sivm.optionPrice}">
		<input type="hidden" name="category" value="${category}">
		<input type="submit" value="カートに追加">
	</form>
	<c:if test="${not empty msg}">
		<p>${msg}</p>
	</c:if>
</body>
</html>