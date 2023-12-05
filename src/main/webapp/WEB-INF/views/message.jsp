<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="https://fonts.googleapis.com/css?family=Poppins:100,100i,200,200i,300,300i,400,400i,500,500i,600,600i,700,700i,800,800i,900,900i" rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
<link href="https://fonts.googleapis.com/css2?family=Lato&display=swap" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Cormorant+Garamond:wght@500&display=swap" rel="stylesheet">
<script src="//dapi.kakao.com/v2/maps/sdk.js?appkey=d2d8856f21736abb5201a83471515122&libraries=services"></script>
<link rel="stylesheet" type="text/css" href="assets/css/dstyle.css">
<link rel="stylesheet" type="text/css" href="assets/css/modal_test.css">

<script defer src="https://unpkg.com/feather-icons"></script>
<script src="https://js.tosspayments.com/v1/payment-widget"></script>
<!-- title of site -->
	<title>모두 판당</title>
	
	<!-- For favicon png -->
	<link rel="shortcut icon" type="image/icon" href="assets/logo/favicon.jpg" />

	<!--font-awesome.min.css-->
	<link rel="stylesheet" href="assets/css/font-awesome.min.css">

	<!--linear icon css-->
	<link rel="stylesheet" href="assets/css/linearicons.css">

	<!--animate.css-->
	<link rel="stylesheet" href="assets/css/animate.css">

	<!--flaticon.css-->
	<link rel="stylesheet" href="assets/css/flaticon.css">

	<!--bootstrap.min.css-->
	<link rel="stylesheet" href="assets/css/bootstrap.min.css">

	<!-- bootsnav -->
	<link rel="stylesheet" href="assets/css/bootsnav.css">

	<!--style.css-->
	<link rel="stylesheet" href="assets/css/style.css">

	<!--responsive.css-->
	<link rel="stylesheet" href="assets/css/responsive.css">
