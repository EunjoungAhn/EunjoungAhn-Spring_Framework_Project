<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="java.time.LocalDate"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	Date date = new Date();
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	String today = sdf.format(date);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>주차장</title>
<link rel="stylesheet" type="text/css" href="../resources/css/car.css">
<script type="text/javascript" src="../resources/js/jquery-3.5.1.min.js"></script>
<script type="text/javascript">
	$(function() {
		// 나감 버튼 클릭 시
		$('#out').click(function() {
			$.ajax({
				url: "../car/out.do",
				success: function(result) {
					console.log(result)
					$('#tab').empty();
					$('#tab').append(result);
					if ($('#t2').text() == "") {
						alert('다 나갔어요....')
						$('#tab').empty();
					}
				},
				error: function() {
					console.log("이상해..")
				}
			})
		}) // out end
		
		// 결제 버튼 클릭 시
		$('#pay').click(function() {
			cID2 = $('#t1').text();
			outTime2 = $('#t4').text();
			price2 = $('#t5').text();
			$.ajax({
				url: "../car/pay.do",
				data: {
					cID: cID2,
					outTime: outTime2,
					price: price2
				},
				success: function(result) {
					if (price2 == 0) {
						alert("나가세요..")
					} else{
						alert("결제되었습니다.")
					}
					$('#tab').empty();
					$('#tab').append(result);
					$('#incar').empty();
				},
				error: function() {
					console.log("결제하다가 오류났어!..")
				}
			})
		}) // pay end
		
		// 초기화 버튼 클릭 시
		$('#reset').click(function() {
			$('#t1').empty();
			$('#t2').empty();
			$('#t3').empty();
			$('#t4').empty();
			$('#t5').empty();
		}) // reset end
		
		// 현재 상황 클릭 시
		$('#present').click(function() {
			$.ajax({
				url: "../car/present.do",
				success: function(result) {
					$('#incar').html(result)
				},
				error: function() {
					console.log("현재 상황 불러오다가 오류났어!")
				}
			})
		}) // present end
		
	}) // function end
</script>
</head>
<body>
	<button id="present">현재 상황</button>
	<a href="car_in.jsp"><button id="in">IN</button></a>
	<button id="out">OUT</button>
	<br><br>
	<table border="1" id="tab">
		<tr>
			<th width="150">No</th>
			<td id="t1" width="150"></td>
		</tr>
		<tr>
			<th>차 번호</th>
			<td id="t2"></td>
		</tr>
		<tr>
			<th>들어온 시간</th>
			<td id="t3"></td>
		</tr>
		<tr>
			<th>나가는 시간</th>
			<td id="t4"></td>
		</tr>
		<tr>
			<th>금액</th>
			<td id="t5"></td>
		</tr>
	</table> <br>
	<button id="reset">초기화</button>
	<button id="pay">결제</button>
	<a href="month_chart.jsp"><button id="chart">매출</button></a>
	<a href="../index.jsp"><button id="home">HOME</button></a>
	<div id="show">
		<span id="incar"></span>
	</div>
	
</body>
</html>