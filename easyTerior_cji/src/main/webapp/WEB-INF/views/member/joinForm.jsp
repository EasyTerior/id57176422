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
<script type="text/javascript">
	function registerCheck(){
		let memID = $("#memID").val();
		// alert("memID : "+memID);
		// 중복 확인 위해 비동기
		$.ajax({
			url : "${contextPath}/registerCheck.do",
			type : "GET",
			data : {"memID": memID},
			success : function(data){
				// 중복 유무를 data가 1이면 사용 가능, 즉 중복 없음,
				// data 가 0이면 중복 있음 == 사용 불가능
				if(data == 1){
					// alert("data : "+data+" -> 중복 없음");
					$("#checkMessage").text(memID+"은(는) 사용 가능한 ID 입니다.");
					$("#checkMessage").css({"color":"blue", "font-weight":"bold"});
					$("#checkType .modal-header.card-header").attr("class","modal-header card-header bg-primary");
					$("#titleMsg").text("사용 가능 ID");
					$("#titleMsg").css("color","white");
				}else{
					// alert("data : "+data+" -> 중복 있음");
					$("#checkMessage").text(memID+"은(는) 사용 불가능한 ID 입니다. 다른 아이디를 시도해보세요.");
					$("#checkMessage").css({"color":"red", "font-weight":"bold"});
					$("#checkType .modal-header.card-header").attr("class","modal-header card-header bg-danger");
					$("#titleMsg").text("사용 불가 ID");
					$("#titleMsg").css("color","white");
				}
				$("#myModal").modal("show");
			},
			error : function(){ alert("Error - registerCheck()"); }
			
		});
	}
	
	function passwordCheck(){
		let memPassword1 = $("#memPassword1").val();
		let memPassword2 = $("#memPassword2").val();
		if (memPassword1 != memPassword2){
			$(".valid-tooltip").text("비밀번호가 서로 동일하지 않습니다.");
			$(".valid-tooltip").css("color","red");
		}else{
			$(".valid-tooltip").text("비밀번호가 서로 일치합니다.");
			$(".valid-tooltip").css("color","green");
			$("#memPassword").val(memPassword1);
		}
		
	}
	// invalid show
	function validation(){
		// Fetch all the forms we want to apply custom Bootstrap validation styles to
		var forms = document.querySelectorAll('.needs-validation');

		// Loop over them and prevent submission
		Array.prototype.slice.call(forms).forEach(function (form) {
		    form.addEventListener('submit', function (event) {
		        if (!form.checkValidity()) {
		        event.preventDefault();
		        event.stopPropagation();
		    }
		    form.classList.add('was-validated');
		    }, false);
		});
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
<title>joinForm.do</title>
</head>
<body>
<main class="main">
	<jsp:include page="../common/header.jsp"></jsp:include>
	<jsp:include page="../common/submenu.jsp"></jsp:include>
	<section class="fixed-top container-fluid overflow-auto" style="height:100%;margin:137px 0 0;padding:56px 0 0 100px;">
	<div class="container-fluid" style="min-height:100vh;margin-bottom: 200px;">
		<div class="container-fluid">
			<div class="mb-5"><h2 class="text-center">회원가입</h2></div>
			<div class="container m-auto" style="width:70%;">
				<form action="join.do" method="POST" class="form container needs-validation">
					<!-- CSRF token -->
					<input type="hidden" name="${ _csrf.parameterName }" value="${ _csrf.token }" />
					<!-- memPassword1와 memPassword2가 일치해야만이 memPassword가 될 것 -->
					<input type="hidden" id="memPassword" name="memPassword" />
					<div class="row mb-3">
					    <label for="memID" class="col-sm-2 col-form-label">아이디</label>
					    <div class="col-sm-7">
					        <input type="text" placeholder="공백 없이 한글, 영어, 숫자로 20자 미만의 아이디만 가능합니다." pattern="^[ㄱ-ㅎ가-힣a-zA-Z0-9]+" maxlength=20 class="form-control" id="memID" />
					    </div>
					    <div class="col-sm-3">
					        <button type="button" onclick="registerCheck()" data-bs-toggle="modal" class="btn btn-sm btn-primary" >중복확인</button>
					    </div>
					</div>
					<div class="row mb-3 position-relative">
					    <label for="memPassword1" class="col-sm-2 col-form-label">비밀번호</label>
					    <div class="col-sm-10">
					        <input type="password" name="memPassword1" id="memPassword1" class="form-control" onkeyup="passwordCheck()" />
					    </div>
					    <div class="valid-tooltip"></div>
					</div>
					<div class="row mb-3 position-relative">
					    <label for="memPassword2" class="col-sm-2 col-form-label">비밀번호 확인</label>
					    <div class="col-sm-10">
					        <input type="password" name="memPassword2" id="memPassword2" class="form-control" onkeyup="passwordCheck()" />
					        <div class="valid-tooltip"></div>
					    </div>
					</div>
					<div class="row mb-3">
					    <label for="memName" class="col-sm-2 col-form-label">이름</label>
					    <div class="col-sm-10">
					        <input type="text" class="form-control" id="memName" required />
					    </div>
					</div>
					<div class="row mb-3">
					    <label for="memNickname" class="col-sm-2 col-form-label">닉네임</label>
					    <div class="col-sm-10">
					        <input type="text" placeholder="공백 없이 한글, 영어, 숫자로 10자 미만의 닉네임만 가능합니다." pattern="^[ㄱ-ㅎ가-힣a-zA-Z0-9]+" maxlength=10 class="form-control" id="memNickname" required />
					    </div>
					</div>
					<div class="row mb-3">
					    <label for="memPhone" class="col-sm-2 col-form-label">휴대폰 번호</label>
					    <div class="col-sm-10">
					        <input type="text" placeholder="000-0000-0000" pattern="^01([0|1|6|7|8|9])-?([0-9]{3,4})-?([0-9]{4})$" class="form-control" id="memPhone" required />
					    </div>
					</div>
					<div class="row mb-3">
					    <label for="memEmail" class="col-sm-2 col-form-label">이메일</label>
					    <div class="col-sm-10">
					        <input type="email" placeholder="email@email.com" pattern="^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$" class="form-control" id="memEmail" required />
					    </div>
					</div>
					<div class="row mb-3">
					    <label for="memAddress" class="col-sm-2 col-form-label">주소</label>
					    <input type="hidden" class="" id="memAddress" />
					    <div class="col-md-4 input-grou position-relative">
							<button type="button" class="btn btn-sm btn-info align-top" onclick="addressFullFill()">우편번호 찾기</button>
					        	<input type="text" id="postcode" class="form-control"  placeholder="우편번호">
						</div>
					    <div class="col-sm-10">

					        <input type="text" id="address" class="form-control" style="width: 300px;" placeholder="주소">
							<input type="text" id="detailAddress" class="form-control" placeholder="상세주소">
							<input type="text" id="extraAddress" class="form-control" placeholder="참고항목">
					    </div>
					</div>
					<div class="row mb-3">
					    <div class="col-sm-10 offset-sm-2">
					        <button type="submit" class="btn btn-primary">가입하기</button>
					    </div>
					</div>
				</form>
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
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
    function addressFullFill() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var addr = ''; // 주소 변수
                var extraAddr = ''; // 참고항목 변수

                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    addr = data.roadAddress;
                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    addr = data.jibunAddress;
                }

                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
                if(data.userSelectedType === 'R'){
                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있고, 공동주택일 경우 추가한다.
                    if(data.buildingName !== '' && data.apartment === 'Y'){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                    if(extraAddr !== ''){
                        extraAddr = ' (' + extraAddr + ')';
                    }
                    // 조합된 참고항목을 해당 필드에 넣는다.
                    document.getElementById("extraAddress").value = extraAddr;
                
                } else {
                    document.getElementById("extraAddress").value = '';
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('postcode').value = data.zonecode;
                document.getElementById("address").value = addr;
                // 커서를 상세주소 필드로 이동한다.
                document.getElementById("detailAddress").focus();
            }
        }).open();
    }
</script>
</body>
</html>