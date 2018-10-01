<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>판매</title>
</head>
<body>
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
<script>
window.onload = function() {
	postSid();
}
function postSid() {
	var s = ${shop.sid};
	$.ajax({
	       url: "http://9.194.107.16:8090/sid",
	       type: "POST",
		   headers: {"Content-Type": "application/json"},
		   data: JSON.stringify(s),
	       success: 
	       function (data) {
	    	   	var temp = new Array();
	    		temp =data.split(',');
	    	   	var str = '';
	    	   	str += "<h1> 주문하기 </h1>";
	    	   	str += "<table border='1'>";
			   	str += "<tr><th>번호</th><th>커피 이름</th><th>가격</th><th>재고</th><th>수량</th></tr>";
			 	for(var i = 0 ; i < temp.length ; i++) {
			 		if(temp[i] == null | temp[i] == "") break;
			 		str += "<tr>";
			 		var cid = temp[i++];
			 		var name = temp[i++];
			 		var price = temp[i++];
			 		var stock = temp[i];
	    			str += "<td>"+cid+"</td>";
	    			str += "<td>"+name+"</td>";
	    			str += "<td>"+price+"</td>";
	    			str += "<td>"+stock+"</td>";
	    			if(stock == '0' | stock == 0) str += "<td><input type = 'text' id = 'zero_amt' value = '판매종료' name = '"+ cid+"'disabled ></td>";
	    			if(stock != '0' | stock != 0) {
	    				str += "<td><input type = 'text' id = 'amt' value = '0' name = '"+ cid+"'></td>";
	    			
	    				}
	    		   	str += "</tr>"; 
			 	}
	    		   str += "</table>";
	    		   
	    		   str += "<input type = 'button' id = 'btn' value = '주문하기'  onclick = 'postDataFromAPI()'>"
	    	   document.write(str);
	       }, 
	       error: function (jqXHR, textStatus, errorThrown) { }
	  });

}
/*
function onlyNumber() {
	if((event.keyCode<48) || (event.keyCode > 57)) event.returnValue = false;
}*/

//
function postDataFromAPI() {
		var i = 0;
	   var str = '';
	   $('input:text[id = "amt"]').each(function(){
		   if(parseInt(this.value) < 0) {alert("잘못된 입력값 입니다."); return false;}
		    str+= "${shop.sid}"+this.name + "," + this.value + ",";
	   })
	
	   $.ajax({
		   type: "POST",
		   url: "http://9.194.107.16:8090/SaleInfo",
		   headers: {"Content-Type": "application/json"},
		   data: JSON.stringify(str),
		   success: function (data) { 
			  if(parseInt(data) == -1) {alert("구매 불가 내역입니다");location.href="/index";}
			  else {
				  if(confirm("총액 : "+ data) == true) location.href="/index";
				  else {return false;}
				}
		   },
		   error: function (jqXHR, textStatus, errorThrown) {}
		   });
	   }

</script>
</body>
</html>