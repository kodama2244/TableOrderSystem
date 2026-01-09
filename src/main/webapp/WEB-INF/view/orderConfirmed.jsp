<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>注文確定画面</title>
<style>
    /* 全画面設定 */
    body {
        margin: 0;
        padding: 0;
        font-family: "Hiragino Kaku Gothic ProN", "Meiryo", sans-serif;
        background-color: white;
        height: 100vh;
        width: 100vw;
        
        /* Flexboxで上下左右中央揃え */
        display: flex;
        flex-direction: column;
        justify-content: center;
        align-items: center;
        text-align: center;
        
        color: #444;
        cursor: pointer; /* タップできることをカーソルで示唆 */
        user-select: none; /* テキスト選択を防ぎ、アプリっぽくする */
    }

    /* タイトル「注文確定」 */
    h1 {
        font-size: 48px;
        font-weight: bold;
        margin: 0 0 40px 0;
        color: #333;
    }

    /* メッセージ本文 */
    p {
        font-size: 32px;
        margin: 10px 0;
        color: #555;
    }
    
    /* 下部に表示するガイドメッセージ */
    .tap-guide {
        margin-top: 80px;
        font-size: 18px;
        color: #999;
        animation: blink 2s infinite; /* ゆっくり点滅させる */
    }
    
    @keyframes blink {
        0%, 100% { opacity: 1; }
        50% { opacity: 0.5; }
    }

</style>
</head>
<body onclick="location.href='MenuServlet'">

    <h1>注文確定</h1>
    
    <p>注文完了しました！</p>
    <p>ご注文ありがとうございました。</p>

    <div class="tap-guide">画面をタップしてメニューへ戻る</div>

</body>
</html>