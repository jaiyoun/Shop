<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>삭제하기</title>
</head>
<body>
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
<script >
window.onload = function(){
	postDataFromAPI();
 }

function postDataFromAPI() {
	$.ajax({
		url: "http://9.194.107.16:8090/ShopDel/"+${sid},
		type: "POST",
		headers: {"Content-Type": "application/json"},
		success: function () {
			alert("삭제 완료");location.href="../index";
		}, 
		error: function (jqXHR, textStatus, errorThrown) {}
		});
   }

</script>
</body>
</html>