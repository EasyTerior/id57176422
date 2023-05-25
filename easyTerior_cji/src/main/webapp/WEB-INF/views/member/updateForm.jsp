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
	// 비밀번호 동일 여부 확인
	function passwordCheck(){
		let memPassword1 = $("#memPassword1").val();
		let memPassword2 = $("#memPassword2").val();
		if (memPassword1 != memPassword2){
			$("#passMessage").text("비밀번호가 서로 일치하지 않습니다. 비밀번호를 확인해주세요.");
			$("#passMessage").css("color","red");
		}else{
			$("#passMessage").text("비밀번호가 서로 일치합니다.");
			$("#passMessage").css("color","green");
			$("#memPassword").val(memPassword1);
		}
		
	}
	
	$(document).ready(function(){
		// 회원가입 실패 후 modal 표시
		if(${ not empty msgType}){
			if(${msgType eq "실패 메세지"}){
				$("#checkType .modal-header.card-header").attr("class","modal-header card-header bg-warning");
			}
			$("#myModal").modal("show");
		}
	});
	
</script>
<title>updateForm.do</title>
</head>
<body>
<section class="main">
	<jsp:include page="../common/header.jsp"></jsp:include>
	<div class="container-fluid">
		<h2>Spring MVC 03 - updateForm.do</h2>
		<div class="card ">
			<div class="card-header"><h3 class="text-center">회원 정보 수정</h3></div>
			<div class="card-body">
				<form action="update.do" method="POST" class="form container">
					<!-- CSRF token -->
					<input type="hidden" name="${ _csrf.parameterName }" value="${ _csrf.token }" />
					<input type="hidden" id="memID" name="memID" value="${ memResult.memID }" />
					<input type="hidden" id="memPassword" name="memPassword" /> <!-- memPassword1와 memPassword2가 일치해야만이 memPassword가 될 것 -->
					<table class="table table-bordered text-center">
						<tbody>
							<tr>
								<th class="align-middle" style="width:150px;"><label for="memID">사용자 ID</label></th>
								<td class="align-middle">
									${ memResult.memID }
								</td>
							</tr>
							<tr>
								<th class="align-middle" style="width:150px;"><label for="memPassword1">사용자 비밀번호</label></th>
								<td class="align-middle">
									<input type="password" onkeyup="passwordCheck()" name=memPassword1 id="memPassword1" class="form-control" maxlength=20 placeholder="비밀번호는 8~20자 미만으로 입력 가능하며 숫자와 소문자와 대문자의 조합으로 만들어주세요" required="required" />
								</td>
							</tr>
							<tr>
								<th class="align-middle" style="width:150px;"><label for="memPassword2">사용자 비밀번호 확인</label></th>
								<td class="align-middle">
									<input type="password" onkeyup="passwordCheck()" name=memPassword2 id="memPassword2" class="form-control" maxlength=20 placeholder="비밀번호는 위와 동일해야 합니다." required="required" />
								</td>
							</tr>
							<tr>
								<th class="align-middle" style="width:150px;"><label for="memName">사용자 이름</label></th>
								<td class="align-middle">
									<input type="text" name=memName id="memName" value="${ memResult.memName }" class="form-control" maxlength=20  placeholder="이름을 입력하세요." required="required" />
								</td>
							</tr>
							<tr>
								<th class="align-middle" style="width:150px;"><label for="memAge">사용자 나이</label></th>
								<td class="align-middle">
									<input type="number" name=memAge id="memAge" value="${ memResult.memAge }" class="form-control" placeholder="나이를 입력하세요." required="required" />
								</td>
							</tr>
							<tr>
								<th class="align-middle" style="width:150px;"><label for="memGender">성별</label></th>
								<td class="align-middle">
									<div class="form-group text-center m-auto">
										<c:if test="${memResult.memGender eq '남자'}">
										<div class="btn-group gender-group" data-toggle="buttons" role="group">
											<label for="male" class="btn btn-sm btn-primary active">
												<input type="radio" name="memGender" id="male" class="btn-check" value="남자" checked="checked"  autocomplete="off" />
												<span>남자</span>
											</label>
											
											<label for="female" class="btn btn-sm btn-primary">
												<input type="radio" name="memGender" id="female" class="btn-check" value="여자" autocomplete="off" />
												<span>여자</span>
											</label>
										</div>
										</c:if>
										<c:if test="${memResult.memGender eq '여자'}">
										<div class="btn-group gender-group" data-toggle="buttons" role="group">
											<label for="male" class="btn btn-sm btn-primary">
												<input type="radio" name="memGender" id="male" class="btn-check" value="남자" autocomplete="off" />
												<span>남자</span>
											</label>
											
											<label for="female" class="btn btn-sm btn-primary active">
												<input type="radio" name="memGender" id="female" class="btn-check" value="여자" checked="checked" autocomplete="off" />
												<span>여자</span>
											</label>
										</div>
										</c:if>
									</div>
								</td>
							</tr>
							<tr>
								<th class="align-middle" style="width:150px;"><label for="memEmail">사용자 이메일</label></th>
								<td class="align-middle">
									<input type="email" name=memEmail id="memEmail" value="${ memResult.memEmail }" class="form-control" maxlength=150 placeholder="이메일을 입력하세요." pattern="[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,}$" required="required" />
								</td>
							</tr>
						</tbody>
						<tfoot>
							<tr>
								<td colspan="2" class="pull-right">
									<p id="passMessage" class="text-center fw-bold"></p>
									<button type="submit" class="btn btn-sm btn-primary">수정하기</button>
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
        <h4 id="titleMsg" class="modal-title text-center">${ msgType }</h4>
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
</body>
</html>