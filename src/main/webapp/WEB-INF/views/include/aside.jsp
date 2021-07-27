<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
				<!-- BEGIN Left Aside -->
                <aside class="page-sidebar">
                    <div class="page-logo">
                    	<c:if test="${userVO.theme != 'null'}">
	                        <img src="${pageContext.request.contextPath}/resources/quaca/img/${userVO.theme}/logo.svg" alt="Logo" aria-roledescription="logo">
                    	</c:if>
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
                            <%-- <img src="${pageContext.request.contextPath}/resources/quaca/img/demo/avatars/avatar-admin.png" class="profile-image rounded-circle" alt="Dr. Codex Lantern"> --%>
                            <!-- <div class="info-card-text">
                                <a href="#" class="d-flex align-items-center text-white">
                                    <span class="text-truncate text-truncate-sm d-inline-block">
                                        Dr. Codex Lantern
                                    </span>
                                </a>
                                <span class="d-inline-block text-truncate text-truncate-sm">Toronto, Canada</span>
                            </div> -->
                            <img src="${pageContext.request.contextPath}/resources/quaca/img/card-backgrounds/cover-2-lg.png" class="cover" alt="cover">
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
		{ "menuCd" : "002", "menuName" : "DashBoard", "href" : "/quaca/main", "dataFilterTags" : "pages DashBoard", "icon" : "fal fa-info-circle"
			,"item" : []	
		},
		
		{ "menuCd" : "003", "menuName" : "결제 정보", "href" : "#", "icon" : "fal fa-window"
			,"item" : [				
				{ "menuCd" : "003001", "menuName" : "주문 정보", "href" : "/quaca/orders/orderInfo", "dataFilterTags" : "pages 주문 정보 order"},
				{ "menuCd" : "003002", "menuName" : "주문 내역", "href" : "/quaca/orders/paymentList", "dataFilterTags" : "pages 주문 내역 payment"},
			]
		},
		
		{ "menuCd" : "004", "menuName" : "매장 분석", "href" : "#", "icon" : "fal fa-chart-pie"
			,"item" : [
				{ "menuCd" : "004001", "menuName" : "매출 달력", "href" : "/quaca/stats/calendar", "dataFilterTags" : "pages 매출 달력 calendar"},
				{ "menuCd" : "004002", "menuName" : "매출 분석", "href" : "/quaca/stats/sales", "dataFilterTags" : "pages 매출 분석 sales"},
				{ "menuCd" : "004003", "menuName" : "영업 분석", "href" : "/quaca/stats/time", "dataFilterTags" : "pages 영업 분석 time"},
				{ "menuCd" : "004004", "menuName" : "상품 분석", "href" : "/quaca/stats/menu", "dataFilterTags" : "pages 상품 분석 menu"},				
			]
		},
		
		{ "menuCd" : "005", "menuName" : "매장 관리", "href" : "#", "icon" : "fal fa-edit"
			,"item" : [				
				{ "menuCd" : "005001", "menuName" : "매장 정보 관리", "href" : "/quaca/store/storeInfo", "dataFilterTags" : "pages 매장 store"},
				{ "menuCd" : "005002", "menuName" : "카테고리 관리", "href" : "/quaca/store/categoryList", "dataFilterTags" : "pages 카테고리 category"},
				{ "menuCd" : "005003", "menuName" : "상품 관리", "href" : "/quaca/store/menuList", "dataFilterTags" : "pages 상품 menu"},
				{ "menuCd" : "005004", "menuName" : "직원 관리", "href" : "/quaca/store/staffList", "dataFilterTags" : "pages 직원 staff"},
				{ "menuCd" : "005005", "menuName" : "행사 관리", "href" : "/quaca/store/eventList", "dataFilterTags" : "pages 행사 event"},
			]
		},
		{ "menuCd" : "006", "menuName" : "재고 관리", "href" : "#", "icon" : "fal fa-th-list"
			,"item" : [
				{ "menuCd" : "006001", "menuName" : "재고 관리", "href" : "/quaca/stock/stockList", "dataFilterTags" : "pages 재고 stock"},				
			]	
		},
		
		{ "menuCd" : "007", "menuName" : "고객 관리", "href" : "#", "icon" : "fal fa-shield-alt"
			,"item" : [
				{ "menuCd" : "007001", "menuName" : "고객 관리", "href" : "/quaca/member/memberList", "dataFilterTags" : "pages 고객 member"},				
			]	
		},
		
		{ "menuCd" : "008", "menuName" : "게시판", "href" : "#", "icon" : "fal fa-credit-card-front"
			,"item" : [
				{ "menuCd" : "008001", "menuName" : "공지 사항", "href" : "/quaca/board/noticeList", "dataFilterTags" : "pages 공지 notice"},
				{ "menuCd" : "008002", "menuName" : "1:1 문의내역", "href" : "/quaca/board/suggestList", "dataFilterTags" : "pages 1:1 문의내역 suggest"},
				{ "menuCd" : "008003", "menuName" : "자주하는 질문", "href" : "/quaca/board/inquireList", "dataFilterTags" : "pages 자주하는 질문 inquire"},				
			]	
		},
	] 
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
		html +=         '<i class="'+menuList[i].icon+'"></i>';
		html +=         '<span class="nav-link-text" >'+menuList[i].menuName+'</span>';
        html += 		'<span class="dl-ref bg-primary-500 hidden-nav-function-minify hidden-nav-function-top" id="span'+menuList[i].menuCd+'"></span>';
		html +=     '</a>';
		
		if(menuList[i].item.length > 0){
			html +=     '<ul>';
			for(var j = 0; j < menuList[i].item.length; j++){
				html += '<li ';
				if(menuCd == menuList[i].item[j].menuCd){
					html += 'class="active"';		
				}
				html += ' >';
				html +=             '<a href="'+menuList[i].item[j].href+'" title="'+menuList[i].item[j].menuName+'" data-filter-tags="'+menuList[i].item[j].dataFilterTags+'">';
				html +=                 '<span class="nav-link-text" >'+menuList[i].item[j].menuName+'</span>';
				html +=             '</a>';
				html +=         '</li>';    				
			}
			html +=     '</ul>';			
		}
		html += '</li>';
	}
	$("#js-nav-menu").html(html);
	
</script>
                <!-- END Left Aside -->