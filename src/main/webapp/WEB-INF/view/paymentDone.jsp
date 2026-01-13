<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>決済完了</title>
    <style>
        /* 全画面を薄暗い背景に */
        body {
            margin: 0;
            padding: 0;
            font-family: "Hiragino Kaku Gothic ProN", "Meiryo", sans-serif;
            background-color: #333; /* 背景を暗くしてポップアップを強調 */
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            user-select: none;
        }

        /* ポップアップカード */
        .result-card {
            background-color: white;
            width: 500px;
            padding: 40px;
            border-radius: 15px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.5);
            text-align: center;
            animation: popin 0.3s ease-out;
        }

        @keyframes popin {
            0% { transform: scale(0.9); opacity: 0; }
            100% { transform: scale(1); opacity: 1; }
        }

        h2 {
            color: #333;
            font-size: 28px;
            margin-top: 0;
            border-bottom: 2px solid #eee;
            padding-bottom: 15px;
        }

        .label {
            font-size: 18px;
            color: #666;
            margin-top: 25px;
        }

        /* お釣り金額の強調 */
        .change-amount {
            font-size: 64px;
            font-weight: bold;
            color: #4A90E2; /* レジ画面の計算結果と同じ青 */
            margin: 10px 0 30px 0;
        }
        .currency {
            font-size: 24px;
            margin-left: 10px;
        }

        /* 戻るボタン */
        .btn-home {
            display: inline-block;
            background-color: #333;
            color: white;
            text-decoration: none;
            font-size: 22px;
            font-weight: bold;
            padding: 20px 0;
            width: 100%;
            border-radius: 8px;
            transition: background-color 0.2s;
        }

        .btn-home:active {
            background-color: #555;
            transform: scale(0.98);
        }

    </style>
</head>
<body>

    <div class="result-card">
        <h2>決済が完了しました</h2>
        
        <p class="label">お釣りをお渡しください</p>
        
        <div class="change-amount">
            <c:out value="${change}" /><span class="currency">円</span>
        </div>

        <a href="${pageContext.request.contextPath}/TableListServlet" class="btn-home">
            座席一覧へ戻る
        </a>
    </div>

</body>
</html>