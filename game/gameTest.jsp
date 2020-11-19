<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게임</title>
<script type="text/javascript" src="../resources/js/jquery-3.5.1.min.js"></script>
<script type="text/javascript">
	$(function() {

		$("#btnVision").click(function() {
			console.log("이미지 분석 시작...")

			var imgName = document.getElementById("file").files[0].name;
			var filepath = "D:/img/" + imgName // 경로 고정시키기

			$.ajax({
				url : "../util/vision.util",
				method : "GET",
				data : {
					filepath : filepath
				},
				success : function(data) {
					console.log("전체" + data)
					var result = data.split("/")
					var isExist = result[0]
					var poleNum = result[1]
					$("#here").append(isExist)
					$("#here2").append(poleNum)
				},
				error : function() {
					console.log("너 뭔가 잘못한듯")
				}
			})
		})
	})
</script>
</head>
<body>
	<div>
		<label>이미지 업로드</label><br> <input type="file" name="file"
			id="file" accept='image/*' onchange='openFile(event)'>
		<button id="btnVision">업로드하기</button>
	</div>

	<hr>

	<h1 id="here"></h1>
	<h1 id="here2"></h1>

	<hr>

	<img id='output'>
	<script>
		var openFile = function(event) {
			var input = event.target;

			var reader = new FileReader();
			reader.onload = function() {
				var dataURL = reader.result;
				var output = document.getElementById('output');
				output.src = dataURL;
			};
			reader.readAsDataURL(input.files[0]);
		};
	</script>


	<hr>
</body>
</html>