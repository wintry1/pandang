<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
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
<title>상품 등록</title>
	<script src="//dapi.kakao.com/v2/maps/sdk.js?appkey=d2d8856f21736abb5201a83471515122&libraries=services"></script>
	<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
	
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
	
	<section id="product-regist">
		<div class="container" style="display:flex; justify-content:center;">
			<div class="row">
				<div class="product-regist-item">
					<div class="product-regist-txt">
						<div class="regist_top">
							상품 등록
						</div>
						<div class="regist_box">
					    	<div class="image_box" style="margin: 10px 0 38px; padding: 10px 0 20px; border-bottom: 1px solid #e5e8eb;">
							    <div class="col-xs-3">
							    	<div class="product-regist-image">상품 이미지</div>
							    	
							    	<button type="button" onclick="triggerFileUpload()">
							    		<img src=/img/write_image.png alt="여기를 클릭하세요" style="margin-left: -30px; margin-top: 10px; border:none;max-width:100%; height:auto; width: 100%;">
							    	</button>
							    	<form id="uploadForm" action="/uploadOk" method="post">
										<input type="file" name="files" accept="image/*" id="fileUpload" style="display:none" onchange="submitForm()">
										<input type="submit" value="File Upload" id="submitButton" style="display: none;">
										<input type="hidden" name="files_name" id="files_name" value="">
									</form>
							    </div>
						    	<div class="product-regist-img">
						            <button class="delete-button"></button>
						    	</div>
					    	</div>
							
							<div class="title_box" style="margin: 10px 0 32px; padding: 0 0 35px; border-bottom: 1px solid #e5e8eb;">
							    <div class="col-xs-3">
							    	<div class="product-regist-title" style="margin-top: 7px;">상품 제목</div>
							    </div>
							    
							    <div class="product-regist-title">
							    	<input type="text" name="prd_title" class="title_input" placeholder="상품 제목을 입력해주세요" maxlength="30" style="">
							    </div>
					    	</div>
					    	
					    	<div class="price_box" style="margin: 10px 0 32px; padding: 0 0 35px; border-bottom: 1px solid #e5e8eb;">
							    <div class="col-xs-3">
							    	<div class="product-regist-price" style="margin-top: 7px;">가격 입력</div>
							    </div>
							    
							    <div class="product-regist-price">
							    	<input type="text" name="prd_price" class="price_input" placeholder="상품 가격을 입력해주세요" maxlength="10" style="">
							    </div>
					    	</div>
					    	
					    	<div class="ctnt_box" style="margin: 10px 0 32px; padding: 0 0 35px; border-bottom: 1px solid #e5e8eb;">
							    <div class="col-xs-3">
							    	<div class="product-regist-ctnt" style="margin-top: 7px;">상품 설명</div>
							    </div>
							    
							    <div class="product-regist-ctnt">
							    	<textarea name="prd_ctnt" class="ctnt_input" placeholder="상품 설명을 입력해주세요" maxlength="200" style="resize: none;"></textarea>
							    </div>
					    	</div>
					    	
					    	<div class="region_box" style="margin: 10px 0 30px; padding: 0 0 0;">
							    <div class="col-xs-3">
							    	<div class="product-regist-region" style="margin-top: 7px;">거래 지역</div>
							    	<div class="map_guide" style="width: 130%; margin-left: -30px; margin-top: 25px;">
							    		<img src=/img/img_mk.png>
							    	</div>
							    </div>
							    
							    <div class="product-regist-region">
							    	<input type="text" id="address" name="regist_region" class="region_input" placeholder="거래 지역을 검색해주세요" maxlength="50" style="">
									<button id="button"><img src="https://s3.ap-northeast-2.amazonaws.com/cdn.wecode.co.kr/icon/search.png"></button>
									
							    	<div class="product-regist-map" style="margin-top:-10px;">
							    		<div id="map" style="width:100% ;height:400px; border-radius:10px;"></div>
							    	</div>
							    </div>
					    	</div>
				    	</div>
						<div class="submit_box" style="display:flex; justify-content:center;">
							<a href="list">
								<button id="cancle_btn" class="cancle_btn" style="margin-right: 12px;">
									취소
								</button>
							</a>

							<div class="register" onclick="sendDataToWrite()">
								<button id="register_btn" class="register_btn" style="margin-right: 12px;">
									등록하기
								</button>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>
	
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
	<script>
		var container = document.getElementById('map');
		var options = {
			center: new kakao.maps.LatLng(${list.user_latitude}, ${list.user_longitude}),
			level: 3
		};
		
		var map = new kakao.maps.Map(container, options);

		var marker = new kakao.maps.Marker(); 

		marker.setMap(map);
		
		function handleClickEvent(mouseEvent) {
		    var latlng = mouseEvent.latLng; 
		    
		    marker.setPosition(latlng);
		    
		    var resultDiv = document.getElementById('result'); 
		    
		    sendCoordinates(latlng.getLat(), latlng.getLng());
		}
		
		kakao.maps.event.addListener(map, 'click', handleClickEvent);
	</script>
	
	<script>
		function searchAddress() {
		    var addrInput = document.getElementById("address");
		    var divAddress = document.getElementById("resultAddress");
		    var addr = addrInput.value;
		    var geocoder = new kakao.maps.services.Geocoder();
		    
		    geocoder.addressSearch(addr, function(result, status) {
		        if (status === "OK") {
		            var address = result[0].road_address || result[0].address;
		            var fullAddress = address.address_name;
		            
		            addrInput.value = fullAddress;
	
		            var mapCenter = new kakao.maps.LatLng(result[0].y, result[0].x);
		            map.setCenter(mapCenter);
	
		            sendCoordinates(result[0].y, result[0].x);
		        } else if (status === "ZERO_RESULT") {
		            divAddress.innerText = "검색 결과가 없습니다.";
		        }
		    });
		}
		
		document.getElementById("button").addEventListener("click", searchAddress);
		document.getElementById("address").addEventListener("keyup", function(e) {
		    if (e.key === "Enter") searchAddress();
		});

		function searchKakaoMaps(query) {
		    var xhr = new XMLHttpRequest();
		    xhr.open("GET", "/searchAddress?query=" + query, true);
		    xhr.onreadystatechange = function() {
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
	</script>
	<script>
		function triggerFileUpload() {
			  document.getElementById('fileUpload').click();
			}
	   
		function submitForm() {
			  document.getElementById('submitButton').click();
			}
	
	
		$(document).ready(function () {
		    $("#uploadForm").submit(function (event) {
		        event.preventDefault();
		
		        var formData = new FormData($(this)[0]);
		
		        $.ajax({
		            url: "/uploadOk",
		            type: "POST",
		            data: formData,
		            async: true,
		            cache: false,
		            contentType: false,
		            processData: false,
		            success: function (data) {
		                var response = JSON.parse(data);
		                if (response.success) {
		                    var imagePath = response.imagePath;
		                    
		                    var imgElement = '<div class="uploaded-image">' + 
		                    					'<button class="delete-button"><img src="assets/images/icon/image_delete.png"></button>' +
						                        '<img src="' + imagePath + '" alt="Uploaded Image ">' +
						                     '</div>';
						 	$(".product-regist-img").append(imgElement);
		                    
						 	$("#files_name").val(imagePath);
		                } else {
		                    alert("업로드 실패");
		                }
		            },
		            error: function () {
		                alert("오류 발생입니다.");
		            }
		        });
		    });
		    
		    $(".product-regist-img").on("click", ".delete-button", function() {
		    	$(this).closest(".uploaded-image").remove();
		    });
		    
		});
	</script>
	<script>
		// 가격 입력(숫자만)
		var priceInput = document.querySelector('.price_input');
	
		priceInput.addEventListener('input', function(event) {
		    // 숫자가 아닌 문자를 빈 문자열로 대체
		    var inputValue = event.target.value;
		    var numericValue = inputValue.replace(/\D/g, '');
		    
		 	// 선행하는 0 제거하여 "0001"과 같은 수를 "1"로 변환 방지
		    numericValue = numericValue.replace(/^0+/, '');
		 	
		 	// 숫자 형식으로 변환하여 NaN 체크
	        var numberValue = parseFloat(numericValue.replace(/,/g, ''));
	        if (!isNaN(numberValue)) {
	            var formattedValue = numberValue.toLocaleString('ko-KR');
	
	            // 입력된 값을 포맷된 숫자로 업데이트
	            event.target.value = formattedValue;
	        } else {
	            // NaN이면 빈 문자열로 설정
	            event.target.value = '';
	        }
		});
	</script>
	<script>
		// 등록하기 버튼
		function sendDataToWrite() {
			console.log(111)
		    // 각 섹션에서 데이터 수집
		    var prd_title = document.querySelector('.title_input').value; // 상품 제목
		    var prd_price = document.querySelector('.price_input').value; // 상품 가격
		    var prd_ctnt = document.querySelector('.ctnt_input').value; // 상품 설명
		    var files_name = document.querySelector('#files_name').value; // 거래 지역
			
		    // 수집한 정보로 데이터 객체 생성
		    var data = {
		        prd_title: prd_title,
		        prd_price: prd_price,
		        prd_ctnt: prd_ctnt,
		        files_name: files_name
		    };
		    console.log(data)
		    // jQuery를 사용하여 Ajax 호출
		    $.ajax({
		        url: '/write',
		        type: 'POST',
		        contentType: 'application/json',
		        data: JSON.stringify(data),
		        success: function(response) {
		        	window.location.href = '/';
		        },
		        error: function(error) {
		            // Ajax 호출 중 오류 발생 시 처리
		            console.error('오류 발생:', error);
		        }
		    });
		}
	</script>
</body>
</html>