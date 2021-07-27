<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../../header.jsp" %>
<link rel="stylesheet" media="screen, print" href="${pageContext.request.contextPath}/resources/quaca/css/formplugins/bootstrap-datepicker/bootstrap-datepicker.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/quaca/kendo/styles/kendo.common.min.css" />
<style>
.center-block {
  display: block;
  margin-right: auto;
  margin-left: auto;
}
</style>
<!-- 메인 영역 -->
<main id="js-page-content" role="main" class="page-content stats-time">
	<ol class="breadcrumb page-breadcrumb">
        <li class="breadcrumb-item"><a href="javascript:void(0);">Quaca</a></li>
        <li class="breadcrumb-item">in 매장 분석</li>
        <li class="breadcrumb-item active">영업 분석</li>
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
						<h2><b>Order time analysis table</b></h2>
						<div class="border border-dark">
							<div class="demo m-1 p-1">
								<table class="table">
									<thead class="bg-dark">
										<tr class="text-center" >
											<th class="text-white">주문이 많이 들어온 시간대</th>
											<th class="text-white">주문이 적게 들어온 시간대</th>
										</tr>
									</thead>
									<tbody>
										<tr class="text-center">
											<td id="maxOrderCntTime">
											</td>
											<td id="minOrderCntTime">
											</td>
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
						<!-- 캔도 차트1 구간 -->
						<h2><b>HOURLY PAYMENT AMOUNT CHART</b></h2>
						<div class="border border-dark">
							<div id="example">
								<div class="demo-section k-content wide">
									<div id="totalPriceChart"></div>
								</div>
							</div>
						</div>
						<!-- /켄도 차트1 구간 -->
					</div>
				</div>
			</div>
			<div id="panel-3" class="panel">
				<div class="panel-container">
					<div class="panel-content">
						<!-- 켄도 차트2 구간 -->
						<h2><b>HOURLY ORDERS CHART</b></h2>
						<div class="border border-dark">
							<div id="example">
								<div class="demo-section k-content wide">
									<div id="orderCntChart"></div>
								</div>
							</div>
						</div>
						<!-- /캔도 차트2 구간 -->
					</div>
				</div>
			</div>
		</div>
	</div>
</main>
<!-- !!메인 영역 -->
<%@ include file="../../footer.jsp" %>
<script src="${pageContext.request.contextPath}/resources/quaca/js/formplugins/bootstrap-datepicker/bootstrap-datepicker.custom.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/quaca/kendo/script/jquery.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/quaca/kendo/script/kendo.all.min.js"></script>
<script>
	// kendoJquery 다른이름으로 버전 불러와 저장.
	var kendojquery = $.noConflict(true);

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
		$("button[name=searchBtn]").removeClass("btn-primary").addClass("btn-secondary");
		$("#"+selectType).removeClass("btn-secondary").addClass("btn-primary");
		
		var selectUrl = "Store/timeday"; // 기본 day url 
		if(selectType == "week"){
			selectUrl = "Store/timeweek"; // 1주일
		}else if(selectType == "month"){
			selectUrl = "Store/timemonth"; // 1개월
		}else if(selectType == "3month"){
			selectUrl = "Store/timemonth3"; // 3개월
		}
		$("#startDt").val("");
		$("#endDt").val("");
		
		$.ajax({
			url : express_docker+selectUrl,
			type : "POST",
			data : {
				StoreId : "${userVO.storeId}"
			},success : function(data){
				max_minOrderCntHtml(data);		// 주문이 많이 들어온 시간대 & 주문이 적게 들어온 시간대
				createChart(data);				// 차트  
			},
			error : function(){
				alert("err");
			}		
		});
	}
	
	//1-2.[검색 - 데이터] - 기간 검색
	function searchDt(){
		$("button[name=searchBtn]").removeClass("btn-primary").addClass("btn-outline-primary");
		$("#searchDt").removeClass("btn-outline-primary").addClass("btn-primary");
		if(validate()){
			$.ajax({
				url : express_docker+"Store/timeDetail",
				type : "POST",
				data : {
					StoreId : "${userVO.storeId}",
					StartDt : $("#startDt").val(),
					EndDt :	$("#endDt").val(),
				},success : function(data){
					max_minOrderCntHtml(data);		// 주문이 많이 들어온 시간대 & 주문이 적게 들어온 시간대
					createChart(data);				// 차트
				},
				error : function(){
					alert("err");
				}		
			});
		}
	}
	
	
	//1-3.[검색 - 데이터] - 주문이 많이 들어온 시간대 & 주문이 적게 들어온 시간대
	function max_minOrderCntHtml(data){
		if(data.success){
			
			var orderCntData = data.info.map(function(v){
					return v.OrderCnt;
			});
			var maxOrderCnt = Math.max.apply(null, orderCntData);
			var minOrderCnt = Math.min.apply(null, orderCntData);
			var maxData = new Array();
			var minData = new Array();
			var maxChk = true;
			var minChk = true;
			for(var i = 0; i < data.info.length; i++){
				if(data.info[i].OrderCnt == maxOrderCnt && maxChk){
					maxChk = false;
					maxData = data.info[i]; 				
				}
				if(data.info[i].OrderCnt == minOrderCnt && minChk ){
					minChk = false;
					minData = data.info[i];
				}
			}
			$("#maxOrderCntTime").html("<h1>"+maxData.InsertDt+":00</h1><h3>"+numberWithCommas(maxData.OrderCnt)+"건</h3>");
			$("#minOrderCntTime").html("<h1>"+minData.InsertDt+":00</h1><h3>"+numberWithCommas(minData.OrderCnt)+"건</h3>");
		}else{
			$("#maxOrderCntTime").html("<h1>00:00</h1><h3>0건</h3>");
			$("#minOrderCntTime").html("<h1>00:00</h1><h3>0건</h3>");
		}
	}
	
	
	//1-4.[검색 - 데이터] - KendoChart(시간별 결제 금액 & 시간별 주문 건수 차트)
	function createChart(data) {
		var totalPrice = new Array();	// 시간별 결제 금액 
		var orderCnt = new Array();		// 시간별 주문 건수
		var dt = new Array();			// 시간
		if(data.success){
			if(data.info.length > 0){
				for(var i = 0 ; i < data.info.length; i++){			
					totalPrice.push(data.info[i].TotalPrice);	// 시간별 결제 금액
					orderCnt.push(data.info[i].OrderCnt);		// 시간별 주문 건수
					dt.push(data.info[i].InsertDt+":00");
				}
			}
		}else{
			var Now = new Date();
			for(var i = 0 ; i < 7; i++){
				totalPrice.push(0);
				orderCnt.push(0);
				dt.push(Now.getHours()-6+i+":00");
			}
			
		}
		// 시간별 결제 금액 차트
		kendojquery("#totalPriceChart").kendoChart({
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
                color : "#000000",
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
		// 시간별 주문 건수 차트
		kendojquery("#orderCntChart").kendoChart({
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
                name: "주문 건수",
                color : "#000000",
                data: orderCnt /* [3.907, 7.943, 7.848, 9.284, 9.263, 9.801, 3.890, 8.238, 9.552, 6.855] */
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
	
	// 콤마 처리
	function numberWithCommas(x) {
	    return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
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
</script>
	