<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>管理者登録</title>
<style>
    body {
        margin: 0; padding: 0; height: 100vh;
        display: flex; justify-content: center; align-items: center;
        background-color: #ffffff; color: #333; font-family: sans-serif;
    }
    .register-container {
        width: 400px; padding: 40px;
        border: 2px solid #333; border-radius: 8px;
        box-shadow: 10px 10px 0px #333;
    }
    h2 { text-align: center; margin-bottom: 30px; letter-spacing: 2px;  padding-bottom: 10px; }
    .form-group { margin-bottom: 20px; }
    label { display: block; margin-bottom: 8px; font-weight: bold; font-size: 14px; }
    input {
        width: 100%; padding: 12px; border: 1px solid #333;
        border-radius: 4px; box-sizing: border-box; font-size: 16px;
    }
    /* バリデーションエラー時のスタイル（任意） */
    input:invalid { border-color: #d9534f; }
    
    .register-btn {
        width: 100%; padding: 15px; background-color: #333; color: white;
        border: none; border-radius: 4px; font-size: 18px; font-weight: bold;
        cursor: pointer; margin-top: 10px;
    }
    .back-link { display: block; text-align: center; margin-top: 20px; color: #777; text-decoration: none; font-size: 14px; }
    .error-msg { color: #d9534f; text-align: center; margin-top: 15px; font-weight: bold; }
</style>
</head>
<body>
    <div class="register-container">
        <h2>新規登録</h2>
        
        <form action="AdminRegisterServlet" method="post">
            <div class="form-group">
                <label>ログインID</label>
                <input type="text" name="loginId" placeholder="半角英数字" required>
            </div>
            
            <div class="form-group">
                <label>パスワード</label>
                <input type="password" name="password" id="pass" required>
            </div>

            <div class="form-group">
                <label>パスワード（再確認）</label>
                <input type="password" name="confirmPassword" id="confirm" required 
                       oninput="checkPasswordMatch(this)">
            </div>
            
            <button type="submit" class="register-btn">新規ユーザーを登録</button>
        </form>

        <c:if test="${not empty adminError}">
            <p class="error-msg">${adminError}</p>
        </c:if>

        <a href="AdminMenuServlet" class="back-link">管理メニューへ戻る</a>
    </div>

    <script>
        // HTML5のsetCustomValidityを使用して、ブラウザ標準のエラー表示を出す
        function checkPasswordMatch(input) {
            const password = document.getElementById('pass').value;
            if (input.value !== password) {
                // 一致しない場合、エラーメッセージを設定（これで送信不可になる）
                input.setCustomValidity('パスワードが一致しません');
            } else {
                // 一致した場合、エラーを空にする（送信可能になる）
                input.setCustomValidity('');
            }
        }
    </script>
</body>
</html>