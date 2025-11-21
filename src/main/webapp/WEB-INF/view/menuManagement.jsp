<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>商品追加削除画面</title>
</head>
<body>
<h1>メニュー追加・オプション設定</h1>
<form action="MunuManagementServlet" method="post">
<label>商品ID</label><br>
<input type="text" value=""placeholder="商品ID"><br>
<label>商品名</label><br>
<input type="text" value=""placeholder="商品名"><br>
<label>商品価格</label><br>
<input type="text" value=""placeholder="商品価格"><br>
<label>商品画像</label><br>
<input type="text" value=""placeholder="商品画像(xxx.jpg)"><br>
<label>商品カテゴリー</label><br>
<select name = "category" id="category-select">
<option value="">カテゴリーを選択してください</option>
<option value="1">そば</option>
<option value="2">うどん</option>
<option value="3">丼もの</option>
<option value="4">おすすめ</option>
<option value="5">サイドメニュー</option>
<option value="6">飲み物</option>
</select><br>
<label>商品説明</label><br>
<textarea rows="10" cols="20"></textarea><br>
<label>商品アレルギー説明</label><br>
<textarea rows="10" cols="20"></textarea><br>
<input type="button" value="追加">
</form>
</body>
</html>