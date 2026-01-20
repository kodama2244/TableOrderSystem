<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="refresh" content="5">
<meta charset="UTF-8">
<title>キッチン・ホール画面</title>
<style>
    /* --- 全体の基本設定 (業務用フルスクリーン) --- */
    body {
        margin: 0;
        padding: 0;
        font-family: "Hiragino Kaku Gothic ProN", "Meiryo", sans-serif;
        background-color: #f4f4f4; /* 少しグレーにして白背景のカードを際立たせる */
        color: #333;
        height: 100vh;
        display: flex;
        flex-direction: column;
    }

    /* --- ヘッダー（管理画面感） --- */
    header {
        background-color: #333;
        color: white;
        padding: 15px 30px;
        display: flex;
        justify-content: space-between;
        align-items: center;
        flex-shrink: 0;
    }

    h1 { margin: 0; font-size: 24px; }

    /* --- メインコンテンツ（注文リスト） --- */
    .order-list-container {
        flex-grow: 1;
        overflow-y: auto;
        padding: 20px;
        display: flex;
        flex-direction: column;
        gap: 15px;
    }

    /* 注文カード（1行分） */
    .order-card {
        display: grid;
        /* テーブル番号 | 商品情報(名+オプション) | 数量 | 状況 | 操作ボタン2つ */
        grid-template-columns: 80px 1fr 80px 120px 180px 180px;
        align-items: center;
        background-color: white;
        border-radius: 8px;
        box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        padding: 10px 20px;
        gap: 15px;
    }

    /* 各要素のスタイル */
    .table-no {
        font-size: 28px;
        font-weight: bold;
        color: #444;
        border-right: 2px solid #eee;
        padding-right: 10px;
        text-align: center;
    }

    .product-info {
        display: flex;
        flex-direction: column;
    }
    .product-name { font-size: 20px; font-weight: bold; }
    .option-name { font-size: 16px; color: #666; margin-top: 4px; }

    .quantity { font-size: 24px; font-weight: bold; text-align: center; }

    .status-badge {
        text-align: center;
        padding: 8px;
        border-radius: 4px;
        font-weight: bold;
        background-color: #eee;
    }

    /* 操作ボタン */
    .action-form { margin: 0; }
    .btn {
        width: 100%;
        padding: 15px 10px;
        border: none;
        border-radius: 6px;
        font-size: 18px;
        font-weight: bold;
        cursor: pointer;
        color: white;
        transition: background-color 0.2s;
    }

    .btn-cooking { background-color: #4A90E2; } /* 調理用：青 */
    .btn-delivery { background-color: #444; }   /* 配膳用：濃いグレー */

    .btn:active {
        transform: translateY(2px);
        filter: brightness(0.8);
    }

    /* 注文がない場合 */
    .empty-msg {
        text-align: center;
        font-size: 24px;
        color: #999;
        margin-top: 100px;
    }

</style>
</head>
<body>

<header>
    <h1>キッチン・ホール注文管理</h1>
    <div id="clock"></div>
</header>

<div class="order-list-container">
    <c:choose>
        <c:when test="${empty khvm.orderHistorys}">
            <p class="empty-msg">現在、有効な注文はありません。</p>
        </c:when>
        <c:otherwise>
            <c:forEach var="order" items="${khvm.orderHistorys}">
                <div class="order-card">
                    <div class="table-no">${order.tableNumber}</div>

                    <div class="product-info">
                        <div class="product-name">${order.productName}</div>
                        <div class="option-name">
                            <c:if test="${not empty order.optionName}">[${order.optionName}]</c:if>
                        </div>
                    </div>

                    <div class="quantity">${order.productQuantity}</div>

                    <div class="status-badge">${order.statusName}</div>

                    <div class="action-form">
                        <form action="KitchenHallServlet" method="post">
                            <input type="hidden" name="status" value="2"> 
                            <input type="hidden" name="orderHistoryId" value="${order.orderHistoryId}">
                            <button type="submit" class="btn btn-cooking">調理完了</button>
                        </form>
                    </div>

                    <div class="action-form">
                        <form action="KitchenHallServlet" method="post">
                            <input type="hidden" name="orderHistoryId" value="${order.orderHistoryId}"> 
                            <input type="hidden" name="status" value="3">
                            <button type="submit" class="btn btn-delivery">配膳完了</button>
                        </form>
                    </div>
                </div>
            </c:forEach>
        </c:otherwise>
    </c:choose>
</div>

<script>
    // 簡易時計表示（店員さんの目安用）
    function updateClock() {
        const now = new Date();
        const timeStr = now.getHours() + ':' + String(now.getMinutes()).padStart(2, '0');
        document.getElementById('clock').textContent = timeStr;
    }
    setInterval(updateClock, 1000);
    updateClock();
</script>

</body>
</html>