<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<h3>전체상품</h3>
<a href="../shop/list.do">전체상품검색</a>

	<form action="../shop/create.do">
		제품번호 <input type="text" name="pdID">
		이름 <input type="text" name="name">
		가격 <input type="text" name="price">
		설명 <input type="text" name="dsc">
		이미지 <input type="text" name="img">
		카테고리 <input type="text" name="category">		
		<button>상품등록</button>
	</form>
</body>
</html>