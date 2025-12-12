<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>いらっしゃいませ画面</title>
</head>
<body>
<h1>${tableNumber}卓</h1>
<form action="NumberCustomersServlet" method="get">
<input type="submit" value="いらっしゃいませ">
</form>
</body>
</html>