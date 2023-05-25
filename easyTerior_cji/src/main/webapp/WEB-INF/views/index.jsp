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
</script>
<title>EasyTerior</title>
</head>
<body>
<main class="main">
	<jsp:include page="common/header.jsp"></jsp:include>
	<jsp:include page="common/submenu.jsp"></jsp:include>
	<!-- section 안에 div 넣고 하기 -->
	<section class="fixed-top container-fluid overflow-auto h-100" style="margin:137px 0 56px 0;padding:0 0 56px 100px;">
		<div class="container justify-content-center m-auto" style="min-height:100vh;">
			<div id="carouselExampleCaptions" class="carousel slide carousel-fade carousel-dark mt-5" data-bs-ride="carousel">
			    <div class="carousel-indicators">
			        <button type="button" data-bs-target="#carouselExampleCaptions" data-bs-slide-to="0" class="active" aria-current="true" aria-label="Slide 1"></button>
			        <button type="button" data-bs-target="#carouselExampleCaptions" data-bs-slide-to="1" aria-label="Slide 2"></button>
			        <button type="button" data-bs-target="#carouselExampleCaptions" data-bs-slide-to="2" aria-label="Slide 3"></button>
			    </div>
			    <div class="carousel-inner">
			        <div class="carousel-item active" data-bs-interval="3000">
			        	<div class="d-block w-50 float-start mt-5 text-center">
			        		<h5 class="fw-bold fs-2 mb-5">방 사진을 올려보세요!<br/>스타일 분석을 해드려요</h5>
			        		<span class="mt-3 mb-3 d-block">당신의 방이 어떤 스타일인지 궁금하지 않으신가요?<br/>방 사진을 업로드하면 확인할 수 있어요!<br/>취향에 맞는 인테리어 상품 추천까지 해드려요.</span>
			        		<a href="${ contextPath }/styleRoom.do" class="d-inline-block m-auto btn btn-primary">분석하러 가기</a>
			        	</div>
			            <a href="#" class="d-block w-50 float-end"><img class="d-block w-100" src="${ contextPath }/resources/images/common/styleRoom.jpg" alt="styleRoom"></a>
			        </div>
			        <div class="carousel-item" data-bs-interval="3000">
			        	<div class="d-block w-50 float-start mt-5 text-center">
			        		<h5 class="fw-bold fs-2 mb-5">방 사진 속 소품의 색깔을 <br/>변경해보세요!</h5>
			        		<span class="mt-3 mb-3 d-block">사진 속 소품의 컬러를 변경하고 적용시켜보세요.<br/>분위기에 맞는 소품과 컬러까지 추천해드려요.</span>
			        		<a href="${ contextPath }/colorChange.do" class="d-inline-block m-auto btn btn-primary">색깔 변경하기</a>
			        	</div>
			            <a href="#" class="d-block w-50 float-end"><img class="d-block w-100" src="${ contextPath }/resources/images/common/colorChange.jpg" alt="colorChange"></a>
			        </div>
			        <div class="carousel-item" data-bs-interval="3000">
			        	<div class="d-block w-50 float-start mt-5 text-center">
			        		<h5 class="fw-bold fs-2 mb-5">커뮤니티에서 당신의 <br/>스타일을 자랑해보세요!</h5>
			        		<span class="mt-3 mb-3 d-block">당신이 변경한 스타일을 자랑해보세요.<br/>서로에게 추천받고 질문해봅시다.</span>
			        		<a href="${ contextPath }/boardMain.do" class="d-inline-block m-auto btn btn-primary">커뮤니티 가기</a>
			        	</div>
			            <a href="#" class="d-block w-50 float-end"><img src="${ contextPath }/resources/images/common/community.jpg" class="d-block w-100" alt="community"></a>
			        </div>
			    </div>

			</div>
		</div>
	</section>
	<jsp:include page="common/footer.jsp"></jsp:include>
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