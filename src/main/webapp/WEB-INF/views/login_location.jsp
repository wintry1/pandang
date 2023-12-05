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
<link href="https://fonts.googleapis.com/css?family=Poppins:100,100i,200,200i,300,300i,400,400i,500,500i,600,600i,700,700i,800,800i,900,900i" rel="stylesheet">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
<link href="https://fonts.googleapis.com/css2?family=Lato&display=swap" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Cormorant+Garamond:wght@500&display=swap" rel="stylesheet">
<script src="//dapi.kakao.com/v2/maps/sdk.js?appkey=d2d8856f21736abb5201a83471515122&libraries=services"></script>
<link rel="stylesheet" type="text/css" href="assets/css/dstyle.css">

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
<script>
$(document).ready(function() {
	$("#confirm").css("pointer-events", "none").css("opacity", "0.5");
	$("#next-agree").css("pointer-events", "none").css("opacity", "0.5");
	initMap();
});
$(function(){
	 function modalClose2(){
	 	$("#popup_map").fadeOut();
	    $("#map").hide();
	}
    $("#next-agree").click(function(){
    	modalClose2();
       $("#popup_agree").css('display','flex').hide().fadeIn();
     });
    $("#confirm").click(function(){
	    modalClose2();
	    window.location.href = "/list";
    });
});


</script>
<script>
	//전체 선택시 전체 선택 또는 전체 해제
	document.addEventListener('DOMContentLoaded', function () {
	  const allCheck = document.getElementById('all-check');
	  const checkboxes = document.getElementsByName('check');
	  const confirmButton = document.getElementById('confirm');
	
	
	  // "모든 약관에 동의합니다." 체크박스를 클릭했을 때
	  allCheck.addEventListener('change', function () {
		checkboxes.forEach((checkbox) => {
		  checkbox.checked = allCheck.checked;
		});
		updateConfirmButtonStatus();
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
	            updateConfirmButtonStatus(); // 변경 시 버튼 상태 업데이트
	        });
	    });

	    function updateConfirmButtonStatus() {
	        const allRequiredChecked = Array.from(checkboxes).filter((c) => c.getAttribute('data-required') === 'true').every((c) => c.checked);

	        if (allRequiredChecked) {
	            confirmButton.disabled = false;
	            $("#confirm").css("pointer-events", "auto").css("opacity", "1");
	        } else {
	            confirmButton.disabled = true;
	            $("#confirm").css("pointer-events", "none").css("opacity", "0.5");
	        }
	    }

	    confirmButton.addEventListener('click', function () {
	        if (!confirmButton.disabled) {
	            // 필수 항목이 모두 선택되었을 때 페이지 이동 또는 기타 작업 수행
	            window.location.href = "/locationUpdate"; // 이동할 URL을 설정하세요
	        }
	    });
	});
	</script>
</head>
<body style="background: #e0e5ec;">

<div class="container_d">

	<!-- Popup for Map -->
	<div class="m-popup-wrap_d" id="popup_map">
		<div class="popup_d">
		  <div class="popup-head_d">
			 <div class="head-title_pan_d">PAN</div>
      		 <div class="head-title_dang_d">DANG</div>
		  </div>
		  <div class="popup-body_d">
			  <div class="body-content_d">
				 <div class="body-titlebox_d">
					  <h74> 주소 입력하세요</h74>
					  <div class="search-frame_d">
					   <input id="address" placeholder="주소 입력"/>
				  <button id="button" class="button_d">검색</button>
				  <div id="resultAddress"></div>
				  <div id="searchResult"></div>
					  </div>
	
				 <div id="map" style="width:380px;height:250px;"></div>
			  </div>
			</div>
		</div>
		<div class="popup-foot_d">
			<span class="pop-btn_d next" id="next-agree">다음</span>
		  </div>
		  </div>
	</div>
	<!-- Popup for Agreement -->  
	<div class="popup-wrap_d" id="popup_agree">
		<div class="popup_d">
			<div class="popup-head_d">
			 <div class="head-title_pan_d">PAN</div>
      		 <div class="head-title_dang_d">DANG</div>
			</div>
		<div class="popup-body_d">
			<div class="body-content_d">
			<div class="body-titlebox_d">
			<h1 style="color:black; font-weight:bold; font-size:25px;">이용 약관</h1>
			<div class="check_group_d">
			<label for="all"><input type="checkbox" id="all-check" class="input_d" name="chkAll"> <b>전체 약관에 동의.</b></label><br/>
			<p>
			<hr>
			<p>
			<label for="check1"><input type="checkbox" name="check" id="check1" class="input_d" data-required="true"> 이용약관에 동의합니다.(필수)</label><br/>
			<p>
			<label for="check2"><input type="checkbox" name="check" id="check2" class="input_d" data-required="true"> 개인정보 수집 및 이용에 동의합니다.(필수)</label><br/>
			<p>
			<label for="check3"><input type="checkbox" name="check" id="check3" class="input_d" data-required="true"> 위치정보 서비스 이용약관(필수)</label><br/>
			<p>
			<label for="check4"><input type="checkbox" name="check" id="check4" class="input_d"> 개인정보 처리 위탁 동의</label><br/>
			<p>
			<label for="check5"><input type="checkbox" name="check" id="check5" class="input_d"> 개인정보 제3자 제공 동의</label><br/>
			</div>
			</div>
		</div>
		</div>
		<div class="popup-foot_d">
		<span class="pop-btn_d confirm" id="confirm" >확인</span>
		</div>
	</div>
	</div>

</div>


<script>
	function initMap() {
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
	         sendCoordinates(latlng.getLat(), latlng.getLng());
	         
	         var resultDiv = document.getElementById('result');
	         $("#next-agree").css("pointer-events", "auto").css("opacity", "1");
	     }
	     
	     kakao.maps.event.addListener(map, 'click', handleClickEvent);
	     
	     
	     function searchAddress() {
	         var divAddress = document.getElementById("resultAddress");
	         var addr = document.getElementById("address").value;
	         var geocoder = new kakao.maps.services.Geocoder();
	         geocoder.addressSearch(addr, function (result, status) {
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
	     
	     function sendCoordinates(latitude, longitude) {
	            var xhr = new XMLHttpRequest();
	            xhr.open("POST", "/kakaosearch?latitude=" + latitude + "&longitude=" + longitude, true);

	            xhr.send();
	        }
	}
   
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

