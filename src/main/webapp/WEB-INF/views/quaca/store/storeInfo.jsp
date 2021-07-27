<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../../header.jsp" %>

<!-- 메인 영역 -->
<main id="js-page-content" role="main" class="page-content store-info">
	<div class="store-info-top">
		<ol class="breadcrumb page-breadcrumb">
	        <li class="breadcrumb-item"><a href="javascript:void(0);">Quaca</a></li>
	        <li class="breadcrumb-item">in 매장 관리</li>
	        <li class="breadcrumb-item active">매장 정보 관리</li>
	        <li class="position-absolute pos-top pos-right d-none d-sm-block"><span class="js-get-date"></span></li>
	    </ol>
		<button class="btn btn-primary modify-store-btn" onclick="goStoreUpdate();">매장정보 수정</button>
	</div>
	<div class="store-cont">
		<div class="store-information">
			<div id="panel-1" class="panel">
				<div class="panel-container">
					<div class="panel-content">
						<h2>STORE INFORMATION</h2>
						<div class="store-info-cont">
							<div class="form-group row store-info-img">
								<div id="mainImg"></div>
							</div>
							<div class="store-info-txt">
								<div class="form-group row">
									<p class="col-12 col-lg-12" id="storeName"></p>
								</div>
								<div class="form-group row store-addr">
									<p class="col-12 col-lg-12" id="addr1"></p>
									<p class="col-12 col-lg-12" id="addr2"></p>
								</div>
							</div>
							<div class="row store-info-detail">
								<div class="col-xl-4 col-lg-12 col-sm-4 col-12">
									<div class="p-3 rounded detail-box" style="background-color: #fbfbfb;">
										<div class="text-center">
											<span id="tel"></span>
											<br>
											<small class="m-0 l-h-n">Contact</small>
										</div>
									</div>
								</div>
								<div class="col-xl-4 col-lg-12 col-sm-4 col-12">
									<div class="p-3 rounded detail-box" style="background-color: #fbfbfb;">
										<div class="text-center">
											<span id="time"></span>
											<br>
											<small class="m-0 l-h-n">Opening hours</small>
										</div>
									</div>
								</div>
								<div class="col-xl-4 col-lg-12 col-sm-4 col-12">
									<div class="p-3 rounded detail-box" style="background-color: #fbfbfb;">
										<div class="text-center">
											<span id="dayOff"></span>
											<br>
											<small class="m-0 l-h-n">Closed</small>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="store-location">
			<div id="panel-2" class="panel">
				<div class="panel-container">
					<div class="panel-content">
						<h2>STORE LOCATION</h2>
						<div class="map-wrap">
							<div id="map" style="width:100%;height:100%;"></div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
   
</main>
<!-- !!메인 영역 -->
<%@ include file="../../footer.jsp" %>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=2ee8f9550f60db397eab55a4204eb995"></script>
<script type="text/javascript">

		$(document).ready(function () {
			$(".panel-hdr").children(".panel-toolbar").remove();
			storeInfo();	// 데이터 호출
		});
		
		
		//1.[매장정보 호출] - 매장 정보 가져오기 
		function storeInfo(){
			console.log("!@!@!@!@111111");
			$.ajax({
				url : express_docker+"store/storeInfo",
				type : "POST",
				data : {
					StoreId : "${userVO.storeId}"
				},success : function(data){
					console.log("!@!@!@!@2222222");
					if(data.success){
						var path = "/resources/quaca/img/noimg.jpg";
						if(data.info.FileId != null && data.info.FileId != ""){
							path = "/"+data.info.FilePath+data.info.FileEncNm;
						}
						var imgHtml = "";
						imgHtml = '<img class="img-responsive" src="'+path+'" alt="대표이미지" >';
						$("#mainImg").html(imgHtml);
						$("#storeName").html(data.info.StoreName);
						$("#time").html(data.info.OpenTime+' ~ '+data.info.CloseTime);
						$("#dayOff").html(data.info.DayOff);
						$("#tel").html(data.info.TelNo);
						$("#addr1").html(data.info.Addr1);
						$("#addr2").html(data.info.Addr2);
						kakaoMap(data.info.Lat, data.info.Lon);
						
					}else{
						alert("정보를 불러오지 못했습니다.");
					}
				},
				error : function(){
					alert("err");
				}		
			});
		}
		
		//2.[매장정보 호출] - 등록된 위도 경도 값으로 카카오 MAP 그리기 
		function kakaoMap(lat, lon){

			var container = document.getElementById('map');
			var options = { //지도를 생성할 때 필요한 기본 옵션
				center: new kakao.maps.LatLng(lat, lon), //지도의 중심좌표.
				//center: new kakao.maps.LatLng(33.450701, 126.570667),
				level: 3 //지도의 레벨(확대, 축소 정도)
			};

			var map = new kakao.maps.Map(container, options); //지도 생성 및 객체 리턴
			// 지도를 클릭한 위치에 표출할 마커입니다
			var marker = new kakao.maps.Marker({ 
			    // 지도 중심좌표에 마커를 생성합니다 
			    position: map.getCenter() 
			}); 
			// 지도에 마커를 표시합니다
			marker.setMap(map);
		}
		// 매장 수정화면으로 이동
		function goStoreUpdate(){
			location.href="/quaca/store/storeUpdate";	
		}
		
</script>
