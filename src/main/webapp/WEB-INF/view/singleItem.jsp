<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>メニュー単品表示</title>
<style>
    /* 全画面・枠なし設定 */
    body {
        margin: 0;
        padding: 0;
        font-family: "Hiragino Kaku Gothic ProN", "Meiryo", sans-serif;
        background-color: #ffffff;
        color: #333;
        height: 100vh;
        box-sizing: border-box;
        display: flex;
        justify-content: center;
        align-items: center;
    }

    /* メインレイアウト（左右2カラム） */
    .container {
        width: 100%;
        height: 100%;
        padding: 20px;
        box-sizing: border-box;
        display: grid;
        grid-template-columns: 1.2fr 1fr; /* 画像エリアを少し広く */
        gap: 30px;
    }

    /* --- 左側エリア（画像、価格、オプション、戻る） --- */
    .left-panel {
        display: flex;
        flex-direction: column;
        gap: 15px;
        height: 100%;
    }

    /* 商品画像エリア */
    .image-container {
        flex: 1; /* 余ったスペースを全て使う */
        background-color: #e0e0e0;
        border-radius: 10px;
        display: flex;
        justify-content: center;
        align-items: center;
        overflow: hidden;
    }

    .image-container img {
        max-width: 90%;
        max-height: 90%;
        object-fit: contain;
    }

    /* 価格表示ボックス */
    .price-box {
        border: 2px solid #333;
        padding: 15px;
        font-size: 28px;
        text-align: center;
        font-weight: bold;
        border-radius: 5px;
    }

    /* オプション表示エリア */
    .options-wrapper {
        display: flex;
        gap: 10px;
    }
    
    .option-card {
        background-color: #444;
        color: white;
        padding: 10px;
        border-radius: 5px;
        text-align: center;
        flex: 1;
        font-size: 14px;
    }
    .option-price {
        background-color: white;
        color: #333;
        margin-top: 5px;
        padding: 2px;
        border-radius: 3px;
        font-weight: bold;
    }

    /* 戻るボタン */
    .back-btn {
        background-color: #444;
        color: white;
        border: none;
        padding: 20px;
        font-size: 20px;
        font-weight: bold;
        border-radius: 5px;
        cursor: pointer;
        width: 100%;
    }

    /* --- 右側エリア（商品名、説明、数量、カート） --- */
    .right-panel {
        display: flex;
        flex-direction: column;
        gap: 20px;
    }

    /* 商品名 */
    .product-title {
        border: 2px solid #333;
        padding: 20px;
        font-size: 32px;
        text-align: center;
        font-weight: bold;
        border-radius: 5px;
    }

    /* 商品説明ボックス */
    .description-box {
        border: 2px solid #333;
        padding: 20px;
        font-size: 16px;
        line-height: 1.6;
        border-radius: 5px;
        flex-grow: 1; /* 縦に伸ばす */
        overflow-y: auto;
    }

    /* 数量選択エリア */
    .quantity-control {
        display: flex;
        align-items: center;
        justify-content: flex-end; /* 右寄せ */
        gap: 10px;
    }

    .qty-btn {
        background-color: #444;
        color: white;
        border: none;
        width: 60px;
        height: 60px;
        font-size: 30px;
        border-radius: 5px;
        cursor: pointer;
        display: flex;
        justify-content: center;
        align-items: center;
    }

    /* 数量表示（inputタグだが読み取り専用） */
    .qty-input {
        width: 80px;
        height: 60px;
        font-size: 30px;
        text-align: center;
        border: 2px solid #333;
        border-radius: 5px;
    }

    /* カートに入れるボタン */
    .cart-btn {
        background-color: #444;
        color: white;
        border: none;
        padding: 30px;
        font-size: 28px;
        font-weight: bold;
        border-radius: 5px;
        cursor: pointer;
        width: 100%;
    }

    .cart-btn:active, .back-btn:active, .qty-btn:active {
        background-color: #222;
        transform: scale(0.98);
    }
    
    /* エラーメッセージ等 */
    .msg-area {
        color: red;
        text-align: center;
    }

</style>
</head>
<body>

<div class="container">
    
    <div class="left-panel">
        <div class="image-container">
            <img src="assets/img/${sivm.productImage}" alt="商品画像">
        </div>

        <div class="price-box">
            ${sivm.productPrice}円
        </div>

        <div class="options-wrapper">
            <div class="option-card">
                <div>${sivm.optionName}</div>
                <div class="option-price">+${sivm.optionPrice}円</div>
            </div>
            </div>

        <button type="button" class="back-btn" onclick="history.back()">戻る</button>
    </div>


    <div class="right-panel">
        
        <div class="product-title">
            ${sivm.productName}
        </div>

        <div class="description-box">
            <p><strong>【商品説明】</strong><br>
            ${sivm.productDescription}</p>
            <br>
            <p><strong>【アレルギー情報】</strong><br>
            ${sivm.productAllergy}</p>
        </div>

        <form action="CartServlet" method="post" style="display: contents;">
            
            <div class="quantity-control">
                <button type="button" class="qty-btn" onclick="changeQty(-1)">←</button>
                <input type="text" name="quantity" id="quantityInput" class="qty-input" value="1" readonly>
                <button type="button" class="qty-btn" onclick="changeQty(1)">→</button>
            </div>

            <input type="hidden" name="productId" value="${sivm.productId}">
            <input type="hidden" name="productName" value="${sivm.productName}"> 
            <input type="hidden" name="productPrice" value="${sivm.productPrice}">
            <input type="hidden" name="optionName" value="${sivm.optionName}">
            <input type="hidden" name="optionPrice" value="${sivm.optionPrice}">
            <input type="hidden" name="category" value="${category}">
            <input type="hidden" name="optionId" value="${sivm.optionId}">

            <input type="submit" value="カートに入れる" class="cart-btn">
        </form>

        <c:if test="${not empty msg}">
            <p class="msg-area">${msg}</p>
        </c:if>
    </div>

</div>

<script>
    // 数量を変更する関数
    function changeQty(amount) {
        var qtyInput = document.getElementById("quantityInput");
        var currentQty = parseInt(qtyInput.value);
        var newQty = currentQty + amount;

        // 最小値は1、最大値は（仮で）10に設定
        if (newQty >= 1 && newQty <= 10) {
            qtyInput.value = newQty;
        }
    }
</script>

</body>
</html>