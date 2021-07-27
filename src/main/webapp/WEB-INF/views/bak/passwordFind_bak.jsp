<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Quaca Admin</title>
<link rel="shortcut icon" href="#">
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
		width: 400px;
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
		width: 85px;
		float: right;
		padding: 3px; 
    }
    input {
		padding: 5px;
	}
</style>
<body>
	<div class="login_wrapper" id="passwordSelect">
		<h1>비밀번호 찾기</h1>
		<div class="login_inner">
			<div>
				<label>아이디 </label>
				<input type="text" id="sId" name="sId" placeholder="아이디"/>
			</div>
			<div>
				<label>연락처 </label>
				<input type="text" id="telNo" name="telNo" placeholder="연락처"/>
			</div>
			<button type="button" id="login_btn" >취소</button>
			<button type="button" id="search_btn" >조회</button>
		</div>
	</div>
	<div class="login_wrapper" id="passwordChange">
		<h1>비밀번호 변경</h1>
		<div class="login_inner">
			<input type="hidden" id="changeSID" name="changeSID" placeholder="아이디"/>
			<div>
				<label>새 비밀번호 </label>
				<input type="text" id="new_pw" name="new_pw" placeholder="새 비밀번호"/>
			</div>
			<div>
				<label>새 비밀번호 확인</label>
				<input type="text" id="conf_pw" name="conf_pw" placeholder="새 비밀번호 확인"/>
			</div>
			<button type="button" id="login_btn" >취소</button>
			<button type="button" id="change_btn" >저장</button>
		</div>
	</div>	
	<script>
		var express_docker = ""; // api 주소 
		var notice_docker = ""; // 알람 주소
		$(document).ready(function () {
			$("#passwordChange").hide();
			// api 주소 가져오기 
			urlAddress();
			
			// 아이디, 연락처 값으로 조회 
			$("#search_btn").on('click', function() {
				searchChk();
			});
			// 비밀번호 변경 
			$("#change_btn").on('click', function() {
				changePW();
			});
			// 로그인으로 돌아가기 
			$("#login_btn").on('click', function(){
				location.href="/quaca/login";
			})
			
			
		});
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
		
		
		// 조회
		function searchChk() {
			var url = express_docker+"users/forgetpassword";
			
			//var url = "http://192.168.0.3:10030/users/forgetpassword";
			
			if(validate()){
			    $.ajax({
			        url: url,
			        type: "POST",
			        data: {
			        	SID:$.trim($("#passwordSelect").find("input[id='sId']").val()),
			        	TelNo:$.trim($("#passwordSelect").find("input[id='telNo']").val())
			        },
			        success: function(data){
			        	if(data.success){
			        		alert("조회된 정보가 있습니다. \n비밀번호를 변경해주세요.");
			        		$("#passwordChange").find("input[id='changeSID']").val($("#passwordSelect").find("input[id='sId']").val());
				        	$("#passwordSelect").hide();
				        	$("#passwordChange").show();
			        		
			        	}else{
			        		alert("일치된 정보가 존재하지 않습니다.");
			        	}
			        },
			        error: function(){
			            alert("err");
			        }
			  	});
			}
		}
		// 비밀번호 변경  
		function changePW(){
			var url = express_docker+"users/updatepw";
			//var url = "http://192.168.0.3:10030/users/updatepw";
			
			if(validate_new_pw()){
			    $.ajax({
			        url: url,
			        type: "POST",
			        data: {
			        	SID:$.trim($("#passwordChange").find("input[id='changeSID']").val()),
			        	PassWord:$.trim($("#passwordChange").find("input[id='new_pw']").val())
			        },
			        success: function(data){
			        	if(data.success){
			        		alert("비밀번호 변경 되었습니다.");
			        		location.href="/quaca/login";
			        	}else{
			        		alert("일치된 정보가 존재하지 않습니다.");
			        	}
			        },
			        error: function(){
			            alert("err");
			        }
			  	});
			}
		}

		function validate_new_pw(){
			var validateChk = true;

			var new_pw = $("#new_pw").val();
			var conf_pw = $("#conf_pw").val();
			
			if(new_pw == ""){
				validateChk = false;
				alert("새 비밀번호를 입력해주세요.");
				$("#new_pw").focus();
			}else if(conf_pw == ""){
				validateChk = false;
				alert("새 비밀번호 확인을 입력해 주세요.");
				$("#conf_pw").focus();
			}else if(new_pw != conf_pw){
				validateChk = false;
				alert("비밀번호가 일치하지 않습니다.");
				$("#conf_pw").focus();
			}
			return validateChk
		}
		
		// 유효성 체크(조회) 
		function validate(){
			var validateChk = true;
			
			var id = $("#sId").val();
			var telNo = $("#telNo").val();	

			if(id == ""){
				validateChk = false;
				alert("아이디를 입력해 주세요.");
				$("#sId").focus();
			}else if(telNo == ""){
				validateChk = false;
				alert("연락처를 입력해 주세요.");
				$("#telNo").focus();
			}
			
			return validateChk
		}

	</script>

</body>
</html>