<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>店舗売上画面</title>
</head>
<body>
	<form action="StoreSaleServlet" method="">
		<input type="calendar" name="saleDate" required>"
	</form>
	<table border="1">
		<tr>
			<th>商品名</th>
			<th>単価</th>
			<th>数量</th>
			<th>商品ごとの売り上げ</th>
			<th>日付</th>
		</tr>
		<c:forEach var="" items="">
			<tr>
			</tr>
		</c:forEach>
	</table>
	<form action="" method="get">
		<button type="submit">戻る</button>
	</form>
	<form action="">
	<button type="submit">ダウンロード</button>
	</form>
</body>
</html>