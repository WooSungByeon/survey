<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>설문조사 결과</title>
<script src="resources/jquery-3.4.1.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.9.3/Chart.min.js"></script>

<script>
	function downloadExel(){
		location.href = 'downLoadExel.do?num=${dto.num}&title=${dto.title}';
	};
	$(document).ready(function(){	
		var voteUser = '${ voteUser }';
		var voteLenth = voteUser.length-1;	
		voteUser = voteUser.substring(1,voteLenth);
		var vote = voteUser.split(", ");
		
		var xlsResult = new Array();
		var xlsCnt = new Array();
		var xlsNum = 0;
		var xlsPer = 0;
		$("#excel").click(function(){
			$.ajax({
		        type : "GET", 
		        url : "makeExcel.do?num=${dto.num}",
		        data : {
		        	"xlsResult" : xlsResult, 
		        	"xlsCnt" : xlsCnt,
		        	"xlsPer" : xlsPer
		        },
		        success : function(){
		        	downloadExel();
		        },
		        error:function(){
		             alert("문제가 발생했습니다"); 
		        }
		    });
		})
		
		// 데이터 값 가져옴
	    $.ajax({
	        type : "GET", 
	        url : "result.do?num=${dto.num}",
	        success : function(data){
	  			result(data);
	        }
	    });
	   
	    var code = '${code}';
	    var divnum = 0;
	    var titlenum=0;
	    var title = new Array();
		var s1 = code.split(",");
		for(i=0; i<s1.length; i++){
			if(s1[i].substring(0,1) == 'q'){
				var qu = s1[i].split(":");
				title[titlenum++] = qu[1];
				$("#answer").append("<div id=div"+divnum+">");
				$("#div"+divnum).append("<h3>"+"["+(divnum+1)+"]&nbsp;"+qu[1]);
				$("#div"+divnum).append("<canvas id=canvas"+divnum+" width=500px height=300px>");
				divnum++;
			} 
		}

		function xlsResultParsing(){
			xlsResult[xlsNum] = "!";
			xlsCnt[xlsNum++] = "!";
		}
		
		// 데이터 split
		function splitData(data){
			var split = data.split(":");
			var answer = split[1].split(",");
			var arr1 = new Array();	// 값을 넣어줄 배열
			var arr2 = new Array();	// 카운트를 넣어줄 배열
			var arr3 = new Array(); // 원본 배열
			var arrCnt = 0;	// 배열 인덱스
			var cnt = 1;	// 중복 갯수
			answer = answer.sort();	// 정렬
			answer.shift();	// 공백 제거
			for (var j = 0; j < answer.length; j++) {	// 정렬하여 다른 값이 나오면 arr에 추가		
				arr3[j] = answer[j];
				if(answer[j] == answer[j+1]) cnt++;
				else {
					xlsResult[xlsNum] = answer[j];
					xlsCnt[xlsNum++] = cnt;
					arr1[arrCnt] = answer[j]
					arr2[arrCnt++] = cnt;
					cnt = 1;
				}
			}
			var max = Math.max.apply(null, arr2);	// 배열 중 가장 큰 값 찾기
			return [arr1, arr2, max ,arr3 ];
		}	
		
	    function result(data){
	    	var data = data;
	    	var divnum = 0;
	    	var arr = new Array();    	
	    	for (var i = 0; i < data.length; i++) {
				if(data[i].substring(0,1) == 'R') {
					xlsResultParsing();
					var result = splitData(data[i]);
					createChart(title[i],result[0],result[1],result[2],divnum);
					divnum++;
				} else if(data[i].substring(0,1) == 'C') {
					xlsResultParsing();
					var result = splitData(data[i]);
					createChart(title[i],result[0],result[1],result[2],divnum);
					divnum++;		
				} else if(data[i].substring(0,1) == 'T') {
					xlsResultParsing();
					var result = splitData(data[i]);
					var answer = result[3];
					$("#canvas"+divnum).replaceWith("");
					for (var j = 0; j < result[3].length; j++) {
						$("#div"+divnum).append("<p>"+answer[j]);
					}
					divnum++;	
				} else if(i == (data.length-1)){
					xlsPer = vote.length;
					$("#info").append("<h3 id=count>[참여인원 :"+xlsPer+"명]");
				}
			}
	    }
		
	    // 그래프 생성 메서드
		function createChart(title,arr1,arr2,max,divnum){
			var ctx = document.getElementById('canvas'+divnum).getContext('2d');
			var chart = new Chart(ctx, {
			    type: 'bar',
			    data: {
			        labels: arr1,
			        datasets: [{
			            label: title,
			            data: arr2,
			            backgroundColor: [
			                'rgba(255, 99, 132, 0.2)',
			                'rgba(54, 162, 235, 0.2)',
			                'rgba(255, 206, 86, 0.2)',
			                'rgba(75, 192, 192, 0.2)',
			                'rgba(153, 102, 255, 0.2)',
			                'rgba(255, 159, 64, 0.2)'
			            ],
			            borderColor: [
			                'rgba(255,99,132,1)',
			                'rgba(54, 162, 235, 1)',
			                'rgba(255, 206, 86, 1)',
			                'rgba(75, 192, 192, 1)',
			                'rgba(153, 102, 255, 1)',
			                'rgba(255, 159, 64, 1)'
			            ],
			            borderWidth: 1
			        }]
			    },
			    options: {
			    	// default value. false일 경우 포함된 div의 크기에 맞춰서 그려짐.
			    	responsive: false,
			        maintainAspectRatio: true, 
			        scales: {
			            yAxes: [{
			                ticks: {   
			                	stepSize: 1,
			                	max: max+3,
			                    beginAtZero:true
			                }
			            }]
			        }
			    }
			});
		}
	});
</script>

<style>

	body {
    background-color: gainsboro;
	}
	
	#title{
	    color: white;
	    background-color: gray;
	    padding: 1%;
	}

	#answer{
		background: whitesmoke;
	    width: 75%;
	    box-shadow: 0 10px 25px 0 rgba(0, 0, 0, 0.3), 0 10px 10px 0 rgba(0, 0, 0, 0.15);
	    padding: 5%;
	    padding-top: 2%;
	    border-radius: 10px;
	    margin: 5% 0% 3% 8%;
	}
	#info {
		text-align: center;
	}
	
	#count {
	    margin-left: 80%;
	    text-align: right;
	    padding: 0% 1% 6% 0%;
	}
	
	#excel { 
		border: none;
	    color: #fff;
	    text-align: right;
	    text-decoration: none;
	    display: inline-block;
	    font-size: 30px;
	    cursor: pointer;
	    background-color: #01aef0;
	    border-radius: 4px;
	    font-family: 'Noto Sans KR', sans-serif;
	    font-weight: 500;
 		padding: 0.5% 34% 0.5% 34%;
 		margin: 0% 0% 0% 9%;
	}
	
	#excel:hover {
	background-color: #00ebfc;
	}
</style>
</head>
<body>
	<div>
		<jsp:include page="../include/header.jsp"/>
	</div>
	<div id="answer">
		<div id="info">
			<h1 id="title">${dto.title}</h1>
		</div>
	</div>
	<button id='excel'>엑셀 파일로 다운로드</button>
	<div>
		<jsp:include page="../include/footer.jsp"/>
	</div>
</body>
</html>