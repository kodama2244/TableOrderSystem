<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>お客様人数入力画面</title>
<style>
    body {
        margin: 0; padding: 0;
        font-family: "Hiragino Kaku Gothic ProN", "Meiryo", sans-serif;
        background-color: white;
        display: flex; flex-direction: column;
        justify-content: center; align-items: center;
        height: 100vh; color: #333;
    }
    h2 { font-weight: normal; margin-bottom: 5px; font-size: 32px; color: #444; }

    /* エラー表示エリア */
    #error-msg {
        color: #d9534f;
        font-weight: bold;
        height: 24px;
        margin-bottom: 15px;
        font-size: 18px;
    }

    form { display: flex; flex-direction: column; align-items: center; }
    .input-display {
        width: 320px; height: 70px;
        border: 2px solid #ccc; border-radius: 8px;
        margin-bottom: 30px;
        display: flex; align-items: center; justify-content: center;
    }
    .input-display input {
        width: 100%; height: 100%; border: none;
        font-size: 40px; text-align: center; outline: none;
        background: transparent; color: #333;
    }
    .keypad {
        display: grid; grid-template-columns: repeat(3, 1fr);
        gap: 15px; width: 320px;
    }
    .btn {
        border: none; border-radius: 8px;
        font-size: 28px; height: 70px;
        cursor: pointer; font-weight: bold;
    }
    .btn:active { opacity: 0.7; }
    .num-btn { background-color: #444; color: white; }
    .del-btn { background-color: #888; color: white; font-size: 20px; }
    .submit-btn { background-color: #333; color: #e76f51; }
</style>
</head>
<body>
    <h2>人数を入力してください</h2>
    
    <div id="error-msg"></div>

    <form action="category" method="get" onsubmit="return validateForm()">
        <div class="input-display">
            <input type="text" name="numberCustomer" id="numberCustomerInput" readonly>
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
    const inputField = document.getElementById("numberCustomerInput");
    const errorDisplay = document.getElementById("error-msg");

    function appendNumber(n) { 
        errorDisplay.innerText = ""; // 文字が打たれたらエラーを消す
        inputField.value += n; 
    }

    function deleteLast() { 
        if(inputField.value.length > 0) {
            inputField.value = inputField.value.slice(0,-1); 
        }
    }

    function validateForm() {
        const val = inputField.value;

        // 1. 未入力チェック
        if (val === "") {
            errorDisplay.innerText = "※人数を入力してください";
            return false;
        }

        // 2. 0名チェック
        const num = parseInt(val, 10);
        if (num === 0) {
            errorDisplay.innerText = "※1名以上で入力してください";
            return false;
        }

        return true; 
    }
</script>
</body>
</html>