<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>mainhome</title>
	<script src="//dapi.kakao.com/v2/maps/sdk.js?appkey=d2d8856f21736abb5201a83471515122&libraries=services"></script>
</head>
<body>
	<input id="address" placeholder="주소 입력"/>
	<button id="button">검색</button>
	<div>
	    <div id="resultAddress"></div>
	</div>
	<div id="searchResult"></div>
	<div id="map" style="width:400px;height:400px;"></div>
	
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
	                
	                var mapCenter = new kakao.maps.LatLng(result[0].y, result[0].x);
	                map.setCenter(mapCenter);
	                
	                sendCoordinates(result[0].y, result[0].x);
	            } else if(status === "ZERO_RESULT") {
	                divAddress.innerText = "검색 결과가 없습니다.";
	            }
	        });
	    } 
	    document.getElementById("button").addEventListener("click", searchAddress);
	    document.getElementById("address").addEventListener("keyup", function(e) {
	        if(e.key === "Enter") searchAddress();
	    });
    
        document.getElementById("searchButton").addEventListener("click", function() {
            var address = document.getElementById("address").value;
            searchKakaoMaps(address);
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
    </script>
    
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
		function sendCoordinates(latitude, longitude) {

		    var xhr = new XMLHttpRequest();
		    xhr.open("POST", "/calcul", true);
		    xhr.setRequestHeader("Content-Type", "application/json");
		
		    var data = {
		        latitude: latitude,
		        longitude: longitude
		    };
		
		    xhr.send(JSON.stringify(data));
		}
	</script>
	<button onclick="initializeMap();">확인</button>
</body>
</html>