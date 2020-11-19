<%@page import="com.mega.plt.util.CheckCount"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>login</title>
<style type="text/css">
body {
	background-color: lightgray;
}

table {
	font-weight: bold;
	font-size: 14pt;
	margin: 0 auto;
	border-spacing: 2px;
}

#btnLogin {
	width: 150px;
	text-align: center;
}
h1 {
	text-align: center;
}

</style>
</head>
<body>
	<h1>로그인</h1>
	<form action="../user/read.do">
		<table border="1">
			<tr>
				<td>아이디</td>
				<td><input type="text" name="uID" id="uID"></td>
			</tr>
			<tr>
				<td>비밀번호</td>
				<td><input type="text" name="password" id="password"></td>
			</tr>
			<tr>
				<td colspan="2"><button id="btnLogin">로그인</button></td>
			</tr>
		</table>
	</form>
</body>
</html>