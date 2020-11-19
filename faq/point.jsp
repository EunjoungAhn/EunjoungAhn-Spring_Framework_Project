<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="../resources/css/car.css">
<script type="text/javascript" src="../resources/js/jquery-3.5.1.min.js"></script>
<script type="text/javascript">
$(function() {
   $('#quick').click(function() {
      $.ajax({
         url: "point.do",
         type: 'POST',
         dataType: 'json',
         success: function(result) {
            console.log(result)
            $('table #re').remove()
            var j = 1;
            for (var i = result.length-1; i >= 0; i--) {
               uID = result[i].uID
               score = result[i].score
               list = uID + ", " + score + "<br>"
               a = "<tr id='re'><td>"+(j++)+"</td><td>"+uID+"</td><td>" + score + "</td></tr>"
               $('#tab').append(a)
            }
         }
      })
   })
   $("#merge").click(function() {
      $.ajax({
        url : "pointUid.do",//mergeSort할 controller로 이동
        type: "POST",
        dataType: "json",
        success : function(mergeSort) {//정렬한 데이터 가져오기
           console.log(mergeSort)
           $("table #re").remove();//이전 테이블 지우기
           var j = 1;
           for (var i = mergeSort.length-1; i >= 0; i--) {
                 var uID = mergeSort[i].uID
                 var score = mergeSort[i].score
                 var allList = ("<tr id='re'><td>"+(j++)+"</td><td>"+uID+"</td><td>"+score+"</td></tr>")
               $("#tab").append(allList)//테이블 출력하기
            }//for
         }//success
      })//ajax
   })//click
})
</script>
</head>
<body>
<button id="quick">quick</button>
<button id="merge">merge</button>
<a href="../index.jsp"><button id="quick">HOME</button></a>
<div id="d2">
</div><br>
<table id="tab" border="1">
   <tr>
      <th width="100">no</th>
      <th width="100">유저</th>
      <th width="100">점수</th>
   </tr>
</table>
</body>
</html>