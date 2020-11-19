<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>

<!DOCTYPE html>
<html>
<head>
<style type="text/css">
.footer {
	position: absolute;
	left: 0;
	bottom: 0;
	width: 100%;
	padding: 30px 0;
	text-align: center;
	color: white;
	background: #343a40;
}
</style>
<meta charset="utf-8">


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

<!--게임 포인트 조회하기  -->
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script type="text/javascript">
	$(function() {
		$.ajax({
			url : "point.do",
			async : false,
			data : {
				uID : "${sessionScope.uID}"
			},
			success : function(result) {
				pltpoint = result;
				$('#pltpoint').append(result);
			}
		})//ajax		

	})
</script>

</head>
<body>
	<!-- Navigation -->
	<nav class="navbar navbar-expand-lg navbar-dark bg-dark fixed-top">
		<div class="container">
			<a class="navbar-brand" href="../index.jsp"><img alt="전찾시 로고"
				src="../resources/img/logo.png" width="40" height="40"> 전찾시
				게임하러 가기 </a>
			<button class="navbar-toggler" type="button" data-toggle="collapse"
				data-target="#navbarResponsive" aria-controls="navbarResponsive"
				aria-expanded="false" aria-label="Toggle navigation">
				<span class="navbar-toggler-icon"></span>
			</button>
			<div class="collapse navbar-collapse" id="navbarResponsive">
				<ul class="navbar-nav ml-auto">
					<li class="nav-item"><a class="nav-link"
						href="cart.do?uID=${sessionScope.uID}">장바구니</a></li>
					<li class="nav-item"><a class="nav-link"
						href="buylist.do?uID=${sessionScope.uID}">결제내역</a></li>
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
						<a href="category.do?category=1" class="list-group-item">일반상품
							(${c1.count})</a>
					</c:forEach>
					<c:forEach items="${category2.rows}" var="c2">
						<a href="category.do?category=2" class="list-group-item">전찾시
							굿즈 (${c2.count})</a>
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
							<img class="d-block img-fluid"
								src="../resources/img/shop/main1.jpg" alt="First slide">
						</div>
						<div class="carousel-item">
							<img class="d-block img-fluid"
								src="../resources/img/shop/main2.jpg" alt="Second slide">
						</div>
						<div class="carousel-item">
							<img class="d-block img-fluid"
								src="../resources/img/shop/main3.jpg" alt="Third slide">
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
				<!--contents  -->

				<h3>배송정보 입력</h3>
				<hr>

				회원아이디 : ${sessionScope.uID}<br> 회원이름 : ${sessionScope.name}<br>
				상품이름 : ${param.name}<br> 결제금액 :
				<fmt:formatNumber type="number" maxFractionDigits="3"
					value="${param.total}" />
				<br>


				<hr>
				보유 포인트 : <span id="pltpoint"></span>

				<form action="../shop/cartpay.jsp">
					<input type="hidden" name="uID" value="${sessionScope.uID}">
					<input type="hidden" name="pdID" value="${param.pdID}"> <input
						type="hidden" name="cnt" value="${param.cnt}"> <input
						type="hidden" name="total" value="${param.total}"> 사용포인트 :<input
						type="number" min="0" value="0" name="score"><br> <br>
					휴대폰번호: <input type="text" name="phone"><br> <br>
					<input type="text" id="sample6_postcode" placeholder="우편번호"
						name="postcode"> <input type="button"
						onclick="sample6_execDaumPostcode()" value="우편번호 찾기"><br>
					<br> <input type="text" id="sample6_address" placeholder="주소"
						name="address1" style="width: 500px;"><br> <br>
					<input type="text" id="sample6_detailAddress" placeholder="상세주소"
						name="address2" style="width: 500px;"> <input type="text"
						id="sample6_extraAddress" placeholder="참고항목" name="address3">
					<br>
					<script
						src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
					<script>
						function sample6_execDaumPostcode() {
							new daum.Postcode(
									{
										oncomplete : function(data) {
											// 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

											// 각 주소의 노출 규칙에 따라 주소를 조합한다.
											// 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
											var addr = ''; // 주소 변수
											var extraAddr = ''; // 참고항목 변수

											//사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
											if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
												addr = data.roadAddress;
											} else { // 사용자가 지번 주소를 선택했을 경우(J)
												addr = data.jibunAddress;
											}

											// 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
											if (data.userSelectedType === 'R') {
												// 법정동명이 있을 경우 추가한다. (법정리는 제외)
												// 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
												if (data.bname !== ''
														&& /[동|로|가]$/g
																.test(data.bname)) {
													extraAddr += data.bname;
												}
												// 건물명이 있고, 공동주택일 경우 추가한다.
												if (data.buildingName !== ''
														&& data.apartment === 'Y') {
													extraAddr += (extraAddr !== '' ? ', '
															+ data.buildingName
															: data.buildingName);
												}
												// 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
												if (extraAddr !== '') {
													extraAddr = ' ('
															+ extraAddr + ')';
												}
												// 조합된 참고항목을 해당 필드에 넣는다.
												document
														.getElementById("sample6_extraAddress").value = extraAddr;

											} else {
												document
														.getElementById("sample6_extraAddress").value = '';
											}

											// 우편번호와 주소 정보를 해당 필드에 넣는다.
											document
													.getElementById('sample6_postcode').value = data.zonecode;
											document
													.getElementById("sample6_address").value = addr;
											// 커서를 상세주소 필드로 이동한다.
											document.getElementById(
													"sample6_detailAddress")
													.focus();
										}
									}).open();
						}
					</script>
					<br>
					<button>결제하기</button>
				</form>
				<br> <br> <br> <br> <br>
			</div>
			<!-- /.row -->

		</div>
		<!-- /.col-lg-9 -->

	</div>
	<!-- /.row -->



	<!-- /.container -->

  <!-- Footer -->
	<footer class="py-5 bg-dark">
		<div class="container">
			<p class="m-0 text-center text-white">
		</div>
		<!-- /.container -->
	</footer>

	<!-- Bootstrap core JavaScript -->
	<script src="../resources/vendor/jquery/jquery.min.js"></script>
	<script src="../resources/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

</body>

</html>