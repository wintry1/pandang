<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
  <head>
    <meta charset="utf-8" />
    <link rel="icon" href="https://static.toss.im/icons/png/4x/icon-toss-logo.png" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>클리어</title>
  	</head>
    <body>
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

		function writeNewPost(chat_room_seq, user_name, msg) {
    		 return new Promise((resolve, reject) => {
        	var postData = {
            	chat_room_seq: chat_room_seq,
            	user_name: user_name,
            	chat_message: msg,
            	chat_read_or_not: false,
            	chat_at: new Date().getTime()
        	};

        	var newPostKey = push(child(ref(database), 'chat/' + chat_room_seq)).key;
        	var newRef = ref(database, 'chat/' + chat_room_seq + '/' + newPostKey);

        	set(newRef, postData)
            	.then(() => resolve())
            	.catch((error) => reject(error));
    		});
		}

		function send() {
            var admin = "하우바우";
            var chat_room_seq = ${list.chat_room_seq};
            var user_name = '${user_name}';
            var msg = user_name + "님 페이 결제 완료 되었습니다.";

            writeNewPost(chat_room_seq, admin, msg)
				.then(() => {
                	window.close();
            	})
    	}

		window.onload = function () {
			send();
     	};	
    </script>
    </body>
</html>