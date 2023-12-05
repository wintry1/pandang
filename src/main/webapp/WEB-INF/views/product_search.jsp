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
<script defer src="https://unpkg.com/feather-icons"></script>
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
    	modalClose1();
    	deletInfo();
    	window.location.href = "/list";
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
    	modalClose1();
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
            	window.location.href = "/list";
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
	            window.location.href = "/numberuserInsert"; // 이동할 URL을 설정하세요
	        }
	    });
	});
	</script>
<script>
	function initMap() {
		 var container = document.getElementById('map');
	     var options = {
	        center: new kakao.maps.LatLng(37.569716, 126.984233),
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
<body>
	<%
	//로그인이 된 사람들은 로그인정보를 담을 수 있도록한다.
	String user_id = null;
	String user_name = null;
	//만약에 현재 세션이 존재한다면
	if (session.getAttribute("user_name") != null) {
		//그 아이디값을 받아서 userID인스턴스로 관리할 수 있도록 한다.
		user_name = (String) session.getAttribute("user_name");
	}
	if (session.getAttribute("user_seq") != null) {
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

	<!--상품 시작 -->
	<section id="product" class="product">
		<div class="container">
			<div class="section-header">
				<h2>검색결과</h2>
			</div><!--/.section-header-->
			<div class="product-content">
				<div class="row">
					<c:forEach items="${list}" var="dto" varStatus="loop">
						<div class="product-use">
							<form action="/view" method="get">
								<input type="hidden" name="product_seq" value="${dto.product_seq}" />
								<button class="col-md-4 col-sm-6">
									<div class="single-product-item">
										<div class="single-product-img">
											<c:choose>
												<c:when test="${empty dto.prd_image}">
									                <img src="${pageContext.request.contextPath}/upload/default_image.png" alt="Default_Image">
									            </c:when>
									            <c:otherwise>
									                <img src="${pageContext.request.contextPath}${dto.prd_image}" alt="Product_Image">
									            </c:otherwise>
								        	</c:choose>
										</div>
										<div class="single-product-txt">
                                            <div class="product-name" style="float:left; width:60%; white-space: nowrap; overflow: hidden; text-overflow: ellipsis;">
                                                ${dto.prd_title}
                                            </div>

                                            <div class="product-price" style="float:right; width:40%; text-align: right;">
                                                <fmt:formatNumber type="number" maxFractionDigits="3" pattern="#,##0원" value="${dto.prd_price}"/>
                                            </div>

                                            <div class="row">
                                                <div class="col-7">
                                                    <div class="region-name" style="width:60%; text-align: left; margin-top: 5px; margin-left: 15px; white-space: nowrap; overflow: hidden; text-overflow: ellipsis;">
                                                        ${dto.prd_address}
                                                    </div>
                                                </div>
                                                <div class="col-3" id="product-${loop.index}">
                                                    <div class="product-time" style="width:30%; text-align: right; margin-right: 15px;">
                                                    </div>
                                                </div>
												
												<script>
													document.addEventListener("DOMContentLoaded", function() {
														const postTime = "${dto.prd_at}";
														const timeSincePost = getTimeDifferenceString(postTime);
														const productTimeElement = document.getElementById("product-${loop.index}").getElementsByClassName("product-time")[0];
														productTimeElement.innerText = timeSincePost;
													});
													
													function getTimeDifferenceString(postTime) {
														const currentTime = new Date();
														const postDate = new Date(postTime);
					
														const timeDifference = currentTime - postDate;
														const seconds = Math.floor(timeDifference / 1000);
														const minutes = Math.floor(seconds / 60);
														const hours = Math.floor(minutes / 60);
														const days = Math.floor(hours / 24);
					
														if (days > 0) {
															return days + "일 전";
														} else if (hours > 0) {
															return hours + "시간 전";
														} else if (minutes > 0) {
															return minutes + "분 전";
														} else {
															return seconds + "초 전";
														}
													}
												</script>
												
											</div>
										</div>
									</div>
								</button>
							</form>
						</div>
					</c:forEach>
				</div>
			</div>
			
			<div class="read-more">
				<button class="read-more-btn" id="load">
					더보기
				</button>
			</div>
			
		</div><!--/.container-->
	</section>
	<!--상품 끝 -->
<!--모달 창 -->

<div class="container_d">

<!-- Popup for Login -->
<div class="popup-wrap_d" id="popup_login">
  <div class="popup_d">
    <div class="popup-head_d">
      <div class="head-title_pan_d">PAN</div>
      <div class="head-title_dang_d">DANG</div>
    </div>
      <div class="popup-body_d login">
        <div class="body-content_d">
          <div class="body-titlebox_d">
            <h70>로그인/회원가입</h70>
            <div class="frame_d">
              <button class="custom-btn_d" id="kakao-login-btn">카카오로 로그인하기</button>
              <button class="custom-btn_d" id="naver-login-btn">네이버로 로그인하기</button>
              <button class="custom-btn_d" id="number-login-btn">휴대번호 인증하기</button>
          </div>
        </div>
      </div>
    </div>
    <div class="popup-foot_d">
      <span class="pop-btn_d close" id="close-login" >닫기</span>
    </div>
  </div>
</div>

<!-- Popup for Number Authentication -->
<div class="popup-wrap_d" id="popup_numberOK">
    <div class="popup_d">
      <div class="popup-head_d">
          <div class="head-title_pan_d">PAN</div>
          <div class="head-title_dang_d">DANG</div>
      </div>
      <div class="popup-body_d">
        <div class="body-content_d">
          <div class="body-titlebox_d">
            <h72>번호로 인증하기</h72>
            <br><br>
            <hr class="hr_d">
            <div class="number_frame_d">
            
            <div class="sendframe_d" id="sendframe">
            <form id="phonenumForm_d">
				<h74> 휴대폰 번호를 입력하세요</h74><br>
				<h76>( '-' 없이 숫자만 입력)</h76>
				<p></p>
				<div style="margin-top:10px;">
				 <input type="text" id="phoneNum" name="phoneNum" size="30" style="color:black;">
				 <button type="button" class="button_d" id="phoneNum-chek" value="인증번호 전송" onclick="ajax_phonenum()">인증번호 전송</button>
			    </div>
			</form>
          	</div>
          	<div class="checkframe_d" id="checkframe"> 
          	<form id="codeForm_d">
				<h74>인증코드 입력하세요</h74><br>
				<h76>3분 이내 입력하세요.</h76>
				<div id="timer" style="font-size:13px">03:00</div>
				<div style="margin-top:10px;">
				  <input type="text" id="codeNum" name="codeNum" size="30" style="margin-top: 3px; color:black;" >
				  <button type="button" id="codeNum-chek" class="button_d" value="인증하기" onclick="ajax_codenum()">인증하기</button>
				</div>
			</form>	
          	</div>
          	</div>
          </div>
        </div>
      </div>
      <div class="popup-foot_d">
        <span class="pop-btn_d" id="next-map">다음</span>
        <span class="pop-btn_d" id="close-numberOK">닫기</span>
      </div>
    </div>
</div>

<!-- Popup for Map -->
<div class="popup-wrap_d" id="popup_map">
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
        <span class="pop-btn_d close" id="close-map">닫기</span>
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
            <label for="all-check"><input type="checkbox" id="all-check" class="input_d" name="chkAll"> <b>전체 약관에 동의.</b></label><br/>
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
        <span class="pop-btn_d confirm" id="confirm">확인</span>
        <span class="pop-btn_d close" id="close-agree">닫기</span>
      </div>
    </div>
</div>

</div>
	<!--모달창 끝 -->
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
