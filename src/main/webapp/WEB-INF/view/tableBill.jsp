<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<html>
  <head>
    <title>会計画面</title>

    <style>
      table {
        border-collapse: collapse; width: 100%;
      }
      
      th, td {
        border: 1px solid #000; padding: 8px; text-align: center;
      }
      
      div {
        margin-top: 10px;
      }
    </style>
  </head>

  <body>
    <h2>テーブル ${viewModel.tableNumber} の会計</h2>

    <!-- 注文一覧 -->
    <table>
      <tr>
        <th>商品名</th>
        <th>数量</th>
        <th>単価</th>
        <th>小計</th>
        <th>状態</th>
      </tr>

      <c:forEach var="item" items="${viewModel.orderList}">
        <tr>
          <td>${ item.orderName }</td>
          <td>${ item.stock }</td>
          <td>${ item.price }</td>
          <td>${ item.stock * item.price }</td>
          <td>${ item.orderStatus }</td>
        </tr>
      </c:forEach>
    </table>

    <!-- お会計中止時確認 -->
    <button type="button" onclick="cancelPayment()">お会計を中止する</button>
    
    <!-- テンキー -->
    <div>
      <div>
        <button type="button" onclick="addNumber(7)">7</button>
        <button type="button" onclick="addNumber(8)">8</button>
        <button type="button" onclick="addNumber(9)">9</button>
      </div>
      <div>
        <button type="button" onclick="addNumber(4)">4</button>
        <button type="button" onclick="addNumber(5)">5</button>
        <button type="button" onclick="addNumber(6)">6</button>
      </div>
      <div>
        <button type="button" onclick="addNumber(1)">1</button>
        <button type="button" onclick="addNumber(2)">2</button>
        <button type="button" onclick="addNumber(3)">3</button>
      </div>
      <div>
        <button type="button" onclick="addNumber(0)">0</button>
        <button type="button" onclick="clearPay()">C</button>
      </div>
    </div>
    
    <!-- 合計金額 -->
    <h3>合計金額：<span id="total">${ viewModel.totalPrice }</span> 円</h3>

    <!-- 支払金額入力＋お釣り -->
    <div>
      <label>支払金額：</label>
      <input type="number" id="pay" oninput="calcChange()">

      <p>お釣り：<span id="change">0</span> 円</p>
    </div>

    <!-- 会計ボタン -->
    <form action="PaymentServlet" method="post" onsubmit="return validatePayment()">
      <input type="hidden" name="tableNumber" value="${ viewModel.tableNumber }">
      <input type="hidden" id="sendPay" name="payAmount">
      <input type="hidden" name="totalAmount" value="${ viewModel.totalPrice }">
      <button type="submit">会計する</button>
    </form>


    <script>
      // お会計中止時確認ポップアップ
      function cancelPayment() {
        const result = confirm("お会計を中止して座席一覧に戻りますか？");

        if (result) {
          location.href = "TableListServlet";
        }
      }

      // テンキー：数字を追加
      function addNumber(num) {
        const payInput = document.getElementById("pay");
        payInput.value = payInput.value + num;
        calcChange(); // お釣り再計算
      }

      // テンキー：クリア
      function clearPay() {
        document.getElementById("pay").value = "";
        document.getElementById("change").textContent = 0;
        document.getElementById("sendPay").value = 0;
      }
      
      // お釣り計算
      function calcChange() {
        const total = Number(document.getElementById("total").textContent);
        const pay   = Number(document.getElementById("pay").value);

        const change = pay - total;

        document.getElementById("change").textContent = change >= 0 ? change : 0;
        document.getElementById("sendPay").value = pay;
      }

      // 支払い金額チェック（不足していたら送信させない）
      function validatePayment() {
        const total = Number(document.getElementById("total").textContent);
        const pay = Number(document.getElementById("pay").value);

        if (pay < total) {
          alert("支払い金額が不足しています。");
          console.log('金額不足')
          return false;  // ← フォーム送信を止める
        }
        console.log('会計完了')
        return true; // OK → 送信
      }
    </script>
  </body>
</html>
