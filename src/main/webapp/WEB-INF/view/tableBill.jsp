<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>レジ会計画面</title>
<style>
/* --- 全体の基本設定 --- */
body {
    margin: 0;
    padding: 20px 40px;
    font-family: "Hiragino Kaku Gothic ProN", "Meiryo", sans-serif;
    background-color: #f2ede4; /* ベージュ背景 */
    color: #5d5046; /* 茶系の文字色 */
}

header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 20px;
}

h1 {
    font-size: 28px;
    border-left: 8px solid #5d5046;
    padding-left: 15px;
    margin: 0;
}

/* --- テーブルエリア --- */
.order-history-area {
    margin-bottom: 15px;
}

.order-table {
    width: 100%;
    border-collapse: collapse;
    background-color: white;
}

.order-table th {
    background-color: #6b5443; /* 茶色ヘッダー */
    color: white;
    padding: 12px;
    border: 1px solid #dcd3c7;
    font-weight: normal;
}

.order-table td {
    padding: 12px;
    border: 1px solid #dcd3c7;
    text-align: center;
}

.price-col, .subtotal-col { text-align: right !important; }

/* 中止ボタン */
.btn-cancel {
    background-color: #9e4343;
    color: white;
    border: none;
    padding: 10px 20px;
    border-radius: 4px;
    cursor: pointer;
    font-size: 16px;
    margin-bottom: 30px;
}

/* --- 会計操作エリア --- */
.payment-section {
    display: flex;
    gap: 40px;
    align-items: flex-start;
}

/* テンキー */
.keypad {
    display: grid;
    grid-template-columns: repeat(3, 1fr);
    gap: 10px;
    background: white;
    padding: 15px;
    border: 1px solid #dcd3c7;
    width: 240px;
}
.key {
    background: #6b5443;
    color: white;
    border: none;
    padding: 20px;
    font-size: 24px;
    text-align: center;
    border-radius: 4px;
    cursor: pointer;
    user-select: none;
}
.key:active {
    background: #4a3a2e;
    transform: scale(0.95);
}

/* 計算ボックス */
.calc-container {
    background-color: #e6dec9;
    padding: 30px;
    border: 1px solid #5d5046;
    flex-grow: 1;
    max-width: 500px;
}

.calc-row {
    font-size: 24px;
    margin-bottom: 20px;
}

.pay-input {
    font-size: 28px;
    padding: 10px;
    width: 100%;
    margin-top: 10px;
    border: 1px solid #ccc;
    text-align: right;
    box-sizing: border-box;
}

.btn-submit {
    background-color: #6b5443;
    color: white;
    border: none;
    width: 150px;
    padding: 15px;
    font-size: 22px;
    cursor: pointer;
    margin-top: 15px;
    border-radius: 4px;
}

.change-display {
    margin-top: 30px;
    font-size: 26px;
    font-weight: bold;
}
</style>
</head>
<body>

    <header>
        <h1>テーブル ${vm.tableNumber} の会計</h1>
        <div>2026/01/16 (金) 11:21:07</div>
    </header>

    <div class="order-history-area">
        <table class="order-table">
            <thead>
                <tr>
                    <th>商品名</th>
                    <th>数量</th>
                    <th class="price-col">単価</th>
                    <th class="subtotal-col">小計</th>
                    <th>状態</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="item" items="${vm.orderList}">
                    <tr>
                        <td>${item.orderName}</td>
                        <td>${item.stock}</td>
                        <td class="price-col">${item.price}</td>
                        <td class="subtotal-col">${item.price * item.stock}</td>
                        <td>提供済み</td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>

    <button type="button" class="btn-cancel" onclick="confirmCancel()">お会計を中止する</button>

    <div class="payment-section">
        <div class="keypad">
            <button type="button" class="key" onclick="pressKey('7')">7</button>
            <button type="button" class="key" onclick="pressKey('8')">8</button>
            <button type="button" class="key" onclick="pressKey('9')">9</button>
            <button type="button" class="key" onclick="pressKey('4')">4</button>
            <button type="button" class="key" onclick="pressKey('5')">5</button>
            <button type="button" class="key" onclick="pressKey('6')">6</button>
            <button type="button" class="key" onclick="pressKey('1')">1</button>
            <button type="button" class="key" onclick="pressKey('2')">2</button>
            <button type="button" class="key" onclick="pressKey('3')">3</button>
            <button type="button" class="key" onclick="pressKey('0')">0</button>
            <button type="button" class="key" style="grid-column: span 2;" onclick="pressKey('C')">C</button>
        </div>

        <div class="calc-container">
            <form id="paymentForm" action="${pageContext.request.contextPath}/PaymentServlet" method="post" onsubmit="return validatePayment()">
                <input type="hidden" name="tableNumber" value="${vm.tableNumber}">
                <input type="hidden" name="totalAmount" value="${vm.totalPrice}">

                <div class="calc-row">合計金額： ${vm.totalPrice} 円</div>
                
                <div class="calc-row">
                    支払金額：<br>
                    <input type="number" name="payAmount" id="payAmount" class="pay-input" 
                           required readonly oninput="calcChange()">
                </div>

                <button type="submit" class="btn-submit">会計</button>

                <div class="change-display">
                    お釣り： <span id="changeResult">0</span> 円
                </div>
            </form>
        </div>
    </div>

    <script>
        // テンキー入力制御
        function pressKey(value) {
            const input = document.getElementById('payAmount');
            if (value === 'C') {
                input.value = "";
            } else {
                // 先頭が0にならないように制御
                if (input.value === "0") input.value = "";
                input.value += value;
            }
            calcChange(); // お釣り計算を走らせる
        }

        // 金額不足時のポップアップ
        function validatePayment() {
            const total = parseInt("${vm.totalPrice}");
            const pay = parseInt(document.getElementById('payAmount').value) || 0;
            
            if (pay < total) {
                alert("お預かり金額が不足しています。");
                return false; 
            }
            return true; 
        }

        // 中止時のポップアップ
        function confirmCancel() {
            if (confirm("会計を中止して座席一覧に戻りますか？")) {
                location.href = '${pageContext.request.contextPath}/TableListServlet';
            }
        }

        // お釣り計算
        function calcChange() {
            const total = parseInt("${vm.totalPrice}");
            const pay = parseInt(document.getElementById('payAmount').value) || 0;
            const change = pay - total;

            const display = document.getElementById('changeResult');
            if (change >= 0) {
                display.textContent = change.toLocaleString();
                display.style.color = "#5d5046";
            } else {
                display.textContent = "不足";
                display.style.color = "#9e4343";
            }
        }
    </script>

</body>
</html>