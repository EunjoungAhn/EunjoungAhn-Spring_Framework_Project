<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%//로그인 아이디 체크
	String uID = null;
	if (session.getAttribute("uID") != null) {
		uID = (String)session.getAttribute("uID");
		System.out.println(uID);
	}  
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>PLT</title>
<link rel="stylesheet" type="text/css"
	href="../resources/css/searchgame.css" />
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script type="text/javascript"
	src="//dapi.kakao.com/v2/maps/sdk.js?appkey=4cb5e1a136203b333f81e6d90870feae&libraries=services,clusterer"></script>
<script type="text/javascript">
	$(function() {
		$.ajax({
			url : "searchAllQuiz.quiz",
			success : function(json) {
				
				/* ----------------------------------kakao map api---------------------------------- */
				var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
				mapOption = {
					center : new kakao.maps.LatLng(37.557240, 126.936933), // 지도의 중심좌표
					level : 10 // 지도의 확대 레벨
				};

				// 지도를 표시할 div와  지도 옵션으로  지도를 생성합니다
				var map = new kakao.maps.Map(mapContainer, mapOption);
				
				//마커의 이미지 주소, 사이즈, 옵션
				var imageSrc = "../resources/img/pltmarker.png", imageSize = new kakao.maps.Size(54, 60), // 마커이미지의 크기입니다
				imageOption = {
					offset : new kakao.maps.Point(27, 63)
				}; // 마커이미지의 옵션입니다. 마커의 좌표와 일치시킬 이미지 안에서의 좌표를 설정합니다.

				// 마커 이미지를 생성합니다    
				var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize);

				// 마커 클러스터러를 생성합니다 
				var clusterer = new kakao.maps.MarkerClusterer({
					map : map, // 마커들을 클러스터로 관리하고 표시할 지도 객체 
					averageCenter : true, // 클러스터에 포함된 마커들의 평균 위치를 클러스터 마커 위치로 설정 
					minLevel : 4
				// 클러스터 할 최소 지도 레벨 
				});

				var markers = new Array();

				for (key in json) {
					// 마커를 생성합니다
					var marker = new kakao.maps.Marker({
						map : map, // 마커를 표시할 지도
						position : new kakao.maps.LatLng(json[key].latitude, json[key].longitude), // 마커를 표시할 위치
						title : json[key].qID, // 마커의 타이틀, 마커에 마우스를 올리면 타이틀이 표시됩니다
						image : markerImage, // 마커 이미지 
						clickable : true
					// 마커를 클릭했을 때 지도의 클릭 이벤트가 발생하지 않도록 설정합니다
					});
					
					// 인포 윈도우에 들어갈 내용 생성 
					var content = "<br>" 
								 +"<div class='infowin'>"
								 + "게임번호: " + json[key].qID + "<br>"
								 + "제목: " + json[key].title + "<br>"
								 + "출제자: " + json[key].uID + "<br>"
								 + "진행도: <span id='" + json[key].qID + "'></span> / 3<br>"
								 + "<a href='playGame.jsp?qID="+ json[key].qID +"'>게임시작</a>"+"<br>"
								 + "</div>";

					// 마커에 표시할 인포 윈도우를 생성합니다 
					var infowindow = new kakao.maps.InfoWindow({
						content : content, // 인포윈도우에 표시할 내용
						removable : true
					});

					// 마커에 이벤트를 등록하는 함수 만들고 즉시 호출하여 클로저를 만듭니다
					// 클로저를 만들어 주지 않으면 마지막 마커에만 이벤트가 등록됩니다
					(function(marker, infowindow) {
						// 마커에 클릭이벤트를 등록합니다
						kakao.maps.event.addListener(marker, 'click', function() {
							
							// 퀴즈에 대한 유저의 진행도 검색, 결과를 인포윈도우의 진행도 태그안으로 넣어준다
							$.ajax({
								url : "searchProgress.game",
								data : {
									uID : '<%=uID%>',
									qID : marker.getTitle()
								},
								success : function(progress) {
									var spanID = marker.getTitle()
									$('#' + spanID).html(progress)
								},
								error : function() {
									alert("실패")
								}
							})
							// 마커 위에 인포윈도우를 표시합니다
							infowindow.open(map, marker);
						});
					})(marker, infowindow);

					markers.push(marker);
					
					//인포윈도우 게임시작 버튼 클릭 이벤트
					$('#startBtn').click(function() {
						alert('test');
					})
					
				}

				clusterer.addMarkers(markers);
				
				// 일반 지도와 스카이뷰로 지도 타입을 전환할 수 있는 지도타입 컨트롤을 생성합니다
				var mapTypeControl = new kakao.maps.MapTypeControl();

				// 지도에 컨트롤을 추가해야 지도위에 표시됩니다
				// kakao.maps.ControlPosition은 컨트롤이 표시될 위치를 정의하는데 TOPRIGHT는 오른쪽 위를 의미합니다
				map.addControl(mapTypeControl, kakao.maps.ControlPosition.TOPRIGHT);

				// 지도 확대 축소를 제어할 수 있는  줌 컨트롤을 생성합니다
				var zoomControl = new kakao.maps.ZoomControl();
				map.addControl(zoomControl, kakao.maps.ControlPosition.RIGHT);

			
				
				/* 주소검색버튼 */
				$('#serchAdress').click(function() {
					
					var keyword = $('#keyword').val()
					
					// 주소-좌표 변환 객체를 생성합니다
					var geocoder = new kakao.maps.services.Geocoder();

					// 주소로 좌표를 검색합니다
					geocoder.addressSearch(keyword, function(result, status) {

					    // 정상적으로 검색이 완료됐으면 
					     if (status === kakao.maps.services.Status.OK) {

					        var coords = new kakao.maps.LatLng(result[0].y, result[0].x);

					        // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
					        map.setCenter(coords);
					        map.setLevel(5);
					    } 
					});    
					
				})
				/* ----------------------------------kakao map api---------------------------------- */
			},
			error : function() {
				alert('ajax 실패 ㅠㅠ')
			}
		})
		
	
	})
</script>
</head>
<body>
	<div class='header'>
		<p>header</p>
		<a href="../index.jsp">HOME</a>
	</div>
	<div class='content'>
		<div class='left'>
			지명으로 위치 검색 <input id="keyword" type="text" />
			<button id="serchAdress">주소검색</button>
			<div id="map"></div>
		</div>
	</div>
	<div class='footer'>
		<p>footer</p>
	</div>
</body>
</html>