<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>メニュー管理</title>
<style>
    body {
        margin: 0;
        font-family: "Hiragino Kaku Gothic ProN", "Meiryo", sans-serif;
        background-color: #f4f4f4;
        color: #333;
        display: flex;
        flex-direction: column;
        height: 100vh;
    }

    /* --- ヘッダー（戻るボタン追加） --- */
    header {
        background-color: #333;
        color: white;
        padding: 10px 30px;
        flex-shrink: 0;
        display: flex;
        align-items: center;
        justify-content: space-between;
    }

    .header-left {
        display: flex;
        align-items: center;
        gap: 20px;
    }

    .btn-header-back {
        color: white;
        text-decoration: none;
        font-size: 28px;
        font-weight: bold;
        width: 40px;
        height: 40px;
        display: flex;
        justify-content: center;
        align-items: center;
        border-radius: 50%;
        transition: background 0.2s;
    }

    .btn-header-back:hover {
        background-color: rgba(255,255,255,0.2);
    }

    .main-container {
        display: flex;
        flex-grow: 1;
        overflow: hidden;
        padding: 20px;
        gap: 20px;
    }

    /* --- 左側：追加フォーム --- */
    .form-section {
        flex: 0 0 350px;
        background: white;
        padding: 20px;
        border-radius: 8px;
        box-shadow: 0 2px 5px rgba(0,0,0,0.1);
        overflow-y: auto;
    }

    .form-section h2 {
        font-size: 20px;
        border-bottom: 2px solid #333;
        padding-bottom: 10px;
        margin-top: 0;
    }

    .input-group { margin-bottom: 15px; }
    .input-group label { display: block; font-weight: bold; margin-bottom: 5px; font-size: 14px; }
    .input-group input[type="text"], 
    .input-group select, 
    .input-group textarea {
        width: 100%;
        padding: 8px;
        border: 1px solid #ccc;
        border-radius: 4px;
        box-sizing: border-box;
    }

    .btn-add {
        width: 100%;
        padding: 12px;
        background-color: #333;
        color: white;
        border: none;
        border-radius: 4px;
        font-weight: bold;
        cursor: pointer;
        margin-top: 10px;
    }

    /* --- 右側：一覧エリア --- */
    .list-section {
        flex-grow: 1;
        background: white;
        padding: 20px;
        border-radius: 8px;
        box-shadow: 0 2px 5px rgba(0,0,0,0.1);
        display: flex;
        flex-direction: column;
    }

    .category-nav {
        display: flex;
        gap: 5px;
        margin-bottom: 15px;
        flex-wrap: wrap;
    }

    .btn-cat {
        padding: 8px 15px;
        border: 1px solid #333;
        background: white;
        cursor: pointer;
        font-weight: bold;
        border-radius: 4px;
    }
    .btn-cat:hover { background: #eee; }

    .table-container {
        flex-grow: 1;
        overflow-y: auto;
        border: 1px solid #eee;
    }

    table {
        width: 100%;
        border-collapse: collapse;
        table-layout: fixed;
    }

    th {
        position: sticky;
        top: 0;
        background: #eee;
        z-index: 10;
        padding: 10px;
        border-bottom: 2px solid #333;
        text-align: left;
    }

    td {
        padding: 10px;
        border-bottom: 1px solid #eee;
        vertical-align: middle;
        font-size: 14px;
    }

    .img-cell img {
        width: 60px;
        height: 60px;
        object-fit: cover;
        border-radius: 4px;
    }

    .btn-edit { background-color: #4A90E2; color: white; border: none; padding: 8px 12px; border-radius: 3px; cursor: pointer; }
    .btn-del { background-color: #d9534f; color: white; border: none; padding: 8px 12px; border-radius: 3px; cursor: pointer; }

    .msg { color: #d9534f; font-weight: bold; margin-bottom: 10px; }
</style>
</head>
<body>

<header>
    <div class="header-left">
        <a href="${pageContext.request.contextPath}/AdminMenuServlet" class="btn-header-back" title="管理メニューへ戻る">←</a>
        <h1 style="margin: 0; font-size: 22px;">メニュー管理（追加・削除・編集）</h1>
    </div>
</header>

<div class="main-container">
    <div class="form-section">
        <h2>メニュー追加</h2>
        <c:if test="${not empty error}"><p class="msg">${error}</p></c:if>
        
        <form action="MenuManagementServlet" method="post" enctype="multipart/form-data">
            <div class="input-group">
                <label>商品ID</label>
                <input type="text" name="productId" placeholder="例: 00000001">
            </div>
            <div class="input-group">
                <label>商品名</label>
                <input type="text" name="productName" placeholder="例: ○○うどん">
            </div>
            <div class="input-group">
                <label>価格</label>
                <input type="text" name="productPrice" placeholder="例: 700">
            </div>
            <div class="input-group">
                <label>カテゴリー</label>
                <select name="categoryId">
                    <option value="1">そば</option>
                    <option value="2">うどん</option>
                    <option value="3">丼もの</option>
                    <option value="4">おすすめ</option>
                    <option value="5">サイドメニュー</option>
                    <option value="6">飲み物</option>
                </select>
            </div>
            <div class="input-group">
                <label>画像</label>
                <input type="file" name="image" accept="image/*" required>
            </div>
            <div class="input-group">
                <label>商品説明</label>
                <textarea name="productDescription" rows="4"></textarea>
            </div>
            <div class="input-group">
                <label>アレルギー情報</label>
                <textarea name="productAllergy" rows="2"></textarea>
            </div>
            <button type="submit" class="btn-add">新規メニューを追加</button>
        </form>
    </div>

    <div class="list-section">
        <div class="category-nav">
            <form action="MenuManagementServlet" method="get" style="display:contents;">
                <button type="submit" name="category" value="1" class="btn-cat">そば</button>
                <button type="submit" name="category" value="2" class="btn-cat">うどん</button>
                <button type="submit" name="category" value="3" class="btn-cat">丼もの</button>
                <button type="submit" name="category" value="4" class="btn-cat">おすすめ</button>
                <button type="submit" name="category" value="5" class="btn-cat">サイド</button>
                <button type="submit" name="category" value="6" class="btn-cat">飲み物</button>
            </form>
        </div>

        <div class="table-container">
            <table>
                <thead>
                    <tr>
                        <th style="width: 80px;">画像</th>
                        <th>商品名 / ID</th>
                        <th style="width: 100px;">価格</th>
                        <th style="width: 160px;">操作</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="list" items="${mvm.products}">
                        <tr>
                            <td class="img-cell">
                                <img src='assets/img/${list.productImage}' alt="画像">
                            </td>
                            <td>
                                <strong>${list.productName}</strong><br>
                                <small style="color:#666;">ID: ${list.productId}</small>
                            </td>
                            <td>${list.productPrice}円</td>
                            <td>
                                <div style="display: flex; gap: 8px;">
                                    <form action="EditProductServlet" method="get">
                                        <button type="submit" name="id" value="${list.productId}" class="btn-edit">編集</button>
                                    </form>
                                    <form action="MenuManagementServlet" method="post">
                                        <input type="hidden" name="action" value="delete">
                                        <button type="submit" name="id" value="${list.productId}" class="btn-del" onclick="return confirm('本当に削除しますか？')">削除</button>
                                    </form>
                                </div>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</div>

</body>
</html>