</head>
<body style="width:400px; height:690px; position: fixed; border: 1px solid grey;">
	<div>
		<div class="chat-user">
			<div class="chat-usernickname">${you_name}</div>
		</div>
		<div class="chat-top">
				<div class="chat-text1">${list.prd_title}</div>
				<div class="chat-price">
					<fmt:formatNumber type="number" maxFractionDigits="3" pattern="#,##0원" value="${list.prd_price}"/>
				</div>
				<button type="button" id="chat-pay-btn" class="chat-pay-btn" onclick="redirectToCheckout()">페     이</button>
			</div>
		<div class="m-chat-content" id="chat-content"></div>
		<div class="chat-bottom">
			<div class="text_content">
				<input type="text" row="4" id="message" class="chat_textarea">
			</div>
			<div class="text_content_btn">
				<input type="button" id="sendBtn" class="chat_btn" value="전송">
			</div>
		</div>
	</div>
    <script>
    	function redirectToCheckout() {
    		var popupWindow = window.open("/checkout?product_seq=" + ${product_seq}, "Checkout", "width=1000, height=600");
    		if (popupWindow == null || typeof popupWindow === 'undefined') {
                alert("팝업 창이 차단되었습니다. 팝업 차단을 해제하고 다시 시도하세요.");
            }
    	}
    </script>
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
		var admin = "하우바우";
		var lastDisplayedDate = "";
		var you_seq = '${you_seq}';
		var idnum = 1;		
		
		function connect() {
    		chat_room_seq = ${chat_room_seq};
    		user_name = '${user_name}';

    		var dbRef = ref(database, 'chat/' + chat_room_seq);

    		onChildAdded(dbRef, (data) => {
        		var username = data.val().user_name;
        		var msg = data.val().chat_message;
				var chat_at = data.val().chat_at;
				var currentTime = convertTimestampToCurrentTime(chat_at);
				var time = splitTimeString(currentTime);
				var timehom = time.period + time.time
				var otherDate = new Date(time.date);

				var year = otherDate.getFullYear();
				var month = ('0' + (otherDate.getMonth() + 1)).slice(-2);
				var day = ('0' + otherDate.getDate()).slice(-2);

				var dateString = year + month + day;

				var chat_read_or_not = data.val().chat_read_or_not;
	
				appendMessage(otherDate, dateString);
				
				if (username == admin) {
					adminappendMessage(msg, dateString, idnum);
				} else if (username == user_name) {
					meappendMessage(msg, timehom, dateString, idnum);
					if (chat_read_or_not !== "false") {
						getNotice(you_seq, chat_room_seq);
					}

				} else if (username !== user_name) {
					udNotice(you_seq, chat_room_seq);
					youappendMessage(msg, timehom, dateString, idnum);
				}
				if (username !== user_name) markMessageAsRead(chat_room_seq, data.key); 
    		});
		}

		function markMessageAsRead(chat_room_seq, messageKey) {
    		var messageRef = ref(database, 'chat/' + chat_room_seq + '/' + messageKey);
    		update(messageRef, {
        		chat_read_or_not: true,
    		});
		}
		
		function convertTimestampToCurrentTime(timestamp) {
    		var date = new Date(timestamp);

    		var formattedTime = date.toLocaleString(); 

    		return formattedTime;
		}
		
		function splitTimeString(timeString) {
    		 var dateTimeParts = timeString.match(/(\d+\.\s\d+\.\s\d+\.)\s([^\s]+)\s(\d+:\d+:\d+)/);

    		if (dateTimeParts) {
        		var result = {
            		date: dateTimeParts[1],
            		period: dateTimeParts[2],
            		time: dateTimeParts[3]
        		};

        		return result;
    		} else {
        		return null;
    		}
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

			if (msg.trim() === '') {
        		return;
    		}

    		writeNewPost(chat_room_seq, user_name, msg);
			$('#message').val('');
		}

		function appendMessage(otherDate, time) {
       		var chatContent = $("#chat-content");

    		var date = new Date(otherDate);

    		var formattedDate = date.toLocaleDateString('ko-KR', { year: 'numeric', month: 'long', day: 'numeric' });

    		if (formattedDate !== lastDisplayedDate) {
        		lastDisplayedDate = formattedDate;
				idnum = idnum + 1;

        		var chatBoxAdmin = $("<div>").addClass("chat-date").attr("id", idnum);
				var dayBoxAdmin = $("<div>").addClass("day-chat").attr("id", time);
        		var h82MsgAdmin = $("<h82>").text(formattedDate);

        		chatBoxAdmin.append(h82MsgAdmin, dayBoxAdmin);
	
        		chatContent.append(chatBoxAdmin);
    		}
		}

		function adminappendMessage(msg, time, idnum) {
    		var chatContent = $("#chat-content");
    		var chatDate = $("#" + idnum);
    		var dayChat = chatDate.find("#" + time);
	
    		var textBoxAdmin  = $("<div>").addClass("text_box_admin").attr("id", "text_box_admin");
    		var sendMsgAdmin = $("<div>").addClass("send-msg_admin").text(msg);

    		textBoxAdmin.append(sendMsgAdmin);
    		dayChat.append(textBoxAdmin);

    		var chatAreaHeight = chatContent.height();
    		var maxScroll = chatContent.prop("scrollHeight") - chatAreaHeight;
    		chatContent.scrollTop(maxScroll);
		}


		function meappendMessage(msg, sendTime, time, idnum) {
    		var chatContent = $("#chat-content");
    		var chatDate = $("#" + idnum);
    		var dayChat = chatDate.find("#" + time);	
	
    		var textBoxme = $("<div>").addClass("text_box_me").attr("id", "text_box_me");
    		var sendTimeme = $("<div>").addClass("send-time").text(sendTime);
    		var sendMsgme = $("<div>").addClass("send-msg").text(msg);

    		textBoxme.append(sendTimeme, sendMsgme);
    		dayChat.append(textBoxme);

    		var chatAreaHeight = chatContent.height();
    		var maxScroll = chatContent.prop("scrollHeight") - chatAreaHeight;
    		chatContent.scrollTop(maxScroll);
		}
		
		function youappendMessage(msg, sendTime, time, idnum) {
    		var chatContent = $("#chat-content");
    		var chatDate = $("#" + idnum);
    		var dayChat = chatDate.find("#" + time);
	
    		var textBoxYou = $("<div>").addClass("text_box_you").attr("id", "text_box_you");
    		var sendTimeYou = $("<div>").addClass("send-time_you").text(sendTime);
    		var sendMsgYou = $("<div>").addClass("send-msg_you").text(msg);

    		textBoxYou.append(sendMsgYou, sendTimeYou);
    		dayChat.append(textBoxYou);

    		var chatAreaHeight = chatContent.height();
    		var maxScroll = chatContent.prop("scrollHeight") - chatAreaHeight;
    		chatContent.scrollTop(maxScroll);
		}

		function udNotice(you_seq, chat_room_seq) {
        	$.ajax({
            	url: '/noticeudchat',
            	type: 'GET',
				data: { you_seq: you_seq,
						chat_room_seq: chat_room_seq },
            	success: function (data) {
            	},
            	error: function (error) {
            	}
        	});
    	}

		function getNotice(you_seq, chat_room_seq) {
        	$.ajax({
            	url: '/noticeintchat',
            	type: 'GET',
				data: { you_seq: you_seq,
						chat_room_seq: chat_room_seq },
            	success: function (data) {
            	},
            	error: function (error) {
            	}
        	});
    	}

		$(document).ready(function () {
			connect();
    		$('#sendBtn').click(function () { send(); });
			$('#message').keyup(function (e) { if (e.key === "Enter") send(); });
		});
		
		
    </script>
	<!-- Include all js compiled plugins (below), or include individual files as needed -->

	<script src="assets/js/jquery.js"></script>

	<!--modernizr.min.js-->
	<script src="https://cdnjs.cloudflare.com/ajax/libs/modernizr/2.8.3/modernizr.min.js"></script>

	<!--bootstrap.min.js-->
	<script src="assets/js/bootstrap.min.js"></script>

	<!-- bootsnav js -->
	<script src="assets/js/bootsnav.js"></script>

	<!--feather.min.js-->
	<script src="assets/js/feather.min.js"></script>

	<!-- counter js -->
	<script src="assets/js/jquery.counterup.min.js"></script>


	<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-easing/1.4.1/jquery.easing.min.js"></script>

	<!--Custom JS-->
	<script src="assets/js/custom.js"></script>
	
</body>
</html>
