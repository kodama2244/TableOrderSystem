<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>レジ座席一覧画面</title>

  <style>
    table {
      border: 3px solid black;
      width: 100%;
      border-collapse: collapse; /* 枠線をきれいにするため追加 */
    }
    td {
      border: 3px solid black;
      padding: 30pt;
      text-align: center;
      vertical-align: middle;
    }
    div {
      color: #789;
    }
    /* フォームがレイアウトを崩さないようにする設定 */
    form {
      margin: 0;
      padding: 0;
      display: inline;
    }
    button {
      padding: 10px 20px;
      cursor: pointer;
    }
  </style>
</head>
<body>

<h2>座席一覧</h2>

<table>
  <tr>
    <c:forEach var="table" items="${ viewModel.tableList }">
      <td>
        <strong>${ table.tableNumber }卓</strong><br><br>

        <c:choose>
          <c:when test="${ table.hasCustomer }">
            
            <form action="${pageContext.request.contextPath}/TableBillServlet" method="get">
                
                <input type="hidden" name="tableNumber" value="${ table.tableNumber }">
                
                <button type="submit">お会計</button>
            </form>
            
          </c:when>

          <c:otherwise>
            <div>案内可</div>
          </c:otherwise>
        </c:choose>
      </td>

      <c:if test="${ table.tableNumber % 4 == 0 }">
        </tr><tr>
      </c:if>

    </c:forEach>
  </tr>
</table>

</body>
</html>