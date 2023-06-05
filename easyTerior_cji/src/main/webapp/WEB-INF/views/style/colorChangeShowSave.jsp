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

    <!-- jQuery library -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

    <!-- bxSlider Javascript file -->
    <script src="https://cdn.jsdelivr.net/bxslider/4.2.12/jquery.bxslider.min.js"></script>

    <!-- bxSlider CSS file -->
    <link href="https://cdn.jsdelivr.net/bxslider/4.2.12/jquery.bxslider.css" rel="stylesheet" />

<script>
	function saveImage() {
		  var imageUrl = 'http://127.0.0.1:5000/images/processed_image.jpg';
		  var fileName = prompt('저장할 파일 이름을 입력하세요.', 'processed_image.jpg');
		  
		  if (fileName) {
		    var link = document.createElement('a');
		    link.href = imageUrl;
		    link.download = fileName;
		    link.style.display = 'none';
		    document.body.appendChild(link);
		    link.click();
		    document.body.removeChild(link);
		  }
		}
	</script>

<script type="text/javascript">
$(document).ready(function(){
    $('.bxslider').bxSlider({
        minSlides: 4, //한번에 보여질 슬라이드 최소 개수
        maxSlides: 4, //최대 개수
        moveSlides: 1, //한번에 움직이는 슬라이드 개수
        slideWidth: 360, // 각 슬라이드의 폭 크기
        slideMargin: 5, // 슬라이드 간 여백
        mode: 'horizontal',
        auto:true, //자동
        pause:3000,
        speed:1000
    });
});
</script>
 		  
<style>
body, main, section {
position: relative;
}
    .green-button {
      background-color: green;
      color: white;
    }
 .pline{
 		font-size: 20px;  /* 글자 크기 설정 */
	    font-weight:bold;
	    text-align:center;
	    margin-top:20px;
	    margin-bottom:20px;
 
 }  
	#resultbutton{
	
		border-radius: 12px;  /* 둥근 모서리를 원하는 크기로 설정 */
		background-color: #62B2E4;  /* 버튼의 배경 색상 설정 */ -->
		padding: 10px 20px;  /* 버튼 내부의 공간 설정 */
		border: none;  /* 버튼 테두리 제거 */
		cursor: pointer;  /* 마우스 커서 모양 변경 */
		color: white;  /* 버튼의 글자 색상 설정 */
	    font-size: 30px;  /* 글자 크기 설정 */
	    font-weight:bold;
	    margin:0 auto;
	    width: 300px; /* 버튼의 너비 설정 */
    	height: 50px; /* 버튼의 높이 설정 */
	}
	#resultbutton:hover {
        background-color: #0895C4;  /* 배경 색상 변경 */
    }
	.bx-prev {
	  width:100%;
	}
</style>
<title>EasyTerior</title>
</head>
<body>
<main class="main">
	<jsp:include page="../common/header.jsp"></jsp:include>
	<jsp:include page="../common/submenu.jsp"></jsp:include>
	<section class="fixed-top container-fluid overflow-auto h-100" style="margin:137px 0 56px 0;padding:0 0 56px 100px;">
		<h1 class="text-center mt-4 mb-3 fw-bold">소품 색 변경 결과</h1></br>
		<!-- 실질 컨텐츠 위치 -->
		<div class="container-fluid" style="min-height:100vh;margin-bottom:200px;">
			<div class="row m-auto" style="width:80%">
			    <div class="col-sm-13">
			        <div class="card border-0">
			            <img src="http://127.0.0.1:5000/images/processed_image.jpg" alt="Processed Image" style="display: block; margin: 0 auto; width: 540px; height: 320px;">
			        </div>
			        <div class="row text-center">
			            <%
       					 String data = request.getParameter("data");
			            data = data.substring(1, data.length()-1); // Remove brackets
			            String[] rgbValues = data.split(", "); // Split by comma and space
    						%>
    						<p class="pline">선택하신 컬러의 RGB 값은 R <%= rgbValues[0]%>, G <%= rgbValues[1]%>, B <%= rgbValues[2]%> 입니다.</p>
					</div>
			    </div>
			    <button id="resultbutton" type="button">변경된 사진 저장</button>
			    </br>
			    <p class="pline">이 색깔과 관련된 인테리어 소품을 추천해드릴게요!</p></br>
			    	<div class="bxslider">
					<c:forEach var="url" items="${image_urls}">
				   	 	<img src="${url}" width="240px" height="160px">
					</c:forEach>	
				</div>
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