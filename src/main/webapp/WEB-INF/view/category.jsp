<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>カテゴリー画面</title>
</head>
<body>
<p>${numberCustomer}名様でご来店ありがとうございます。</p> 
<form action="MenuServlet" method="get">
		<table border="1">
			<tr>
				<td><button type="submit" name="category" value="1">そば</button></td>
				<td><button type="submit" name="category" value="2">うどん</button></td>
				<td><button type="submit" name="category" value="3">丼もの</button></td>
				<td><button type="submit" name="category" value="4">おすすめ</button></td>
				<td><button type="submit" name="category" value="5">サイドメニュー</button></td>
				<td><button type="submit" name="category" value="6">飲み物</button></td>
			</tr>
		</table>
</form>
</body>
</html>