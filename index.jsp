<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>전찾시</title>
<script type="text/javascript" src="resources/js/jquery-3.5.1.min.js"></script>
<script type="text/javascript">
	$(function() {
		$("#btnLogout").click(function() {
			$.ajax({
				url : "user/logout.do",
				data : {},
				success : function() {
					alert("로그아웃 되었습니다")
					$("#userInfo").html("안녕하세요! 환영합니다.")
				}
			})
		})
	})
</script>
<style type="text/css">
body {
	background-image: url("resources/img/p.png");
	padding: 30px;
	margin: 0 auto;
	width: 1300px;
	
}
header {
	text-align: center;
	height: 150px;
	background-color: lightgray;
	padding: 20px;
}
#logo {
	font-size: 30px;
}

#btnLogout {
	float: right;
}

ul {
  list-style-type: none;
  margin: 0;
  padding: 0;
  overflow: hidden;
  background-color: #333;
  position: sticky;
  top: 0;
}

li {
  float: left;
}

li a {
  display: block;
  color: white;
  text-align: center;
  padding: 14px 16px;
  text-decoration: none;
}

li a:hover {
  background-color: #111;
}

.main {
	height: 400px;
	background-color: lightgray;
	padding: 20px;
}

.main h1 {
	position: fixed;
	right: 10%;
	top: 25%;
}

#hide {
  border: none;
  color: white;
  padding: 16px 32px;
  text-align: center;
  text-decoration: none;
  display: inline-block;
  font-size: 16px;
  margin: 4px 2px;
  transition-duration: 0.4s;
  cursor: pointer;
  background-color: white;
  color: black;
  border: 2px solid #555555;
}

#hide:hover {
  background-color: #555555;
  color: white;
}

#seek {
  border: none;
  color: white;
  padding: 16px 32px;
  text-align: center;
  text-decoration: none;
  display: inline-block;
  font-size: 16px;
  margin: 4px 2px;
  transition-duration: 0.4s;
  cursor: pointer;
  background-color: white; 
  color: black; 
  border: 2px solid #008CBA;
}
#seek:hover {
  background-color: #008CBA;
  color: white;
}

.button {
  display: inline-block;
  border-radius: 4px;
  background-color: #f4511e;
  border: none;
  color: #FFFFFF;
  text-align: center;
  font-size: 28px;
  padding: 20px;
  width: 200px;
  transition: all 0.5s;
  cursor: pointer;
  margin: 5px;
}

.button span {
  cursor: pointer;
  display: inline-block;
  position: relative;
  transition: 0.5s;
}

.button span:after {
  content: '\00bb';
  position: absolute;
  opacity: 0;
  top: 0;
  right: -20px;
  transition: 0.5s;
}

.button:hover span {
  padding-right: 25px;
}

.button:hover span:after {
  opacity: 1;
  right: 0;
}

#userInfo {
	top: 40%;
	right: 30%;
}

</style>
</head>
<body>
	<header>
		<img alt="전찾시 로고" src="resources/img/logo.png" width="100" height="100"><span id="logo">전찾시</span>
		<button id="btnLogout">로그아웃</button>
	</header>

	<div class="navi">
		<ul>
			<li><a href="user/register.jsp">Join Us</a></li>
			<li><a href="user/login.jsp">Sign in</a></li>
			<li><a href="game/gameTest.jsp">Vision</a></li>
			<li><a href="car/pos.do">Parking</a></li>
			<li><a href="shop/list.do">Shopping</a></li>
			<li><a href="faq/point.jsp">Ranking</a></li>
		</ul>
	</div>
	
	
	<div class="main">
		<h1 id="userInfo">안녕하세요 ${name}(${uID})님</h1>
		<img alt="전봇대 수리기사" src="resources/img/wow.jpg">
		<button onClick="location.href='game/searchQuiz.jsp'" class="button" style="vertical-align:middle"><span>Start</span></button>
		<button onClick="location.href='quiz/quizSetHint1.jsp'" id="hide">숨기기</button>
		<button onClick="location.href='game/myScore.jsp'" id="myScore">내 기록</button>
	</div>

</body>
</html>