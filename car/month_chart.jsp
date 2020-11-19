<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>정승주차장</title>
<link rel="stylesheet" type="text/css" href="../resources/css/car.css">
<link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

<script type = "text/javascript"src = "https://www.gstatic.com/charts/loader.js"> </script>
<!-- <script type="text/javascript" src="../resources/js/jquery-3.5.1.min.js"></script> -->
<script type="text/javascript">
$(function() {
	$('#b1').click(function() {
		bid2 = $('#bid').val()
		$.ajax({
			url: "chartMonth.do",
			type: 'POST',
			dataType: 'json',
			success: function(result) {
				console.log(result)
				$('#d1').append("엥..")
				console.log("이것도 찍히나요?")
				
				for (var i = 0; i < result.length; i++) {
					no = result[i]
					console.log(result[i]);
					$('#d1').append(no + "<br>")
				}
				
				google.charts.load ( 'current', { 'packages': [ 'corechart']});
				google.charts.setOnLoadCallback (drawChart);

				function drawChart () {
					console.log(result.length)
					var no = Number(result[1]); // int형으로 형변환
					var data = [['Month', '매출 평균']];
					
					for (var i = 0; i < result.length; i++) {
						data.push([String((i+1)+'월'), Number(result[i])]);
					}
					
					var line_data = google.visualization.arrayToDataTable(data);

				  var options = {
				    title : '월별 매출',
				    curveType : 'function',
				    legend : {position : 'bottom'},
				    colors: ['purple']
				  };
					// 꺽은선 차트
				  var chart = new google.visualization.ColumnChart (document.getElementById ( 'curve_chart'));

				  chart.draw (line_data, options);
				}
			}, error: function(error) {
				console.log(error)
			}
		}) // ajax end
	}) // click end
	
	// 보고싶은 날 선택
	$('#dp').datepicker({dateFormat: "yy-mm-dd"})
	$('#dp').datepicker('setDate', 'today')
	
	// 확인 버튼 클릭 시
	$('#b2').click(function() {
		month = $('#month').val()
		$.ajax({
			url: "chartDay.do",
			data: {
				outTime: month
			},
			success: function(result) {
				console.log(result)
				
				for (var i = 0; i < result.length; i++) {
					no = result[i]
					console.log(result[i]);
				}
				
				google.charts.load ( 'current', { 'packages': [ 'corechart']});
				google.charts.setOnLoadCallback (drawChart);

				function drawChart () {
					console.log(result.length)
					var no = Number(result[1]); // int형으로 형변환
					var data = [['일', '매출']];
					
					for (var i = 0; i < result.length; i++) {
						data.push([String(i+1), Number(result[i])]);
					}
					
					var line_data = google.visualization.arrayToDataTable(data);

				  var options = {
				    title : month + '월 매출',
				    legend : {position : 'none'},
				    colors: ['green']
				  };
					// 막대차트로
				  var chart = new google.visualization.LineChart (document.getElementById ( 'curve_chart'));

				  chart.draw (line_data, options);
				}
				
			}, error: function(error) {
				console.log(error)
			}
		})
	})
	
	// 일일
	$('#b3').click(function() {
		day = $('#dp').val().substring(5, 10)
		$.ajax({
			url: "chartHours.do",
			data: {
				outTime: day
			},
			success: function(result) {
				console.log(result)
				
				for (var i = 0; i < result.length; i++) {
					no = result[i]
					console.log(result[i]);
					$('#d1').append(no + "<br>")
				}
				
				google.charts.load ( 'current', { 'packages': [ 'corechart']});
				google.charts.setOnLoadCallback (drawChart);

				function drawChart () {
					console.log(result.length)
					var no = Number(result[1]); // int형으로 형변환
					var data = [['day', '매출']];
					
					for (var i = 0; i < result.length; i++) {
						if (i <= 9) {
							data.push([String('0'+i+'시'), Number(result[i])]);
						} else{
							data.push([String(i+'시'), Number(result[i])]);
						}
					}
					
					var line_data = google.visualization.arrayToDataTable(data);

				  var options = {
				    title : day.substring(0, 2) + '월 ' + day.substring(3,5) + '일 매출',
				    curveType : 'function',
			      vAxis: {minValue: 0, maxValue: 50000},
				    legend : {position : 'bottom'},
				    colors: ['orange']
				  };

				  var chart = new google.visualization.ScatterChart(document.getElementById ( 'curve_chart'));

				  chart.draw (line_data, options);
				}
				
			}, error: function(error) {
				console.log(error)
			}
		})
	})
	
}) // function end

</script>
</head>
<body>
<h3>CHART</h3>
<button id="b1">2020년 매출</button>
<select id="month">
	<option value="01">1월</option>
	<option value="02">2월</option>
	<option value="03">3월</option>
	<option value="04">4월</option>
	<option value="05">5월</option>
	<option value="06">6월</option>
	<option value="07">7월</option>
	<option value="08">8월</option>
	<option value="09">9월</option>
	<option value="10">10월</option>
	<option value="11">11월</option>
	<option value="12">12월</option>
</select>
<button id="b2">확인</button>
<input type="text" id="dp"><button id="b3">확인</button>
<div id = "curve_chart" style = "width : 1200px; height : 500px"> 
</div>

</body>
</html>