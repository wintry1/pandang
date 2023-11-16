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
<style>
#bottom {
            position: relative;
            bottom: -50px;
            left: 0px;
        }
</style>
<body>
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
						<a class="navbar-brand" href="#home">PAN<span>DANG</span></a>
					</div><!--/.navbar-header-->
					
					<!-- Collect the nav links, forms, and other content for toggling -->
					<div class="collapse navbar-collapse menu-ui-design" id="navbar-menu">
						<ul class="nav navbar-nav navbar-right" data-in="fadeInDown" data-out="fadeOutUp">
							<li>
								<form onclick="https://search.naver.com/search.naver">
									<div class="search-form">
						  				<input type="text" name="query" placeholder="상품이나 지역을 검색해보세요" maxlength="50">
						  					<button type="submit"><img src="https://s3.ap-northeast-2.amazonaws.com/cdn.wecode.co.kr/icon/search.png"></button>
									</div>
								</form>
							</li>
							<li><a href="">상품등록</a></li>
							<li><a href="">내상점</a></li>
							<li><a href="">찜</a></li>
							<li><a href="">채팅하기</a></li>
							<li><a href="">로그인/회원가입</a></li>
						</ul><!--/.nav -->
					</div><!-- /.navbar-collapse -->
				</div><!--/.container-->
			</nav><!--/nav-->
			<!--  상단 네비게이션바 끝 -->
			
		</div><!--/.header-area-->
		<div class="clearfix"></div>
	</section><!-- /.top-area-->
	
	<% String nickName = "후이바오"; %>
	
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
						<a href="modifyProfile.jsp" ><button type="button" class="btn btn-primary btn-block" value="수정" >프로필 수정</button></a>
					</div>
					<div class="col-xs-2" id="bottom">
						<a href="modifyProfile.jsp" ><button type="button" class="btn btn-danger btn-block" value="회원탈퇴" >회원 탈퇴</button></a>
					</div>
				</div>
			</div><!--/.section-header-->
			<div class="product-content">
			</div>			
		</div><!--/.container-->
	</section>
	<!--프로필 헤더 끝 -->

	<!--프로필 메뉴 탭 시작 -->
	<section id="profile_menu" class="profile_menu">
		<div class="container">
			<div class="section-header">
				<ul class="nav nav-tabs">
				  <li class="nav-item">
				    <a class="nav-link active" aria-current="page" data-toggle="tab" href="#sold">판매 리스트</a>
				  </li>
				  <li class="nav-item">
				    <a class="nav-link" data-toggle="tab" href="#review">거래 후기</a>
				  </li>
				  <li class="nav-item">
				    <a class="nav-link" data-toggle="tab" href="#bookmark">찜 목록</a>
				  </li>
				</ul><br><br>
			</div>		

			<div class="tab-content">			
				<div class="tab-pane" id="sold">
					<div class="row">
						<c:forEach items="${soldList}" var="dto">
							<button class="col-md-4 col-sm-6" onclick="window.location.href='product_view'">
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
										<div class="product-status">
											${dto.prd_use}
										</div>
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
						</c:forEach>
					</div>
			  	</div>
			  	<div class="tab-pane" id="review">
			  		<div class="container-fluid"> 				
					  	<div class="row">
					    	<div class="col-8">
								<table align="center" class="table table-striped">
									<thead>
								    	<tr>
											<th scope="col">아이디</th>
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
			  	</div>
				<div class="tab-pane" id="bookmark">
				  	<div class="row">
						<c:forEach items="${bookmarkList}" var="dto3">
								<button class="col-md-4 col-sm-6" onclick="window.location.href='product_view'">
									<div class="single-product-item">
										<div class="single-product-img">
											<c:choose>
												<c:when test="${empty dto3.prd_image}">
									                <img src="${pageContext.request.contextPath}/upload/default_image.png" alt="Default_Image">
									            </c:when>
									            <c:otherwise>
									                <img src="${pageContext.request.contextPath}/upload/${dto3.prd_image}" alt="Product_Image">
									            </c:otherwise>
								        	</c:choose>
										</div>
										
										<div class="single-product-txt">
											<div class="product-name">
												${dto3.prd_title}
											</div>
											<div class="row">
												<div class="col-sm-5">
													<div class="product-price">
														<fmt:formatNumber type="number" maxFractionDigits="3" pattern="#,##0원" value="${dto3.prd_price}"/>
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
							
						</c:forEach>
					</div>
		  		</div>
		  		
		  		
				  		
		  		
		  	</div><!--/.tab-content-->
		</div><!--/.container-->
	</section>
	<!--프로필 메뉴 탭 끝 -->

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
