<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../../header.jsp" %>

<!-- 메인 영역  -->
<main id="js-page-content" role="main" class="page-content order-info">
	<ol class="breadcrumb page-breadcrumb">
        <li class="breadcrumb-item"><a href="javascript:void(0);">Quaca</a></li>
        <li class="breadcrumb-item">in 결제 정보</li>
        <li class="breadcrumb-item active">주문 정보</li>
        <li class="position-absolute pos-top pos-right d-none d-sm-block"><span class="js-get-date"></span></li>
    </ol>
	<div class="row">
		<div class="col-xl-12">
         	<div class="set-title-line">
         	    <ul class="nav nav-pills nav-justified" role="tablist">
	                 <li class="nav-item"><a id="ocOrderInfoNav" class="nav-link active" data-toggle="tab" href="#ocOrderInfoDiv" onclick="reloadOrderList();">접수 대기</a></li>
	                 <li class="nav-item"><a id="rcOrderInfoNav" class="nav-link" data-toggle="tab" href="#rcOrderInfoDiv" onclick="reloadOrderList();">주문 진행</a></li>
	                 <li class="nav-item"><a id="cpOrderInfoNav" class="nav-link" data-toggle="tab" href="#cpOrderInfoDiv" onclick="reloadOrderList();">주문 취소</a></li>
             	</ul>
         	</div>
			<div id="panel-1" class="panel OrderPanel">
			     <div class="panel-container">
			         <div class="panel-content">
						<div class="order-count" role="alert">
							<div class="box waiting">
								<div class="order-text">접수 대기</div>
								<div class="order-number"><span class="order-totalAll" id="ocOrderCount">0</span>건 <span class="order-totalMenu" id="ocOrderMenuCnt">0</span>개 메뉴</div>
								<hr class="line">
							</div>
							<div class="box ing">
								<div class="order-text">주문 진행</div>
								<div class="order-number"><span class="order-totalAll" id="rcOrderCount">0</span>건 <span class="order-totalMenu" id="rcOrderMenuCnt">0</span>개 메뉴</div>
								<hr class="line">
							</div>
							<div class="box cancel">
								<div class="order-text">주문 취소 요청</div>
								<div class="order-number"><span class="order-totalAll" id="cpOrderCount">0</span>건 <span class="order-totalMenu" id="cpOrderMenuCnt">0</span>개 메뉴</div>
								<hr class="line">
							</div>
						</div>
			             
			             <div class="tab-content">
			                 <div class="tab-pane fade show active" id="ocOrderInfoDiv" role="tabpanel">
			                 </div>
			                 <div class="tab-pane fade" id="rcOrderInfoDiv" role="tabpanel">
			                 </div>
			                 <div class="tab-pane fade" id="cpOrderInfoDiv" role="tabpanel">
			                 </div>
			             </div>
			         </div>
			     </div>
			 </div>
			 <!-- .ViewOrder Modal -->
			<div class="modal fade orderView-modal" id="orderViewModal" tabindex="-1" role="dialog" aria-hidden="true">
				<div class="layer"></div>
				<!-- <div class="modal-dialog modal-lg" role="document"> -->
				<div class="modal-dialog" role="document">
					<button type="button" class="btn btn-close" data-dismiss="modal"><img src="/resources/quaca/img/close.png"></button>
					<div class="modal-content">
						<div class="modal-header center-block">
							<span class="OrderNum" id="modal_OrderNum">ORDER NO.0</span>
						</div>
						<div class="modal-body" id="modal_body">
						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-secondary" data-dismiss="modal">확인</button>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>		
</main>
<!-- !!메인 영역 -->

