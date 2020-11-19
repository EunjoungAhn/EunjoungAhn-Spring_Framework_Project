<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>전체 이용자 포인트 순위</title>
<script type="text/javascript" src="../resources/js/jquery-3.5.1.min.js"></script>
<script type="text/javascript">
$(function() {
	$("#sort").click(function() {
		$.ajax({
     	url : "pointUid.do",//mergeSort할 controller로 이동
     	type: "POST",
     	dataType: "json",
     	success : function(mergeSort) {//정렬한 데이터 가져오기
     		console.log(mergeSort)
     		$("table #all").remove();//이전 테이블 지우기
     		for (var i = 0; i < mergeSort.length; i++) {
     				var uID = mergeSort[i].uID
     				var score = mergeSort[i].score
     				var allList = ("<tr id='all'><td>"+(i+1)+"</td><td>"+uID+"</td><td>"+score+"</td></tr>")
         		$("#afterSort").append(allList)//테이블 출력하기
				}//for
	   	}//success
   	})//ajax
	})//click
})
</script>
</head>
<body>
전체 이용자 포인트 순위<br>
정렬 전: <div id="beforeSort">
<sql:setDataSource
url="jdbc:mysql://127.0.0.1:3306/pltdb"
driver="com.mysql.jdbc.Driver"
user="root"
password="1234"
scope="application"
var="db"
/>
<sql:query var="list" dataSource="${db}">
	SELECT uID, score FROM point
</sql:query>
<c:forEach items="${list.rows}" var="vo">
아이디: ${vo.uID} 
스코어: ${vo.score} <br>
</c:forEach>
</div>
정렬 후: <div>
<c:forEach items="${pointSort}" var="vo">
스코어: ${vo.score} <br>
</c:forEach>
<button id="sort">병합정렬</button>
</div>
<table id="afterSort" border="1" style="border-color: skyblue;">
<tr>
<th>순위</th>
<th>유저</th>
<th>점수</th>
</tr>
</table>
<a href="../index.jsp"><button class="button button-alt">홈으로</button></a>
</body>
</html>