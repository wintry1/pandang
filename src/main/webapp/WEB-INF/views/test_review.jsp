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
<link rel="stylesheet" type="text/css" href="assets/css/modal_test.css">

<script defer src="https://unpkg.com/feather-icons"></script>
<script src="https://js.tosspayments.com/v1/payment-widget"></script>
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
        $(".review_icon_btn").click(function() {
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
            var reviewText = $(".review_textarea").val();
            var user_seq = ${user_seq};
            var product_seq = ${productList.product_seq};
			console.log(score);
			console.log(reviewText);
            // AJAX를 사용하여 서버로 데이터 전송
            $.ajax({
                type: "POST", 
                url: "/save_review",
                data: {score: score, reviewText: reviewText, user_seq: user_seq, product_seq: product_seq },
                success: function(json) {
                    console.log("데이터 전송 성공", score, reviewText);
                    window.location.href ="/list";
                },
                error: function(error) {
                    console.error("데이터 전송 실패", error);
                }
            });
        });
    });
</script>
</head>
<body style="width:400px; height:690px;">
	<div id="select-review" style="width:400px; height:690px; position: fixed;">
		<div class="select-review">
			<div class="review-top">
			
			</div>
			<div class="review-content">
				<div class="review_m">
					<h81>${user_name}님과의 거래후기를 남겨주세요</h81>
				</div>
				<div class="review_icon">
					<a href="#" id="review_smile" class="review_icon_btn" data-feather="smile"></a>
					<a href="#" id="review_meh" class="review_icon_btn" data-feather="meh"></a>
					<a href="#" id="review_frown" class="review_icon_btn" data-feather="frown"></a>
				</div>
				<div class="review_bottom">
					<div class="review_text">
						<textarea rows="3" class="review_textarea"></textarea>
					</div>
					<div class="review_text_btn"> 
						<button type="button" id="review_btn" class="review_btn" value="보내기">보내기</button>
					</div>
				</div>
				
			</div>
		</div>
	</div>
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