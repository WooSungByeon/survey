<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<title>Login</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="icon" type="image/png" href="images/icons/favicon.ico" />
<link rel="stylesheet" type="text/css"
	href="resources/login/fonts/font-awesome-4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" type="text/css"
	href="resources/login/fonts/Linearicons-Free-v1.0.0/icon-font.min.css">
<link rel="stylesheet" type="text/css"
	href="resources/login/vendor/animate/animate.css">
<link rel="stylesheet" type="text/css"
	href="resources/login/vendor/css-hamburgers/hamburgers.min.css">
<link rel="stylesheet" type="text/css"
	href="resources/login/vendor/animsition/css/animsition.min.css">
<link rel="stylesheet" type="text/css"
	href="resources/login/vendor/select2/select2.min.css">
<link rel="stylesheet" type="text/css"
	href="resources/login/vendor/daterangepicker/daterangepicker.css">
<link rel="stylesheet" type="text/css"
	href="resources/login/css/util.css">
<link rel="stylesheet" type="text/css"
	href="resources/login/css/main.css">
<script>
	$(document).ready(function(){ 
		var is_CookieId = getCookie("CookieId");
	   	if(is_CookieId==null){
	      	$("input:checkbox[id='ckb1']").prop("checked",false);
	   	} else{
	      	$("input:checkbox[id='ckb1']").prop("checked",true);
	      	$("#usernameC").val(is_CookieId);
	   	}  
	   
	   	$(".input100").keydown(function(key) {
           if (key.keyCode == 13) {
               login();
           }
		});
	});
	var cnt=0;
	function login(){
		if($("input:checkbox[id='ckb1']").is(":checked")){
			setCookie("CookieId",$("#usernameC").val(),3);
		}else{
			deleteCookie("CookieId");
	    }
	    
		cnt++;
		
		$.ajax({
		      url:"signIn",
		      type:"POST",  
		      data:$("#lform").serialize(),
		      success:function(data){
		    	  if(data.rs==1){
		        		location.href="mainpage";
		         }else if(data.rs==2){
		            alert("비밀번호가 일치하지 않습니다.");
		         }else{
		            alert("일치하는 아이디가 없습니다.");
		         }
		         
			      },
			      error:function(){}
			   });
		}
	var setCookie = function(name, value, exp) {
		var date = new Date();
		date.setTime(date.getTime() + exp*24*60*60*1000);
		document.cookie = name + '=' + value + ';expires=' + date.toUTCString();
		};
	var getCookie = function(name) {
		var value = document.cookie.match('(^|;) ?' + name + '=([^;]*)(;|$)');
		return value? value[2] : null;
	};
	var deleteCookie = function(name) {
		document.cookie = name + '=; expires=Thu, 01 Jan 1999 00:00:10 GMT;';
	}

	</script>
</head>
<body>
	<div class="limiter">
		<div class="container-login100">
			<div class="wrap-login100 p-t-50 p-b-90">
				<form class="login100-form validate-form flex-sb flex-w"
					method="post" action="signIn" id="lform">
					<span class="login100-form-title p-b-51"> Login </span>

					<div class="wrap-input100 validate-input m-b-16"
						data-validate="Username is required">
						<input class="input100" type="text" name="id" id="usernameC"
							placeholder="Username"> <span class="focus-input100"></span>
					</div>

					<div class="wrap-input100 validate-input m-b-16"
						data-validate="Password is required">
						<input class="input100" type="password" name="pw"
							placeholder="Password"> <span class="focus-input100"></span>
					</div>

					<div class="flex-sb-m w-full p-t-3 p-b-24">
						<div class="contact100-form-checkbox">
							<input class="input-checkbox100" id="ckb1" type="checkbox"
								name="remember-me"> <label class="label-checkbox100"
								for="ckb1"> Remember me </label>
						</div>

						<div>
							<a href=""><label for="modal_regi">sign up</label></a>
						</div>
					</div>
				</form>
				<button class="login100-form-btn" onclick=login()>Login</button>
			</div>
		</div>
	</div>

	<div id="dropDownSelect1"></div>
	<script src="resources/login/vendor/jquery/jquery-3.2.1.min.js"></script>
	<script src="resources/login/vendor/animsition/js/animsition.min.js"></script>
	<script src="resources/login/vendor/bootstrap/js/popper.js"></script>
	<script src="resources/login/vendor/bootstrap/js/bootstrap.min.js"></script>
	<script src="resources/login/vendor/select2/select2.min.js"></script>
	<script src="resources/login/vendor/daterangepicker/moment.min.js"></script>
	<script src="resources/login/vendor/daterangepicker/daterangepicker.js"></script>
	<script src="resources/login/vendor/countdowntime/countdowntime.js"></script>
	<script src="resources/login/js/main.js"></script>

</body>
</html>