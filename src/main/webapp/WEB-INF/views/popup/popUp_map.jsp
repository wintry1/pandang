<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<link rel="stylesheet" type="text/css" href="/css/style.css">
<link href="https://fonts.googleapis.com/css2?family=Lato&display=swap" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Cormorant+Garamond:wght@500&display=swap" rel="stylesheet">
<script src="//dapi.kakao.com/v2/maps/sdk.js?appkey=d2d8856f21736abb5201a83471515122&libraries=services"></script>

<script>
$(function(){
	  $("#next").click(function(){
	      window.location.href = "/popUp_agree";
	  });
	  $("#modal-open").click(function(){        
		  $("#popup").css('display','flex').hide().fadeIn();
	  });
	  $("#close").click(function(){
	      modalClose();
	  });
	  function modalClose(){
	    $("#popup").fadeOut();
	  }
	});
</script>

</head>
<body>

  <div class="container">
  <div class="modal-btn-box">
  <button type="button" id="modal-open">로그인/회원가입</button>  
  </div>
  
  <div class="popup-wrap" id="popup">
    <div class="popup">
      <div class="popup-head">
          <span class="head-title">
            PANDANG</span>
      </div>
            <div class="popup-body">
        <div class="body-content">
        <div class="body-titlebox">

    <input id="address" placeholder="주소 입력"/>
   <button id="button">검색</button>
   <div>
       <div id="resultAddress"></div>
   </div>
   <div id="searchResult"></div>
<div id="map" style="width:200px;height:200px;"></div>
</div>
</div></div>
<div class="popup-foot">
        <span class="pop-btn next" id="next">다음</span>
        <span class="pop-btn close" id="close">창 닫기</span>
      </div>
      <script>

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
          
          var resultDiv = document.getElementById('result'); 
      }
      
      kakao.maps.event.addListener(map, 'click', handleClickEvent);
   </script>

    <script>
        function searchAddress() {
            var divAddress = document.getElementById("resultAddress");
            var addr = document.getElementById("address").value;
            var geocoder = new kakao.maps.services.Geocoder();
            geocoder.addressSearch(addr, function (result, status) {
                console.log(result, status);
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
    </script>
</body>
</html>