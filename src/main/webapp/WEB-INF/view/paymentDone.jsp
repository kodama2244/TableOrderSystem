<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8">
    <title>決済完了</title>
  </head>
  
  <body>
    <h2>決済が完了しました。</h2>
    
    <h2>お釣り : ${ change }円</h2>

    <button onclick="location.href='TableListServlet'">座席一覧へ戻る</button>
  </body>
</html>
