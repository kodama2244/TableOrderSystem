<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>レジ座席一覧画面</title>
    <style>
        /* --- 全体の基本設定 --- */
        body {
            margin: 0;
            padding: 0;
            font-family: "Hiragino Kaku Gothic ProN", "Meiryo", sans-serif;
            background-color: #f4f4f4;
            color: #333;
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
            flex-shrink: 0;
        }

        h2 { margin: 0; font-size: 24px; }

        /* --- 座席グリッドエリア --- */
        .table-grid {
            flex-grow: 1;
            padding: 30px;
            display: grid;
            /* 1行に4列、等幅で配置 */
            grid-template-columns: repeat(4, 1fr);
            gap: 20px;
            overflow-y: auto;
            align-content: start;
        }

        /* 各座席カードの基本スタイル */
        .table-card {
            background-color: white;
            border-radius: 12px;
            box-shadow: 0 4px 6px rgba(0,0,0,0.1);
            height: 200px;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            text-align: center;
            transition: transform 0.1s;
            position: relative;
            padding: 20px;
            box-sizing: border-box;
        }

        .table-number {
            font-size: 32px;
            font-weight: bold;
            margin-bottom: 15px;
        }

        /* ステータス：案内可（空席） */
        .status-vacant {
            color: #bbb;
            font-size: 20px;
            font-weight: bold;
        }

        /* お会計ボタン（お客様あり） */
        .bill-form {
            width: 100%;
            margin-top: 10px;
        }

        .btn-bill {
            width: 100%;
            padding: 20px 0;
            background-color: #444;
            color: white;
            border: none;
            border-radius: 8px;
            font-size: 22px;
            font-weight: bold;
            cursor: pointer;
            transition: background-color 0.2s;
        }

        .btn-bill:active {
            background-color: #000;
            transform: scale(0.95);
        }

        /* お客様がいる場合のカード強調（任意で枠線をつけるなど） */
        .table-card.has-customer {
            border: 2px solid #444;
            background-color: #fff;
        }

    </style>
</head>
<body>

<header>
    <h2>座席一覧・お会計選択</h2>
    <div id="clock"></div>
</header>

<div class="table-grid">
    <c:forEach var="table" items="${ viewModel.tableList }">
        <div class="table-card ${ table.hasCustomer ? 'has-customer' : '' }">
            
            <div class="table-number">${ table.tableNumber }卓</div>

            <c:choose>
                <c:when test="${ table.hasCustomer }">
                    <form action="${pageContext.request.contextPath}/TableBillServlet" method="get" class="bill-form">
                        <input type="hidden" name="tableNumber" value="${ table.tableNumber }">
                        <button type="submit" class="btn-bill">お会計</button>
                    </form>
                </c:when>

                <c:otherwise>
                    <div class="status-vacant">案内可</div>
                </c:otherwise>
            </c:choose>

        </div>
    </c:forEach>
</div>

<script>
    // 時計機能
    function updateClock() {
        const now = new Date();
        document.getElementById('clock').textContent = 
            now.getHours() + ':' + String(now.getMinutes()).padStart(2, '0');
    }
    setInterval(updateClock, 1000);
    updateClock();
</script>

</body>
</html>	