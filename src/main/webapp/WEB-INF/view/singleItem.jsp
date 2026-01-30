<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>メニュー単品表示</title>
<style>
    html, body {
        margin: 0; padding: 0; width: 100%; height: 100%;
        font-family: "Hiragino Kaku Gothic ProN", "Meiryo", sans-serif;
        background-color: #ffffff; color: #333; overflow: hidden;
        display: flex; justify-content: center; align-items: center;
    }

    .container {
        width: 90%; max-width: 1100px; height: 85vh;
        display: grid; grid-template-columns: 1fr 1fr; gap: 40px; box-sizing: border-box;
    }

    .left-panel { display: flex; flex-direction: column; gap: 15px; height: 100%; }

    .image-container {
        width: 100%; height: 350px; background-color: #f8f8f8;
        border: 2px solid #333; border-radius: 8px;
        display: flex; justify-content: center; align-items: center; overflow: hidden;
    }
    .image-container img { width: 100%; height: 100%; object-fit: contain; padding: 10px; }

    .price-box {
        border: 2px solid #333; padding: 10px; font-size: 24px;
        text-align: center; font-weight: bold; border-radius: 5px; background-color: #fff;
    }

    /* --- 右パネル --- */
    .right-panel { display: flex; flex-direction: column; gap: 20px; height: 100%; }

    .product-title { border-bottom: 2px solid #333; padding-bottom: 10px; font-size: 28px; font-weight: bold; }

    .description-box {
        border: 1px solid #ccc; padding: 15px; 
        border-radius: 5px; background-color: #fafafa; flex-grow: 1; overflow-y: auto;
    }

    .description-box strong {
        display: inline-block;
        font-family: "Hiragino Kaku Gothic ProN", "Meiryo", sans-serif;
        font-size: 14px; letter-spacing: 0.1em; color: #555;
        margin-bottom: 5px; border-bottom: 1px solid #ccc;
    }

    .description-box p {
        font-family: "Yu Mincho", "YuMincho", "Hiragino Mincho ProN", serif;
        font-size: 17px; line-height: 1.8; color: #444;
        margin-bottom: 25px; white-space: pre-wrap;
    }

    /* --- ボタンサイズを統一 --- */
    .back-btn, .cart-btn {
        width: 100%;
        box-sizing: border-box;
        background-color: #333;
        color: white;
        border: none;
        padding: 20px;
        font-size: 20px;
        font-weight: bold;
        border-radius: 5px;
        cursor: pointer;
        transition: 0.2s;
        text-align: center;
    }

    .back-btn { margin-top: auto; }
    .cart-btn { margin-top: 15px; }

    .cart-btn:hover, .back-btn:hover { background-color: #555; }
    .cart-btn:active, .back-btn:active { opacity: 0.8; transform: translateY(1px); }

    /* --- オプションチェックボタン --- */
    .option-check-wrapper { display: flex; flex-direction: column; gap: 10px; }
    .option-check-label {
        display: flex; justify-content: space-between; align-items: center;
        background-color: #eee; border: 2px solid #333; padding: 12px 20px;
        border-radius: 5px; cursor: pointer; font-size: 16px; transition: 0.2s;
    }
    .option-check-label.selected { background-color: #333; color: white; }
    .option-check-label::after { content: '□'; font-size: 20px; }
    .option-check-label.selected::after { content: '✓'; }

    /* --- 数量操作 --- */
    .quantity-control { display: flex; align-items: center; gap: 15px; justify-content: flex-end; }
    .qty-btn {
        background-color: #444; color: white; border: none;
        width: 45px; height: 45px; font-size: 20px; border-radius: 5px; cursor: pointer;
    }
    .qty-input { width: 50px; height: 45px; font-size: 20px; text-align: center; border: 1px solid #333; border-radius: 5px; }

</style>
</head>
<body>

<div class="container">
    <div class="left-panel">
        <div class="image-container">
            <img src="assets/img/${sivm.productImage}" alt="${sivm.productName}">
        </div>
        <div class="price-box">${sivm.productPrice} 円</div>
        
        <div class="option-check-wrapper">
            <c:if test="${sivm.optionId != 0}">
                <label id="optionLabel" class="option-check-label" onclick="toggleOption()">
                    <span><strong>${sivm.optionName}</strong> (+${sivm.optionPrice}円)</span>
                </label>
            </c:if>
        </div>
        <button type="button" class="back-btn" onclick="history.back()">戻る</button>
    </div>

    <div class="right-panel">
        <div class="product-title">${sivm.productName}</div>
        <div class="description-box">
            <p><strong>DESCRIPTION</strong><br>${sivm.productDescription}</p>
            <p><strong>ALLERGY INFO</strong><br>${sivm.productAllergy}</p>
        </div>

        <form action="CartServlet" method="post" style="display: flex; flex-direction: column;">
            <div class="quantity-control">
                <span style="font-weight:bold;">数量</span>
                <button type="button" class="qty-btn" onclick="changeQty(-1)">−</button>
                <input type="text" name="quantity" id="quantityInput" class="qty-input" value="1" readonly>
                <button type="button" class="qty-btn" onclick="changeQty(1)">＋</button>
            </div>

            <input type="hidden" name="productId" value="${sivm.productId}">
            <input type="hidden" name="productName" value="${sivm.productName}"> 
            <input type="hidden" name="productPrice" value="${sivm.productPrice}">
            <input type="hidden" name="category" value="${category}">
            
            <input type="hidden" name="optionId" id="h_optionId" value="0">
            <input type="hidden" name="optionName" id="h_optionName" value="">
            <input type="hidden" name="optionPrice" id="h_optionPrice" value="0">

            <input type="submit" value="カートに入れる" class="cart-btn">
        </form>
    </div>
</div>

<script>
    let isOptionSelected = false;

    function toggleOption() {
        const label = document.getElementById("optionLabel");
        const hId = document.getElementById("h_optionId");
        const hName = document.getElementById("h_optionName");
        const hPrice = document.getElementById("h_optionPrice");

        isOptionSelected = !isOptionSelected;

        if (isOptionSelected) {
            label.classList.add("selected");
            hId.value = "${sivm.optionId}";
            hName.value = "${sivm.optionName}";
            hPrice.value = "${sivm.optionPrice}";
        } else {
            label.classList.remove("selected");
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