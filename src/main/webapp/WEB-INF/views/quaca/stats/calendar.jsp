<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../../header.jsp" %>
<link rel="stylesheet" media="screen, print" href="${pageContext.request.contextPath}/resources/quaca/css/miscellaneous/fullcalendar/fullcalendar.bundle.css">
<!-- 메인 영역 -->
<main id="js-page-content" role="main" class="page-content">
	<ol class="breadcrumb page-breadcrumb">
        <li class="breadcrumb-item"><a href="javascript:void(0);">Quaca</a></li>
        <li class="breadcrumb-item">in 매장 분석</li>
        <li class="breadcrumb-item active">매출 달력</li>
        <li class="position-absolute pos-top pos-right d-none d-sm-block"><span class="js-get-date"></span></li>
    </ol>
    
	<div class="row">
		<div class="col-xl-8">
			<div id="panel-1" class="panel">
				<div class="panel-container show">
					<div class="panel-content">
						<div id="calendar"></div>
					</div>
				</div>
			</div>
		</div>
		<div class="col-xl-4">
			<div id="panel-2" class="panel">
				<div class="panel-container show">
					<div class="panel-content">
						<div>
							<c:set var="now" value="<%=new java.util.Date()%>" />
							<c:set var="today"><fmt:formatDate value="${now}" pattern="YYYY-MM-dd" /></c:set> 
							<h2 class="row">
								<span class="col-xl-6 text-left"><b>현 매출 현황</b></span>
								<span class="col-xl-6 text-right">${today}</span>
							</h2>
							<div>
								<div class="form-group row">
									<label class="col-form-label col-12 col-lg-4 form-label text-center">매출 금액 : </label>
									<div class="col-12 col-lg-8 text-right" id="todayTotalPrice">0원</div>
								</div>
								<div class="form-group row">
									<label class="col-form-label col-12 col-lg-4 form-label text-center">취소 금액 : </label>
									<div class="col-12 col-lg-8 text-right" id="todayCancelPrice">0원</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div id="panel-3" class="panel">
				<div class="panel-container show">
					<div class="panel-content">
						<div>
							<c:set var="month"><fmt:formatDate value="${now}" pattern="MM" /></c:set> 
							<h2><b><span id="selectMonth">${month}</span>월 총 매출 현황</b></h2>
							<div>
								<div class="form-group row">
									<label class="col-form-label col-12 col-lg-4 form-label text-center">매출 금액 : </label>
									<div class="col-12 col-lg-8 text-right" id="monthTotalPrice">0원</div>
								</div>
								<div class="form-group row">
									<label class="col-form-label col-12 col-lg-4 form-label text-center">취소 금액 : </label>
									<div class="col-12 col-lg-8 text-right" id="monthCancelPrice">0원</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>


</main>
<!-- !!메인 영역 -->
<%@ include file="../../footer.jsp" %>

