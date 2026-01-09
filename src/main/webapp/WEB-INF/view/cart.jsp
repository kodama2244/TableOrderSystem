<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>カート画面</title>
</head>
<body>
	<h2>カート</h2>
	<c:if test="${empty cvm}">
		<p>カートは空です。</p>
	</c:if>
	<c:if test="${not empty cvm}">
		<table border="1">
			<tr>
				<th>商品名</th>
				<th>オプション名</th>
				<th>オプションid</th>
				<th>価格</th>
				<th>数量</th>
				<th>小計</th>
				<th>操作</th>
			</tr>
			<c:forEach var="item" items="${cvm}" varStatus="status">
				<%-- varStatusを追加 --%>
				<tr>
					<td>${item.productName}</td>
					<td>${item.optionName}</td>
					<td>${item.optionId}</td>
					<td>${item.productPrice + item.optionPrice}円</td>
					<td>${item.quantity}</td>
					<td>${(item.productPrice + item.optionPrice) * item.quantity}円</td>
					<td>
						<form action="CartServlet" method="post">
							<input type="hidden" name="action" value="delete">
							<%-- status.indexで現在の行の番号を送信 --%>
							<input type="hidden" name="index" value="${status.index}">
							<button type="submit" class="delete-btn">削除</button>
						</form>
					</td>
				</tr>
			</c:forEach>
		</table>
		<p>合計金額: ${totalAmount}円</p>
		<form action="OrderConfirmedServlet" method="post">
			<c:forEach var="item" items="${cvm}">
				<input type="hidden" name="productId" value="${item.productId}" />
				<input type="hidden" name="quantity" value="${item.quantity}" />
				<input type="hidden" name="optionName" value="${item.optionId}" />
			</c:forEach>
			<input type="submit" value="注文を確定する">
		</form>
	</c:if>
	<form action="MenuServlet" method="get">
		<button type="submit" name="category" value="${category}">メニュー一覧に戻る</button>
	</form>
</body>
</html>