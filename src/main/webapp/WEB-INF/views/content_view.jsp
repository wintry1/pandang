<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<link href="https://fonts.googleapis.com/css2?family=Lato&display=swap" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Cormorant+Garamond:wght@500&display=swap" rel="stylesheet">
<script src="//dapi.kakao.com/v2/maps/sdk.js?appkey=d2d8856f21736abb5201a83471515122&libraries=services"></script>
<style type="text/css">
*{
  margin:0;
  padding:0;
  box-sizing: border-box;
}

body {
  background: #e0e5ec;
}

p{
  margin-top:10px;
}
.container{
  width:100%;
}
.modal-btn-box{
  width:100%;
  text-align:center;
}
.modal-btn-box button{
  display:inline-block;
  width:150px;
  height:50px;
  background-color:#ffffff;
  border:1px solid #e1e1e1;
  cursor:pointer;
  padding-top:8px;
}
.popup-wrap{
  background-color:rgba(0,0,0,.3);
  justify-content:center;
  align-items:center;
  position:fixed;
  top:0;
  left:0;
  right:0;
  bottom:0;
  display:none;
  padding:15px;
}
.popup{
  width:100%;
  max-width:400px;
  background-color:#ffffff;
  border-radius:10px;
  overflow:hidden;
  background-color:#FF9800;
  box-shadow: 5px 10px 10px 1px rgba(0,0,0,.3);
}
.popup-head{
  width:100%;
  height:60px;
  display:flex;
  align-items:center;
  justify-content:center;
}
.head-title {
	color:#FFFFFF;
    font-size: 38px;
    font-style: 'Poppins', sans-serif;
    font-weight: 700;
    letter-spacing: -3px;
    text-align: center;
}
.popup-body{
  width:100%;
  background-color:#ffffff;
}
.body-content{
  width:100%;
  padding:20px;
}
.body-titlebox{
  text-align:center;
  width:100%;
  height:300px;
  margin-top:10px;
  margin-bottom:10px;
}
.body-contentbox{
  word-break:break-word;
  overflow-y:auto;
  min-height:100px;
  max-height:200px;
}
.popup-foot{
  width:100%;
  height:60px;
}
.pop-btn{
  display:inline-flex;
  width:50%;
  height:100%;
  float:left;
  justify-content:center;
  align-items:center;
  color:#ffffff;
  cursor:pointer;
}
.pop-btn.confirm{
  border-right:1px solid #3b5fbf;
}
.frame {
  width: 90%;
  margin: 30px auto;
  text-align: center;
}
button {
  margin: 10px;
  outline: none;
}
.custom-btn {
  width: 250px;
  height: 50px;
  padding: 10px 20px;
  border: 2px solid #9e9e9e;
  font-family: 'Roboto', sans-serif;
  font-weight: 500;
  background: transparent;
  cursor: pointer;
  transition: all 0.3s ease;
  position: relative;
  display: inline-block;
}

</style>
<script>
$(function(){
	  $("#confirm").click(function(){
	      modalClose();
	      //컨펌 이벤트 처리
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
	        <span class="head-title">PANDANG</span>
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
			</div>
		</div>
	<div class="popup-foot">
        <span class="pop-btn confirm" id="confirm">확인</span>
        <span class="pop-btn close" id="close">창 닫기</span>
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
</body>
</html>