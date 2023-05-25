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
		// 회원가입 후 modal 표시
		if(${ not empty msgType}){
			if(${msgType eq "실패 메세지"}){ 
				$("#checkType .modal-header.card-header").attr("class", "modal-header card-header bg-warning");
			}
			$("#myModal").modal("show");
		}
	});
	
</script>
<title>loginForm.do</title>
</head>
<body>
<section class="main">
	<jsp:include page="../common/header.jsp"></jsp:include>
	<div class="container-fluid">
		<h2>Spring MVC 03 - loginForm.do</h2>
		<div class="card ">
			<div class="card-header">
				<h3 class="text-center">로그인</h3>
			</div>
			<div class="card-body">
				<form action="${ contextPath }/login.do" method="POST" class="form container">
					<!-- CSRF token -->
					<input type="hidden" name="${ _csrf.parameterName }" value="${ _csrf.token }" />
					<table class="table table-bordered text-center">
						<tbody>
							<tr>
								<th class="align-middle" style="width:150px;"><label for="memID">사용자 ID</label></th>
								<td class="align-middle">
									<input type="text" name=memID id="memID" class="form-control" maxlength=20 placeholder="아이디를 20자 미만으로 입력하세요" required="required" />
								</td>
							</tr>
							<tr>
								<th class="align-middle" style="width:150px;"><label for="memPassword">사용자 비밀번호</label></th>
								<td class="align-middle">
									<input type="password" name=memPassword id="memPassword" class="form-control" maxlength=20 placeholder="비밀번호를 입력해주세요" required="required" />
								</td>
							</tr>
						</tbody>
						<tfoot>
							<tr>
								<td colspan="2" class="pull-right">
									<p id="passMessage" class="text-center fw-bold"></p>
									<button type="submit" class="btn btn-sm btn-primary">로그인</button>
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