<script src="${pageContext.request.contextPath}/resources/quaca/js/dependency/moment/moment.js"></script>
<script src="${pageContext.request.contextPath}/resources/quaca/js/miscellaneous/fullcalendar/fullcalendar.bundle.js"></script>
<script>
	
	// 월 증가 감소 처리 변수
    var monthCount = 0;
	$(document).ready(function () {
		calendarInfo();  // 데이터 호출
	});
    //1.[해당 월 데이터 호출] - 해당 월 데이터 호출    
	function calendarInfo(){
		
		var now = new Date();
		// 날짜 재가공(월 - & + 처리 [검색용])
	    var formatDate = new Date(now.getFullYear(), (now.getMonth() + 1 + monthCount), "01");  
	    var year = formatDate.getFullYear();
	    var month = formatDate.getMonth();
	    month = month >=10 ? month : "0" + month;
	    var dt =  year+"-"+month;
	    
	    // 오늘 일자 처리
	    var nowYear = now.getFullYear();
	    var nowMonth = now.getMonth()+1;
	    var nowDay = now.getDate();
	    nowMonth = nowMonth >=10 ? nowMonth : "0" + nowMonth;
	    nowDay = nowDay >=10 ? nowDay : "0" + nowDay;
	    var today = nowYear+"-"+nowMonth+"-"+nowDay;
	    
	    
	    // 우측 월 총 매출 현황 월값
	    $("#selectMonth").html(month);
	    
		$.ajax({
			url : express_docker+"Store/calendar",
			type : "POST",
			data : {
				StoreId : "${userVO.storeId}",
				InsertDt : dt
			},success : function(data){
				$("#calendar").html("");
				calendarFlow(data, dt, today);
				//$(".fc-today").parents(".fc-content-skeleton").find("tbody td").eq($(".fc-content-skeleton .fc-today").index()).addClass("fc-today-sales");
				$(".fc-today").css("background-color",'#E3F2FD');
			},
			error : function(){
				alert("err");
			}		
		});
	}
	
	//2.[데이터 캘린더 처리] - 켈린더 
	var dataArr = new Array();
	function calendarFlow (data, dt, today){
		dataArr = new Array();
		
		var dataObj = new Object();
		var totalPrice = 0;
		var cancelTotalPrice = 0;
		var dataId = "";
		if(data.success){
			for(var i = 0 ; i < data.info.Order.length; i++){
				if(data.info.Order[i].InsertDt == today){
					// 금일 총 매출 금액
					$("#todayTotalPrice").html(numberWithCommas(data.info.Order[i].TotalPrice)+"원");
				}
				dataId = "";
				dataId = data.info.Order[i].InsertDt.split("-")[0]+data.info.Order[i].InsertDt.split("-")[1]+data.info.Order[i].InsertDt.split("-")[2]+data.info.Order;
				totalPrice += data.info.Order[i].TotalPrice;
				dataObj = new Object();
				dataObj.id = dataId;
				dataObj.title = "매출 : "+numberWithCommas(data.info.Order[i].TotalPrice)+"원";
				dataObj.start = data.info.Order[i].InsertDt;
				dataObj.description = i+data.info.Order.length;
				dataObj.className = "border-dark bg-dark text-white";
				dataArr.push(dataObj);
			}
			for(var i = 0 ; i < data.info.cancelOrder.length; i++){
				if(data.info.cancelOrder[i].InsertDt == today){
					// 금일 총 취소 금액
					$("#todayCancelPrice").html(numberWithCommas(data.info.cancelOrder[i].TotalPrice)+"원");
				}
				dataId = "";
				dataId = data.info.cancelOrder[i].InsertDt.split("-")[0]+data.info.cancelOrder[i].InsertDt.split("-")[1]+data.info.cancelOrder[i].InsertDt.split("-")[2]+data.info.cancelOrder.length;
				cancelTotalPrice += data.info.cancelOrder[i].TotalPrice;
				dataObj = new Object();
				dataObj.id = dataId;
				dataObj.title = "취소 : "+numberWithCommas(data.info.cancelOrder[i].TotalPrice)+"원";
				dataObj.start = data.info.cancelOrder[i].InsertDt;
				dataObj.description = i+data.info.cancelOrder.length;
				dataObj.className = " border-white bg-white text-dark";
				if(data.info.cancelOrder[i].InsertDt == today){
					dataObj.className = "bg-transparent text-dark";	
				}
				dataArr.push(dataObj);
			}
		}
		// 이번달 총 매출 금액
		$("#monthTotalPrice").html(numberWithCommas(totalPrice)+"원");
		
		// 이번달 총 환불 금액
		$("#monthCancelPrice").html(numberWithCommas(cancelTotalPrice)+"원");
		
		var calendarEl = document.getElementById('calendar');
		
		var calendar = new FullCalendar.Calendar(calendarEl,
		{
		    plugins: ['dayGrid', 'list', 'timeGrid', 'interaction', 'bootstrap'],
		    themeSystem: 'bootstrap',
		    timeZone: 'UTC',
		    defaultDate : dt+'-01',
		    //dateAlignment: "month", //week, month
		    buttonText:
		    {
		        today: 'today',
		        month: 'month',
		        week: 'week',
		        day: 'day',
		        list: 'list'
		    },
		    eventTimeFormat:
		    {
		        hour: 'numeric',
		        minute: '2-digit',
		        meridiem: 'short'
		    },
		    navLinks: true,
		    header:
		    {
		        //left: 'prev,next today addEventButton',
		        left: 'movePrev, reset, moveNext',
		        center: 'title',
		        //right: 'dayGridMonth,timeGridWeek,timeGridDay,listWeek'
		        right: ''
		    },
		    customButtons:
		    {
		    	movePrev : {
		    		text : "<",
		    		click : function(){
		    			//fc-prev-button btn btn-default
		    			--monthCount;
		    			calendarInfo();
		    		}
		    	},
		    	moveNext : {
		    		text : ">",
		    		click : function(){
		    			//fc-next-button btn btn-default
		    			++monthCount;
		    			calendarInfo();
		    		}
		    	},
		    	reset : {
		    		text : "오늘",
		    		click : function(){
		    			monthCount = 0;
		    			calendarInfo();
		    		}
		    	}
		    },
		    viewSkeletonRender: function(info) {
		        calendarEl.querySelectorAll('.fc-button').forEach((button) => {
		          if (button.innerText === 'prev') {
		            button.classList.add('fc-prev-button btn btn-default')
		          }
		          if (button.innerText === 'next') {
		            button.classList.add('fc-next-button btn btn-default')
		          }
		        });
		    },
		    footer:
		    {
		        left: '',
		        center: '',
		        right: ''
		    },
		    prev : {
	    		click : function(){
	    			alert();
	    		}
	    	},
			editable: false,
			eventLimit: true, // allow "more" link when too many events
			events:dataArr,
			locale : 'kr'
		});

		calendar.render();
	}
	
	
	// 콤마 처리
	function numberWithCommas(x) {
	    return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
	}
	
</script>