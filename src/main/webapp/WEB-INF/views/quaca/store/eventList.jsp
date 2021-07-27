<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../../header.jsp" %>
<link rel="stylesheet" media="screen, print" href="${pageContext.request.contextPath}/resources/quaca/css/datagrid/datatables/datatables.bundle.css">
<!-- 메인 영역 -->
<main id="js-page-content" role="main" class="page-content">
	<ol class="breadcrumb page-breadcrumb">
        <li class="breadcrumb-item"><a href="javascript:void(0);">Quaca</a></li>
        <li class="breadcrumb-item">in 매장 관리</li>
        <li class="breadcrumb-item">행사 관리</li>
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
								<button class="btn btn-primary" onclick="goEventInsert();">등록하기</button>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<div id="formDiv"></div>
</main>
<!-- !!메인 영역 -->
<%@ include file="../../footer.jsp" %>
<script src="${pageContext.request.contextPath}/resources/quaca/js/datagrid/datatables/datatables.bundle.custom.js"></script>
<script type="text/javascript">
	
	$(document).ready(function () {
		$(".panel-hdr").children(".panel-toolbar").remove();
		// 행사 목록 호출
		eventList();
	});
	
	//1-1.[행사 목록 호출] - 행사 목록 가져오기 
	function eventList(){
		$.ajax({
			url : express_docker+"store/eventList",
			type : "POST",
			data : {
				StoreId : "${userVO.storeId}",
			},success : function(data){
				if(data.success){
					$("#tableDiv").html(eventListHtml(data.info));
					$('#dt-basic-example').dataTable({
						responsive: true
					});
				}else{
					$("#tableDiv").html(eventListBasisHtml());
				}
			},
			error : function(){
				alert("err");
			}
		})
	}
	
	//1-2.[행사 목록 호출] - 행사 목록 table html(data = 있음)
	function eventListHtml(data){
		var html = "";
		var number = 0;
		
		html += '<table id="dt-basic-example" class="table table-bordered table-hover table-striped w-100">';
		html += 	'<thead>';
		html += 		'<tr class="text-center" >';
		html += 			'<th>번호</th>';
		html += 			'<th>행사 구분</th>';
		html += 			'<th>행사명</th>';
		html += 			'<th>할인정보</th>';
		html += 			'<th>시작일</th>';
		html += 			'<th>종료일</th>';
		html += 			'<th>사용여부</th>';
		html += 			'<th>등록일</th>';
		html += 		'</tr>';
		html += 	'</thead>';
		html += 	'<tbody id="eventList">';
		for(var i = 0; i < data.length; i++){
			number++;
			html += 		'<tr class="text-center" onclick="goEventUpdate(\''+data[i].EventCd+'\');">';
			html +=				'<td>'+((data.length+1)-number)+'</td>';
			html +=				'<td>';
			html +=					data[i].EventType == 'F' ? "프리퀀시" : "할인" ;
			html +=				'</td>';
			html +=				'<td>'+data[i].EventNm+'</td>';
			html +=				'<td>';
			html +=					data[i].EventType == 'F' ? "-" :numberWithCommas(data[i].SaleValue)+" "+data[i].SaleType ;
			html +=				'</td>';
			html +=				'<td>'+data[i].StartDt+'</td>';
			html +=				'<td>'+data[i].EndDt+'</td>';
			html +=				'<td>';
			html +=					data[i].UseYn == 'Y' ? "사용중" : "미사용" ;
			html +=				'</td>';
			html +=				'<td>'+data[i].InsertDt+'</td>';
			html += 		'</tr>';
		}		
		html +=    '</tbody>';
		html += '</table>';
		return html;
	}
	//1-3.[행사 목록 호출] - table html (data = 없음)
	function eventListBasisHtml(){
		var html = "";
		
		html += '<table id="dt-basic-example" class="table table-bordered table-hover table-striped w-100">';
		html += 	'<thead>';
		html += 		'<tr class="text-center" >';
		html += 			'<th>번호</th>';
		html += 			'<th>행사 구분</th>';
		html += 			'<th>행사명</th>';
		html += 			'<th>할인정보</th>';
		html += 			'<th>시작일</th>';
		html += 			'<th>종료일</th>';
		html += 			'<th>사용여부</th>';
		html += 			'<th>등록일</th>';
		html += 		'</tr>';
		html += 	'</thead>';
		html += 	'<tbody id="eventList">';
		html += 		'<tr class="text-center" >';
		html += 			'<td colspan="8"> 데이터가 존재하지 않습니다.</td>';
		html += 		'</tr>';
		html +=    '</tbody>';
		html += '</table>';
		return html;
	}
	
	//2.[행사 수정 화면 이동] - 행사 수정 화면으로 이동
	function goEventUpdate(eventCd){
		var html ="";
		html += '<form id="eventFm" name="eventFm" method="get">';
		html += 	'<input type="hidden" id="eventCd" name="eventCd" value="'+eventCd+'" />'; 
		html +=	'</form>';
		$("#formDiv").html(html);
		
		$('#eventFm').attr({
			action : '/quaca/store/eventUpdate',
			method : 'get'
		}).submit();
	}
	
	//3.[행사 등록 화면 이동] - 행사 등록 화면으로 이동
	function goEventInsert(){
		location.href="/quaca/store/eventInsert";	
	}
	
	// 콤마 처리
	function numberWithCommas(x) {
	    return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
	}
</script>