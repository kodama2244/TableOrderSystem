<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core"%>
<%-- エラーが出る fn タグは削除しました --%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>メニュー一覧</title>
<style>
/* CSS部分は共有いただいた画像のレイアウトを維持 */
body {
	margin: 0;
	padding: 0;
	font-family: "Hiragino Kaku Gothic ProN", "Meiryo", sans-serif;
	background-color: #f4f4f4;
	height: 100vh;
	width: 100vw;
	display: grid;
	grid-template-rows: 10vh 74vh 12vh;
	grid-template-columns: 1fr 140px;
	gap: 10px;
	padding: 10px;
	box-sizing: border-box;
	overflow: hidden;
}

.category-nav {
	grid-column: 1/-1;
}

.category-form {
	display: flex;
	gap: 8px;
	height: 100%;
}

.cat-btn {
	flex: 1;
	background-color: #333;
	color: white;
	border: none;
	border-radius: 8px;
	font-size: 1.2rem;
	font-weight: bold;
	cursor: pointer;
}

.cat-btn.active {
	background-color: #4A90E2;
}

.product-area {
	grid-column: 1/2;
	background: white;
	border-radius: 10px;
	padding: 15px;
	box-sizing: border-box;
}

.product-grid {
	display: grid;
	grid-template-columns: repeat(3, 1fr);
	grid-template-rows: repeat(2, 1fr);
	gap: 15px;
	height: 100%;
}

.product-card {
	background: white;
	border: 1px solid #eee;
	border-radius: 10px;
	padding: 10px;
	cursor: pointer;
	display: flex;
	flex-direction: column;
	justify-content: space-between;
	overflow: hidden;
	box-shadow: 0 2px 4px rgba(0, 0, 0, 0.05);
	text-decoration: none;
	color: inherit;
	width: 100%;
	height: 100%;
	box-sizing: border-box;
}

.card-inner {
	flex: 1;
	display: flex;
	align-items: center;
	justify-content: center;
	min-height: 0;
}

.card-inner img {
	max-width: 100%;
	max-height: 100%;
	object-fit: contain;
}

.product-info {
	flex-shrink: 0;
	text-align: center;
	margin-top: 5px;
}

.product-name {
	font-size: 1.2rem;
	font-weight: bold;
	margin-bottom: 2px;
}

.product-price {
	font-size: 1.1rem;
	color: #d9534f;
	font-weight: bold;
}

.sidebar {
	grid-column: 2/3;
	grid-row: 2/4;
	display: flex;
	flex-direction: column;
	gap: 10px;
}

.side-btn {
	flex: 1;
	background-color: #444;
	color: white;
	border: none;
	border-radius: 8px;
	font-size: 1.1rem;
	font-weight: bold;
	cursor: pointer;
}

.btn-checkout {
	background-color: #2c3e50;
}

.footer-nav {
	grid-column: 1/2;
	display: flex;
	justify-content: space-between;
	align-items: center;
	height: 100%;
}

.nav-btn {
	background-color: #666;
	color: white;
	border: none;
	border-radius: 8px;
	width: 120px;
	height: 70%;
	font-size: 1rem;
	font-weight: bold;
	cursor: pointer;
}

.page-controls {
	display: flex;
	gap: 10px;
	height: 70%;
}

.arrow-btn {
	width: 100px;
	background-color: #ddd;
	border: none;
	border-radius: 8px;
	font-size: 1.8rem;
	font-weight: bold;
	cursor: pointer;
	display: flex;
	align-items: center;
	justify-content: center;
}

.arrow-btn:disabled {
	opacity: 0.2;
	cursor: not-allowed;
}
</style>
</head>
<body>

	<%-- ページングロジック (ライブラリ不要のJava記述) --%>
	<%
	int pageSize = 6;
	String p = request.getParameter("page");
	int currPage = (p == null || p.isEmpty()) ? 1 : Integer.parseInt(p);

	viewmodel.MenuViewModel mvm = (viewmodel.MenuViewModel) request.getAttribute("mvm");
	int totalCount = 0;
	if (mvm != null && mvm.getProducts() != null) {
		totalCount = mvm.getProducts().size();
	}

	int startIndex = (currPage - 1) * pageSize;
	int endIndex = startIndex + pageSize - 1;

	// JSPタグで使えるように保存
	pageContext.setAttribute("currPage", currPage);
	pageContext.setAttribute("startIndex", startIndex);
	pageContext.setAttribute("endIndex", endIndex);
	pageContext.setAttribute("totalCount", totalCount);
	pageContext.setAttribute("pageSize", pageSize);
	%>

	<div class="category-nav">
		<form action="MenuServlet" method="get" class="category-form">
			<
			<c:forEach var="item"
				items="${['そば', 'うどん', '丼もの', '期間限定', 'サイド', '飲み物']}"
				varStatus="status">
				<%-- status.count を一度変数に受けて、文字列として比較する --%>
				<c:set var="currentCat" value="${status.count}" />
				<button type="submit" name="category" value="${currentCat}"
					class="cat-btn ${category.toString() == currentCat.toString() ? 'active' : ''}">
					${item}</button>
			</c:forEach>
		</form>
	</div>

	<div class="product-area">
		<form action="SingleItemServlet" method="get" style="height: 100%;">
			<input type="hidden" name="category" value="${category}">
			<div class="product-grid">
				<%-- 1ページ6件分だけをループ表示 --%>
				<c:forEach var="list" items="${mvm.products}" varStatus="status"
					begin="${startIndex}" end="${endIndex}">
					<button type="submit" name="id" value="${list.productId}"
						class="product-card">
						<div class="card-inner">
							<img alt="${list.productName}"
								src='assets/img/${list.productImage}'>
						</div>
						<div class="product-info">
							<div class="product-name">${list.productName}</div>
							<div class="product-price">${list.productPrice}円</div>
						</div>
					</button>
				</c:forEach>
			</div>
		</form>
	</div>

	<div class="sidebar">
		<form action="CartServlet" method="get"
			style="flex: 1; display: flex;">
			<input type="hidden" name="category" value="${category}">
			<button type="submit" class="side-btn">カート</button>
		</form>
		<form action="OrderHistoryServlet" method="get"
			style="flex: 1; display: flex;">
			<button type="submit" class="side-btn">履歴</button>
		</form>
		<form action="CheckoutServlet" method="get"
			style="flex: 1; display: flex;">
			<button type="submit" class="side-btn btn-checkout">お会計</button>
		</form>
	</div>

	<div class="footer-nav">
		<button type="button" class="nav-btn" onclick="history.back()">戻る</button>

		<div class="page-controls">
			<%-- 前のページ --%>
			<button type="button" class="arrow-btn"
				onclick="location.href='MenuServlet?category=${category}&page=${currPage - 1}'"
				${currPage <= 1 ? 'disabled' : ''}>←</button>

			<%-- 次のページ：全件数を超えていなければ有効 --%>
			<button type="button" class="arrow-btn"
				onclick="location.href='MenuServlet?category=${category}&page=${currPage + 1}'"
				${(startIndex + pageSize) >= totalCount ? 'disabled' : ''}>→</button>
		</div>
	</div>

</body>
</html>