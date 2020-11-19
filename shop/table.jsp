<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<!-- Bootstrap core CSS -->
<link
	href="${pageContext.request.contextPath}/resources/vendor/bootstrap/css/bootstrap.min.css"
	rel="stylesheet">

<!-- Custom styles for this template -->
<link
	href="${pageContext.request.contextPath}/resources/css/shop-homepage.css"
	rel="stylesheet">
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<table class="table table-hover" border="1px">
                <thead>
                    <tr>
                        <th>Product</th>
                        <th>Quantity</th>
                        <th class="text-center">Price</th>
                        <th class="text-center">Total</th>
                        <th> </th>
                    </tr>
                </thead>
                <tbody>

                    <tr>
                        <td class="col-sm-1 col-md-1 text-center">
                        <div class="media">
                            <a class="thumbnail pull-left" href="#"> <img class="media-object" src="${vo.img}" style="width: 130px; margin: 5px"> </a>
                            <div class="media-body">
                                <h4 class="media-heading"><a href="#">${vo.name}</a></h4>
                            </div>
                        </div></td>
                        <td class="col-sm-1 col-md-1 text-center">
                       <a href="update.do?pdID=${vo.pdID}&uID=${vo.uID}&cnt=${vo.cnt-1}">
                  <button type="button" onclick="this.parentNode.querySelector('input[type=number]').stepDown()"
                    class="minus">-</button></a>
                  <input class="quantity" min="1" name="cnt" value="${vo.cnt}" type="number" id="amount" oninput="validity.valid||(value=value.replace(/\D+/g, ''))" style="width: 40px; margin: 5px; text-align: left"> 
                  <a href="update.do?pdID=${vo.pdID}&uID=${vo.uID}&cnt=${vo.cnt+1}">
                  <button  type="button" onclick="this.parentNode.querySelector('input[type=number]').stepUp()"
                    class="plus">+</button></a>                    
                        </td>
                        <td class="col-sm-1 col-md-1 text-center"><strong>${vo.price}</strong></td>
                        <td class="col-sm-1 col-md-1 text-center"><strong>$14.61</strong></td>
                        <td class="col-sm-1 col-md-1">
                        <a href="delete.do?pdID=${vo.pdID}&uID=${vo.uID}">
                        <button type="button" class="btn btn-danger" >
                            <span class="glyphicon glyphicon-remove"></span> 삭제
                        </button></a></td>
                    </tr>

                    <tr>
                        <td>   </td>
                        <td>   </td>
                        <td>   </td>
                        <td><h3>총 금액</h3></td>
                        <td class="text-right"><h3><strong><fmt:formatNumber type="number" maxFractionDigits="3" value="${total}"/></strong></h3></td>
                    </tr>
                    <tr>
                        <td>   </td>
                        <td>   </td>
                        <td>   </td>
                        <td>   </td>
                        <td>
                        <button type="button" class="btn btn-success">
                            결제하기 <span class="glyphicon glyphicon-play"></span>
                        </button></td>
                    </tr>
                </tbody>
            </table>
</body>
</html>