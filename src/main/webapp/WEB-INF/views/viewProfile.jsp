<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<%-- <%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList"%> --%>
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
    	// 초기 선택된 아이콘 없음
        var selectedIcon = null;
    	var score = 0;

        // 아이콘 클릭 이벤트 처리
        $(".m-review_icon_btn").click(function() {
            // 현재 클릭한 아이콘의 ID 가져오기
            var clickedIcon = $(this).attr("id");

            // 이미 선택된 아이콘이 있는 경우 선택 해제
            if (selectedIcon !== null) {
                $("#" + selectedIcon).removeClass("selected");
            }

            // 선택된 아이콘을 현재 클릭한 아이콘으로 설정
            selectedIcon = clickedIcon;

            // 선택된 아이콘에 클래스 추가
            $("#" + selectedIcon).addClass("selected");
	
            if (selectedIcon === "review_smile") {
                score = 5;
            } else if (selectedIcon === "review_meh") {
                score = 0;
            } else if (selectedIcon === "review_frown") {
                score = -5;
            }
            // 선택된 아이콘에 따라 점수 표시
            
            console.log("점수: " + score);  
        });
        $("#review_btn").click(function() {
            // textarea에서 입력된 텍스트 가져오기
            var reviewText = $(".m-review_textarea").val();
            var user_seq = ${user_seq};
            var product_seq = ${product_seq};
			console.log(score);
			console.log(reviewText);
            // AJAX를 사용하여 서버로 데이터 전송
            $.ajax({
                type: "POST", 
                url: "/seller_review",
                data: {score: score, reviewText: reviewText, user_seq: user_seq, product_seq: product_seq },
                success: function(json) {
                    console.log("데이터 전송 성공", score, reviewText);
                    window.location.href ="/Profile";
                },
                error: function(error) {
                    console.error("데이터 전송 실패", error);
                }
            });
        });		
        $("#modal_close").click(function(){
            modalClose1();
	     });
	     function modalClose1(){
	         $("#modal_buyer").fadeOut();
	         $("#div1").fadeOut();
	     }
	
	     $("#modal-open2").click(function () {
	         modalClose1();
	         $("#div2").css('display','flex').hide().fadeIn();
	         $("#m-select-review").css('display','flex').hide().fadeIn();
	     });
	     $("#review-close-btn").click(function(){
	            modalClose2();
	     });
	     function modalClose2(){
	         $("#m-select-review").fadeOut();
	         $("#div2").fadeOut();
	     }
	});
	
</script>
</head>

<style>
#bottom {
            position: relative;
            bottom: -50px;
            left: 0px;
        }
        
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

.container_m {
	width: 100%;
}
.modal-btn_box{
	width: 100%;
	height: 20%;
	display:inline-block;
}

.modal_btn{
	width: 100px;
	height: 50px;
	background-color:#bd00ff;
}
.modal-btn_box2{
	width: 100%;
	height: 20%;
	display:inline-block;
}

.modal_btn2{
	width: 100px;
	height: 50px;
	background-color:yellowgreen;
}
.modal_buyer {
	margin: 20px;
	width: 300px;
    height: 400px;
    border-radius: 5px;
    border: 1px solid grey;
    display: none;
    flex-direction: column;
	z-index:11;
}

.modal_top {
	width: 100%;
    height: 8%;
    background-color: #ffdb99;
}
.modal_close{
	width: 30px;
    height: 30px;
    float: right;
    padding: 3px;
    color: grey;
}
.modal_title{
	width: 100%;
	height: 30%;
	background-color: aliceblue;
}
.product_title{
	padding: 10px;
    width: 90%;
    height: 70%;
    font-size: 20px;
    font-weight: bold;
    color: black;
}
.product_nickname{
	padding: 10px 10px 30px 10px;
    width: 90%;
    height: 30%;
    font-size: 16px;
    color: black;
}


.modal_content{
	padding: 10px 10px 10px 10px;
	width: 100%;
    height: 60%;
    background-color: #ffdb99;
    display: flex;
    flex-direction: column;
    overflow: scroll;
}
.buyer_list{
	margin: 10px;
    width: 90%;
    
    font-size: 20px;
    border-bottom: 1px solid black;
    padding: 5px;
    color: black;
}


.modal_review_p{
    width: 300px;
    height: 400px;
    margin: 20px;
 
}

.m-select-review {
	margin: 0 auto;
	width: 300px;
	height:400px;
	border: 1px solid #b7b7b7;
	background-color: #ffdb99;
	position: relative;
	border-radius: 5px;
	display: none;
	flex-direction: column;
}

