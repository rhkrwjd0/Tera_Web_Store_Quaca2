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
				<%-- <img src="${pageContext.request.contextPath}/resources/quaca/img/logo_quaca.png" alt="logo"> --%>							
				<div class="card login-card rounded-plus">
					<form id="loginform" action="/quaca/loginCheck" method="post">
						<div class="form-group">
							<label class="form-label" for="username">아이디</label>
							<input type="text" id="sid" name="sid" class="form-control form-control-lg" placeholder="아이디" value="" onkeydown="keyEnter();" required>
						</div>
						<div class="form-group">
							<label class="form-label" for="password">비밀번호</label>
							<input type="password" id="password" name="password" class="form-control form-control-lg" placeholder="비밀번호" value="" onkeydown="keyEnter();" required>
						</div>
						<div class="row no-gutters sign-btns">
							<div class="col-12 sign-btn">
								<button type="button" class="btn btn-block btn-primary btn-first" onclick="loginChk();">Sign in</button>
							</div>
							<div class="col-12 sign-btn">
								<button type="button" class="btn find-pw btn-last" onclick="goPasswordFind();">FIND PASSWORD</button>
							</div>
						</div>
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
		//var express_docker = "http://192.168.0.3:10030/"; // api 주소
   		var express_docker = "http://quaca.co.kr:10030/"; // api 주소

		// 엔터 기능 
		function keyEnter(){ 
			if (event.keyCode == "13") {
				loginChk()
			}
		}
		
		// 로그인
		function loginChk() {
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