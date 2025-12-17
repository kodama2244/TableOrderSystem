<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>キッチン・ホール画面</title>
</head>
<body>
	<h1>キッチン・ホール画面</h1>
	<table border="1">
		<tr>
			<th>テーブル番号</th>
			<th>商品名</th>
			<th>オプション名</th>
			<th>価格</th>
			<th>数量</th>
			<th>注文状況</th>
			<th>調理完了</th>
			<th>配膳完了</th>
		</tr>
		<c:choose>
			<c:when test="${empty khvm}">
				<tr>
					<td colspan="5">注文履歴はありません</td>
				</tr>
			</c:when>
			<c:otherwise>
				<c:forEach var="order" items="${khvm.orderHistorys}">
					<tr>
						<td>${order.tableNumber}</td>
						<td>${order.productName}</td>
						<td>${order.optionName}</td>
						<td>${order.productPrice}</td>
						<td>${order.productQuantity}</td>
						<td>${order.statusName}</td>
						<td>
							<form action="KitchenHallServlet" method="post">
								<input type="hidden" name="status" value="2"> <input
									type="hidden" name="orderHistoryId"
									value="${order.orderHistoryId}">
								<button type="submit">調理済みにする</button>
							</form>
						</td>
						<td>
							<form action="KitchenHallServlet" method="post">
								<input type="hidden" name="orderHistoryId"
									value="${order.orderHistoryId}"> <input type="hidden"
									name="status" value="3">
								<button type="submit">配膳済みにする</button>
							</form>
						</td>
					</tr>
				</c:forEach>
			</c:otherwise>
		</c:choose>
	</table>
</body>
</html>