<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>カート画面</title>
<style>
    /* CSSはそのままなので省略 */
    body { margin: 0; padding: 0; font-family: sans-serif; background-color: white; color: #333; height: 100vh; display: flex; flex-direction: column; }
    header { height: 80px; display: flex; align-items: center; justify-content: center; }
    .cart-container { flex-grow: 1; overflow-y: auto; padding: 0 40px; display: flex; flex-direction: column; gap: 15px; }
    .cart-row { display: grid; grid-template-columns: 2fr 1fr 1fr 0.8fr 100px; align-items: center; border: 1px solid #ccc; padding: 15px; border-radius: 8px; gap: 10px; }
    .delete-btn { background-color: #888; color: white; border: none; padding: 10px; border-radius: 5px; cursor: pointer; }
    .total-area { padding: 20px 40px; text-align: right; font-size: 28px; font-weight: bold; border-top: 2px solid #eee; }
    .footer-actions { height: 100px; padding: 0 40px 30px 40px; display: flex; justify-content: space-between; align-items: center; }
    .action-btn { height: 70px; width: 200px; border: none; border-radius: 8px; font-size: 24px; font-weight: bold; cursor: pointer; color: white; }
    .btn-back { background-color: #555; }
    .btn-confirm { background-color: #444; width: 300px; }
</style>
</head>
<body>

    <header>
        <h2>カート</h2>
    </header>

    <div class="cart-container">
        <c:if test="${empty cvm}">
            <p style="text-align:center; font-size:24px; color:#888;">カートは空です。</p>
        </c:if>

        <c:if test="${not empty cvm}">
            <c:forEach var="item" items="${cvm}" varStatus="status">
                <div class="cart-row">
                    <div class="item-name"><strong>${item.productName}</strong></div>
                    <div class="item-option" style="background:#f0f0f0; border-radius:4px; text-align:center;">${item.optionName}</div>
                    <div class="item-price" style="text-align:right;">${item.productPrice + item.optionPrice}円</div>
                    <div class="item-qty" style="text-align:center;">数量: ${item.quantity}</div>
                    <div>
                        <form action="CartServlet" method="post">
                            <input type="hidden" name="action" value="delete">
                            <input type="hidden" name="index" value="${status.index}">
                            <button type="submit" class="delete-btn">削除</button>
                        </form>
                    </div>
                </div>
            </c:forEach>
        </c:if>
    </div>

    <%-- フッター：カートが空でなくても空でも「戻る」ボタンを表示 --%>
    <div class="total-area">
        <c:if test="${not empty cvm}">合計金額: ${totalAmount}円</c:if>
    </div>

    <div class="footer-actions">
      <form action="MenuServlet" method="get">
            <%-- キー名を統一。単に ${category} でOKです --%>
            <input type="hidden" name="category" value="${category}">
            <button type="submit" class="action-btn btn-back">
                <c:out value="${empty cvm ? 'メニューへ' : '戻る'}" />
            </button>
        </form>

        <c:if test="${not empty cvm}">
          <form action="OrderConfirmedServlet" method="post">
        <%-- ★ここを追加：カート内の全商品を隠しフィールドとして送信 --%>
        <c:forEach var="item" items="${cvm}">
            <input type="hidden" name="productId" value="${item.productId}">
            <input type="hidden" name="optionId" value="${item.optionId}">
            <input type="hidden" name="quantity" value="${item.quantity}">
        </c:forEach>
        
        <button type="submit" class="action-btn btn-confirm">注文確定</button>
    </form>
        </c:if>
    </div>

</body>
</html>