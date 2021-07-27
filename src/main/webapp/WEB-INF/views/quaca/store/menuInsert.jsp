<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../../header.jsp" %>

<!-- 메인 영역 -->
<main id="js-page-content" role="main" class="page-content">
	<ol class="breadcrumb page-breadcrumb">
        <li class="breadcrumb-item"><a href="javascript:void(0);">Quaca</a></li>
        <li class="breadcrumb-item">in 매장 관리</li>
        <li class="breadcrumb-item">상품 관리</li>
        <li class="breadcrumb-item active">등록</li>
        <li class="position-absolute pos-top pos-right d-none d-sm-block"><span class="js-get-date"></span></li>
    </ol>
    <div class="row">
		<div class="col-xl-12">		
			<div id="panel-1" class="panel">
				<div class="panel-hdr ">
					<div class="col-xl-12">
						<div class="form-row float-right">
							<button class="btn btn-primary" onclick="menuSave();">저장하기</button>
							<button class="btn btn-secondary" onclick="goMenuList();">돌아가기</button>
						</div>	
					</div>
				</div>
				<div class="panel-container show">
					<div class="panel-content">
						<div class="form-group row">
							<label class="col-form-label col-12 col-lg-2 form-label text-lg-right">카테고리</label>
							<div class="col-12 col-lg-6">
								<div class="input-group">
									<select class="form-control " id="largeDivCd" name="largeDivCd">
									</select>
								</div>
							</div>
						</div>
						<div class="form-group row" id="midDivCdDiv">
							<label class="col-form-label col-12 col-lg-2 form-label text-lg-right">하위 카테고리</label>
							<div class="col-12 col-lg-6">
								<div class="input-group">
									<select class="form-control " id="midDivCd" name="midDivCd" >
									</select>
								</div>
							</div>
						</div>
						<div class="form-group row">
							<label class="col-form-label col-12 col-lg-2 form-label text-lg-right">상품 명</label>
							<div class="col-12 col-lg-6">
								<div class="input-group">
									<input type="text" class="form-control " id="menuName" name="menuName" value="">
								</div>
							</div>
						</div>
						<div class="form-group row">
							<label class="col-form-label col-12 col-lg-2 form-label text-lg-right">가격</label>
							<div class="col-12 col-lg-6">
								<div class="input-group">
									<input type="text" class="form-control " id="price" name="price" value="" oninput="this.value=this.value.replace(/[^0-9]/g,'');">
								</div>
							</div>
						</div>
						<!-- 이미지 별도 저장 처리 하기 위한 form 210603-->
						<form id="fileForm" class="form-group row" enctype="multipart/form-data" method="post">
							<label class="col-form-label col-12 col-lg-2 form-label text-lg-right">상품 이미지</label>
							<div class="col-12 col-lg-6">
								<div class="input-group">
									<input type="file" class="form-control" id="file" name="file" value="" accept="image/gif, image/jpeg, image/png" required style="border: 0px; padding: .5rem 0">
									<input type="hidden" id="type" name="type" value="M">
									<input type="hidden" id="storeId" name="storeId" value="${userVO.storeId}">
									<span class="img-require">이미지의 최대 크기는 100*100(px)이며, 배경이 투명한 png 파일을 권장합니다.</span>
								</div>
							</div>
						</form>
						<!-- 이미지 별도 저장 처리 하기 위한 form -->
						<div id="optionDiv">						
						</div>
						<div class="form-group row">
							<label class="col-form-label col-12 col-lg-2 form-label text-lg-right">추천 여부</label>
							<div class="col-12 col-lg-6">
								<div class="input-group">
									<label class="col-form-label col-lg-4"><input type="radio" id="bestY" name="best" value="Y" checked="checked"/> 예</label>
									<label class="col-form-label col-lg-4"><input type="radio" id="bestN" name="best" value="N"/> 아니요</label>
								</div>
							</div>
						</div>
						<div class="form-group row">
							<label class="col-form-label col-12 col-lg-2 form-label text-lg-right">사용 여부</label>
							<div class="col-12 col-lg-6">
								<div class="input-group">
									<label class="col-form-label col-lg-4"><input type="radio" id="useYnY" name="useYn" value="Y" checked="checked"/> 예</label>
									<label class="col-form-label col-lg-4"><input type="radio" id="useYnN" name="useYn" value="N"/> 아니요</label>
								</div>
							</div>
						</div>
						<div class="form-group row">
							<label class="col-form-label col-12 col-lg-2 form-label text-lg-right">상품 설명</label>
							<div class="col-12 col-lg-6">
								<div class="input-group">
									<textarea class="form-control " id="contents" name="contents" rows="5"></textarea>
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
<script type="text/javascript">
		
		$(document).ready(function () {
			$(".panel-hdr").children(".panel-toolbar").remove();
			
			categoryList();	// 카테고리 목록 호출
			
			// 카테고리 change event(하위 카테고리 & 카테고리별 옵션)
			$("#largeDivCd").change(function(){
				
				if(this.value != 'D'){
					$("#midDivCd").children().remove();
					$("#midDivCdDiv").hide();
				}else{
					$("#midDivCdDiv").show();
					 midDivCdList(this.value)
				}
				
				categoryOption(this.value);
			});
			
		});
		
		//1-1. [카테고리별 설정 처리] - 카테고리 목록(상품 전용)
		function categoryList(){
			$.ajax({
				url : express_docker+"store/categorymenu",
				type : "POST",
				data : {
					StoreId : "${userVO.storeId}",
					UseYn : 'Y'
				},
				success : function(data){
					if(data.success){
						$("#largeDivCd").html(largeDivOptionHtml(data.info));
						 
						if($("#largeDivCd option:selected").val() != 'D'){
							$("#midDivCd").children().remove();
							$("#midDivCdDiv").hide();
						}else{
							$("#midDivCdDiv").show();
							 midDivCdList($("#largeDivCd option:selected").val())
						}
						// 카테고리별 옵션 
						categoryOption($("#largeDivCd option:selected").val());
						
					}else{
						alert("카테고리 정보를 불러오기를 실패 하였습니다.");						
					}
				},
				error : function(){
					alert("err");
				}		
			});
		}
		
		//1-2. [카테고리별 설정 처리] -  select option html(카테고리)
		function largeDivOptionHtml(data){
			var html;
			for(var i = 0; i < data.length; i++){
				html += '<option value="'+data[i].CateCd+'">';
				html +=  data[i].CateNm
				html += '</option>';
			}
			return html;
		}
		
		//2. [카테고리별 설정 처리] -  하위 카테고리 
		function midDivCdList(cateCd){
			$.ajax({
				url : express_docker+"store/categorymid",
				type : "POST",
				data : {
					StoreId : "${userVO.storeId}",
					CateCd : cateCd
				},
				success : function(data){
					if(data.success){
						$("#midDivCdDiv").show();
						$("#midDivCd").html(midDivOptionHtml(data.info));
					}else{
					}
				},
				error : function(){
					alert("err");
				}		
			});
		}
		
		//2-1. [카테고리별 설정 처리] -  select option html (하위 카테고리)
		function midDivOptionHtml(data){
			var html;
			for(var i = 0; i < data.length; i++){
				html += '<option value="'+data[i].MidCateCd+'">';
				html +=  data[i].MidCateNm
				html += '</option>';
			}
			return html;
		}
		
		//3. [카테고리별 설정 처리] - 각 카테고리별 옵션 항목 호출
		function categoryOption(largeDivCd){
			var cateCd = largeDivCd;
			if(cateCd == "S"){
				cateCd = "D"
			}
			$.ajax({
				url : express_docker+"menu/menuOption",
				type : "POST",
				data : {
					StoreId : "${userVO.storeId}",
					LargeDivCd : cateCd,
				},
				success : function(data){
					if(data.success){
						$("#optionDiv").html(categoryOptionhtml(largeDivCd, data.info));
					}else{
					}
				},
				error : function(){
					alert("err");
				}		
			});
		}
		
		//4. [카테고리별 설정 처리] - 카테고리에 따른 특정 옵션 처리 (D:음료, B:베이커리, G:굿즈) 
		function categoryOptionhtml(cateCd, data){
			var html = "";
			
			if(cateCd == "D" || cateCd == "S"){
				html += '<div class="form-group row" id="OptionADiv">';
				html +=		'<label class="col-form-label col-12 col-lg-2 form-label text-lg-right" id="optionALabel">온도</label>';
				html += 	'<div class="col-12 col-lg-6">';
				html += 		'<div class="input-group" id="optionAChk">';
				for(var i = 0; i < data.length; i++){
					if(data[i].GroupCode == "OptionA"){
						html += 			'<label class="col-form-label col-lg-4"><input type="checkbox" id="optionA'+i+'" name="optionA" value="'+data[i].MenuName+'"/>'+data[i].MenuName+'</label>';
					}
				}
				html += 		'</div>';
				html += 	'</div>';
				html += '</div>';
				html += '<div class="form-group row" id="OptionBDiv">';
				html += 	'<label class="col-form-label col-12 col-lg-2 form-label text-lg-right" id="optionBLabel">사이즈</label>';
				html += 	'<div class="col-12 col-lg-6">';
				html += 		'<div class="input-group" id="optionBChk">';
				for(var i = 0; i < data.length; i++){
					if(data[i].GroupCode == "OptionB"){
						html += 			'<label class="col-form-label col-lg-4"><input type="checkbox" id="optionB'+i+'" name="optionB" value="'+data[i].MenuName+'"/>'+data[i].MenuName+'</label>';
					}
				}
				html += 		'</div>';
				html += 	'</div>';
				html += '</div>';
				html += '<div class="form-group row" id="OptionCDiv">';
				html += 	'<label class="col-form-label col-12 col-lg-2 form-label text-lg-right" id="optionCLabel">컵</label>';
				html += 	'<div class="col-12 col-lg-6">';
				html += 		'<div class="input-group" id="optionCChk">';
				for(var i = 0; i < data.length; i++){
					if(data[i].GroupCode == "OptionC"){
						html += 			'<label class="col-form-label col-lg-4"><input type="checkbox" id="optionC'+i+'" name="optionC" value="'+data[i].MenuName+'"/>'+data[i].MenuName+'</label>';
					}
				}
				html += 		'</div>';
				html += 	'</div>';
				html += '</div>';
			}else if(cateCd == "B"){
				html += '<div class="form-group row" id="OptionADiv">';
				html +=		'<label class="col-form-label col-12 col-lg-2 form-label text-lg-right" id="optionALabel">온도</label>';
				html += 	'<div class="col-12 col-lg-6">';
				html += 		'<div class="input-group" id="optionAChk">';
				for(var i = 0; i < data.length; i++){
					if(data[i].GroupCode == "OptionA"){
						html += 			'<label class="col-form-label col-lg-4"><input type="checkbox" id="optionA'+i+'" name="optionA" value="'+data[i].MenuName+'"/>'+data[i].MenuName+'</label>';
					}
				}
				html += 		'</div>';
				html += 	'</div>';
				html += '</div>';
				html += '<div class="form-group row" id="OptionCDiv">';
				html += 	'<label class="col-form-label col-12 col-lg-2 form-label text-lg-right" id="optionCLabel">포장</label>';
				html += 	'<div class="col-12 col-lg-6">';
				html += 		'<div class="input-group" id="optionCChk">';
				for(var i = 0; i < data.length; i++){
					if(data[i].GroupCode == "OptionC"){
						html += 			'<label class="col-form-label col-lg-4"><input type="checkbox" id="optionC'+i+'" name="optionC" value="'+data[i].MenuName+'"/>'+data[i].MenuName+'</label>';
					}
				}
				html += 		'</div>';
				html += 	'</div>';
				html += '</div>';
			}else if(cateCd == "G"){
				html += '<div class="form-group row" id="OptionCDiv">';
				html += 	'<label class="col-form-label col-12 col-lg-2 form-label text-lg-right" id="optionCLabel">포장</label>';
				html += 	'<div class="col-12 col-lg-6">';
				html += 		'<div class="input-group" id="optionCChk">';
				for(var i = 0; i < data.length; i++){
					if(data[i].GroupCode == "OptionC"){
						html += 			'<label class="col-form-label col-lg-4"><input type="checkbox" id="optionC'+i+'" name="optionC" value="'+data[i].MenuName+'"/>'+data[i].MenuName+'</label>';
					}
				}
				html += 		'</div>';
				html += 	'</div>';
				html += '</div>';
			}
			
			return html;
		}
		
		// 1-1.[상품 등록] - 상품 정보 저장(등록)
		function menuSave(){
			var largeDivCd = $("#largeDivCd").val();						// 카테고리 코드
			var midDivCd = $("#midDivCd").val();							// 하위 카테고리 코드
			var menuName = $("#menuName").val();							// 상품 명
			var price = $("#price").val();									// 가격
			var imgUrl = $("#imgUrl").val();								// 상품 이미지
			var best = $('input[name="best"]:checked').val();				// 추천 여부
			var	useYn = $('input[name="useYn"]:checked').val();				// 사용 여부
			var contents = $("#contents").val();							// 상품 설명
			
			var optionAarr = new Array();
			var optionBarr = new Array();
			var optionCarr = new Array();
			$('input:checkbox[name="optionA"]:checked').each(function() {
				optionAarr.push(this.value);
			});
			$('input:checkbox[name="optionB"]:checked').each(function() {
				optionBarr.push(this.value);
			});
			$('input:checkbox[name="optionC"]:checked').each(function() {
				optionCarr.push(this.value);
			});
			
			var optionA = optionAarr.join(',');										// A 옵션
			var optionB = optionBarr.join(',');										// B 옵션
			var optionC = optionCarr.join(',');										// C 옵션
			
			if(validate()){
				
				$.ajax({
					url : express_docker+"menu/Minsert ",
					type : "POST",
					data : {
						StoreId : "${userVO.storeId}",
						LargeDivCd : largeDivCd,
						MidDivCd : midDivCd,
						MenuName : menuName,
						Price : price,
						ImgUrl : imgUrl,
						OptionA : optionA,
						OptionB : optionB,
						OptionC : optionC,
						Contents : contents,
						Best : best,
						UseYn : useYn,
					},
					success : function(data){
						if(data.success){
							fileUpLoadAjAX(data.info.MenuId);	// control에서 파일 정보 추출 및 저장
						}else{
							alert("등록 실패 되었습니다.");
						}
					},
					error : function(){
						alert("err");
					}		
				});
			}
		}
		
		// 1-2.[상품 등록] - 파일 업로드 기능(특정 디렉터리에 파일 업로드)[추가 : 210603]
		function fileUpLoadAjAX(menuId){
        	var form = $("#fileForm")[0];
        	var data = new FormData(form);

        	$.ajax({
        		type: "POST",          
                enctype: 'multipart/form-data',  
                url: "/file/upload",        
                data: data,
                datatype : "text",
                processData: false,    
                contentType: false,
                cache: false,           
                timeout: 600000,   
                success: function (data) { 
                	//alert("complete");
                	fileUpLoadInfoSave(data.vo, menuId);	// control에서 파일 정보 추출한 것을 api통해 저장 처리
                },          
                error: function (e) {  
                	console.log("ERROR : ", e);     
                    //alert("fail");      
                 }     
        	});
		}
		// 1-3.[상품 등록] - 업로드된 파일 정보 저장 기능[추가 : 210603]
		function fileUpLoadInfoSave(vo, menuId){
			$.ajax({
				url : express_docker+"menu/ImagesInsert",
				type : "POST",
				data : {
					StoreId : "${userVO.storeId}",
					FileEncNm : vo.fileEncNm,
					FileOrgNm : vo.fileOrgNm,
					FilePath : vo.filePath,
					FileSize : vo.fileSize,
					FileType : vo.fileType,
					Type : vo.type,
					RefId : menuId,
					DelYn : "N",
					InsertId : "${userVO.sid}"
				},
				success : function(data){
					if(data.success){
						//alert("등록 되었습니다.");
						//location.href="/quaca/store/menuList";
						menuUpdate(vo, menuId);
					}else{
						alert("파일 등록 실패 되었습니다.");
					}
				},
				error : function(){
					alert("err");
				}		
			});
		}
		//  1-4.[상품 등록] - 저장된 파일 정보를 다시 url 설정(상품 정보 수정)
		function menuUpdate(vo, menuId){
			
			var imgUrl = fixImagePath+vo.filePath+vo.fileEncNm;				// 상품 이미지
			var largeDivCd = $("#largeDivCd").val();						// 카테고리 코드
			var midDivCd = $("#midDivCd").val();							// 하위 카테고리 코드
			var menuName = $("#menuName").val();							// 상품 명
			var price = $("#price").val();									// 가격
			var best = $('input[name="best"]:checked').val();				// 추천 여부
			var	useYn = $('input[name="useYn"]:checked').val();				// 사용 여부
			var contents = $("#contents").val();							// 상품 설명
			
			var optionAarr = new Array();
			var optionBarr = new Array();
			var optionCarr = new Array();
			$('input:checkbox[name="optionA"]:checked').each(function() {
				optionAarr.push(this.value);
			});
			$('input:checkbox[name="optionB"]:checked').each(function() {
				optionBarr.push(this.value);
			});
			$('input:checkbox[name="optionC"]:checked').each(function() {
				optionCarr.push(this.value);
			});
			
			var optionA = optionAarr.join(',');										// A 옵션
			var optionB = optionBarr.join(',');										// B 옵션
			var optionC = optionCarr.join(',');										// C 옵션
			if(validate()){
	 	 		$.ajax({
					url : express_docker+"menu/Mupdate",
					type : "POST",
					data : {
						StoreId : "${userVO.storeId}",
						MenuId : menuId,
						LargeDivCd : largeDivCd,
						MidDivCd : midDivCd,
						MenuName : menuName,
						Price : price,
						ImgUrl : imgUrl,
						OptionA : optionA,
						OptionB : optionB,
						OptionC : optionC,
						Contents : contents,
						Best : best,
						UseYn : useYn,
					},
					success : function(data){
						if(data.success){
							alert("등록 되었습니다.");
							location.href="/quaca/store/menuList";
						}else{
							alert("등록 실패 되었습니다.");
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
			
			var fileForm = /(.*?)\.(jpg|jpeg|png|gif|bmp|pdf)$/; // 이미지 확장자만
			var maxSize = 10 * 1024 * 1024; //10MB까지 
			var fileSize;
			if($("#menuName").val() == ""){
				//validateChk = false;
				alert("상품 명을 입력해 주세요.");
				$("#menuName").focus();
				return false;
			}else if($("#price").val() == ""){
				//validateChk = false;
				alert("가격을 입력해 주세요.");
				$("#price").focus();
				return false;
			}else if($("#file").val() == ""){
				//validateChk = false;
				alert("파일을 선택해 주세요.");
				$("#file").focus();
				return false;
			}
			
			if($("#file").val() != "" && $("#file").val() != null){
				fileSize = document.getElementById("file").files[0].size;
				if(!$("#file").val().match(fileForm)){
					alert("이미지 파일만 업로드 가능합니다.");
					$("#file").focus();	
					return false;
				}else if(fileSize > maxSize){
					alert("파일 사이즈 10MB까지 가능합니다.");
					$("#file").focus();	
					return false;
				}
			}
			return true;
		}
		
		// 뒤로 가기 
		function goMenuList(){
			location.href="/quaca/store/menuList";	
		}
</script>		