<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>   
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Firebase Realtime</title>
<script src="http://code.jquery.com/jquery.js"></script>
<script src="https://js.tosspayments.com/v1/payment-widget"></script>
</head>
<body>
<%
	int chat_room_seq = (int) request.getSession().getAttribute("chat_room_seq");
	String user_name = (String) request.getSession().getAttribute("user_name");
%>
	<button onclick="redirectToCheckout()">페이</button>
	<h1>채팅방</h1>
	<div id="chatArea"><div id="chatMessageArea"></div></div>
	<br/>
	<input type="text" id="message">
	<input type="button" id="sendBtn" value="전송">
	
    <script type="module">
		import { initializeApp } from 'https://www.gstatic.com/firebasejs/10.6.0/firebase-app.js';
		import { getDatabase, ref, onChildAdded, update, orderByChild , limitToLast, set, child, push } from 'https://www.gstatic.com/firebasejs/10.6.0/firebase-database.js';

		var firebaseConfig = {
    		apiKey: "AIzaSyB02lC7PohY7yOS5LbEHtuvA3Bv_nbZcKY",
    		authDomain: "flutter-exam-fd5fa.firebaseapp.com",
    		databaseURL: "https://flutter-exam-fd5fa-default-rtdb.asia-southeast1.firebasedatabase.app",
    		projectId: "flutter-exam-fd5fa",
    		storageBucket: "flutter-exam-fd5fa.appspot.com",
    		messagingSenderId: "770408969236",
    		appId: "1:770408969236:web:d2875d3d8f7b1345472301"
		};

		const app = initializeApp(firebaseConfig);
		const database = getDatabase(app);

		var chat_room_seq;
    	var	user_name;

		var chatMessages = [];
		function connect() {
    		chat_room_seq = <%= chat_room_seq %>;
    		user_name = '<%= user_name %>';

    		var dbRef = ref(database, 'chat/' + chat_room_seq);

    		onChildAdded(dbRef, (data) => {
        		var username = data.val().user_name;
        		var msg = data.val().chat_message;
		
				console.log("[3]" + username + ":" + msg);
				appendMessage(username + ":" + msg);

				if (username !== user_name) {
					markMessageAsRead(chat_room_seq, data.key);
				}
    		});
		}

		function markMessageAsRead(chat_room_seq, messageKey) {
    		var messageRef = ref(database, 'chat/' + chat_room_seq + '/' + messageKey);
    		update(messageRef, {
        		chat_read_or_not: true,
    		});
		}

		function writeNewPost(chat_room_seq, user_name, msg) {
    		var postData = {
				chat_room_seq: chat_room_seq,
        		user_name: user_name,
        		chat_message: msg,
				chat_read_or_not: false,
				chat_at: new Date().getTime()
    		};

    		var newPostKey = push(child(ref(database), 'chat/' + chat_room_seq)).key;
    		var newRef = ref(database, 'chat/' + chat_room_seq + '/' + newPostKey);

    		set(newRef, postData);
		}

		function send() {
    		var msg = $("#message").val();
    		writeNewPost(chat_room_seq, user_name, msg);
		}

		function appendMessage(msg) {
    		$("#chatMessageArea").append(msg + "<br>");
    		var chatAreaHeight = $('#chatArea').height();
    		var maxScroll = $('#chatMessageArea').height() - chatAreaHeight;
    		$('#chatArea').scrollTop(maxScroll);
		}
		
		$(document).ready(function () {
			connect();
    		$('#sendBtn').click(function () { send(); });
		});
    </script>
    <script>
    	function redirectToCheckout() {
    		window.location.href = "/checkout";
    	}
    </script>
</body>
</html>