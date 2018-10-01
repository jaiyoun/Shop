<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>상세조회</title>
</head>
<body>
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
<script>
window.onload = function() {
	getDataFromAPI();
}

function getDataFromAPI() {
   $.ajax({
       url: "http://9.194.107.16:8090/CoffeeList",
       type: "GET",
       dataType:'json',
       success: 
       function (data) {
    	   var str = '';
    	   str += "<h1> 상세 조회 화면</h1>";
    	   str += "<table border='1'>";
    	   str += "<tr><th>번호</th><th>이름</th><th>등록일</th><th>수정일</th></tr>";
    	   str += "<tr>";
    	   str += "<td>" + ${shop.sid} + "</td>";
    	   str += "<td>${shop.name}</td>";
    	   str += "<td>" + ${shop.enrolldt} + "</td>";
    	   str += "<td>" + ${shop.update_dt} + "</td>";
    	   str += "</tr> </table>";
    	   str += "<table border = '1'>";
		   str += "<tr><th>커피 이름</th><th>가격</th><th>판매량</th><th>매출액</th></tr>";
		  
		   $.each(data,function(){
			   str += "<tr>";
    		   if(${shop.sid} == this['totId'].substring(0,3)) {
    			   
    			   str += "<td>"+this['name']+"</td>";
    			   str += "<td>"+this['price']+"</td>";
    			   str += "<td>"+this['totSales']+"</td>";
    			   str += "<td>"+this['totSalesAmt']+"</td>";
    			   
    		   }
    		   str += "</tr>";
    	   });
		   
    		   str += "</table>";
    	   document.write(str);
       }, 
       error: function (jqXHR, textStatus, errorThrown) { }
  });
}

</script>
</body>
</html>