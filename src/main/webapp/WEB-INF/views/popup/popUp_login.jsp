<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
<link href="https://fonts.googleapis.com/css2?family=Lato&display=swap" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Cormorant+Garamond:wght@500&display=swap" rel="stylesheet">
<script src="//dapi.kakao.com/v2/maps/sdk.js?appkey=d2d8856f21736abb5201a83471515122&libraries=services"></script>
<link rel="stylesheet" type="text/css" href="/css/style.css">

<script>
$(function(){
	  $("#modal-open").click(function(){        
		  $("#popup1").css('display','flex').hide().fadeIn();
	  });
	  
	  $("#kakao-login-btn").click(function(){
		  $("#popup-overlay").show();
		  var popupWindow = window.open("/oauth2/authorization/kakao", "", "width=500px, height=550px");
		  // Detect when the popup is closed
		    var checkPopupClosed = setInterval(function() {
		        if (popupWindow.closed) {
		            // 팝업창이 닫히면 실행
		            $("#popup-overlay").hide();  
		            clearInterval(checkPopupClosed); 
		        }
		    }, 100); // 1초마다 팝업창이 닫혔는지 체크

	  });

	  $("#naver-login-btn").click(function(){
		  $("#popup-overlay").show();
		  var popupWindow = window.open("/oauth2/authorization/naver", "", "width=500px, height=550px");    
		    // Detect when the popup is closed
		    var checkPopupClosed = setInterval(function() {
		        if (popupWindow.closed) {
		            // 팝업창이 닫히면 실행
		            $("#popup-overlay").hide();  
		            clearInterval(checkPopupClosed); 
		        }
		    }, 100); // 1초마다 팝업창이 닫혔는지 체크
	  });
	  $("#number-login-btn").click(function(){
		  $("#popup-overlay").show();
		  var popupWindow = modal.open("/number_login", "", "width=500px, height=550px");    
		    // Detect when the popup is closed
		    var checkPopupClosed = setInterval(function() {
		        if (popupWindow.closed) {
		            // 팝업창이 닫히면 실행
		            $("#popup-overlay").hide();  
		            clearInterval(checkPopupClosed); 
		        }
		    }, 100); // 1초마다 팝업창이 닫혔는지 체크
	  });
	  
	  $("#close-login").click(function(){
		modalClose1();
	  });
	  function modalClose1(){
	    $("#popup1").fadeOut();
	  }
	  
	  function frameClose() {
		 $("#popup-overlay").hide();
	  }
	  
	  $("#next-map").click(function(){
		modalClose2();
	    $("#popup2").css('display','flex').hide().fadeIn();
	    $("#map").css('display','flex').hide().fadeIn();
	  });
	  $("#close-map").click(function(){
		  modalClose1();
		  modalClose2();
	  });
	  function modalClose2(){
	    $("#popup2").fadeOut();
	  }
	  
	  $("#next-agree").click(function(){
			modalClose3();
	     $("#popup3").css('display','flex').hide().fadeIn();  
	     $("#map").hide();
	  });
	  $("#close-agree").click(function(){
		  modalClose1();
		  modalClose2();
		  modalClose3();
	  });
	  function modalClose3(){
	    $("#popup3").fadeOut();
	  }
	  $("#confirm").click(function(){
		modalClose1();
		modalClose2();
		modalClose3();
	  });
	  
	});
	
</script>
<script>
//전체 선택시 전체 선택 또는 전체 해제	
document.addEventListener('DOMContentLoaded', function () {
  const allCheck = document.getElementById('all-check');
  const checkboxes = document.getElementsByName('check');
  const nextButton = document.getElementById('confirm');

  // "모든 약관에 동의합니다." 체크박스를 클릭했을 때
  allCheck.addEventListener('change', function () {
    checkboxes.forEach((checkbox) => {
      checkbox.checked = allCheck.checked;
    });
  });

  // 개별 체크박스 중 하나를 클릭했을 때
  checkboxes.forEach((checkbox) => {
    checkbox.addEventListener('change', function () {
      if (!this.checked) {
        allCheck.checked = false;
      } else {
        // 다른 모든 체크박스도 선택된 상태인지 확인
        const allChecked = Array.from(checkboxes).every((c) => c.checked);
        allCheck.checked = allChecked;
      }
    });
  });
  checkboxes.forEach((checkbox) => {
	    checkbox.addEventListener('change', function () {
	      if (!this.checked) {
	        allCheck.checked = false;
	      } else {
	        // 다른 모든 체크박스도 선택된 상태인지 확인
	        const allRequiredChecked = Array.from(checkboxes).filter((c) => c.getAttribute('data-required') === 'true').every((c) => c.checked);
	     // "다음" 버튼 활성화 또는 비활성화
	        nextButton.disabled = !allRequiredChecked;
	      }
	    });
	  });
  nextButton.addEventListener('click', function () {
	    if (!nextButton.disabled) {
	      // 필수 항목이 모두 선택되었을 때 페이지 이동
	      window.location.href = "/main"; // 이동할 URL을 설정하세요
	    }
	  });
});

 
</script>
</head>
<body>

<div class="container">
  <div class="modal-btn-box">
  <button type="button" id="modal-open">로그인/회원가입</button>  
  </div>

  <div class="popup-wrap" id="popup1">
    <div class="popup">
      <div class="popup-head">
          <span class="head-title">
            PANDANG</span>
      </div>
      <div class="popup-body login">
        <div class="body-content">
          <div class="body-titlebox">
            <h2>번호로 이증하기</h2>
            <div class="frame">
            <input type="text" >
          	</div>
          </div>
        </div>
      </div>
      <div class="popup-foot">
      	<span class="pop-btn next" id="next-map" >다음</span>
        <span class="pop-btn close" id="close-login" >창 닫기</span>
      </div>
      <div class="popup-overlay" id="popup-overlay">
    </div>
</div>
</div>
</body>
</html>