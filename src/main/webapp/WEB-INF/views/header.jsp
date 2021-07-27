<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
		<meta charset="UTF-8">
		<title>
            Quaca Admin
        </title>
        <meta name="description" content="Marketing Dashboard">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no, user-scalable=no, minimal-ui">
        <!-- Call App Mode on ios devices -->
        <meta name="apple-mobile-web-app-capable" content="yes" />
        <!-- Remove Tap Highlight on Windows Phone IE -->
        <meta name="msapplication-tap-highlight" content="no">
        <!-- base css -->
        <link id="vendorsbundle" rel="stylesheet" media="screen, print" href="${pageContext.request.contextPath}/resources/quaca/css/vendors.bundle.css">
        <link id="appbundle" rel="stylesheet" media="screen, print" href="${pageContext.request.contextPath}/resources/quaca/css/app.bundle.css">
        <!-- 20210609 테마처리 구간(시작) -->
        <!-- <link id="mytheme" rel="stylesheet" media="screen, print" href="#"> -->
        <%-- <link id="mytheme" rel="stylesheet" media="screen, print" href="${pageContext.request.contextPath}/resources/quaca/css/themes/cust-theme-1.css"> --%>
        <link id="mytheme" rel="stylesheet" media="screen, print" href="${pageContext.request.contextPath}/resources/quaca/css/themes/cust-theme-${userVO.storeId}.css">
        <!-- 20210609 테마처리 구간 (끝)-->
        <link id="myskin" rel="stylesheet" media="screen, print" href="${pageContext.request.contextPath}/resources/quaca/css/skins/skin-master.css">
        <!-- store css -->
        <link id="myskin" rel="stylesheet" media="screen, print" href="${pageContext.request.contextPath}/resources/quaca/css/store/basic.css">
        <c:if test="${userVO.theme != 'null'}">
			<link id="myskin" rel="stylesheet" media="screen, print" href="${pageContext.request.contextPath}/resources/quaca/css/store/store-${userVO.theme}.css">
        </c:if>
        <!-- !!!!store css -->
        
        <!-- Place favicon.ico in the root directory -->
        <link rel="apple-touch-icon" sizes="180x180" href="${pageContext.request.contextPath}/resources/quaca/img/favicon/apple-touch-icon.png">
        <link rel="icon" type="image/png" sizes="32x32" href="${pageContext.request.contextPath}/resources/quaca/img/favicon/favicon-32x32.png">
        <link rel="mask-icon" href="${pageContext.request.contextPath}/resources/quaca/img/favicon/safari-pinned-tab.svg" color="#5bbad5">
        <%-- <link rel="stylesheet" media="screen, print" href="${pageContext.request.contextPath}/resources/quaca/css/datagrid/datatables/datatables.bundle.css"> --%>
        <script type="text/javascript" src="${pageContext.request.contextPath}/resources/quaca/js/jquery/jquery-3.6.0.min.js"></script>
</head>
          
