<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="../resources/css/gameComplete.css" />
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
</head>
<body>
	<div class='header'>
		<p>header</p>
		<a href="../index.jsp">HOME</a>
	</div>
	<div class='content'>
		<h1><%=(String)session.getAttribute("uID")%>님의 기록</h1>
		<sql:setDataSource
			url="jdbc:mysql://localhost:3306/pltdb"
			driver="com.mysql.jdbc.Driver"
			user="root"
			password="1234"
			scope="application"
			var="db"
		/>
		<sql:query var="list" dataSource="${db}">
			select count(*) as gameCount, 
			sum(game.score) as scoreSum 
			from game 
			join gamedetail using (gID) 
			where game.uID = '<%=(String)session.getAttribute("uID")%>' and game.`end` is not null
		</sql:query>
		<c:forEach items="${list.rows}" var="vo">
		<h1>성공한 게임 총 수 : ${vo.gameCount}</h1>
		<h1>획득한 총 점수 : ${vo.scoreSum}</h1>	
		</c:forEach>
		
		<h2><a href="../index.jsp">홈으로</a></h2>

	</div>
	<div class='footer'>
		<p>footer</p>
	</div>
</body>
</html>