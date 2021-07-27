<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../../header.jsp" %>
<link rel="stylesheet" media="screen, print" href="${pageContext.request.contextPath}/resources/quaca/css/datagrid/datatables/datatables.bundle.css">
<!-- 메인 영역 -->
<main id="js-page-content" role="main" class="page-content">
	<ol class="breadcrumb page-breadcrumb">
        <li class="breadcrumb-item"><a href="javascript:void(0);">Quaca</a></li>
        <li class="breadcrumb-item">in 매장 관리</li>
        <li class="breadcrumb-item">상품 관리</li>
        <li class="breadcrumb-item active">목록</li>
        <li class="position-absolute pos-top pos-right d-none d-sm-block"><span class="js-get-date"></span></li>
    </ol>
	<div class="row">
		<div class="col-xl-12">
			<div class="set-title-line">
				<ul class="nav nav-pills nav-justified" role="tablist">
	                <li class="nav-item"><a class="nav-link active" data-toggle="tab" href="#drinkDiv" onclick="reloadMenuList();">음료</a></li>
	                <li class="nav-item"><a class="nav-link" data-toggle="tab" href="#breadDiv" onclick="reloadMenuList();">브레드</a></li>
	                <li class="nav-item"><a class="nav-link" data-toggle="tab" href="#goodsDiv" onclick="reloadMenuList();">굿즈</a></li>
	            </ul>
            </div>
			<div id="panel-1" class="panel">
				<div class="panel-container show">
					<div class="panel-content">
			             <div class="tab-content py-3">
			                 <div class="tab-pane fade show active" id="drinkDiv" role="tabpanel">
			                 </div>
			                 <div class="tab-pane fade" id="breadDiv" role="tabpanel">
			                 </div>
			                 <div class="tab-pane fade" id="goodsDiv" role="tabpanel">
			                 </div>
			             </div>
						<div class="row">
							<div class="col-xl-12">
								<button class="btn btn-primary" onclick="goMenuInsert();">등록하기</button>
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
			// 상품 목록 호출
        	menuList();
		});
		//1-1.[상품 목록 호출] - 상품 리스트 불러오기 
		function menuList(){
			$.ajax({
				url : express_docker+"menu/menulist",
				type : "POST",
				data : {
					StoreId : "${userVO.storeId}"
				},
				success : function(data){
					if(data.success){
						
						$("#drinkDiv").html(menuHtml(data.info.drink));
						$("#breadDiv").html(menuHtml(data.info.bread));
						$("#goodsDiv").html(menuHtml(data.info.goods));
						$('[name = dt-basic-example]').dataTable({
							responsive: true
						});
					}else{
						$("#drinkDiv").html(menuBasisHtml());
						$("#breadDiv").html(menuBasisHtml());
						$("#goodsDiv").html(menuBasisHtml());
					}
				},
				error : function(){
					alert("err");
				}		
			});
		}
		//1-2.[상품 목록 호출] - 상품 목록 table html(data = 있음) 
		function menuHtml(data){
			var number = 0;
			var html = "";
			var path = "";
			html += '<table name="dt-basic-example" class="table table-bordered table-hover table-striped w-100">';
			html += 	'<thead>';
			html += 		'<tr class="text-center" >';
			html += 			'<th>번호</th>';
			html += 			'<th>이미지</th>';
			html += 			'<th>상품 명</th>';
			html += 			'<th>금액</th>';
			html += 			'<th>추천 여부</th>';
			html += 			'<th>사용 여부</th>';
			html += 			'<th>등록 일</th>';
			html += 		'</tr>';
			html += 	'</thead>';
			html += 	'<tbody id="menutList">';
			for(var i = 0; i < data.length; i++ ){
				if(data[i].FileEncNm != null && data[i].FileEncNm != ""){
					path = '/'+data[i].FilePath+data[i].FileEncNm;
				}else{
					path = '/resources/quaca/img/noimg.jpg';
				}
				number++;
				html += 		'<tr class="text-center" onclick="goMenuUpdate(\''+data[i].MenuId+'\');">';
				html += 			'<td>'+((data.length+1)-number)+'</td>';
				html += 			'<td><img src="'+path+'" width="50" height="50" /></td>';
				html += 			'<td>'+data[i].MenuName+'</td>';
				html += 			'<td>'+numberWithCommas(data[i].Price)+'원</td>';
				html += 			'<td>';
				html +=					data[i].Best == 'Y' ? '추천' : '비 추천';
				html += 			'</td>';
				html += 			'<td>';
				html +=					data[i].UseYn == 'Y' ? '사용' : '미사용';
				html += 			'</td>';
				html += 			'<td>'+data[i].InsertDate+'</td>';
				html += 		'</tr>';
			}
			
			
			html +=    '</tbody>';
			html += '</table>';
		    
			return html;
		}
		//1-3.[상품 목록 호출] - 상품 목록 table html(data = 없음)
		function menuBasisHtml(){

			var html ="";
			
			html += '<table id="dt-basic-example" class="table table-bordered table-hover table-striped w-100">';
			html += 	'<thead>';
			html += 		'<tr class="text-center" >';
			html += 			'<th>번호</th>';
			html += 			'<th>이미지</th>';
			html += 			'<th>상품 명</th>';
			html += 			'<th>금액</th>';
			html += 			'<th>추천 여부</th>';
			html += 			'<th>사용 여부</th>';
			html += 			'<th>등록 일</th>';
			html += 		'</tr>';
			html += 	'</thead>';
			html += 	'<tbody id="menutList">';
			html += 		'<tr class="text-center" >';
			html += 		'<td colspan="7"> 데이터가 존재하지 않습니다.</td>';
			html += 		'</tr>';
			html +=    '</tbody>';
			html += '</table>';

			return html;
		} 
		
		//2.[상품 수정 화면 이동] - 상품 수정 화면으로 이동
		function goMenuUpdate(menuId){
			var html ="";
			html += '<form id="menuFm" name="menuFm" method="get">';
			html += 	'<input type="hidden" id="menuId" name="menuId" value="'+menuId+'" />'; 
			html +=	'</form>';
			$("#formDiv").html(html);
			
			$('#menuFm').attr({
				action : '/quaca/store/menuUpdate',
				method : 'get'
			}).submit();
		}
		
		//3.[상품 수정 화면 이동] - 상품 등록 화면으로 이동
		function goMenuInsert(){
			location.href="/quaca/store/menuInsert";	
		}
		
		//4.[상품 탭 기능] - 탭 클릭 시 api 호출
		function reloadMenuList(){
			menuList();
		}
		
		// 콤마 처리
		function numberWithCommas(x) {
		    return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
		}
</script>
