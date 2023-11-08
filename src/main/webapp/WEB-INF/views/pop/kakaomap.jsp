<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>kakaomap</title>
	<script>
		function sendInfoToParent() {
		    window.opener.postMessage(latlng, "*");
		}
	</script>
</head>
<body>
	<div id="map" style="width:400px;height:400px;"></div>
	<script src="//dapi.kakao.com/v2/maps/sdk.js?appkey=d2d8856f21736abb5201a83471515122&libraries=services"></script>
	<input id="address" placeholder="주소 입력"/>
	<button id="button">submit</button>
	<div>
	    <div id="resultAddress"></div>
	    <div id="result"></div>
	</div>
	
	<script>
	    function searchAddress() {
	        var divAddress = document.getElementById("resultAddress");
	        var divResult = document.getElementById("result");
	        var addr = document.getElementById("address").value;
	        var geocoder = new kakao.maps.services.Geocoder();
	        geocoder.addressSearch(addr, function(result, status) {
	            console.log(result, status);
	            if(status === "OK") {
	                var address = result[0].road_address || result[0].address;
	                divAddress.innerText = address.address_name;
	                divResult.innerText = "위도: " + result[0].y + ", 경도: " + result[0].x;
	                
	                var mapCenter = new kakao.maps.LatLng(result[0].y, result[0].x);
	                map.setCenter(mapCenter);
	            } else if(status === "ZERO_RESULT") {
	                divAddress.innerText = "";
	                divResult.innerText = "검색 결과가 없습니다.";
	            }
	        });
	    }
	    document.getElementById("button").addEventListener("click", searchAddress);
	    document.getElementById("address").addEventListener("keyup", function(e) {
	        if(e.key === "Enter") searchAddress();
	    });
	</script>
	
	<script>
		var container = document.getElementById('map');
		var options = {
			center: new kakao.maps.LatLng(33.450701, 126.570667),
			level: 3
		};

		var map = new kakao.maps.Map(container, options);
		
		var marker = new kakao.maps.Marker({ 
			position: map.getCenter() 
		});
		marker.setMap(map);
		kakao.maps.event.addListener(map, 'click', function(mouseEvent) {        
		    
		    var latlng = mouseEvent.latLng; 
		    
		    marker.setPosition(latlng);
		    
		    var resultDiv = document.getElementById('clickLatlng'); 
		    resultDiv.innerHTML = message;
		});
	</script>
	
	<button onclick="sendInfoToParent();">확인</button>
</body>
</html>