<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>本日はご来店ありがとうございました</title>
<style>
    /* 全画面設定（枠なし・フルスクリーン） */
    body {
        margin: 0;
        padding: 0;
        font-family: "Hiragino Kaku Gothic ProN", "Meiryo", sans-serif;
        background-color: white;
        height: 100vh;
        width: 100vw;
        
        /* 中央揃え */
        display: flex;
        flex-direction: column;
        justify-content: center;
        align-items: center;
        text-align: center;
        
        color: #333;
        cursor: pointer;
        user-select: none; /* 誤操作によるテキスト選択を防止 */
    }

    /* メッセージ本文（通常） */
    h1 {
        font-size: 42px;
        font-weight: normal;
        margin-bottom: 60px;
    }

    /* 強調メッセージ（赤字部分） */
    .highlight-text {
        color: #FF5A5F; /* 画像に近い赤色 */
        font-size: 56px;
        font-weight: bold;
        margin: 20px 0;
    }

    /* タップガイド */
    .tap-guide {
        margin-top: 100px;
        font-size: 20px;
        color: #bbb;
        animation: fade 2.5s infinite;
    }

    @keyframes fade {
        0%, 100% { opacity: 1; }
        50% { opacity: 0.3; }
    }
</style>
</head>
<body onclick="location.href='welcom'">

    <h1>本日はご来店ありがとうございました</h1>

    <div class="highlight-text">
        バインダーをレジに持っていってください
    </div>

    <div class="tap-guide">画面をタップして終了する</div>

</body>
</html>