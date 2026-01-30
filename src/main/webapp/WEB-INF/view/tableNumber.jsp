<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>タブレット番号入力画面</title>
<style>
    body {
        margin: 0; padding: 0;
        font-family: "Hiragino Kaku Gothic ProN", "Meiryo", sans-serif;
        background-color: white;
        display: flex; flex-direction: column; justify-content: center; align-items: center;
        height: 100vh; color: #333;
    }

    h2 { font-weight: normal; margin-bottom: 5px; font-size: 32px; color: #444; }

    /* エラーメッセージ：赤字で表示 */
    #error-msg {
        color: #d9534f;
        font-weight: bold;
        height: 24px;
        margin-bottom: 15px;
        font-size: 18px;
    }

    form { display: flex; flex-direction: column; align-items: center; }

    .input-display {
        width: 320px; height: 70px; border: 2px solid #ccc;
        margin-bottom: 30px; display: flex; align-items: center;
        justify-content: center; border-radius: 8px;
    }

    .input-display input {
        width: 100%; height: 100%; border: none; font-size: 40px;
        text-align: center; outline: none; background: transparent; color: #333;
    }

    .keypad { display: grid; grid-template-columns: repeat(3, 1fr); gap: 15px; width: 320px; }

    .btn {
        border: none; border-radius: 8px; font-size: 28px; height: 70px;
        cursor: pointer; transition: opacity 0.1s; font-weight: bold;
    }
    .btn:active { opacity: 0.7; }
    .num-btn { background-color: #444; color: white; }
    .del-btn { background-color: #888; color: white; font-size: 20px; }
    .submit-btn { background-color: #333; color: #e76f51; }
</style>
</head>
<body>
    <h2>タブレット番号入力</h2>
    
    <div id="error-msg"></div>

    <form action="welcom" method="get" onsubmit="return validateForm()">
        <div class="input-display">
            <input type="text" name="tableNumber" id="tableNumberInput" readonly>
        </div>
        <div class="keypad">
            <button type="button" class="btn num-btn" onclick="appendNumber('1')">1</button>
            <button type="button" class="btn num-btn" onclick="appendNumber('2')">2</button>
            <button type="button" class="btn num-btn" onclick="appendNumber('3')">3</button>
            <button type="button" class="btn num-btn" onclick="appendNumber('4')">4</button>
            <button type="button" class="btn num-btn" onclick="appendNumber('5')">5</button>
            <button type="button" class="btn num-btn" onclick="appendNumber('6')">6</button>
            <button type="button" class="btn num-btn" onclick="appendNumber('7')">7</button>
            <button type="button" class="btn num-btn" onclick="appendNumber('8')">8</button>
            <button type="button" class="btn num-btn" onclick="appendNumber('9')">9</button>
            <button type="button" class="btn del-btn" onclick="deleteLast()">削除</button>
            <button type="button" class="btn num-btn" onclick="appendNumber('0')">0</button>
            <button type="submit" class="btn submit-btn">確定</button>
        </div>
    </form>

<script>
    const inputField = document.getElementById("tableNumberInput");
    const errorDisplay = document.getElementById("error-msg");

    function appendNumber(n) { 
        errorDisplay.innerText = ""; 
        // 3桁以上にならないように制限（16までなので最大2桁で十分）
        if (inputField.value.length < 2) {
            inputField.value += n; 
        }
    }

    function deleteLast() { 
        errorDisplay.innerText = "";
        if(inputField.value.length > 0) {
            inputField.value = inputField.value.slice(0,-1); 
        }
    }

    function validateForm() {
        const val = inputField.value;

        // 1. 未入力チェック
        if (val === "") {
            errorDisplay.innerText = "※番号を入力してください";
            return false;
        }

        // 2. 範囲チェック（1〜16）
        const num = parseInt(val, 10);
        if (num < 1 || num > 16) {
            errorDisplay.innerText = "※1番から16番を入力してください";
            // 入力をクリアするかはお好みですが、残しておいたほうが修正しやすいです
            return false;
        }

        return true; 
    }
</script>
</body>
</html>