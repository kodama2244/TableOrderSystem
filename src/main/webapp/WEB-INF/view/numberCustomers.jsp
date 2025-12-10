<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>お客様人数入力画面</title>
</head>
<body>
	<form action="category" method="get">
		<select name="numberCustomer" id="numberCustomer-select">
			<option value="">人数を入力してください</option>
			<option value="1">1</option>
			<option value="2">2</option>
			<option value="3">3</option>
			<option value="4">4</option>
			<option value="5">5</option>
			<option value="6">6</option>
			<option value="7">7</option>
		</select>
		<input type="submit" value="確定">
	</form>
</body>
</html>