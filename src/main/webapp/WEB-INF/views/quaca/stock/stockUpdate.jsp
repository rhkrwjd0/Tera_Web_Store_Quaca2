<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../../header.jsp" %>
<link rel="stylesheet" media="screen, print" href="${pageContext.request.contextPath}/resources/quaca/css/formplugins/bootstrap-datepicker/bootstrap-datepicker.css">
<!-- 메인 영역 -->
<main id="js-page-content" role="main" class="page-content">
	<ol class="breadcrumb page-breadcrumb">
        <li class="breadcrumb-item"><a href="javascript:void(0);">Quaca</a></li>
        <li class="breadcrumb-item">in 재고 관리</li>
        <li class="breadcrumb-item">재고 관리</li>
        <li class="breadcrumb-item active"> 입고 & 출고</li>
        <li class="position-absolute pos-top pos-right d-none d-sm-block"><span class="js-get-date"></span></li>
    </ol>
   	<div class="row">
		<div class="col-xl-12">
			<div id="panel-1" class="panel">
				<div class="panel-container show">
					<div class="panel-content">
			             <ul class="nav nav-pills nav-justified" role="tablist">
			                 <li class="nav-item"><a class="nav-link active" data-toggle="tab" href="#WDiv" data-value="W" onclick="stockInfo('W');">입고</a></li>
			                 <li class="nav-item"><a class="nav-link" data-toggle="tab" href="#SDiv" data-value="S" onclick="stockInfo('S');">출고</a></li>
			             </ul>
			             <div class="tab-content py-3">
			                 <div class="tab-pane fade show active" id="WDiv" role="tabpanel">
			                 </div>
			                 
			                 <div class="tab-pane fade" id="SDiv" role="tabpanel">
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
		$(".panel-hdr").children(".panel-toolbar").remove();
		
		// 탭 active 클래스가 들어간 data-value 값을 데이터 호출에 사용 
		$("a.nav-link").map(function (){
			if($(this).hasClass("active") === true){
				stockInfo($(this).data("value")); // 데이터 호출
			}
		});
	});
			
	//1-1.[입출고 재고 정보 호출] - 재고 정보 호출 
	function stockInfo(type){
		$.ajax({
			url : express_docker+"store/stockInfo",
			type : "POST",
			data : {
				StoreId : "${userVO.storeId}",
				StockCd : "${stockCd}"
			},success : function(data){
				if(data.success){ 
					$("#"+type+"Div").html(stockInfoHtml(type, data.info));
					
					//입출고 데이트 피커
					$('input[name=stockDt]').datepicker({
						todayBtn: "linked",
						clearBtn: true,
						todayHighlight: true,
						orientation: "bottom left",
						templates: controls,
						format: "yyyy-mm-dd",
			            language: "kr"
					});
					
					stockHistoryList(type+"Div",'W', data.info.StockCd);
					
					stockHistoryList(type+"Div",'S', data.info.StockCd);
					
				}else{
					alert("정보를 불러오기 실패 했습니다.");
				}
			},
			error : function(){
				alert("err");
			}		
		});
	}
	
	//1-2.[입출고 재고 정보 호출] - 재고 정보 html 
	function stockInfoHtml(type, data){
		var html = "";
		html += 	'<div class="form-group row">';
		html +=			'<label class="col-form-label col-12 col-lg-2 form-label text-lg-right">품목 명</label>';
		html +=			'<div class="col-12 col-lg-6">';
		html +=				'<div class="input-group">';
		html +=					'<input type="text" class="form-control " id="stockNm" name="stockNm" value="'+data.StockNm+'">';
		html +=					'<input type="hidden" class="form-control " id="stockCd" name="stockCd" value="'+data.StockCd+'">';
		html +=				'</div>';
		html +=			'</div>';
		html +=		'</div>';
		html +=	 	'<div class="form-group row">';
		html +=			'<label class="col-form-label col-12 col-lg-2 form-label text-lg-right">'+(type == 'W' ? '입고' : '출고')+' 수량</label>';
		html +=			'<div class="col-12 col-lg-6">';
		html +=				'<div class="input-group">';
		html +=					'<input type="text" class="form-control " id="stockCnt" name="stockCnt" value="" oninput="this.value=this.value.replace(/[^0-9]/g,\'\');">';
		html +=				'</div>';
		html +=			'</div>';
		html +=		'</div>';
		html +=		'<div class="form-group row">';
		html +=			'<label class="col-form-label col-12 col-lg-2 form-label text-lg-right">'+(type == 'W' ? '입고' : '출고')+' 일자</label>';
		html +=			'<div class="col-12 col-lg-6">';
		html +=				'<div class="input-group">';
		html +=					'<input type="text" class="form-control " id="stockDt" name="stockDt" value="" style="background-color:transparent;" readonly="readonly">';
		html +=					'<div class="input-group-append">';
		html +=						'<span class="input-group-text fs-xl"><i class="fal fa-calendar-alt"></i></span>';
		html +=					'</div>';
		html +=				'</div>';
		html +=			'</div>';
		html +=		'</div>';
		html +=		'<div class="form-group row">';
		html +=			'<label class="col-form-label col-12 col-lg-2 form-label text-lg-right">현재 수량</label>';
		html +=			'<div class="col-12 col-lg-6">';
		html +=				'<div class="input-group">';
		html +=					'<input type="text" class="form-control " id="lastStockCnt" name="lastStockCnt" value="'+data.StockCnt+'" style="background-color:transparent; border: 0px;" readonly="readonly">';
		html +=				'</div>';
		html +=			'</div>';
		html +=		'</div>';
		html +=		'<div class="form-group row">';
		html +=			'<label class="col-form-label col-12 col-lg-2 form-label text-lg-right">최근 입고일</label>';
		html +=			'<div class="col-12 col-lg-6">';
		html +=				'<div class="input-group">';
		html +=					'<input type="text" class="form-control " id="warehousingDt" name="warehousingDt" value="'+data.WarehousingDt+'" style="background-color:transparent; border: 0px;" readonly="readonly">';
		html +=				'</div>';
		html +=			'</div>';
		html +=		'</div>';
		html +=		'<div class="form-group row">';
		html +=			'<label class="col-form-label col-12 col-lg-2 form-label text-lg-right">최근 출고일</label>';
		html +=			'<div class="col-12 col-lg-6">';
		html +=				'<div class="input-group">';
		html +=					'<input type="text" class="form-control " id="shipmentDt" name="shipmentDt" value="'+(data.ShipmentDt != null ? data.ShipmentDt : "")+'" style="background-color:transparent; border: 0px;" readonly="readonly">';
		html +=				'</div>';
		html +=			'</div>';
		html +=		'</div>';
		html +=		'<div class="form-group row">';
		html +=			'<div class="col-12 col-lg-6">';
		html +=			'</div>';
		html +=			'<div class="col-12 col-lg-6">';
		html +=				'<div class="form-row float-right">';
		html +=					'<button class="btn btn-primary" onclick="stockSave(\''+type+'\');">저장하기</button>';
		html +=					'<button class="btn btn-secondary" onclick="goStockList();">돌아가기</button>';
		html +=				'</div>';
		html +=			'</div>';
		html +=		'</div>';
		html +=		'<div class="form-group row">';
		html +=		'</br>';
		html +=		'</div>';
		html +=		'<div id="tableDiv" class ="row">';
		html += 		'<div div class="col-xl-6" id="WTableDiv">';
		html +=			'</div>';
		html += 		'<div div class="col-xl-6" id="STableDiv">';
		html +=			'</div>';
		html +=		'</div>';
		return html;
	}
	
	//1-3.[입출고 재고 정보 호출] - 재고 내역 리스트 
	function stockHistoryList(divId, type, stockCd){
		$.ajax({
			url : express_docker+"store/stockHistoryList",
			type : "POST",
			data : {
				StoreId : "${userVO.storeId}",
				StockCd : stockCd,
				WSType : type,
			},success : function(data){
				$("#"+divId).find("#"+type+"TableDiv").html(stockHistoryHtml(type, data));
			},
			error : function(){
				alert("err");
			}		
		});
	}
	//1-4.[입출고 재고 정보 호출] - 재고 내역(히스토리) table html
	function stockHistoryHtml(type, data){
		var html = "";
		var idx = 0;
		html += 		'<table class="table table-sm">';
		html += 			'<thead class="bg-dark">';
		html += 				'<tr class="text-center" >';
		html += 					'<th class="text-white">번호</th>';
		html += 					'<th class="text-white">'+(type == 'W' ? '입고' : '출고')+' 날짜</th>';
		html += 					'<th class="text-white">'+(type == 'W' ? '입고' : '출고')+' 수량</th>';
		html += 				'</tr>';
		html += 			'</thead>';
		html += 			'<tbody>';
		if(data.success){
			for(var i = 0 ; i < data.info.length; i++){
				idx = data.info.length-1-i;
				html += 				'<tr class="text-center" >';
				html += 					'<td>'+(idx+1)+'</td>';
				html += 					'<td>'+data.info[idx].StockDt+'</td>';
				html += 					'<td>'+data.info[idx].StockCnt+'</td>';
				html += 				'</tr>';
			}
		}else{
			html += 				'<tr class="text-center" >';
			html += 					'<td colspan="3">데이터가 존재하지 않습니다.</td>';
			html += 				'</tr>';
		}
		html += 			'</tbody>';
		html += 		'</table>';
		return html;
	}
	
	//2.[입출고 정보 저장] - 재고 정보 저장
	function stockSave(type){
	
		if(validate(type)){
			$.ajax({
				url : express_docker+"store/stockUpdate",
				type : "POST",
				data : {
					StoreId : "${userVO.storeId}",
					StockCd : $("#"+type+"Div").find("#stockCd").val(),
					StockNm : $("#"+type+"Div").find("#stockNm").val(),
					StockCnt : $("#"+type+"Div").find("#stockCnt").val(),
					WSType : type,
					StockDt : $("#"+type+"Div").find("#stockDt").val()
				},success : function(data){
					if(data.success){
						alert("저장 되었습니다.")
						stockInfo(type);
					}else{
						alert("저장 실패하였습니다.");
					}
				},
				error : function(){
					alert("err");
				}		
			});
		}
	}
	
	// 유효성 체크 
	function validate(type){
		var divId = type+"Div";
		var validateChk = true;
		if($("#"+divId).find("#stockNm").val() == ""){
			validateChk = false;
			alert("품목 명을 입력해 주세요.");
			$("#"+divId).find("#stockNm").focus();
		}else if($("#"+divId).find("#stockCnt").val() == "" || Number($("#"+divId).find("#stockCnt").val()) == 0){
			validateChk = false;
			alert(type == 'W' ? '입고' : '출고'+" 수량을 입력해 주세요.");
			$("#"+divId).find("#stockCnt").focus();
		}else if($("#"+divId).find("#stockDt").val() == ""){
			validateChk = false;
			alert(type == 'W' ? '입고' : '출고'+" 날짜를 입력해 주세요.");
			$("#"+divId).find("#stockDt").focus();
		}else if(type == 'S' && Number($("#"+divId).find("#stockCnt").val()) > Number($("#"+divId).find("#lastStockCnt").val())){
			validateChk = false;
			alert("현재 수량보다 많은 출고 수량을 입력할 수 없습니다.");
			$("#"+divId).find("#stockCnt").focus();
		}else if(type == 'S' && $("#"+divId).find("#shipmentDt").val() != ""){
			var stockDate = new Date($("#"+divId).find("#stockDt").val());
			var shipmentDate = new Date($("#"+divId).find("#shipmentDt").val());
			if(stockDate.getTime() < shipmentDate.getTime()){
				validateChk = false;
				alert("최근 출고일 보다 과거를 입력 할 수 없습니다.");
				$("#"+divId).find("#stockDt").focus();	
			}	
		}else if(type == 'W' && $("#"+divId).find("#warehousingDt").val() != ""){
			var stockDate = new Date($("#"+divId).find("#stockDt").val());
			var warehousingDate = new Date($("#"+divId).find("#warehousingDt").val());
			if(stockDate.getTime() < warehousingDate.getTime()){
				validateChk = false;
				alert("최근 입고일 보다 과거를 입력 할 수 없습니다.");
				$("#"+divId).find("#stockDt").focus();	
			}	
		}
		return validateChk;
	}
	
	// 뒤로 가기 
	function goStockList(){
		location.href="/quaca/stock/stockList";	
	}
	
	
</script>