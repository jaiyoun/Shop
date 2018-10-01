<!DOCTYPE html>
<html>
   <head>
      <meta charset="UTF-8"/>
      <title>등록하기</title>
      <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
   </head>
   <body>
   <input type="button" name="getData" id="getData" value="GET DATA" onclick="getDataFromAPI();"/>
   <input type="button" name="postData" id="postData" value="POST DATA" onclick="postDataFromAPI();"/>
   <input type="text" name="name" id="name"/>
   <input type="text" name="enroll_dt" id="enroll_dt"/>
   <script>
   function getDataFromAPI() {
       $.ajax({
           url: "/getdata",
           type: "GET",
           success: function (data) {
              console.log("GET DATA API RESPONSE - NAME ::"+data.name);
              console.log("GET DATA API RESPONSE - ENROLL DATE::"+data.enroll_dt);
           }, error: function (jqXHR, textStatus, errorThrown) {
           }
      });
   }
   
   function postDataFromAPI() {
      
      var modelObj = {
            name: $("name").val(),
            enroll_dt: $("enroll_dt").val()
      };
      
      console.log("post data:"+modelObj);      
      
       $.ajax({
               type: "POST",
               url: "/shop/insert",
               headers: {
                   "Content-Type": "application/json"
               },
               data: JSON.stringify(modelObj),
               success: function (data) {
                  console.log("POST API RESPONSE::"+data);
               },
               error: function (jqXHR, textStatus, errorThrown) {
               }
           });
   }
   </script>
   </body>
</html>