<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>レジ会計画面</title>
    <style>
        body {
            margin: 0;
            padding: 0;
            font-family: "Hiragino Kaku Gothic ProN", "Meiryo", sans-serif;
            background-color: #f4f4f4;
            height: 100vh;
            display: flex;
            flex-direction: column;
        }

        header {
            background-color: #333;
            color: white;
            padding: 15px 30px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        /* 注文一覧エリア（スクロール可能） */
        .order-history-area {
            flex-grow: 1;
            overflow-y: auto;
            padding: 20px;
        }

        .order-card {
            display: grid;
            grid-template-columns: 2fr 100px 80px 120px;
            background: white;
            margin-bottom: 10px;
            padding: 15px;
            border-radius: 5px;
            box-shadow: 0 1px 3px rgba(0,0,0,0.1);
            align-items: center;
            font-size: 18px;
        }

        .price-text { text-align: right; font-weight: bold; }
        .qty-text { text-align: center; }

        /* 会計操作エリア（固定） */
        .payment-footer {
            background: white;
            border-top: 3px solid #333;
            padding: 20px 40px;
        }

        .calc-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 40px;
            align-items: start;
        }

        .total-display {
            font-size: 24px;
            border: 2px solid #333;
            padding: 20px;
            background: #fafafa;
        }

        .total-amount {
            font-size: 48px;
            color: #d9534f;
            display: block;
            text-align: right;
        }

        /* 入力フォーム */
        .input-group {
            display: flex;
            flex-direction: column;
            gap: 15px;
        }

        .pay-input {
            font-size: 40px;
            padding: 10px;
            width: 100%;
            text-align: right;
            border: 2px solid #ccc;
            border-radius: 5px;
        }

        .change-display {
            font-size: 28px;
            font-weight: bold;
            color: #4A90E2;
            text-align: right;
        }

        /* ボタン */
        .btn-group {
            display: flex;
            gap: 20px;
            margin-top: 20px;
        }

        .btn {
            flex: 1;
            height: 80px;
            font-size: 24px;
            font-weight: bold;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            color: white;
        }

        .btn-back { background-color: #777; }
        .btn-submit { background-color: #333; }
        .btn:active { opacity: 0.8; }

    </style>
</head>
<body>

<header>
    <h2>席番号: ${vm.tableNumber}</h2>
    <div>レジ会計担当</div>
</header>

<div class="order-history-area">
    <c:forEach var="item" items="${vm.orderList}">
        <div class="order-card">
            <div>${item.orderName}</div>
            <div class="price-text">${item.price}円</div>
            <div class="qty-text">${item.stock}点</div>
            <div class="price-text" style="color:#666;">小計: ${item.stock * item.price}円</div>
        </div>
    </c:forEach>
</div>

<div class="payment-footer">
    <form action="${pageContext.request.contextPath}/PaymentServlet" method="post" id="payForm">
        <input type="hidden" name="tableNumber" value="${vm.tableNumber}">
        <input type="hidden" name="totalAmount" value="${vm.totalPrice}">

        <div class="calc-grid">
            <div class="input-group">
                <div class="total-display">
                    合計金額
                    <span class="total-amount">${vm.totalPrice} <small>円</small></span>
                </div>
                
                <div>
                    <label style="font-size: 20px; font-weight: bold;">お預かり金額</label>
                    <input type="number" name="payAmount" id="payAmount" class="pay-input" 
                           required min="${vm.totalPrice}" placeholder="0" oninput="calcChange()">
                </div>
            </div>

            <div class="input-group">
                <div class="change-display">
                    お釣り: <span id="changeResult">0</span> 円
                </div>
                
                <div class="btn-group">
                    <button type="button" class="btn btn-back" 
                            onclick="location.href='${pageContext.request.contextPath}/TableListServlet'">中止して戻る</button>
                    <button type="submit" class="btn btn-submit">会計済み (確定)</button>
                </div>
            </div>
        </div>
    </form>
</div>

<script>
    // お釣りをリアルタイム計算するスクリプト
    function calcChange() {
        const total = parseInt("${vm.totalPrice}");
        const pay = parseInt(document.getElementById('payAmount').value) || 0;
        const change = pay - total;
        
        const display = document.getElementById('changeResult');
        if (change >= 0) {
            display.textContent = change.toLocaleString();
            display.style.color = "#4A90E2"; // 青色
        } else {
            display.textContent = "不足";
            display.style.color = "#d9534f"; // 赤色
        }
    }
</script>

</body>
</html>