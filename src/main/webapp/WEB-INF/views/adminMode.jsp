<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.5.0/Chart.min.js"></script>
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
        
.nav-tabs .nav-item .nav-link {
  color: black;
  font-size: 17px;
}

.nav-tabs .nav-item.active .nav-link{
  color: #e37e02;
  font-size: 17px;
  font-weight: bolder;
}

.nav-tabs > li > a {
    /* adjust padding for height*/
    padding-left: 120px;
    padding-right: 120px;
}

div.stats1 {
  position: relative;
  float:left; 
  left: 30px;
  width: 500px;
  height: 500px;
  padding: 10px;
  border: 1px solid black;
  margin-tight:20px;
  margin-bottom:20px;
}

div.stats2 {
  position: relative;
  float:left; 
  left: 30px;
  width: 500px;
  height: 500px;
  padding: 10px;
  border: 1px solid black;
  margin-bottom:20px;
}

div.stats3 {
  position: relative;
  top: 520px;
  left: 30px;
  width: 1000px;
  height: 650px;
  padding: 10px;
  border: 1px solid black;
}
</style>

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
	
	<% String nickName = (String)session.getAttribute("admin_name"); %>
	<% String address = (String)session.getAttribute("admin_address"); %>

	<!--관리자 헤더 시작 -->
	<section id="admin" class="admin">
		<div class="container">
			<div class="section-header">
				<h2 class="text-left">관리자 모드</h2>
				<div class="row">				
					<div class="col-xs-2">
						<img src="/img/panda4.jpg" width="100" align="right">
					</div>
					<div class="col-xs-2" align="left">
						<h4><%= nickName %></h4>
						<h3><%= address %></h3>
					</div>					
				</div>
			</div><!--/.section-header-->
			<div class="product-content">
			</div>			
		</div><!--/.container-->
	</section>
	<!--관리자 헤더 끝 -->
	
	<!--관리자 메뉴 탭 시작 -->
	<section id="admin_menu" class="admin_menu">
		<div class="container">
			<div class="section-header">
				<ul class="nav nav-tabs" id="myTabs">
				  <li class="nav-item active">
				    <a class="nav-link" data-toggle="tab" href="#user">회 원&nbsp&nbsp&nbsp 관 리</a>
				  </li>
				  <li class="nav-item">
				    <a class="nav-link" data-toggle="tab" href="#product">상 품&nbsp&nbsp&nbsp 관 리</a>
				  </li>
				  <li class="nav-item">
				    <a class="nav-link" data-toggle="tab" href="#stats">통 계&nbsp&nbsp&nbsp 정 보</a>
				  </li>  
				</ul><br><br>
					

			<div class="tab-content">			
				<div class="tab-pane active" id="user">		
				
			  		<div class="container-fluid"> 	
						<form name="search" action="/searchUser" method="get">
							<table class="pull-right" align="center">
								<tr>
									<td><select class="form-control" name="searchField">
										<option value="0">선택</option>
										<option value="user_id">아이디</option>
										<option value="user_name">닉네임</option>
									</select></td>
									<td><input type="text" class="form-control"
										placeholder="검색어 입력" name="searchText" maxlength="30"></td>
									<td><button type="submit" class="btn btn-dark">검색</button></td>
								</tr>
							</table>
						</form>
					</div>
					<br>
					
			  		<div class="container-fluid"> 				
					  	<div class="row">
					    	<div class="col-8">
								<table align="center" class="table table-striped">
									<thead>
								    	<tr>
											<th scope="col" style="text-align:center" width="7%">일련번호</th>
											<th scope="col" style="text-align:center" width="15%">사용자 ID</th>
											<th scope="col" style="text-align:center" width="13%">닉네임</th>
											<th scope="col" style="text-align:center" width="15%">등록일</th> 
											<th scope="col" style="text-align:center" width="10%">매너온도</th> 
											<th scope="col" style="text-align:center" width="10%">가입상태</th> 
											<th scope="col" style="text-align:center" width="10%">경고</th>											
											<th scope="col" style="text-align:center" width="10%">징계</th>											
											<th scope="col" style="text-align:center" width="10%">삭제</th>											
											
									    </tr>
									</thead>
					  	  			<tbody>
										<c:forEach items="${userList}" var="dto">
										<tr scope="row">
											<td> ${dto.user_seq}</td>
											<td> ${dto.user_id}</td>
											<td> <a href="Profile2?user_Seq=${dto.user_seq}">${dto.user_name}</a></td>
											<td> ${dto.user_created_at}</td>
											<td> ${dto.user_grade}</td>
											<td> ${dto.user_status}</td>
											<td>
												<button class="btn btn-info" type="button" onclick="ajax_admin_warn(${dto.user_seq})">경고</button>
												<script>
													function ajax_admin_warn(userSEQ) {
														var userSeq = userSEQ;
													    
													    $.ajax({
													        type: "GET",
													        url: "/userWarning",
													        data:  { user_SEQ: userSeq },
													        dataType: 'text',
													        success: function(json) {
													        	var result = JSON.parse(json);				
																if (result.code == "success") {
																	alert(result.desc);
													            } else {
													            	alert(result.desc);
													            }
																location.reload();
													        }
													    });
													}	
												</script>
											</td>
											<td>
												<button class="btn btn-warning" type="button" onclick="ajax_admin_crime(${dto.user_seq})">징계</button>
												<script>
													function ajax_admin_crime(userSEQ) {
														var userSeq = userSEQ;
													    
													    $.ajax({
													        type: "GET",
													        url: "/userPunish",
													        data:  { user_SEQ: userSeq },
													        dataType: 'text',
													        success: function(json) {
													        	var result = JSON.parse(json);				
																if (result.code == "success") {
																	alert(result.desc);
													            } else {
													            	alert(result.desc);
													            }
																location.reload();
													        }
													    });
													}	
												</script>
											</td>
											<td>												
												<button class="btn btn-danger" type="button" onclick="ajax_admin_delete(${dto.user_seq})">삭제</button>												
												<script>
													function ajax_admin_delete(userSEQ) {														
														var userSeq = userSEQ;
														
													    $.ajax({
													        type: "GET",
													        url: "/userDelete",
													        data: { user_SEQ: userSeq },
													        dataType: 'text',
													        success: function(json) {
													        	var result = JSON.parse(json);				
																if (result.code == "success") {
																	alert(result.desc);
													            } else {
													            	alert(result.desc);
													            }
																location.reload();
													        }
													    });    		
													}
												</script>
												
											</td>
										</tr>									
										</c:forEach>
									<tbody>
								</table>
							</div>
				 	 	</div>
					</div>
			  	</div>
			  	
			  	<div class="tab-pane" id="product">			  		
			  		<div class="container-fluid">
						<form name="search" action="/searchProduct" method="get">
							<table class="pull-right" align="center">
								<tr>
									<td><select class="form-control" name="searchField">
										<option value="0">선택</option>
										<option value="prd_title">상품명</option>
										<option value="prd_ctnt">내용</option>
									</select></td>
									<td><input type="text" class="form-control"
										placeholder="검색어 입력" name="searchText" maxlength="30"></td>
									<td><button type="submit" class="btn btn-dark">검색</button></td>
								</tr>
							</table>
						</form>
					</div>
					<br>
										
			  		<div class="container-fluid"> 				
					  	<div class="row">
					    	<div class="col-8">
								<table align="center" class="table table-striped">
									<thead>
								    	<tr id=prd_admin_form>
											<th scope="col" style="text-align:center" width="7%">일련번호</th>
											<th scope="col" style="text-align:center" width="8%">판매자번호</th>
											<th scope="col" style="text-align:center" width="23%">상품명</th>
											<th scope="col" style="text-align:center" width="10%">판매가</th>
											<th scope="col" style="text-align:center" width="15%">등록일</th> 
											<th scope="col" style="text-align:center" width="7%">조회수</th> 
											<th scope="col" style="text-align:center" width="10%">거래상태</th> 
											<th scope="col" style="text-align:center" width="10%">판매정지</th>
											<th scope="col" style="text-align:center" width="10%">해제</th>
										</tr>
									</thead>
					  	  			<tbody >
										<c:forEach items="${productList}" var="dto2">
										<tr scope="row">
											<td> ${dto2.product_seq}</td>
											<td> ${dto2.user_seq}</td>
											<td> <a href="view?product_seq=${dto2.product_seq}">${dto2.prd_title}</a></td>
											<td> ${dto2.prd_price}</td>
											<td> ${dto2.prd_at}</td>
											<td> ${dto2.prd_hit}</td>
											<td> ${dto2.prd_use}</td>											
											<td>
												<button class="btn btn-danger" type="button" onclick="ajax_admin_hide(${dto2.product_seq})">판매정지</button>
												<script>
													function ajax_admin_hide(prdSEQ) {
														var prdSeq = prdSEQ;
													    
													    $.ajax({
													        type: "GET",
													        url: "/hideProduct",
													        data:  { product_SEQ: prdSeq },
													        dataType: 'text',
													        success: function(json) {
													        	var result = JSON.parse(json);				
																if (result.code == "success") {
																	alert(result.desc);
													            } else {
													            	alert(result.desc);
													            }
																//location.reload();
													        }
													    });
													}										
												</script>
											</td>
											<td>
												<button class="btn btn-warning" type="button" onclick="ajax_admin_open(${dto2.product_seq})">해제</button>
												<script>
													function ajax_admin_open(prdSEQ) {
														var prdSeq = prdSEQ;
													    
													    $.ajax({
													        type: "GET",
													        url: "/openProduct",
													        data:  { product_SEQ: prdSeq },
													        dataType: 'text',
													        success: function(json) {
													        	var result = JSON.parse(json);				
																if (result.code == "success") {
																	alert(result.desc);
													            } else {
													            	alert(result.desc);
													            }
																//location.reload();
													        }
													    });
													}										
												</script>
											</td>
										</tr>	
										</c:forEach>								
									<tbody>				
								</table>
							</div>
				 	 	</div>
					</div>	
			  	</div>
			  	
				<div class="tab-pane" id="stats">	
				
					<div class="stats1"> 	
					  	<canvas id="bar-chart" ></canvas>
					  	<script>
							// Bar chart
							new Chart(document.getElementById("bar-chart"), {
							    type: 'bar',
							    data: {
							      labels: ["Africa", "Asia", "Europe", "Latin America", "North America"],
							      datasets: [
							        {
							          label: "Population (millions)",
							          backgroundColor: ["#3e95cd", "#8e5ea2","#3cba9f","#e8c3b9","#c45850"],
							          data: [2478,5267,734,784,433]
							        }
							      ]
							    },
							    options: {
							      legend: { display: false },
							      title: {
							        display: true,
							        text: 'Predicted world population (millions) in 2050'
							      }
							    }
							});
						</script>
					</div>
					
					<div class="stats2"> 	
						<canvas id="pie-chart" ></canvas>
				  		<script>
							// Pie chart
							new Chart(document.getElementById("pie-chart"), {
							    type: 'pie',
							    data: {
							      labels: ["Africa", "Asia", "Europe", "Latin America", "North America"],
							      datasets: [{
							        label: "Population (millions)",
							        backgroundColor: ["#3e95cd", "#8e5ea2","#3cba9f","#e8c3b9","#c45850"],
							        data: [2478,5267,734,784,433]
							      }]
							    },
							    options: {
							      title: {
							        display: true,
							        text: 'Predicted world population (millions) in 2050'
							      }
							    }
							});	
						</script>
			  		</div>
					
					<br><br><br>
					<div class="stats3">
						<canvas id="line-chart"  width="800" height="450"></canvas>
					  	<script>
						  	// Line chart
							new Chart(document.getElementById("line-chart"), {
								  type: 'line',
								  data: {
								    labels: [1500,1600,1700,1750,1800,1850,1900,1950,1999,2050],
								    datasets: [{ 
								        data: [86,114,106,106,107,111,133,221,783,2478],
								        label: "Africa",
								        borderColor: "#3e95cd",
								        fill: false
								      }, { 
								        data: [282,350,411,502,635,809,947,1402,3700,5267],
								        label: "Asia",
								        borderColor: "#8e5ea2",
								        fill: false
								      }, { 
								        data: [168,170,178,190,203,276,408,547,675,734],
								        label: "Europe",
								        borderColor: "#3cba9f",
								        fill: false
								      }, { 
								        data: [40,20,10,16,24,38,74,167,508,784],
								        label: "Latin America",
								        borderColor: "#e8c3b9",
								        fill: false
								      }, { 
								        data: [6,3,2,2,7,26,82,172,312,433],
								        label: "North America",
								        borderColor: "#c45850",
								        fill: false
								      }
								    ]
								  },
								  options: {
								    title: {
								      display: true,
								      text: 'World population per region (in millions)'
								    }
								  }
								});
						</script>
					</div>
				</div>		
		  		
		  	</div><!--/.tab-content-->
		</div><!--/.container-->
	</section>
	<!--관리자 메뉴 탭 끝 -->
		
	
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
