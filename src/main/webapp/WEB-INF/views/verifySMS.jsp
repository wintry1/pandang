<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Send SMS</title>
<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
</head>
<body>
<br><p>

<table width="30" cellpadding="3" cellspacing="3" border="1">
	<form id="phonenumForm">
		<tr>
			<td> 전화번호 ( '-' 없이 숫자만 입력)</td>
		</tr>
		<tr>
			<td><input type="text" id="phoneNum" name="phoneNum" size="30"></td>
		</tr>
		<tr>
			<td colspan="2"><button type="button" value="전화번호전송" onclick="ajax_phonenum()">전송</button>
		</tr>	
	</form>
</table>

<script>
	function ajax_phonenum() {
	    var formData = $("#phonenumForm").serialize();

	    $.ajax({
	        type: "GET",
	        url: "/sendOne",
	        data: formData,
	        dataType: 'text',
	        success: function(json) {
	        	var result = JSON.parse(json);				
				if (result.code == "success") {
					alert(result.desc);
	            } else {
	            	alert(result.desc);
	            }
	        }
	    });
	}	
</script>

<br>
<br>
<br>
<br>

<table width="30" cellpadding="3" cellspacing="3" border="1">
	<form id="codeForm">
		<tr>
			<td> 인증코드 (3분내에 보내세요)</td>
		</tr>
		<tr>
			<td><input type="text" id="codeNum" name="codeNum" size="30"></td>
		</tr>
		<tr>
			<td colspan="2"><button type="button" value="코드전송" onclick="ajax_codenum()">전송</button>
		</tr>	
	</form>	
</table>

<script>
	function ajax_codenum() {
	    var formData = $("#codeForm").serialize();

	    $.ajax({
	        type: "GET",
	        url: "/checkCode",
	        data: formData,
	        dataType: 'text',
	        success: function(json) {
	        	var result = JSON.parse(json);				
				if (result.code == "success") {
					alert(result.desc);
	            } else {
	            	alert(result.desc);
	            }
	        }
	    });
	}	
</script>

</body>
</html>