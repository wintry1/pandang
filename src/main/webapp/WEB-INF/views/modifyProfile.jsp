<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<link href="https://fonts.googleapis.com/css?family=Poppins:100,100i,200,200i,300,300i,400,400i,500,500i,600,600i,700,700i,800,800i,900,900i" rel="stylesheet">
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
	$("#checkframe").css("display", "none");
	$("#codeNum-chek").prop("disabled", false);
	$("#next-map").css("pointer-events", "none").css("opacity", "0.5");
	$("#next-agree").css("pointer-events", "none").css("opacity", "0.5");
});
$(function(){
	$(document).ready(function() {
		$("#modal-open").click(function () {
			$("#popup_login").css('display','flex').hide().fadeIn();
	    });
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
	
    $("#close-numberOK").click(function(){
    	modalClose11();
    });
    
    function modalClose11(){
      	$("#popup_numberOK").fadeOut();
    }


    $("#next-map").click(function(){
    	modalClose11();
      	$("#popup_map").css('display','flex').hide().fadeIn();
      	initMap();
      	
    });
    
    
    $("#close-map").click(function(){
      modalClose2();
    });
    function modalClose2(){
      $("#popup_map").fadeOut();
      $("#map").hide();
    }
   
    
    
    $("#next-agree").click(function(){
    	modalClose1();
    	modalClose2();
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

function ajax_phonenum() {
    var formData = $("#phonenumForm_d").serialize();
    console.log(123123123123123132132);
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
				var threeMinutes = 180,
                display = document.querySelector('#timer');
            	startTimer(threeMinutes, display);
            } else {
            	alert(result.desc);
            }
        }
    });
}	

function ajax_codenum() {
    var formData = $("#codeForm_d").serialize();
    $.ajax({
        type: "GET",
        url: "/checkCode",
        data: formData,
        dataType: 'text',
        success: function(json) {
        	var result = JSON.parse(json);				
			if (result.code == "sing-in") {
				alert(result.desc);
				console.log("되고있나");
				$("#codeNum-chek").prop("disabled", true);
				clearInterval(countdown);
				$("#next-map").css("pointer-events", "auto").css("opacity", "1");
				
            }else if(result.code == "login"){
            	console.log("되고있나3");
            	window.location.href = "/list";
            } else {
            	alert(result.desc);
            	console.log("되고있나2");
            }
        }
    });
}	

var countdown; // variable to store the timer

function startTimer(duration, display) {
    var timer = duration, minutes, seconds;
    countdown = setInterval(function () {
        minutes = parseInt(timer / 60, 10);
        seconds = parseInt(timer % 60, 10);

        minutes = minutes < 10 ? "0" + minutes : minutes;
        seconds = seconds < 10 ? "0" + seconds : seconds;

        display.textContent = minutes + ":" + seconds;

        if (--timer < 0) {
            clearInterval(countdown); // clear the timer when it reaches zero
            // Add any action you want to perform when the timer reaches zero
            $("#codeNum-chek").prop("disabled", true);
            deletInfo();
            alert("Time's up!");
        }
    }, 1000);
}

function deletInfo() {
	$.ajax({
        type: "GET",
        url: "/deleteCode",
        data: { phoneNum: $("#phoneNum").val() },
        dataType: 'text',
        success: function(json) {
        	console.log("삭제 성공");
        }
    });	
}
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
        window.location.href = "/numberuserInsert"; // 이동할 URL을 설정하세요
      }
    });
});
</script>
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
</head>
<style>    
.nav-tabs .nav-item .nav-link {
  color: black;
  font-size: 17px;
}

.nav-tabs .nav-item.active .nav-link{
  color: #e37e02;
  font-size: 17px;
  font-weight: bolder;
}

.nav-tabs > li > a
{
    /* adjust padding for height*/
    padding-left: 120px; 
    padding-right: 120px;
}
        
