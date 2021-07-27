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
<main id="js-page-content" role="main" class="page-content store-menu">
	<ol class="breadcrumb page-breadcrumb analysis-breadcrumb">
        <li class="breadcrumb-item"><a href="javascript:void(0);">Quaca</a></li>
        <li class="breadcrumb-item">in 매장 분석</li>
        <li class="breadcrumb-item active">상품 분석</li>
        <li class="position-absolute pos-top pos-right d-none d-sm-block"><span class="js-get-date"></span></li>
    </ol>
   	<div class="row">
		<div class="col-xl-12 con-grid">
			<!-- 검색 구간 -->
			<div class="set-title-line">
				<div class="search-date-wrap">
					<button type="button" class="btn btn-secondary" id="day" name="searchBtn" onclick="searchType('day'); ">오늘</button>
				    <button type="button" class="btn btn-secondary" id="week" name="searchBtn" onclick="searchType('week');">1주일</button>
				    <button type="button" class="btn btn-secondary" id="month" name="searchBtn" onclick="searchType('month');">1개월</button>
				    <button type="button" class="btn btn-secondary" id="3month" name="searchBtn" onclick="searchType('3month');">3개월</button>							
				</div>
				<div class="search-form-wrap">
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
							<button type="button" class="btn btn-primary" id="searchDt" name="searchBtn" onclick="searchDt();">SEARCH</button>
						</div>
					</div>
				</div>
			</div>
			<!-- 검색 구간 -->
			
			<div id="panel-1" class="panel">
				<div class="panel-container">
					<div class="panel-content">
						<!-- 데이터 구간(top 3) -->
						<h2 class="row top3Div-header div-title">
							<span class="col-6 text-left"><b>Best Menu</b></span>
							<span class="col-6 text-right" style="color: #9a9a9a;"><span class="top3-tot">Total</span> <span id="orderTop3Total" style="color: #4a4a4a;">0</span>건</span>
						</h2>
						<div id="top3Div">
						</div>
						<!-- 데이터 구간(top 3) -->
					</div>
				</div>
			</div>
			<div id="panel-2" class="panel">
				<div class="panel-container">
					<div class="panel-content">
						<!-- 데이터 구간(chart) -->
						<h2 class="div-title"><b>Category Status</b></h2>
						<div class="row">
							<div  class="col-sm-5 col-12">
								<div id="chart" class="store-chart"></div>
							</div>
							<div  class="col-sm-7 col-12 my-auto mx-auto" id="categoryLabelDiv">
							</div>
						</div>
						<div id="categoryListDiv"></div>
						<!-- 데이터 구간(chart) -->
					</div>
				</div>
			</div>
			<div id="panel-3" class="panel">
				<div class="panel-container">
					<div class="panel-content best-sell-cont">
						<!-- 데이터 구간(top 10 List) -->
						<h2 class="row best-sell div-title">
							<span class="col-7 text-left"><b>best selling menu 10</b></span>
							<span class="col-5 text-right" style="color: #9a9a9a;"><span class="top3-tot">Total 10</span></span>
						</h2>
						<div id="top10Div"></div>
						<!-- 데이터 구간(top 10 List) -->
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
	
	//1-1.[검색 - 데이터] - 오늘, 1주일, 1개월, 3개월 검색(상품 top 3 & 상품 top 10)
	function searchType(selectType){
		searchCategoryType(selectType);
		$("button[name=searchBtn]").removeClass("btn-primary").addClass("btn-secondary");
		$("#"+selectType).removeClass("btn-secondary").addClass("btn-primary");
		
		var selectUrl = "Store/menuday"; // 기본 day url 
		if(selectType == "week"){
			selectUrl = "Store/menuweek"; // 1주일
		}else if(selectType == "month"){
			selectUrl = "Store/menumonth"; // 1개월
		}else if(selectType == "3month"){
			selectUrl = "Store/menumonth3"; // 3개월
		}
		$("#startDt").val("");
		$("#endDt").val("");
		
		$.ajax({
			url : express_docker+selectUrl,
			type : "POST",
			data : {
				StoreId : "${userVO.storeId}"
			},success : function(data){
				$("#top3Div").html(top3Html(data));
				$("#top10Div").html(top10Html(data));
			},
			error : function(){
				alert("err");
			}		
		});
	}
	
	//1-2.[검색 - 데이터] - 기간 검색(상품 top 3 & 상품 top 10)
	function searchDt(){
		searchCategoryDt();
		//$("button[name=searchBtn]").removeClass("btn-primary").addClass("btn-outline-primary");
		$("#searchDt").removeClass("btn-primary").addClass("btn-outline-primary");
		if(validate()){
			$.ajax({
				url : express_docker+"Store/menumonthdetail",
				type : "POST",
				data : {
					StoreId : "${userVO.storeId}",
					StartDt : $("#startDt").val(),
					EndDt :	$("#endDt").val(),
				},success : function(data){
					$("#top3Div").html(top3Html(data));
					$("#top10Div").html(top10Html(data));
				},
				error : function(){
					alert("err");
				}		
			});
		}
	}
	//1-3.[검색 - 데이터] - 상품 top 10 html
	function top10Html(data){
		var html = "";
		
		html += '<table class="table table-bordered-btm table-hover" >';
		html += 	'<thead>';
		html += 		'<tr class="text-center" >';
		html += 			'<th>Rank</th>';
		html += 			'<th>Menu Name</th>';
		html += 			'<th>Category</th>';
		html += 			'<th>Count</th>';
		html += 			'<th>Sales</th>';
		html += 		'</tr>';
		html += 	'</thead>';
		html += 	'<tbody>';
		
		if(data.success){
			if(data.info.length > 0){
				for(var i = 0; i < (data.info.length > 10 ? 10 : data.info.length); i++){
					html += 	'<tr class="text-center">';
					html += 		'<td>'+(i+1)+'</td>';
					html += 		'<td class="menu-name">'+data.info[i].MenuName+'</td>';
					html += 		'<td>'+createNm(data.info[i].Category)+'</td>';
					html += 		'<td>'+data.info[i].MenuCnt+'</td>';
					html += 		'<td>'+numberWithCommas(data.info[i].TotalPrice)+'</td>';
					html += 	'</tr>';
				}
			}	
		}else{
			html += 	'<tr class="text-center">';
			html += 		'<td colspan="5">데이터가 존재하지 않습니다.</td>';
			html += 	'</tr>';
		}
		
		html += 	'</tbody>';
		html += '</table>';
		
		
		return html;
	}
	
	//1-4.[검색 - 데이터] - 상품 top 3 html 
	function top3Html(data){
		var totalOrderCnt = 0;	// 총 건수
		var top1Nm = "-";		// 1위 네임
		var top1OrderCnt = 0;	// 1위 건수
		var top1ImgPath= "";	// 1위 이미지 경로 
		var top2Nm = "-";		// 2위 네임
		var top2OrderCnt = 0;	// 2위 건수
		var top2ImgPath= "";	// 2위 이미지 경로 
		var top3Nm = "-";		// 3위 네임
		var top3OrderCnt = 0;	// 3위 건수
		var top3ImgPath= "";	// 3위 이미지 경로 
		
		var html = "";
		
		if(data.success){
			if(data.info.length > 0){
				for(var i = 0; i < (data.info.length > 3 ? 3 : data.info.length); i++){
					if(i == 0){
						totalOrderCnt += data.info[i].MenuCnt
						top1Nm = data.info[i].MenuName;
						top1OrderCnt = data.info[i].MenuCnt;
						top1ImgPath = "/"+data.info[i].FilePath+data.info[i].FileEncNm
					}else if(i == 1){
						totalOrderCnt += data.info[i].MenuCnt
						top2Nm = data.info[i].MenuName;
						top2OrderCnt = data.info[i].MenuCnt;
						top2ImgPath = "/"+data.info[i].FilePath+data.info[i].FileEncNm
					}else if(i == 2){
						totalOrderCnt += data.info[i].MenuCnt
						top3Nm = data.info[i].MenuName;
						top3OrderCnt = data.info[i].MenuCnt;
						top3ImgPath = "/"+data.info[i].FilePath+data.info[i].FileEncNm
					}
				}
				//Best Menu 3(total data) 
				$("#orderTop3Total").html(numberWithCommas(totalOrderCnt));
				
				html += '<div class="row top3-wrap">';
				html += 	'<div class="col-sm-6 left">';
				if(top1OrderCnt > 0){
					html += 		'<div class="item item-top1">';
					html +=				'<span class="best-rank">01</span>';
					html +=				'<div class="thumb">'
					html +=					'<img src="'+top1ImgPath+'">';
					html +=				'</div>'
					html +=				'<div class="text">'
					html +=					'<span>'+top1Nm+'</span>';
					html +=					'<span class="best-cnt">'+'<span class="num">'+numberWithCommas(top1OrderCnt)+'</span>'+'건</span>';
					html +=				'</div>'
					html += 		'</div>';
				}
				html += 	'</div>';
				html += 	'<div class="col-sm-6 right">';
				if(top2OrderCnt > 0){
					html += 	'<div class="item">';
					html += 		'<span class="best-rank">02</span>';
					html +=			'<div class="thumb">'
					html +=				'<img src="'+top2ImgPath+'">';
					html +=			'</div>'
					html +=			'<div class="text">'
					html +=				'<span>'+top2Nm+'</span>';
					html +=				'<span class="best-cnt">'+'<span class="num">'+numberWithCommas(top2OrderCnt)+'</span>'+'건</span>';
					html +=			'</div>'
					html += 	'</div>';
				}
				if(top3OrderCnt > 0){
					html += 	'<div class="item">';
					html += 		'<span class="best-rank">03</span>';
					html +=			'<div class="thumb">'
					html +=				'<img src="'+top3ImgPath+'">';
					html +=			'</div>'
					html +=			'<div class="text">'
					html +=				'<span>'+top3Nm+'</span>';
					html +=				'<span class="best-cnt">'+'<span class="num">'+numberWithCommas(top3OrderCnt)+'</span>'+'건</span>';
					html +=			'</div>'
					html += 	'</div>';
				}
				html += 	'</div>';
				html += '</div>';
			}
		}else{
			$("#orderTop3Total").html(0);
		}
		
		return html; 
	}
	
	//2-1.[검색 - 도넛 차트(category)] - 오늘, 1주일, 1개월, 3개월 검색
	function searchCategoryType(selectType){
		
		var selectUrl = "Store/menucateday"; // 기본 day url 
		if(selectType == "week"){
			selectUrl = "Store/menucateweek"; // 1주일
		}else if(selectType == "month"){
			selectUrl = "Store/menucatemonth"; // 1개월
		}else if(selectType == "3month"){
			selectUrl = "Store/menucatemonth3"; // 3개월
		}
		$.ajax({
			url : express_docker+selectUrl,
			type : "POST",
			data : {
				StoreId : "${userVO.storeId}"
			},success : function(data){
				createChart(data); 
			},
			error : function(){
				alert("err");
			}		
		});
	}
	
	//2-2.[검색 - 도넛 차트(category)] - 기간 검색
	function searchCategoryDt(){
		if(validate()){
			$.ajax({
				url : express_docker+"Store/menucatemonthdetail",
				type : "POST",
				data : {
					StoreId : "${userVO.storeId}",
					StartDt : $("#startDt").val(),
					EndDt :	$("#endDt").val(),
				},success : function(data){
					createChart(data);
				},
				error : function(){
					alert("err");
				}		
			});
		}
	}
	
	//2-3.[검색 - 도넛 차트(category)] - 7가지 색상
	function sevenColors(count){
		var remainder = count % 3;
		var colorVal = "";
		if(remainder == 0){colorVal = "#000000";}
		else if(remainder == 1){colorVal = "#454545";}	
		else if(remainder == 2){colorVal = "#707070";}	
		return colorVal; 
	}
	
	//2-4.[검색 - 도넛 차트(category)] - 카테고리 한글화
	function createNm(Cate){
		var nm = "";
		if(Cate == 'Drink' || Cate == 'D' || Cate == 'S'){nm = "음료"}
		else if(Cate == 'Goods' || Cate == 'G'){nm = "굿즈"}
		else if(Cate == 'Bakery' || Cate == 'B'){nm = "베이커리"}
		return nm;
	}
	
	//2-5.[검색 - 도넛 차트(category)] - KendoChart
	function createChart(data) {
		
		var firstCate = "";
		var firstCateValue = 0;
		
		var dataArr = new Array();
		var dataObj = new Object();
		var totalOrderCnt = 0;
		
		if(data.success){
			dataArr = new Array();
			totalOrderCnt= 0;
			for(var i = 0 ; i < data.info.length; i++){
				
				if(data.info[i].Ranking == 1){
					firstCate = createNm(data.info[i].Cate);
					firstCateValue = data.info[i].OrderCnt;
				}
				
				dataObj = new Object();
				totalOrderCnt += data.info[i].OrderCnt;
				dataObj.category = createNm(data.info[i].Cate);
				dataObj.value = data.info[i].OrderCnt;
				dataObj.color = sevenColors(i);
				dataObj.totalPrice = data.info[i].TotalPrice;
				dataArr.push(dataObj);
			}
			$("#categoryLabelDiv").html(categoryLabelHtml(dataArr, totalOrderCnt));
		}else{
			dataArr = new Array();
			dataObj = new Object();
			dataObj.category = "없음";
			dataObj.value = 1;
			dataObj.color = sevenColors(0);
			dataArr.push(dataObj);
			
			$("#categoryLabelDiv").html("");
		}
		
		var center;
        var radius;
        
		kendojquery("#chart").width(250).height(250).kendoChart({
			chartArea: { 
				background: ""
			},
           	legend: {
                visible: false
            },
            series: [{
                type: "donut",
                overlay: { gradient: "none" },
                startAngle: 100,
                holeSize : 50,
                visual: function(e) {
                    center = e.center;
                    radius = e.radius;

                    return e.createVisual();
                  },
                data: dataArr
            }],
            tooltip: {
                visible: true,
                template: "#= category # - #= kendo.format('{0:P}', percentage) #"
            },
            render: function(e) {
            	var circleGeometry = new kendo.geometry.Circle(center, radius);
                var bbox = circleGeometry.bbox();

                
                var heading = new kendo.drawing.Text(firstCate, [0, 0], {
                	font: '14px "Noto Sans KR"'
                });

                var line = new kendo.drawing.Text((totalOrderCnt > 0 ? ((firstCateValue/totalOrderCnt)*100).toFixed(0) : 0), [0, 0], {
                  	font: 'bold 36px "Red Hat Display"'
                });
                          
                var layout = new kendo.drawing.Layout(bbox, {
					orientation: "vertical",	// 수직 정렬 처리 
					alignItems: 'center',
					alignContent: "center",
					justifyContent: "center",
					//spacing: 2,
                });

                layout.append(heading, line);
                layout.reflow();
                
                e.sender.surface.draw(layout); 
                
                // '%' 개별 스타일
                var targetCategoryRate = "#chart svg g:last-child text:last-child";
                var categoryRate = $(targetCategoryRate).text();
                $("#chart").append("<div class='category-rate'>" + categoryRate + "<span class='rate-per'>" + "%</span>" + "</div>");
                $(targetCategoryRate).hide();
            }
           
        });
    }
	
	//2-6.[검색 - 도넛 차트(category)] - 라벨(퍼센트)
	function categoryLabelHtml(data, totalOrderCnt){
		var html="";
		var percentage = 0;
		if(data.length > 0){
			for(var i = 0; i < data.length; i++){
				percentage = totalOrderCnt > 0 ? ((data[i].value/totalOrderCnt)*100).toFixed(0) : 0;
				html += '<div class="category-label category-status">';
				html += 	'<div class="label-tit">';
				html += 		'<span class="label-circle" style="background-color: '+data[i].color+';"></span>';
				html += 	'</div>';
				html += 	'<div class="status-table-wrap">';
				html +=			'<table>';
				html +=				'<tr>';
				html += 				'<td>'+'<span class="ml-2 mr-2 category">'+data[i].category+'</span>'+'</td>';
				html += 				'<td>'+'<span class="text-center ml-2 mr-2 category-txt per">'+'<b>' + percentage +'</b>' +'%</span>'+'</td>';
				html += 				'<td>'+'<span class="text-center ml-2 mr-2 category-txt">'+'<b>' + data[i].value +'</b>' +'건</span>'+'</td>';
				html += 				'<td>'+'<span class="text-center ml-2 mr-2 category-txt">'+'<b>' + numberWithCommas(data[i].totalPrice) +'</b>'+'</span>'+'</td>';
				html +=					'</tr>';
				html +=			'</table>';
				html +=		'</div>';
				html += '</div>';
			}
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