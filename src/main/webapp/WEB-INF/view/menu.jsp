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
<table border="1">
  <c:forEach var="list" items="${mvm.products}">
    <tr>
      <td><img alt="イメージ画像" src='assets/img/${list.productImage}'></td>
      <td>${list.productName}</td>
      <td>${list.productPrice}円</td>
    </tr>
  </c:forEach>
</table>
</body>
</html>