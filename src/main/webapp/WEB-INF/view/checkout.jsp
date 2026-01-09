<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>お会計画面</title>
<style>
    /* --- 全体の基本設定 (枠なし・フルスクリーン) --- */
    body {
        margin: 0;
        padding: 0;
        font-family: "Hiragino Kaku Gothic ProN", "Meiryo", sans-serif;
        background-color: white;
        color: #333;
        height: 100vh;
        width: 100vw;
        display: flex;
        flex-direction: column;
        justify-content: center;
        align-items: center;
        box-sizing: border-box;
    }

    /* タイトル */
    h1 {
        font-size: 48px;
        font-weight: bold;
        margin-bottom: 60px;
    }

    /* 合計金額表示エリア */
    .amount-display {
        width: 500px;
        height: 150px;
        border: 2px solid #333;
        display: flex;
        justify-content: center;
        align-items: center;
        font-size: 40px;
        font-weight: bold;
        margin-bottom: 80px;
        background-color: #fff;
    }

    /* ボタンコンテナ */
    .button-container {
        display: flex;
        gap: 100px; /* 戻るボタンと確定ボタンの間隔 */
        width: 100%;
        justify-content: center;
    }

    /* ボタン共通スタイル */
    .btn {
        width: 280px;
        height: 100px;
        font-size: 32px;
        font-weight: bold;
        border: none;
        border-radius: 8px;
        cursor: pointer;
        display: flex;
        justify-content: center;
        align-items: center;
        transition: transform 0.1s, opacity 0.2s;
        color: white;
    }

    /* 戻るボタン */
    .btn-back {
        background-color: #4a4a4a;
    }

    /* 確定ボタン */
    .btn-confirm {
        background-color: #4a4a4a;
        color: #ff6347; /* 確定の文字色を画像に合わせる */
    }

    .btn:active {
        transform: scale(0.95);
        opacity: 0.9;
    }

</style>
</head>
<body>

    <h1>お会計</h1>

    <div class="amount-display">
        合計金額： ${totalAmount} 円
    </div>

    <div class="button-container">
        <form action="MenuServlet" method="get">
            <button type="submit" class="btn btn-back">戻る</button>
        </form>

        <form action="CheckoutServlet" method="post">
            <button type="submit" class="btn btn-confirm">確定</button>
        </form>
    </div>

</body>
</html>