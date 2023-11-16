<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>   
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Firebase Realtime</title>
<script src="http://code.jquery.com/jquery.js"></script>
</head>
<body>
	판매자 : <input type="text" id="sell_seq"> <br>
    상품 Name : <input type="text" id="product_seq"> <br>
	이름 Name : <input type="text" id="buy_seq"> <br>
	Name : <input type="text" id="user_name"> <br>
	<input type="button" id="chat_room" value="입장"> 
	
	<script>
    document.getElementById('chat_room').addEventListener('click', function() {
        var product_seq = document.getElementById('product_seq').value;
        var buy_seq = document.getElementById('buy_seq').value;
        var sell_seq = document.getElementById('sell_seq').value;
        var user_name = document.getElementById('user_name').value;

        window.location.href = '/chroom?product_seq=' + encodeURIComponent(product_seq) + '&buy_seq=' + encodeURIComponent(buy_seq) + '&sell_seq=' + encodeURIComponent(sell_seq) + '&user_name=' + encodeURIComponent(user_name);
    });
</script>
</body>
</html>