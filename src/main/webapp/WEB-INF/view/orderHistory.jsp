<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="refresh" content="5">
<meta charset="UTF-8">
<title>注文履歴</title>
<style>
/* --- 全体の基本設定 (枠なし・フルスクリーン) --- */
body {
	margin: 0;
	padding: 0;
	font-family: "Hiragino Kaku Gothic ProN", "Meiryo", sans-serif;
	background-color: white;
	color: #333;
	height: 100vh;
	display: flex;
	flex-direction: column;
	box-sizing: border-box;
}

/* --- ヘッダーエリア --- */
header {
	height: 80px;
	display: flex;
	align-items: center;
	justify-content: center;
	flex-shrink: 0;
}

h2 {
	font-size: 32px;
	font-weight: normal;
	margin: 0;
	color: #444;
}

/* --- メインコンテンツ（履歴リスト） --- */
.history-container {
	flex-grow: 1;
	overflow-y: auto;
	padding: 0 40px;
	display: flex;
	flex-direction: column;
	gap: 15px;
}

/* 注文履歴の各行 */
.history-row {
	display: grid;
	/* 商品名 | オプション | 価格 | 数量 | 注文状況 */
	grid-template-columns: 2fr 1fr 1fr 0.8fr 1.2fr;
	align-items: center;
	border: 1px solid #ccc;
	padding: 15px;
	border-radius: 8px;
	font-size: 18px;
	background-color: #fff;
	gap: 10px;
}

.item-name {
	font-weight: bold;
	font-size: 20px;
}

.item-option {
	background-color: #f0f0f0;
	padding: 5px 10px;
	border-radius: 4px;
	text-align: center;
	font-size: 16px;
}

.item-price {
	text-align: right;
	font-weight: bold;
}

.item-qty {
	text-align: center;
}

/* 注文状況のラベル（配膳状況） */
.item-status {
	text-align: center;
	background-color: #444;
	color: white;
	padding: 8px;
	border-radius: 5px;
	font-size: 16px;
	font-weight: bold;
}

/* 履歴なしメッセージ */
.empty-msg {
	text-align: center;
	font-size: 24px;
	margin-top: 100px;
	color: #888;
}

/* --- 合計金額エリア --- */
.total-area {
	padding: 20px 40px;
	text-align: left; /* 画像に合わせて左側に配置 */
	border-top: 2px solid #eee;
	background-color: #fafafa;
}

.total-box {
	display: inline-block;
	border: 2px solid #333;
	padding: 10px 40px;
	font-size: 28px;
	font-weight: bold;
	background-color: white;
}

/* --- フッター（アクションボタン） --- */
.footer-actions {
	height: 100px;
	padding: 0 40px 30px 40px;
	display: flex;
	justify-content: flex-end; /* 右寄せ */
	gap: 20px;
	align-items: center;
	flex-shrink: 0;
}

.action-btn {
	height: 70px;
	width: 200px;
	border: none;
	border-radius: 8px;
	font-size: 24px;
	font-weight: bold;
	cursor: pointer;
	color: white;
	transition: opacity 0.2s;
}

.btn-back {
	background-color: #555;
}

.btn-checkout {
	background-color: #444;
}

.action-btn:active {
	opacity: 0.8;
	transform: scale(0.98);
}
</style>
</head>
<body>

	<header>
		<h2>注文履歴</h2>
	</header>

	<div class="history-container">
		<c:choose>
			<c:when test="${empty ovm.orderHistorys}">
				<p class="empty-msg">注文履歴はありません</p>
			</c:when>
			<c:otherwise>
				<c:forEach var="order" items="${ovm.orderHistorys}">
					<div class="history-row">
						<div class="item-name">${order.productName}</div>

						<%-- オプション名を表示する列（CSSの5列レイアウト維持） --%>
						<div class="item-option">${order.optionName}</div>

						<%-- 単価（商品単価 + オプション単価）を表示 --%>
						<div class="item-price">${order.productPrice + order.optionPrice}円
						</div>

						<div class="item-qty">${order.productQuantity}個</div>
						<div class="item-status">${order.statusName}</div>
					</div>
				</c:forEach>
			</c:otherwise>
		</c:choose>
	</div>
	<div class="total-area">
		<div class="total-box">合計金額： ${totalAmount} 円</div>
	</div>

	<div class="footer-actions">
		<form action="MenuServlet" method="get">
			<button type="submit" class="action-btn btn-back">戻る</button>
		</form>

		<form action="CheckoutServlet" method="get">
			<button type="submit" class="action-btn btn-checkout">お会計</button>
		</form>
	</div>

</body>
</html>
