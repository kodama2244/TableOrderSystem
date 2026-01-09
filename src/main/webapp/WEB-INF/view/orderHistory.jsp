<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core"%>
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
			<th>オプション名</th>
			<th>価格</th>
			<th>数量</th>
			<th>注文状況</th>
			<c:choose>
				<c:when test="${empty ovm}">
					<tr>
						<td colspan="5">注文履歴はありません</td>
					</tr>
				</c:when>
				<c:otherwise>
					<c:forEach var="order" items="${ovm.orderHistorys}">
						<tr>
							<td>${order.productName}</td>
							<td>${order.optionName}</td>
							<td>${order.productPrice}</td>
							<td>${order.productQuantity}</td>
							<td>${order.statusName}</td>
						</tr>
					</c:forEach>
				</c:otherwise>
			</c:choose>
	</table>
	<div class="total-area">
		<h3>合計金額： ${totalAmount} 円</h3>
	</div>
	<form action="MenuServlet" method="get">
		<button type="submit">メニューに戻る</button>
	</form>
	<form action="CheckoutServlet" method="get">
		<button type="submit">お会計</button>
	</form>
</body>
</html>