<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>문제 등록 화면</title>
<style>
body{
	background-color: lightgray;
}
.header {
	background-image: url("../resources/img/p.png");
	margin: 10px;
	padding: 10px;
	height: 150px;
}
.hideHeader {
	width: 350px;
	height: 50px;
	margin-top: 50px;
	margin-left: 500px;
	margin-bottom: 20px;
}
.img{
	background: white;
	float: right;
	width: 80px;
	height: 80px;
}
.poleImgBox {
	width: 600px;
	height: 500px;
}
.poleCheckBox {
	width: 600px;
	height: 500px;
	float: left;
	margin-top: 0px
}
.allHintBox{
  width: 1500px;
	height: 700px;
}
.hintBox {
	width: 250px;
	height: 200px;
	float: left;
	margin-right: 50px;
	margin-left: 40px;
}
.hintBox2 {
	width: 250px;
	height: 200px;
	float: left;
	margin-right: 50px;
}
.hintBox3 {
	width: 250px;
	height: 200px;
	float: left;
}
.hideContainer {
	/* margin-top: 100px; */
	margin-left: 100px;
	margin-right: 200px;
}
.insertButton{
	margin-top: 100px;
	margin-left: 700px;
	margin-right: 400px;
	float: left;
}
.textAreaSize{
  border: 2px solid #f3cc2f;
	resize: none;
	width: 200px;
	height: 100px;
}
.button
	{
		display: inline-block;
		padding: 1em 2em 1em 2em;
		letter-spacing: 0.10em;
		margin-top: 2em;
		padding: 1.40em 3em;
		background: #f3cc2f;
		border-radius: 6px;
		text-decoration: none;
		font-weight: 700;
		font-size: 1em;
		color: #3f0900;
	}
/*구들 지도 스타일 설정  */
#map_ma {width:100%; height:500px; clear:both;}
</style>
</head>
<div class="header"></div>
<body>
	<section class="hideContainer">
		<header class="hideHeader"> <h1>게임 만들기 STEP 4/4</h1></header>
			<div class="img">
				<img src="../resources/img/kakaoQR.png" style="width: 80px; height: 80px;">
				궁금한것은 여기!
			</div>
		<form action="quizSetResult.do" id="qsr">
			<div class="poleCheckBox">
				<div class="poleImgBox">
					<div id="map" style="width:100%; height: 70vh;"></div>
				</div>
			</div>
		<div class="allHintBox">
			<div class="hintBox">
				제목: <input type="text" name="title" value="${QuizSetTitle}"><br> 
				<br>
				모든 전신주 문제: <br> 
				<br>
				첫번째 전신주 문제: <br> 
				<br>
				첫번째 힌트: <textarea class="textAreaSize"  name="hint11">${QuizDetailHintAll[0].getHint1()}</textarea><br>
				<br>
				두번째 힌트: <textarea class="textAreaSize"  name="hint12">${QuizDetailHintAll[0].getHint2()}</textarea><br>
				<br>
				세번째 힌트: <textarea class="textAreaSize"  name="hint13">${QuizDetailHintAll[0].getHint3()}</textarea>
				<input name="ordr1" type="hidden" value="1">
	 			<input type="hidden" name="pID1" value="${QuizDetailHintAll[0].getpID()}">
			</div>
		<div class="hintBox2">
			<br>
			두번째 전신주 문제: <br> 
			<br>
			첫번째 힌트: <textarea class="textAreaSize"  name="hint21">${QuizDetailHintAll[1].getHint1()} </textarea><br>
			<br>
			두번째 힌트: <textarea class="textAreaSize"  name="hint22">${QuizDetailHintAll[1].getHint2()}</textarea><br>
			<br>
			세번째 힌트: <textarea class="textAreaSize"  name="hint23">${QuizDetailHintAll[1].getHint3()}</textarea>
			<input name="ordr2" type="hidden" value="2">
			<input type="hidden" name="pID2" value="${QuizDetailHintAll[1].getpID()}">
		</div>
	<div class="hintBox3">
		<br>
		세번째 전신주 문제: <br> 
		<br>
		첫번째 힌트: <textarea class="textAreaSize"  name="hint31">${QuizDetailHintAll[2].getHint1()} </textarea><br>
		<br>
		두번째 힌트: <textarea class="textAreaSize"  name="hint32">${QuizDetailHintAll[2].getHint2()}</textarea><br>
		<br>
		세번째 힌트: <textarea class="textAreaSize"  name="hint33">${QuizDetailHintAll[2].getHint3()}</textarea>
		<input name="ordr3" type="hidden" value="3">
		<input type="hidden" name="pID3" value="${QuizDetailHintAll[2].getpID()}">
	</div>
<div class="insertButton">
	<button id="sumbit" class="button button-alt">문제 등록</button>
</div>
</div>
</form>
</section>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>	
<!-- 	<script type="text/javascript" src="resources/js/jquery-3.5.1.min.js"></script> -->
<script async defer src="https://maps.googleapis.com/maps/api/js?key=구글키"></script>
<script>
<!-- 뒤로 가기 방지  -->
window.history.forward();
<!-- 구글 지도 api-->	
function initMap() {
	var locations = [//세션에 저장되어 있는 각 전신주의 위도, 경도를 확인하여 지도에 표시하기
  ['첫번째 전신주', ${PoleAll[0].getLatitude()}, ${PoleAll[0].getLongitude()}],
  ['두번째 전신주', ${PoleAll[1].getLatitude()}, ${PoleAll[1].getLongitude()}],
  ['세번째 전신주', ${PoleAll[2].getLatitude()}, ${PoleAll[2].getLongitude()}]
  ];
var map = new google.maps.Map(//지도를 보이고자 하는 기준을 잡는 변수와 메서드
	document.getElementById('map'), {
  zoom: 17,
  center: new google.maps.LatLng( ${PoleAll[0].getLatitude()}, ${PoleAll[0].getLongitude()})
  });
 for (var i = 0; i < locations.length; i++) {
 	marker = new google.maps.Marker({//마커 표시 설정
  	id: i,
    position: new google.maps.LatLng(locations[i][1], locations[i][2]),
    map: map
    })
   var flightPlanCoordinates = [//여러좌표를 기준으로 거리 선 기준 지정하기 위한 설정
  	 { lat: locations[0][1], lng: locations[0][2] },
     { lat: locations[1][1], lng: locations[1][2] },
     { lat: locations[2][1], lng: locations[2][2] },
     ];
   var flightPath = new google.maps.Polyline({//직선 긋는 설정
   	path: flightPlanCoordinates,
    geodesic: false, //곡선 설정
    strokeColor: "#FF0000",//16진수법으로 색깔 설정
    strokeOpacity: 1.0,//선의 불투명도 설정
    strokeWeight: 2,//선 굵기 설정
    });
   flightPath.setMap(map);
   }
	}
</script>
</body>
</html>