<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
		<title>
            Quaca Admin
        </title>
        <meta name="description" content="Login">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no, user-scalable=no, minimal-ui">
        <!-- Call App Mode on ios devices -->
        <meta name="apple-mobile-web-app-capable" content="yes" />
        <!-- Remove Tap Highlight on Windows Phone IE -->
        <meta name="msapplication-tap-highlight" content="no">
        <!-- base css -->
        <link rel="shortcut icon" href="#">
        <link id="vendorsbundle" rel="stylesheet" media="screen, print" href="${pageContext.request.contextPath}/resources/quaca/css/vendors.bundle.css">
        <link id="appbundle" rel="stylesheet" media="screen, print" href="${pageContext.request.contextPath}/resources/quaca/css/app.bundle.css">
        <link id="mytheme" rel="stylesheet" media="screen, print" href="#">
        <link id="myskin" rel="stylesheet" media="screen, print" href="${pageContext.request.contextPath}/resources/quaca/css/skins/skin-master.css">
        <!-- store css -->
        <link id="myskin" rel="stylesheet" media="screen, print" href="${pageContext.request.contextPath}/resources/quaca/css/store/basic.css">
        <link id="myskin" rel="stylesheet" media="screen, print" href="${pageContext.request.contextPath}/resources/quaca/css/store/store-halo.css">
        <!-- Place favicon.ico in the root directory -->
        <link rel="apple-touch-icon" sizes="180x180" href="${pageContext.request.contextPath}/resources/quaca/img/favicon/apple-touch-icon.png">
        <link rel="icon" type="image/png" sizes="32x32" href="${pageContext.request.contextPath}/resources/quaca/img/favicon/favicon-32x32.png">
        <link rel="mask-icon" href="${pageContext.request.contextPath}/resources/quaca/img/favicon/safari-pinned-tab.svg" color="#5bbad5">
        <link rel="stylesheet" media="screen, print" href="${pageContext.request.contextPath}/resources/quaca/css/fa-brands.css">
        <script type="text/javascript" src="${pageContext.request.contextPath}/resources/quaca/js/jquery/jquery-3.6.0.min.js"></script>
</head>
          
