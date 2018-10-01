<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>List</title>
</head>
<body>
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
<script >

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
    	   var str='';
    	   var temp = '';
    	   $.each(data,function(){
    		   if(this['totId'].substring(0,3) != '999' && temp.substring(0,3) != this['totId'].substring(0,3) && this['isdeleted'] == 'n') {
    			temp = this['totId'];
    		   	str += "/"+this['totId']+",";
    		   	str += this['name']+",";
    		   }
    		   else if(this['totId'].substring(0,3) != '999' && temp.substring(0,3) == this['totId'].substring(0,3) && this['isdeleted'] == 'n') {
    			   str += this['name']+",";
    		   }
    		});
    	  postDataFromAPI(str);
       }, 
       error: function (jqXHR, textStatus, errorThrown) {}
  });
}

 function postDataFromAPI(str) {
       $.ajax({
           url: "/shop/list",
           type: "POST",
           dataType:'json',
           success: 
             function (data) {
        	   var htmls='';
        	   var temp = str.split('/');
        	   var i = 1 ;
               htmls += "<h1>조회하기</h1>";
               htmls += "<select id = 'ord_by' name = 'ord_by' size = '1' onchange = 'changeOrder()'>";
               htmls += "<option value = '1'>Enroll date ASC</option>";
               htmls += "<option value = '2'>Enroll date DESC</option>";
           	   htmls += "<option value = '3'>Name ASC</option>";
           	   htmls += "<option value = '4'>Name DESC</option>";
           	   htmls += "</select>";
               htmls+="<table border='1'>";
               htmls+="<tr><th>이름</th><th>등록일</th><th>커피리스트</th><th>상세 정보</th><th>삭제</th><th>수정</th><th>판매</th></tr>";
               
               $.each(data,function(){
            	   if(temp[i].substring(0,3) != this['sid'] && this['flags'] == 0 ) {
            		   	htmls+="<tr>";
                  		htmls+="<td>"+ this['name'];
                  		htmls+="<td>"+ this['enrolldt']+"</td>";
                  		htmls+="<td>nothing</td>";
                  		htmls+="<td><a href='./detail/"+this['sid']+"'>상세 정보</a></td>";
                  		htmls+="<td><a href='./del/"+this['sid']+"''>삭제</a></td>";
                  		htmls+="<td><a href ='./upd/"+this['sid']+"''>수정</a></td>";
                  		htmls+="<td><a href ='./pos/"+this['sid']+"''>판매</a></td>";
                  		htmls+="</tr>";
            	   }
            	   else if(temp[i].substring(0,3) ==  this['sid'] && this['flags'] == 0 ){
                   		htmls+="<tr>";
                   		htmls+="<td>"+ this['name'];
                   		htmls+="<td>"+this['enrolldt']+"</td>";
                   		htmls+="<td>"+temp[i].substring(6, temp[i].length-1)+"</td>";
                   		htmls+="<td><a href='./detail/"+this['sid']+"'>상세 정보</a></td>";
                   		htmls+="<td><a href='./del/"+this['sid']+"''>삭제</a></td>";
                   		htmls+="<td><a href ='./upd/"+this['sid']+"''>수정</a></td>";
                   		htmls+="<td><a href ='./pos/"+this['sid']+"''>판매</a></td>";
                   		htmls+="</tr>";
                   		i+=1;
                 	}
            	   
                });
               htmls+="</table>";
               htmls+="<a href='/shop/reg'>추가</a>";
    		document.write(htmls);
           }, error: function (jqXHR, textStatus, errorThrown) { }
      });
   }
   
 
 function changeOrder() {
	 var a = $("select[name = ord_by]").val();
	 var temp = a*1;
	 if(temp != null) {
		 $.ajax({
	            type: 'post',
	            data: a,
	            url: '/shop/list/'+ temp,
	            //dataType: 'json',
	            success: function(){
	               alert(a);
	               console.log(a);
	            },
	            error: function(jqXHR, textStatus, errorThrown){}
	        });
	 }
 }
   </script>

</body>
</html>