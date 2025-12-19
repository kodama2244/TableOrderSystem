<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>本日はご来店ありがとうございました画面</title>
</head>
<body>
	<h1>本日はご来店ありがとうございました</h1>
	<p>バインダーをレジにお持ちください。</p>
	<form action="NumberCustomersServlet" method="get">
		<button type="submit">初めから</button>
	</form>
</body>
</html>