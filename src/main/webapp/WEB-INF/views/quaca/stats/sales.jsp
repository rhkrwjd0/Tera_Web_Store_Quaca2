<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../../header.jsp" %>
<link rel="stylesheet" media="screen, print" href="${pageContext.request.contextPath}/resources/quaca/css/formplugins/bootstrap-datepicker/bootstrap-datepicker.css">
<style>
.center-block {
  display: block;
  margin-right: auto;
  margin-left: auto;
}
</style>
<!-- 메인 영역 -->
<main id="js-page-content" role="main" class="page-content stats-sales">
	<ol class="breadcrumb page-breadcrumb">
        <li class="breadcrumb-item"><a href="javascript:void(0);">Quaca</a></li>
        <li class="breadcrumb-item">in 매장 분석</li>
        <li class="breadcrumb-item active">매출 분석</li>
        <li class="position-absolute pos-top pos-right d-none d-sm-block"><span class="js-get-date"></span></li>
    </ol>
   	<div class="row">
		<div class="col-xl-12 con-grid">
			<!-- 검색 구간 -->
			<div class="set-title-line">
				<div class="search-date-wrap">
					<button type="button" class="btn btn-primary" id="day" name="searchBtn" onclick="searchType('day');">오늘</button>
				    <button type="button" class="btn btn-secondary" id="week" name="searchBtn" onclick="searchType('week');">1주일</button>
				    <button type="button" class="btn btn-secondary" id="month" name="searchBtn" onclick="searchType('month');">1개월</button>
				    <button type="button" class="btn btn-secondary" id="3month" name="searchBtn" onclick="searchType('3month');">3개월</button>							
				</div>
				<div  class="search-form-wrap">
					<div class="form-group">								                               
						<div class="input-group">
							<input type="text" id="startDt" class="form-control" placeholder="시작 일" style="background-color:White;" readonly="readonly">
							<div class="input-group-append">
								<span class="input-group-text fs-xl"><i class="fal fa-calendar-alt"></i></span>
							</div>
							<input type="text" id="endDt" class="form-control" placeholder="종료 일" style="background-color:White;" readonly="readonly">
							<div class="input-group-append">
								<span class="input-group-text fs-xl"><i class="fal fa-calendar-alt"></i></span>
							</div>
							<button type="button" class="btn btn-outline-primary" id="searchDt" name="searchBtn" onclick="searchDt();">검색</button>
						</div>
					</div>
				</div>
			</div>
			<!-- /검색 구간 -->
			
			<div id="panel-1" class="panel">
				<div class="panel-container show">
					<div class="panel-content">
						<!-- 데이터 구간 -->
						<h2><b>Sales Analysis Table</b></h2>
						<div class="border border-dark">
							<div class="demo m-1 p-1">
								<table class="table" >
									<thead class="bg-dark">
										<tr class="text-center">
											<th class="text-white">결제 금액</th>
											<th class="text-white">결제 건수</th>
											<th class="text-white">평균 결제 금액</th>
										</tr>
									</thead>
									<tbody>
										<tr class="text-center">
											<td id="totalPrice">0원</td>
											<td id="orderCnt">0건</td>
											<td id="avgPrice">0원</td>
										</tr>
									</tbody>
								</table>
								<table class="table">
									<thead class="bg-dark">
										<tr class="text-center" >
											<th class="text-white">주문 취소 금액</th>
											<th class="text-white">주문 취소 건수</th>
											<th class="text-white">평균 주문 취소 금액</th>
										</tr>
									</thead>
									<tbody>
										<tr class="text-center">
											<td id="cancelTotalPrice">0원</td>
											<td id="cancelOrderCnt">0건</td>
											<td id="cancelAvgPrice">0원</td>
										</tr>
									</tbody>
								</table>
							</div>
						</div>
						<!-- 데이터 구간 -->
					</div>
				</div>
			</div>
			<div id="panel-2" class="panel">
				<div class="panel-container">
					<div class="panel-content">
						<!-- 결제 방식 차트 구간 -->
						<h2><b>Sales by payment method</b></h2>
						<div class="border border-dark">
							<div id="example">
								<div class="demo-section k-content wide m-1 p-3">
									<div id="barChart">
									
									</div>
								</div>
							</div>
						</div>
						<!-- 결제 방식 차트 구간 -->
					</div>
				</div>
			</div>
		</div>
	</div>
