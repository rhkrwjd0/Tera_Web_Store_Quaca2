<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../../header.jsp" %>

<!-- 메인 영역 -->
<main id="js-page-content" role="main" class="page-content">
	<ol class="breadcrumb page-breadcrumb">
        <li class="breadcrumb-item"><a href="javascript:void(0);">Quaca</a></li>
        <li class="breadcrumb-item">in 매장 관리</li>
        <li class="breadcrumb-item">매장 정보 관리</li>
        <li class="breadcrumb-item active">수정</li>
        <li class="position-absolute pos-top pos-right d-none d-sm-block"><span class="js-get-date"></span></li>
    </ol>
	<div class="row">
		<div class="col-xl-12">		
			<div id="panel-1" class="panel">
				<div class="panel-hdr ">
					<div class="col-xl-12">
						<div class="form-row float-right">
							<button class="btn btn-primary" onclick="goStoreSave();">저장하기</button>
							<button class="btn btn-secondary" onclick="goStoreInfo();">돌아가기</button>
						</div>	
					</div>
				</div>
				<div class="panel-container show">
					<div class="panel-content">
						<div class="form-group row">
							<label class="col-form-label col-12 col-lg-2 form-label text-lg-right">매장 명</label>
							<div class="col-12 col-lg-6">
								<div class="input-group">
									<input type="text" class="form-control " id="storeName" name="storeName" value="">
									<input type="hidden" class="form-control " id="mainImgUrl" name="mainImgUrl" value="">
								</div>
							</div>
						</div>
						<form id="fileForm" class="form-group row" enctype="multipart/form-data" method="post">
							<label class="col-form-label col-12 col-lg-2 form-label text-lg-right">메인 이미지</label>
							<div class="col-12 col-lg-6">
								<div class="input-group" id="fileDiv">
								</div>
							</div>
						</form>
						<!-- <div class="form-group row">
							<label class="col-form-label col-12 col-lg-2 form-label text-lg-right">메인 이미지</label>
							<div class="col-12 col-lg-6">
								<div class="input-group">
									<input type="text" class="form-control " id="mainImgUrl" name="mainImgUrl" value="">
								</div>
							</div>
						</div> -->
						<div class="form-group row">
							<label class="col-form-label col-12 col-lg-2 form-label text-lg-right">오픈 시간</label>
							<div class="col-12 col-lg-1">
								<div class="input-group">
									<select class="form-control " id="openTimHour" name="openTimHour" ></select>
								</div>
							</div>
							<div class="col-12 col-lg-1">
								<div class="input-group">
									<select class="form-control " id="openTimeMin" name="openTimeMin" ></select>
								</div>
							</div>
						</div>
						<div class="form-group row">
							<label class="col-form-label col-12 col-lg-2 form-label text-lg-right">닫는 시간</label>
							<div class="col-12 col-lg-1">
								<div class="input-group">
									<select class="form-control " id="closeTimeHour" name="closeTimeHour" >
									
									</select>
								</div>
							</div>
							<div class="col-12 col-lg-1">
								<div class="input-group">
									<select class="form-control " id="closeTimeMin" name="closeTimeMin" ></select>
								</div>
							</div>
						</div>
						
						<div class="form-group row">
							<label class="col-form-label col-12 col-lg-2 form-label text-lg-right">휴무일</label>
							<div class="col-12 col-lg-6">
								<div class="input-group">
									<input type="text" class="form-control " id="dayOff" name="dayOff" value="">
								</div>
							</div>
						</div>
						<div class="form-group row">
							<label class="col-form-label col-12 col-lg-2 form-label text-lg-right">전화번호</label>
							<div class="col-12 col-lg-6">
								<div class="input-group">
									<input type="text" class="form-control " id="telNo" name="telNo" value="">
								</div>
							</div>
						</div>
						<div class="form-group row">
							<label class="col-form-label col-12 col-lg-2 form-label text-lg-right">주소</label>
							<div class="col-12 col-lg-4">
								<div class="input-group">
									<input type="text" class="form-control " id="addr1" name="addr1" value="" readonly="readonly" style="background-color: white;" onclick="searchAddr();">
									<button class="btn btn-primary" onclick="searchAddr();">주소 검색</button>
								</div>
							</div>
						</div>
						<div class="form-group row">
							<label class="col-form-label col-12 col-lg-2 form-label text-lg-right"></label>
							<div class="col-12 col-lg-6">
								<div class="input-group">
									<input type="text" class="form-control " id="addr2" name="addr2" value="">
									<input type="hidden" class="form-control " id="lon" name="lon" value="">
									<input type="hidden" class="form-control " id="lat" name="lat" value="">
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
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/quaca/js/daumcdn/postcode/postcode.v2.js"></script>
<script type="text/javascript">

		$(document).ready(function () {
			$(".panel-hdr").children(".panel-toolbar").remove();
			storeInfo(); // 매장 정보 호출
		});
		
		//1.[주소검색] - 주소 검색 창
		function searchAddr(){
		    new daum.Postcode({
		        oncomplete: function(data) {
		            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분입니다.
		            // 예제를 참고하여 다양한 활용법을 확인해 보세요.
		        	// 각 주소의 노출 규칙에 따라 주소를 조합한다. 
					// 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다. 
					var fullAddr = ''; // 최종 주소 변수 
					var extraAddr = ''; // 조합형 주소 변수 
					
					// 사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다. 
					if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우 
						fullAddr = data.roadAddress; 
					} else { // 사용자가 지번 주소를 선택했을 경우(J) 
						fullAddr = data.jibunAddress; 
					} 
					
					// 사용자가 선택한 주소가 도로명 타입일때 조합한다. 
					if(data.userSelectedType === 'R'){ 
						//법정동명이 있을 경우 추가한다. 
						if(data.bname !== ''){ 
							extraAddr += data.bname; 
						} 
						// 건물명이 있을 경우 추가한다. 
						if(data.buildingName !== ''){ 
							extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName); 
						} 
						// 조합형주소의 유무에 따라 양쪽에 괄호를 추가하여 최종 주소를 만든다. 
						fullAddr += (extraAddr !== '' ? ' ('+ extraAddr +')' : ''); 
					}
					$("#addr1").val(fullAddr);
					searchPoint(fullAddr);
					$("#addr2").focus();
		        }
		    }).open();
		}
		
		//2.[주소검색] - 주소 데이터로 x,y좌표(위도, 경도) 검색
		function searchPoint(addr){ 
			$.ajax({
				url : '/getAddrDetail',
				type : 'get',
				data : {
					"addr" : addr,
					"kakaoRestAppKey" : "1c9d57bfdb8c196983503366b7b0d719"
				},
				success: function (data) {
					addrSearch(data);
				},
				error: function () {
					
				}
			});
		}
		//3.[주소검색] - input 창 - 주소 입력처리 및 좌표 입력처리 
		function addrSearch(data){// X,Y좌표 추출
			var jsonObj = JSON.parse(data);
		    $("[name=lon]").val(jsonObj.documents[0].x);	// 경도
		    $("[name=lat]").val(jsonObj.documents[0].y);	// 위도
		}
		
		//1.[매장정보 호출] - 매장 정보 가져오기 
		function storeInfo(){
			$.ajax({
				url : express_docker+"store/storeInfo",
				type : "POST",
				data : {
					StoreId : "${userVO.storeId}"
				},success : function(data){
					if(data.success){
						// 매장 정보 입력 처리
						storeInfoHtml(data.info);
						
						// 파일 존재 여부에 따른 html 처리 
						if(data.info.FileId != null && data.info.FileId != ""){
							$("#fileDiv").html(updateFileHtml(data.info));
						}else{
							$("#fileDiv").html(insertFileHtml());
						}
					}else{
						alert("정보를 불러오지 못했습니다.");
					}
				},
				error : function(){
					alert("err");
				}		
			});
		}
		
		//1-1.[매장정보 호출] - 파일 있을 경우 html 
		function updateFileHtml(data){
			var path = "/"+data.FilePath+data.FileEncNm;
			var html = "";
				html += '<a href="'+path+'" class="text-info fs-sm" target="_blank"><label class="col-form-label col-lg-12">'+data.FileOrgNm+'</label></a>'; 
				html += '<button type="button" class="btn btn-xs btn-primary" onclick="fileDelete(\''+data.FileId+'\');">삭제</button>';
			return html;
		}
		//1-2.[매장정보 호출] - 파일 없을 경우 html 
		function insertFileHtml(){
			var html = "";
				html += '<input type="file" class="form-control" id="file" name="file" value="" accept="image/gif, image/jpeg, image/png" required style="border: 0px;">';
				html += '<input type="hidden" id="type" name="type" value="S">';
				html += '<input type="hidden" id="storeId" name="storeId" value="${userVO.storeId}">';
			return html;
		}
		
		//1-3.[매장정보 호출] - storeInfo 정보 입력 처리 		
		function storeInfoHtml(data){

			$("#storeName").val(data.StoreName);	// 매장 명
			//$("#mainImgUrl").val(data.MainImgUrl);	// 메인 이미지 
			$("#mainImgUrl").val(fixImagePath+data.FilePath+data.FileEncNm);	// 메인 이미지 
			$("#dayOff").val(data.DayOff);			// 휴무일
			$("#telNo").val(data.TelNo);			// 연락처
			$("#addr1").val(data.Addr1);			// 주소
			$("#addr2").val(data.Addr2);			// 상세 주소
			$("#lat").val(data.Lat);					// 위도
			$("#lon").val(data.Lon);					// 경도
			
			$("#openTimHour").html(optionHour(data.OpenTime.split(":")[0]));		// 오픈 시간(시)
			$("#closeTimeHour").html(optionHour(data.CloseTime.split(":")[0]));	// 닫는 시간(시)
			$("#openTimeMin").html(optionMin(data.OpenTime.split(":")[1]));		// 오픈 시간(분) 
			$("#closeTimeMin").html(optionMin(data.CloseTime.split(":")[1]));		// 닫는 시간(분)
		}
		//1-4.[매장정보 호출] - select 시간(시) 옵션
		function optionHour(hour){
			var hourHtml;
			for(var i = 1; i <= 24; i++){
				hourHtml += '<option value="'+numFormat(i)+'" ';
				if(numFormat(i) == hour){
					hourHtml += 'selected'	
				}
				hourHtml += ' >'+numFormat(i)+'</option>';
			}
			return hourHtml;
		}
		//1-5.[매장정보 호출] -  select 시간(분) 옵션
		function optionMin(min){
			var minHtml = "";
			for(var i = 0; i <= 59; i++){
				minHtml += '<option value="'+numFormat(i)+'" ';
				if(numFormat(i) == min){
					minHtml += 'selected'	
				}
				minHtml += ' >'+numFormat(i)+'</option>';
			}
			return minHtml;
		}
		
		
		//1.[매장정보 저장] - 등록 파일 유무에 따른 처리 방식 
		function goStoreSave(){
			if($("#fileDiv").children("#file").length > 0){
				fileUpLoadAjAX();	// control에서 파일 정보 추출 및 저장
			}else{
				// 파일 정보 없을경우 그냥 저장
				storeSave();
			}
		}
		//2.[매장정보 저장] - 매장 정보 저장(새로 입력된 파일 없을 경우)
		function storeSave(){
			if(validate()){
				$.ajax({
					url : express_docker+"store/storeUpdate ",
					type : "POST",
					data : {
						StoreId : "${userVO.storeId}",
						StoreName : $("#storeName").val(),
						OpenTime : $("#openTimHour option:selected").val()+":"+$("#openTimeMin option:selected").val(),
						CloseTime : $("#closeTimeHour option:selected").val()+":"+$("#closeTimeMin option:selected").val(),
						DayOff : $("#dayOff").val(),
						TelNo : $("#telNo").val(),
						Addr1 : $("#addr1").val(),
						Addr2 : $("#addr2").val(),
						Lat : $("#lat").val(),
						Lon : $("#lon").val(),
						MainImgUrl : $("#mainImgUrl").val()
						
					},success : function(data){
						if(data.success){
							alert("수정 되었습니다.");
							location.href="/quaca/store/storeInfo";	
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
		//3-1.[매장정보 저장] - 파일 업로드 기능(특정 디렉터리에 파일 업로드)[추가 : 210603]
		function fileUpLoadAjAX(){
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
                	fileUpLoadInfoSave(data.vo);	// control에서 파일 정보 추출한 것을 api통해 저장 처리
                },          
                error: function (e) {  
                	console.log("ERROR : ", e);     
                    //alert("fail");      
                 }     
        	});
		}
		//3-2.[매장정보 저장] - 업로드된 파일 정보 저장 기능[추가 : 210603]
		function fileUpLoadInfoSave(vo){
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
					RefId : null,
					DelYn : "N",
					InsertId : "${userVO.sid}"
				},
				success : function(data){
					if(data.success){
						storeSave2(vo);
					}else{
						alert("파일저장 실패 되었습니다.");
					}
				},
				error : function(){
					alert("err");
				}		
			});
		}
		//3-3.[매장정보 저장] - 매장 정보 저장(새로 입력된 파일 있을 경우)
		function storeSave2(vo){
			var mainImg = fixImagePath+vo.filePath+vo.fileEncNm;
			if(validate()){
				$.ajax({
					url : express_docker+"store/storeUpdate ",
					type : "POST",
					data : {
						StoreId : "${userVO.storeId}",
						StoreName : $("#storeName").val(),
						OpenTime : $("#openTimHour option:selected").val()+":"+$("#openTimeMin option:selected").val(),
						CloseTime : $("#closeTimeHour option:selected").val()+":"+$("#closeTimeMin option:selected").val(),
						DayOff : $("#dayOff").val(),
						TelNo : $("#telNo").val(),
						Addr1 : $("#addr1").val(),
						Addr2 : $("#addr2").val(),
						Lat : $("#lat").val(),
						Lon : $("#lon").val(),
						MainImgUrl : mainImg
						
					},success : function(data){
						if(data.success){
							alert("수정 되었습니다.");
							location.href="/quaca/store/storeInfo";	
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
		
		// 유효성 체크 
		function validate(){
			var validateChk = true;
			
			var fileForm = /(.*?)\.(jpg|jpeg|png|gif|bmp|pdf)$/; // 이미지 확장자만
			var maxSize = 10 * 1024 * 1024; //10MB까지 
			var fileSize;
			if($("#storeName").val() == ""){
				//validateChk = false;
				alert("매장 명을 입력해 주세요.");
				$("#storeName").focus();
				return false;
			}else if($("#dayOff").val() == ""){
				//validateChk = false;
				alert("휴무일을 입력해 주세요.");
				$("#dayOff").focus();
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
		
		
		
		// 두자리 처리(숫자) 
		function numFormat(variable) { 
			variable = Number(variable).toString(); 
			if(Number(variable) < 10 && variable.length == 1) variable = "0" + variable; 
			return variable; 
		}

		// 돌아가기 
		function goStoreInfo(){
			location.href="/quaca/store/storeInfo";	
		}
</script>
