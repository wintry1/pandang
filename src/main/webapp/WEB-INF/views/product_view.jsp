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

</head>
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
								<form action="/search">
									<div class="search-form">
						  				<input type="text" name="title" placeholder="상품이나 지역을 검색해보세요" maxlength="50">
						  					<button type="submit"><img src="https://s3.ap-northeast-2.amazonaws.com/cdn.wecode.co.kr/icon/search.png"></button>
									</div>
								</form>
							</li>
							<li><a href="">상품등록</a></li>
							<li><a href="">찜</a></li>
							<li><a href="">채팅하기</a></li>
							
							<%
							// 로그인/회원가입은 로그인이 되어있지 않은 경우만 나오게한다.
							if (user_id == null) {
							%>
							<li><a href="">로그인/회원가입</a></li>
							<%
							// 로그인이 되어있는 사람만 볼수 있는 화면
							} else {
							%>
							<li><a href="">내정보</a></li>
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
	
	<!--상품 뷰 시작 -->
	
	
	<section id="product-view">
		<div class="container" style="display:flex; justify-content:center;">
			<div class="row">
				<div class="single-product-view-item">
					<div class="single-product-view-img">
						<c:choose>
							<c:when test="${empty product.prd_image}">
				                <img src="${pageContext.request.contextPath}/upload/default_image.png" alt="Default_Image" style="object-fit:cover; width:100%;">
				            </c:when>
				            <c:otherwise>
				                <img src="${pageContext.request.contextPath}/upload/${product.prd_image}" alt="Product_Image" style="object-fit:cover; width:100%;">
				            </c:otherwise>
			        	</c:choose>
						<!-- <img src="/upload/p2.jpg" style="object-fit:cover; width:100%;"> -->
					</div>
					<div class="single-product-view-txt">
						<div class="nickname">
							닉네임
						</div>
					    <div class="region-name">${product.prd_address}</div>
					    <div class="product-time">등록일 : ${product.prd_at}</div>
					    <div class="clearfix"></div>
						<hr>
						<div class="col" style="float:left;">
							<div class="product-title">
								${product.prd_title}
							</div>
							<div class="product-price">
								${product.prd_price}
							</div>
						</div>
						<button class="cht-btn" onclick="#">
							채팅하기
						</button>
						<div class="clearfix"></div>
						<div class="product-content">
							${product.prd_ctnt}
						</div>
						<div class="product-view-icon">
							<a href="#"><i data-feather="heart"></i></a>
							찜 54 ∙ 조회 ${product.prd_hit}
						</div>
						<hr>
					</div>
				</div>
			</div>
		</div>
	</section>


	<!--상품 뷰 끝 -->

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
	<script src="assets/js/waypoints.min.js"></script>

	<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-easing/1.4.1/jquery.easing.min.js"></script>

	<!--Custom JS-->
	<script src="assets/js/custom.js"></script>
	

</body>
</html>
