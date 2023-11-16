<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>writeview</title>
	<script src="//dapi.kakao.com/v2/maps/sdk.js?appkey=d2d8856f21736abb5201a83471515122&libraries=services"></script>
	<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
</head>
<body>
	<div id="map" style="width:400px;height:400px;"></div>
	<table width="500" cellpadding="0" cellspacing="0" border="1">
		<form action="write" method="post">
			<tr>
				<td> 이름 </td>
				<td> <input type="text" name="user_name" size="100"> </td>
			</tr>
			<tr>
				<td> 제목 </td>
				<td> <input type="text" name="prd_title" size="100"> </td>
			</tr>
			<tr>
				<td> 내용 </td>
				<td> <input type="text" name="prd_ctnt" size="100"> </td>
			</tr>
			<tr>
				<td> 판매가 </td>
				<td> <input type="text" name="prd_price" size="100"> </td>
			</tr>
			<tr>
				<td colspan="2"> <input type="submit" value="입력">
						&nbsp;&nbsp; <a href="list">목록보기</a></td>
			</tr>
		</form>
		<div id="imageContainer"></div>
		
		<form id="uploadForm" action="/uploadOk" method="post" enctype="multipart/form-data">
				파일 : <input type="file" name="files"><br>
			<input type="submit" value="File Upload">
		</form>
		
		<input id="address" placeholder="주소 입력"/>
		<button id="button">검색</button>
		<div>
		    <div id="resultAddress"></div>
		</div>
		<div id="searchResult"></div>
		
	</table>
	<c:set var="userLatitude" value="${list.user_latitude}" />
	<c:set var="userLongitude" value="${list.user_longitude}" />
	<script>
	    var container = document.getElementById('map');
	    var options = {
	    	center: new kakao.maps.LatLng(<c:out value="${userLatitude}" />, <c:out value="${userLongitude}" />),
	        level: 3
	    };
	    
	    var map = new kakao.maps.Map(container, options);
	
	    var marker = new kakao.maps.Marker(); 
	    marker.setMap(map);
	    
	    function handleClickEvent(mouseEvent) {
	        var latlng = mouseEvent.latLng; 
	        
	        marker.setPosition(latlng);
	        
	     // 좌표를 서버로 전송
	        $.ajax({
	            type: 'POST',
	            url: '/search',
	            data: {
	                latitude: latlng.getLat(),
	                longitude: latlng.getLng()
	            },
	            success: function (response) {
	                console.log('좌표 전송 성공:', response);
	                // 서버에서의 추가 작업 또는 응답에 따른 클라이언트 작업 수행
	            },
	            error: function (error) {
	                console.error('좌표 전송 실패:', error);
	            }
	        });
	        
	        var resultDiv = document.getElementById('result'); 
	    }
	    
	    kakao.maps.event.addListener(map, 'click', handleClickEvent);
	</script>
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
	    function uploadFile() {
	        var formData = new FormData(document.getElementById('uploadForm'));
	
	        $.ajax({
	            type: "POST",
	            url: "/uploadOk",
	            data: formData,
	            processData: false,
	            contentType: false,
	            success: function(response) {
	                var result = JSON.parse(response);
	
	                if (result.success === "1") {
	                    var filePath = result.filePath;
	
	                    var imageContainer = $("#imageContainer");
	
	                    var imgElement = document.createElement("img");
	                    imgElement.src = "http://localhost:8080" + filePath;
	                    imageContainer.empty();
	                    imageContainer.append(imgElement);
	                } else {
	                    alert("업로드 실패: " + result.desc);
	                }
	            },
	            error: function(error) {
	                console.log("에러:", error);
	            }
	        });
	    }
	
	    $(document).ready(function() {
	        $("#uploadForm").submit(function(e) {
	            e.preventDefault();
	            uploadFile();
	        });
	    });
	</script>
</body>
</html>