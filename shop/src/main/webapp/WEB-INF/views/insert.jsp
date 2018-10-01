<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
   <head>
      <meta charset="UTF-8"/>
      <title>Shop 추가 </title>
      <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
   </head>
   <body>
	<%request.setCharacterEncoding("utf-8");%>
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
        	   var htmls='';
        	   htmls+="Name : <input type='text' name='name' id='name'/><br/>";
               htmls+="<h2>Coffee List</h2>";
            $.each(data,function(){
               htmls += "<input type='checkbox' name='check_d' id="+this['id']+" >" + this['name'] ; 
            });
         	htmls += "<br><input type = 'button' name = 'btn' id = 'submit' value='submit' onclick = 'postDataFromAPI()'/>";
			document.write(htmls);
           }, error: function (jqXHR, textStatus, errorThrown) { }
      });
   }
   
   function postDataFromAPI() {
	   
	   var str = '';
	   //커피메뉴가 없는 경우 처리
	   var count = 0;
	   
	   //이름이 없는 경우 처리
	   if($('#name').val() == null | $('#name').val() == "") {
		   alert("이름을 입력하세요");
		   return false;
	   }
	   
	   str+=$('#name').val()+ ",";
	   $('input:checkbox[name = "check_d"]').each(function(){
		   if(this.checked == true) {
			   str+= ${sid}+ this['id']+",";//alert(this['id']);
			   count += 1;
		   }
	   })
	   
	   //Coffee선택 안하는 경우
	   if(count == 0 ) {
		   alert("커피를 추가해주세요");
		   return false;
	   }
	   
	   if(confirm("정말로 추가하시겠습니까 ? ") == true) {//location.href="/index";
	   	$.ajax({
		   type: "POST",
		   url: "/shop/register",
		   headers: {"Content-Type": "application/json"},
		   data: JSON.stringify(str),
		   success: function () { 
			   location.href="/index";
			   },
		   error: function (jqXHR, textStatus, errorThrown) {}
		   });
	  
	   	$.ajax({
		   type: "POST",
		   url: "http://9.194.107.16:8090/getShopInfo",
		   headers: {"Content-Type": "application/json"},
		   data: JSON.stringify(str),
		   success: function () { },
		   error: function (jqXHR, textStatus, errorThrown) {}
		   });
	   	}
	   else {
		   location.href="/index";
		   return false;
	   }
   	}
   </script>
   </body>
</html>