<body >
	

	<script>
            /**
             *	This script should be placed right after the body tag for fast execution 
             *	Note: the script is written in pure javascript and does not depend on thirdparty library
             **/
            'use strict';

            var classHolder = document.getElementsByTagName("BODY")[0],
                /** 
                 * Load from localstorage
                 **/
                themeSettings = (localStorage.getItem('themeSettings')) ? JSON.parse(localStorage.getItem('themeSettings')) :
                {},
                themeURL = themeSettings.themeURL || '',
                themeOptions = themeSettings.themeOptions || '';
            /** 
             * Load theme options
             **/
            if (themeSettings.themeOptions)
            {
                classHolder.className = themeSettings.themeOptions;
                console.log("%c✔ Theme settings loaded", "color: #148f32");
            }
            else
            {
                console.log("%c✔ Heads up! Theme settings is empty or does not exist, loading default settings...", "color: #ed1c24");
            }
            if (themeSettings.themeURL && !document.getElementById('mytheme'))
            {
                var cssfile = document.createElement('link');
                cssfile.id = 'mytheme';
                cssfile.rel = 'stylesheet';
                cssfile.href = themeURL;
                document.getElementsByTagName('head')[0].appendChild(cssfile);

            }
            else if (themeSettings.themeURL && document.getElementById('mytheme'))
            {
                document.getElementById('mytheme').href = themeSettings.themeURL;
            }
            /** 
             * Save to localstorage 
             **/
            var saveSettings = function()
            {
                themeSettings.themeOptions = String(classHolder.className).split(/[^\w-]+/).filter(function(item)
                {
                    return /^(nav|header|footer|mod|display)-/i.test(item);
                }).join(' ');
                if (document.getElementById('mytheme'))
                {
                    themeSettings.themeURL = document.getElementById('mytheme').getAttribute("href");
                };
                localStorage.setItem('themeSettings', JSON.stringify(themeSettings));
            }
            /** 
             * Reset settings
             **/
            var resetSettings = function()
            {
                localStorage.setItem("themeSettings", "");
            }
        	
	</script>
	<div class="auth">
		<div class="login-top-bg"></div>
		<div class="login-cont">
			<div class="login-box">
				<div class="login-title">
					<h2>HALO ROASTERS</h2>
					<span>Admin Manager</span>
				</div>
				<div class="card login-card rounded-plus">
					<form id="passwordSelect">
						<div class="form-group">
							<label class="form-label" for="username">아이디</label>
							<input type="text" id="sId" name="sId" class="form-control form-control-lg" placeholder="아이디" value="" required>
						</div>
						<div class="form-group">
							<label class="form-label" for="password">연락처</label>
							<input type="text" id="telNo" name="telNo" class="form-control form-control-lg" placeholder="연락처" value="" required>
						</div>
						<div class="row no-gutters sign-btns find-btns">
							<div class="col-6 sign-btn">
								<button type="button" class="btn btn-block btn-primary btn-first" id="search_btn">조회</button>
							</div>
							<div class="col-6 sign-btn find-cancel">
								<button type="button" class="btn btn-block btn-outline-primary btn-last" onclick="goLogin();">취소</button>
							</div>
						</div>
					</form>
					<form id="passwordChange">
					</form>
				</div>
			</div>
		</div>
	</div>
	<div class="login-footer">
		<p>HALO Roasters @ all right reserved.</p>
	</div>
	<!-- 컬러프로필? 영역 -->
	<%@ include file="../../include/profile.jsp" %>
	<!-- !!컬러프로필? 영역 -->		
    <script src="${pageContext.request.contextPath}/resources/quaca/js/vendors.bundle.js"></script>
    <script src="${pageContext.request.contextPath}/resources/quaca/js/app.bundle.js"></script>
    
	<script>
		var express_docker = "http://192.168.0.7:10030/"; // api 주소
		//var express_docker = "http://49.50.167.171:10030/"; // api 주소(새주소)
		$(document).ready(function () {
			// 아이디, 연락처 값으로 조회 
			$("#search_btn").on('click', function() {
				searchChk();
			});
			// 비밀번호 변경 
			$("#passwordChange").on('click', "#change_btn", function() {
				changePW();
			});
			// 로그인으로 돌아가기 
			$("button[name='cancel_btn']").on('click', function(){
				location.href="/quaca/login";
			})
		});
		
		// 조회
		function searchChk() {
			if(validate()){
			    $.ajax({
			        url: express_docker+"users/forgetpassword",
			        type: "POST",
			        data: {
			        	SID:$.trim($("#passwordSelect").find("input[id='sId']").val()),
			        	TelNo:$.trim($("#passwordSelect").find("input[id='telNo']").val())
			        },
			        success: function(data){
			        	if(data.success){
			        		alert("조회된 정보가 있습니다. \n비밀번호를 변경해주세요.");
				        	$("#passwordSelect").hide();
				        	$("#passwordChange").html(passwordChangeHtml());
			        		$("#passwordChange").find("input[id='changeSID']").val($("#passwordSelect").find("input[id='sId']").val());
			        		
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
		
		// 비밀번호 변경 HTML 작성
		function passwordChangeHtml(){
			var html = "";
			
			html += '<div class="form-group">';
			html += 	'<label class="form-label" for="username">아이디</label>';
			html += 	'<input type="text" id="changeSID" name="changeSID" class="form-control form-control-lg" placeholder="아이디" value="" required  disabled="disabled">';
			html += '</div>';
			html += '<div class="form-group">';
			html += 	'<label class="form-label" for="password">비밀번호</label>';
			html += 	'<input type="text" id="new_pw" name="new_pw" class="form-control form-control-lg" placeholder="새 비밀번호" value="" required>';
			html += '</div>';
			html += '<div class="form-group">';
			html += 	'<label class="form-label" for="password">새 비밀번호 확인</label>';
			html += 	'<input type="text" id="conf_pw" name="conf_pw" class="form-control form-control-lg" placeholder="새 비밀번호 확인" value="" required>';
			html += '</div>';
			html += '<div class="row no-gutters sign-btns find-btns">';
			html += 	'<div class="col-6 sign-btn">';
			html += 		'<button type="button" class="btn btn-block btn-primary btn-first" id="change_btn">비밀번호 변경</button>';
			html += 	'</div>';
			html += 	'<div class="col-6 sign-btn find-cancel">';
			html += 		'<button type="button" class="btn btn-block btn-outline-primary btn-last" onclick="goLogin();">취소</button>';
			html += 	'</div>';
			html += '</div>';
			
			return html; 
		}
		
		// 비밀번호 변경  
		function changePW(){
			if(validate_new_pw()){
			    $.ajax({
			        url: express_docker+"users/updatepw",
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
		// 로그인 페이지 이동
		function goLogin(){
			location.href="/quaca/login";
		}
	</script>

</body>
</html>