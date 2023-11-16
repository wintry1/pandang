<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<link href="https://fonts.googleapis.com/css2?family=Lato&display=swap" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Cormorant+Garamond:wght@500&display=swap" rel="stylesheet">
<link rel="stylesheet" type="text/css" href="/css/style.css">

<script>
$(document).ready(function() {
	$("#checkframe").css("display", "none");
});
$(function(){
	  $("#confirm").click(function(){
	      modalClose();
	      //컨펌 이벤트 처리
	  });
	  
	  $("#modal-open").click(function(){        
		  $("#popup_numberOK").css('display','flex').hide().fadeIn();
	  });
	  
	  $("#close-numberOK").click(function(){
	      modalClose();
	  });

	  function modalClose(){
	    $("#popup_numberOK").fadeOut();
	  }
	  
	  
 });

	function ajax_phonenum() {
	    var formData = $("#phonenumForm").serialize();
	    console.log(formData);
	    $.ajax({
	        type: "GET",
	        url: "/sendOne",
	        data: formData,
	        dataType: 'text',
	        success: function(json) {
	        	var result = JSON.parse(json);				
				if (result.code == "success") {
					$("#phoneNum-chek").prop("disabled", true);
					$("#checkframe").css('display', 'block');					
					alert(result.desc);
	            } else {
	            	alert(result.desc);
	            }
	        }
	    });
	}	
	
	function ajax_codenum() {
	    var formData = $("#codeForm").serialize();

	    $.ajax({
	        type: "GET",
	        url: "/checkCode",
	        data: formData,
	        dataType: 'text',
	        success: function(json) {
	        	var result = JSON.parse(json);				
				if (result.code == "success") {
					alert(result.desc);
					$("#codeNum-chek").prop("disabled", true);
	            } else {
	            	alert(result.desc);
	            }
	        }
	    });
	}	
</script>

</head>
<body>
<div class="container">
  <div class="modal-btn-box">
  <button type="button" id="modal-open">로그인/회원가입</button>  
  </div>
  
  <div class="popup-wrap" id="popup_numberOK">
    <div class="popup">
      <div class="popup-head">
          <span class="head-title">PANDANG</span>
      </div>
      <div class="popup-body">
        <div class="body-content">
          <div class="body-titlebox">
            <h2>번호로 인증하기</h2>
            <hr>
            <div class="number_frame">
            
            <div class="sendframe" id="sendframe">
           <form id="phonenumForm">
				<h4> 휴대폰 번호를 입력하세요</h4>
				<h6>( '-' 없이 숫자만 입력)</h6>
				<p></p>
				<input type="text" id="phoneNum"  name="phoneNum" size="30">
				<button type="button" id="phoneNum-chek" value="인증번호 전송" onclick="ajax_phonenum()" style="margin-top:8px;">인증번호 전송</button>
			</form>
          	</div>
          	<div class="checkframe" id="checkframe"> 
          	<form id="codeForm">
				<h4>인증코드 입력하세요</h4>
				<h6><laber for="Timer">남은 시간: (3분 내에 입력하시오.)</laber></h6><br/>
				<input type="text" id="codeNum" name="codeNum" size="30" style="margin-top: 7px;" >
				<button type="button" id="codeNum-chek" value="인증하기" onclick="ajax_codenum()" style="margin-left: 15px;">인증하기</button>
			</form>	
          	</div>
          	</div>
          </div>
        </div>
      </div>
      <div class="popup-foot">
        <span class="pop-btn next" id="next-map">다음</span>
        <span class="pop-btn close" id="close-numberOK">창 닫기</span>
      </div>
    </div>
</div>
</div>
</body>
</html>