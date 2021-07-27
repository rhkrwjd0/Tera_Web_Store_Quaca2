<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../../header.jsp" %>
<link rel="stylesheet" media="screen, print" href="${pageContext.request.contextPath}/resources/quaca/css/datagrid/datatables/datatables.bundle.css">
<link rel="stylesheet" media="screen, print" href="${pageContext.request.contextPath}/resources/quaca/css/formplugins/bootstrap-datepicker/bootstrap-datepicker.css">
<style>
.center-block {
  display: block;
  margin-right: auto;
  margin-left: auto;
}
</style>
<!-- 메인 영역 -->
<main id="js-page-content" role="main" class="page-content payment-list">
	<ol class="breadcrumb page-breadcrumb">
        <li class="breadcrumb-item"><a href="javascript:void(0);">Quaca</a></li>
        <li class="breadcrumb-item">in 결제 정보</li>
        <li class="breadcrumb-item">주문 내역</li>
        <li class="breadcrumb-item active">목록</li>
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
						<div class="demo-v-spacing">
							<h2><b>Total Order / Sales</b></h2>
							<div class="alert alert-primary" role="alert">
								<div class="row">
									<div class="col-xl-6" id="totalCount">
									    <strong>총 주문 횟수 : </strong> 0건
									</div>
								     
									<div class="col-xl-6" id="totalPrice">
									    <strong>총 매출 액 : </strong> 0원
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
		   	</div>
		   	<div id="panel-2" class="panel">
		   		<div class="panel-container">
		   			<div class="panel-content">
		   				<div id="tableDiv">
						</div>
						<!-- Modal Large -->
						<div class="modal fade" id="paymentInfoModal" tabindex="-1" role="dialog" aria-hidden="true">
							<!-- <div class="modal-dialog modal-lg" role="document"> -->
							<div class="modal-dialog" role="document">
								<div class="modal-content">
									<div class="modal-header center-block">
										<h1 class="modal-title fa-3x"><b>주문 상세</b></h1>								  
									</div>
									<div class="modal-body" id="modal_body">
									</div>
									<div class="modal-footer">
										<button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
									</div>
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

	<script src="${pageContext.request.contextPath}/resources/quaca/js/datagrid/datatables/datatables.bundle.custom.js"></script>
	<script src="${pageContext.request.contextPath}/resources/quaca/js/formplugins/bootstrap-datepicker/bootstrap-datepicker.custom.js"></script>
	<script type="text/javascript">
		// 데이트 피커 전용 
		var controls = {
			leftArrow: '<i class="fal fa-angle-left" style="font-size: 1.25rem"></i>',
			rightArrow: '<i class="fal fa-angle-right" style="font-size: 1.25rem"></i>'
		}
		$(document).ready(function () {
			// "오늘" 기준으로 데이터 호출
			searchType("day");
			
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
		
		//1-1.[검색] - 오늘, 1주일, 1개월, 3개월 검색
		function searchType(selectType){
			$("button[name=searchBtn]").removeClass("btn-primary").addClass("btn-secondary");
			$("#"+selectType).removeClass("btn-secondary").addClass("btn-primary");
			
			var selectUrl = "orders/paymentList"; // 기본 day url 
			if(selectType == "week"){
				selectUrl = "orders/paymentListweek"; // 1주일
			}else if(selectType == "month"){
				selectUrl = "orders/paymentListmonth"; // 1개월
			}else if(selectType == "3month"){
				selectUrl = "orders/paymentListmonth3"; // 3개월
			}
			$("#startDt").val("");
			$("#endDt").val("");
			console.log("!@!@");
			$.ajax({
				url : express_docker+selectUrl,
				type : "POST",
				data : {
					StoreId : "${userVO.storeId}"
				},success : function(data){
					
					if(data.success){
						console.log("!@!@");
						$("#tableDiv").html(paymentListHtml(data.info));
						$('#dt-basic-example').dataTable({
							responsive: true
						});
					}else{
						$("#tableDiv").html(paymentBasisHtml());
					}
				},
				error : function(){
					alert("err");
				}		
			});
		}
		
		//1-2.[검색] - 기간 검색
		function searchDt(){
			$("button[name=searchBtn]").removeClass("btn-primary").addClass("btn-outline-primary");
			$("#searchDt").removeClass("btn-outline-primary").addClass("btn-primary");
			if(validate()){
				$.ajax({
					url : express_docker+"orders/paymentListDetail",
					type : "POST",
					data : {
						StoreId : "${userVO.storeId}",
						StartDT : $("#startDt").val(),
						EndDT :	$("#endDt").val(),
					},success : function(data){
						if(data.success){
							$("#tableDiv").html(paymentListHtml(data.info));
							$('#dt-basic-example').dataTable({
								responsive: true
							});
						}else{
							$("#tableDiv").html(paymentBasisHtml());
						}
					},
					error : function(){
						alert("err");
					}		
				});
			}
		}
		
		//1-3.[검색] - 주문내역 table html(data = 있음)
		function paymentListHtml(data){
			var html ="";
			var totalPrice = 0;
			var idx = 0;
			html += '<table id="dt-basic-example" class="table table-bordered table-hover table-striped w-100">';
			html += 	'<thead>';
			html += 		'<tr class="text-center" >';
			html += 			'<th>번호</th>';
			html += 			'<th>주문 자</th>';
			html += 			'<th>주문 ID</th>';
			html += 			'<th>메뉴명</th>';
			html += 			'<th>할인 금액</th>';
			html += 			'<th>총 결제 금액</th>';
			html += 			'<th>결제 일</th>';
			html += 			'<th>상태</th>';
			html += 		'</tr>';
			html += 	'</thead>';
			html += 	'<tbody id="paymentList">';
			for(var i = 0; i < data.length; i++){
				idx = data.length-1-i;
				totalPrice += Number(data[idx].TotalPrice);
				
				html += 		'<tr class="text-center" onclick="paymentInfo(\''+data[idx].UserPayId+'\');" data-toggle="modal" data-target="#paymentInfoModal">';
				html += 			'<td>'+(idx+1)+'</td>';
				html += 				'<td>'+data[idx].NickName+'</td>';
				html += 				'<td>'+data[idx].UserPayId+'</td>';
				html += 				'<td>'+data[idx].FirstMenuName;
				if(data[idx].OrderCnt >= 2){				
					html +=     			' 외 '+(data[idx].OrderCnt-1)+'개'; 
				}
				html +=     			'</td>';
				html += 				'<td>-</td>';
				html += 				'<td>'+numberWithCommas(data[idx].TotalPrice)+'원</td>';
				html += 				'<td>'+data[idx].PayCompleteTime+'</td>';
				html += 				'<td>';
				if(data[idx].OrderStatus == 'OC'){
					html += 				'접수 대기';	
				}else if(data[idx].OrderStatus == 'RC'){
					html += 				'접수 완료';	
				}else if(data[idx].OrderStatus == 'PC'){
					html += 				'제조 완료';
				}else if(data[idx].OrderStatus == 'PUC'){
					html += 				'픽업 완료';
				}else if(data[idx].OrderStatus == 'CP'){
					html += 				'주문 취소 요청';
				}else if(data[idx].OrderStatus == 'CUP'){
					html += 				'주문 취소 완료';
				}
				html +=					'</td>';
				html += 			'</tr>';					
				
			}
						
			html +=    '</tbody>';
			html += '</table>';
		    
			$("#totalCount").html("<strong>총 주문 횟수 : </strong> "+data.length+"건");
			$("#totalPrice").html("<strong>총 매출 액 : </strong> "+numberWithCommas(totalPrice)+"원");
			return html;
			
		} 
		
		//1-4.[검색] - 주문내역 table html(data = 없음)
		function paymentBasisHtml(){

			var html ="";
			
			html += '<table id="dt-basic-example" class="table table-bordered table-hover table-striped w-100">';
			html += 	'<thead>';
			html += 		'<tr class="text-center" >';
			html += 			'<th>번호</th>';
			html += 			'<th>주문 자</th>';
			html += 			'<th>주문 ID</th>';
			html += 			'<th>메뉴명</th>';
			html += 			'<th>할인 금액</th>';
			html += 			'<th>총 결제 금액</th>';
			html += 			'<th>결제 일</th>';
			html += 			'<th>상태</th>';
			html += 		'</tr>';
			html += 	'</thead>';
			html += 	'<tbody id="paymentList">';
			html += 		'<tr class="text-center" >';
			html += 			'<td colspan="8"> 데이터가 존재하지 않습니다.</td>';
			html += 		'</tr>';
			html +=    '</tbody>';
			html += '</table>';

			$("#totalCount").html("<strong>총 주문 횟수 : </strong> 0건");
			$("#totalPrice").html("<strong>총 매출 액 : </strong> 0원");
			
			return html;
		} 
		
		//2-1.[주문 내역 상세 정보] - 상세 정보 데이터 출력
		function paymentInfo(id){
			$.ajax({
				url : express_docker+"orders/paymentInfo",
				type : "POST",
				data : {
					UserPayId : id,
				},success : function(data){
					//$("#modal_body").html();
					if(data.success){
						$("#modal_body").html('');
						$("#modal_body").html(paymentInfoHtml(data.info));
					}else{
						$("#modal_body").html('');
					}
				},
			});
		}
		
		//2-2.[주문 내역 상세 정보] - 상세 정보 html 
		function paymentInfoHtml(data){
			var payMentNm = "";
			if(data.PayMethod == "point"){
				payMentNm = "카카오페이";
			}else if(data.PayMethod == "card"){
				payMentNm = "신용카드";
			}else if(data.PayMethod == "samsung"){
				payMentNm = "삼성페이";
			}else if(data.PayMethod == "phone"){
				payMentNm = "핸드폰 소액 결제";
			}
			
			var html = "";
			html += '<ul class="list-group">';
			html += 	'<li class="list-group-item">';
			html += 		'<span><h3><b>주문 번호 : </b>'+data.UserPayId+'</h3></span>';
			html += 		'<span><h3><b>주 문 자 : </b>'+data.NickName+'</h3></span>';
			html += 		'<span><h3><b>결제 완료 : </b>'+data.PayCompleteTime+'</h3></span>';
			html += 		'<span><h3><b>준비 완료 : </b>'+(data.MenuCompleteTime != null ? data.MenuCompleteTime : '-')+'</h3></span>';
			html += 		'<span><h3><b>진행 상태 : </b>';
			if(data.OrderStatus == 'OC'){
				html += 				'접수 대기';	
			}else if(data.OrderStatus == 'RC'){
				html += 				'접수 완료';	
			}else if(data.OrderStatus == 'PC'){
				html += 				'제조 완료';
			}else if(data.OrderStatus == 'PUC'){
				html += 				'픽업 완료';
			}else if(data.OrderStatus == 'CP'){
				html += 				'주문 취소 요청';
			}else if(data.OrderStatus == 'CUP'){
				html += 				'주문 취소 완료';
			}
			html += 		'</h3></span>';
			html += 	'</li>';
			html += '</ul>';
			html += '<br/>';
			html += '<ul class="list-group">';
			html += 	'<li class="list-group-item">';
			html += 		'<span><h3><b>주문 정보</b></h3></span>';
			html += 		'<div class="table-wrap">'
			html += 			'<table class="col-xl-12">';
			html += 				'<tbody>';
			if(data.OrderMenu.length > 0){
				for(var i = 0; i < data.OrderMenu.length; i++){
					html += 				'<tr>';
					html += 					'<td colspan="2"><h4>'+data.OrderMenu[i].MenuName+'</h4></td>';
					html += 				'</tr>';
					html += 				'<tr>';
					//html += 					'<td class="float-left"><h5>'+data.OrderMenu[i].OptionA+'/'+data.OrderMenu[i].OptionB+'/'+data.OrderMenu[i].OptionC+'</h5></td>';
					html += 					'<td class="float-left"><h5>'+(data.OrderMenu[i].OptionA != null && data.OrderMenu[i].OptionA != "" ? data.OrderMenu[i].OptionA+'/' : '') + (data.OrderMenu[i].OptionB != null && data.OrderMenu[i].OptionB != "" ? data.OrderMenu[i].OptionB+'/' : '') + (data.OrderMenu[i].OptionC != null && data.OrderMenu[i].OptionC != "" ? data.OrderMenu[i].OptionC : '')+' '+data.OrderMenu[i].OrderCnt+'개'+'</h5></td>';
					html += 					'<td class="float-right"><h5>'+data.OrderMenu[i].Price+'원</h5></td>';
					html += 				'</tr>';	
				}
			}
			html += 				'</tbody>';
			html += 			'</table>';
			html +=			'</div>';
			html += 		'<div class="float-left">';
			html +=				'<h3><b>총 주문 금액</b></h3>';
			html +=			'</div>';
			html += 		'<div class="float-right">';
			html +=				'<h3>'+data.TotalPrice+'원</h3>';
			html +=			'</div>';
			html += 	'</li>';
			html += '</ul>';
			html += '<br/>';
			html += '<ul class="list-group">';
			html += 	'<li class="list-group-item">';
			html += 		'<span><h3><b>결제 정보</b></h3></span>';
			html += 		'<br>';
			html += 		'<table class="col-xl-12">';
			html += 			'<tbody>';
			html += 				'<tr>';
			html += 					'<td class="float-left"><h4>결제 수단</h4></td>';
			html += 					'<td class="float-right"><h4>'+payMentNm+'</h4></td>';
			html += 				'</tr>';
			html += 				'<tr>';
			html += 					'<td class="float-left"><h4>총 주문 금액</h4></td>';
			html += 					'<td class="float-right"><h4>'+data.TotalPrice+'원</h4></td>';
			html += 				'</tr>';
			html += 			'</tbody>';
			html += 		'</table>';
			html += 	'</li>';
			html += '</ul>';
			
			return html;
		}
		
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
