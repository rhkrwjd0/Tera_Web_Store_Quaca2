<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../../header.jsp" %>
<link rel="stylesheet" media="screen, print" href="${pageContext.request.contextPath}/resources/quaca/css/datagrid/datatables/datatables.bundle.css">
<!-- 메인 영역 -->
<main id="js-page-content" role="main" class="page-content">
	<ol class="breadcrumb page-breadcrumb">
        <li class="breadcrumb-item"><a href="javascript:void(0);">Quaca</a></li>
        <li class="breadcrumb-item">in 고객 관리</li>
        <li class="breadcrumb-item">고객 관리</li>
        <li class="breadcrumb-item active">고객 정보</li>
        <li class="position-absolute pos-top pos-right d-none d-sm-block"><span class="js-get-date"></span></li>
    </ol>
     <div class="row">
		<div class="col-xl-12">
			<div id="panel-1" class="panel">
				<div class="panel-container show">
					<div class="panel-content">
			             <ul class="nav nav-pills nav-justified" role="tablist">
			                 <li class="nav-item"><a class="nav-link active" data-toggle="tab" href="#memberInfoDiv" onclick="memberInfo();">회원 정보</a></li>
			                 <li class="nav-item"><a class="nav-link" data-toggle="tab" href="#memberOrderListDiv" onclick="memberOrderList();">주문 내역</a></li>
			                 <li class="nav-item"><a class="nav-link" data-toggle="tab" href="#memberPreCardListDiv" onclick="memberPreCardList();">선불카드 내역</a></li>
			                 <li class="nav-item"><a class="nav-link" data-toggle="tab" href="#memberCouponDiv" onclick="memberCouponList();">쿠폰 내역</a></li>
			             </ul>
			             <div class="tab-content py-3">
			                 <div class="tab-pane fade show active" id="memberInfoDiv" name="tabDiv" role="tabpanel">
			                 </div>
			                 <div class="tab-pane fade" id="memberOrderListDiv" name="tabDiv" role="tabpanel">
			                 </div>
			                 <div class="tab-pane fade" id="memberPreCardListDiv" name="tabDiv" role="tabpanel">
			                 </div>
			                 <div class="tab-pane fade" id="memberCouponDiv" name="tabDiv" role="tabpanel">
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
<script type="text/javascript">

	$(document).ready(function () {
		$(".panel-hdr").children(".panel-toolbar").remove();
		
    	memberInfo();			// 회원 정보 호출
    	memberOrderList();		// 회원 주문 내역 호출
    	memberPreCardList();	// 회원 선불카드 내역 호출
    	memberCouponList();		// 회원 쿠폰 내역 호출
	});
	
	//1-1.[고객 정보 호출] - 고객 정보 호출
	function memberInfo(){
		$.ajax({
			url : express_docker+"users/memberinfo",
			type : "POST",
			data : {
				StoreId : "${userVO.storeId}",
				UserId : "${userId}"
			},success : function(data){
				if(data.success){ 
					$("#memberInfoDiv").html(memberInfoHtml(data.info));
				}else{
					alert("정보를 불러오기 실패 했습니다.");
				}
			},
			error : function(){
				alert("err");
			}		
		});
	}
	
	//1-2.[고객 정보 호출] - 회원 정보 html 
	function memberInfoHtml(data){
		var html ="";
		html += '<div class="form-group row">';
		html += 	'<label class="col-form-label col-12 col-lg-2 form-label text-lg-right">닉네임</label>';
		html += 	'<div class="col-12 col-lg-6">';
		html += 		'<div class="input-group">';
		html += 			'<input type="text" class="form-control " id="nickName" name="nickName" value="'+data.NickName+'">';
		html += 			'<input type="hidden" class="form-control " id="userId" name="userId" value="'+data.UserId+'">';
		html += 		'</div>';
		html += 	'</div>';
		html += '</div>';
		html += '<div class="form-group row">';
		html += 	'<label class="col-form-label col-12 col-lg-2 form-label text-lg-right">연락처</label>';
		html += 	'<div class="col-12 col-lg-6">';
		html += 		'<div class="input-group">';
		html += 			'<input type="text" class="form-control " id="telNo" name="telNo" value="'+(data.TelNo != null ? data.TelNo : '')+'">';
		html += 		'</div>';
		html += 	'</div>';
		html += '</div>';
		html += '<div class="form-group row">';
		html += 	'<label class="col-form-label col-12 col-lg-2 form-label text-lg-right">가입일</label>';
		html += 	'<div class="col-12 col-lg-6">';
		html += 		'<div class="input-group">';
		html += 			'<input type="text" class="form-control " id="insertDt" name="insertDt" value="'+data.InsertDt+'" style="background-color:transparent; border: 0px;" readonly="readonly">';
		html += 		'</div>';
		html += 	'</div>';
		html += '</div>';
		html += '<div class="form-group row">';
		html += 	'<label class="col-form-label col-12 col-lg-2 form-label text-lg-right">마지막 주문일</label>';
		html += 	'<div class="col-12 col-lg-6">';
		html += 		'<div class="input-group">';
		html += 			'<input type="text" class="form-control " id="lastOrderDt" name="lastOrderDt" value="'+data.lastOrderDt+'" style="background-color:transparent; border: 0px;" readonly="readonly">';
		html += 		'</div>';
		html += 	'</div>';
		html += '</div>';
		html += '<div class="form-group row">';
		html += 	'<label class="col-form-label col-12 col-lg-2 form-label text-lg-right">총 주문 건수</label>';
		html += 	'<div class="col-12 col-lg-6">';
		html += 		'<div class="input-group">';
		html += 			'<input type="text" class="form-control " id="totalOrderCnt" name="totalOrderCnt" value="'+data.TotalOrderCnt+'건" style="background-color:transparent; border: 0px;" readonly="readonly">';
		html += 		'</div>';
		html += 	'</div>';
		html += '</div>';
		html += '<div class="form-group row">';
		html += 	'<label class="col-form-label col-12 col-lg-2 form-label text-lg-right">선불카드 잔액</label>';
		html += 	'<div class="col-12 col-lg-6">';
		html += 		'<div class="input-group">';
		html += 			'<input type="text" class="form-control " id="card" name="card" value="0원" style="background-color:transparent; border: 0px;" readonly="readonly">';
		html += 		'</div>';
		html += 	'</div>';
		html += '</div>';
		html +=	'<div class="form-group row">';
		html +=		'<div class="col-12 col-lg-6">';
		html +=		'</div>';
		html +=		'<div class="col-12 col-lg-6">';
		html +=			'<div class="form-row float-right">';
		html +=				'<button class="btn btn-primary" onclick="memberInfoSave();">저장하기</button>';
		html +=				'<button class="btn btn-secondary" onclick="goMemberList();">돌아가기</button>';
		html +=			'</div>';
		html +=		'</div>';
		html +=	'</div>';
		return html;
	}
	//2.[고객 정보 수정] 고객 정보 저장
	function memberInfoSave(){
		if(validate()){
			$.ajax({
				url : express_docker+"users/memberUpdate",
				type : "POST",
				data : {
					UserId : $("#memberInfoDiv").find("#userId").val(),
					NickName : $("#memberInfoDiv").find("#nickName").val(),
					TelNo : $("#memberInfoDiv").find("#telNo").val(),
				},success : function(data){
					if(data.success){ 
						alert("정보가 변경 되었습니다.");
						memberInfo();
					}else{
						alert("정보를 불러오기 실패 했습니다.");
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
		
		if($("#nickName").val() == ""){
			validateChk = false;
			alert("닉네임을 입력해 주세요.");
			$("#nickName").focus();
		}
		return validateChk
	}			
	
	//2-1.[고객 주문&선불카드&쿠폰 내역 호출] - 회원 주문 내역 호출
	function memberOrderList(){
		$.ajax({
			url : express_docker+"users/memberOrderList",
			type : "POST",
			data : {
				StoreId : "${userVO.storeId}",
				UserId : "${userId}"
			},success : function(data){
				if(data.success){
					$("#memberOrderListDiv").html(memberListHtml(data.info, "orderList"));
					$('#dt-basic-example-orderList').dataTable({
						responsive: true
					});
				}else{
					$("#memberOrderListDiv").html(memberListBasisHtml("orderList"));
				}
			},
			error : function(){
				alert("err");
			}		
		});
	}
	//2-2.[고객 주문&선불카드&쿠폰 내역 호출] - 회원 쿠폰 호출
	function memberCouponList(){
		$.ajax({
			url : express_docker+"users/CouponList",
			type : "POST",
			data : {
				StoreId : "${userVO.storeId}",
				UserId : "${userId}"
			},success : function(data){
				if(data.success){
					$("#memberCouponDiv").html(memberListHtml(data.info, "couponList"));
					$('#dt-basic-example-couponList').dataTable({
						responsive: true
					});
				}else{
					$("#memberCouponDiv").html(memberListBasisHtml("couponList"));
				}
			},
			error : function(){
				alert("err");
			}		
		});
	}
	
	//2-3.[고객 주문&선불카드&쿠폰 내역 호출] - 회원 선불 카드 호출
	function memberPreCardList(){
		$.ajax({
			url : express_docker+"users/PreCardInfo",
			type : "POST",
			data : {
				StoreId : "${userVO.storeId}",
				UserId : "${userId}"
			},success : function(data){
				if(data.success){
					$("#memberPreCardListDiv").html(memberListHtml(data.info, "preCardList"));
					$('#dt-basic-example-preCardList').dataTable({
						responsive: true
					});
				}else{
					$("#memberPreCardListDiv").html(memberListBasisHtml("preCardList"));
				}
			},
			error : function(){
				alert("err");
			}		
		});
	}
	
	//2-4.[고객 주문&선불카드&쿠폰 내역 호출] - 회원 (주문, 선불카드, 쿠폰)내역 목록 table html (data = 있음)
	function memberListHtml(data, type){
		var html = "";
		var number = 0;
		html += '<table id="dt-basic-example-'+type+'" class="table table-bordered table-hover table-striped w-100">';
		html += 	'<thead>';
		html += 		'<tr class="text-center" >';
		if(type == 'orderList'){
			html += 			'<th>번호</th>';
			html += 			'<th>메뉴 명</th>';
			html += 			'<th>총 결제 금액</th>';
			html += 			'<th>결제 일</th>';
			html += 			'<th>상태</th>';
		}else if(type == 'preCardList'){
			html += 			'<th>번호</th>';
			html += 			'<th>카드 구분</th>';
			html += 			'<th>카드 명</th>';
			html += 			'<th>결제 구분</th>';
			html += 			'<th>결제 금액</th>';
			html += 			'<th>잔액</th>';
			html += 			'<th>등록 일</th>';
			html += 			'<th>수정 일</th>';
		}else if(type == 'couponList'){
			html += 			'<th>번호</th>';
			html += 			'<th>쿠폰 명</th>';
			html += 			'<th>쿠폰 내용</th>';
			html += 			'<th>사용 가능한 기간</th>';
			html += 			'<th>상태</th>';
			html += 			'<th>사용 일시</th>';
		}
		html += 		'</tr>';
		html += 	'</thead>';
		html += 	'<tbody>';
		if(type == 'orderList'){
			for(var i = 0; i < data.length; i++){
				number++;
				html += 		'<tr class="text-center" >';
				html +=				'<td>'+((data.length+1)-number)+'</td>';
				html +=				'<td>'+data[i].FirstMenuName+'</td>';
				html +=				'<td>'+numberWithCommas(data[i].TotalPrice)+'</td>';
				html +=				'<td>'+data[i].PayCompleteTime+'</td>';
				html +=				'<td>';
				if(data[i].OrderStatus == 'OC'){
					html += 				'접수 대기';	
				}else if(data[i].OrderStatus == 'RC'){
					html += 				'접수 완료';	
				}else if(data[i].OrderStatus == 'PC'){
					html += 				'제조 완료';
				}else if(data[i].OrderStatus == 'PUC'){
					html += 				'픽업 완료';
				}
				html +=				'</td>';
				html += 		'</tr>';
			}
		}else if(type == 'preCardList'){
			for(var i = 0; i < data.length; i++){
				number++;
				html += 		'<tr class="text-center" >';
				html +=				'<td>'+((data.length+1)-number)+'</td>';
				html +=				'<td>'+data[i].CardCode+'</td>';
				html +=				'<td>'+data[i].CardNum+'</td>';
				html +=				'<td>'+data[i].PayMethod+'</td>';
				html +=				'<td>'+numberWithCommas(data[i].UseAmount)+'원</td>';
				html +=				'<td>'+numberWithCommas(data[i].ReAmount)+'원</td>';
				html +=				'<td>'+(data[i].InsertDt != null ? data[i].InsertDt : '-')+'</td>';
				html +=				'<td>'+(data[i].UpdateDt != null ? data[i].UpdateDt : '-')+'</td>';
				html += 		'</tr>';
			}	
		}else if(type == 'couponList'){
			for(var i = 0; i < data.length; i++){
				number++;
				html += 		'<tr class="text-center" >';
				html +=				'<td>'+((data.length+1)-number)+'</td>';
				html +=				'<td>'+data[i].Title+'</td>';
				html +=				'<td>'+data[i].Contents+'</td>';
				html +=				'<td>'+data[i].StartEndDate+'</td>';
				html +=				'<td>'+(data[i].Used == 'Y' ? '사용' : '미사용') +'</td>';
				html +=				'<td>'+(data[i].UseDate != null ? data[i].UseDate : '-')+'</td>';
				html += 		'</tr>';
			}	
		}
		html +=    '</tbody>';
		html += '</table>';
		return html;
	}
	
	
	//2-5.[고객 주문&선불카드&쿠폰 내역 호출] - table html(data == 없음)
	function memberListBasisHtml(type){
		var html = "";
		html += '<table id="dt-basic-example" class="table table-bordered table-hover table-striped w-100">';
		html += 	'<thead>';
		html += 		'<tr class="text-center" >';
		if(type == 'orderList'){
			html += 			'<th>번호</th>';
			html += 			'<th>메뉴 명</th>';
			html += 			'<th>총 결제 금액</th>';
			html += 			'<th>결제 일</th>';
			html += 			'<th>상태</th>';
		}else if(type == 'preCardList'){
			html += 			'<th>번호</th>';
			html += 			'<th>카드 구분</th>';
			html += 			'<th>카드 명</th>';
			html += 			'<th>결제 구분</th>';
			html += 			'<th>결제 금액</th>';
			html += 			'<th>잔액</th>';
			html += 			'<th>등록 일</th>';
			html += 			'<th>수정 일</th>';
		}else if(type == 'couponList'){
			html += 			'<th>번호</th>';
			html += 			'<th>쿠폰 명</th>';
			html += 			'<th>쿠폰 내용</th>';
			html += 			'<th>사용 가능한 기간</th>';
			html += 			'<th>상태</th>';
			html += 			'<th>사용 일시</th>';
		}
		html += 		'</tr>';
		html += 	'</thead>';
		html += 	'<tbody>';
		html += 		'<tr class="text-center" >';
		if(type == 'orderList'){
			html += 			'<td colspan="5"> 데이터가 존재하지 않습니다.</td>';
		}else if(type == 'preCardList'){
			html += 			'<td colspan="8"> 데이터가 존재하지 않습니다.</td>';
		}else if(type == 'couponList'){
			html += 			'<td colspan="6"> 데이터가 존재하지 않습니다.</td>';
		}
		html += 		'</tr>';
		html +=    '</tbody>';
		html += '</table>';
		return html;
	}
	
	// 뒤로 가기 
	function goMemberList(){
		location.href="/quaca/member/memberList";	
	}
	// 콤마 처리
	function numberWithCommas(x) {
	    return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
	}
</script>