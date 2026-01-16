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
        grid-template-columns: 1.2fr 1fr;
        gap: 30px;
    }

    .left-panel {
        display: flex;
        flex-direction: column;
        gap: 15px;
        height: 100%;
    }

    .image-container {
        flex: 1;
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
        min-height: 80px;
    }
    
    .option-card {
        background-color: #eee;
        color: #333;
        border: 2px solid #333;
        padding: 10px;
        border-radius: 5px;
        text-align: center;
        flex: 1;
        font-size: 16px;
        cursor: pointer;
        transition: 0.2s;
    }

    /* 選択された時のスタイル */
    .option-card.selected {
        background-color: #444;
        color: white;
    }

    .option-price {
        background-color: white;
        color: #333;
        margin-top: 5px;
        padding: 2px;
        border-radius: 3px;
        font-weight: bold;
        font-size: 14px;
    }

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

    .right-panel {
        display: flex;
        flex-direction: column;
        gap: 20px;
    }

    .product-title {
        border: 2px solid #333;
        padding: 20px;
        font-size: 32px;
        text-align: center;
        font-weight: bold;
        border-radius: 5px;
    }

    .description-box {
        border: 2px solid #333;
        padding: 20px;
        font-size: 16px;
        line-height: 1.6;
        border-radius: 5px;
        flex-grow: 1;
        overflow-y: auto;
    }

    .quantity-control {
        display: flex;
        align-items: center;
        justify-content: flex-end;
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

    .qty-input {
        width: 80px;
        height: 60px;
        font-size: 30px;
        text-align: center;
        border: 2px solid #333;
        border-radius: 5px;
    }

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
            <%-- 大盛オプション(ID:1)がある場合のみ選択パネルを表示 --%>
            <c:if test="${sivm.optionId == 1}">
                <div id="optionPanel" class="option-card" onclick="toggleOption()">
                    <div><strong>${sivm.optionName}</strong>にする</div>
                    <div class="option-price">+${sivm.optionPrice}円</div>
                </div>
            </c:if>
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

            <%-- カートに送る基本情報 --%>
            <input type="hidden" name="productId" value="${sivm.productId}">
            <input type="hidden" name="productName" value="${sivm.productName}"> 
            <input type="hidden" name="productPrice" value="${sivm.productPrice}">
            <input type="hidden" name="category" value="${category}">

            <%-- オプション情報（初期値は「なし」の0） --%>
            <input type="hidden" name="optionId" id="h_optionId" value="0">
            <input type="hidden" name="optionName" id="h_optionName" value="">
            <input type="hidden" name="optionPrice" id="h_optionPrice" value="0">

            <input type="submit" value="カートに入れる" class="cart-btn">
        </form>

        <c:if test="${not empty msg}">
            <p class="msg-area">${msg}</p>
        </c:if>
    </div>

</div>

<script>
    let isOptionSelected = false;

    // オプションの選択状態を切り替える関数
    function toggleOption() {
        const panel = document.getElementById("optionPanel");
        const hId = document.getElementById("h_optionId");
        const hName = document.getElementById("h_optionName");
        const hPrice = document.getElementById("h_optionPrice");

        isOptionSelected = !isOptionSelected;

        if (isOptionSelected) {
            panel.classList.add("selected");
            hId.value = "${sivm.optionId}";
            hName.value = "${sivm.optionName}";
            hPrice.value = "${sivm.optionPrice}";
        } else {
            panel.classList.remove("selected");
            hId.value = "0";
            hName.value = "";
            hPrice.value = "0";
        }
    }

    function changeQty(amount) {
        var qtyInput = document.getElementById("quantityInput");
        var currentQty = parseInt(qtyInput.value);
        var newQty = currentQty + amount;

        if (newQty >= 1 && newQty <= 10) {
            qtyInput.value = newQty;
        }
    }
</script>

</body>
</html>