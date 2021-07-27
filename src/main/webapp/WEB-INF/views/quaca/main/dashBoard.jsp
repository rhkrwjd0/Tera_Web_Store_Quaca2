<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../../header.jsp" %>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/quaca/kendo/styles/kendo.common.min.css" />

<!-- 메인 영역 -->
<main id="js-page-content" role="main" class="page-content dashboard">
	<ol class="breadcrumb page-breadcrumb">
		<li class="breadcrumb-item"><a href="javascript:void(0);">Quaca</a></li>
		<li class="breadcrumb-item active">Dashboard</li>
		<li class="position-absolute pos-top pos-right d-none d-sm-block"><span class="js-get-date"></span></li>
	</ol>
	   
	<!-- <div class="subheader">
		<h1 class="subheader-title">
			<i class='subheader-icon fal fa-chart-area'></i> Dashboard 
		</h1>
	</div> -->

	<div class="row info-point">
		<div class="col-sm-6 col-xl-3">
			<div class="point p-3 rounded overflow-hidden position-relative mb-g" onclick="goOrderInfo();">
				<h3 class="display-4 d-block l-h-n m-0 fw-500" id="totalRevenue"></h3>
				<i class="fal fa-coins position-absolute pos-right pos-bottom opacity-15 mb-1 mr-2" style="font-size:3.4rem;"></i>
			</div>
		</div>
		<div class="col-sm-6 col-xl-3">
			<div class="point p-3 rounded overflow-hidden position-relative mb-g" onclick="goOrderInfo();">
				<h3 class="display-4 d-block l-h-n m-0 fw-500" id="totalOCOrderCount"></h3>
				<i class="fal fa-user-clock position-absolute pos-right pos-bottom opacity-15 mb-2 mr-2" style="font-size:3.1rem;"></i>
			</div>
		</div>
		<div class="col-sm-6 col-xl-3">
			<div class="point p-3 rounded overflow-hidden position-relative mb-g" onclick="goOrderInfo();">
				<h3 class="display-4 d-block l-h-n m-0 fw-500" id="totalRCPCOrderCount"></h3>
				<i class="fal fa-file-alt position-absolute pos-right pos-bottom opacity-15 mb-2 mr-2" style="font-size:3.4rem;"></i>
			</div>
		</div>
		<div class="col-sm-6 col-xl-3">
			<div class="point p-3 rounded overflow-hidden position-relative mb-g" onclick="goOrderInfo();">
				<h3 class="display-4 d-block l-h-n m-0 fw-500" id="totalCPOrderCount"></h3>
				<i class="fal fa-bell-slash position-absolute pos-right pos-bottom opacity-15 mb-2 mr-2" style="font-size:3.2rem;"></i>
			</div>
		</div>
	</div>
	<div class="row">
		<div class="col-lg-12">
			<div id="panel-1" class="panel">
				<div class="panel-container show">
					<!-- <div class="panel-content bg-subtlelight-fade">
						<div id="js-checkbox-toggles" class="d-flex mb-3">
							<div class="custom-control custom-switch mr-2">
								<input type="checkbox" class="custom-control-input" name="gra-0" id="gra-0" checked="checked">
								<label class="custom-control-label" for="gra-0">Target Profit</label>
							</div>
							<div class="custom-control custom-switch mr-2">
								<input type="checkbox" class="custom-control-input" name="gra-1" id="gra-1" checked="checked">
								<label class="custom-control-label" for="gra-1">Actual Profit</label>
							</div>
							<div class="custom-control custom-switch mr-2">
								<input type="checkbox" class="custom-control-input" name="gra-2" id="gra-2" checked="checked">
								<label class="custom-control-label" for="gra-2">User Signups</label>
							</div>
						</div>
						<div id="flot-toggles" class="w-100 mt-4" style="height: 300px"></div>
					</div> -->
					<div class="panel-content k-content wide">
						<h2 class="mb-5">Sales graph(week1 basis)</h2>
						<div id="chart" ></div>
					</div>
				</div>
			</div>
		</div>
	</div>

