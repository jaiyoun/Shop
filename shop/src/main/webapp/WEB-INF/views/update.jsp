<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>수정</title>
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
</head>

<body>

<script>
window.onload = function() {
	getDataFromAPI();
}

function getDataFromAPI() {
	$.ajax({
		url: "http://9.194.107.16:8090/getCoffeeNameId",
		type: "GET",
		dataType:'json',
		success: 
			function (data) {
				var temp = ${shop.sid};
				var htmls='';
				htmls += "<h1>수정하기</h1>";
				htmls += "수정할 이름 : <input type='text' name='name' id='name'/> ";
               	htmls+="<h2>Coffee List</h2>";
            	$.each(data,function(){
               		htmls += "<input type='checkbox' name='check_d' id="+this['id']+" >" + this['name'] ; 
            	});//each
            	
         		htmls += "<br><input type = 'button' name = 'btn' id = 'submit' value='submit' onclick = 'postDataFromAPI()'/>";
				document.write(htmls);
           }, error: function (jqXHR, textStatus, errorThrown) { }
      });//ajax
   }
   
   function postDataFromAPI() {
	   
	   var str = '';
	   var count = 0;
	   
	   if($('#name').val() == null | $('#name').val() == '') str += "${shop.name}" + ",";
	   else str+=$('#name').val()+ ",";
	   
	   $('input:checkbox[name = "check_d"]').each(function(){
		   if(this.checked == true) {
			   str+= ${shop.sid}+this['id']+",";//alert(this['id']);
		   		count += 1;
		   }
	   })
	   
	   //Coffee선택 안하는 경우
	   if(count == 0 ) {
		   alert("커피를 추가해주세요");
		   return false;
	   }
	   
	   else if(count != 0) {
	   $.ajax({
		   type: "POST",
		   url: "/upd",
		   headers: {"Content-Type": "application/json"},
		   data: JSON.stringify(str),
		   success: function () { 
			   alert("성공");location.href="/index";
			   },
		   error: function (jqXHR, textStatus, errorThrown) {}
		   });
	  
	   $.ajax({
		   type: "POST",
		   url: "http://9.194.107.16:8090/modShop",
		   headers: {"Content-Type": "application/json"},
		   data: JSON.stringify(str),
		   success: function () { },
		   error: function (jqXHR, textStatus, errorThrown) {}
		   });
	   }
   }
   </script>
</body>
</html>