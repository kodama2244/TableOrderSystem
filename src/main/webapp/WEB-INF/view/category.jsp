<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>カテゴリー画面</title>
<style>
    body {
        margin: 0; padding: 20px;
        font-family: "Hiragino Kaku Gothic ProN", "Meiryo", sans-serif;
        background-color: white;
        height: 100vh;
        box-sizing: border-box;
        display: flex;
        flex-direction: column;
    }

    .welcome-msg {
        text-align: right;
        color: #555;
        font-size: 18px;
        margin-bottom: 20px;
    }

    /* 画面いっぱいを使うフォーム */
    form {
        flex-grow: 1;
        display: flex;
    }

    .category-grid {
        display: grid;
        grid-template-columns: repeat(3, 1fr);
        grid-template-rows: repeat(2, 1fr);
        gap: 20px;
        width: 100%;
        height: 100%;
    }

    .cat-btn {
        background-color: #444;
        color: white;
        border: none;
        border-radius: 10px;
        font-size: 32px;
        font-weight: bold;
        cursor: pointer;
        width: 100%;
        height: 100%;
        transition: background-color 0.2s;
    }
    .cat-btn:hover { background-color: #555; }
    .cat-btn:active { background-color: #333; }
</style>
</head>
<body>
    <p class="welcome-msg">${numberCustomer}名様でご来店ありがとうございます。</p> 
    <form action="MenuServlet" method="get">
        <div class="category-grid">
            <button type="submit" name="category" value="1" class="cat-btn">そば</button>
            <button type="submit" name="category" value="2" class="cat-btn">うどん</button>
            <button type="submit" name="category" value="3" class="cat-btn">丼もの</button>
            <button type="submit" name="category" value="4" class="cat-btn">おすすめ</button>
            <button type="submit" name="category" value="5" class="cat-btn">サイドメニュー</button>
            <button type="submit" name="category" value="6" class="cat-btn">飲み物</button>
        </div>
    </form>
</body>
</html>