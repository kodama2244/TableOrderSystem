<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="refresh" content="5">
    <title>レジ座席一覧画面</title>
    <style>
        /* --- 全体の基本設定 --- */
        body {
            margin: 0;
            padding: 0;
            font-family: "Hiragino Kaku Gothic ProN", "Meiryo", sans-serif;
            background-color: #f2ede4; /* ベージュ系の背景 */
            color: #333;
            height: 100vh;
            display: flex;
            flex-direction: column;
            overflow: hidden; /* 全体はスクロールさせない */
        }

        header {
            background-color: transparent;
            color: #5d5046;
            padding: 10px 40px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-shrink: 0;
        }

        h2 { margin: 0; font-size: 24px; }
        #clock { font-size: 20px; font-weight: bold; }

        /* --- 座席グリッドエリア（画面いっぱいに広げる） --- */
        .table-grid {
            flex-grow: 1;
            padding: 10px 40px 20px 40px;
            display: grid;
            /* 1行に4つ固定。画面幅いっぱいに広がる */
            grid-template-columns: repeat(4, 1fr);
            /* 縦方向の間隔を少し狭くして、縦長感を解消 */
            grid-template-rows: repeat(4, 1fr);
            gap: 20px;
            box-sizing: border-box;
        }

        /* 各座席カードのスタイル */
        .table-card {
            background-color: #fffaf5;
            border-radius: 8px;
            box-shadow: 0 4px 10px rgba(93, 80, 70, 0.15);
            border: 1px solid #dcd3c7;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            text-align: center;
            padding: 10px;
            box-sizing: border-box;
            /* 高さが足りない場合は自動で調整されるが、基本はgrid内で均等 */
        }

        .table-number {
            font-size: 22px;
            color: #5d5046;
            margin-bottom: 5px;
        }

        /* ステータス：案内可 */
        .status-vacant {
            color: #9e938a;
            font-size: 16px;
        }

        /* お会計ボタン（画像に近いコンパクトなサイズ） */
        .bill-form {
            width: 70%;
        }

        .btn-bill {
            width: 100%;
            padding: 10px 0;
            background-color: #6b5443;
            color: white;
            border: none;
            border-radius: 4px;
            font-size: 18px;
            font-weight: bold;
            cursor: pointer;
            box-shadow: 0 2px 4px rgba(0,0,0,0.2);
        }

        .btn-bill:active {
            background-color: #4a3a2e;
            transform: scale(0.98);
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
        <div class="table-card">
            
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