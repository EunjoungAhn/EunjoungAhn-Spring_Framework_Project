<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>
<h1>결제완료</h1>
회원아이디 : ${sessionScope.uID}<br>
회원이름 :  ${sessionScope.name}<br>
상품 아이디 : ${param.pdID}<br>
구매 수량 : ${param.cnt}<br>
사용pole : ${-param.score}<br>
전화번호 : ${param.phone}<br>
배송지 : (${param.postcode})${param.address1} ${param.address3} ${param.address2} <br>
<hr>
결제금액 : ${param.total-(param.score*20)}<br>
</body>
</html>