</main>
<!-- !!메인 영역 -->
<!-- jquery kendo -->
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/quaca/kendo/script/jquery.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/quaca/kendo/script/kendo.all.min.js"></script>
<script type="text/javascript">
	// kendoJquery 다른이름으로 버전 불러와 저장.
	var kendojquery = $.noConflict(true);
	
	$(document).ready(function () {
       	// 데이터 호출
      	dashBoardTodayData();
   		dashBoardWeekData();
	});
	// 금일 총 주문 내역
	function dashBoardTodayData(){
		$.ajax({
			url : express_docker+"orders/DashBoardTodayData",
			type : "POST",
			data : {
				StoreId : "${userVO.storeId}"
			},
			success : function(data){
				// OC:결제완료, RC:접수완료, PC:제조완료, PUC:픽업완료, CP:주문취소요청, CUP:주문취소완료
				var totalRevenue = 0;			// 오늘 총 매출액
				var totalOCOrderCount = 0;		// 접수 대기 건수 
				var totalRCPCOrderCount = 0;	// 주문 진행 건수 
				var totalCPOrderCount = 0;		// 주문 취소 건수
				var orderStatus = "";
				if(data.success){
					for(var i = 0; i < data.info.length; i++){
						orderStatus = data.info[i].OrderStatus;
						if(('PUC').includes(orderStatus)){
							totalRevenue += Number(data.info[i].TotalPrice);	// 오늘 총 매출액
						}
						if(('OC').includes(orderStatus)){
							totalOCOrderCount++;								// 접수 대기 건수
						}
						if(('RC,PC').includes(orderStatus)){
							totalRCPCOrderCount++;								// 주문 진행 건수
						}
						if(('CP').includes(orderStatus)){
							totalCPOrderCount++;								// 주문 취소 건수
						}
					}
				}
				
				var revenueHtml = "";
				revenueHtml += numberWithCommas(totalRevenue)+" 원";
				revenueHtml += '<small class="m-0 l-h-n">오늘 총 매출 액</small>';
				$("#totalRevenue").html(revenueHtml);
				
				var OCOrderCountHtml = "";
				OCOrderCountHtml += numberWithCommas(totalOCOrderCount)+" 건";
				OCOrderCountHtml += '<small class="m-0 l-h-n">오늘 접수 대기</small>';
				$("#totalOCOrderCount").html(OCOrderCountHtml);
				
				var RCPCOrderCountHtml ="";
				RCPCOrderCountHtml += numberWithCommas(totalRCPCOrderCount)+" 건";
				RCPCOrderCountHtml += '<small class="m-0 l-h-n">오늘 주문 진행</small>';
				$("#totalRCPCOrderCount").html(RCPCOrderCountHtml);
				
				var CPOrderCountHtml ="";
				CPOrderCountHtml += numberWithCommas(totalCPOrderCount)+" 건";
				CPOrderCountHtml += '<small class="m-0 l-h-n">오늘 주문 취소</small>';
				$("#totalCPOrderCount").html(CPOrderCountHtml);
			},
			error : function(){
				alert("err");
			}		
		});
		
	}
	// 현 기준일부로 7일 총매출 액
	function dashBoardWeekData(){
		
		$.ajax({
			url : express_docker+"orders/DashBoardWeekData",
			type : "POST",
			data : {
				StoreId : "${userVO.storeId}"
			},
			success : function(data){
				// 켄도 차트 
				if(data.success){
					createChart(data.info);
				}
			},
			error : function(){
				alert("err");
			}
		});
	} 
	
	// 주문 정보 이동하기
	function goOrderInfo(){
		location.href="/quaca/orders/orderInfo";
	}
	
	// 3자리 콤마 처리 
	function numberWithCommas(x) {
    	return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
	}
	
	// KendoChart
	function createChart(weekData) {
		var totalPrice = new Array();
		var dt = new Array();
		if(weekData.length > 0){
			
			for(var i = 0 ; i < weekData.length; i++){			
				totalPrice.push(weekData[i].TotalPrice)
				dt.push(weekData[i].InsertDT)
			}
		}
		
		kendojquery("#chart").kendoChart({
            title: {
                text: ""
            },
            legend: {
                position: "bottom"
            },
            chartArea: {
                background: ""
            },
            seriesDefaults: {
                type: "line",
                style: "smooth"
            },
            series: [{
                name: "매출 금액",
                data: totalPrice /* [3.907, 7.943, 7.848, 9.284, 9.263, 9.801, 3.890, 8.238, 9.552, 6.855] */
            }],
            valueAxis: {
                labels: {
                    format: "{0}"
                },
                line: {
                    visible: false
                },
                axisCrossingValue: -10
            },
            categoryAxis: {
                categories: dt /* [2002, 2003, 2004, 2005, 2006, 2007, 2008, 2009, 2010, 2011] */,
                majorGridLines: {
                    visible: false
                },
                labels: {
                    rotation: "auto"
                }
            },
            tooltip: {
                visible: true,
                format: "{0}",
                template: "#= series.name #: #= value #"
            }
        });
    }
	$(document).bind("kendo:skinChange", createChart);
</script>


<%@ include file="../../footer.jsp" %>
