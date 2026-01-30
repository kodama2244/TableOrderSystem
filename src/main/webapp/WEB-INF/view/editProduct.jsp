<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>メニュー編集</title>
<style>
    /* 全体の背景：薄いグレー */
    body {
        margin: 0;
        padding: 0;
        background-color: #f5f5f5;
        font-family: "Helvetica Neue", Arial, "Hiragino Kaku Gothic ProN", "Hiragino Sans", Meiryo, sans-serif;
        color: #333;
    }

    /* ダークグレーのトップバー */
    .top-bar {
        background-color: #333;
        color: white;
        padding: 15px 25px;
        display: flex;
        align-items: center;
        font-weight: bold;
        font-size: 18px;
    }
    .top-bar a {
        color: white;
        text-decoration: none;
        margin-right: 15px;
        font-size: 24px;
    }

    /* メインコンテンツエリア */
    .container {
        display: flex;
        justify-content: center;
        padding: 40px 20px;
    }

    /* 白いカード：メニュー管理のスタイルに合わせる */
    .edit-card {
        background-color: white;
        width: 100%;
        max-width: 600px;
        padding: 30px;
        border-radius: 12px;
        box-shadow: 0 4px 15px rgba(0,0,0,0.05);
    }

    h2 {
        margin-top: 0;
        padding-bottom: 15px;
        border-bottom: 2px solid #eee;
        font-size: 20px;
        color: #444;
    }

    .form-group {
        margin-bottom: 20px;
    }

    label {
        display: block;
        font-weight: bold;
        margin-bottom: 8px;
        font-size: 14px;
        color: #555;
    }

    /* 入力フィールドのスタイル */
    input[type="text"],
    input[type="number"],
    select,
    textarea {
        width: 100%;
        padding: 12px;
        border: 1px solid #ddd;
        border-radius: 6px;
        box-sizing: border-box;
        font-size: 15px;
        background-color: #fff;
    }

    input:focus, select:focus, textarea:focus {
        outline: none;
        border-color: #5c93bb;
    }

    /* 画像プレビュー */
    .image-preview {
        margin: 10px 0;
        padding: 10px;
        background-color: #f9f9f9;
        border-radius: 8px;
        text-align: center;
    }
    .image-preview img {
        border-radius: 6px;
        max-height: 200px;
        box-shadow: 0 2px 5px rgba(0,0,0,0.1);
    }

    /* ボタンエリア */
    .button-group {
        display: flex;
        gap: 15px;
        margin-top: 30px;
    }

    .btn-submit {
        flex: 2;
        padding: 14px;
        background-color: #5c93bb; /* 管理画面の「編集」ボタンに近い青 */
        color: white;
        border: none;
        border-radius: 6px;
        font-size: 16px;
        font-weight: bold;
        cursor: pointer;
        transition: background 0.2s;
    }
    .btn-submit:hover { background-color: #4a7a9d; }

    .btn-cancel {
        flex: 1;
        padding: 14px;
        background-color: #f5f5f5;
        color: #666;
        text-align: center;
        text-decoration: none;
        border-radius: 6px;
        font-size: 14px;
        display: flex;
        align-items: center;
        justify-content: center;
        border: 1px solid #ddd;
    }
    .btn-cancel:hover { background-color: #eee; }

    .msg { padding: 10px; border-radius: 4px; margin-bottom: 20px; text-align: center; font-size: 14px; }
</style>
</head>
<body>

    <div class="top-bar">
        <a href="MenuManagementServlet">←</a>
        メニュー編集
    </div>

    <div class="container">
        <div class="edit-card">
            <h2>商品情報の変更</h2>

            <c:if test="${not empty message}"><div class="msg" style="background:#e8f5e9; color:#2e7d32;">${message}</div></c:if>
            <c:if test="${not empty error}"><div class="msg" style="background:#ffebee; color:#c62828;">${error}</div></c:if>

            <form action="EditProductServlet" method="post" enctype="multipart/form-data">
                
                <div class="form-group">
                    <label>商品ID</label>
                    <input type="text" name="productId" value="${product.productId}" readonly style="background-color: #f0f0f0; color: #888;">
                </div>

                <div class="form-group">
                    <label>商品名</label>
                    <input type="text" name="productName" value="${product.productName}" placeholder="例：明太うどん" required>
                </div>

                <div class="form-group">
                    <label>価格 (円)</label>
                    <input type="number" name="productPrice" value="${product.productPrice}" required>
                </div>

                <div class="form-group">
                    <label>現在の画像</label>
                    <div class="image-preview">
                        <c:if test="${not empty product.productImage}">
                            <img src='assets/img/${product.productImage}' alt="商品画像">
                        </c:if>
                        <c:if test="${empty product.productImage}">
                            <p style="color:#999; font-size:12px;">画像が設定されていません</p>
                        </c:if>
                    </div>
                    <label style="margin-top:10px;">画像を差し替える</label>
                    <input type="file" name="image" accept="image/*">
                </div>

                <div class="form-group">
                    <label>カテゴリー</label>
                    <select name="categoryId" required>
                        <option value="1" ${product.category == 1 ? "selected" : ""}>そば</option>
                        <option value="2" ${product.category == 2 ? "selected" : ""}>うどん</option>
                        <option value="3" ${product.category == 3 ? "selected" : ""}>丼もの</option>
                        <option value="4" ${product.category == 4 ? "selected" : ""}>おすすめ</option>
                        <option value="5" ${product.category == 5 ? "selected" : ""}>サイド</option>
                        <option value="6" ${product.category == 6 ? "selected" : ""}>飲み物</option>
                    </select>
                </div>

                <div class="form-group">
                    <label>商品説明</label>
                    <textarea name="productDescription" rows="4">${product.productDescription}</textarea>
                </div>

                <div class="form-group">
                    <label>アレルギー情報</label>
                    <textarea name="productAllergy" rows="2">${product.productAllergy}</textarea>
                </div>

                <div class="button-group">
                    <a href="MenuManagementServlet" class="btn-cancel">キャンセル</a>
                    <input type="submit" value="更新を保存する" class="btn-submit">
                </div>
            </form>
        </div>
    </div>

</body>
</html>