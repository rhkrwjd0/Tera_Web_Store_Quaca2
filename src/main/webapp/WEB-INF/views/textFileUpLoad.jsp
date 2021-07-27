<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>

<html xmlns:th="http://www.thymeleaf.org"
	xmlns:layout="http://www.ultraq.net.nz/thymeleaf/layout"
	data-layout-decorate="~{sample/layout/sampleLayout}"
	>
	
<head>
	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/quaca/js/jquery/jquery-3.6.0.min.js"></script>
</head>
<body>
	 <div class="container">
        <h3>File Upload Test</h3>
        <form id="insertfrm" enctype="multipart/form-data" method="post">
            <div class="form-group">
                <label for="exampleInputFile">File input</label>
                <input type="file" id="file" name="file">
                <input type="hidden" id="storeId" name="storeId" value="1">
				<input type="hidden" id="type" name="type" value="M">
            </div>
            
            <!-- jquery ajax으로 전송하기 -->
            <button type="button" class="btn btn-primary btn-ajax-submit">Ajax Submit</button>
             <input type="submit" value="upload">
    
        </form>
    </div>    	

	<script type="text/javascript">
$(document).ready(function() {
        
        /**
        * Ajax submit
        */
        $('.btn-ajax-submit').on('click', function() {
        	var form = $("#frm-upload")[0];
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
                	alert("complete");
                	console.log(data);
                },          
                error: function (e) {  
                	console.log("ERROR : ", e);     
                    alert("fail");      
                 }     
        	});
        	
        });
});        
	</script>
</body>



</html>