<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
				<!-- BEGIN Left Aside -->
                <aside class="page-sidebar">
                    <div class="page-logo">
                        <!-- <a href="#" class="page-logo-link press-scale-down d-flex align-items-center position-relative" data-toggle="modal" data-target="#modal-shortcut">
                            <img src="resources/quaca/img/logo.png" alt="SmartAdmin WebApp" aria-roledescription="logo">
                            <span class="page-logo-text mr-1">SmartAdmin WebApp</span>
                            <span class="position-absolute text-white opacity-50 small pos-top pos-right mr-2 mt-n2"></span>
                            <i class="fal fa-angle-down d-inline-block ml-1 fs-lg color-primary-300"></i>
                        </a>-->
                    </div>
                    <!-- BEGIN PRIMARY NAVIGATION -->
                    <nav id="js-primary-nav" class="primary-nav" role="navigation">
                    	<!-- 검색창 -->
                        <div class="nav-filter">
                            <div class="position-relative">
                                <input type="text" id="nav_filter_input" placeholder="Filter menu" class="form-control" tabindex="0">
                                <a href="#" onclick="return false;" class="btn-primary btn-search-close js-waves-off" data-action="toggle" data-class="list-filter-active" data-target=".page-sidebar">
                                    <i class="fal fa-chevron-up"></i>
                                </a>
                            </div>
                        </div>
                       <!-- //검색창 -->
                       <!-- 프로필 구간  -->
                        <div class="info-card">
                           <!-- <img src="resources/quaca/img/demo/avatars/avatar-admin.png" class="profile-image rounded-circle" alt="Dr. Codex Lantern"> --> 
                           
                            <!-- <img src="resources/quaca/img/card-backgrounds/cover-2-lg.png" class="cover" alt="cover"> -->
                            <a href="#" onclick="return false;" class="pull-trigger-btn" data-action="toggle" data-class="list-filter-active" data-target=".page-sidebar" data-focus="nav_filter_input">
                                <i class="fal fa-angle-down"></i>
                            </a>
                        </div>
                       <!-- //프로필 구간  --> 
                        <ul id="js-nav-menu" class="nav-menu">
                            <!-- class="active open" -->
                            
                        </ul>
                        <div class="filter-message js-filter-message bg-success-600"></div>
                    </nav>
                    <!-- END PRIMARY NAVIGATION -->
                  
                </aside>

