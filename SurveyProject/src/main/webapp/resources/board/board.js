/*------------------------------------ 네비게이션 버튼 js -----------------------------------------------*/
$(document).ready(function(){
	$('.fab').hover(function(){
		$(this).toggleClass('active');
	});
	$(function(){
		$('[data-toggle="tooltip"]').tooltip();
	});
});

var cnt = 0; 	// div 나누는 변수
var numR = 0; 	// 라디오 버튼 추가를 위한 변수
var numC = 0;  // 체크 박스 추가를 위한 변수
var numI = 1;
$(document).ready(function(){    
	/*------------------------------------ Radio Start -----------------------------------------------*/
	// 라디오 div 생성
	$("#radio").click(function(){
		$("#form").append("<div id=div"+cnt+" class='quiz'></div><br id=br"+cnt+">");
		$("#div"+cnt).append("<div id=input"+cnt+"></div><br>");
		$("#input"+cnt).append("<h1 id=test>["+(cnt+1)+"]</h1><br>");
		$("#input"+cnt).append("<font class='	Q'>Q</font> <input type='text' id='q"+cnt+"' name='q"+cnt+"' class='question_input' placeholder='질문'> <br>");        		
		$("#input"+cnt).append("<input type='radio' disabled='true' name="+cnt+"> ");
		$("#input"+cnt).append("<input type='text' name=R"+cnt+"0><br>");
		$("#div"+cnt).append("<input type='button' value='라디오 버튼 추가' id='addR' name="+cnt+">"); 
		// 라디오 삭제 버튼
		$("#div"+cnt).append("<input type='button' value='삭제' id='delR' name="+cnt+">");
		cnt++;
	}); 

	// 같은 div에 있는 라디오 버튼 추가
	$(document).on('click','#addR',function(){
		// 라디오 추가 버튼을 누르면 group 이름 가져옴
		var group = $(this).attr("name");

		$("#input"+group).append("<input type='radio' disabled='true' id=radio"+numR+" name="+group+">");    
		$("#input"+group).append("<input type='text' id=radio"+numR+" name=R"+group+""+numI+">");
		$("#input"+group).append("<span id=spanR"+numR+"><input type='button' value='삭제' id='delinner' class="+numR+" name="+numR+"><br></span>");
		numR++;
		numI++;
	});

	// 같은 div에 있는 라디오 버튼 삭제
	$(document).on('click','#delinner',function(){
		var group = $(this).attr("name"); 
		$("input").remove("#radio"+group);
		$("input").remove("#delinner."+group);
		$("span").remove("#spanR"+group);
	});

	// 라디오 삭제 버튼
	$(document).on('click','#delR',function(){
		var group = $(this).attr("name");
		$('br').remove('#br'+group);
		$("div").remove("#div"+group+".quiz");
		var group1 = parseInt(group);
		var rs = cnt - group;
		$.ajax({   	 
			url:"board",
			type:"POST",  
			success:function(data){ 	
				if(rs >= 1){ 
					for(var i = group1; i < cnt; i++ ){ 		
						var temp = i+1;     
						$("#div"+temp+" h1").text("["+temp+"]");    
						$("#div"+temp).attr('id','div'+i);
						$("#input"+temp).attr('id','input'+i);
						$('#q'+temp).attr('name','q'+i);
						$('#q'+temp).attr('id','q'+i);
						$("#div"+i+" #addR").attr('name',i);            		    	 
						$("#div"+i+" #delR").attr('name',i);     
						$("#div"+i+" #addC").attr('name',i);            		    	 
						$("#div"+i+" #delC").attr('name',i);   
						$("#div"+i+" #delT").attr('name',i);   
						$("#br"+i).attr('id','br'+(i-1));
					}
				}
				cnt--;	
			},
			error:function(){
				alert("문제가 발생했습니다"); 
			}
		});
	});        
	/*------------------------------------ Radio End -----------------------------------------------*/
	/*------------------------------------ CheckBox Start -----------------------------------------------*/
	// 체크 박스 div 생성
	$("#check").click(function(){
		$("#form").append("<div id=div"+cnt+" class='quiz'></div><br id=br"+cnt+">");
		$("#div"+cnt).append("<div id=input"+cnt+"></div><br>");
		$("#input"+cnt).append("<h1 id=test>["+(cnt+1)+"]</h1><br>");
		$("#input"+cnt).append("<font class='Q'>Q</font> <input type='text' id='q"+cnt+"' name='q"+cnt+"' class='question_input' placeholder='질문'> <br>");  
		$("#input"+cnt).append("<input type='checkbox' disabled='true' name="+cnt+">");
		$("#input"+cnt).append("<input type='text' name=C"+cnt+"0><br>");
		$("#div"+cnt).append("<input type='button' value='체크박스 추가' id='addC' name="+cnt+" >");
		// 체크 박스 삭제 버튼
		$("#div"+cnt).append("<input type='button' value='삭제' id='delC' name="+cnt+">");
		cnt++;
	});

	// 같은 div에 있는 체크박스 추가
	$(document).on('click','#addC',function(){
		var group = $(this).attr("name");
		$("#input"+group).append("<input type='checkbox' disabled='true' id=check"+numC+" name="+group+">");   
		$("#input"+group).append("<input type='text' id=check"+numC+" name=C"+group+""+numI+">");
		$("#input"+group).append("<span id=spanC"+numC+"><input type='button' value='삭제' id='delinnerCheck' class="+numC+" name="+numC+"><br></span>");
		numC++;
		numI++;
	});

	// 체크박스 항목 삭제 버튼
	$(document).on('click','#delinnerCheck',function(){
		var group = $(this).attr("name");
		$("input").remove("#check"+group);
		$("input").remove("#delinnerCheck."+group);
		$("span").remove("#spanC"+group);

	});

	// 체크박스 전체 삭제 버튼
	$(document).on('click','#delC',function(){
		var group = $(this).attr("name");
		var div = $(this).attr("id");
		var group1 = parseInt(group);
		var rs = cnt - group;
		$('br').remove('#br'+group);
		$("div").remove("#div"+group+".quiz");  
		$.ajax({
			url:"board",
			type:"POST", 
			success:function(data){ 
				if(rs >= 1){
					for(var i = group1;i<cnt;i++ ){
						var temp=i+1;    
						$("#div"+temp+" h1").text("["+temp+"]");    
						$("#div"+temp).attr('id','div'+i);
						$("#input"+temp).attr('id','input'+i);
						$('#q'+temp).attr('name','q'+i);
						$('#q'+temp).attr('id','q'+i);
						$("#div"+i+" #addC").attr('name',i);            		    	 
						$("#div"+i+" #delC").attr('name',i);            		    	 
						$("#div"+i+" #addR").attr('name',i);            		    	 
						$("#div"+i+" #delR").attr('name',i);      
						$("#div"+i+" #delT").attr('name',i);   
						$("#br"+i).attr('id','br'+(i-1));
					}
				}
				cnt--;
			},
			error:function(){
				alert("문제가 발생했습니다"); 
			}
		});      
	});
	/*------------------------------------ CheckBox End -----------------------------------------------*/ 
	/*------------------------------------ TextArea Start ------------------------------------------*/
	// 주관식 div 생성
	$("#text").click(function(){
		$("#form").append("<div id=div"+cnt+" class='quiz'></div><br id=br"+cnt+">");
		$("#div"+cnt).append("<h1 id=test>["+(cnt+1)+"]</h1><br>");
		$("#div"+cnt).append("<font class='Q'>Q</font> <input type='text' id='q"+cnt+"' name='q"+cnt+"' class='question_input' placeholder='질문' name="+cnt+"> <br>");  
		$("#div"+cnt).append("<textarea rows='10' disabled='true' name="+cnt+"></textarea><br>");  
		$("#div"+cnt).append("<input type='hidden' name='T"+cnt+"' value='text'>");      	
		// 주관식 삭제 버튼 
		$("#div"+cnt).append("<input type='button' value='삭제' id='delT' name="+cnt+">");
		cnt++;
	});

	// 주관식 전체 삭제 버튼
	$(document).on('click','#delT',function(){
		var group = $(this).attr("name");
		$('br').remove('#br'+group);
		$("div").remove("#div"+group+".quiz"); 
		var group1 = parseInt(group);
		var rs = cnt - group;
		$.ajax({		 
			url:"board",
			type:"POST",  
			success:function(data){ 	
				if(rs >= 1){ 
					for(var i = group1; i < cnt; i++){ 	
						var temp = i+1;     
						$("#div"+temp+" h1").text("["+temp+"]");    
						$("#div"+temp).attr('id','div'+i);
						$("#input"+temp).attr('id','input'+i);
						$('#q'+temp).attr('name','q'+i);
						$('#q'+temp).attr('id','q'+i);
						$("#div"+i+" #addR").attr('name',i);            		    	 
						$("#div"+i+" #delR").attr('name',i);     
						$("#div"+i+" #addC").attr('name',i);            		    	 
						$("#div"+i+" #delC").attr('name',i);   
						$("#div"+i+" #delT").attr('name',i);
						$("#br"+i).attr('id','br'+(i-1));
					}
				}
				cnt--;	
			},
			error:function(){
				alert("문제가 발생했습니다"); 
			}
		});
	});   
	/*------------------------------------ TextArea End -----------------------------------------------*/ 

	
	/*------------------------------------ 스크롤 따라오기 -----------------------------------------------*/ 
	var currentPosition = parseInt($("#remote").css("top")); 
	$(window).scroll(function() { 
		var position = $(window).scrollTop(); 
		$("#remote").stop().animate({
			"top":position+currentPosition+"px"},200); 
	});
	/*------------------------------------ html 코드 주소에 뭍히기 -----------------------------------------------*/ 
	$('#save').click(function(){
		var deadline = $('#deadline').val();
		var title = $('.title_input').val();
		var hashtag = $('#hash').val();
		if(deadline == ""){
			alert("마감 날짜를 정해주세요");
		} else if(title == "") {
			alert("제목을 정해주세요");	
		} else if(hashtag == "") {
			alert("해쉬태그를 하나 이상 넣어주세요");	
		} else {
			
			if(userPointCheck != 0){
				var result = confirm('"'+ selectPoint + "'" +'포인트가 차감됩니다. 등록하시겠습니까?');
				if(result){
				    $("#surveyForm").submit();
				}else{
				}	
			}else{
				alert("포인트가 모자릅니다! 설문조사를 참여하여 포인트를 획득하세요 :D");
			}
	
		}
	});

	/*------------------------------------ 해쉬태그 입력 -----------------------------------------------*/ 
	var replaceChar = /[~!@\$%^&*\()\-=+_'\;<>\/.\`:\"\\,\[\]?|{}]/gi; 
	var replaceNotFullKorean = /[ㄱ-ㅎㅏ-ㅣ]/gi;
	$("#hash").on("focusout", function() {
		var x = $(this).val();
		if (x.length > 0) {
			if (x.match(replaceChar) || x.match(replaceNotFullKorean)) {
				x = x.replace(replaceChar, "").replace(replaceNotFullKorean, "");
			}
			$(this).val(x);

			if(!(x.match("#"))){
				alert("# 해시태그를 달아주세요");
				setTimeout(function(){
					$('#hash').focus();
				});
			}
		}
	}).on("keyup", function() {
		$(this).val($(this).val().replace(replaceChar, ""));
	});		
	
	/*나의 이미지 변경하기*/
	$("#border_icon_Change").hide();
	$("#icon_Change").click(function() {
		$("#border_icon_Change").toggle('1000');
	});
	
	
	$("#board_icon01").click(function() {
		$("#boder_icon").attr('src','resources/board/images/mini_icon1.png');
		$("#board_icon_input").val('resources/board/images/mini_icon1.png');
	});
	$("#board_icon02").click(function() {
		$("#boder_icon").attr('src','resources/board/images/mini_icon2.png');
		$("#board_icon_input").val('resources/board/images/mini_icon2.png');
	});
	$("#board_icon03").click(function() {
		$("#boder_icon").attr('src','resources/board/images/mini_icon3.png');
		$("#board_icon_input").val('resources/board/images/mini_icon3.png');
	});
	$("#board_icon04").click(function() {
		$("#boder_icon").attr('src','resources/board/images/mini_icon4.png');
		$("#board_icon_input").val('resources/board/images/mini_icon4.png');
	});
	$("#board_icon05").click(function() {
		$("#boder_icon").attr('src','resources/board/images/mini_icon5.png');
		$("#board_icon_input").val('resources/board/images/mini_icon5.png');
	});
	$("#board_icon06").click(function() {
		$("#boder_icon").attr('src','resources/board/images/mini_icon6.png');
		$("#board_icon_input").val('resources/board/images/mini_icon6.png');
	});
	

	/*------------------------------------ 포인트 관련 -----------------------------------------------*/
	var userPoint = $("#userPoint").attr('value');
	var userPointCheck = 1;
	var selectPoint = 1100;
	
	 if(selectPoint <= userPoint){
		 $("#h4").text('"'+selectPoint+'"'+'포인트가 차감됩니다!!');
	 }else{
		 $("#h4").text('"'+(selectPoint-userPoint)+'"'+'포인트가 모자릅니다!');
		 userPointCheck = 0;
	 }
	 
	$("#point").change(function() {
	     $("#point option:selected").each(function() {
	    	 selectPoint =($(this).val()*100)+1000;
	    	 
	    	 if(selectPoint <= userPoint){
	    		 $("#h4").text('"'+selectPoint+'"'+'포인트가 차감됩니다!!');
	    	 }else{
	    		 $("#h4").text('"'+(selectPoint-userPoint)+'"'+'포인트가 모자릅니다!');
	    		 userPointCheck = 0;
	    	 }
	     });
	});

	
	
});  