.m-review-close-btn {
	margin: 3px;
    width: 30px;
    height: 30px;
    float: right;
    color: grey
}

.m-review-content{
	padding: 20px;
    width: 100%;
    height: 93%;
    position:relative;
}
.m-review_m{
	width:100%;
	height: 25%;
}

.m-review_icon {
	width:100%;
	height: 50%;
	display: flex;
    align-items: center;
    justify-content: space-around;
}
.m-review_icon_btn{
	width: 85px;
    height: 85px;
    color: white;
}

.m-review_text{
	width: 100%;
	height: 40%;
    display: flex;
    align-items: center;
    justify-content: space-around;
}

.m-review_bottom{
	width: 100%;
    height: 25%;
    display: flex;
    align-items: center;
}
.m-review_text {
	 width:80%;
	 height:100%;
}

.m-review_textarea {
	width: 100%;
    height: 100%;
    resize: none;
}

.m-review_text_btn{
	padding:1.5px;
	width: 20%;
	height:100%;
	background-color: white;
	display: flex;
    align-items: center;
    justify-content: center;
    border: 1px solid;
}

.m-review_btn{
	color:black;
}
.div1 {
    position: fixed;
    left: 0;
    right: 0;
    bottom: 0;
    top: 0;
    z-index: 10;
    display: none;
    align-items: center;
    justify-content: center
}
.div2 {
    position: fixed;
    left: 0;
    right: 0;
    bottom: 0;
    top: 0;
    z-index: 10;
    display: none;
    align-items: center;
    justify-content: center
}
.m-review_icon_btn:active{
    color: orange;
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
							<li><a href="/write_view">상품등록</a></li>
							<li><a href="/noticelist">알림</a></li>
							
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
	
	<% String nickName = (String)session.getAttribute("user_name"); %>
	<% String product_title = ""; %>
	<% product_title = (String)session.getAttribute("product_title"); %>	
	<% Integer product_seq = (Integer)session.getAttribute("product_seq"); %>	
	
	<!--프로필 헤더 시작 -->
	<section id="profile" class="profile">
		<div class="container">
			<div class="section-header">
				<h2 class="text-left">나의 프로필</h2>
				<div class="row">				
					<div class="col-xs-2">
						<img src="/img/panda.jpg" width="100" align="right">
					</div>
					<div class="col-xs-2" align="left">
						<h4><%= nickName %></h4>
						<h12>${address}</h12>
					</div>					
					<div class="col-xs-2" item="${temp}" var="temp">
						<c:choose>
							<c:when test ="${ temp < 16.5 }">
				                <img src="/img/thermo_1_차갑다.jpg" width="50" align="center">
				                <h7>매너온도: ${temp}</h7>
				            </c:when>
							<c:when test ="${ temp >= 16.5 and temp < 26.5 }">
				                <img src="/img/thermo_2_썰렁하다.jpg" width="50" align="center">
				                <h8>매너온도: ${temp}</h8>
				            </c:when>
							<c:when test ="${ temp >= 26.5 and temp < 46.5 }">
				                <img src="/img/thermo_3_포근하다.jpg" width="50" align="center">
				                <h9>매너온도: ${temp}</h9>
				            </c:when>
							<c:when test ="${ temp >= 46.5 and temp < 66.5 }">
				                <img src="/img/thermo_4_따끈하다.jpg" width="50" align="center">
				                <h10>매너온도: ${temp}</h10>
				            </c:when>
							<c:otherwise>
				                <img src="/img/thermo_5_뜨겁다.jpg" width="50" align="center">
				                <h11>매너온도: ${temp}</h11>
				            </c:otherwise>
						</c:choose>						
					</div>
					<div class="col-xs-2" id="bottom">
						<a href="modifyProfile" ><button type="button" class="btn btn-primary btn-block" value="수정" >프로필 수정</button></a>
					</div>
				</div>
			</div><!--/.section-header-->
			<div class="product-content">
			</div>			
		</div><!--/.container-->
	</section>
	<!--프로필 헤더 끝 -->
	<br><br>
	
	<!--프로필 메뉴 탭 시작 -->
	<section id="profile_menu" class="profile_menu" style="width:100%; height:100%;">
		<div class="container">
			<div class="section-header">
			    <ul class="nav nav-tabs" id="myTabs" style="display:flex;">
			      <li class="nav-item active" style="flex:1;" >
			        <a class="nav-link" data-toggle="tab" href="#sold">판 매   리 스 트</a>
			      </li>
			      <li class="nav-item" style="flex:1;">
			        <a class="nav-link" data-toggle="tab" href="#review">거 래   후 기</a>
			      </li>
			      <li class="nav-item" style="flex:1;">
			        <a class="nav-link" data-toggle="tab" href="#bookmark">찜   목 록</a>
			      </li>
			    </ul><br><br>
			</div>
			<div class="tab-content">			
				<div class="tab-pane active" id="sold">
					<div class="row">
						<c:forEach items="${sellList}" var="dto">
							<div class="col-md-4 col-sm-6">
								<div class="single-product-item">
									<div class="single-product-img">
										<c:choose>
											<c:when test="${empty dto.prd_image}">
								                <img src="${pageContext.request.contextPath}/upload/default_image.png" alt="Default_Image">
								            </c:when>
								            <c:otherwise>
								                <img src="${pageContext.request.contextPath}/upload/${dto.prd_image}" alt="Product_Image">
								            </c:otherwise>
							        	</c:choose>
									</div>
									
									<div class="profile-product-txt">
														
										<div class="product-name">
											${dto.prd_title}
										</div>
										<div class="row">
											<div class="col-sm-7 profile-product-price">												
												<div>
													<fmt:formatNumber type="number" maxFractionDigits="3" pattern="#,##0원" value="${dto.prd_price}"/>
												</div>
											</div>
																				
											<div class="col-sm-5">
												<table class="pull-right" align="center">
													<tr>
														<td>
															<select class="form-control" id="prd_Status" style="width:120px">
																	<option id="StatusS" name="StatusS" value="S">판매완료</option>
																	<option id="StatusR" name="StatusR" value="R">예약중</option>
																	<option id="StatusE" name="StatusE" value="E">판매중</option>
															</select>
														</td>
														<c:choose>
       														<c:when test="${dto.product_seq eq product_seq}">
																<td><button type="button" class="btn btn-info" onclick="modal_on()">후기작성</button></td>																
															</c:when>
															<c:otherwise>
																<td><button type="button" class="btn btn-dark" onclick="ajax_show_buyer(${dto.product_seq})">변경</button></td>																													 	
							            					</c:otherwise>
							            				</c:choose>
													</tr>
												</table>
																			
												<script>
													function ajax_show_buyer(prdSEQ) {
														var prdSeq = prdSEQ;
														
													    $.ajax({
													        type: "GET",
													        url: "/showBuyer",
													        data:  { "product_SEQ": prdSeq },
														    dataType: 'text',
													        success: function(json) {
													        	var result = JSON.parse(json);				
																if (result.code == "success") {
																																	
																	location.reload();
																	
													            } else {
													            	alert(result.desc);
													            }
																
													        }
													    });
													}
													
													function modal_on(){	
														$("#div1").css('display','flex').hide().fadeIn();		       
													    $("#modal_buyer").css('display','flex').hide().fadeIn();		       
													};

												</script>
												
											</div>
										</div>
										<div class="row">
											<div class="col-sm-5 product-status">
												현재 ${dto.prd_use}
											</div>											
										</div>			
									</div>
								</div>
							</div>
						</c:forEach>
					</div>
			  	</div>
			  	
			  	<div class="tab-pane" id="review">
				  	<c:if test="${not empty reviewList}">
				  		<div class="container-fluid"> 				
						  	<div class="row">
						    	<div class="col-8">
									<table align="center" class="table table-striped">
										<thead>
									    	<tr>
												<th scope="col">닉네임</th>
												<th scope="col">주소</th>
												<th scope="col">후기</th>
												<th scope="col">날짜</th> 
										    </tr>
										</thead>
						  	  			<tbody>
											<c:forEach items="${reviewList}" var="dto2">
											<tr scope="row">
												<td> ${dto2.rev_name}</td>
												<td> ${dto2.rev_addr}</td>
												<td> ${dto2.rev_content}</td>
												<td> ${dto2.rev_date}</td>
											</tr>
											</c:forEach>								
										<tbody>				
									</table>
								</div>
					 	 	</div>
						</div>	
				  	</c:if>
			  	</div>
				<div class="tab-pane" id="bookmark">
				  	<div class="row">
						<c:forEach items="${bookmarkList}" var="dto3">
							<form action="/view" method="get">
								<input type="hidden" name="product_seq" value="${dto3.product_seq}" />
								<button class="col-md-4 col-sm-6">
									<div class="single-product-item">
										<div class="single-product-img">
											<c:choose>
												<c:when test="${empty dto3.prd_image}">
									                <img src="${pageContext.request.contextPath}/upload/default_image.png" alt="Default_Image">
									            </c:when>
									            <c:otherwise>
									                <img src="${pageContext.request.contextPath}${dto3.prd_image}" alt="Product_Image">
									            </c:otherwise>
								        	</c:choose>
										</div>
										
										<div class="profile-product-txt">
											
											<div class="product-name">
												${dto3.prd_title}
											</div>
											<div class="row">
												<div class="col-sm-7 profile-product-price">
													<h12>${address}</h12>
													<div>
														<fmt:formatNumber type="number" maxFractionDigits="3" pattern="#,##0원" value="${dto3.prd_price}"/>
													</div>
													
												</div>
												<div class="col-sm-5">
													<div class="product-map-icon">
														<a href="#" id="likeButton" onclick="toggleLike(${dto3.product_seq});"><img id="heartIcon" src="assets/images/icon/heart-fill.png"></a>
													</div>
													
													<script>
														document.getElementById('likeButton').addEventListener('click', function(event) {
														    event.preventDefault();
														});
														
														function toggleLike(product_seq) {
														    $.ajax({
														        type: 'GET', // 또는 'GET' (구현에 따라 다름)
														        url: '/bookmark', // 좋아요 토글을 처리하는 URL
														        data: { product_seq: product_seq }, // 서버로 전송할 데이터
														        success: function(response) {
														        	console.log(response);
														        	location.reload();
														        },
														        error: function(error) {
														            // 오류 처리
														            console.error('좋아요 토글 중 오류 발생:', error);
														        }
														    });
														}
													</script>
													
												</div>
											</div>											
										</div>
																													
									</div>
								</button>
							</form>
						</c:forEach>
					</div>  		
		  	</div><!--/.tab-content-->
			  	<div class="div1" id="div1">
				  	<div class="modal_buyer" id="modal_buyer">
						<div class="modal_top">
							<button type="button" id="modal_close" class="modal_close" data-feather="x"></button>
						</div>
						<div class="modal_title" align="center">
							<div class="product_title">** <%= product_title %> **</div>
							<div class="product_nickname">판매자: <%= nickName %></div>
						</div>				
						<div class="modal_content" align="center">
							<h1>최종 구매자를 선택하세요.</h1><br>
							<c:forEach items="${chatroomList}" var="chatroom">
							 	<label>
		                            <input type="checkbox" name="buyer" value="${chatroom.buyer_name}" onclick="getCheckboxValue(event)">&nbsp;${chatroom.buyer_name}
		                        </label>
							</c:forEach>			
							<br>
	 						<div><button type="button" class="btn btn-info" id="modal-open2">결정</button></div>
						</div>	
					</div>
				</div>
		
				<script>
					function getCheckboxValue(event)  {				
						  let result = '';
						  if(event.target.checked)  {
						    result = event.target.value;
						  }else {
						    result = '';
						  }
						  
						  document.getElementById('result').innerText
						    = result;
						  document.getElementById('result').innerText
						    = result;
					}			
					</script>
				<div class="div2" id="div2">
					<div class="modal_review_p">
						<!-- 후기 창 열기 -->
		 			<div class="m-select-review" id="m-select-review">
						<div class="m-review-top">
							<button type="button" id="review-close-btn" class="m-review-close-btn" data-feather="x"></button>
						</div>
						<div class="m-review-content">
							<div class="m-review_m">
								<div id="result" style="font-size: 26px; font-weight: bold ; color: #0473b8"></div><h81>님과의 거래후기를 남겨주세요</h81>
							</div>
							<div class="m-review_icon">
								<a href="#" id="review_smile" class="m-review_icon_btn" data-feather="smile"></a>
								<a href="#" id="review_meh" class="m-review_icon_btn" data-feather="meh"></a>
								<a href="#" id="review_frown" class="m-review_icon_btn" data-feather="frown"></a>
							</div>
							<div class="m-review_bottom">
								<div class="m-review_text">
									<textarea rows="3" class="m-review_textarea"></textarea>
								</div>
							<div class="m-review_text_btn">
								<button type="button" id="review_btn" class="m-review_btn" value="보내기">보내기</button>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		
		
	</div>
</div>
		<!--/.container-->
		
<!--		<div class="container_m" >
 		<div class="modal-btn_box">
		    	<button type="button" class="modal_btn" id="modal-open">모달창 열기</button>  
			</div>
			<div class="modal-btn_box2">
		    	<button type="button" class="modal_btn2" id="modal-open2">후기창 열기</button>  
			</div>
		</div>
 -->			
 	
			
			

			
	</section>
	<!--프로필 메뉴 탭 끝 -->
	
		<!--알림 시작 -->


	<!--알림 끝 -->

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
