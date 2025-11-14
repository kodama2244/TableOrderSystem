<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>メニュー一覧</title>
</head>
<body>
<form action="MenuServlet" method="GET">
<button type="submit" name="category" value="soba">そば</button>
<button type="submit" name="category" value="udon">うどん</button>
<button type="submit" name="category" value="udon">うどん</button>
<button type="submit" name="category" value="udon">うどん</button>
<button type="submit" name="category" value="udon">うどん</button>
</form>
<form action="SingleItemServlet" method="POST">
<c:forEach var="list" items="${mvm}">
<input type="button" value="${list}">
<input type="hidden" name="id" value="${list}"> 
</c:forEach>
</form>
</body>
</html>