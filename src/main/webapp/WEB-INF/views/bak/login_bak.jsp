<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Quaca Admin</title>
<meta name="description" content="Login">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no, user-scalable=no, minimal-ui">
<!-- <link rel="shortcut icon" href="#"> -->
<link id="vendorsbundle" rel="stylesheet" media="screen, print" href="${pageContext.request.contextPath}/resources/quaca/css/vendors.bundle.css">
<link id="appbundle" rel="stylesheet" media="screen, print" href="${pageContext.request.contextPath}/resources/quaca/css/app.bundle.css">
<link id="mytheme" rel="stylesheet" media="screen, print" href="#">
<link id="myskin" rel="stylesheet" media="screen, print" href="${pageContext.request.contextPath}/resources/quaca/css/skins/skin-master.css">
<!-- Place favicon.ico in the root directory -->
<link rel="apple-touch-icon" sizes="180x180" href="${pageContext.request.contextPath}/resources/quaca/img/favicon/apple-touch-icon.png">
<link rel="icon" type="image/png" sizes="32x32" href="${pageContext.request.contextPath}/resources/quaca/img/favicon/favicon-32x32.png">
<link rel="mask-icon" href="img/favicon/safari-pinned-tab.svg" color="#5bbad5">
<link rel="stylesheet" media="screen, print" href="${pageContext.request.contextPath}/resources/quaca/css/fa-brands.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/quaca/js/jquery/jquery-3.6.0.min.js"></script>
</head>
<style>
	.login_wrapper {
		border: 20px solid black;
		padding: 5px 20px;
		position: absolute;
		top: 50%;
		left: 50%;
		width: 450px; height: 250px;
		margin-left: -220px;
		margin-top: -170px;
		
		display: flex;
		flex-direction: column;
		justify-content: center;
		align-items: center;
	}
	h1 {
		font-size: 25px;
		padding-bottom: 20px;
	}
	.login_inner {
		width: 300px;
	}
	.login_inner > div {
		display: flex;
		justify-content: center;
		padding-bottom: 7px;
		align-items: center;
	}
	label {
		flex: 1;
		text-align: left;
    }
    button {
		width: 100px;
		float: right;
		padding: 3px; 
    }
    input {
		padding: 5px;
	}
</style>
<body>
	<form id="loginform" action="/quaca/loginCheck" method="post">			
		<div class="login_wrapper">	
			<h1>로그인</h1>
			<div class="login_inner">
					<div>
						<label>아이디 </label>
						<input type="text" id="sid" name="sid" placeholder="아이디"/>
					</div>
					<div>
						<label>비밀번호 </label>
						<input type="text" id="password" name="password" placeholder="비밀번호"/>
					</div>
				<button type="button" onclick="loginChk();" >로그인</button>
				<button type="button" onclick="goPasswordFind();" >비밀번호 찾기</button>
				<button type="button" onclick="goHome();" >홈으로</button>
			</div>
		</div>
	</form>
	
	<script>
		var express_docker = ""; // api 주소 
		var notice_docker = ""; // 알람 주소
		
		// url 정보 가져오기 
		function urlAddress() {
			
			$.ajax({
		        url: "https://tera-energy.github.io/Tera_Quaca_Common/server.json",
		        type: "GET",
		        success: function(data){
		        	express_docker = data.store_WEB.serverUrl;
		        	notice_docker = data.customerNotice.serverUrl;
		        },
		        error: function(){
		            alert("err");
		        }
		  	});
		} 
		$(document).ready(function () {
			// api 주소 가져오기 
			urlAddress();
		});
		
		// 로그인
		function loginChk() {
						
 			/*if(validate()){
			    $.ajax({
			        url: express_docker+"users/login",
			        type: "POST",
			        data: {
			        	SID:$("#sId").val(),
			        	PassWord:$("#passWord").val()
			        },
			        success: function(data){
			        	if(data.success){
			        		alert("로그인 되었습니다.");
							sessionStorage.setItem("userInfo", JSON.stringify(data.info));
							location.href="/main";
			        	}else{
			        		alert("로그인 실패 하였습니다.");
			        	}
			        },
			        error: function(){
			            alert("err");
			        }
			  	});
			} */
			
			$("#loginform").submit();
		}

		
		// 비밀번호 찾기 
		function goPasswordFind(){
			location.href="/quaca/passwordFind";
		}
		// 그냥 메인 넘어가기 
		function goHome(){
			location.href="/quaca/main";
		}
		
		// 유효성 체크 
		function validate(){
			var validateChk = true;
			
			var id = $("#sId").val();
			var pw = $("#passWord").val();	
			if(id == ""){
				validateChk = false;
				alert("아이디를 입력해 주세요.");
				$("#sId").focus();
			}else if(pw == ""){
				validateChk = false;
				alert("비밀번호를 입력해 주세요.");
				$("#passWord").focus();
			}
			return validateChk
		}
	</script>

</body>
</html>