</style>
<body>

	<%
	//로그인이 된 사람들은 로그인정보를 담을 수 있도록한다.
	String user_id = null;
	//만약에 현재 세션이 존재한다면
	if (session.getAttribute("user_id") != null) {
		//그 아이디값을 받아서 userID인스턴스로 관리할 수 있도록 한다.
		user_id = (String) session.getAttribute("user_id");
	}
	%>
	
	<section class="top-area">
		<div class="header-area">
			<!-- Start Navigation -->
			<nav class="navbar navbar-default bootsnav  navbar-sticky navbar-scrollspy" data-minus-value-desktop="70"
				data-minus-value-mobile="55" data-speed="1000">
				
				<div class="container">

					<!--  상단 네비게이션바 시작 -->
					<div class="navbar-header">
						<button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#navbar-menu">
							<i class="fa fa-bars"></i>
						</button>
						<a class="navbar-brand" href="/list">PAN<span>DANG</span></a>
					</div><!--/.navbar-header-->
					
					<!-- Collect the nav links, forms, and other content for toggling -->
					<div class="collapse navbar-collapse menu-ui-design" id="navbar-menu">
						<ul class="nav navbar-nav navbar-right" data-in="fadeInDown" data-out="fadeOutUp">
							<li>
								<form action="/search" method="get">
									<div class="search-form">
						  				<input type="text" name="search_words" placeholder="상품이나 지역을 검색해보세요" maxlength="50">
						  					<button type="submit"><img src="https://s3.ap-northeast-2.amazonaws.com/cdn.wecode.co.kr/icon/search.png"></button>
									</div>
								</form>
							</li>
							<li><a href="javascript:void(0);" onclick="checkLoginProduct()">상품등록</a></li>
							<li><a href="javascript:void(0);" onclick="checkLoginNotice()">알림</a></li>
							<%
							// 로그인/회원가입은 로그인이 되어있지 않은 경우만 나오게한다.
							if (user_id == null) {
							%>
							<li><a href="#" id="modal-open">로그인/회원가입</a></li>
							<%
							// 로그인이 되어있는 사람만 볼수 있는 화면
							} else {
							%>
							<li><a href="/Profile">내정보</a></li>
							<%
								}
							%>
							
						</ul><!--/.nav -->
					</div><!-- /.navbar-collapse -->
				</div><!--/.container-->
			</nav><!--/nav-->
			<!--  상단 네비게이션바 끝 -->
			
		</div><!--/.header-area-->
		<div class="clearfix"></div>
	</section><!-- /.top-area-->

	<!--프로필 헤더 시작 -->
	<section id="profile" class="profile">
		<div class="container">
			<div class="section-header">
				<h2 class="text-left">나의 프로필</h2>
				<div class="row">				
					<div class="col-xs-2">
						<img src="/img/panda.jpg" width="100" align="right">
					</div>
					<form action="changeName" method="get">
					    <div class="col-2" align="left" style="margin: 10px 0px 10px 0px;">
					        <input type="text" id="newName" name="newName" placeholder="새로운 닉네임을 입력해 주세요" maxlength="20" style="padding:5px; margin-left:15px; width: 340px; height: 35px; color: black;">
					    </div>
					    <div class="col-xs-2" id="bottom" style="margin-right: -20px;">
					        <button type="submit" class="btn btn-primary btn-block" value="수정" >닉네임 변경</button>
					    </div>
					</form>
					<form action="deleteUser" method="get">
						<div class="col-xs-2" id="bottom">
							<button type="submit" class="btn btn-danger btn-block" value="회원탈퇴" >회원 탈퇴</button>
						</div>
					</form>
				</div>
			</div><!--/.section-header-->
			<div class="product-content">
			</div>			
		</div><!--/.container-->
	</section>
	<!--프로필 헤더 끝 -->

	<!--하단바 시작-->
	<footer id="footer" class="footer">
		<div class="container">
			<div class="footer-menu">
				<div class="row">
					<div class="col-sm-3">
						<div class="navbar-header">
							<a class="navbar-brand" href="">PAN<span>DANG</span></a>
						</div><!--/.navbar-header-->
						
						<div class="navbar-header">
							<br>
							<p>© PANDANG all rights reserved</p>
						</div>
						
					</div>
					<div class="col-sm-9">
						<ul class="footer-menu-item">
							<li><a href="mailto:jhpark1@gmail.com">박정현</a></li>
							<li><a href="mailto:spilite@naver.com">강해마루</a></li>
							<li><a href="mailto:gmltmd189@gmail.com">권도해</a></li>
							<li><a href="mailto:myteo979797@gmail.com">김민재</a></li>
						</ul><!--/.nav -->
					</div>
				</div>
			</div>
		</div><!--/.container-->
		<div id="scroll-Top">
			<div class="return-to-top">
				<i class="fa fa-angle-up " id="scroll-top" data-toggle="tooltip" data-placement="top" title=""
					data-original-title="Back to Top" aria-hidden="true"></i>
			</div>
		</div>
	</footer>
	<!--하단바 끝-->
	<script>
		function guestLogin() {
			$("#popup_login").css('display','flex').hide().fadeIn();
		}
		function checkLoginNotice() {
	        var isLoggedIn = '<%= user_id %>';
	
	        if (isLoggedIn === 'null') {
	        	guestLogin();
	        } else {
	        	window.location.href = "/noticelist";
	        }
	    }
		function checkLoginProduct() {
	        var isLoggedIn = '<%= user_id %>';

	        if (isLoggedIn === 'null') {
	        	guestLogin();
	        } else {
	        	window.location.href = "/write_view";
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
