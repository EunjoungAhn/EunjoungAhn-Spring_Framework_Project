<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>정승주차장</title>
<link rel="stylesheet" type="text/css" href="../resources/css/car.css">
<script type="text/javascript" src="../resources/js/jquery-3.5.1.min.js"></script>
<script src="../resources/js/qrcode.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/html2canvas/0.4.1/html2canvas.min.js"></script>
<script type="text/javascript">
	$(function() {
		$("#btnNumber").click(function() {
      $.ajax({
         url : "http://127.0.0.1:8000/test/5/?format=json",
         data : {},
         success : function(data) {
            alert("!!!")
            console.log("차 번호: " + data.number)
            number = data.number
            $('input[name=cNum]').attr('value', number);
         }
      })
   })
		
		$('#qrmk').click(function() {
			$('#qrcode').empty(); // 전에 발급받은 코드가 있다면 삭제
			formData = $('#qrr').serialize(); // 폼의 모든 요소들을 가져옴
			new QRCode(document.getElementById("qrcode"), formData); // QR코드 발급
		})
	})
</script>
</head>
<body>
	<div id="d1">
		<h2>차량 등록</h2>
		<!-- 자동차 번호판 출력 -->      
    <button id="btnNumber">차 번호 인식</button>
		<br>
		<form id="qrr" action="carIn.do">
			차  번  호  <input type="text" name="cNum"><br>
			전화번호  <input type="text" name="phone"><br>
			<button type="submit" id="qrrb">등록</button>
		</form>
		<button id="qrmk">QR</button>
		<a href="pos.do"><button>ADMIN</button></a>
		<a href="../faq/point.jsp"><button>POINT</button></a>
		<a href="../index.jsp"><button id="quick">HOME</button></a>
		<div id="qrcode">
		</div>
	</div>
	
</body>
</html>