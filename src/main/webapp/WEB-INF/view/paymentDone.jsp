<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>決済完了</title>
    <style>
        /* レジ画面と統一したベージュ背景 */
        body {
            margin: 0;
            padding: 0;
            font-family: "Hiragino Kaku Gothic ProN", "Meiryo", sans-serif;
            background-color: #f2ede4; 
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            user-select: none;
            color: #5d5046; /* 茶系の文字色 */
        }

        /* ポップアップカード（座席カードと同じオフホワイト） */
        .result-card {
            background-color: #fffaf5;
            width: 500px;
            padding: 40px;
            border-radius: 8px; /* 角丸を少し抑えて統一 */
            box-shadow: 0 10px 30px rgba(93, 80, 70, 0.2);
            border: 1px solid #dcd3c7;
            text-align: center;
            animation: popin 0.3s ease-out;
        }

        @keyframes popin {
            0% { transform: scale(0.9); opacity: 0; }
            100% { transform: scale(1); opacity: 1; }
        }

        h2 {
            color: #5d5046;
            font-size: 28px;
            margin-top: 0;
            border-bottom: 2px solid #dcd3c7;
            padding-bottom: 15px;
            font-weight: bold;
        }

        .label {
            font-size: 18px;
            color: #9e938a;
            margin-top: 25px;
        }

        /* お釣り金額（重要情報なので少し濃い茶色で強調） */
        .change-amount {
            font-size: 64px;
            font-weight: bold;
            color: #6b5443; 
            margin: 10px 0 30px 0;
        }
        .currency {
            font-size: 24px;
            margin-left: 10px;
        }

        /* 戻るボタン（レジ画面のボタン色と統一） */
        .btn-home {
            display: inline-block;
            background-color: #6b5443;
            color: white;
            text-decoration: none;
            font-size: 22px;
            font-weight: bold;
            padding: 20px 0;
            width: 100%;
            border-radius: 4px;
            transition: background-color 0.2s;
            box-shadow: 0 2px 4px rgba(0,0,0,0.2);
        }

        .btn-home:active {
            background-color: #4a3a2e;
            transform: scale(0.98);
            box-shadow: none;
        }

    </style>
</head>
<body>

    <div class="result-card">
        <h2>決済完了</h2>
        
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