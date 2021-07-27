<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../../header.jsp" %>
<link rel="stylesheet" media="screen, print" href="${pageContext.request.contextPath}/resources/quaca/css/datagrid/datatables/datatables.bundle.css">
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
        <li class="breadcrumb-item">in 매장 관리</li>
        <li class="breadcrumb-item">카테고리 관리</li>
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
								<button class="btn btn-primary" data-toggle="modal" data-target="#categoryInsertModal">등록하기</button>
							</div>
						</div>
						
						
						<!-- Insert Modal Large -->
						<div class="modal fade" id="categoryInsertModal" tabindex="-1" role="dialog" aria-hidden="true">
							<!-- <div class="modal-dialog modal-lg" role="document"> -->
							<div class="modal-dialog" role="document">
								<div class="modal-content">
									<div class="modal-header center-block">
										<h1 class="modal-title fa-3x"><b>카테고리 등록</b></h1>								  
									</div>
									<div class="modal-body" id="modal_body">
										<ul class="list-group">
											<li class="list-group-item">
												<div class="form-group row">
													<label class="col-form-label col-12 col-lg-4 form-label text-lg-right">카테고리 명</label>
													<div class="col-12 col-lg-8">
														<div class="input-group">
															<input type="text" class="form-control " id="cateNm" name="cateNm" value="">
														</div>
													</div>
												</div>
												<div class="form-group row">
													<label class="col-form-label col-12 col-lg-4 form-label text-lg-right">카테고리 코드</label>
													<div class="col-12 col-lg-8">
														<div class="input-group">
															<input type="text" class="form-control " id="cateCd" name="cateCd" value="">
														</div>
													</div>
												</div>
												<div class="form-group row">
													<label class="col-form-label col-12 col-lg-4 form-label text-lg-right">하위 카테고리 명</label>
													<div class="col-12 col-lg-8">
														<div class="input-group">
															<input type="text" class="form-control " id="midCateNm" name="midCateNm" value="">
														</div>
													</div>
												</div>
												<div class="form-group row">
													<label class="col-form-label col-12 col-lg-4 form-label text-lg-right">하위 카테고리 코드</label>
													<div class="col-12 col-lg-8">
														<div class="input-group">
															<input type="text" class="form-control " id="midCateCd" name="midCateCd" value="">
														</div>
													</div>
												</div>
												<div class="form-group row">
													<label class="col-form-label col-12 col-lg-4 form-label text-lg-right">설명</label>
													<div class="col-12 col-lg-8">
														<div class="input-group">
															<textarea class="form-control " id="cateDetail" name="cateDetail" rows="5"></textarea>
														</div>
													</div>
												</div>
												
											</li>
										</ul>		
									</div>
									<div class="modal-footer">
										<button type="button" class="btn btn-primary" onclick="categoryInsert();"> 저장 </button>
										<button type="button" class="btn btn-secondary" data-dismiss="modal" onclick="categoryReSet('categoryInsertModal');">닫기</button>
									</div>
								</div>
							</div>
						</div>	
						<!-- Update Modal Large -->
						<div class="modal fade" id="categoryUpdateModal" tabindex="-1" role="dialog" aria-hidden="true">
							<!-- <div class="modal-dialog modal-lg" role="document"> -->
							<div class="modal-dialog" role="document">
								<div class="modal-content">
									<div class="modal-header center-block">
										<h1 class="modal-title fa-3x"><b>카테고리 수정</b></h1>								  
									</div>
									<div class="modal-body" id="modal_body">
										<ul class="list-group">
											<li class="list-group-item">
												<div class="form-group row">
													<input type="hidden" id="sid" name="sid" value="">
													<label class="col-form-label col-12 col-lg-4 form-label text-lg-right">카테고리 명</label>
													<div class="col-12 col-lg-8">
														<div class="input-group">
															<input type="text" class="form-control " id="cateNm" name="cateNm" value="">
														</div>
													</div>
												</div>
												<div class="form-group row">
													<label class="col-form-label col-12 col-lg-4 form-label text-lg-right">카테고리 코드</label>
													<div class="col-12 col-lg-8">
														<div class="input-group">
															<input type="text" class="form-control " id="cateCd" name="cateCd" value="" disabled>
														</div>
													</div>
												</div>
												<div class="form-group row">
													<label class="col-form-label col-12 col-lg-4 form-label text-lg-right">하위 카테고리 명</label>
													<div class="col-12 col-lg-8">
														<div class="input-group">
															<input type="text" class="form-control " id="midCateNm" name="midCateNm" value="">
														</div>
													</div>
												</div>
												<div class="form-group row">
													<label class="col-form-label col-12 col-lg-4 form-label text-lg-right">하위 카테고리 코드</label>
													<div class="col-12 col-lg-8">
														<div class="input-group">
															<input type="text" class="form-control " id="midCateCd" name="midCateCd" value="" disabled>
														</div>
													</div>
												</div>
												<div class="form-group row">
													<label class="col-form-label col-12 col-lg-4 form-label text-lg-right">사용 여부</label>
													<div class="col-12 col-lg-8">
														<div class="input-group">
															<label class="col-form-label col-lg-4"><input type="radio" id="useYnY" name="useYn" value="Y" checked="checked"/> 예</label>
															<label class="col-form-label col-lg-4"><input type="radio" id="useYnN" name="useYn" value="N"/> 아니요</label>
														</div>
													</div>
												</div>
												<div class="form-group row">
													<label class="col-form-label col-12 col-lg-4 form-label text-lg-right">설명</label>
													<div class="col-12 col-lg-8">
														<div class="input-group">
															<textarea class="form-control " id="cateDetail" name="cateDetail" rows="5"></textarea>
														</div>
													</div>
												</div>
												
											</li>
										</ul>		
									</div>
									<div class="modal-footer">
										<button type="button" class="btn btn-primary" onclick="categoryUpdate();"> 저장 </button>
										<button type="button" class="btn btn-secondary" data-dismiss="modal" onclick="categoryReSet('categoryUpdateModal');">닫기</button>
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
<script type="text/javascript">

	$(document).ready(function () {
		$(".panel-hdr").children(".panel-toolbar").remove();
		
		// 카테고리 목록 호출
		categoryList();
	});
	
	//1-1.[카데고리 목록 호출] - 카테고리 목록 가져오기
	function categoryList(){
		$.ajax({
			url : express_docker+"store/category",
			type : "POST",
			data : {
				StoreId : "${userVO.storeId}",
				UseYn : ""
			},success : function(data){
				if(data.success){
					$("#tableDiv").html(categoryListHtml(data.info));
					$('#dt-basic-example').dataTable({
						responsive: true
					});
				}else{
					$("#tableDiv").html(categoryBasisHtml());
				}
			},
			error : function(){
				alert("err");
			}		
		});
	}
	//1-2.[카데고리 목록 호출] - 카테고리 목록 table html (data = 있음)
	function categoryListHtml(data){
		var html ="";
		var idx = 0;
		
		html += '<table id="dt-basic-example" class="table table-bordered table-hover table-striped w-100">';
		html += 	'<thead>';
		html += 		'<tr class="text-center" >';
		html += 			'<th>번호</th>';
		html += 			'<th>카테고리 명</th>';
		html += 			'<th>카테고리 코드</th>';
		html += 			'<th>하위 카테고리 명</th>';
		html += 			'<th>하위 카테고리 코드</th>';
		html += 			'<th>설명</th>';
		html += 			'<th>사용 여부</th>';
		html += 			'<th>등록 일</th>';
		html += 		'</tr>';
		html += 	'</thead>';
		html += 	'<tbody id="categoryList">';
		for(var i = 0; i < data.length; i++){
			idx = data.length-1-i;
			html += 		'<tr class="text-center" onclick="categoryInfo(\''+data[idx].SID+'\');" data-toggle="modal" data-target="#categoryUpdateModal">';
			html +=				'<td>'+(idx+1)+'</td>';
			html +=				'<td>'+data[idx].CateNm+'</td>';
			html +=				'<td>'+data[idx].CateCd+'</td>';
			html +=				'<td>';
			html +=					data[idx].MidCateNm ? data[idx].MidCateNm : '-'; 
			html +=				'</td>';
			html +=				'<td>';
			html +=					data[idx].MidCateCd ? data[idx].MidCateCd : '-'; 
			html +=				'</td>';
			html +=				'<td>'+data[idx].CateDetail+'</td>';
			html +=				'<td>';
			html +=				data[idx].UseYn == 'Y' ? "사용 중" : "미 사용" ;
			html +=				'</td>';
			html +=				'<td>'+data[idx].InsertDt+'</td>';
			html += 		'</tr>';	
		}
		html +=    '</tbody>';
		html += '</table>';
		return html;
	}
	
	//1-3.[카데고리 목록 호출] - table html (data = 없음)
	function categoryBasisHtml(){

		var html ="";
		
		html += '<table id="dt-basic-example" class="table table-bordered table-hover table-striped w-100">';
		html += 	'<thead>';
		html += 		'<tr class="text-center" >';
		html += 			'<th>번호</th>';
		html += 			'<th>카테고리 명</th>';
		html += 			'<th>카테고리 코드</th>';
		html += 			'<th>하위 카테고리 명</th>';
		html += 			'<th>하위 카테고리 코드</th>';
		html += 			'<th>설명</th>';
		html += 			'<th>사용 여부</th>';
		html += 			'<th>등록 일</th>';
		html += 		'</tr>';
		html += 	'</thead>';
		html += 	'<tbody id="categoryList">';
		html += 		'<tr class="text-center" >';
		html += 			'<td colspan="8"> 데이터가 존재하지 않습니다.</td>';
		html += 		'</tr>';
		html +=    '</tbody>';
		html += '</table>';
		
		return html;
	} 
	
	//2.[카데고리 상세정보 호출] - 카테고리 정보
	function categoryInfo(sid){
		
		$.ajax({
			url : express_docker+"store/categoryDetail",
			type : "POST",
			data : {
				StoreId : "${userVO.storeId}",
				SID : sid
			},success : function(data){
				if(data.success){
					$("#categoryUpdateModal").find("#sid").val(data.info.SID);
					$("#categoryUpdateModal").find("#cateCd").val(data.info.CateCd);
					$("#categoryUpdateModal").find("#cateNm").val(data.info.CateNm);
					$("#categoryUpdateModal").find("#midCateCd").val(data.info.MidCateCd);
					$("#categoryUpdateModal").find("#midCateNm").val(data.info.MidCateNm);
					$("#categoryUpdateModal").find("#cateDetail").val(data.info.CateDetail);
					
					data.info.UseYn == 'Y' ? $("#categoryUpdateModal").find("#useYnY").prop('checked', true) : $("#categoryUpdateModal").find("#useYnN").prop('checked', true)
				}else{
					alert("정보를 불러오지 못했습니다.");	
				}
			},
			error : function(){
				alert("err");
			}		
		});
	}
	//3.[카데고리 상세정보 수정] - 카테고리 수정
	function categoryUpdate(){
		if(validate('categoryUpdateModal')){
			
			$.ajax({
				url : express_docker+"store/categoryUpdate",
				type : "POST",
				data : {
					StoreId : "${userVO.storeId}",
					CateCd : $("#categoryUpdateModal").find("#cateCd").val(),
					CateNm : $("#categoryUpdateModal").find("#cateNm").val(),
					MidCateCd : $("#categoryUpdateModal").find("#midCateCd").val(),
					MidCateNm : $("#categoryUpdateModal").find("#midCateNm").val(),
					CateDetail : $("#categoryUpdateModal").find("#cateDetail").val(),
					UseYn : $("#categoryUpdateModal").find('input[name="useYn"]:checked').val(),
				},success : function(data){
					if(data.success){
						$("#categoryUpdateModal").modal("hide");
						categoryReSet("categoryUpdateModal");
						categoryList();
					}else{
						alert("수정 실패하였습니다.");
					}
				},
				error : function(){
					alert("err");
				}		
			});
		}
	}
	
	//4.[카데고리 정보 등록] - 카테고리 등록
	function categoryInsert(){
		if(validate('categoryInsertModal')){
			
			$.ajax({
				url : express_docker+"store/categoryInsert",
				type : "POST",
				data : {
					StoreId : "${userVO.storeId}",
					CateCd : $("#categoryInsertModal").find("#cateCd").val(),
					CateNm : $("#categoryInsertModal").find("#cateNm").val(),
					MidCateCd : $("#categoryInsertModal").find("#midCateCd").val(),
					MidCateNm : $("#categoryInsertModal").find("#midCateNm").val(),
					CateDetail : $("#categoryInsertModal").find("#cateDetail").val(),	
				},success : function(data){
					if(data.success){
						$("#categoryInsertModal").modal("hide");
						categoryReSet("categoryInsertModal");
						categoryList();
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
	function validate(id){
		var validateChk = true;
		
		if($("#"+id).find("#cateNm").val() == ""){
			validateChk = false;
			alert("카테고리 명을 입력해 주세요.");
			$("#"+id).find("#cateNm").focus();
		}else if($("#"+id).find("#cateCd").val() == ""){
			validateChk = false;
			alert("카테고리 코드를 입력해 주세요.");
			$("#"+id).find("#cateCd").focus();
		}
		return validateChk;
	}
	
	// 모달 초기화 처리 
	function categoryReSet(id){
		$("#"+id).find("#cateCd").val("");
		$("#"+id).find("#cateNm").val("");
		$("#"+id).find("#midCateCd").val("");
		$("#"+id).find("#midCateNm").val("");
		$("#"+id).find("#cateDetail").val("");	
	}
	
	
	
</script>