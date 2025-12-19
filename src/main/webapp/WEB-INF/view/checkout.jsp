<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>お会計画面</title>
</head>
<body>
	<h1>お会計</h1>
	<p>お会計金額は${totalAmount}円です。</p>
	<form action="CheckoutServlet" method="post">
		<button type="submit">確定</button>
	</form>
	<form action="MenuServlet" method="get">
		<button type="submit">戻る</button>
	</form>
</body>
</html>