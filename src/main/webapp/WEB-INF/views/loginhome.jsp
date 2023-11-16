<%@page import="com.study.springboot.oauth2.SessionUser"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ page import="com.study.springboot.oauth2.SessionUser" %>
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
<link rel="stylesheet" type="text/css" href="assets/css/dstyle.css">


<script>
$(document).ready(function() {
	$("#checkframe").css("display", "none");
});
$(function(){
    $("#modal-open").click(function(){        
      $("#popup_login").css('display','flex').hide().fadeIn();
    });
    $("#close-login").click(function(){
        modalClose1();
    });
    function modalClose1(){
      $("#popup_login").fadeOut();
    }
   
    $("#kakao-login-btn").click(function(){
      window.location.href ="/oauth2/authorization/kakao";
    });
   
    $("#naver-login-btn").click(function(){
      window.location.href ="/oauth2/authorization/naver";
    });
   
    $("#number-login-btn").click(function(){
      $("#popup_numberOK").css('display','flex').hide().fadeIn();       
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

	            } else {
	            	alert(result.desc);
	            }
	        }
	    });
	}	
    
    
    
  
    $("#close-numberOK").click(function(){
    	modalClose11();
    });
    function modalClose11(){
      	$("#popup_numberOK").fadeOut();
    }


    $("#next-map").click(function(){
    	modalClose11();
      	$("#popup_map").css('display','flex').hide().fadeIn();
      	$("#map").css('display','flex').hide().fadeIn();
    });
    
    
    $("#close-map").click(function(){
      modalClose2();
    });
    function modalClose2(){
      $("#popup_map").fadeOut();
      $("#map").hide();
    }
   
    
    
    $("#next-agree").click(function(){
       $("#popup_agree").css('display','flex').hide().fadeIn();
     });
    
    
    
    $("#close-agree").click(function(){
      modalClose11();
      modalClose2();
      modalClose3();
    });
    
    
    function modalClose3(){
      $("#popup_agree").fadeOut();
    }
    $("#confirm").click(function(){
    modalClose1();
    modalClose11();
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


<div class="popup-wrap" id="popup_login">
  <div class="popup">
    <div class="popup-head">
      <span class="head-title">PANDANG</span>
    </div>
      <div class="popup-body login">
        <div class="body-content">
          <div class="body-titlebox">
            <h1>로그인/회원가입</h1>
            <div class="frame">
              <button class="custom-btn" id="kakao-login-btn">카카오로 로그인하기</button>
              <button class="custom-btn" id="naver-login-btn">네이버로 로그인하기</button>
              <button class="custom-btn" id="number-login-btn">번호로 인증하기</button>
          </div>
        </div>
      </div>
    </div>
    <div class="popup-foot">
      <span class="pop-btn close" id="close-login" >창 닫기</span>
    </div>
  </div>
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
				<button type="button" id="phoneNum-btn" value="인증번호 전송" onclick="ajax_phonenum()" style="margin-top:8px;">인증번호 전송</button>
			</form>
          	</div>
          	<div class="checkframe" id="checkframe"> 
          	<form id="codeForm">
				<h4>인증코드 입력하세요</h4>
				<h6><laber for="Timer">남은 시간: (3분 내에 입력하시오.)</laber></h6><br/>
				<input type="text" id="codeNum" name="codeNum" size="30" style="margin-top: 7px;" >
				<button type="button" value="인증하기" onclick="ajax_codenum()" style="margin-left: 15px;">인증하기</button>
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




<div class="popup-wrap" id="popup_map">
    <div class="popup">
      <div class="popup-head">
          <span class="head-title"> PANDANG</span>
      </div>
      <div class="popup-body">
      	<div class="body-content">
      	   <div class="body-titlebox">
      	   	 <h4> 주소 입력하세요</h4>
      	   	 <div class="search-frame">
      	   	  <input id="address" placeholder="주소 입력"/>
			  <button id="button">검색</button>
			  <div id="resultAddress"></div>
              <div id="searchResult"></div>
      	   	 </div>

			 <div id="map" style="width:250px;height:250px;"></div>
		  </div>
		</div>
	</div>
	<div class="popup-foot">
        <span class="pop-btn next" id="next-agree">다음</span>
        <span class="pop-btn close" id="close-map">창 닫기</span>
      </div>
      </div>
</div>


   
	<div class="popup-wrap" id="popup-agree">
      <div class="popup">
     	 <div class="popup-head">
           <span class="head-title">PANDANG</span>
      	 </div>
         <div class="popup-body">
           <div class="body-content">
             <div class="body-titlebox">
             <h1>이용 약관</h1>
            <div class="check_group">
            <label for="all"><input type="checkbox" id="all-check" name="chkAll"> <b>전체 약관에 동의.</b></label><br/>
            <p>
            <hr>
            <p>
            <label for="check1"><input type="checkbox" name="check" id="check1" data-required="true"> 이용약관에 동의합니다.(필수)</label><br/>
            <p>
            <label for="check2"><input type="checkbox" name="check" id="check2" data-required="true"> 개인정보 수집 및 이용에 동의합니다.(필수)</label><br/>
            <p>
            <label for="check3"><input type="checkbox" name="check" id="check3" data-required="true"> 위치정보 서비스 이용약관(필수)</label><br/>
            <p>
            <label for="check4"><input type="checkbox" name="check" id="check4" > 개인정보 처리 위탁 동의</label><br/>
            <p>
            <label for="check5"><input type="checkbox" name="check" id="check5" > 개인정보 제3자 제공 동의</label><br/>
            </div>
          </div>
        </div>
      </div>
      <div class="popup-foot">
        <span class="pop-btn confirm" id="confirm">확인</span>
        <span class="pop-btn close" id="close-agree">창 닫기</span>
      </div>
    </div>
</div>


<script>


      var container = document.getElementById('map');
      var options = {
         center: new kakao.maps.LatLng(33.450701, 126.570667),
         level: 3
      };
     
      var map = new kakao.maps.Map(container, options);


      var marker = new kakao.maps.Marker();
      marker.setMap(map);
     
      function handleClickEvent(mouseEvent) {
          var latlng = mouseEvent.latLng;
         
          marker.setPosition(latlng);
         
          var resultDiv = document.getElementById('result');
      }
     
      kakao.maps.event.addListener(map, 'click', handleClickEvent);
   </script>


    <script>
        function searchAddress() {
            var divAddress = document.getElementById("resultAddress");
            var addr = document.getElementById("address").value;
            var geocoder = new kakao.maps.services.Geocoder();
            geocoder.addressSearch(addr, function (result, status) {
                console.log(result, status);
                if (status === "OK") {
                    var address = result[0].road_address || result[0].address;
                    divAddress.innerText = address.address_name;


                    var mapCenter = new kakao.maps.LatLng(result[0].y, result[0].x);
                    map.setCenter(mapCenter);
                } else if (status === "ZERO_RESULT") {
                    divAddress.innerText = "검색 결과가 없습니다.";
                }
            });
        }


        document.getElementById("button").addEventListener("click", searchAddress);
        document.getElementById("address").addEventListener("keyup", function (e) {
            if (e.key === "Enter") searchAddress();
        });


        document.getElementById("searchButton").addEventListener("click", function () {
            var address = document.getElementById("address").value;
            searchKakaoMaps(address);
        });


        function searchKakaoMaps(query) {
            var xhr = new XMLHttpRequest();
            xhr.open("GET", "/searchAddress?query=" + query, true);
            xhr.onreadystatechange = function () {
                if (xhr.readyState === 4 && xhr.status === 200) {
                    var response = xhr.responseText;
                    document.getElementById("searchResult").innerText = response;
                }
            };
            xhr.send();
        }
    </script>
</body>
</html>

