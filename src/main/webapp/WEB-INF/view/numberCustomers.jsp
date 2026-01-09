<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>お客様人数入力画面</title>
<style>
    /* タブレット番号入力と同じスタイル */
    body {
        margin: 0; padding: 0;
        font-family: "Hiragino Kaku Gothic ProN", "Meiryo", sans-serif;
        background-color: white;
        display: flex; flex-direction: column;
        justify-content: center; align-items: center;
        height: 100vh; color: #333;
    }
    h2 { font-weight: normal; margin-bottom: 30px; font-size: 32px; color: #444; }
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
    .num-btn { background-color: #444; color: white; }
    .del-btn { background-color: #888; color: white; font-size: 20px; }
    .submit-btn { background-color: #333; color: #e76f51; }
</style>
</head>
<body>
    <h2>人数を入力してください</h2>
    <form action="category" method="get">
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
            <input type="submit" value="確定" class="btn submit-btn">
        </div>
    </form>
<script>
    function appendNumber(n){ document.getElementById("numberCustomerInput").value += n; }
    function deleteLast(){ 
        var i=document.getElementById("numberCustomerInput"); 
        if(i.value.length>0) i.value=i.value.slice(0,-1); 
    }
</script>
</body>
</html>