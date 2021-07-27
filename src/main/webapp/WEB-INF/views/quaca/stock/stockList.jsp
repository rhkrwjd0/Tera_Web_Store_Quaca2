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
<main id="js-page-content" role="main" class="page-content">
	<ol class="breadcrumb page-breadcrumb">
        <li class="breadcrumb-item"><a href="javascript:void(0);">Quaca</a></li>
        <li class="breadcrumb-item">in 재고 관리</li>
        <li class="breadcrumb-item">재고 관리</li>
        <li class="breadcrumb-item active">목록</li>
        <li class="position-absolute pos-top pos-right d-none d-sm-block"><span class="js-get-date"></span></li>
    </ol>
   	<div class="row">
		<div class="col-xl-12">
			<div id="panel-1" class="panel">
				<div class="panel-container show">
					<div class="panel-content">
						<div class="col-xl-12 col-12">
							<div id="tableDiv"></div>
						</div>
						
						<div class="row">
							<div class="col-xl-12">
								<button class="btn btn-primary" data-toggle="modal" data-target="#stockInsertModal">등록하기</button>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- Insert Modal Large -->
	<div class="modal fade" id="stockInsertModal" tabindex="-1" role="dialog" aria-hidden="true">
		<!-- <div class="modal-dialog modal-lg" role="document"> -->
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header center-block">
					<h1 class="modal-title fa-3x"><b>재고 등록</b></h1>								  
				</div>
				<div class="modal-body" id="modal_body">
					<ul class="list-group">
						<li class="list-group-item">
							<div class="form-group row">
								<label class="col-form-label col-12 col-lg-4 form-label text-lg-right">품목 명</label>
								<div class="col-12 col-lg-8">
									<div class="input-group">
										<input type="text" class="form-control " id="stockNm" name="stockNm" value="" placeholder="품목 명">
									</div>
								</div>
							</div>
							<div class="form-group row">
								<label class="col-form-label col-12 col-lg-4 form-label text-lg-right">수량</label>
								<div class="col-12 col-lg-8">
									<div class="input-group">
										<input type="text" class="form-control" id="stockCnt" name="stockCnt" value="" placeholder="수량" oninput="this.value=this.value.replace(/[^0-9]/g,'');">
									</div>
								</div>
							</div>
							<div class="form-group row">
								<label class="col-form-label col-12 col-lg-4 form-label text-lg-right">입고 일</label>
								<div class="col-12 col-lg-8">
									<div class="input-group">
										<input type="text" class="form-control " id="warehousingDt" name="warehousingDt" value="" style="background-color:transparent;" readonly="readonly">
										<div class="input-group-append">
											<span class="input-group-text fs-xl"><i class="fal fa-calendar-alt"></i></span>
										</div>
									</div>
								</div>
							</div>
						</li>
					</ul>		
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-primary" onclick="stockInsert();"> 저장 </button>
					<button type="button" class="btn btn-secondary" data-dismiss="modal" onclick="stockReSet('stockInsertModal');">닫기</button>
				</div>
			</div>
		</div>
	</div>	
	<div id="formDiv"></div>
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
		$(".panel-hdr").children(".panel-toolbar").remove();
		// 재고 목록 호출
		stockList();
		// 입고일 데이트 피커
		$('input[name=warehousingDt]').datepicker({
			todayBtn: "linked",
			clearBtn: true,
			todayHighlight: true,
			orientation: "bottom left",
			templates: controls,
			format: "yyyy-mm-dd",
            language: "kr"
		});
	});
	
	//1-1.[재고 목록 호출] - 재고 관리 목록 호출
	function stockList(){
		$.ajax({
			url : express_docker+"store/stockList",
			type : "POST",
			data : {
				StoreId : "${userVO.storeId}",
			},success : function(data){
				if(data.success){
					$("#tableDiv").html(stockListHtml(data.info));
					$('#dt-basic-example').dataTable({
						responsive: true
					});
				}else{
					$("#tableDiv").html(stockListBasisHtml());
				}
			},
			error : function(){
				alert("err");
			}
		})
	}
	//1-2.[재고 목록 호출] - 재고 목록 table html (data = 있음)
	function stockListHtml(data){
		var html = "";
		var number = 0;
		
		html += '<table id="dt-basic-example" class="table table-bordered table-hover table-striped w-100">';
		html += 	'<thead>';
		html += 		'<tr class="text-center" >';
		html += 			'<th>번호</th>';
		html += 			'<th>품목 명</th>';
		html += 			'<th>수량</th>';
		html += 			'<th>최근 입고일</th>';
		html += 			'<th>최근 출고일</th>';
		html += 			'<th>등록일</th>';
		html += 			'<th>사용여부</th>';
		html += 			'<th>사용 여부 처리 기능</th>';
		html += 		'</tr>';
		html += 	'</thead>';
		html += 	'<tbody>';
		for(var i = 0; i < data.length; i++){
			number++;
			html += 		'<tr class="text-center" onclick="goStockUpdate(\''+data[i].StockCd+'\');">';
			html +=				'<td>'+((data.length+1)-number)+'</td>';
			html +=				'<td>'+data[i].StockNm+'</td>';
			html +=				'<td>'+numberWithCommas(data[i].StockCnt)+'</td>';
			html +=				'<td>'+data[i].WarehousingDt+'</td>';
			html +=				'<td>'+(data[i].ShipmentDt ? data[i].ShipmentDt : "-")+'</td>';
			html +=				'<td>'+data[i].InsertDt+'</td>';
			html +=				'<td>';
			html +=					data[i].UseYn == 'Y' ? "사용중" : "미사용" ;
			html +=				'</td>';
			html +=				'<td onclick="event.cancelBubble=true">';
			html +=					'<div class="custom-control custom-switch">';
			html +=						'<input type="checkbox" class="custom-control-input" onclick="useYnChange(\''+data[i].UseYn+'\',\''+data[i].StockCd+'\')" id="useYnChk'+i+'" ';
			html +=							data[i].UseYn == 'Y' ? "checked" : "" ;
			html +=						'>';
			html +=						'<label class="custom-control-label" for="useYnChk'+i+'"></label>';
			html +=					'</div>';
			html += 			'</td>';
			html += 		'</tr>';
		}		
		html +=    '</tbody>';
		html += '</table>';
		return html;
	}
	//1-3.[재고 목록 호출] - table html (data = 없음)
	function stockListBasisHtml(){
		var html = "";
		
		html += '<table id="dt-basic-example" class="table table-bordered table-hover table-striped w-100">';
		html += 	'<thead>';
		html += 		'<tr class="text-center" >';
		html += 			'<th>번호</th>';
		html += 			'<th>품목 명</th>';
		html += 			'<th>수량</th>';
		html += 			'<th>최근 입고일</th>';
		html += 			'<th>최근 출고일</th>';
		html += 			'<th>사용여부</th>';
		html += 			'<th>등록일</th>';
		html += 		'</tr>';
		html += 	'</thead>';
		html += 	'<tbody>';
		html += 		'<tr class="text-center" >';
		html += 			'<td colspan="7"> 데이터가 존재하지 않습니다.</td>';
		html += 		'</tr>';
		html +=    '</tbody>';
		html += '</table>';
		return html;
	}
	
	//2.[재고 수정 화면 이동] - 재고 수정 화면으로 이동
	function goStockUpdate(stockCd){
		var html ="";
		html += '<form id="stockFm" name="stockFm" method="get">';
		html += 	'<input type="hidden" id="stockCd" name="stockCd" value="'+stockCd+'" />'; 
		html +=	'</form>';
		$("#formDiv").html(html);
		
		$('#stockFm').attr({
			action : '/quaca/stock/stockUpdate',
			method : 'get'
		}).submit();
	} 
	
	//3.[재고 사용 여부] - 사용 여부 기능 처리 
	function useYnChange(useYn, stockCd){
		var useYnChange = "Y"
		if(useYn == 'Y'){
			useYnChange = "N"
		}
		$.ajax({
			url : express_docker+"store/stockUseYn",
			type : "POST",
			data : {
				StoreId : "${userVO.storeId}",
				StockCd : stockCd,
				UseYn : useYnChange
			},success : function(data){
				if(data.success){
					stockList();
				}else{
					alert("등록 실패하였습니다.");
				}
			},
			error : function(){
				alert("err");
			}		
		});
	}
	
	//4.[재고 정보 등록] - 재고 등록
	function stockInsert(){
		if(validate()){
			$.ajax({
				url : express_docker+"store/stockInsert",
				type : "POST",
				data : {
					StoreId : "${userVO.storeId}",
					StockNm : $("#stockInsertModal").find("#stockNm").val(),
					StockCnt : $("#stockInsertModal").find("#stockCnt").val(),
					WarehousingDt : $("#stockInsertModal").find("#warehousingDt").val(),
				},success : function(data){
					if(data.success){
						$("#stockInsertModal").modal("hide");
						stockReSet("stockInsertModal");
						stockList();
					}else{
						alert("등록 실패하였습니다.");
					}
				},
				error : function(){
					alert("err");
				}		
			});
		}
	}
	
	// 유효성 체크 
	function validate(){
		var validateChk = true;
		
		if($("#stockInsertModal").find("#stockNm").val() == ""){
			validateChk = false;
			alert("품목 명을 입력해 주세요.");
			$("#stockInsertModal").find("#stockNm").focus();
		}else if($("#stockInsertModal").find("#stockCnt").val() == ""){
			validateChk = false;
			alert("수량을 입력해 주세요.");
			$("#stockInsertModal").find("#stockCnt").focus();
		}else if($("#stockInsertModal").find("#warehousingDt").val() == ""){
			validateChk = false;
			alert("날짜를 입력해 주세요.");
			$("#stockInsertModal").find("#warehousingDt").focus();
		} 
		return validateChk;
	}
	
	// 모달 초기화 처리 
	function stockReSet(id){
		$("#"+id).find("#stockNm").val("");
		$("#"+id).find("#stockCnt").val("");
		$("#"+id).find("#warehousingDt").val("");
	}
	
	// 콤마 처리
	function numberWithCommas(x) {
	    return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
	}
</script>