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

<!--아임포트 라이브러리  -->
<script type="text/javascript"
	src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
<script type="text/javascript"
	src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>

<script type="text/javascript">
$(function() {
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
				/* 아임포트 결제 API */
				var IMP = window.IMP; // 생략가능
				IMP.init('imp28770680'); // 'iamport' 대신 부여받은 "가맹점 식별코드"를 사용
				IMP.request_pay({
					pg : 'html5_inicis', // version 1.1.0부터 지원.
				    pay_method : 'card',
				    merchant_uid : 'merchant_' + new Date().getTime(),
				    name : '주문명:결제테스트',
				    amount : '${param.total-(param.score*20)}',
				    buyer_email : 'iamport@siot.do',
				    buyer_name : '${sessionScope.name}',
				    buyer_tel : '${param.phone}',
				    buyer_addr : '${param.address1}',
				    buyer_postcode : '${param.postcode}',
				    
				}, function(rsp) {
				    if ( rsp.success ) {
				        var msg = '결제가 완료되었습니다.';
				        msg += '고유ID : ' + rsp.imp_uid;
				        msg += '상점 거래ID : ' + rsp.merchant_uid;
				        msg += '결제 금액 : ' + rsp.paid_amount;
				        msg += '카드 승인번호 : ' + rsp.apply_num;
				        
				        /* 결제완료시 DB에 저장 */
						$.ajax({
							url : "cartpay2.do",
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
						/* 결제완료시 DB에 저장 */
						location.href = "ok.jsp"
				    } else {
				        var msg = '결제에 실패하였습니다.';
				        msg += '에러내용 : ' + rsp.error_msg;
				        location.href = "fail.jsp"
				    }
				    alert(msg);
				});
				
				/* 아임포트 결제 API */				
			}//else
		}//success
	})//ajax 포인트 조회
})//ready
</script>

</head>
<body>

<!-- Navigation -->
	<nav class="navbar navbar-expand-lg navbar-dark bg-dark fixed-top">
		<div class="container">
			<a class="navbar-brand" href="../index.jsp"><img alt="전찾시 로고" src="../resources/img/logo.png" width="40" height="40"> 전찾시 게임하러 가기 </a>
			<button class="navbar-toggler" type="button" data-toggle="collapse"
				data-target="#navbarResponsive" aria-controls="navbarResponsive"
				aria-expanded="false" aria-label="Toggle navigation">
				<span class="navbar-toggler-icon"></span>
			</button>
			<div class="collapse navbar-collapse" id="navbarResponsive">
				<ul class="navbar-nav ml-auto">
					<li class="nav-item"><a class="nav-link" href="cart.do?uID=${sessionScope.uID}">장바구니</a></li>
					<li class="nav-item"><a class="nav-link" href="buylist.do?uID=${sessionScope.uID}">결제내역</a>
					</li>					
				</ul>
			</div>
		</div>
	</nav>

	<!-- Page Content -->
	<div class="container">
		<div class="row">
			<div class="col-lg-3">

				<h1 class="my-4"></h1>
				<div class="list-group">
					<c:forEach items="${all.rows}" var="all">
						<a href="list.do" class="list-group-item">ALL (${all.count})</a>
					</c:forEach>
					<c:forEach items="${category1.rows}" var="c1">
						<a href="category.do?category=1" class="list-group-item">Category
							1 (${c1.count})</a>
					</c:forEach>
					<c:forEach items="${category2.rows}" var="c2">
						<a href="category.do?category=2" class="list-group-item">Category
							2 (${c2.count})</a>
					</c:forEach>

				</div>

			</div>
			<!-- /.col-lg-3 -->

			<div class="col-lg-9">

				<div id="carouselExampleIndicators" class="carousel slide my-4"
					data-ride="carousel">
					<ol class="carousel-indicators">
						<li data-target="#carouselExampleIndicators" data-slide-to="0"
							class="active"></li>
						<li data-target="#carouselExampleIndicators" data-slide-to="1"></li>
						<li data-target="#carouselExampleIndicators" data-slide-to="2"></li>
					</ol>
					<div class="carousel-inner" role="listbox">
						<div class="carousel-item active">
							<img class="d-block img-fluid" src="../resources/img/shop/main1.jpg"
								alt="First slide">
						</div>
						<div class="carousel-item">
							<img class="d-block img-fluid" src="../resources/img/shop/main2.jpg"
								alt="Second slide">
						</div>
						<div class="carousel-item">
							<img class="d-block img-fluid" src="../resources/img/shop/main3.jpg"
								alt="Third slide">
						</div>
					</div>
					<a class="carousel-control-prev" href="#carouselExampleIndicators"
						role="button" data-slide="prev"> <span
						class="carousel-control-prev-icon" aria-hidden="true"></span> <span
						class="sr-only">Previous</span>
					</a> <a class="carousel-control-next" href="#carouselExampleIndicators"
						role="button" data-slide="next"> <span
						class="carousel-control-next-icon" aria-hidden="true"></span> <span
						class="sr-only">Next</span>
					</a>
				</div>

	<h1>결제진행중</h1>

	<br>
	회원아이디 : ${sessionScope.uID}
	<br> 회원이름 : ${sessionScope.name}
	<br> 상품 아이디 : ${param.pdID}
	<br> 구매 수량 : ${param.cnt}
	<br> 사용pole : ${-param.score}
	<br> 전화번호 : ${param.phone}
	<br> 배송지 : (${param.postcode})${param.address1} ${param.address3}
	${param.address2}
	<br>
	<hr>
	결제금액 : ${param.total-(param.score*20)}
	<br>
	<br>
	<br>
	<br>

</div>
				<!-- /.row -->

			</div>
			<!-- /.col-lg-9 -->

		</div>
		<!-- /.row -->


	
	<!-- /.container -->

	<!-- Footer -->
	<footer>
		
	</footer>

	<!-- Bootstrap core JavaScript -->
	<script src="../resources/vendor/jquery/jquery.min.js"></script>
	<script src="../resources/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

</body>

</html>