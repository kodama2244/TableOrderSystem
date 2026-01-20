<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>管理者メニュー</title>
    <style>
        body {
            margin: 0;
            padding: 0;
            font-family: "Hiragino Kaku Gothic ProN", "Meiryo", sans-serif;
            background-color: #f4f4f4;
            display: flex;
            flex-direction: column;
            height: 100vh;
        }

        header {
            background-color: #333;
            color: white;
            padding: 20px 30px;
            text-align: center;
            box-shadow: 0 2px 5px rgba(0,0,0,0.2);
        }

        .container {
            flex-grow: 1;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 40px;
        }

        /* タイル状のメニューレイアウト */
        .menu-grid {
            display: grid;
            grid-template-columns: repeat(2, 300px);
            grid-template-rows: repeat(2, 200px);
            gap: 30px;
        }

        .menu-item {
            background-color: white;
            border-radius: 15px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.1);
            text-decoration: none;
            color: #333;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            transition: all 0.3s ease;
            border: 2px solid transparent;
        }

        .menu-item:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 25px rgba(0,0,0,0.2);
            border-color: #333; /* モノトーンに合わせて黒に */
        }

        .menu-item:active {
            transform: scale(0.95);
        }

        .icon {
            font-size: 50px;
            margin-bottom: 15px;
        }

        .label {
            font-size: 22px;
            font-weight: bold;
        }

        .desc {
            font-size: 14px;
            color: #777;
            margin-top: 8px;
        }

        /* ログアウトボタン */
        .footer {
            padding: 30px;
            text-align: center;
        }

        .btn-logout {
            background-color: #555;
            color: white;
            text-decoration: none;
            padding: 12px 40px;
            border-radius: 5px;
            font-weight: bold;
            transition: background-color 0.2s;
        }

        .btn-logout:hover {
            background-color: #d9534f;
        }
    </style>
</head>
<body>

<header>
    <h1>管理者用メインメニュー</h1>
</header>

<div class="container">
    <div class="menu-grid">
        <a href="${pageContext.request.contextPath}/StoreSalesServlet" class="menu-item">
            <span class="icon">📈</span>
            <span class="label">売上管理</span>
            <span class="desc">日次売上の確認・集計</span>
        </a>

        <a href="${pageContext.request.contextPath}/MenuManagementServlet" class="menu-item">
            <span class="icon">🍴</span>
            <span class="label">メニュー管理</span>
            <span class="desc">商品の追加・削除・編集</span>
        </a>

        <a href="${pageContext.request.contextPath}/AdminRegisterServlet" class="menu-item">
            <span class="icon">👤</span>
            <span class="label">スタッフ管理</span>
            <span class="desc">新規管理者の登録・追加</span>
        </a>

        <a href="#" class="menu-item" style="opacity: 0.6; cursor: not-allowed;">
            <span class="icon">⚙️</span>
            <span class="label">システム設定</span>
            <span class="desc">準備中</span>
        </a>
    </div>
</div>

<div class="footer">
    <a href="${pageContext.request.contextPath}/AdminLoginServlet" class="btn-logout">ログアウト（終了）</a>
</div>

</body>
</html>