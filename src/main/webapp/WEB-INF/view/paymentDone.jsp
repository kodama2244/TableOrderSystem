<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>決済完了</title>

</head>
<body>

    <div class="result-box">
        <h2>決済が完了しました</h2>
        <p>お預かり金額から計算した結果：</p>
        <p>お釣り</p>
        <div class="change-amount">
            <c:out value="${change}" /> 円
        </div>

        <a href="${pageContext.request.contextPath}/TableListServlet" class="btn-home">
            座席一覧へ戻る
        </a>
    </div>

</body>
</html>