<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../../header.jsp" %>
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
        <li class="breadcrumb-item">행사 관리</li>
        <li class="breadcrumb-item active">등록</li>
        <li class="position-absolute pos-top pos-right d-none d-sm-block"><span class="js-get-date"></span></li>
    </ol>
	<div class="row">
		<div class="col-xl-12">		
			<div id="panel-1" class="panel">
				<div class="panel-hdr ">
					<div class="col-xl-12">
						<div class="form-row float-right">
							<button class="btn btn-primary" onclick="eventSave();">저장하기</button>
							<button class="btn btn-secondary" onclick="goEventList();">돌아가기</button>
						</div>	
					</div>
				</div>
				<div class="panel-container show">
					<div class="panel-content">
						<div class="form-group row">
							<label class="col-form-label col-12 col-lg-2 form-label text-lg-right">행사 명</label>
							<div class="col-12 col-lg-6">
								<div class="input-group">
									<input type="text" class="form-control " id="eventNm" name="eventNm" value="">
								</div>
							</div>
						</div>
						<div class="form-group row">
							<label class="col-form-label col-12 col-lg-2 form-label text-lg-right">행사구분</label>
							<div class="col-12 col-lg-6">
								<div class="input-group">
									<select class="form-control " id="eventType" name="eventType" >
										<option value="D">할인</option>
										<option value="F">프리퀀시</option>
									</select>
								</div>
							</div>
						</div>
						<div id="eventTypeDiv" >
						
						</div>
						<div class="form-group row">
							<label class="col-form-label col-12 col-lg-2 form-label text-lg-right">시작일</label>
							<div class="col-12 col-lg-6">
								<div class="input-group">
									<input type="text" class="form-control " id="startDt" name="startDt" value="" style="background-color:transparent;" readonly="readonly">
									<div class="input-group-append">
										<span class="input-group-text fs-xl"><i class="fal fa-calendar-alt"></i></span>
									</div>
								</div>
							</div>
						</div>
						<div class="form-group row">
							<label class="col-form-label col-12 col-lg-2 form-label text-lg-right">종료일</label>
							<div class="col-12 col-lg-6">
								<div class="input-group">
									<input type="text" class="form-control " id="endDt" name="endDt" value="" style="background-color:transparent;" readonly="readonly">
									<div class="input-group-append">
										<span class="input-group-text fs-xl"><i class="fal fa-calendar-alt"></i></span>
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
		
	    // 첫 화면 행사 구분 값이 (D=할인)이면 카테고리 호출  
	 	if($("#eventType option:selected").val() == "D"){
	 		$("#eventTypeDiv").html(discountHtml());
	 		categoryList();
	 	}else{
	 		$("#eventTypeDiv").html(frequencyHtml());
	 	}
		
		//시작일 데이트 피커
		$('input[name=startDt]').datepicker({
			todayBtn: "linked",
			clearBtn: true,
			todayHighlight: true,
			orientation: "bottom left",
			templates: controls,
			format: "yyyy-mm-dd",
            language: "kr"
		});
		//종료일 데이트 피커
		$('input[name=endDt]').datepicker({
			todayBtn: "linked",
			clearBtn: true,
			todayHighlight: true,
			orientation: "bottom left",
			templates: controls,
			format: "yyyy-mm-dd",
            language: "kr"
		});
		// 행사구분 변경 시 메뉴 호출 처리 
		$("#eventType").change(function(){
			if(this.value=="D"){
				$("#eventTypeDiv").html(discountHtml());
				categoryList();
			}else{
				$("#eventTypeDiv").html(frequencyHtml());
			}
		});
	});
	
	//1-1.[행사 구분] - html (D = 할인)
	function discountHtml(){
		var html ="";
		
		html += '<div class="form-group row">';
		html += 	'<label class="col-form-label col-12 col-lg-2 form-label text-lg-right">카테고리 구분</label>';
		html += 	'<div class="col-12 col-lg-6">';
		html += 		'<div class="input-group">';
		html += 			'<select class="form-control " id="cateCd" name="cateCd">';
		html += 			'</select>';
		html += 		'</div>';
		html += 	'</div>';
		html += '</div>';
		html += '<div class="form-group row">';
		html += 	'<label class="col-form-label col-12 col-lg-2 form-label text-lg-right">상품 구분</label>';
		html += 	'<div class="col-12 col-lg-6">';
		html += 		'<div class="input-group">';
		html += 			'<select class="form-control " id="menuId" name="menuId">';
		html += 			'</select>';
		html += 		'</div>';
		html += 	'</div>';
		html += '</div>';
		html += '<div class="form-group row">';
		html += 	'<label class="col-form-label col-12 col-lg-2 form-label text-lg-right">할인 구분</label>';
		html += 	'<div class="col-12 col-lg-6">';
		html += 		'<div class="input-group">';
		html += 			'<label class="col-form-label col-lg-4"><input type="radio" id="saleType1" name="saleType" value="%" checked="checked"/> %</label>';
		html += 			'<label class="col-form-label col-lg-4"><input type="radio" id="saleType2" name="saleType" value="원"/> 원</label>';
		html += 		'</div>';
		html += 	'</div>';
		html += '</div>';
		html += '<div class="form-group row">';
		html += 	'<label class="col-form-label col-12 col-lg-2 form-label text-lg-right">할인 값</label>';
		html += 	'<div class="col-12 col-lg-6">';
		html += 		'<div class="input-group">';
		html += 			'<input type="text" class="form-control " id="saleValue" name="saleValue" value="" oninput="this.value=this.value.replace(/[^0-9]/g,\'\');">';
		html += 		'</div>';
		html += 	'</div>';
		html += '</div></br>';
		
		return html;
	}
	//1-2.[행사 구분] - html (F = 프리퀀시)
	function frequencyHtml(){
		var html = "";
		html += '<div class="form-group row">';
		html += 	'<label class="col-form-label col-12 col-lg-2 form-label text-lg-right">조건A</label>';
		html += 	'<div class="col-12 col-lg-6">';
		html += 		'<div class="input-group">';
		html += 			'<select class="form-control " id="optionA" name="optionA" >';
		html += 				'<option value="">선택택</option>';
		html += 				'<option value="일반음료">일반음료</option>';
		html += 				'<option value="스페셜음료">스페셜음료</option>';
		html += 			'</select>';
		html += 			'<input class="form-control " type="text" id="cntA" name="cntA" value="" placeholder="갯수" oninput="this.value=this.value.replace(/[^0-9]/g,\'\');">';
		html += 		'</div>';
		html += 	'</div>';
		html += '</div>';
		html += '<div class="form-group row">';
		html += 	'<label class="col-form-label col-12 col-lg-2 form-label text-lg-right">조건B</label>';
		html += 	'<div class="col-12 col-lg-6">';
		html += 		'<div class="input-group">';
		html += 			'<select class="form-control " id="optionB" name="optionB" >';
		html += 				'<option value="">선택택</option>';
		html += 				'<option value="일반음료">일반음료</option>';
		html += 				'<option value="스페셜음료">스페셜음료</option>';
		html += 			'</select>';
		html += 			'<input class="form-control " type="text" id="cntB" name="cntB" value="" placeholder="갯수" oninput="this.value=this.value.replace(/[^0-9]/g,\'\');">';
		html += 		'</div>';
		html += 	'</div>';
		html += '</div>';
		html += '<div class="form-group row">';
		html += 	'<label class="col-form-label col-12 col-lg-2 form-label text-lg-right">조건C</label>';
		html += 	'<div class="col-12 col-lg-6">';
		html += 		'<div class="input-group">';
		html += 			'<select class="form-control " id="optionC" name="optionC" >';
		html += 				'<option value="">선택택</option>';
		html += 				'<option value="일반음료">일반음료</option>';
		html += 				'<option value="스페셜음료">스페셜음료</option>';
		html += 			'</select>';
		html += 			'<input class="form-control " type="text" id="cntC" name="cntC" value="" placeholder="갯수" oninput="this.value=this.value.replace(/[^0-9]/g,\'\');">';
		html += 		'</div>';
		html += 	'</div>';
		html += '</div>';
		html += '<div class="form-group row">';
		html += 	'<label class="col-form-label col-12 col-lg-2 form-label text-lg-right">증정</label>';
		html += 	'<div class="col-12 col-lg-6">';
		html += 		'<div class="input-group">';
		html += 			'<input class="form-control " type="text" id="present" name="present" value="" placeholder="증정">';
		html += 		'</div>';
		html += 	'</div>';
		html += '</div></br>';
		return html;
	}
	
	//1-1.[카테고리 목록 호출] - 카테고리 목록 (D = 할인)
	function categoryList(){
		$.ajax({
			url : express_docker+"store/categorymenu",
			type : "POST",
			data : {
				StoreId : "${userVO.storeId}"
			},
			success : function(data){
				if(data.success){
					$("#cateCd").html(categoryOptionHtml(data.info));
					// 메뉴 리스트 호출
					menuList(menuList($("#cateCd option:selected").val()));
				}else{
					alert("카테고리 정보를 불러오기를 실패 하였습니다.");						
				}
			},
			error : function(){
				alert("err");
			}		
		});
	}
	//1-2.[카테고리 목록 호출] - select option(카테고리)
	function categoryOptionHtml(data){
		var html;
		for(var i = 0; i < data.length; i++){
			// 스페셜은 음료에 포함 되어있음
			if(data[i].CateCd != 'S'){
				html += '<option value="'+data[i].CateCd+'">';
				html +=  data[i].CateNm
				html += '</option>';
			}
		}
		return html;
	}
	
	//2-1.[카테고리 목록 호출] - 카테고리 변경시 메뉴 호출
	$("#eventTypeDiv").on('change','#cateCd',function(){
		menuList($(this).val())
	});
	
	//2-2.[카테고리 목록 호출] - 메뉴 목록
	function menuList(cateCd){
		$.ajax({
			url : express_docker+"menu/menulist",
			type : "POST",
			data : {
				StoreId : "${userVO.storeId}"
			},
			success : function(data){
				if(data.success){
					if(cateCd == "D"){
						$("#menuId").html(menuOptionHtml(data.info.drink));
					}else if(cateCd == "B"){
						$("#menuId").html(menuOptionHtml(data.info.bread));
					}else if(cateCd == "G"){
						$("#menuId").html(menuOptionHtml(data.info.goods));
					}
				}else{
					alert("메뉴 정보를 불러오기를 실패 하였습니다.");						
				}
			},
			error : function(){
				alert("err");
			}		
		});
	}
	
	//2-3.[카테고리 목록 호출] - select option(메뉴)
	function menuOptionHtml(data){
		var html;
		for(var i = 0; i < data.length; i++){
			html += '<option value="'+data[i].MenuId+'">';
			html +=  data[i].MenuName
			html += '</option>';
		}
		return html;
	}
	
	//1-1.[행사 정보 등록] - 행사 등록
	function eventSave(){
		
		var eventType = $("#eventType").val();
		var eventNm = $("#eventNm").val();
		var startDt = $("#startDt").val();
		var endDt = $("#endDt").val();
		
		var cateCd = "";
		var menuId = "";
		var saleType = "";
		var saleValue = "";
		if(eventType == "D"){
			cateCd = $("#cateCd option:selected").val();
			menuId = $("#menuId option:selected").val();
			saleType = $('input[name="saleType"]:checked').val();;
			saleValue = $("#saleValue").val();	
		}
		if(validate()){
			$.ajax({
				url : express_docker+"store/eventInsert",
				type : "POST",
				data : {
					StoreId : "${userVO.storeId}",
					EventType : eventType,
					EventNm : eventNm, 
					StartDt : startDt, 
					EndDt : endDt,
					CateCd : cateCd,
					MenuId : menuId,
					SaleType : saleType,
					SaleValue : saleValue,
				},success : function(data){
					if(data.success){
						
						if(eventType == "D"){
							location.href="/quaca/store/eventList";	
						}else{
							// 프리퀀시 옵션 저장 처리 
							frequencySave(data.info.EventCd);
						}
						
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
	//1-2.[행사 정보 등록] - 프리퀀시 옵션 등록 처리 
	function frequencySave(eventCd){
		$.ajax({
			url : express_docker+"store/eventfrequencyInsert",
			type : "POST",
			data : {
				StoreId : "${userVO.storeId}",
				EventCd : eventCd,
				OptionA : $("#optionA").val(), 
				CntA : $("#cntA").val(), 
				OptionB : $("#optionB").val(), 
				CntB : $("#cntB").val(), 
				OptionC : $("#optionC").val(), 
				CntC : $("#cntC").val(),
				Present : $("#present").val(),
			},success : function(data){
				if(data.success){
					location.href="/quaca/store/eventList";	
				}else{
					alert("실패 하였습니다.");
				}
			},error : function(){
				alert("err");
			}
		});
	}
	
	// 유효성 체크 
	function validate(){
		var validateChk = true;
		
		if($("#eventType").val() == "D"){
			if($("#eventNm").val() == ""){
				validateChk = false;
				alert("행사 명을 입력해 주세요.");
				$("#eventNm").focus();
			}else if($("#saleValue").val() == ""){
				validateChk = false;
				alert("할인값을 입력해 주세요.");
				$("#saleValue").focus();
			}else if($("#startDt").val() == ""){
				validateChk = false;
				alert("시작일을 입력해 주세요.");
				$("#startDt").focus();
			}else if($("#endDt").val() == ""){
				validateChk = false;
				alert("종료일을 입력해 주세요.");
				$("#endDt").focus();
			}
		}else if($("#eventType").val() == "F"){
			if($("#eventNm").val() == ""){
				validateChk = false;
				alert("행사 명을 입력해 주세요.");
				$("#eventNm").focus();
			}else if($("#optionA").val() == ""){
				validateChk = false;
				alert("조건 값을 선택해 주세요.");
				$("#optionA").focus();
			}else if($("#optionA").val() != "" && $("#cntA").val() == ""){
				validateChk = false;
				alert("조건에 맞는 갯수를 입력해 주세요.");
				$("#cntA").focus();
			}else if(($("#optionB").val() != "" && $("#cntB").val() == "") || ($("#optionB").val() == "" && $("#cntB").val() != "")){
				validateChk = false;
				alert("조건 선택과 조건에 맞는 갯수를 입력해 주세요.");
				$("#optionB").focus();
			}else if(($("#optionC").val() != "" && $("#cntC").val() == "") || ($("#optionC").val() == "" && $("#cntC").val() != "")){
				validateChk = false;
				alert("조건 선택과 조건에 맞는 갯수를 입력해 주세요.");
				$("#optionC").focus();
			}else if($("#present").val() == ""){
				validateChk = false;
				alert("증정 상품 정보를 입력해 주세요.");
				$("#present").focus();
			}else if($("#startDt").val() == ""){
				validateChk = false;
				alert("시작일을 입력해 주세요.");
				$("#startDt").focus();
			}else if($("#endDt").val() == ""){
				validateChk = false;
				alert("종료일을 입력해 주세요.");
				$("#endDt").focus();
			}
		}
		return validateChk;
	}
	
	// 뒤로 가기 
	function goEventList(){
		location.href="/quaca/store/eventList";	
	}
	
</script>