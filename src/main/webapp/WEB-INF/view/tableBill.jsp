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
            overflow: hidden; /* 画面全体のスクロールを禁止 */
        }

        header {
            background-color: #333;
            color: white;
            padding: 10px 30px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-shrink: 0;
        }

        /* --- 注文履歴エリア（ここを大きくしました） --- */
        .order-history-area {
            flex-grow: 1; /* 余ったスペースをすべて使う */
            overflow-y: auto; /* 明細が多い場合はここだけスクロール */
            padding: 20px 40px;
            background-color: #fff;
            margin: 10px 20px;
            border: 1px solid #ccc;
            border-radius: 8px;
        }

        .order-table {
            width: 100%;
            border-collapse: collapse;
            font-size: 20px;
        }

        .order-table th {
            position: sticky; /* 見出しを固定 */
            top: 0;
            background: #eee;
            padding: 15px;
            border-bottom: 2px solid #333;
        }

        .order-table td {
            padding: 18px 15px;
            border-bottom: 1px solid #eee;
        }

        .price-col { text-align: right; font-weight: bold; width: 150px; }
        .qty-col { text-align: center; width: 100px; }
        .subtotal-col { text-align: right; color: #666; width: 180px; }

        /* --- 会計操作エリア（下部に固定） --- */
        .payment-footer {
            background: #e9e9e9;
            padding: 20px 40px;
            flex-shrink: 0;
            box-shadow: 0 -5px 10px rgba(0,0,0,0.05);
        }

        .calc-grid {
            display: grid;
            grid-template-columns: 1.2fr 1fr;
            gap: 40px;
            align-items: center;
        }

        /* 左側：合計・預かり入力 */
        .amount-inputs {
            display: flex;
            align-items: center;
            gap: 30px;
        }

        .total-box {
            background: #333;
            color: white;
            padding: 15px 25px;
            border-radius: 5px;
            min-width: 250px;
        }
        .total-box label { font-size: 16px; display: block; margin-bottom: 5px; }
        .total-val { font-size: 36px; font-weight: bold; display: block; text-align: right; }

        .pay-box label { font-size: 18px; font-weight: bold; display: block; margin-bottom: 5px; }
        .pay-input {
            font-size: 32px;
            padding: 8px;
            width: 200px;
            text-align: right;
            border: 2px solid #999;
            border-radius: 5px;
        }

        /* 右側：お釣り・ボタン（右下配置） */
        .action-area {
            display: flex;
            flex-direction: column;
            align-items: flex-end;
            gap: 15px;
        }

        .change-display {
            font-size: 28px;
            font-weight: bold;
        }
        .change-val { font-size: 40px; color: #4A90E2; margin-left: 10px; }

        .btn-group {
            display: flex;
            gap: 15px;
        }

        .btn {
            height: 70px;
            width: 200px;
            font-size: 22px;
            font-weight: bold;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            color: white;
        }

        .btn-back { background-color: #888; }
        .btn-submit { background-color: #2c3e50; }
        .btn:active { transform: scale(0.97); opacity: 0.9; }

    </style>
</head>
<body>

<header>
    <h1>テーブル番号: ${vm.tableNumber} 会計明細</h1>
 
</header>

<div class="order-history-area">
    <table class="order-table">
        <thead>
            <tr>
                <th style="text-align: left;">商品名</th>
                <th class="price-col">単価</th>
                <th class="qty-col">数量</th>
                <th class="subtotal-col">小計</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="item" items="${vm.orderList}">
                <tr>
                    <td>${item.orderName}</td>
                    <td class="price-col">${item.price}円</td>
                    <td class="qty-col">${item.stock}</td>
                    <td class="subtotal-col">${item.stock * item.price}円</td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</div>

<div class="payment-footer">
    <form action="${pageContext.request.contextPath}/PaymentServlet" method="post">
        <input type="hidden" name="tableNumber" value="${vm.tableNumber}">
        <input type="hidden" name="totalAmount" value="${vm.totalPrice}">

        <div class="calc-grid">
            <div class="amount-inputs">
                <div class="total-box">
                    <label>請求合計金額</label>
                    <span class="total-val">${vm.totalPrice} <small>円</small></span>
                </div>
                
                <div class="pay-box">
                    <label>お預かり金額</label>
                    <input type="number" name="payAmount" id="payAmount" class="pay-input" 
                           required min="${vm.totalPrice}" oninput="calcChange()">
                </div>
            </div>

            <div class="action-area">
                <div class="change-display">
                    お釣り: <span id="changeResult" class="change-val">0</span> <small>円</small>
                </div>
                
                <div class="btn-group">
                    <button type="button" class="btn btn-back" 
                            onclick="location.href='${pageContext.request.contextPath}/TableListServlet'">中止</button>
                    <button type="submit" class="btn btn-submit">会計確定</button>
                </div>
            </div>
        </div>
    </form>
</div>

<script>
    function calcChange() {
        const total = parseInt("${vm.totalPrice}");
        const pay = parseInt(document.getElementById('payAmount').value) || 0;
        const change = pay - total;
        
        const display = document.getElementById('changeResult');
        if (change >= 0) {
            display.textContent = change.toLocaleString();
            display.style.color = "#4A90E2";
        } else {
            display.textContent = "不足";
            display.style.color = "#d9534f";
        }
    }
</script>

</body>
</html>