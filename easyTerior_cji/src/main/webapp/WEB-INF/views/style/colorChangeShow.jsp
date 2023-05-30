<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %><%-- JSTL --%>
<c:set var="contextPath" value="${ pageContext.request.contextPath }" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css"><!-- icons -->
<link href="https://cdn.jsdelivr.net/npm/boxicons@latest/css/boxicons.min.css"
rel="stylesheet" /><!-- icons -->
<script src="https://cdn.jsdelivr.net/npm/jquery@3.6.4/dist/jquery.min.js"></script>
<script>
		$(document).ready(function() {
		    $.getJSON('http://127.0.0.1:5000//get_objects', function(data) {
		        for (var key in data) {
		            var value = data[key];
		            var button = $('<button>').text(value);
		            button.attr("data-class-id", key);
		            button.click(function() {
		                var class_id = $(this).attr("data-class-id");
		                var selectedColor = $('input[name="favcolor"]').val();
		                sendColorChangeRequest(class_id, selectedColor);
		            });
		            $('#buttons_container').append(button);
		        }
		    });
		});
		
		function sendColorChangeRequest(class_id, color) {
		    $.ajax({
		        url: 'http://127.0.0.1:5000/process_image2',
		        type: 'post',
		        data: {
		            'class_id': class_id,
		            'color': color
		        },
		        success: function(data) {
		            // Do something on success
		        }
		    });
		}
</script>
<style>
body, main, section {
position: relative;
}
</style>

<title>EasyTerior</title>
</head>
<body>
<main class="main">
	<jsp:include page="../common/header.jsp"></jsp:include>
	<jsp:include page="../common/submenu.jsp"></jsp:include>
	<section class="fixed-top container-fluid overflow-auto h-100" style="margin:137px 0 56px 0;padding:0 0 56px 100px;">
		<h1 class="text-center mt-4 mb-3">소품 색 변경하기</h1>
		<!-- 실질 컨텐츠 위치 -->
		<div class="container-fluid" style="min-height:100vh;margin-bottom:200px;">
			<div class="row m-auto" style="width:80%">
			    <div class="col-sm-6">
			        <div class="card border-0">
			            <div class="card-body">
			                <h5 class="card-title text-center fw-bold">업로드한 사진</h5>
			            </div>
			            <img src="http://127.0.0.1:5000/images/processed_image.jpg" alt="Processed Image" style="width: 480px; height: 480x;">
			        </div>
			    </div>
			    <div class="col-sm-6">
			        <div class="card border-0">
			            <div class="card-body">
			                <h5 class="card-title text-center mb-4 fw-bold">색깔을 변경할 소품을 클릭해주세요</h5>
			                	<div>
			                	<button id="bed">침대</button>
			                	<button id=">이불</button>
			                	<button>카펫</button>
			                	<button>의자</button>
			                	<button>문</button>
			                	<button>램프</button>
			                	<button>베개</button>
			                	<button>선반</button>
			                	<button>소파</button>
			                	<button>테이블</button>
			                	</div>
			                    <div>
			                    <h6 class="card-title text-center mb-4 fw-bold">색상을 선택해주세요</h5>
			                    Select color: <input type="color" name="favcolor" value="#ff0000"><br>
			                    </div>
			                <p class="card-text text-center" style="padding:90px 0 0 0;"><br/> <br/><br/><br/></p>
			            </div>
			            <input type="submit" value="색상 변경하기">
			        </div>
			    </div>
			</div>
			<div class="row text-center" style="padding-top:50px;">
			</div>		  
		</div>
	</section>
	<jsp:include page="../common/footer.jsp"></jsp:include>
</main>

<!-- The Modal -->
<div class="modal fade" id="myModal"><!-- animation : fade -->
    <div class="modal-dialog">
        <div id="checkType" class="card modal-content">
            <!-- Modal Header -->
            <div class="modal-header card-header">
                <h4 class="modal-title text-center">${ msgType }</h4>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <!-- Modal body -->
            <div class="modal-body">
                <p id="checkMessage" class="text-center">${ msg }</p>
            </div>
            <!-- Modal footer -->
            <div class="modal-footer">
                <button type="button" class="btn btn-danger" data-bs-dismiss="modal">닫기</button>
            </div>
        </div>
    </div>
</div>

<script type="text/javascript">

</script>
</body>
</html>