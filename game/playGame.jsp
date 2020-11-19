<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	//로그인 아이디 체크
String uID = "user1";
if (session.getAttribute("uID") != null) {
	uID = (String) session.getAttribute("uID");
	System.out.println(uID);
}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>PLT</title>
<link rel="stylesheet" type="text/css"
	href="../resources/css/playgame.css" />
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script type="text/javascript"
	src="//dapi.kakao.com/v2/maps/sdk.js?appkey=카카오키=clusterer"></script>
<script type="text/javascript">
	/* 힌트순서 큐 */
	class HintQueue {
		  constructor() {
		    this.store = [];
		  }
		  
		  enqueue(item) {
		    this.store.push(item);
		  }
		  
		  dequeue() {
		    return this.store.shift();
		  }
	}

	const queue = new HintQueue(); //힌트큐 : 페이지 로딩시 2번 힌트와 3번을 넣은 후 힌트보기를 누르면 디큐

	$(function() {
		$.ajax({
			url : "searchProgress.game",
			async:false,
			data : {
				uID : '<%=uID%>',
				qID : <%=request.getParameter("qID")%>
			},
			success : function(progress) {
				//첫도전 = -1, 하나도 안풀었다 0,  하나 풀었으면 1, 두개면 2, 모두 풀었으면 3
				console.log("진행도 검색결과 progress : " + progress);
				loadQuiz(progress*1);
			},
			error : function() {
				alert("진행도 검색실패")
			}
		})
		
		function loadQuiz(progress) {
		
			if(progress >= 0 && progress < 3){
				//기록 가져오기
					$.ajax({
					url : "getRecord.game",
					async:false,
					data : {
						uID : '<%=uID%>',
						qID : <%=request.getParameter("qID")%>
					},
					success : function(result) {
						console.log(result)	
						
						$('#gID').text(result.gID);
						$('#startTime').text(result.start);
						var pNo = (result.isSolved1*1 + result.isSolved2*1 + result.isSolved3*1) + 1 ; //찾아야할 전신주가 몇번째
						$('#pNo').text(pNo);
						var hintNo = 3 - (result.hint1*1 + result.hint2*1 + result.hint3*1); //남은 힌트보기 기회
						
						var score = 30 - (3-hintNo)*5 //현제 스코어 = 30 - (힌트사용횟수*5)
						$('#score').text(score);
					
						$('#hintNo').text(hintNo);
						
						//찾아야할 전신주에 맞는 데이터 가져온 후 UI반영
						$.ajax({
							url: "selectQuiz.quiz",
							async: false,
							data:{
								qID : <%=request.getParameter("qID")%>,
								ordr : pNo
							},
							success : function(pole) {
								console.log(pole)
								
								//나중에 정답확인을 위해 pID를 text값으로 넣어둠
								//이 element는 display none으로 되어있음
								$("#answer").text(pole.pID); 
								
								//전신주 정보를 화면에 출력
								$('#hint1').text(pole.hint1)
								$('#hint2').text(pole.hint2)
								$('#hint3').text(pole.hint3)
								$('#hint2box').hide() //1번 힌트만 노출
								$('#hint3box').hide()
								queue.enqueue(2) //2번 힌트 인덱스 인큐
								queue.enqueue(3) //3번 힌트 인덱스 인큐
								
								/* kakao map api */	
								
								//전신주 좌표와 원의 중심이 어긋나도록 원래 좌표에 임의값을 더해줌
								var longtitude = (pole.longtitude * 1) + 0.0004;
								var latitude = (pole.latitude * 1) + 0.0002;
								var position = new  kakao.maps.LatLng(latitude, longtitude);
								
								var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
								mapOption = {
									center : position, // 지도의 중심좌표
									level : 2 // 지도의 확대 레벨
								};

								// 지도를 표시할 div와  지도 옵션으로  지도를 생성합니다
								var map = new kakao.maps.Map(mapContainer, mapOption);
								
								// 지도에 표시할 원을 생성합니다
								var circle = new kakao.maps.Circle({
								    center : position,  // 원의 중심좌표 입니다 
								    radius: 100, // 미터 단위의 원의 반지름입니다 
								    strokeWeight: 5, // 선의 두께입니다 
								    strokeColor: '#75B8FA', // 선의 색깔입니다
								    strokeOpacity: 1, // 선의 불투명도 입니다 1에서 0 사이의 값이며 0에 가까울수록 투명합니다
								    strokeStyle: 'dashed', // 선의 스타일 입니다
								    fillColor: '#CFE7FF', // 채우기 색깔입니다
								    fillOpacity: 0.7  // 채우기 불투명도 입니다   
								}); 

								// 지도에 원을 표시합니다 
								circle.setMap(map); 
								
								// 커스텀 오버레이를 생성합니다
								var customOverlay = new kakao.maps.CustomOverlay({
								    position: position,
								    content: '<span style="color:red">이 원 어딘가에 있습니다!!</span>'
								});

								// 커스텀 오버레이를 지도에 표시합니다
								customOverlay.setMap(map);
								
								/* kakao map api */	
								
							},
							error : function() {
								alert("퀴즈 불러오기 실패")
							}
						})
					},
					error : function() {
						alert("기록 불러오기 실패")
					}
				})
				
			}else if(progress == -1){
				// 첫 도전일때 새로운 기록 insert
				$.ajax({
					url : "insertRecord.game",
					async:false,
					data : {
						uID : '<%=uID%>',
						qID : <%=request.getParameter("qID")%>
					},
					success : function(result) {
						history.go(0); //insert 후 새로고침
					},
					error : function() {
						alert("진행도 insert 실패")
					}
				})
			}else{
				alert("이미 완료한 게임입니다")
				history.go(-1); //뒤로가기
			}
			
		}
		
		$('#showHint').click(function() {
			
			if($('#hintNo').text()*1 > 0){
				var hintbox = queue.dequeue();
				//남은 힌트 수가 3회면 hint1 업데이트,  2회 -> hint2, 1회 -> hint3
				var hintcol = 4 - $('#hintNo').text()*1
				if(hintbox == 2){
					updateHint(hintbox, hintcol)
				}else if(hintbox == 3){
					updateHint(hintbox, hintcol)
				}else{
					alert("이 전신주에 대한 힌트는 더 이상 없습니다")
				}	
			}else{
				alert('힌트보기 기회를 모두 소진 하셨습니다.')
			}
			
			
		})
		
		function updateHint(hintbox, hintcol) {
			//hint2box.show()
			//힌트기회 하나 차감 DB update
			//남은힌트보기 span 업데이트 -1
			//현재스코어 span 업데이트 -5
			
			//or
			
			//hint3box.show()
			//힌트기회 하나 차감 DB update
			//남은힌트보기 span 업데이트 -1
			//현재스코어 span 업데이트 -5
			if(hintbox==2){
				$('#hint2box').show();
			}else if(hintbox==3){
				$('#hint3box').show();
			}
			$.ajax({
				url : 'updateHintChance.game',
				data: {
					hintcol : hintcol,
					gID : $('#gID').text()
				},
				success : function(result) {
					//alert('업데이트 결과' + result)
					//힌트보기 기회 UI 업데이트
					var newHintNo = $('#hintNo').text()*1 - 1;
					$('#hintNo').text(newHintNo);
					//총점 UI 업데이트
					var newscore = $('#score').text()*1 - 5;
					$('#score').text(newscore);
					
				},
				error : function() {
					alert('업데이트 결과' + result)
				}
			})
		}
		
		$("#checkAnswer").click(function() {
			var inputPid = $("#here2").val();
			if(inputPid == $("#answer").text()){
				//정답
				alert('정답입니다! 축하합니다!')				
				var gID = $("#gID").text()*1; //어떤 게임기록인지
				var colNo = $("#pNo").text(); //몇 번째 전신주인가 isSolved1 or 2 or 3
				$.ajax({
					url: 'updateIsSolved.game',
					data : {
						gID : gID,
						solvedCol : colNo
					},
					success : function(result) {
						
						//문제를 다 풀었다면 스코어 반영하고 결과 페이지로 이동
						if(colNo == 3){
							$.ajax({
								url : 'updateScore.game',
								data : {
									gID : gID,
									score : $("#score").text(),
									uID : '<%=uID%>'
								},
								success : function(result) {
									if(result == 'true'){
										//결과페이지로 이동
										//gID
										location.href = "gameComplete.jsp?gID="+$('#gID').text();
										
									}
								},
								error : function() {
									alert(result)
								}
							})
						}else{							
							history.go(0); //update 후 새로고침
						}
								
					},
					error : function() {
						alert('업데이트실패');
					}
				})
			}else{
				//오답
				alert('오답입니다 ㅠㅠ')
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
	<div class='quizset'>
		<span>QuizSetID: <%=request.getParameter("qID")%></span>&nbsp&nbsp gID : <span id='gID'></span>
		&nbsp&nbsp 현재
		스코어: <span id='score'></span>/30 &nbsp&nbsp 전신주: <span id='pNo'></span>/
		3 &nbsp&nbsp 시작: <span id='startTime'></span> <br> 남은 힌트보기 횟수: <span
			id='hintNo'></span>/3 (한 게임당 3번의 기회가 주어지며 사용시 5점이 차감됩니다) <span id="answer" style="display: none;">...</span>
	</div>
	<div class='content'>

		<div class='left'>
			<div id="map"></div>
		</div>
		<div class='right'>
			<div class='hint'>
				<div class='top'>
					<div id='hint1box'
						style="margin: 10px; padding-top: 20px; border: 1px solid red;">
						힌트 1 : <span id='hint1'>힌트 들어갈자리</span>
						<p>1/3</p>
					</div>
					<div id='hint2box'
						style="margin: 10px; padding-top: 20px; border: 1px solid red;">
						힌트 2 : <span id='hint2'>힌트 들어갈자리</span>
						<p>2/3</p>
					</div>
					<div id='hint3box'
						style="margin: 10px; padding-top: 20px; border: 1px solid red;">
						힌트 3 : <span id='hint3'>힌트 들어갈자리</span>
						<p>3/3</p>
					</div>
				</div>
				<div class='bottom'>
					<button id='showHint'>힌트보기</button><br>
					*주의 : 이 페이지를 새로고침 하거나 떠나면<br>오픈한 힌트는 다시 볼 수 없어요!* 
				</div>
			</div>
			<div class='img'>
				<div class='top'>
					<p>
						힌트를 보고 어떤 전신주인지 맞춰보세요.<br>정답이라고 생각하는 전신주의<br>전주번호철 사진을
						업로드하세요.<br>정답확인 횟수에는 제한이 없습니다
					</p>
					<img width="250" height="250" id='output' style="border: 1px solid black" alt=""
						src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAOEAAADhCAMAAAAJbSJIAAAAdVBMVEX////7+/sAAACenp7i4uKampqurq74+Pijo6NVVVVpaWnw8PBvb2/l5eW7u7vs7OxiYmKDg4PR0dHGxsa0tLSnp6dLS0tGRkbLy8srKyva2tqNjY2EhIRRUVExMTF4eHg7OztAQEAQEBBbW1skJCQYGBgfHx/MtWJCAAADkElEQVR4nO3X2XKiQBiG4QbBhmZrFgVBBOPM3P8lDrsaSaWcSczJ+xykGtAv/dsLIAQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAADwWmXmbJytNR546XYURuMJGe42TmY9myOicA7ypuQhKPrq3n8usHPtx83ezYz+MNnnbq9uyvFy0/qx37rpkzkizfdjUDzWXKpzE/snXXxbJR9JmiKIPC+oTuHQsVMWWL1ADpf3dRF5kRUfkudyRNamU9BQsZfrpAsqVV5+YzGr5DSJhHb7rqT7u1KqX9OsO6jncsS2vp3ZRpwHQyM6xP/X3/+wM/tRC893FZrV1EjePp2ndzlit7+r0HSmVnj6bDZ8m+1Y4eW2Y6k5zynjMNcqZLpMtDKVH+SInbrdVLa/lh3osPuqHj9r9zZWGAi5dNv5PbcM5c/NqNFTiaW+BB/kCEd5N0HH/dzyLtXDV17E1/36yVQR2lWWjAMQ58vlSi/NQKmhxFKpxwKnHGE3SVhVWTkuT70sYxn/1EJMD/1CMzZ/XBUfVe4Ps0q5y3XH9Zb2WOJ6gWOOkMeDq45dUDx8Jl9mgLT9x5n9Cp4//uP0mHbD5xX+sIzc6w56W2FXorYsvVbgnCOyKvX6Bwjd9N87LQMnq5+pUG7qcW3NSydps+7vZX0MhxJXC1xyhBxv/CJt+zFtr2P4QxWGp+z+hOdXXRfVdR3u9N31wjTXnk4eckSg+70zv65D+0fWYXpy3p0xbL+bpvFhOfb928uBq7X7OIaPOd2CPHaDry/zsad/Yi9NzIf/amxi2d8P56lp5Lc/fVDXUtb1+xJXcoRR2V3Qtp2nZnS2v6TPTynMh19eRJfhnLmdjuXS6li17josdX3/yrGWI6x9/5xqmOF8/Cd8/NA32651LGmHjqjztGE0++v+UGo1DK2n9O1j9GqOCNt+vRqXaRlLpV690XjbbnSMQd+B0uo7YBSXYZMXQRv3dw0vNK+PpV4876KBir31nDlIpnU1VFSeq/6j3u7t5a9PjnnY2aP+RljVVRaG9ml6PRTFXm/DsLl9mJTFMjmtQq7ndO+VbheUVe1x+nCY+12Q/7DXfr/UcTajoWdWVvm+csJlbMpN48ebz18s3uUYQ5DvhPNPYCR2F+S8/gV4hRdF747/beUY0RcFAQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA4CX+AuyILezF3pzjAAAAAElFTkSuQmCC">
					<div id="loadingImg">..</div>
				</div>
				<div class='bottom'>
					전신주 유효성<span id="here"></span><br>
					인식된 전주 번호<input type="text" id="here2"></input>
					<input type="file" 
					name="file" id="file" 
					accept='image/*' onchange='openFile(event)'><br>
					<button id="checkAnswer">정답확인</button>
					<button>포기</button>
				</div>
			</div>
		</div>

	</div>
	
	<script>
		<!-- 파일선택 -->
		var openFile = function(event) {
			var input = event.target;

			var reader = new FileReader();
			reader.onload = function() {
				var dataURL = reader.result;
				var output = document.getElementById('output');
				output.src = dataURL;
			};
			reader.readAsDataURL(input.files[0]);
			
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
					$("#here").append(isExist);
					$("#here2").val(poleNum);
				},
				error : function() {
					console.log("데이터 추출 실패")
				}
			})
			
			/* 로딩중 gif */
			test('../resources/img/Spinner.gif');	
			
		};
		
		/* 로딩중 gif */
		function test(imageURL) {
    		LoadingWithMask(imageURL);
   	 		setTimeout("closeLoadingWithMask()", 10000);
		}
 
		function LoadingWithMask(gif) {
		    //화면의 높이와 너비를 구합니다.
		    var maskHeight = $(document).height();
		    var maskWidth  = window.document.body.clientWidth;
		     
		    //화면에 출력할 마스크를 설정해줍니다.
		    var mask       ="<div id='mask' style='position:absolute; z-index:9000; background-color:#000000; display:none; left:0; top:0;'></div>";
		    var loadingImg ='';
		      
		    loadingImg +=" <img src='"+ gif +"' style='position: absolute; display: block; margin: 0px auto;'/>";
		 
		    //화면에 레이어 추가
		    $('body')
		        .append(mask)
		 
		    //마스크의 높이와 너비를 화면 것으로 만들어 전체 화면을 채웁니다.
		    $('#mask').css({
		            'width' : maskWidth,
		            'height': maskHeight,
		            'opacity' :'0.3'
		    });
		  
		    //마스크 표시
		    $('#mask').show();
		  
		    //로딩중 이미지 표시
		    $('#loadingImg').append(loadingImg);
		    $('#loadingImg').show();
		}
		 
		function closeLoadingWithMask() {
		    $('#mask, #loadingImg').hide();
		    $('#mask, #loadingImg').empty(); 
		}
		
		

	</script>
</body>
</html>