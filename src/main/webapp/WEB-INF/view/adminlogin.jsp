<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>管理者ログイン</title>
<style>
    body {
        margin: 0; padding: 0; height: 100vh;
        display: flex; justify-content: center; align-items: center;
        background-color: #ffffff; color: #333;
        font-family: sans-serif;
    }
    .login-container {
        width: 350px; padding: 40px;
        border: 2px solid #333; border-radius: 8px;
        box-shadow: 10px 10px 0px #333; /* 少し遊び心のある影 */
    }
    h2 { text-align: center; margin-bottom: 30px; letter-spacing: 2px; }
    .form-group { margin-bottom: 20px; }
    label { display: block; margin-bottom: 8px; font-weight: bold; }
    input {
        width: 100%; padding: 12px; border: 1px solid #333;
        border-radius: 4px; box-sizing: border-box; font-size: 16px;
    }
    .login-btn {
        width: 100%; padding: 15px; background-color: #333; color: white;
        border: none; border-radius: 4px; font-size: 18px; font-weight: bold;
        cursor: pointer; margin-top: 10px;
    }
    .login-btn:active { transform: scale(0.98); }
    .error-msg { color: #d9534f; text-align: center; margin-top: 15px; font-weight: bold; }
</style>
</head>
<body>
    <div class="login-container">
        <h2>ログイン</h2>
        <form action="AdminLoginServlet" method="post">
            <div class="form-group">
                <label>ログインID</label>
                <input type="text" name="loginId" required>
            </div>
            <div class="form-group">
                <label>パスワード</label>
                <input type="password" name="password" required>
            </div>
            <button type="submit" class="login-btn">ログイン</button>
        </form>
        <c:if test="${not empty error}">
            <p class="error-msg">${error}</p>
        </c:if>
    </div>
</body>
</html>