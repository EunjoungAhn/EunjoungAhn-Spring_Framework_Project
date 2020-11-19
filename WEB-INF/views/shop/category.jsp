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
<sql:setDataSource url="jdbc:mysql://localhost:3366/pltdb"
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
						<a href="category.do?category=1" class="list-group-item">일반상품 (${c1.count})</a>
					</c:forEach>
					<c:forEach items="${category2.rows}" var="c2">
						<a href="category.do?category=2" class="list-group-item">전찾시 굿즈 (${c2.count})</a>
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
<!--contents  -->

				<div class="row">

					<c:forEach var="vo" items="${list}">
						<div class="col-lg-4 col-md-6 mb-4">
							<div class="card h-100">
								<a href="detail.do?pdID=${vo.pdID}"><img
									class="card-img-top" src="${vo.img}" alt=""></a>
								<div class="card-body">
									<h4 class="card-title">
										<a href="detail.do?pdID=${vo.pdID}">${vo.name}</a>
									</h4>
									<h5>
										<fmt:formatNumber type="number" maxFractionDigits="3"
											value="${vo.price}" />
									</h5>
									<p class="card-text">${vo.dsc}</p>
								</div>
								<div class="card-footer">
									<small class="text-muted">&#9733; &#9733; &#9733;
										&#9733; &#9734;</small>
								</div>
							</div>
						</div>
					</c:forEach>

				</div>
				<!-- /.row -->

			</div>
			<!-- /.col-lg-9 -->

		</div>
		<!-- /.row -->

	</div>
	<!-- /.container -->

	<!-- Footer -->
	<footer class="py-5 bg-dark">
		<div class="container">
		</div>
		<!-- /.container -->
	</footer>

	<!-- Bootstrap core JavaScript -->
	<script src="../resources/vendor/jquery/jquery.min.js"></script>
	<script src="../resources/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

</body>

</html>