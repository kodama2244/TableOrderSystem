<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>カート画面</title>
<style>
    /* --- 全体の基本設定 (枠なし・フルスクリーン) --- */
    body {
        margin: 0;
        padding: 0;
        font-family: "Hiragino Kaku Gothic ProN", "Meiryo", sans-serif;
        background-color: white;
        color: #333;
        height: 100vh;
        display: flex;
        flex-direction: column;
        box-sizing: border-box;
    }

    /* --- ヘッダーエリア --- */
    header {
        height: 80px;
        display: flex;
        align-items: center;
        justify-content: center;
        flex-shrink: 0;
    }

    h2 {
        font-size: 32px;
        font-weight: normal;
        margin: 0;
        color: #444;
    }

    /* --- メインコンテンツ（リストエリア） --- */
    .cart-container {
        flex-grow: 1;
        overflow-y: auto; /* スクロール可能に */
        padding: 0 40px;
        display: flex;
        flex-direction: column;
        gap: 15px;
    }

    /* 空のカートメッセージ */
    .empty-msg {
        text-align: center;
        font-size: 24px;
        margin-top: 100px;
        color: #888;
    }

    /* カート内の各行のデザイン */
    .cart-row {
        display: grid;
        /* レイアウト: 商品名(可変) | オプション | 価格 | 数量 | 削除ボタン */
        grid-template-columns: 2fr 1fr 1fr 0.8fr 100px; 
        align-items: center;
        border: 1px solid #ccc;
        padding: 15px;
        border-radius: 8px;
        font-size: 18px;
        background-color: #fff;
        gap: 10px;
    }

    /* 各セルのスタイル */
    .item-name {
        font-weight: bold;
        font-size: 20px;
    }
    .item-option {
        background-color: #f0f0f0;
        padding: 5px 10px;
        border-radius: 4px;
        text-align: center;
        font-size: 16px;
    }
    .item-price {
        text-align: right;
        font-weight: bold;
    }
    .item-qty {
        text-align: center;
    }
    
    /* 削除ボタン */
    .delete-btn {
        background-color: #888;
        color: white;
        border: none;
        padding: 10px;
        border-radius: 5px;
        cursor: pointer;
        width: 100%;
        font-size: 16px;
    }
    .delete-btn:active {
        background-color: #666;
    }

    /* --- 合計金額エリア --- */
    .total-area {
        padding: 20px 40px;
        text-align: right;
        font-size: 28px;
        font-weight: bold;
        border-top: 2px solid #eee;
        background-color: #fafafa;
    }

    /* --- フッター（アクションボタン） --- */
    .footer-actions {
        height: 100px;
        padding: 0 40px 30px 40px; /* 下に余白 */
        display: flex;
        justify-content: space-between;
        align-items: center;
        flex-shrink: 0;
    }

    /* ボタン共通スタイル */
    .action-btn {
        height: 70px;
        width: 200px;
        border: none;
        border-radius: 8px;
        font-size: 24px;
        font-weight: bold;
        cursor: pointer;
        color: white;
    }

    .btn-back {
        background-color: #555;
    }
    .btn-confirm {
        background-color: #444; /* 画像に合わせて濃いグレー */
        width: 300px; /* 確定ボタンは少し大きく */
    }

    .action-btn:active {
        opacity: 0.8;
        transform: scale(0.98);
    }

</style>
</head>
<body>

    <header>
        <h2>カート</h2>
    </header>

    <div class="cart-container">
        <c:if test="${empty cvm}">
            <p class="empty-msg">カートは空です。</p>
        </c:if>

        <c:if test="${not empty cvm}">
            <c:forEach var="item" items="${cvm}" varStatus="status">
                <div class="cart-row">
                    <div class="item-name">${item.productName}</div>
                    
                    <div class="item-option">
                        ${item.optionName}<br>
                    </div>

                    <div class="item-price">
                        ${item.productPrice + item.optionPrice}円
                    </div>

                    <div class="item-qty">
                        数量: ${item.quantity}<br>
                    </div>

                    <div>
                        <form action="CartServlet" method="post">
                            <input type="hidden" name="action" value="delete">
                            <input type="hidden" name="index" value="${status.index}">
                            <button type="submit" class="delete-btn">削除</button>
                        </form>
                    </div>
                </div>
            </c:forEach>
        </c:if>
    </div>

    <c:if test="${not empty cvm}">
        <div class="total-area">
            合計金額: ${totalAmount}円
        </div>

        <div class="footer-actions">
            <form action="MenuServlet" method="get">
                <button type="submit" name="category" value="${category}" class="action-btn btn-back">戻る</button>
            </form>

            <form action="OrderConfirmedServlet" method="post">
                <c:forEach var="item" items="${cvm}">
                    <input type="hidden" name="productId" value="${item.productId}" />
                    <input type="hidden" name="quantity" value="${item.quantity}" />
                    <input type="hidden" name="optionId" value="${item.optionId}" />
                </c:forEach>
                <button type="submit" class="action-btn btn-confirm">注文確定</button>
            </form>
        </div>
    </c:if>

    <c:if test="${empty cvm}">
        <div class="footer-actions" style="justify-content: center;">
            <form action="MenuServlet" method="get">
                <button type="submit" name="category" value="${category}" class="action-btn btn-back">メニューに戻る</button>
            </form>
        </div>
    </c:if>

</body>
</html>