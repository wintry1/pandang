<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ page import="java.io.PrintWriter"%>
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
		String user_id = null;
		if (session.getAttribute("user_id") != null) {//주어진 userID에 연결된 속성값을 얻어낸다.
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

	<!--상품 시작 -->
	<section id="product" class="product">
		<div class="container">
			<div class="section-header">
				<h2>검색결과</h2>
			</div><!--/.section-header-->
			<div class="product-content">
				<div class="row">
					<c:forEach items="${list}" var="dto">
						<div class="product-use">
							<form action="/view" method="get">
								<input type="hidden" name="productSeq" value="${dto.product_seq}" />
								<button class="col-md-4 col-sm-6">
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
										<div class="single-product-txt">
											<div class="product-name">
												${dto.prd_title}
											</div>
											<div class="row">
												<div class="col-sm-5">
													<div class="product-price">
														<fmt:formatNumber type="number" maxFractionDigits="3" pattern="#,##0원" value="${dto.prd_price}"/>
													</div>
												</div>
												<div class="col-sm-7">
													<div class="product-map-icon">
														<a href="#"><i data-feather="heart"></i></a>
													</div>
												</div>
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
