<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="refresh" content="5">
<meta charset="UTF-8">
<title>SOBAYA | キッチン・ホール注文管理</title>
<style>
    /* --- 全体の基本設定 --- */
    body {
        margin: 0; padding: 0;
        font-family: "Hiragino Kaku Gothic ProN", "Meiryo", sans-serif;
        background-color: #f0f2f5;
        color: #333;
        height: 100vh;
        display: flex;
        flex-direction: column;
    }

    /* --- ヘッダー --- */
    header {
        background-color: #2c3e50;
        color: white;
        padding: 10px 30px;
        display: flex;
        justify-content: space-between;
        align-items: center;
        box-shadow: 0 2px 4px rgba(0,0,0,0.2);
    }
    h1 { margin: 0; font-size: 22px; letter-spacing: 1px; }

    /* --- サマリー見出しエリア --- */
    .summary-bar {
        background-color: #fff;
        padding: 15px 30px;
        display: flex;
        align-items: center;
        gap: 50px;
        border-bottom: 1px solid #ddd;
    }
    .summary-item { display: flex; align-items: baseline; gap: 10px; }
    .summary-label { font-size: 16px; font-weight: bold; color: #666; }
    .summary-count { font-size: 32px; font-weight: bold; color: #d9534f; }

    /* --- ★ 見出し行（ズレ修正版） ★ --- */
    .column-header {
        /* カードの親要素（order-list-container）のpaddingと横位置を合わせる */
        margin: 15px 30px 0 30px; 
        display: grid;
        /* カード側と全く同じカラム比率 */
        grid-template-columns: 80px 1fr 100px 140px 180px 180px;
        gap: 20px;
        color: #7f8c8d;
        font-weight: bold;
        font-size: 15px;
        text-align: center;
        
        /* カードの border-left (8px) と padding (25px) の合計分を計算して合わせる */
        padding: 10px 25px; 
        border-left: 8px solid transparent; 
    }

    /* --- 注文リストエリア --- */
    .order-list-container {
        flex-grow: 1;
        overflow-y: auto;
        padding: 10px 30px 20px 30px;
        display: flex;
        flex-direction: column;
        gap: 12px;
    }

    /* 注文カード */
    .order-card {
        display: grid;
        grid-template-columns: 80px 1fr 100px 140px 180px 180px;
        align-items: center;
        background-color: white;
        border-radius: 10px;
        padding: 15px 25px;
        gap: 20px;
        box-shadow: 0 2px 5px rgba(0,0,0,0.05);
        /* ステータスを示す左線 */
        border-left: 8px solid #ccc;
    }

    .table-no { font-size: 32px; font-weight: bold; text-align: center; color: #2c3e50; }
    .product-info { text-align: left; }
    .product-name { font-size: 20px; font-weight: bold; }
    .option-name { font-size: 15px; color: #e67e22; font-weight: bold; margin-top: 4px; }
    .quantity { font-size: 28px; font-weight: bold; text-align: center; background: #f8f9fa; border-radius: 5px; padding: 5px 0; }
    .status-badge { text-align: center; padding: 10px; border-radius: 5px; font-weight: bold; background-color: #ecf0f1; font-size: 16px; }

    /* 操作ボタン */
    .btn {
        width: 100%; padding: 18px 0; border: none; border-radius: 8px;
        font-size: 18px; font-weight: bold; cursor: pointer; color: white; transition: 0.2s;
    }
    .btn-cooking { background-color: #3498db; } 
    .btn-delivery { background-color: #34495e; } 
    .btn:hover:not(:disabled) { opacity: 0.9; }
    .btn:active:not(:disabled) { transform: scale(0.98); }
    .btn:disabled { opacity: 0.2; cursor: not-allowed; }

    .empty-msg { text-align: center; font-size: 24px; color: #999; margin-top: 100px; }
</style>
</head>
<body>

<header>
    <h1>SOBAYA 注文管理システム</h1>
    <div id="clock" style="font-size: 22px; font-family: monospace;"></div>
</header>

<div class="summary-bar">
    <div class="summary-item">
        <span class="summary-label">未完了の注文数:</span>
        <span class="summary-count">
            <c:out value="${empty khvm.orderHistorys ? '0' : khvm.orderHistorys.size()}" />
        </span>
        <span class="summary-label">件</span>
    </div>
</div>

<div class="column-header">
    <div>テーブル</div>
    <div style="text-align: left;">注文内容</div>
    <div>数量</div>
    <div>現在の状態</div>
    <div>調理操作</div>
    <div>配膳操作</div>
</div>

<div class="order-list-container">
    <c:choose>
        <c:when test="${empty khvm.orderHistorys}">
            <p class="empty-msg">現在、対応が必要な注文はありません。</p>
        </c:when>
        <c:otherwise>
            <c:forEach var="order" items="${khvm.orderHistorys}">
                <div class="order-card" 
                     style="border-left-color: ${order.statusName == '未調理' ? '#e74c3c' : '#f1c40f'};">
                    
                    <div class="table-no">${order.tableNumber}</div>

                    <div class="product-info">
                        <div class="product-name">${order.productName}</div>
                        <div class="option-name">
                            <c:if test="${not empty order.optionName}">[${order.optionName}]</c:if>
                        </div>
                    </div>

                    <div class="quantity">${order.productQuantity}</div>

                    <div class="status-badge" style="color: ${order.statusName == '未調理' ? '#e74c3c' : '#f39c12'};">
                        ${order.statusName}
                    </div>

                   <div class="action-form">
                        <form action="KitchenHallServlet" method="post">
                            <input type="hidden" name="status" value="2"> 
                            <input type="hidden" name="orderHistoryId" value="${order.orderHistoryId}">
                            <button type="submit" class="btn btn-cooking">調理完了</button>
                        </form>
                    </div>

                    <div class="action-form">
                        <form action="KitchenHallServlet" method="post">
                            <input type="hidden" name="status" value="3">
                            <input type="hidden" name="orderHistoryId" value="${order.orderHistoryId}"> 
                            <button type="submit" class="btn btn-delivery">配膳完了</button>
                        </form>
                    </div>
                </div>
            </c:forEach>
        </c:otherwise>
    </c:choose>
</div>

<script>
    function updateClock() {
        const now = new Date();
        document.getElementById('clock').textContent = now.toLocaleTimeString('ja-JP');
    }
    setInterval(updateClock, 1000);
    updateClock();
</script>

</body>
</html>