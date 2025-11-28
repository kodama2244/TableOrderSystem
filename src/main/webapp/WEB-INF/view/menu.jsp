<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html>
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
<head>
<meta charset="UTF-8">
<title>メニュー一覧</title>
</head>
<body>
	<form action="MenuServlet" method="get">
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
	<form action="SingleItemServlet" method="get">
		<table border="1">
			<c:forEach var="list" items="${mvm.products}">
				<tr>
					<td>${list.productId}</td>
					<td>
						<button type="submit" name="id" value="${list.productId}">
							<img alt="イメージ画像" src='assets/img/${list.productImage}'
								width="100" height="100">
						</button>
					</td>
					<td>${list.productName}</td>
					<td>${list.productPrice}円</td>
				</tr>
			</c:forEach>
		</table>
	</form>
</body>
</html>