<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>決済完了</title>
    <style>
        body { font-family: sans-serif; text-align: center; padding-top: 50px; }
        .result-box { 
            display: inline-block; 
            padding: 30px; 
            border: 2px solid #4CAF50; 
            border-radius: 10px; 
            background-color: #f9fff9;
        }
        .change-amount { font-size: 2em; color: #d32f2f; font-weight: bold; }
        .btn-home { 
            margin-top: 20px; 
            padding: 10px 20px; 
            background-color: #4CAF50; 
            color: white; 
            border: none; 
            cursor: pointer; 
            text-decoration: none;
            display: inline-block;
        }
    </style>
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