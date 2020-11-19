<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>

<!DOCTYPE html>
<html>


<head>

<meta charset="UTF-8">

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
</style>

<title>PLT Shop</title>

<!-- Bootstrap core CSS -->
<link
	href="${pageContext.request.contextPath}/resources/vendor/bootstrap/css/bootstrap.min.css"
	rel="stylesheet">

<!-- Custom styles for this template -->
<link
	href="${pageContext.request.contextPath}/resources/css/shop-homepage.css"
	rel="stylesheet">
<link
	href="${pageContext.request.contextPath}/resources/css/shop-detail.css"
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

<!-- add Cart -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script type="text/javascript">
$(function() {
	$('#cart').click(function() {
		if ("${sessionScope.uID}" != "") {
			//로그인 상태에만 카트 이용 가능! null이 아니었음을..
			$.ajax({
				url : "addCart.do",
				data : {
					uID:"${sessionScope.uID}",
					pdID:"${vo.pdID}",
					cnt: $('#amount').val(),
					price:"${vo.price}"				
				},
				success : function(messege) {
					if (messege) {
						alert("장바구니에 추가되었습니다")
					}else {
						alert("이미 추가하신 상품입니다")
					}
				}
			})//ajax	
		}else {
			alert("로그인후 사용해주세요")
		}			
		
	})//button click
})//ready

</script>


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

<!--Section: Block Content-->
<section class="mb-5">
<br>

<form action="../shop/buy.jsp">
					<input type="hidden" name="pdID" value="${vo.pdID}"> <input
						type="hidden" name="name" value="${vo.name}"> <input
						type="hidden" name="price" value="${vo.price}">
  <div class="row">
    <div class="col-md-6 mb-4 mb-md-0">

      <div id="mdb-lightbox-ui"></div>

      <div class="mdb-lightbox">

        <div class="row product-gallery mx-1">

          <div class="col-12 mb-0">
            <figure class="view overlay rounded z-depth-1 main-img">
                <img src="${vo.img}"
                  class="img-fluid z-depth-1">           
            </figure>

          </div>
          <div class="col-12">
            <div class="row">
              <div class="col-3">

              </div>
              <div class="col-3">

              </div>
              <div class="col-3">

              </div>
              <div class="col-3">

              </div>
            </div>
          </div>
        </div>

      </div>

    </div>
    <div class="col-md-6">

      <h5>${vo.name}</h5>
      <p class="mb-2 text-muted text-uppercase small">${vo.dsc}</p>
      <p><span class="mr-1"><strong><fmt:formatNumber type="number" maxFractionDigits="3"
												value="${vo.price}" />
											원</strong></span></p>

      <hr>
      <div class="table-responsive mb-2">
        <table class="table table-sm table-borderless">
          <tbody>
            <tr>
              <td class="pl-0 pb-0 w-25">수량</td>
            </tr>
            <tr>
              <td class="pl-0">
                <div class="def-number-input number-input safari_only mb-0">
                  <button  type="button" onclick="this.parentNode.querySelector('input[type=number]').stepDown()"
                    class="minus">-</button>
                  <input class="quantity" min="1" name="cnt" value="1" type="number" id="amount">
                  <button  type="button" onclick="this.parentNode.querySelector('input[type=number]').stepUp()"
                    class="plus">+</button>
                </div>
              </td>
            </tr>
          </tbody>
        </table>
      </div>
      
      											<%
												if (session.getAttribute("uID") != null) {
											%>
											<!-- 세션있음 로그인 상태 -->
										  <button type="submit" class="btn btn-primary btn-md mr-1 mb-2">주문하기</button>
											<%
												} else {
											%>
											<button type="button" onclick="alert('로그인 후 이용해주세요')"
												class="btn btn-primary btn-md mr-1 mb-2">주문하기</button>
											<%
												}
											%>
    
      
      <button type="button" class="btn btn-light btn-md mr-1 mb-2" id="cart"><i
          class="fas fa-shopping-cart pr-2"></i>장바구니 담기</button>
    </div>
  </div><!--이걸지우면 세로본능  -->
</form>
</section>
</div> <!-- /.col-lg-9 -->      

<!--Section: Block Content-->
     



    </div><!-- /.row -->
    

  </div>
  <!-- /.container -->

	<!-- Footer -->
	<footer class="footer"></footer>

	<!-- Bootstrap core JavaScript -->
	<script src="../resources/vendor/jquery/jquery.min.js"></script>
	<script src="../resources/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

</body>

</html>