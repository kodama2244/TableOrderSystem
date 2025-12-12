<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>注文履歴</title>
</head>
<body>
	<h2>注文履歴</h2>
	<table border="1">
		<tr>
			<th>商品名</th>
			<th>オプション</th>
			<th>値段</th>
			<th>数字</th>
			<th>配膳状況</th>
		</tr>
		<c:forEach var="order" items="${orderHistory}">
			<tr>
				<td>${order.productName}</td>
				<td>${order.options}</td>
				<td>${order.price}</td>
				<td>${order.quantity}</td>
				<td>${order.status}</td>
			</tr>
		</c:forEach>
	</table>
	</form action="MenuServlet" method="get">
	<button type="submit">メニューに戻る</button>
</body>
</html>