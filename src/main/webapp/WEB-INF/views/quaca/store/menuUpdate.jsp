<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../../header.jsp" %>

<!-- 메인 영역 -->
<main id="js-page-content" role="main" class="page-content">
	<ol class="breadcrumb page-breadcrumb">
        <li class="breadcrumb-item"><a href="javascript:void(0);">Quaca</a></li>
        <li class="breadcrumb-item">in 매장 관리</li>
        <li class="breadcrumb-item">상품 관리</li>
        <li class="breadcrumb-item active">수정</li>
        <li class="position-absolute pos-top pos-right d-none d-sm-block"><span class="js-get-date"></span></li>
    </ol>
    <div class="row">
		<div class="col-xl-12">		
			<div id="panel-1" class="panel">
				<div class="panel-hdr ">
					<div class="col-xl-12">
						<div class="form-row float-right">
							<button class="btn btn-primary" onclick="goMenuSave();">저장하기</button>
							<button class="btn btn-warning" onclick="menuDelete();">삭제하기</button>
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
									<select class="form-control " id="largeDivCd" name="largeDivCd" disabled="disabled">
									</select>
									<input type="hidden" id="menuId" name="menuId" value="">
									<input type="hidden" class="form-control " id="imgUrl" name="imgUrl" value="">
								</div>
							</div>
						</div>
						<div class="form-group row" id="midDivCdDiv">
							<label class="col-form-label col-12 col-lg-2 form-label text-lg-right">하위 카테고리</label>
							<div class="col-12 col-lg-6">
								<div class="input-group">
									<select class="form-control " id="midDivCd" name="midDivCd"  disabled="disabled" >
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
								<div class="input-group" id="fileDiv">
								</div>
							</div>
						</form>
						<div id="optionDiv">						
						</div>
						<div class="form-group row">
							<label class="col-form-label col-12 col-lg-2 form-label text-lg-right">추천 여부</label>
							<div class="col-12 col-lg-6">
								<div class="input-group">
									<label class="col-form-label col-lg-4"><input type="radio" id="bestY" name="best" value="Y"/> 예</label>
									<label class="col-form-label col-lg-4"><input type="radio" id="bestN" name="best" value="N"/> 아니요</label>
								</div>
							</div>
						</div>
						<div class="form-group row">
							<label class="col-form-label col-12 col-lg-2 form-label text-lg-right">사용 여부</label>
							<div class="col-12 col-lg-6">
								<div class="input-group">
									<label class="col-form-label col-lg-4"><input type="radio" id="useYnY" name="useYn" value="Y"/> 예</label>
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
			// 상품 정보 호출
			menuInfo();
			
			// 카테고리 change event(하위 카테고리 & 카테고리별 옵션)
			$("#largeDivCd").change(function(){
				
				if(this.value != 'D'){
					$("#midDivCd").children().remove();
					$("#midDivCdDiv").hide();
				}else{
					$("#midDivCdDiv").show();
					 midDivCdList(this.value, "")
				}
				categoryOption(this.value, "", "", "");
			})
			
		});
		
		
		//1.[상품 정보 호출] - 상품 정보 가져오기 
		function menuInfo(){
			$.ajax({
				url : express_docker+"menu/menuInfo",
				type : "POST",
				data : {
					StoreId : "${userVO.storeId}",
					MenuId : "${menuId}"
				},
				success : function(data){
					if(data.success){
						// 파일 존재 여부에 따른 html 처리 
						if(data.info.FileId != null && data.info.FileId != ""){
							$("#fileDiv").html(updateFileHtml(data.info));
						}else{
							$("#fileDiv").html(insertFileHtml());
						}
						
						categoryList(data.info.LargeDivcd, data.info.MidDivCd, data.info.OptionA, data.info.OptionB, data.info.OptionC);
						
						$("#menuId").val(data.info.MenuId);			// 상품 코드					
						$("#menuName").val(data.info.MenuName);		// 상품 명
						$("#price").val(data.info.Price);			// 가격
						$("#imgUrl").val(fixImagePath+data.info.FilePath+data.info.FileEncNm);			// 상품 이미지
						$("#contents").val(data.info.Contents);		// 상품 설명
						// 추천 여부
						$('input[name="best"]').each(function(){
							if($(this).val() == data.info.Best){
								this.checked = true;
							}
						});
						// 사용 여부
						$('input[name="useYn"]').each(function(){
							if($(this).val() == data.info.UseYn){
								this.checked = true;
							}
						});
					}else{
						alert("정보를 불러오지 못했습니다.");
					}
				},
				error : function(){
					alert("err");
				}		
			});
		}
		
		//2-1.[상품 정보 호출] -  파일 있을 경우 html 
		function updateFileHtml(data){
			var path = "/"+data.FilePath+data.FileEncNm;
			var html = "";
				html += '<a href="'+path+'" class="text-info fs-sm" target="_blank"><label class="col-form-label col-lg-12">'+data.FileOrgNm+'</label></a>'; 
				html += '<button type="button" class="btn btn-xs btn-primary" onclick="fileDelete(\''+data.FileId+'\');">삭제</button>';
			return html;
		}
		//2-2.[상품 정보 호출] - 파일 없을 경우 html 
		function insertFileHtml(){
			var html = "";
				html += '<input type="file" class="form-control" id="file" name="file" value="" accept="image/gif, image/jpeg, image/png" required style="border: 0px;">';
				html += '<input type="hidden" id="type" name="type" value="M">';
				html += '<input type="hidden" id="storeId" name="storeId" value="${userVO.storeId}">';
			return html;
		}
		
		//3-1.[상품 정보 호출] - 카테고리 목록(상품 전용)
		function categoryList(cateCd, midCateCd, optionA, optionB, optionC){
			$.ajax({
				url : express_docker+"store/categorymenu",
				type : "POST",
				data : {
					StoreId : "${userVO.storeId}",
					UseYn : 'Y'
				},
				success : function(data){
					if(data.success){
						// 카테고리 정보 
						$("#largeDivCd").html(largeDivOptionHtml(data.info, cateCd));
						 
						if($("#largeDivCd option:selected").val() != 'D'){
							$("#midDivCd").children().remove();
							$("#midDivCdDiv").hide();
						}else{
							$("#midDivCdDiv").show();
							 midDivCdList($("#largeDivCd option:selected").val(), midCateCd)
						}
						// 카테고리별 옵션 
						categoryOption($("#largeDivCd option:selected").val(), optionA, optionB, optionC);
					}else{
						alert("카테고리 정보를 불러오기를 실패 하였습니다.");						
					}
				},
				error : function(){
					alert("err");
				}		
			});
		}
		//3-2.[상품 정보 호출] - select option html (카테고리)
		function largeDivOptionHtml(data, cateCd){
			var html;
			for(var i = 0; i < data.length; i++){
				html += '<option value="'+data[i].CateCd+'"';
				html += cateCd == data[i].CateCd ? 'selected' : '';
				html += '>';
				html +=  data[i].CateNm
				html += '</option>';
			}
			return html;
		}
		
		//4-1.[상품 정보 호출] - 하위 카테고리 
		function midDivCdList(cateCd, midCateCd){
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
						$("#midDivCd").html(midDivOptionHtml(data.info, midCateCd));
					}else{
					}
				},
				error : function(){
					alert("err");
				}		
			});
		}
		
		//4-2.[상품 정보 호출] - select 옵션(하위 카테고리)
		function midDivOptionHtml(data, midCateCd){
			var html;
			for(var i = 0; i < data.length; i++){
				html += '<option value="'+data[i].MidCateCd+'"';
				html += midCateCd == data[i].MidCateCd ? 'selected' : '';
				html += '>';
				html +=  data[i].MidCateNm
				html += '</option>';
			}
			return html;
		}
		
		//5-1.[상품 정보 호출] - 각 카테고리별 옵션 항목 호출 (D:음료, B:베이커리, G:굿즈)
		function categoryOption(largeDivCd, optionA, optionB, optionC){
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
						
						// 옵션 A
						$('input:checkbox[name="optionA"]').each(function() {
							if(optionA != null && optionA != "" && optionA.indexOf($(this).val()) != -1){
								//this.checked = true;
								$(this).prop('checked', true);
							}	
						});
						// 옵션 B
						$('input:checkbox[name="optionB"]').each(function() {
							if(optionB != null && optionB != "" && optionB.indexOf($(this).val()) != -1){
								this.checked = true;
							}
						});
						// 옵션 C
						$('input:checkbox[name="optionC"]').each(function() {
							var arrData = optionC.split(",");
							var cnt = arrData.length;
							if(cnt > 0){
								for(var i = 0 ; cnt > i; i++){
									if(arrData[i] == $(this).val()){
										this.checked = true;	
									}
								}
							}else{
								if(optionC != null && optionC != "" && optionC == $(this).val()){
									this.checked = true;	
								}
							}
						});
						
					}else{
					}
				},
				error : function(){
					alert("err");
				}		
			});
		}
		
		//5-2.[상품 정보 호출] - 각 카테고리별 옵션 항목 호출 (D:음료, B:베이커리, G:굿즈)
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
		
		//1.[상품 수정] - 등록 파일 유무에 따른 처리 방식 
		function goMenuSave(){
			if($("#fileDiv").children("#file").length > 0){
				fileUpLoadAjAX($("#menuId").val());	// control에서 파일 정보 추출 및 저장
			}else{
				// 파일 정보 없을경우 그냥 저장
				menuSave();
			}
		}
		//2.[상품 수정] - 상품 정보 저장(수정)&(새로 입력된 파일 없을 경우)
		function menuSave(){
			var menuId = $("#menuId").val();								// 상품 코드	
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
							alert("수정 되었습니다.");
							location.href="/quaca/store/menuList";
						}else{
							alert("수정 실패 되었습니다.");
						}
					},
					error : function(){
						alert("err");
					}		
				}); 
			}
		}
		//3-1.[상품 수정] - 파일 업로드 기능(특정 디렉터리에 파일 업로드)[추가 : 210603]
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
		//3-2.[상품 수정] - 업로드된 파일 정보 저장 기능[추가 : 210603]
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
						menuSave2(vo);
					}else{
						alert("수정 실패 되었습니다.");
					}
				},
				error : function(){
					alert("err");
				}		
			});
		}
		
		//3-3.[상품 수정] - 상품 정보 저장(수정)&(새로 입력된 파일 있을 경우)
		function menuSave2(vo){
			
			var imgUrl = fixImagePath+vo.filePath+vo.fileEncNm;				// 상품 이미지
			var menuId = $("#menuId").val();								// 상품 코드	
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
							alert("수정 되었습니다.");
							location.href="/quaca/store/menuList";
						}else{
							alert("수정 실패 되었습니다.");
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
		
		//1.[상품 삭제] - 상품 삭제 처리
		function menuDelete(){
			var menuId = $("#menuId").val();								// 상품 코드
			var warning = confirm("삭제하시겠습니까?");
			if(warning){
				$.ajax({
					url : express_docker+"menu/MDelete",
					type : "POST",
					data : {
						StoreId : "${userVO.storeId}",
						MenuId : menuId,
						DelYn : 'Y'
					},
					success : function(data){
						if(data.success){
							alert("삭제 되었습니다.");
							location.href="/quaca/store/menuList";
						}else{
							alert("삭제 실패 되었습니다.");
						}
					},
					error : function(){
						alert("err");
					}		
				}); 
			}
		}
		//1.[파일삭제] - 파일 삭제 처리 
		function fileDelete(fileId){
			var warning = confirm("삭제하시겠습니까?");
			if(warning){
				$.ajax({
					url : express_docker+"menu/ImagesDelete",
					type : "POST",
					data : {
						FileId : fileId,
						DelYn : "Y",
					},
					success : function(data){
						if(data.success){
							alert("삭제 되었습니다.");
							$("#fileDiv").html(insertFileHtml());
						}else{
							alert("삭제 실패 되었습니다.");
						}
					},
					error : function(){
						alert("err");
					}		
				});
			}
		}
		// 뒤로 가기 
		function goMenuList(){
			location.href="/quaca/store/menuList";	
		}
		

		
		// 옵션 html(2021-05-27 상품 옵션 테이블 생성으로 인해 폐기 대기 [사용안함]) 
		function optionHtml2(cateCd){
			var html = "";
			
			if(cateCd == "D" || cateCd == "S"){
				html += '<div class="form-group row" id="OptionADiv">';
				html +=		'<label class="col-form-label col-12 col-lg-2 form-label text-lg-right" id="optionALabel">온도</label>';
				html += 	'<div class="col-12 col-lg-6">';
				html += 		'<div class="input-group" id="optionAChk">';
				html += 			'<label class="col-form-label col-lg-4"><input type="checkbox" id="optionA1" name="optionA" value="HOT"/>HOT</label>';
				html += 			'<label class="col-form-label col-lg-4"><input type="checkbox" id="optionA2" name="optionA" value="ICE"/>ICE</label>';
				html += 		'</div>';
				html += 	'</div>';
				html += '</div>';
				html += '<div class="form-group row" id="OptionBDiv">';
				html += 	'<label class="col-form-label col-12 col-lg-2 form-label text-lg-right" id="optionBLabel">사이즈</label>';
				html += 	'<div class="col-12 col-lg-6">';
				html += 		'<div class="input-group" id="optionBChk">';
				html += 			'<label class="col-form-label col-lg-4"><input type="checkbox" id="optionB1" name="optionB" value="Large"/>Large</label>';
				html += 			'<label class="col-form-label col-lg-4"><input type="checkbox" id="optionB2" name="optionB" value="Small"/>Small</label>';
				html += 		'</div>';
				html += 	'</div>';
				html += '</div>';
				html += '<div class="form-group row" id="OptionCDiv">';
				html += 	'<label class="col-form-label col-12 col-lg-2 form-label text-lg-right" id="optionCLabel">컵</label>';
				html += 	'<div class="col-12 col-lg-6">';
				html += 		'<div class="input-group" id="optionCChk">';
				html += 			'<label class="col-form-label col-lg-4"><input type="checkbox" id="optionC1" name="optionC" value="매장컵"/>매장컵</label>';
				html += 			'<label class="col-form-label col-lg-4"><input type="checkbox" id="optionC2" name="optionC" value="일회용컵"/>일회용컵</label>';
				html += 			'<label class="col-form-label col-lg-4"><input type="checkbox" id="optionC3" name="optionC" value="개인컵"/>개인컵</label>';
				html += 		'</div>';
				html += 	'</div>';
				html += '</div>';
			}else if(cateCd == "B"){
				html += '<div class="form-group row" id="OptionADiv">';
				html +=		'<label class="col-form-label col-12 col-lg-2 form-label text-lg-right" id="optionALabel">온도</label>';
				html += 	'<div class="col-12 col-lg-6">';
				html += 		'<div class="input-group" id="optionAChk">';
				html += 			'<label class="col-form-label col-lg-4"><input type="checkbox" id="optionA1" name="optionA" value="따뜻하게데움"/>따뜻하게데움</label>';
				html += 			'<label class="col-form-label col-lg-4"><input type="checkbox" id="optionA2" name="optionA" value="데우지않음"/>데우지않음</label>';
				html += 		'</div>';
				html += 	'</div>';
				html += '</div>';
				html += '<div class="form-group row" id="OptionCDiv">';
				html += 	'<label class="col-form-label col-12 col-lg-2 form-label text-lg-right" id="optionCLabel">포장</label>';
				html += 	'<div class="col-12 col-lg-6">';
				html += 		'<div class="input-group" id="optionCChk">';
				html += 			'<label class="col-form-label col-lg-4"><input type="checkbox" id="optionC1" name="optionC" value="매장"/>매장</label>';
				html += 			'<label class="col-form-label col-lg-4"><input type="checkbox" id="optionC2" name="optionC" value="포장"/>포장</label>';
				html += 		'</div>';
				html += 	'</div>';
				html += '</div>';
			}else if(cateCd == "G"){
				html += '<div class="form-group row" id="OptionCDiv">';
				html += 	'<label class="col-form-label col-12 col-lg-2 form-label text-lg-right" id="optionCLabel">포장</label>';
				html += 	'<div class="col-12 col-lg-6">';
				html += 		'<div class="input-group" id="optionCChk">';
				html += 			'<label class="col-form-label col-lg-4"><input type="checkbox" id="optionC1" name="optionC" value="포장"/>포장</label>';
				html += 			'<label class="col-form-label col-lg-4"><input type="checkbox" id="optionC2" name="optionC" value="포장안함"/>포장안함</label>';
				html += 		'</div>';
				html += 	'</div>';
				html += '</div>';
			}
			
			return html;
		}
		
</script>		