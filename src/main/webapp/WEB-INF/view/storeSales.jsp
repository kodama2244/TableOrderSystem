<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>店舗売上管理</title>
</head>
<body>

    <h1>店舗売上管理</h1>

    <form action="StoreSalesServlet" method="get">
        <label for="targetDate">表示日の選択:</label>
        <input type="date" id="targetDate" name="targetDate" value="${selectedDate}">
        <button type="submit">検索</button>
    </form>

    <hr>

    <c:if test="${not empty vm}">
        <h3>対象日: ${vm.targetDate}</h3>
        <p><strong>総売上高: ${vm.totalSales}円</strong></p>

        <c:choose>
            <c:when test="${empty vm.salesList}">
                <p>この日の売上データはありません。</p>
            </c:when>
            <c:otherwise>
                <table border="1">
                    <thead>
                        <tr>
                            <th>商品名</th>
                            <th>オプション名</th>
                            <th>単価(込)</th>
                            <th>数量</th>
                            <th>小計</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="item" items="${vm.salesList}">
                            <tr>
                                <td>${item.productName}</td>
                                <td>${item.optionName}</td>
                                <td>${item.productPrice + item.optionPrice}円</td>
                                <td>${item.productQuantity}</td>
                                <td>${(item.productPrice + item.optionPrice) * item.productQuantity}円</td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </c:otherwise>
        </c:choose>
    </c:if>

    <br>
    <form action="AdminMenuServlet" method="get">
        <button type="submit">管理者メニューに戻る</button>
    </form>

</body>
</html>	