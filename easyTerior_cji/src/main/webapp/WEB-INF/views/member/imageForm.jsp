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
<script src="https://cdn.jsdelivr.net/npm/jquery@3.6.4/dist/jquery.min.js"></script>
<script type="text/javascript">
	$(document).ready(function(){
		// 프로필 이미지 업로드 후 modal 표시
		if(${ not empty msgType}){
			if(${msgType eq "실패 메세지"}){ 
				$("#checkType .modal-header.card-header").attr("class", "modal-header card-header bg-warning");
			}
			$("#myModal").modal("show");
		}
	});
	
</script>
<title>imageForm.do</title>
</head>
<body>
<section class="main">
	<jsp:include page="../common/header.jsp"></jsp:include>
	<div class="container-fluid">
		<h2>Spring MVC 03 - imageForm.do</h2>
		<div class="card ">
			<div class="card-header">
				<h3 class="text-center">프로필 이미지 등록</h3>
			</div>
			<div class="card-body">
				<form action="${ contextPath }/imageUpload.do?${_csrf.parameterName}=${ _csrf.token }" method="POST" class="form container" enctype="multipart/form-data">
					<!-- CSRF token -->
					<input type="hidden" name="${ _csrf.parameterName }" value="${ _csrf.token }" />
					<input type="hidden" name="memID" value="${ memResult.memID }" />
					<table class="table table-bordered text-center">
						<tbody>
							<tr>
								<th class="align-middle" style="width:150px;"><label for="memID">사용자 ID</label></th>
								<td class="align-middle">${ memResult.memID }</td>
							</tr>
							<tr>
								<th class="align-middle" style="width:150px;"><label for="memProfile">사진 업로드</label></th>
								<td class="align-middle">
									<input type="file" name="memProfile" id="memProfile" class="form-control" />
								</td>
							</tr>
						</tbody>
						<tfoot>
							<tr>
								<td colspan="2" class="pull-right">
									<p id="passMessage" class="text-center fw-bold"></p>
									<button type="submit" class="btn btn-sm btn-primary">저장하기</button>
									<button type="reset" class="btn btn-sm btn-warning">취소하기</button>
								</td>
							</tr>
						</tfoot>
					</table>
				</form>
			</div>
			<div class="card-footer">Panel footer</div>
		</div>
	</div>
</section>
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
        <button type="button" class="btn btn-danger" data-bs-dismiss="modal">Close</button>
      </div>

    </div>
  </div>
</div>
</body>
</html>