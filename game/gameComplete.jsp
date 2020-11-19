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
		gID : <%=request.getParameter("gID")%>
		<sql:setDataSource
			url="jdbc:mysql://localhost:3306/pltdb"
			driver="com.mysql.jdbc.Driver"
			user="root"
			password="1234"
			scope="application"
			var="db"
		/>
		<sql:query var="list" dataSource="${db}">
			select * from game where gID = <%=request.getParameter("gID")%>
		</sql:query>
		<c:forEach items="${list.rows}" var="vo">
		${vo}<br>
		<h1>축하합니다 모든 전신주 찾기 완료!</h1>
		획득한 포인트 : +${vo.score}<br>
		시작시간 : ${vo.start}<br>
		완료시간 : ${vo.end}<br>
		</c:forEach>
		
		<h2><a href="../index.jsp">홈으로</a></h2>

	</div>
	<div class='footer'>
		<p>footer</p>
	</div>
</body>
</html>