<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<script src="resources/jquery-3.4.1.js"></script>
<script src="//code.jquery.com/jquery-1.11.1.min.js"></script>
<link
	href="//netdna.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css"
	rel="stylesheet" id="bootstrap-css">
<script
	src="//netdna.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css" />
<link rel='stylesheet prefetch'
	href='https://maxcdn.bootstrapcdn.com/font-awesome/4.2.0/css/font-awesome.min.css'>

<!------ Include the above in your HEAD tag ---------->
<link rel="stylesheet" href="resources/board/main.css">

<script>
        $(document).ready(function(){
            $('.fab').hover(function(){
                $(this).toggleClass('active');
            });
            $(function(){
              $('[data-toggle="tooltip"]').tooltip();
            });
        });
    </script>
	<script>										
    	var cnt = 0; 	// div 나누는 변수
        var numR = 0; 	// 라디오 버튼 추가를 위한 변수
     	var numC = 0;  // 체크 박스 추가를 위한 변수
		
     	$(document).ready(function(){    
     		/*------------------------------------ Radio Start -----------------------------------------------*/
     		// 라디오 div 생성
         	$("#radio").click(function(){
            	$("#form").append("<div id=div"+cnt+" class='quiz'></div><br id=br"+cnt+">");
            	$("#div"+cnt).append("<div id=input"+cnt+"></div><br>");
           		$("#input"+cnt).append("<font>"+(cnt+1)+"번 문항</font><br>");                 
           		$("#input"+cnt).append("<input type='radio' name="+cnt+">");
   				$("#input"+cnt).append("<input type='input' name="+cnt+"><br>");
     			$("#div"+cnt).append("<input type='button' value='라디오 버튼 추가' id='addR' name="+cnt+">"); 
     			// 라디오 삭제 버튼
               	$("#div"+cnt).append("<input type='button' value='삭제' id='delR' name="+cnt+">");
            	cnt++;
          	}); 
            
            // 같은 div에 있는 라디오 버튼 추가
            $(document).on('click','#addR',function(){
            	// 라디오 추가 버튼을 누르면 group 이름 가져옴
            	var group = $(this).attr("name");
              	$("#input"+group).append("<input type='radio' id=radio"+numR+" name="+group+">");    
              	$("#input"+group).append("<input type='input' id=radio"+numR+" name="+group+">");
              	$("#input"+group).append("<span id=spanR"+numR+"><input type='button' value='삭제' id='delinner' class="+numR+" name="+numR+"><br></span>");
               	numR++;
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
            		    		$("#div"+temp+" font").text(temp+"번 문항");    
            		    		$("#div"+temp).attr('id','div'+i);
            		    		$("#input"+temp).attr('id','input'+i);
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
            
            /*------------------------------------ TextArea Start ------------------------------------------*/
     		// 주관식 div 생성
   			$("#text").click(function(){
         	 	$("#form").append("<div id=div"+cnt+" class='quiz'></div><br id=br"+cnt+">");
              	$("#div"+cnt).append("<font>"+(cnt+1)+"번 문항</font><br>");
               	$("#div"+cnt).append("<input type='input' name="+cnt+"><br>");
               	$("#div"+cnt).append("<textarea name="+cnt+"></textarea><br>");     
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
            		    		$("#div"+temp+" font").text(temp+"번 문항");    
            		    		$("#div"+temp).attr('id','div'+i);
            		    		$("#input"+temp).attr('id','input'+i);
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
   			
   			/*------------------------------------ CheckBox End -----------------------------------------------*/
          	// 체크 박스 div 생성
          	$("#check").click(function(){
       	        $("#form").append("<div id=div"+cnt+" class='quiz'></div><br id=br"+cnt+">");
   	          	$("#div"+cnt).append("<div id=input"+cnt+"></div><br>");
           		$("#input"+cnt).append("<font id=test>"+(cnt+1)+"번 문항</font><br>");
              	$("#input"+cnt).append("<input type='checkbox' name="+cnt+">");
               	$("#input"+cnt).append("<input type='input' name="+cnt+"><br>");
              	$("#div"+cnt).append("<input type='button' value='체크박스 추가' id='addC' name="+cnt+" >");
               	// 체크 박스 삭제 버튼
              	$("#div"+cnt).append("<input type='button' value='삭제' id='delC' name="+cnt+">");
               	cnt++;
         	});
                
         	// 같은 div에 있는 체크박스 추가
          	$(document).on('click','#addC',function(){
           		var group = $(this).attr("name");
              	$("#input"+group).append("<input type='checkbox' id=check"+numC+" name="+group+">");   
              	$("#input"+group).append("<input type='input' id=check"+numC+" name="+group+">");
              	$("#input"+group).append("<span id=spanC"+numC+"><input type='button' value='삭제' id='delinnerCheck' class="+numC+" name="+numC+"><br></span>");
              	numC++;
         	});
         	
          	// 체크박스 항목 삭제 버튼
            $(document).on('click','#delinnerCheck',function(){
                var group = $(this).attr("name");
                console.log(group);
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
            		    		$("#div"+temp+" font").text(temp+"번 문항");    
            		    		$("#div"+temp).attr('id','div'+i);
            		    		$("#input"+temp).attr('id','input'+i);
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
    	});  
	</script>
	<style>
		.quiz {
			border-style: solid;
		}
	</style>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<!-- 옆에 버튼 만들어주는 div start -->
	<div class="container">
		<div class="row">
			<div id="inbox">
				<div class="fab btn-group show-on-hover dropup">
					<div data-toggle="tooltip" data-placement="left" title="Compose"
						style="margin-left: 42px;">
						<button type="button"
							class="btn btn-danger btn-io dropdown-toggle"
							data-toggle="dropdown">
							<span class="fa-stack fa-2x"> <i
								class="fa fa-circle fa-stack-2x fab-backdrop"></i> 
								<i class="fa fa-plus fa-stack-1x fa-inverse fab-primary"></i> 
								<i class="fa fa-pencil fa-stack-1x fa-inverse fab-secondary" ></i>
							</span>
						</button>
					</div>
					<ul class="dropdown-menu dropdown-menu-right" role="menu">

						<li><button type="button" id="radio" data-toggle="tooltip"
								data-placement="left" title="radio">
								<i class="far fa-dot-circle"></i>
							</button></li>
						<li><button type="button" id="text" data-toggle="tooltip"
								data-placement="left" title="text">
								<i class="fa fa-comments-o"></i>
							</button></li>
						<li><button type="button" id="check" data-toggle="tooltip"
								data-placement="left" title="checkbox">
								<i class="fas fa-check-square" style="font-size: 17px"></i>
							</button></li>
					</ul>
				</div>
			</div>
		</div>
		<!-- 옆에 버튼 만들어주는 div end -->
		<form action="#">
			
			<div id="form"></div>
		</form>
	</div>
</body>
</html>