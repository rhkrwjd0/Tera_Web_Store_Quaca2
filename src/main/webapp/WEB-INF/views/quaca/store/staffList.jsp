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
        <li class="breadcrumb-item">in 매장 관리</li>
        <li class="breadcrumb-item">직원 관리</li>
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
								<button class="btn btn-primary" data-toggle="modal" data-target="#staffInsertModal">등록하기</button>
							</div>
						</div>
						
						<!-- Insert Modal Large -->
						<div class="modal fade" id="staffInsertModal" tabindex="-1" role="dialog" aria-hidden="true">
							<!-- <div class="modal-dialog modal-lg" role="document"> -->
							<div class="modal-dialog" role="document">
								<div class="modal-content">
									<div class="modal-header center-block">
										<h1 class="modal-title fa-3x"><b>직원 등록</b></h1>								  
									</div>
									<div class="modal-body" id="modal_body">
										<ul class="list-group">
											<li class="list-group-item">
												<div class="form-group row">
													<label class="col-form-label col-12 col-lg-2 form-label text-lg-right">직급</label>
													<div class="col-12 col-lg-8">
														<div class="input-group">
															<select id="classCd" name="classCd" class="form-control">
																<option value="M">매니저</option>
																<option value="E">직원</option>
															</select>
														</div>
													</div>
												</div>
												<div class="form-group row">
													<label class="col-form-label col-12 col-lg-2 form-label text-lg-right">직원명</label>
													<div class="col-12 col-lg-8">
														<div class="input-group">
															<input type="text" class="form-control " id="employeeNm" name="employeeNm" value="">
														</div>
													</div>
												</div>
												<div class="form-group row">
													<label class="col-form-label col-12 col-lg-2 form-label text-lg-right">연락처</label>
													<div class="col-12 col-lg-8">
														<div class="input-group">
															<input type="text" class="form-control " id="phoneNum" name="phoneNum" value="">
														</div>
													</div>
												</div>
												<div class="form-group row">
													<label class="col-form-label col-12 col-lg-2 form-label text-lg-right">입사일</label>
													<div class="col-12 col-lg-8">
														<div class="input-group">
															<input type="text" class="form-control " id="startDt" name="startDt" value="" style="background-color:transparent;" readonly="readonly">
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
										<button type="button" class="btn btn-primary" onclick="staffInsert();"> 저장 </button>
										<button type="button" class="btn btn-secondary" data-dismiss="modal" onclick="staffInfoReSet('staffInsertModal');">닫기</button>
									</div>
								</div>
							</div>
						</div>	
						<!-- Update Modal Large -->
						<div class="modal fade" id="staffUpdateModal" tabindex="-1" role="dialog" aria-hidden="true">
							<!-- <div class="modal-dialog modal-lg" role="document"> -->
							<div class="modal-dialog" role="document">
								<div class="modal-content">
									<div class="modal-header center-block">
										<h1 class="modal-title fa-3x"><b>직원 등록</b></h1>								  
									</div>
									<div class="modal-body" id="modal_body">
										<ul class="list-group">
											<li class="list-group-item">
												<div class="form-group row">
													<label class="col-form-label col-12 col-lg-3 form-label text-lg-right">직급</label>
													<div class="col-12 col-lg-8">
														<div class="input-group">
															<select id="classCd" name="classCd" class="form-control">
																<option value="M">매니저</option>
																<option value="E">직원</option>
															</select>
														</div>
													</div>
												</div>
												<div class="form-group row">
													<label class="col-form-label col-12 col-lg-3 form-label text-lg-right">직원명</label>
													<div class="col-12 col-lg-8">
														<div class="input-group">
															<input type="text" class="form-control " id="employeeNm" name="employeeNm" value="">
															<input type="hidden" class="form-control " id="employeeCd" name="employeeCd" value="">
														</div>
													</div>
												</div>
												<div class="form-group row">
													<label class="col-form-label col-12 col-lg-3 form-label text-lg-right">연락처</label>
													<div class="col-12 col-lg-8">
														<div class="input-group">
															<input type="text" class="form-control " id="phoneNum" name="phoneNum" value="">
														</div>
													</div>
												</div>
												<div class="form-group row">
													<label class="col-form-label col-12 col-lg-3 form-label text-lg-right">입사일</label>
													<div class="col-12 col-lg-8">
														<div class="input-group">
															<input type="text" class="form-control " id="startDt" name="startDt" value="" style="background-color:transparent;" readonly="readonly">
															<div class="input-group-append">
																<span class="input-group-text fs-xl"><i class="fal fa-calendar-alt"></i></span>
															</div>
														</div>
													</div>
												</div>
												<div class="form-group row">
													<label class="col-form-label col-12 col-lg-3 form-label text-lg-right">퇴사일</label>
													<div class="col-12 col-lg-8">
														<div class="input-group">
															<input type="text" class="form-control " id="endDt" name="endDt" value="" style="background-color:transparent;" readonly="readonly">
															<div class="input-group-append">
																<span class="input-group-text fs-xl"><i class="fal fa-calendar-alt"></i></span>
															</div>
														</div>
													</div>
												</div>
												<div class="form-group row">
													<label class="col-form-label col-12 col-lg-3 form-label text-lg-right">근무여부</label>
													<div class="col-12 col-lg-8">
														<div class="input-group">
															<label class="col-form-label col-lg-4"><input type="radio" id="useYnY" name="useYn" value="Y" checked="checked"/>재직</label>
															<label class="col-form-label col-lg-4"><input type="radio" id="useYnN" name="useYn" value="N"/> 퇴사</label>
														</div>
													</div>
												</div>
											</li>
										</ul>		
									</div>
									<div class="modal-footer">
										<button type="button" class="btn btn-primary" onclick="staffUpdate();"> 저장 </button>
										<button type="button" class="btn btn-secondary" data-dismiss="modal" onclick="staffInfoReSet('staffUpdateModal');">닫기</button>
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
		$(".panel-hdr").children(".panel-toolbar").remove();
		// 직원 목록 호출
		staffList();
		
		//입사일 데이트 피커
		$('input[name=startDt]').datepicker({
			todayBtn: "linked",
			clearBtn: true,
			todayHighlight: true,
			orientation: "bottom left",
			templates: controls,
			format: "yyyy-mm-dd",
            language: "kr"
		});
		//퇴사일 데이트 피커
		$('input[name=endDt]').datepicker({
			todayBtn: "linked",
			clearBtn: true,
			todayHighlight: true,
			orientation: "bottom left",
			templates: controls,
			format: "yyyy-mm-dd",
            language: "kr"
		});
		
	});
	
	//1-1.[직원 목록 호출] - 직원 목록 가져오기 
	function staffList(){
		$.ajax({
			url : express_docker+"store/staffList",
			type : "POST",
			data : {
				StoreId : "${userVO.storeId}",
			},success : function(data){
				if(data.success){
					$("#tableDiv").html(staffListHtml(data.info));
					$('#dt-basic-example').dataTable({
						responsive: true
					});
				}else{
					$("#tableDiv").html(staffListBasisHtml());
				}
			},
			error : function(){
				alert("err");
			}
		})
	}
	//1-2.[직원 목록 호출] - 직원 목록 table html(data = 있음)
	function staffListHtml(data){
		var html = "";
		var idx = 0;
		
		html += '<table id="dt-basic-example" class="table table-bordered table-hover table-striped w-100">';
		html += 	'<thead>';
		html += 		'<tr class="text-center" >';
		html += 			'<th>번호</th>';
		html += 			'<th>계급</th>';
		html += 			'<th>성함</th>';
		html += 			'<th>연락처</th>';
		html += 			'<th>입사일</th>';
		html += 			'<th>퇴사일</th>';
		html += 			'<th>근무여부</th>';
		html += 		'</tr>';
		html += 	'</thead>';
		html += 	'<tbody id="staffList">';
		for(var i = 0; i < data.length; i++){
			idx = data.length-1-i;
			html += 		'<tr class="text-center" onclick="staffInfo(\''+data[idx].EmployeeCd+'\');" data-toggle="modal" data-target="#staffUpdateModal">';
			html +=				'<td>'+(idx+1)+'</td>';
			html +=				'<td>'+data[idx].ClassNm+'</td>';
			html +=				'<td>'+data[idx].EmployeeNm+'</td>';
			html +=				'<td>'+data[idx].PhoneNum+'</td>';
			html +=				'<td>'+data[idx].StartDt+'</td>';
			html +=				'<td>';
			html +=					data[idx].EndDt ? data[idx].EndDt : "-" ;
			html +=				'</td>';
			html +=				'<td>';
			html +=					data[idx].UseYn == 'Y' ? "재직" : "퇴사" ;
			html +=				'</td>';
			html += 		'</tr>';
		}		
		html +=    '</tbody>';
		html += '</table>';
		return html;
	}
	//1-3.[직원 목록 호출] - table html(data = 없음)
	function staffListBasisHtml(){
		var html = "";
		
		html += '<table id="dt-basic-example" class="table table-bordered table-hover table-striped w-100">';
		html += 	'<thead>';
		html += 		'<tr class="text-center" >';
		html += 			'<th>번호</th>';
		html += 			'<th>계급</th>';
		html += 			'<th>성함</th>';
		html += 			'<th>연락처</th>';
		html += 			'<th>입사일</th>';
		html += 			'<th>퇴사일</th>';
		html += 			'<th>근무여부</th>';
		html += 		'</tr>';
		html += 	'</thead>';
		html += 	'<tbody id="staffList">';
		html += 		'<tr class="text-center" >';
		html += 			'<td colspan="7"> 데이터가 존재하지 않습니다.</td>';
		html += 		'</tr>';
		html +=    '</tbody>';
		html += '</table>';
		return html;
	}
	
	//2.[직원 상세정보 호출] - 직원 정보
	function staffInfo(employeeCd){
		
		$.ajax({
			url : express_docker+"store/staffListDetail",
			type : "POST",
			data : {
				StoreId : "${userVO.storeId}",
				EmployeeCd : employeeCd
			},success : function(data){
				if(data.success){
					$("#staffUpdateModal").find("#employeeCd").val(data.info.EmployeeCd);
					$("#staffUpdateModal").find("#employeeNm").val(data.info.EmployeeNm);
					$("#staffUpdateModal").find("#phoneNum").val(data.info.PhoneNum);
					$("#staffUpdateModal").find("#startDt").val(data.info.StartDt);
					$("#staffUpdateModal").find("#endDt").val(data.info.EndDt);
					$("#staffUpdateModal").find("#endDt").val(data.info.EndDt);
					$("#staffUpdateModal").find("#classCd").val(data.info.ClassCd).prop("selected", true);
					data.info.UseYn == 'Y' ? $("#staffUpdateModal").find("#useYnY").prop('checked', true) : $("#staffUpdateModal").find("#useYnN").prop('checked', true)
					
				}else{
					alert("정보를 불러오지 못했습니다.");
				}
			},
			error : function(){
				alert("err");
			}		
		});
	}
	
	//3.[직원 상세정보 수정] - 직원 수정
	function staffUpdate(){
		if(validate("staffUpdateModal")){
			
			$.ajax({
				url : express_docker+"store/staffUpdate",
				type : "POST",
				data : {
					StoreId : "${userVO.storeId}",
					ClassCd : $("#staffUpdateModal").find("#classCd option:selected").val(),
					ClassNm : $("#staffUpdateModal").find("#classCd option:selected").text(),
					EmployeeCd : $("#staffUpdateModal").find("#employeeCd").val(),
					EmployeeNm : $("#staffUpdateModal").find("#employeeNm").val(),
					PhoneNum : $("#staffUpdateModal").find("#phoneNum").val(),
					UseYn : $("#staffUpdateModal").find('input[name="useYn"]:checked').val(),
					StartDt : $("#staffUpdateModal").find("#startDt").val(),
					EndDt : $("#staffUpdateModal").find("#endDt").val(),
				},success : function(data){
					if(data.success){
						$("#staffUpdateModal").modal("hide");
						staffInfoReSet("staffUpdateModal");
						staffList();
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
	
	
	//4.[직원 정보 등록] - 직원 등록
	function staffInsert(){
		if(validate("staffInsertModal")){
			$.ajax({
				url : express_docker+"store/staffInsert",
				type : "POST",
				data : {
					StoreId : "${userVO.storeId}",
					ClassCd : $("#staffInsertModal").find("#classCd option:selected").val(),
					ClassNm : $("#staffInsertModal").find("#classCd option:selected").text(),
					EmployeeNm : $("#staffInsertModal").find("#employeeNm").val(),
					PhoneNum : $("#staffInsertModal").find("#phoneNum").val(),
					StartDt : $("#staffInsertModal").find("#startDt").val(),
				},success : function(data){
					if(data.success){
						$("#staffInsertModal").modal("hide");
						staffInfoReSet("staffInsertModal");
						staffList();
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
		
		if($("#"+id).find("#employeeNm").val() == ""){
			validateChk = false;
			alert("직원 명을 입력해 주세요.");
			$("#"+id).find("#employeeNm").focus();
		}else if($("#"+id).find("#phoneNum").val() == ""){
			validateChk = false;
			alert("연락처를 입력해 주세요.");
			$("#"+id).find("#phoneNum").focus();
		}else if($("#"+id).find("#startDt").val() == ""){
			validateChk = false;
			alert("입사일을 입력해 주세요.");
			$("#"+id).find("#startDt").focus();
		}
		return validateChk;
	}
	
	// 모달 창 정보 리셋
	function staffInfoReSet(id){
		$("#"+id).find("#employeeNm").val("");
		$("#"+id).find("#phoneNum").val("");
		$("#"+id).find("#startDt").val("");
		$("#"+id).find("#endDt").val("");
	}
</script>