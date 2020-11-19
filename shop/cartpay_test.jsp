<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>

<!DOCTYPE html>
<html>

<head>

<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">

<title>PLT Shop</title>

<!-- Bootstrap core CSS -->
<link
	href="${pageContext.request.contextPath}/resources/vendor/bootstrap/css/bootstrap.min.css"
	rel="stylesheet">

<!-- Custom styles for this template -->
<link
	href="${pageContext.request.contextPath}/resources/css/shop-homepage.css"
	rel="stylesheet">
	
<!-- 카테고리별 상품 개수  -->	
<sql:setDataSource url="jdbc:mysql://localhost:3306/pltdb"
	driver="com.mysql.jdbc.Driver" user="root" password="1234"
	scope="application" var="db" />
<sql:query var="all" dataSource="${db}">
	select count(category) as "count" from product
</sql:query>

<sql:query var="category1" dataSource="${db}">
	select count(category) as "count" from product where category='1'
</sql:query>

<sql:query var="category2" dataSource="${db}">
	select count(category) as "count" from product where category='2'
</sql:query>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script type="text/javascript">
$(function() {
	//결제 api 로드하기 전에 , 사용자 입력값 유효성 체크하기
			$.ajax({
			url : "point.do",			
			data : {
				uID : "${sessionScope.uID}"				
			},
			success : function(result) {
				if (result < '${param.score}') { //보유포인트 < 사용포인트 
					alert("포인트 사용 불가")
					window.history.back(); //이전페이지로 돌아감
				}else if ("${param.postcode}" == "" || "${param.phone}"== "" || "${param.address2}" == "") {
					// 주소, 연락처 정보 입력 안했을때
					alert("배송지 정보를 다시 확인해주세요")
					window.history.back();
				}else {
					/*  결제API 호출*/
					
					$('#payment').click(function() {
						alert("디비저장")

						$.ajax({
							url : "../shop/cartpay2.do",
							data : {
								uID: '${sessionScope.uID}',							
								cnt: '${param.cnt}',
								total: '${param.total-(param.score*20)}',
								pnt: '${param.score*20}',
								score: '${-param.score}',
								address: '(${param.postcode}) ${param.address1} ${param.address3} ${param.address2}',
								phone: '${param.phone}'     		
							},
							success : function() {
							
							}
						})
						
						
					})//button click
					/* 결제API 끝 */
				}
			}
		})//ajax
})//ready

</script>

</head>
<body>
<h1>카트에 담아둔 물건 결제진행중</h1>
회원아이디 : ${sessionScope.uID}<br>
회원이름 :  ${sessionScope.name}<br>
상품 아이디 : ${param.pdID}<br>
구매 수량 : ${param.cnt}<br>
사용pole : ${-param.score}<br>
전화번호 : ${param.phone}<br>
배송지 : (${param.postcode})${param.address1} ${param.address3} ${param.address2} <br>
<hr>
결제금액 : ${param.total-(param.score*20)}<br>
<button id = "payment">결제하기</button>
</body>
</html>