<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %><%-- JSTL --%>
<!DOCTYPE html>
<html lang="KO">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/jquery@3.6.4/dist/jquery.min.js"></script>
<script type="text/javascript">
	// CSRF 토큰의 이름과 값 설정 -> 비동기 방식은 csrfHeaderName으로 넣음
	var csrfHeaderName = "${ _csrf.headerName }"; // 문자열 형태로
	var csrfTokenValue = "${ _csrf.token }";

	// 비동기 통신 javaScript 코드 작성 feat. JQuery(functional library), Ajax
	$(document).ready(function(){ // ready() -> after html load
		loadList(); // 게시글 보는 기능 실행
	});
	
	// 비동기 통신으로 게시글 리스트 가져오는 기능 -> 객체로 가져옴 이 객체 표현 방식 == JSON {"key":value}
	function loadList(){
		// ajax 비동기 통신
		$.ajax({
			url : "board/all",
			// url : "boardList.do", // boardList.do 이 url이 BoardController.java 에서 @GetMapping 받고 list 반환함.
			type : "GET", // 어떤 데이터 방식으로 요청 GET, POST
			dataType: "json",
			// 통신 성공과 실패에 대해
			success : makeView, // 성공 시 makeView 함수 실행
			error : function(){
				alert("Error");
			}
		}); // ajax("") 
	}
	
	// 게시글 리스트 정보를 성공적으로 받았을 시 tag로 만들어서 보여주는 함수
	function makeView(data){
		// console.log(data); // browser console
		// 게시글 정보를 태그로 만들어서 id가 view인 요소에 넣기
		let listHTML = "<table class='table table-bordered'>";
		listHTML += "<thead>";
		listHTML += "<tr>";
		listHTML += "<th>번호</th>";
		listHTML += "<th>제목</th>";
		listHTML += "<th>작성자</th>";
		listHTML += "<th>작성일</th>";
		listHTML += "<th>조회수</th>";
		listHTML += "</tr>";
		listHTML += "</thead>";
		listHTML += "<tbody>";
		// 반복문으로 JSON Array 안의 게시글 정보 listHTML 안에 담기
		$.each(data, function(index, obj){ // data에서 index와 객체 하나가 obj
			listHTML += "<tr>";
			listHTML += "<td>"+(index + 1)+"</td>";
			// 페이지 이동하지 않는 비동기 방식으로서 href 가 javascript 작동하도록 처리
			listHTML += "<td id='tit"+obj.idx+"'><a href='javaScript:goContent("+obj.idx+")'>"+ 
			obj.title.replace(/</g, '&lt;').replace(/>/g, '&gt;')
			+"</a></td>";
			listHTML += "<td id='wr"+obj.idx+"'>"+ obj.writer +"</td>";
			listHTML += "<td>"+ obj.indate +"</td>";
			listHTML += "<td>"+ obj.count +"</td>";
			listHTML += "</tr>";
			// 각각 게시글 상세가 컨텐츠 하나마다 불러오고 display:none으로 했다가 제목 누르면 보이도록 처리
			// 게시글 상세보기
			listHTML += "<tr id=c"+obj.idx+" style='display:none'>";
			listHTML += "<th><label for='lb"+obj.idx+"''>내용</label></th>";
			listHTML += "<td colspan='4' >";
			listHTML += "<textarea id='ta"+obj.idx+"' rows='10' cols='20' class='form-control' readonly>";
			// listHTML += obj.content;
			listHTML += "</textarea>";
			// listHTML += "<textarea id='ta" + obj.idx + "' rows='10' class='form-control' readonly></textarea>";
			//console.log($("#ta"+obj.idx).val());
			//$("#ta"+obj.idx).html(obj.content+"testing");
			//$("textarea#ta"+obj.idx).val(obj.content+"testing");
			
			
			// 수정 & 삭제 버튼 추가
			if("${memResult.memID}" == obj.memID){
				listHTML += "<p class='mt-3 mb-3 text-center'>";
				listHTML += "<span id='ub"+obj.idx+"'>";
				listHTML += "<button onclick='goUpdateForm("+obj.idx+")' class='btn btn-sm btn-success'>수정</button>"
				listHTML += "</span>";
				listHTML += "&nbsp";
				listHTML += "<button onclick='goDelete("+obj.idx+")' class='btn btn-sm btn-warning'>삭제</button>"
				listHTML += "</p>";
			}
			listHTML += "</td>";
			listHTML += "</tr>";
			
			
			//listHTML += "<textarea id='ta"+obj.idx+"' rows='10' class='form-control' readonly>"+obj.content+"</textarea>";

		});
	
		listHTML += "</tbody>";
		if(${ not empty memResult}){
			listHTML += "<tfoot>";
			listHTML += "<tr>";
			listHTML += "<td colspan='5'>";
			listHTML += "<button onclick='goWriteForm()' class='btn btn-sm btn-primary'>글쓰기</button>";
			listHTML += "</td>";
			listHTML += "</tr>";
			listHTML += "</tfoot>";	
		}
		listHTML += "</table>";
		
		$("#view").html(listHTML);
		//console.log(data);
		
		goList(); // 게시글 입력이 끝나면 목록 다시 불러오도록 함수 call
	}
	
	// 게시글 입력 함수
	function goInsert(){
		// input / textarea 의 입력값 가져오기
		// let title = $("#title").val(); // document.querySelector();
		// let content = $("#content");
		// let writer = $("#writer").val();
		// console.log("goInsert() : " + title + " | " + content +  " | by."  + writer);
		var formData = $("#frm").serialize(); // 직렬화(Serialization)해서 가져옴
		// console.log("goInsert() :" + formData);
		
		$.ajax({ // js에서 객체 표현 방식 -> json
			url : "board/new", // BoardRestController
			// url : "boardInsert.do", // BoardController에서
			type : "POST",
			// data 비동기로 보내기 전 token 먼저 보내기
			beforeSend : function(xhr){ // xhr 에 담아서 보냄
				xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
			},
			data : formData, // 서버로 보낼 data가 있을 때만 사용. formData가 key=value 형식으로 다 가지고 있음.
			// 입력만 하고 결과 반환 받을 게 있으면 // dataType : "json", 이라고 쓰고 없으면 안 씀.
			// 성공시
			success : loadList, // 다시 게시글 목록 불러오기 -> loadList에서 이미 비동기통신 처리 되어있음. -> makeView 실행
			error : function(){ alert("Error from goInsert()"); },
		});
		// form 데이터 넘기고 나서 form 안의 내용들 초기화하기
		/*
		let title = $("#title").val(""); 
		let content = $("#content").val("");
		let writer = $("#writer").val("");
		*/
		// id=fclear 로 지정된 reset 버튼 활성화 해서 전체 초기화
		// clearAllFormData(); // reset button not working
		$("#fclear").trigger("click");
		
	}
	
	// 게시글 상세보기 기능
	function goContent(idx){
		let cidx = $("#c"+idx);
		if(cidx.css("display") == "none"){
			cidx.css("display","table-row"); // tr이라서 table-row인 것
			$("#ta"+idx).attr("readonly", true);
			// 클릭한 게시글 하나의 정보 불러오기
			$.ajax({
				// url: "boardContent.do",
				url : "board/"+idx,
				type : "GET",
				// data 비동기로 보내기 전 token 먼저 보내기
				beforeSend : function(xhr){ // xhr 에 담아서 보냄
					xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
				},
				data : {"idx" : idx},
				dataType : "json",
				success : function(data){ // dataType으로 들어온 data
					// console.log(data);
					$("#ta"+idx).val(data.content);
					$("#wr"+idx).val(data.writer);
				},
				error : function(){ alert("Error from goContent("+idx+")"); },
			});
			// $("#ta"+idx).val();
			// $("tr:not(#c"+idx+")").css("display","none");
		}else{
			cidx.css("display","none"); // tr이라서 table-row인 것
			$("#ta"+idx).attr("readonly", false);
			// 조회수 올리는 기능
			// 요청 URL - boardCount.do
			// 게시글 조회수 1 올리고 나서 다시 게시글 목록 불러와 적용하기.
			$.ajax({
				// url : "boardCount.do",
				// type: "GET",
				// data : {"idx" : idx },
				url : "board/count/"+idx,
				type: "PUT",
				// data 비동기로 보내기 전 token 먼저 보내기
				beforeSend : function(xhr){ // xhr 에 담아서 보냄
					xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
				},
				success : loadList,
				error : function(){ alert("Error from boardCount("+idx+")"); },
			});
			
			
		}
		
	};
	
	// 게시글 삭제하기
	function goDelete(idx){
		$.ajax({
			// 문제 : 서버로 idx와 일치하는 게시글을 삭제하시오.
			// idx 값을 보낼 때는 json 형태로 보내야 합니다. 삭제 성공 시 게시글 정보를 다시 불러와서 보여줘야 한다.
			// url : "boardDelete.do",
			//type : "GET",
			url : "board/"+idx,
			type : "DELETE",
			// data 비동기로 보내기 전 token 먼저 보내기
			beforeSend : function(xhr){ // xhr 에 담아서 보냄
				xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
			},
			data : {"idx" : idx},
			success : loadList, // 성공 시 makeView 함수 실행
			error : function(){ alert("Error : goDelete("+idx+")"); }
		});
	}
	
	// 게시글 form 업데이트 준비
	function goUpdateForm(idx){
		$("#ta"+idx).attr("readonly", false); // readonly 를 false 해서 수정 가능 처리
		let title = $("#tit"+idx+' a').text();
		let newInput = "<input type='text' id='nt"+idx+"' class='form-control' value='"+title+"' />";
		$("#tit"+idx).html(newInput);
		let newButton = "<button onclick='goUpdate("+idx+")' class='btn btn-sm btn-primary'>수정</button>";
		$("#ub"+idx).html(newButton);
	}
	// 수정하기 기능
	function goUpdate(idx){
		// 문제. 입력한 제목과 내용을 바탕으로 게시글을 수정하시오.
		// 요청 URL - boardUpdate.do
		let title = $("#nt"+idx).val();
		let content = $("#ta"+idx).val();
		$.ajax({
			// url : "boardUpdate.do",
			// type : "POST",
			url : "board/update",
			type : "PUT",
			contentType : "application/json;charset=utf-8",
			// data 비동기로 보내기 전 token 먼저 보내기
			beforeSend : function(xhr){ // xhr 에 담아서 보냄
				xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
			},
			data : JSON.stringify({"idx" : idx, "title" : title, "content" : content}),
			success : loadList, // 성공 시 makeView 함수 실행
			error : function(){ alert("Error : goUpdate("+idx+")"); }
		});
	}
	
	
	// 기타 method
	function goWriteForm(){
		// let writer = "${ memResult.memName }";
		// $("#writeForm #writer").val(writer);
		$("#view").hide();
		$("#writeForm").css("display","block");
		clearAllFormData();
	}
	
	function goList(){
		$("#writeForm").css("display","none");
		$("#view").show();
		clearAllFormData();
	}
	
	function clearAllFormData(){
		// console.log("clearAllFormData called");
		$(".form-control").val("");
		$("#content").val("");
		// $("#frm").reset(); // reset button not working
	}
	