<script type="text/javascript">
	
	$(document).ready(function () {
		orderList();
	});
	
	// 탭 클릭 시 리로드처리
	function reloadOrderList(){
		// 건수 호출 하기위해서 전체 호출 처리
		orderList();
	}
	// 주문 정보 리스트 
	function orderList(){
		$.ajax({
			url : express_docker+"orders/OCRCCP",
			type : "POST",
			data : {
				StoreId : "${userVO.storeId}"
			},
			success : function(data){
				if(data.success){
					$("#ocOrderCount").html(data.info.OCOrder.length);
					$("#ocOrderInfoDiv").html(ocOrderHtml(data.info.OCOrder));
					$("#rcOrderCount").html(data.info.RCOrder.length);
					$("#rcOrderInfoDiv").html(rcOrderHtml(data.info.RCOrder));	
					$("#cpOrderCount").html(data.info.CPOrder.length);
					$("#cpOrderInfoDiv").html(cpOrderHtml(data.info.CPOrder));	
				}else{
					$("#ocOrderInfoDiv").html('');
					$("#rcOrderInfoDiv").html('');
					$("#cpOrderInfoDiv").html('');
				}
			},
			error : function(){
				alert("err");
			}		
		});
	}
	// 시간 설정
	function ocOrderTime(id,str){
		$("#"+id+"_time").val(str);
	}
	// 상태 변경(몽고 & 마리아 UPDATE 접수(RC), 제조완료(PC), 픽업완료(PUC))
	function orderUpdate(storeId, userPayId, orderStatus){
 		$.ajax({
			url : express_docker+"orders/OrderUpdate",
			type : "POST",
			data : {
				StoreId : storeId,
				UserPayId : userPayId,
				OrderStatus : orderStatus
			},
			success : function(data){
				if(data.success){
					reloadOrderList();
					// 사용자 알람 처리 
					userAlarm(orderStatus, userPayId);
				}else{
					// 주문 접수 받기전에 주문 취소가 먼저 들어갈경우
					if(data.msg != "error" && orderStatus == "OC"){
						alert(data.msg);
						reloadOrderList();
					}
				}
			},
			error : function(){
				alert("err");
			}
			
		});
	}
	// 주문 취소(몽고 & 마리아 CUP UPDATE + IMPORT)
	function orderCancle(storeId,orderNum,userPayId){
		if(confirm("Order No."+orderNum+" 취소 하시겠습니까?") == true){
	 		$.ajax({
				url : express_docker+"orders/PayCancle",
				type : "POST",
				data : {
					StoreId : storeId,
					UserPayId : userPayId
				},
				success : function(data){
					if(data.success){
						reloadOrderList();
					}else{
						// 주문 접수 받기전에 주문 취소가 먼저 들어갈경우
						if(data.msg != "error" && orderStatus == "OC"){
							alert(data.msg);
							reloadOrderList();
						}
					}
				},
				error : function(){
					alert("err");
				}
			});
		}else{
			return;
		}

	}
	
	// 알람 기능 통합
	function userAlarm(alarmType, userPayId){
		if(alarmType == "RC"){
			$.ajax({
				url : notice_docker+"RCsend",
				type : "POST",
				data : {
					UserPayId : userPayId,
					time : $("#"+userPayId+"_time").val() 
				},
				success : function(data){
					if(data.success){
					}
				},
				error : function(){
					alert("err");
				}
			});		
		}else if(alarmType == "PC"){
			$.ajax({
				url : notice_docker+"PCsend",
				type : "POST",
				data : {
					UserPayId : userPayId
				},
				success : function(data){
					if(data.success){
					}
				},
				error : function(){
					alert("err");
				}
			});	
		}
	}
	
	/* *****************************접수 대기 처리 구간****************** */
	//1-1.[접수대기 목록] - 접수 대기 목록 table html
	function ocOrderHtml(data){
		var ocOrderMenuCnt = 0;
		var html ="";
		for(var i = 0; i < data.length; i++){
			
			ocOrderMenuCnt += data[i].OrderMenu.length;
			
			html += '<div class="card m-auto border" id="'+data[i].UserPayId+'">';
			html += 	'<div class="card-body">';
			html += 		'<div class="blockquote mb-0">';
			html += 		'<div>';
			html += 			'<div class="row">';
			html += 				'<div class="col-7" style="text-align:left">';
			//html += 					'<span class="OrderNum">'+data[i].UserPayId+'</span>';
			html += 					'<span class="OrderNum">ORDER NO.'+data[i].OrderNum+'</span>';
			html += 				'</div>';
			html += 				'<div class="OrderTimeBox">';
			html += 					'<span class="OrderTime"><i>' + data[i].InsertDt.split(" ")[0] + '</i>' + data[i].InsertDt.split(" ")[1]  +'</span>';
			html +=						'<button type="button" class="btn-cancel" onclick="orderCancle(${userVO.storeId},\''+data[i].OrderNum+'\',\''+data[i].UserPayId+'\');">';
			html +=							'주문 취소';
			html +=						'</button>';
			html += 				'</div>';
			html += 			'</div>';
			if(data[i].OrderMenu.length > 0){	
				html += 		'<div class="OrderWrap">';
				for(var j = 0; j < data[i].OrderMenu.length; j++){
					html += 	'<div class="row">';
					html += 		'<span class="OrderName" >'+data[i].OrderMenu[j].MenuName+'</span>';
					html +=         '<span class="OrderCnt">'+data[i].OrderMenu[j].OrderCntDetail+'<span class="OrderCntDetail">개</span>'+'</span>';
					html +=			'<span class ="OrderOption">'+(data[i].OrderMenu[j].OptionA != null && data[i].OrderMenu[j].OptionA != "" ? data[i].OrderMenu[j].OptionA+'/' : '') + (data[i].OrderMenu[j].OptionB != null && data[i].OrderMenu[j].OptionB != "" ? data[i].OrderMenu[j].OptionB+'/' : '') + (data[i].OrderMenu[j].OptionC != null && data[i].OrderMenu[j].OptionC != "" ? data[i].OrderMenu[j].OptionC : '') +'</span>';
					html += 	'</div>';
				}
				if(data[i].OrderMenu.length > 3) {
					html +=			'<div class="OrderMore">'
					html +=				'<button type="button" onclick="orderDetailInfo(\''+data[i].UserPayId+'\', \''+data[i].OrderNum+'\');" class="ViewOrder" data-toggle="modal" data-target="#orderViewModal">주문메뉴 전체보기</button>'
					html +=			'</div>'
				}
				html += 		'</div>';
			}
			html += 			'<div class="row OrderTotal">';
			html += 				'<div class="col-xl-12" style="text-align:right">';
			html += 					'<span class="OrderCntUser">'+'<span class="CntTotal">'+data[i].OrderCnt+'</span>'+'<span class="OrderCntDetail">개</span>  '+' / '+data[i].NickName+' <span class="OrderCntDetail">님</span>'+'</span>';
			html +=					'</div>';
			html +=				'</div>';
			html += 			'</div>';
			html +=				'<div class="row OrderLine" style="margin-bottom:-17px">';
			html +=					'<div class="col-sm-12">'
			html +=						'<input type="hidden" id="'+data[i].UserPayId+'_time" name="'+data[i].UserPayId+'_time" value="곧"/>';
			html +=						'<div class="col-sm-3 col-6 left">'
			html +=							'<button type="button" class="btn btn-outline-dark" onclick="ocOrderTime(\''+data[i].UserPayId+'\','+'\'곧'+'\')">곧</button>';
			html +=							'<button type="button" class="btn btn-outline-dark" onclick="ocOrderTime(\''+data[i].UserPayId+'\','+'\'5분'+'\')">5분</button>';
			html +=						'</div>'
			html +=						'<div class="col-sm-3 col-6 left left2">'
			html +=							'<button type="button" class="btn btn-outline-dark" onclick="ocOrderTime(\''+data[i].UserPayId+'\','+'\'10분'+'\')">10분</button>';
			html +=								'<button type="button" class="btn btn-outline-dark" onclick="ocOrderTime(\''+data[i].UserPayId+'\','+'\'20분'+'\')">20분</button>';
			html +=						'</div>'
			html +=						'<div class="col-sm-6 col-12 right">'
			html += 						'<button type="button" class="btn btn-dark OrderBtn" onclick="orderUpdate(${userVO.storeId},\''+data[i].UserPayId+'\','+'\'RC'+'\');">';
			html += 							'주문 접수';
			html += 						'</button>';
			html +=						'</div>'
			html += 				'</div>';
			html += 			'</div>';
			html += 		'</div>';
			html += 	'</div>';
			html += '</div>';
		}
		// 메뉴  건수 추가 작업
		$("#ocOrderMenuCnt").html(ocOrderMenuCnt);
		return html; 
	}
	
		
	/* *****************************주문 진행 처리 구간****************** */
	//2-1.[주문진행 목록] - 주문 진행 table html
	function rcOrderHtml(data){
		var html ="";
		var rcOrderMenuCnt = 0;
		for(var i = 0; i < data.length; i++){
			
			rcOrderMenuCnt += data[i].OrderMenu.length;
			
			html += '<div class="card m-auto border" id="'+data[i].UserPayId+'">';
			html += 	'<div class="card-body">';
			html += 		'<div class="blockquote mb-0">';
			html += 		'<div style="min-height:280px">';
			html += 			'<div class="row">';
			html += 				'<div class="col-7" style="text-align:left">';
			//html += 					'<span class="OrderNum">'+data[i].UserPayId+'</span>';
			html += 					'<span class="OrderNum">ORDER NO.'+data[i].OrderNum+'</span>';
			html += 				'</div>';
			html += 				'<div class="col-5" style="text-align:right">';
			html += 					'<span class="OrderTime">'+data[i].InsertDt+'</span>';
			html += 				'</div>';
			html += 			'</div>';
			if(data[i].OrderMenu.length > 0){	
				html += 		'<div class="OrderWrap">';
				for(var j = 0; j < data[i].OrderMenu.length; j++){
					html += 	'<div class="row">';
					html += 		'<span class="OrderName" >'+data[i].OrderMenu[j].MenuName+'</span>';
					html +=         '<span class="OrderCnt">'+data[i].OrderMenu[j].OrderCntDetail+'<span class="OrderCntDetail">개</span>'+'</span>';
					html +=			'<span class ="OrderOption">'+(data[i].OrderMenu[j].OptionA != null && data[i].OrderMenu[j].OptionA != "" ? data[i].OrderMenu[j].OptionA+'/' : '') + (data[i].OrderMenu[j].OptionB != null && data[i].OrderMenu[j].OptionB != "" ? data[i].OrderMenu[j].OptionB+'/' : '') + (data[i].OrderMenu[j].OptionC != null && data[i].OrderMenu[j].OptionC != "" ? data[i].OrderMenu[j].OptionC : '') +'</span>';
					html += 	'</div>';
				}
				if(data[i].OrderMenu.length > 3) {
					html +=			'<div class="OrderMore">'
					html +=				'<button type="button" onclick="orderDetailInfo(\''+data[i].UserPayId+'\', \''+data[i].OrderNum+'\');" class="ViewOrder" data-toggle="modal" data-target="#orderViewModal">주문메뉴 전체보기</button>'
					html +=			'</div>'
				}
				html += 		'</div>';
			}
			html += 			'<div class="row OrderTotal">';
			html += 				'<div class="col-xl-12" style="text-align:right">';
			html += 					'<span class="OrderCntUser">'+'<span class="CntTotal">'+data[i].OrderCnt+'</span>'+'<span class="OrderCntDetail">개</span>  '+' / '+data[i].NickName+' <span class="OrderCntDetail">님</span>'+'</span>';
			html +=					'</div>';
			html +=				'</div>';
			html += 			'</div>';
			html +=				'<div class="row OrderLine OrderIng">';
			html +=					'<div class="left">'
			html +=						'<button type="button" class="btn btn-outline-dark" onclick="orderUpdate(${userVO.storeId},\''+data[i].UserPayId+'\','+'\'PC'+'\');" ';
			if(data[i].OrderStatus != 'RC'){
				html +=							' disabled="disabled"';	
			}
			//OrderStatus
			html +=							'>';
			html +=								'제조 완료';
			html +=						'</button>';				
			html +=						'<button type="button" class="btn btn-outline-dark" onclick="orderUpdate(${userVO.storeId},\''+data[i].UserPayId+'\','+'\'PUC'+'\');" ';
			if(data[i].OrderStatus != 'PC'){
				html +=							' disabled="disabled"';	
			}
			html +=							'>';
			html +=								'픽업 완료';
			html +=						'</button>';
			html +=					'</div>';
			html +=					'<div class="right">';
			html +=						'<button type="button" class="btn btn-dark" onclick="orderCancle(${userVO.storeId},\''+data[i].OrderNum+'\',\''+data[i].UserPayId+'\');">';
			html +=							'주문 취소';
			html +=						'</button>';
			html +=					'</div>';
			html +=				'</div>';
			html +=			'</div>';
			html +=		'</div>';
			html +=	'</div>';
		}
		// 메뉴  건수 추가 작업
		$("#rcOrderMenuCnt").html(rcOrderMenuCnt);
		
		return html;
	}
	
	/* *****************************환불 요청 처리 구간****************** */
	//3-1.[환불 요청 목록] - 환불 요청 table html
	function cpOrderHtml(data){
		var html ="";
		var cpOrderMenuCnt = 0;
		for(var i = 0; i < data.length; i++){
			cpOrderMenuCnt += data[i].OrderMenu.length;
			html += '<div class="card m-auto border" id="'+data[i].UserPayId+'">';
			html += 	'<div class="card-body">';
			html += 		'<div class="blockquote mb-0">';
			html += 		'<div style="min-height:280px">';
			html += 			'<div class="row">';
			html += 				'<div class="col-7" style="text-align:left">';
			//html += 					'<span class="OrderNum">'+data[i].UserPayId+'</span>';
			html += 					'<span class="OrderNum">ORDER NO.'+data[i].OrderNum+'</span>';
			html += 				'</div>';
			html += 				'<div class="col-5" style="text-align:right">';
			html += 					'<span class="OrderTime">'+data[i].InsertDt+'</span>';
			html += 				'</div>';
			html += 			'</div>';
			if(data[i].OrderMenu.length > 0){	
				html += 		'<div class="OrderWrap">';
				for(var j = 0; j < data[i].OrderMenu.length; j++){
					html += 	'<div class="row">';
					html += 		'<span class="OrderName" >'+data[i].OrderMenu[j].MenuName+'</span>';
					html +=         '<span class="OrderCnt">'+data[i].OrderMenu[j].OrderCntDetail+'<span class="OrderCntDetail">개</span>'+'</span>';
					html +=			'<span class ="OrderOption">'+(data[i].OrderMenu[j].OptionA != null && data[i].OrderMenu[j].OptionA != "" ? data[i].OrderMenu[j].OptionA+'/' : '') + (data[i].OrderMenu[j].OptionB != null && data[i].OrderMenu[j].OptionB != "" ? data[i].OrderMenu[j].OptionB+'/' : '') + (data[i].OrderMenu[j].OptionC != null && data[i].OrderMenu[j].OptionC != "" ? data[i].OrderMenu[j].OptionC : '') +'</span>';
					html += 	'</div>';
				}
				if(data[i].OrderMenu.length > 3) {
					html +=			'<div class="OrderMore">'
					html +=				'<button type="button" onclick="orderDetailInfo(\''+data[i].UserPayId+'\', \''+data[i].OrderNum+'\');" class="ViewOrder" data-toggle="modal" data-target="#orderViewModal">주문메뉴 전체보기</button>'
					html +=			'</div>'
				}
				html += 		'</div>';
			}
			html += 			'<div class="row OrderTotal">';
			html += 				'<div class="col-xl-12" style="text-align:right">';
			html += 					'<span class="OrderCntUser">'+'<span class="CntTotal">'+data[i].OrderCnt+'</span>'+'<span class="OrderCntDetail">개</span>  '+' / '+data[i].NickName+' <span class="OrderCntDetail">님</span>'+'</span>';
			html +=					'</div>';
			html +=				'</div>';
			html += 			'</div>';
			html +=				'<div class="row OrderLine CancelLine">';
			html +=					'<button type="button" class="btn btn-dark" onclick="orderCancle(${userVO.storeId},\''+data[i].OrderNum+'\',\''+data[i].UserPayId+'\');">';
			html +=						'주문 취소';
			html +=					'</button>';
			html +=				'</div>';
			html +=			'</div>';
			html +=		'</div>';
			html +=	'</div>';
		}
		// 메뉴  건수 추가 작업
		$("#cpOrderMenuCnt").html(cpOrderMenuCnt)
		return html;
	}
	
	//4-1.[주문 상품 상세 보기] - 정보 호출
	function orderDetailInfo(id, num){
		$.ajax({
			url : express_docker+"orders/paymentInfo",
			type : "POST",
			data : {
				UserPayId : id,
			},success : function(data){
				if(data.success){
					$("#modal_body").html('');
					$("#modal_body").html(orderDetailInfoHtml(data.info));
					$("#modal_OrderNum").html('ORDER NO.'+num);
				}else{
					$("#modal_body").html('');
					$("#modal_OrderNum").html('ORDER NO.0');
				}
			},
		});
	}
	//4-2.[주문 상품 상세 보기] - html 그리기 
	function orderDetailInfoHtml(data){
		var html = "";
		
		if(data.OrderMenu.length > 0){
			for(var i = 0; i < data.OrderMenu.length; i++){
				html +=	'<div class="row">';
				html +=		'<span class="OrderName">'+data.OrderMenu[i].MenuName+'</span>';
				html +=		'<span class="OrderCnt">'+data.OrderMenu[i].OrderCnt+'<span class="OrderCntDetail">개</span></span>';
				html +=		'<span class ="OrderOption">'+(data.OrderMenu[i].OptionA != null && data.OrderMenu[i].OptionA != "" ? data.OrderMenu[i].OptionA+'/' : '') + (data.OrderMenu[i].OptionB != null && data.OrderMenu[i].OptionB != "" ? data.OrderMenu[i].OptionB+'/' : '') + (data.OrderMenu[i].OptionC != null && data.OrderMenu[i].OptionC != "" ? data.OrderMenu[i].OptionC : '')+'</span>';
				html +=	'</div>';
			}
		}
		
		return html;
		
	}
	
</script>

<%@ include file="../../footer.jsp" %>