<script type="text/javascript">
	var menuList =[		
		{ "menuCd" : "002", "menuName" : "DashBoard", "href" : "/quaca/main", "data-filter-tags" : "pages DashBoard"
			,"item" : []	
		},
		
		{ "menuCd" : "003", "menuName" : "결제 정보", "href" : "#"
			,"item" : [				
				{ "menuCd" : "003001", "menuName" : "주문 정보", "href" : "/quaca/orders/orderInfo", "data-filter-tags" : "pages 주문 정보 order"},
				{ "menuCd" : "003002", "menuName" : "주문 내역", "href" : "/quaca/orders/paymentList", "data-filter-tags" : "pages 주문 내역 payment"},
			]
		},
		
		{ "menuCd" : "004", "menuName" : "매장 분석", "href" : "#"
			,"item" : [
				{ "menuCd" : "004001", "menuName" : "매출 달력", "href" : "/quaca/stats/calendar", "data-filter-tags" : "pages 매출 달력 calendar"},
				{ "menuCd" : "004002", "menuName" : "매출 분석", "href" : "/quaca/stats/sales", "data-filter-tags" : "pages 매출 분석 sales"},
				{ "menuCd" : "004003", "menuName" : "영업 분석", "href" : "/quaca/stats/time", "data-filter-tags" : "pages 영업 분석 time"},
				{ "menuCd" : "004004", "menuName" : "상품 분석", "href" : "/quaca/stats/menu", "data-filter-tags" : "pages 상품 분석 menu"},				
			]
		},
		
		{ "menuCd" : "005", "menuName" : "매장 관리", "href" : "#"
			,"item" : [				
				{ "menuCd" : "005001", "menuName" : "매장 정보 관리", "href" : "/quaca/store/storeInfo", "data-filter-tags" : "pages 매장 store"},
				{ "menuCd" : "005002", "menuName" : "카테고리 관리", "href" : "/quaca/store/categoryList", "data-filter-tags" : "pages 카테고리 category"},
				{ "menuCd" : "005003", "menuName" : "상품 관리", "href" : "/quaca/store/menuList", "data-filter-tags" : "pages 상품 menu"},
				{ "menuCd" : "005004", "menuName" : "직원 관리", "href" : "/quaca/store/staffList", "data-filter-tags" : "pages 직원 staff"},
				{ "menuCd" : "005005", "menuName" : "행사 관리", "href" : "/quaca/store/eventList", "data-filter-tags" : "pages 행사 event"},
			]
		},
		{ "menuCd" : "006", "menuName" : "재고 관리", "href" : "#"
			,"item" : [
				{ "menuCd" : "006001", "menuName" : "재고 관리", "href" : "/quaca/stock/stockList", "data-filter-tags" : "pages 재고 stock"},				
			]	
		},
		
		{ "menuCd" : "007", "menuName" : "고객 관리", "href" : "#"
			,"item" : [
				{ "menuCd" : "007001", "menuName" : "고객 관리", "href" : "/quaca/member/memberList", "data-filter-tags" : "pages 고객 member"},				
			]	
		},
		
		{ "menuCd" : "008", "menuName" : "게시판", "href" : "#"
			,"item" : [
				{ "menuCd" : "008001", "menuName" : "공지 사항", "href" : "/quaca/board/noticeList", "data-filter-tags" : "pages 공지 notice"},
				{ "menuCd" : "008002", "menuName" : "건의 사항", "href" : "/quaca/board/suggestList", "data-filter-tags" : "pages 건의 suggest"},
				{ "menuCd" : "008003", "menuName" : "문의 사항", "href" : "/quaca/board/inquireList", "data-filter-tags" : "pages 문의 inquire"},				
			]	
		},
	] 
	// <a href="javascript:goLink(\'' + e.menuType + '\', \'' + e.menuUrl+ '\', \'' + e.menuCd + '\', \'' + e.menuLink + '\')">' + e.menuNm + '</a>
	//'<li><a href="javascript:goLink(\'' + e.menuType + '\', \'' + e.menuUrl+ '\', \'' + e.menuCd + '\', \'' + e.menuLink + '\')">' + e.menuNm + '</a></li>'
	//<li class="active open">
	//<li class="active">
	var menuCd = "${menuVO.menuCd}";
	var html = "";
	for(var i = 0; i < menuList.length; i++){
		html += '<li ';
		if(menuList[i].item.length == 0 && menuCd.substring(0,3) == menuList[i].menuCd){
			html += 'class="active"';
		}else if(menuList[i].item.length > 0 && menuCd.substring(0,3) == menuList[i].menuCd){
			html += 'class="active open"';
		}
		html += ' >';
		
		html +=     '<a href="'+menuList[i].href+'" title="'+menuList[i].menuName+'">';
		html +=         '<i class="fal fa-cog"></i>';
		html +=         '<span class="nav-link-text" >'+menuList[i].menuName+'</span>';
		html +=     '</a>';
		
		if(menuList[i].item.length > 0){
			html +=     '<ul>';
			for(var j = 0; j < menuList[i].item.length; j++){
				html += '<li ';
				if(menuCd == menuList[i].item[j].menuCd){
					html += 'class="active"';		
				}
				html += ' >';
				html +=             '<a href="'+menuList[i].item[j].href+'" title="'+menuList[i].item[j].menuName+'" data-filter-tags="'+menuList[i].item[j].data-filter-tags+'">';
				html +=                 '<span class="nav-link-text" >'+menuList[i].item[j].menuName+'</span>';
				html +=             '</a>';
				html +=         '</li>';    				
			}
			html +=     '</ul>';			
		}
		html += '</li>';
	}
	$("#js-nav-menu").append(html);
	
	function goLink(menuCd, href){
		
	}
</script>
                <!-- END Left Aside -->