</main>
<!-- !!메인 영역 -->
<%@ include file="../../footer.jsp" %>
<script src="${pageContext.request.contextPath}/resources/quaca/js/formplugins/bootstrap-datepicker/bootstrap-datepicker.custom.js"></script>
<script>
	// 데이트 피커 전용 
	var controls = {
		leftArrow: '<i class="fal fa-angle-left" style="font-size: 1.25rem"></i>',
		rightArrow: '<i class="fal fa-angle-right" style="font-size: 1.25rem"></i>'
	}
	
	$(document).ready(function () {
 	    // "오늘" 기준으로 데이터 호출
		searchType("week");
		//시작일 데이트 피커
		$('#startDt').datepicker({
			todayBtn: "linked",
			clearBtn: true,
			todayHighlight: true,
			orientation: "bottom left",
			templates: controls,
			format: "yyyy-mm-dd",
            language: "kr"
		});
		//종료일 데이트 피커
		$('#endDt').datepicker({
			todayBtn: "linked",
			clearBtn: true,
			todayHighlight: true,
			orientation: "bottom left",
			templates: controls,
			format: "yyyy-mm-dd",
            language: "kr"
		});
	});
	

	//1-1.[검색 - 데이터] - 오늘, 1주일, 1개월, 3개월 검색
	function searchType(selectType){
		//2.[검색 - 결제수단별] - 호출
		searchPaymentType(selectType);
		
		$("button[name=searchBtn]").removeClass("btn-primary").addClass("btn-secondary");
		$("#"+selectType).removeClass("btn-secondary").addClass("btn-primary");
		
		var selectUrl = "Store/salesday "; // 기본 day url 
		if(selectType == "week"){
			selectUrl = "Store/salesweek"; // 1주일
		}else if(selectType == "month"){
			selectUrl = "Store/salesmonth"; // 1개월
		}else if(selectType == "3month"){
			selectUrl = "Store/salesmonth3"; // 3개월
		}
		$("#startDt").val("");
		$("#endDt").val("");
		
		$.ajax({
			url : express_docker+selectUrl,
			type : "POST",
			data : {
				StoreId : "${userVO.storeId}"
			},success : function(data){
				var totalPrice = "0원";
				var orderCnt = "0건";
				var avgPrice = "0원";
				var cancelTotalPrice = "0원";
				var cancelOrderCnt = "0건";
				var cancelAvgPrice = "0원";
				if(data.success){
					
					// 결제 정보
					totalPrice = data.info.Order.TotalPrice != null ? numberWithCommas(data.info.Order.TotalPrice)+"원" : "0원";
					orderCnt = numberWithCommas(data.info.Order.OrderCnt)+"건";
					avgPrice = data.info.Order.AvgPrice != null ? numberWithCommas(data.info.Order.AvgPrice.toFixed(2))+"원" : "0원";
					// 취소 정보
					cancelTotalPrice = data.info.cancelOrder.CancelTotalPrice != null ? numberWithCommas(data.info.cancelOrder.CancelTotalPrice)+"원" : "0원";
					cancelOrderCnt = numberWithCommas(data.info.cancelOrder.CancelOrderCnt)+"건";
					cancelAvgPrice = data.info.cancelOrder.CancelAvgPrice != null ? numberWithCommas(data.info.cancelOrder.CancelAvgPrice.toFixed(2))+"원" : "0원";
				}
				$("#totalPrice").html(totalPrice);
				$("#orderCnt").html(orderCnt)
				$("#avgPrice").html(avgPrice);
				$("#cancelTotalPrice").html(cancelTotalPrice);
				$("#cancelOrderCnt").html(cancelOrderCnt)
				$("#cancelAvgPrice").html(cancelAvgPrice);
			},
			error : function(){
				alert("err");
			}		
		});
	}
	//1-2.[검색 - 데이터] - 기간 검색
	function searchDt(){
		//2.[검색 - 결제수단별] - 호출
		searchPaymentDt();		
		$("button[name=searchBtn]").removeClass("btn-primary").addClass("btn-outline-primary");
		$("#searchDt").removeClass("btn-outline-primary").addClass("btn-primary");
		if(validate()){
			$.ajax({
				url : express_docker+"Store/salesdetail",
				type : "POST",
				data : {
					StoreId : "${userVO.storeId}",
					StartDt : $("#startDt").val(),
					EndDt :	$("#endDt").val(),
				},success : function(data){
					var totalPrice = "0원";
					var orderCnt = "0건";
					var avgPrice = "0원";
					var cancelTotalPrice = "0원";
					var cancelOrderCnt = "0건";
					var cancelAvgPrice = "0원";
					if(data.success){
						
						// 결제 정보
						totalPrice = data.info.Order.TotalPrice != null ? numberWithCommas(data.info.Order.TotalPrice)+"원" : "0원";
						orderCnt = numberWithCommas(data.info.Order.OrderCnt)+"건";
						avgPrice = data.info.Order.AvgPrice != null ? numberWithCommas(data.info.Order.AvgPrice.toFixed(2))+"원" : "0원";
						// 취소 정보
						cancelTotalPrice = data.info.cancelOrder.CancelTotalPrice != null ? numberWithCommas(data.info.cancelOrder.CancelTotalPrice)+"원" : "0원";
						cancelOrderCnt = numberWithCommas(data.info.cancelOrder.CancelOrderCnt)+"건";
						cancelAvgPrice = data.info.cancelOrder.CancelAvgPrice != null ? numberWithCommas(data.info.cancelOrder.CancelAvgPrice.toFixed(2))+"원" : "0원";
					}
					$("#totalPrice").html(totalPrice);
					$("#orderCnt").html(orderCnt)
					$("#avgPrice").html(avgPrice);
					$("#cancelTotalPrice").html(cancelTotalPrice);
					$("#cancelOrderCnt").html(cancelOrderCnt)
					$("#cancelAvgPrice").html(cancelAvgPrice);
				},
				error : function(){
					alert("err");
				}		
			});
		}
	}
	
	//2-1.[검색 - 결제수단별 ] - 오늘, 1주일, 1개월, 3개월 검색
	function searchPaymentType(selectType){
		
		var selectUrl = "Store/payday "; // 기본 day url 
		if(selectType == "week"){
			selectUrl = "Store/payweek"; // 1주일
		}else if(selectType == "month"){
			selectUrl = "Store/paymonth"; // 1개월
		}else if(selectType == "3month"){
			selectUrl = "Store/paymonth3"; // 3개월
		}
		
		$.ajax({
			url : express_docker+selectUrl,
			type : "POST",
			data : {
				StoreId : "${userVO.storeId}"
			},success : function(data){
				if(data.success){
					var totalPrice = 0;
					data.info.map(function(v){
						totalPrice += v.TotalPrice;
					});
					$("#barChart").html(barChartHtml(data.info, totalPrice));
				}else{
					var html = "";
					$("#barChart").html('<div class="demo js-progress-animated"><div class="empty">데이터 존재하지 않습니다.</div></div>')
				}
			},
			error : function(){
				alert("err");
			}		
		});
	}
	
	//2-2.[검색 - 결제수단별 ] - 기간 검색
	function searchPaymentDt(){
		if(validate()){
			$.ajax({
				url : express_docker+"Store/paydetail",
				type : "POST",
				data : {
					StoreId : "${userVO.storeId}",
					StartDt : $("#startDt").val(),
					EndDt :	$("#endDt").val(),
				},success : function(data){
					if(data.success){
						var totalPrice = 0;
						data.info.map(function(v){
							totalPrice += v.TotalPrice;
						});
						$("#barChart").html(barChartHtml(data.info, totalPrice));
					}else{
						var html = "";
						$("#barChart").html('<div class="demo js-progress-animated"><div class="empty">데이터 존재하지 않습니다.</div></div>')
					}
				},
				error : function(){
					alert("err");
				}		
			});
		}
	}
	//2-3.[검색 - 결제수단별 ] - bar chart 
	function barChartHtml(data, totalPrice){
		var html = "";
		var payMentNm = "";
		var percent = 0;
		if(data.length > 0){
			for(var i = 0; i < data.length; i++){
				payMentNm = "";
				percent = Math.round(data[i].TotalPrice/totalPrice*100);
				if(data[i].PayMethod == "point"){
					payMentNm = "카카오페이";
				}else if(data[i].PayMethod == "card"){
					payMentNm = "신용카드";
				}else if(data[i].PayMethod == "samsung"){
					payMentNm = "삼성페이";
				}else if(data[i].PayMethod == "phone"){
					payMentNm = "핸드폰소액결제";
				}
				
				html += '<div class="demo js-progress-animated">';
				html += 	'<div class="form-group row">';
				html += 		'<div class="col-12 col-lg-6">';
				html += 			'<div class="form-row float-left">';
				html += 				"- "+payMentNm;
				html += 			'</div>';
				html += 		'</div>';
				html += 		'<div class="col-12 col-lg-6">';
				html += 			'<div class="form-row float-right">';
				html +=					 numberWithCommas(data[i].TotalPrice)+'원';
				html += 			'</div>';
				html += 		'</div>';
				html += 	'</div>';
				html += 	'<div class="progress progress-xl">';
				html += 		'<div class="progress-bar progress-bar-striped bg-dark" role="progressbar" style="width: '+percent+'%" aria-valuenow="'+percent+'" aria-valuemin="0" aria-valuemax="100"></div>';
				html += 	'</div>';
				html += '</div>';
			}
		}else{
			html += '<div class="demo js-progress-animated">';
			html += 	'<h3>데이터 존재하지 않습니다.</h3>';
			html += '</div>';
		}
		return html;
	}
	
	// 유효성 체크 
	function validate(){
		var validateChk = true;
		var startDt = $("#startDt").val();
		var endDt = $("#endDt").val();	
		if(startDt == ""){
			validateChk = false;
			alert("시작일을 입력해 주세요.");
			$("#startDt").focus();
		}else if(endDt == ""){
			validateChk = false;
			alert("종료일을 입력해 주세요.");
			$("#endDt").focus();
		}
		return validateChk;
	}
	// 콤마 처리
	function numberWithCommas(x) {
	    return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
	}
</script>