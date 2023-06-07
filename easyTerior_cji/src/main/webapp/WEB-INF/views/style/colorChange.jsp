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
<style>
body, main, section {
position: relative;
}
     .alert5 {
         color: red;
         border: 1px solid red;
         padding: 10px;
         margin-bottom: 10px;
     }

</style>
<script type="text/javascript">
	$(document).ready(function(){
		// 회원가입 후 modal 표시
		if(${ not empty msgType}){
			if(${msgType eq "성공 메세지"}){ // MemberController.java에서 rttr.addFlashAttribute("msgType", "성공 메세지");로 보냄
				$("#checkType .modal-header.card-header").attr("class", "modal-header card-header bg-success");
			}
			$("#myModal").modal("show");
		}
		
	});
	
	function submitForm() {
	    // Submit the form
	    document.querySelector('form').submit();
	}
	  
	  
</script>
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
			    	<c:if test="${not empty param.message}">
				        <div class="alert5">
				            <strong>객체가 검출되지 않았습니다.</strong>
				            </br>${param.message}
				        </div>
				        				    </c:if>
			        <div class="card border-0">
			            <div class="card-body">
			                <h5 class="card-title text-center fw-bold">예시 이미지</h5>
			            </div>
			            <img class="card-img-bottom" src="${ contextPath }/resources/images/common/colorChange.jpg" alt="colorChange">
			        </div>
			    </div>
			    <div class="col-sm-6">
			        <div class="card border-0">
			            <div class="card-body">
			                <h5 class="card-title text-center mb-4 fw-bold">이미지 가이드라인</h5>
			                <p class="card-text text-center" style="padding:90px 0 0 0;">소파, 침대, 커튼, 테이블, 의자의 색을 변경해볼 수 있어요!<br/> <br/>사물의 색을 변경해보고 싶다면<br/>위 사물 중 하나 이상 포함된 사진을 업로드해주세요.<br/><br/>사물이 명확히 나온 사진만 인식이 가능합니다.</p>
			            </div>
			        </div>
			    </div>
			</div>
			<div class="row text-center" style="padding-top:50px;">
				<form action="http://127.0.0.1:5000/process_image2" method="POST" enctype="multipart/form-data" class="text-center">
					<input type="hidden" name="${ _csrf.parameterName }" value="${ _csrf.token }" />
					<label for="imgUpload" class="btn btn-primary d-block m-auto ps-2 fw-bold" style="width:260px">사진 업로드</label>
					<input type="file" id="imgUpload" name="image" class="invisible">
					<input type="submit" value="Submit" style="display:none;" />
					
				</form>
				<button onclick ="submitForm()">등록하기</button>
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