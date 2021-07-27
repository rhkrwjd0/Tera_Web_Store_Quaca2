<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../../header.jsp" %>
<link rel="stylesheet" media="screen, print" href="${pageContext.request.contextPath}/resources/quaca/css/datagrid/datatables/datatables.bundle.css">
<!-- 메인 영역 -->
<main id="js-page-content" role="main" class="page-content">
	<ol class="breadcrumb page-breadcrumb">
        <li class="breadcrumb-item"><a href="javascript:void(0);">Quaca</a></li>
        <li class="breadcrumb-item">in 고객 관리</li>
        <li class="breadcrumb-item">고객 관리</li>
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
		memberList(); // 고객 목록 호출
	});
	
	//1-1.[고객 목록 호출] - 고객 목록 호출
	function memberList(){
		$.ajax({
			url : express_docker+"users/memberList",
			type : "POST",
			data : {
				StoreId : "${userVO.storeId}",
			},success : function(data){
				if(data.success){
					$("#tableDiv").html(memberListHtml(data.info));
					$('#dt-basic-example').dataTable({
						responsive: true
					});
				}else{
					$("#tableDiv").html(memberListBasisHtml());
				}
			},
			error : function(){
				alert("err");
			}
		})
	}
	
	//1-2.[고객 목록 호출] - 회원 목록 table html (data = 있음)
	function memberListHtml(data){
		var html = "";
		var number = 0;
		
		html += '<table id="dt-basic-example" class="table table-bordered table-hover table-striped w-100">';
		html += 	'<thead>';
		html += 		'<tr class="text-center" >';
		html += 			'<th>번호</th>';
		html += 			'<th>닉네임</th>';
		html += 			'<th>연락처</th>';
		html += 			'<th>총 주문 건수</th>';
		html += 			'<th>마지막 주문일</th>';
		html += 			'<th>등록일</th>';
		html += 		'</tr>';
		html += 	'</thead>';
		html += 	'<tbody>';
		for(var i = 0; i < data.length; i++){
			number++;
			html += 		'<tr class="text-center" onclick="goMemberUpdate(\''+data[i].UserId+'\');">';
			html +=				'<td>'+((data.length+1)-number)+'</td>';
			html +=				'<td>'+data[i].NickName+'</td>';
			html +=				'<td>'+(data[i].TelNo != null ? data[i].TelNo : '-')+'</td>';
			html +=				'<td>'+data[i].TotalOrderCnt+' 건</td>';
			html +=				'<td>'+data[i].lastOrderDt+'</td>';
			html +=				'<td>'+data[i].InsertDt+'</td>';
			html += 		'</tr>';
		}		
		html +=    '</tbody>';
		html += '</table>';
		return html;
	}
	
	//1-3.[고객 목록 호출] - table html (data = 없음)
	function memberListBasisHtml(){
		var html = "";
		
		html += '<table id="dt-basic-example" class="table table-bordered table-hover table-striped w-100">';
		html += 	'<thead>';
		html += 		'<tr class="text-center" >';
		html += 			'<th>번호</th>';
		html += 			'<th>닉네임</th>';
		html += 			'<th>연락처</th>';
		html += 			'<th>총 주문 건수</th>';
		html += 			'<th>마지막 주문일</th>';
		html += 			'<th>등록일</th>';
		html += 		'</tr>';
		html += 	'</thead>';
		html += 	'<tbody>';
		html += 		'<tr class="text-center" >';
		html += 			'<td colspan="6"> 데이터가 존재하지 않습니다.</td>';
		html += 		'</tr>';
		html +=    '</tbody>';
		html += '</table>';
		return html;
	}
	
	//2.[고객 수정 화면 이동] - 고객 수정 화면으로 이동
	function goMemberUpdate(userId){
		var html ="";
		html += '<form id="memberFm" name="memberFm" method="get">';
		html += 	'<input type="hidden" id="userId" name="userId" value="'+userId+'" />'; 
		html +=	'</form>';
		$("#formDiv").html(html);
		
		$('#memberFm').attr({
			action : '/quaca/member/memberInfo',
			method : 'get'
		}).submit();
	}
</script>