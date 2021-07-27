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
        <li class="breadcrumb-item">in 게시판</li>
        <li class="breadcrumb-item">1:1 문의내역</li>
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
						

						
						<!-- Insert Modal Large -->
						<div class="modal fade" id="boardInsertModal" tabindex="-1" role="dialog" aria-hidden="true">
							<!-- <div class="modal-dialog modal-lg" role="document"> -->
							<div class="modal-dialog modal-lg" role="document">
								<div class="modal-content">
									<div class="modal-header center-block">
										<h1 class="modal-title fa-3x"><b>1:1 문의내역 등록</b></h1>								  
									</div>
									<div class="modal-body" id="modal_body">
										<ul class="list-group">
											<li class="list-group-item">
												<div class="form-group row">
													<label class="col-form-label col-12 col-lg-2 form-label text-lg-right">제목</label>
													<div class="col-12 col-lg-10">
														<div class="input-group">
															<input type="text" class="form-control " id="title" name="title" value="">
														</div>
													</div>
												</div>
												<div class="form-group row">
													<label class="col-form-label col-12 col-lg-2 form-label text-lg-right">작성자</label>
													<div class="col-12 col-lg-10">
														<div class="input-group">
															<input type="text" class="form-control " id="insertNm" name="insertNm" value="">
														</div>
													</div>
												</div>
												<div class="form-group row">
													<label class="col-form-label col-12 col-lg-2 form-label text-lg-right">내용</label>
													<div class="col-12 col-lg-10">
														<div class="input-group">
															<textarea class="form-control " id="contents" name="contents" rows="10"></textarea>
														</div>
													</div>
												</div>
												
											</li>
										</ul>		
									</div>
									<div class="modal-footer">
										<button type="button" class="btn btn-primary" onclick="boardInsert();"> 저장 </button>
										<button type="button" class="btn btn-secondary" data-dismiss="modal" onclick="boardReSet('boardInsertModal');">닫기</button>
									</div>
								</div>
							</div>
						</div>	
						<!-- Update Modal Large -->
						<div class="modal fade" id="boardUpdateModal" tabindex="-1" role="dialog" aria-hidden="true">
							<!-- <div class="modal-dialog modal-lg" role="document"> -->
							<div class="modal-dialog modal-lg" role="document">
								<div class="modal-content">
									<div class="modal-header center-block">
										<h1 class="modal-title fa-3x"><b>1:1 문의내역</b></h1>								  
									</div>
									<div class="modal-body" id="modal_body">
										<ul class="list-group">
											<li class="list-group-item">
												<div class="form-group row">
													<label class="col-form-label col-12 col-lg-2 form-label text-lg-right">제목</label>
													<div class="col-12 col-lg-10">
														<div class="input-group">
															<input type="text" class="form-control " id="title" name="title" value="" disabled="disabled" style="background-color: white;">
															<input type="hidden" id="sid" name="sid" value="">
														</div>
													</div>
												</div>
												<div class="form-group row">
													<label class="col-form-label col-12 col-lg-2 form-label text-lg-right">작성자</label>
													<div class="col-12 col-lg-10">
														<div class="input-group">
															<input type="text" class="form-control " id="insertNm" name="insertNm" value="" disabled="disabled" style="background-color: white;">
														</div>
													</div>
												</div>
												<div class="form-group row">
													<label class="col-form-label col-12 col-lg-2 form-label text-lg-right">문의 내용</label>
													<div class="col-12 col-lg-10">
														<div class="input-group">
															<textarea class="form-control " id="contents" name="contents" rows="5" disabled="disabled" style="background-color: white;"></textarea>
														</div>
													</div>
												</div>
												<div class="form-group row">
													<label class="col-form-label col-12 col-lg-2 form-label text-lg-right">답변자</label>
													<div class="col-12 col-lg-10">
														<div class="input-group">
															<input type="text" class="form-control " id="updateNm" name="updateNm" value="">
														</div>
													</div>
												</div>
												<div class="form-group row">
													<label class="col-form-label col-12 col-lg-2 form-label text-lg-right">답변 내용</label>
													<div class="col-12 col-lg-10">
														<div class="input-group">
															<textarea class="form-control " id="reContents" name="reContents" rows="10"></textarea>
														</div>
													</div>
												</div>
												<div class="form-group row">
													<label class="col-form-label col-12 col-lg-2 form-label text-lg-right">사용여부</label>
													<div class="col-12 col-lg-10">
														<div class="input-group">
															<label class="col-form-label col-lg-4"><input type="radio" id="useYnY" name="useYn" value="Y"/>사용</label>
															<label class="col-form-label col-lg-4"><input type="radio" id="useYnN" name="useYn" value="N"/> 미사용</label>
														</div>
													</div>
												</div>
											</li>
										</ul>		
									</div>
									<div class="modal-footer">
										<button type="button" class="btn btn-primary" onclick="boardUpdate();"> 저장 </button>
										<button type="button" class="btn btn-secondary" data-dismiss="modal" onclick="boardReSet('boardUpdateModal');">닫기</button>
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
       	boardList(); // 게시판 목록 호출
	});
	
	//1-1.[게시판 목록 호출] - 1:1 문의내역 목록 가져오기
	function boardList(){
		$.ajax({
			url : express_docker+"notice/suggestlist",
			type : "POST",
			data : {
				StoreId : "${userVO.storeId}",
				Title : ""
			},success : function(data){
				if(data.success){
					$("#tableDiv").html(boardListHtml(data.info));
					$('#dt-basic-example').dataTable({
						responsive: true
					});
				}else{
					$("#tableDiv").html(boardListBasisHtml());
				}
			},
			error : function(){
				alert("err");
			}		
		});
	}
	//1-2.[게시판 목록 호출] - 1:1 문의내역 목록 table html (data = true)
	function boardListHtml(data){
		var number = 0;
		var html ="";
		
		html += '<table id="dt-basic-example" class="table table-bordered table-hover table-striped w-100">';
		html += 	'<thead>';
		html += 		'<tr class="text-center" >';
		html += 			'<th>번호</th>';
		html += 			'<th>제목</th>';
		html += 			'<th>작성자</th>';
		html += 			'<th>작성일</th>';
		html += 			'<th>답변자</th>';
		html += 			'<th>답변일</th>';
		html += 		'</tr>';
		html += 	'</thead>';
		html += 	'<tbody>';
		for(var i = 0; i < data.length; i++){
			number++;
			html += 		'<tr class="text-center" onclick="boardInfo(\''+data[i].SID+'\');" data-toggle="modal" data-target="#boardUpdateModal">';
			html +=				'<td>'+((data.length+1)-number)+'</td>';
			html +=				'<td>'+data[i].Title+'</td>';
			html +=				'<td>'+(data[i].InsertNm != null && data[i].InsertNm != "" ? data[i].InsertNm : "-")+'</td>';
			html +=				'<td>'+(data[i].InsertDt != null && data[i].InsertDt != "" ? data[i].InsertDt : "-")+'</td>';
			html +=				'<td>'+(data[i].UpdateNm != null && data[i].UpdateNm != "" ? data[i].UpdateNm : "-")+'</td>';
			html +=				'<td>'+(data[i].UpdateDt != null && data[i].UpdateDt != "" ? data[i].UpdateDt : "-")+'</td>';
			html += 		'</tr>';	
		}
		html +=    '</tbody>';
		html += '</table>';
		return html;
	}
	//1-3.[게시판 목록 호출] - table html (data = false)
	function boardListBasisHtml(){

		var html ="";
		
		html += '<table id="dt-basic-example" class="table table-bordered table-hover table-striped w-100">';
		html += 	'<thead>';
		html += 		'<tr class="text-center" >';
		html += 			'<th>번호</th>';
		html += 			'<th>제목</th>';
		html += 			'<th>등록자</th>';
		html += 			'<th>등록일</th>';
		html += 			'<th>답변자</th>';
		html += 			'<th>답변일</th>';
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
	
	//2.[게시판 상세정보 호출] - 1:1 문의내역 정보 호춣 
	function boardInfo(sid){
		$.ajax({
			url : express_docker+"notice/suggestselect",
			type : "POST",
			data : {
				StoreId : "${userVO.storeId}",
				SID : sid
			},success : function(data){
				if(data.success){
					$("#boardUpdateModal").find("#sid").val(data.info.SID);
					$("#boardUpdateModal").find("#title").val(data.info.Title);
					$("#boardUpdateModal").find("#contents").val(data.info.Contents);
					$("#boardUpdateModal").find("#insertNm").val(data.info.InsertNm);
					$("#boardUpdateModal").find("#reContents").val(data.info.ReContents);
					$("#boardUpdateModal").find("#updateNm").val(data.info.UpdateNm);
					data.info.UseYn == 'Y' ? $("#boardUpdateModal").find("#useYnY").prop('checked', true) : $("#boardUpdateModal").find("#useYnN").prop('checked', true);
				}else{
					alert("정보를 불러오지 못했습니다.");	
				}
			},
			error : function(){
				alert("err");
			}		
		});
	}
	
	//3.[게시판 상세정보 수정] - 1:1 문의내역 정보 수정 
	function boardUpdate(){
		if(validate('boardUpdateModal')){
			$.ajax({
				url : express_docker+"notice/suggestupdate",
				type : "POST",
				data : {
					StoreId : "${userVO.storeId}",
					SID : $("#boardUpdateModal").find("#sid").val(),
					ReContents : $("#boardUpdateModal").find("#reContents").val(),
					UpdateNm : $("#boardUpdateModal").find("#updateNm").val(),
					UseYn : $("#boardUpdateModal").find('input[name="useYn"]:checked').val()
				},success : function(data){
					if(data.success){
						alert("수정 되었습니다.");
						$("#boardUpdateModal").modal("hide");
						boardReSet("boardUpdateModal");
						boardList();
					}else{
						alert("수정 실패 했습니다.");
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
		
		if($("#"+id).find("#reContents").val() == ""){
			validateChk = false;
			alert("답변을 입력해 주세요.");
			$("#"+id).find("#reContents").focus();	
		}else if($("#"+id).find("#updateNm").val() == ""){
			validateChk = false;
			alert("답변자을 입력해 주세요.");
			$("#"+id).find("#updateNm").focus();
		}
		return validateChk;
	}
	
	
	// 모달 초기화 처리 
	function boardReSet(id){
		$("#"+id).find("#updateNm").val("");
		$("#"+id).find("#reContents").val("");
	}
	
</script>