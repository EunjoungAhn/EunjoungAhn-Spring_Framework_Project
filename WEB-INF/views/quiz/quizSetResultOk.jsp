<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%session.removeAttribute("PoleAll"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>힌트4 화면</title>
<style>
body{
	background-color: lightgray;
}
.header {
	background-image: url("../resources/img/p.png");
	margin: 10px;
	padding: 10px;
	height: 150px;
}
.hideHeader {
	width: 350px;
	height: 50px;
	margin-top: 50px;
	margin-left: 500px;
	margin-bottom: 20px;
}
.button{
		display: inline-block;
		padding: 1em 2em 1em 2em;
		letter-spacing: 0.10em;
		margin-top: 2em;
		padding: 1.40em 3em;
		background: #f3cc2f;
		border-radius: 6px;
		text-decoration: none;
		font-weight: 700;
		font-size: 1em;
		color: #3f0900;
}
</style>
</head>
<div class="header"></div>
<body>
	<header class="hideHeader"> <h1>숨기기 문제가 등록 되었습니다.</h1> </header>
		<div class="button">
		    <a href="../quiz/quizSetHint1.jsp"><button>다른 문제 등록하기</button></a>
		    <h4><a href="../index.jsp"><button class="button button-alt">홈으로</button></a></h4>
		</div>
</body>
</html>