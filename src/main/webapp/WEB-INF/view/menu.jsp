<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>メニュー一覧</title>
<style>
    body {
        margin: 0; padding: 0;
        font-family: "Hiragino Kaku Gothic ProN", "Meiryo", sans-serif;
        background-color: white;
        height: 100vh;
        display: grid;
        /* レイアウト: [上部ナビ] / [左メイン] [右サイド] / [下部フッター] */
        grid-template-rows: 60px 1fr 60px;
        grid-template-columns: 1fr 140px;
        gap: 10px;
        padding: 10px;
        box-sizing: border-box;
    }

    /* --- 上部カテゴリーナビ --- */
    .category-nav {
        grid-column: 1 / -1;
    }
    .category-form {
        display: flex; gap: 5px; height: 100%;
    }
    .cat-btn {
        flex: 1;
        background-color: #444; color: white;
        border: none; border-radius: 5px;
        font-size: 16px; font-weight: bold;
        cursor: pointer;
    }
    .cat-btn:hover { background-color: #555; }

    /* --- メイン商品エリア --- */
    .product-area {
        grid-column: 1 / 2;
        overflow-y: auto; /* スクロール */
        border: 1px solid #eee; /* 薄い境界線 */
        border-radius: 5px;
        padding: 10px;
    }
    .product-grid {
        display: grid;
        grid-template-columns: repeat(3, 1fr);
        gap: 20px;
    }
    .product-card {
        background: none; border: none; padding: 0;
        cursor: pointer; width: 100%; outline: none;
    }
    .card-inner {
        background-color: #f5f5f5;
        width: 100%; aspect-ratio: 1 / 1;
        display: flex; align-items: center; justify-content: center;
        margin-bottom: 5px; border-radius: 5px;
    }
    .card-inner img { width: 80%; height: auto; object-fit: contain; }
    .product-name { font-size: 18px; font-weight: bold; color: #333; margin-bottom: 5px;}
    .product-price { font-size: 16px; color: #666; }

    /* --- 右サイドバー --- */
    .sidebar {
        grid-column: 2 / 3; grid-row: 2 / 4;
        display: flex; flex-direction: column; gap: 10px;
    }
    .sidebar-form { flex: 1; display: flex; }
    .side-btn {
        width: 100%; height: 100%;
        background-color: #444; color: white;
        border: none; border-radius: 5px;
        font-size: 18px; font-weight: bold; cursor: pointer;
    }

    /* --- フッター（戻る） --- */
    .footer-nav {
        grid-column: 1 / 2;
        display: flex; align-items: center;
    }
    .nav-btn {
        background-color: #555; color: white;
        border: none; border-radius: 5px;
        width: 150px; height: 100%;
        font-size: 18px; cursor: pointer;
    }
</style>
</head>
<body>

    <div class="category-nav">
        <form action="MenuServlet" method="get" class="category-form">
            <button type="submit" name="category" value="1" class="cat-btn">そば</button>
            <button type="submit" name="category" value="2" class="cat-btn">うどん</button>
            <button type="submit" name="category" value="3" class="cat-btn">丼もの</button>
            <button type="submit" name="category" value="4" class="cat-btn">おすすめ</button>
            <button type="submit" name="category" value="5" class="cat-btn">サイド</button>
            <button type="submit" name="category" value="6" class="cat-btn">飲み物</button>
        </form>
    </div>

    <div class="product-area">
        <form action="SingleItemServlet" method="get">
            <input type="hidden" name="category" value="${category}">
            <div class="product-grid">
                <c:forEach var="list" items="${mvm.products}">
                    <button type="submit" name="id" value="${list.productId}" class="product-card">
                        <div class="card-inner">
                            <img alt="${list.productName}" src='assets/img/${list.productImage}'>
                        </div>
                        <div class="product-name">${list.productName}</div>
                        <div class="product-price">${list.productPrice}円</div>
                    </button>
                </c:forEach>
            </div>
        </form>
    </div>

    <div class="sidebar">
        <form action="CartServlet" method="get" class="sidebar-form">
            <button type="submit" name="category" value="${category}" class="side-btn">カート</button>
        </form>
        <form action="OrderHistoryServlet" method="get" class="sidebar-form">
            <button type="submit" class="side-btn">注文<br>履歴</button>
        </form>
        <form action="CheckoutServlet" method="get" class="sidebar-form">
            <button type="submit" class="side-btn">お会計</button>
        </form>
    </div>

    <div class="footer-nav">
        <button type="button" class="nav-btn" onclick="history.back()">戻る</button>
    </div>

</body>
</html>