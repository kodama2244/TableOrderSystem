<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<html>
<head>
    <title>会計画面</title>
    <style>
        table {
            border-collapse: collapse;
            width: 100%;
        }
        th, td {
            border: 1px solid #000;
            padding: 8px;
            text-align: center;
        }
        div {
            margin-top: 10px;
        }
    </style>
</head>

<body>

<h2>テーブル ${vm.tableNumber} の会計</h2>

<!-- 注文一覧 -->
<table>
    <tr>
        <th>商品名</th>
        <th>数量</th>
        <th>単価</th>
        <th>小計</th>
        <th>状態</th>
    </tr>

    <c:forEach var="item" items="${vm.orderList}">
        <tr>
            <td>${item.orderName}</td>
            <td>${item.stock}</td>
            <td>${item.price}</td>
            <td>${item.stock * item.price}</td>
            <td>${item.orderStatus}</td>
        </tr>
    </c:forEach>
</table>

<!-- 合計金額 -->
<h3>合計金額：${vm.totalPrice} 円</h3>

<!-- 会計フォーム -->
<form action="${pageContext.request.contextPath}/PaymentServlet" method="post">
    <input type="hidden" name="tableNumber" value="${vm.tableNumber}">
    <input type="hidden" name="totalAmount" value="${vm.totalPrice}">

    <label>支払金額：</label>
    <input type="number" name="payAmount" required min="${vm.totalPrice}">
    円

    <br><br>

    <button type="submit">会計する</button>
</form>

<br>

<!-- 会計中止 -->
<form action="${pageContext.request.contextPath}/TableListServlet" method="get">
    <button type="submit">会計を中止して一覧に戻る</button>
</form>

</body>
</html>
