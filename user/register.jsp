<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
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
	<h1>회원가입</h1>
	<form action="../user/create.do">
		<table border=1>
			<tr>
				<td>아이디</td>
				<td><input type="text" name="uID"></td>
			</tr>
			<tr>
				<td>비밀번호</td>
				<td><input type="text" name="password"></td>
			</tr>
			<tr>
				<td>이름</td>
				<td><input type="text" name="name"></td>
			</tr>
			<tr>
				<td colspan=2><button>회원가입</button></td>
			</tr>
		</table>
	</form>
</body>
</html>