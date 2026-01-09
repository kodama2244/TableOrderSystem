<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>いらっしゃいませ画面</title>
<style>
    /* 画面全体の設定 */
    body {
        margin: 0;
        padding: 0;
        width: 100%;
        height: 100vh; /* 画面の高さいっぱいに広げる */
        display: flex;       /* フレックスボックスを使用 */
        flex-direction: column; /* 要素を縦に並べる */
        justify-content: center; /* 上下中央揃え */
        align-items: center;     /* 左右中央揃え */
        font-family: "Hiragino Kaku Gothic ProN", "Meiryo", sans-serif; /* 見やすいフォント */
        background-color: #ffffff;
        cursor: pointer; /* マウスカーソルを指マークにする */
        user-select: none; /* テキスト選択を防ぎ、アプリっぽくする */
    }

    /* 「〜いらっしゃいませ〜」のスタイル */
    .title-text {
        font-size: 32px;
        color: #444;       /* 濃いグレー */
        margin-bottom: 80px; /* 下のテキストとの間隔 */
        letter-spacing: 2px;
    }

    /* 「画面をタップしてください」のスタイル */
    .instruction-text {
        font-size: 24px;
        color: #666;       /* 少し薄いグレー */
    }

    /* フォーム自体は画面に見えなくて良いので隠す */
    #hiddenForm {
        display: none;
    }
</style>
</head>
<body>

    <div class="title-text">～いらっしゃいませ～</div>
    <div class="instruction-text">画面をタップしてください</div>

    <form action="NumberCustomersServlet" method="get" id="hiddenForm">
        </form>

<script>
    // 画面全体（body）のどこかがクリック/タップされたら実行される処理
    document.body.addEventListener('click', function() {
        // IDを指定してフォームを取得し、送信(submit)する
        document.getElementById('hiddenForm').submit();
    });
</script>

</body>
</html>