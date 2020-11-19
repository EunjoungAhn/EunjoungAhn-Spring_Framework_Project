<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>힌트3 화면</title>
<!-- 숨기기 화면 css -->
<link href="../resources/css/quizSet.css" rel="stylesheet">
<!-- 숨기기 화면 이미지 업로드, 지도 js  -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script type="text/javascript" src="../resources/js/jquery-3.5.1.min.js"></script>
<script type="text/javascript">
window.history.forward();<!-- 뒤로 가기 방지  -->
//이미지 분석 함수
$(function() {
//$(".sumbit").prop("disabled", true);//완료 버튼 비활성화
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
	  	console.log("나는전체ㅋㅋ" + data)
      var result = data.split("/")
      var isExist = result[0]
      var poleNum = result[1]
      $("#pID").append(poleNum)
	    if (isExist == "true") {//pID가 DB에 있다면, 버튼 활성화
				$("#pID").val(poleNum)//pID값을 input에 넣기
				var ordrNum = document.getElementById("ordr").value;
       	$.ajax({
	     		url : "../quiz/distance.do",
	     		data : {
		   			pID : poleNum, //pID값 quizController로 보내기
		   			ordr : ordrNum
		      	},
		      success : function(distance) {//거리 계산 값 받아오기
		      	console.log("거리 계산: "+distance)
            if (distance < 500) {//500미터 보다 작다면 등록 가능 전신주 if문
							$("#poleDiv").html("사용 가능한 전신주입니다.")
							$(".sumbit").prop('disabled', false);
            	}else{//500미터가 넘으면 문제 등록 불가능
            		$("#poleDiv").html("전신주 사이의 길이가 500m가넘습니다. 다른 전신주를 등록해주세요.")
            		$(".sumbit").prop("disabled", true)
            	}//if문
            }//success
           })//2번째 ajax
						}else{
							alert("전신주를 다시 넣어주세요.")//없다면, 비활성화
							$("#sumbit").prop("disabled", true);
						}
	         },
					 error : function() {
						console.log("너 뭔가 잘못한듯")
						}
					})
				})
			})
//전송 전 null값 확인 후 전송
function nullCheck() {
	//hint1 null값 체크
	if(!document.quizSet.hint1.value){
		alert("첫번째 힌트를 입력해주세요");
		document.quizSet.hint1.focus();
		return false;
	}
	//hint2 null값 체크
	if(!document.quizSet.hint2.value){
		alert("두번째 힌트를 입력해주세요"); 
	  document.quizSet.hint2.focus();
		return false;
	  }
	//hint3 null값 체크
	if(!document.quizSet.hint3.value){
	  alert("세번째 힌트를 입력해주세요");  
	  document.quizSet.hint3.focus();  
	  return false;    
	  }
	}
</script>
</head>
<div class="header"></div>
<body>
	<section class="hideContainer">
		<header class="hideHeader"> <h1>게임 만들기 STEP 3/4</h1> </header>
			<div class="qr">
				<img src="../resources/img/kakaoQR.png" style="width: 80px; height: 80px;">
				궁금한것은 여기!
			</div>
		<form action="quizSetHint3.do" name="quizSet" onsubmit="return nullCheck()">
			<div class="poleCheckBox">
				<div class="poleImgBox">
					<div class="img_wrap">
					 <img id="output" class="img"/>
					</div>
				</div>
			<div>
		<div style="margin-left: 120px;  margin-top: 10px;">
			<input type="file" name="file" id="file" accept='image/*' onchange='openFile(event)'>
			<input type="button" id="btnVision" value="업로드하기" >
		 		전신주 번호: <input type="text" name="pID" id="pID" readonly="readonly">
		 			<div id="poleDiv"></div>
		</div>
	</div> 
</div>
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
<div class="allHintBox">
	<div class="hintBox">
		세번째 문제: <br> 
		<br>
		<br>
		첫번째 힌트: <textarea class="textAreaSize" name="hint1" maxlength="80"></textarea><br>
		<br>
		두번째 힌트: <textarea class="textAreaSize" name="hint2" maxlength="80"></textarea><br>
		<br>
		세번째 힌트: <textarea class="textAreaSize" name="hint3" maxlength="80"></textarea>
		<input name="ordr" id="ordr" value="3" type="hidden">
	</div>
<div class="insertButton">
	<div style="color: red">
		*문제 등록전 오타자 혹은 수정사항은 미리 확인해 주세요.*
	</div>
  <button style="margin-top: 10px; margin-left: 200px;" type="submit" class="sumbit button button-alt">완료</button>
</div>
</div>
</form>
</section>
</body>
</html>