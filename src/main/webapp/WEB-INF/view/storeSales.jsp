<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>店舗売上管理</title>
<style>
    body {
        margin: 0;
        padding: 0;
        font-family: "Hiragino Kaku Gothic ProN", "Meiryo", sans-serif;
        background-color: #f4f4f4;
        color: #333;
        height: 100vh;
        display: flex;
        flex-direction: column;
        overflow: hidden;
    }

    header {
        background-color: #333;
        color: white;
        padding: 15px 30px;
        display: flex;
        justify-content: space-between;
        align-items: center;
        flex-shrink: 0;
    }

    .search-bar {
        background: white;
        padding: 15px 30px;
        border-bottom: 1px solid #ccc;
        display: flex;
        align-items: center;
        gap: 20px;
        flex-shrink: 0;
    }

    /* --- 売上明細エリア --- */
    .sales-container {
        flex-grow: 1;
        overflow-y: auto;
        margin: 15px;
        background-color: #fff;
        border-radius: 8px;
        border: 1px solid #ccc;
        position: relative;
    }

    .sales-table {
        width: 100%;
        /* 列幅を固定してズレを防止 */
        table-layout: fixed; 
        border-collapse: separate;
        border-spacing: 0;
    }

    /* 列ごとの幅指定 (合計100%) */
    .col-name { width: 35%; }
    .col-opt  { width: 20%; }
    .col-unit { width: 15%; }
    .col-qty  { width: 10%; }
    .col-sub  { width: 20%; }

    /* --- 見出しの固定と縦線 --- */
    .sales-table thead th {
        position: sticky;
        top: 0;
        background-color: #eee;
        color: #333;
        padding: 15px 12px;
        text-align: left;
        border-bottom: 2px solid #333;
        /* 縦線の追加 */
        border-right: 1px solid #ccc; 
        z-index: 100;
        background-clip: padding-box;
    }

    /* 最後の列の縦線は不要 */
    .sales-table thead th:last-child {
        border-right: none;
    }

    /* --- データの縦線 --- */
    .sales-table tbody td {
        padding: 15px 12px;
        border-bottom: 1px solid #eee;
        /* 縦線の追加 */
        border-right: 1px solid #eee;
        background-color: #fff;
        position: relative;
        z-index: 1;
        /* 長い商品名の折り返し設定 */
        word-wrap: break-word;
        overflow-wrap: break-word;
    }

    .sales-table tbody td:last-child {
        border-right: none;
    }

    .num-col { text-align: right; }

    /* --- フッター --- */
    .footer-summary {
        background: white;
        padding: 15px 40px;
        border-top: 3px solid #333;
        display: flex;
        justify-content: space-between;
        align-items: center;
        flex-shrink: 0;
    }

    .total-display {
        background: #f8f9fa;
        border: 2px solid #333;
        padding: 10px 25px;
        display: flex;
        align-items: center;
        gap: 20px;
    }

    .total-amount { font-size: 28px; font-weight: bold; color: #d9534f; }

    .btn-back {
        background-color: #555;
        color: white;
        border: none;
        padding: 12px 25px;
        border-radius: 5px;
        font-size: 18px;
        font-weight: bold;
        cursor: pointer;
    }
</style>
</head>
<body>

    <header>
        <h1>店舗売上管理</h1>
    </header>

    <div class="search-bar">
        <form action="StoreSalesServlet" method="get" style="margin:0; display:flex; align-items:center; gap:15px;">
            <label for="targetDate" style="font-weight:bold;">表示日の選択:</label>
            <input type="date" id="targetDate" name="targetDate" value="${selectedDate}">
            <button type="submit" style="background-color: #4A90E2; color:white; border:none; padding:10px 20px; border-radius:4px; cursor:pointer; font-weight:bold;">検索</button>
        </form>
    </div>

    <div class="sales-container">
        <c:choose>
            <c:when test="${empty vm.salesList}">
                <div style="text-align:center; padding:100px; color:#999; font-size:18px;">
                    データがありません。日付を選択してください。
                </div>
            </c:when>
            <c:otherwise>
                <table class="sales-table">
                    <colgroup>
                        <col class="col-name">
                        <col class="col-opt">
                        <col class="col-unit">
                        <col class="col-qty">
                        <col class="col-sub">
                    </colgroup>
                    <thead>
                        <tr>
                            <th>商品名</th>
                            <th>オプション</th>
                            <th class="num-col">単価(込)</th>
                            <th class="num-col">数量</th>
                            <th class="num-col">小計</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="item" items="${vm.salesList}">
                            <tr>
                                <td>${item.productName}</td>
                                <td><c:out value="${empty item.optionName ? 'なし' : item.optionName}" /></td>
                                <td class="num-col">${item.productPrice + item.optionPrice}円</td>
                                <td class="num-col">${item.productQuantity}</td>
                                <td class="num-col">${(item.productPrice + item.optionPrice) * item.productQuantity}円</td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </c:otherwise>
        </c:choose>
    </div>

    <div class="footer-summary">
        <div class="total-display">
            <span style="font-weight:bold;">対象日: ${vm.targetDate} ／ 総売上高</span>
            <span class="total-amount">
                <c:out value="${not empty vm ? vm.totalSales : 0}" /> <small>円</small>
            </span>
        </div>

        <form action="AdminMenuServlet" method="get" style="margin:0;">
            <button type="submit" class="btn-back">管理者メニューへ戻る</button>
        </form>
    </div>

</body>
</html>