</script>

<title>Board Main</title>
</head>
<body>
<jsp:include page="../common/header.jsp"></jsp:include>
<h1 class="toast hide">게시글 리스트 페이지 입니다.</h1>
<div class="container mt-3">
	<h2 class="text-center">Spring MVC ver03 </h2>
	<div class="card panel-default">
		<div class="card-header mb-3">게시판 header</div>
		<div class="card-body mb-3">
			<!-- boardList -->
			<div id="view"></div>
			<!-- boardWriteForm -->
			<div id="writeForm" style="display:none;">
				<form id="frm"> <!-- action="" method="POST" -->
					<input type="hidden" name="memID" value="${ memResult.memID }" />
					<table class="table table-bordered">
						<tbody>
							<tr>
								<th>제목</th>
								<td><input type="text" id="title" name="title" class="form-control" /></td>
							</tr>
							<tr>
								<th>내용</th>
								<td><textarea id="content" rows="10" name="content" class="form-control"></textarea></td>
							</tr>
							<tr>
								<th>작성자</th>
								<td>
									<input type="text" id="writer" name="writer" value="${ memResult.memName }" readonly class="form-control-plaintext" />
								</td>
							</tr>
						</tbody>
						<tfoot>
							<tr>
								<td colspan="2" class="text-center">
									<button type="button" onclick="goInsert()" class="btn btn-sm btn-primary">저장</button>
									<!-- <button type="submit" class="btn btn-sm btn-primary">저장</button> -->
									<button type="button" id="fclear" onclick="clearAllFormData()" class="btn btn-sm btn-warning">취소</button>
									<button type="button" onclick="goList()" class="btn btn-sm btn-info">목록</button>
								</td>
							</tr>
						</tfoot>
					</table>
				</form>
			</div>
		</div>
		<div class="card-footer">Spring MVC 02 : 스프링 게시판 - 박병관 강사님 by.오세연</div>
	</div>
</div>
</body>
</html>