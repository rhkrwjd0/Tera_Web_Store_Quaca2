<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

            		<!-- 푸터 영역 -->
            		<%@ include file="include/footer.jsp" %>
            		<!-- !!푸터 영역 -->
            		
            		<!-- 컬러프로필? 영역 -->
            		<%@ include file="include/profile.jsp" %>
            		<!-- !!컬러프로필? 영역 -->
            	</div>
            </div>
        </div>
        
                    		
   		<!-- 퀵메뉴 영역 -->
   		<%@ include file="include/quickMenu.jsp" %>
   		<!-- !!퀵메뉴 영역 -->
   	    
   	    <!-- pageSettings 영역 -->
   		<%@ include file="include/pageSettings.jsp" %>
   		<!-- !!pageSettings 영역 -->

<script src="${pageContext.request.contextPath}/resources/quaca/js/vendors.bundle.js"></script>
<script src="${pageContext.request.contextPath}/resources/quaca/js/app.bundle.js"></script>
                     
<script type="text/javascript">
    /* Activate smart panels */
    $('#js-page-content').smartPanel();
    
    $(document).ready(function () {
    	// 날짜 형식 설정
    	var getTodayDate = new Date();
    	var todayYear = getTodayDate.getFullYear();
    	var todayMonth = getTodayDate.getMonth() + 1;
    	if (todayMonth < 10) {
    		todayMonth = '0' + todayMonth;
    	}
    	var todayDay = getTodayDate.getDate();
    	if (todayDay < 10) {
    		todayDay = '0' + todayDay;
    	}
    	var todayDate = todayYear + '.' + todayMonth + '.' + todayDay;
    	
    	$('.js-get-date').text(todayDate);
	});
</script>
        
</body>
</html>