<body class="mod-bg-1 mod-nav-link ">
	

	<script>
            /**
             *	This script should be placed right after the body tag for fast execution 
             *	Note: the script is written in pure javascript and does not depend on thirdparty library
             **/
            'use strict';

            /*20210609 테마 변경 작업*/
            document.getElementsByTagName("BODY")[0].className = "mod-bg-1 mod-nav-link"; 
            /*20210609 테마 변경 작업*/
            
            /*20210609 테마 기존 처리 방식 (시작)*/
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
            /* if (themeSettings.themeURL && !document.getElementById('mytheme'))
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
            } */ 
            
            /*20210609 테마 기존 처리 방식 (끝)*/
            
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
                //css file명 체크
                console.log("4 themeSettings.themeURL : "+themeSettings.themeURL.split("/")[5]);
            }
            /** 
             * Reset settings
             **/
            var resetSettings = function()
            {
                localStorage.setItem("themeSettings", "");
            }
            
            
        	/********************************* 스크립트 커스텀 구간 ***********************************************/
            var alarmOrderLastTime = 0;		// 마지막 주문 시간
            var alarmCPOrderLastTime = 0;	// 마지막 환불 요청 시간
            var link = document.location.pathname;	// 현재 URL 값
            var countDown = 0;
       		// default url
       		//var express_docker = "http://192.168.0.3:10030/"; // api 주소(로컬)
       		//var express_docker = "http://quaca.co.kr:10030/"; // api 주소(전주소)
       		//var notice_docker = "http://quaca.co.kr:10050/";	// 알람 (관리자에서 사용자로)
       		
       		var express_docker = "http://49.50.167.171:10030/"; // api 주소(새주소)
       		//var express_docker = "http://192.168.0.7:10030/"; // api 주소(로컬)
       		var notice_docker = "http://49.50.167.171:10050/";	// 알람 (관리자에서 사용자로)
       		// 고정 url (이미지)
    		var fixImagePath = "http://quaca.co.kr:8080/";
       		
       		// api 주소 가져오기 
       		$(document).ready(function () {
       			// (최초) 알람 시간 체크
        		$.ajax({
					url : express_docker+"orders/OrderAlarm",
					type : "GET",
					data : {
						StoreId : "${userVO.storeId}"
					},
					success : function(data){
						if(data.success){
							// 주문 취소 알람 시간 
							var cancelDate = new Date();
							cancelDate = new Date(data.info.cancelTime);
							alarmCPOrderLastTime = cancelDate.getTime();
							// 주문 정보 알람 시간
							var orderDate = new Date();
							orderDate = new Date(data.info.orderTime);
							alarmOrderLastTime = orderDate.getTime();
							// 주문 갯수
							$("#span003").html(data.info.orderCnt+"+");
							
							console.log("최초 주문 접수 시간 : "+alarmOrderLastTime);
							console.log("최초 주문 취소 시간 : "+alarmCPOrderLastTime);
							
								
						}else{
							$("#span003").html("0+");
						}
					},
					error : function(){
						
					}
				});
        		
				setInterval(orderAlarm, 10000);	// 10초 호출 (접수, 주문, 환불 요청) 갯수 처리
       		});
			
			// 주문 접수 알람 처리
        	function orderAlarm(){
        		$.ajax({
					url : express_docker+"orders/OrderAlarm",
					type : "GET",
					data : {
						StoreId : "${userVO.storeId}"
					},
					success : function(data){
						if(data.success){
								
							// 주문 취소 알람 시간 
							var cancelDate = new Date();
							cancelDate = new Date(data.info.cancelTime);
							// 주문 정보 알람 시간
							var orderDate = new Date();
							orderDate = new Date(data.info.orderTime);
							// 주문 갯수
							$("#span003").html(data.info.orderCnt+"+");
							if(alarmOrderLastTime < orderDate.getTime() || alarmCPOrderLastTime < cancelDate.getTime()){
								alarmOrderLastTime = orderDate.getTime();
								alarmCPOrderLastTime = cancelDate.getTime();
								
								orderTypeModal();
								linkAction();
							}
							
							console.log("주문 접수 시간 : "+alarmOrderLastTime);
							console.log("주문 취소 시간 : "+alarmCPOrderLastTime);
						}else{
							$("#span003").html("0+");
						}
					},
					error : function(){
						
					}
				});
        	}	
        	// 주문 정보 화면 일경우 처리
        	function linkAction(){
        		if("/quaca/orders/orderInfo" == link){
					// 접수대기 탭 바 활성화 처리
					$("#ocOrderInfoNav").attr("class","nav-link active");
					$("#rcOrderInfoNav").attr("class","nav-link");
					$("#cpOrderInfoNav").attr("class","nav-link");
					
					// 접수대기 탭 화면 활성화 처리 
					$("#ocOrderInfoDiv").attr("class","tab-pane fade show active");
					$("#rcOrderInfoDiv").attr("class","tab-pane fade");	
					$("#cpOrderInfoDiv").attr("class","tab-pane fade");
					
					// orderInfo.jsp에 있는 함수 호출 (접수 대기, 주문 진행 정보 다시 불러오기 처리)
					reloadOrderList();				
        		}
        	}
        	
        	// 알람 모달 카운트 다운 처리 및 타입별 출력 값 처리(주문 & 환불)
        	function orderTypeModal(){
        		var typeText = "주문 정보가 들어왔습니다. ";
        		
       			var modalHtml = "";
       			var orderLink = '/quaca/orders/orderInfo';
        		if(orderLink == link){
        			modalHtml += '<button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>';
        		}else{
        			modalHtml += '<button type="button" class="btn btn-primary" onclick="location.href=\''+orderLink+'\'">주문화면으로 이동하기</button>'
        			modalHtml += '<button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>';
        		}
        		$("#alarmFooter").html(modalHtml);
        		
        		countDown = 5;
				var countDowVal = setInterval(function(){
					if(countDown == 5){
						$("#orderAlarmModal").modal("show");
					}
					$("#alarmTitle").html(typeText+Number(countDown)+"초");
					if(Number(countDown) == 0){
						clearInterval(countDowVal);
						$("#orderAlarmModal").modal("hide");		
					}
					countDown--;
				}, 1000);
        	}
            
	</script>
		<!-- 알람 모달창 -->
		<div class="modal modal-alert fade" id="orderAlarmModal" tabindex="-1" role="dialog" aria-hidden="true">
			<div class="modal-dialog modal-dialog-centered" role="document">
				<div class="modal-content">
					<div class="modal-header">
						<h5 class="modal-title" id="alarmTitle"></h5>
					</div>
					<div class="modal-body">
					</div>
					<div class="modal-footer" id="alarmFooter">
					</div>
				</div>
			</div>
		</div>
		<!-- 알람 모달창 -->
		
        <!-- BEGIN Page Wrapper -->
        <div class="page-wrapper">
            <div class="page-inner">
            	<!-- 사이드바 영역 -->
            	<%@ include file="include/aside.jsp" %>
            	<!-- !!사이드바 영역 -->
            	
            	<div class="page-content-wrapper">
            		<!-- 헤더 영역 -->
            		<%@ include file="include/header.jsp" %>
            		<!-- 헤더 영역 -->
            		
            		<!-- 메인 영역 -->