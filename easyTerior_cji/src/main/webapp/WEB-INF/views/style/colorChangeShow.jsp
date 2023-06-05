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
	function saveColor() {
	  var colorPicker = document.getElementById("colorPicker");
	  var selectedColor = colorPicker.value;
		alert("색상을 저장하였습니다.");
	  fetch("http://127.0.0.1:5000/save-color", {
	    method: "POST",
	    headers: {
	      "Content-Type": "application/json",
	    },
	    body: JSON.stringify({ color: selectedColor }),
	  })
	    .then(response => response.json())
	    .then(data => {
	      console.log(data); // 서버에서 반환한 응답 데이터 확인
	      var colorButton = document.getElementById("colorButton");
	      if (colorButton.style.backgroundColor === "blue") {
	        colorButton.style.backgroundColor = "";
	      } else {
	        colorButton.style.backgroundColor = "blue";
	      }
	    })
	    .catch(error => {
	      console.error("Error:", error);
	    });
	}
		  
	var savedButtonIDs = [];

	function saveButton(buttonID) {
	  // save the button id to the array
	  savedButtonIDs.push(buttonID);
	  
	}

	function removeSavedButton(buttonID) {
	  // remove the button id from the array
	  const index = savedButtonIDs.indexOf(buttonID);
	  if (index > -1) {
	    savedButtonIDs.splice(index, 1);
	  }
	}

	function saveSelectedItem() {
	  // Check if there are any saved items
	  if (savedButtonIDs.length === 0) {
	    alert("적어도 하나 이상의 항목을 선택해주세요.");
	    return;
	  }
		
	  // send the saved button ids to the server
	  
	  var xhr = new XMLHttpRequest();
	  xhr.open("POST", "http://127.0.0.1:5000/save_selected_item", true);  // Your Flask route here
	  xhr.setRequestHeader("Content-Type", "application/json");

	  // convert savedButtonIDs to JSON and send
	  xhr.send(JSON.stringify({ "selectedItems": savedButtonIDs }));

	  xhr.onload = function() {
	    if (xhr.status === 200) {
	      alert("선택한 소품을 저장 하였습니다.");
	      var saveButton = document.getElementById("saveButton");
	      saveButton.style.backgroundColor = "blue";
	    } else {
	      alert("Error occurred while sending to the server.");
	    }
	  };
	}
	  
	function submitForm() {
	    window.location.href = "http://localhost:8081/colorChangeShowImage.do";
	}


</script>
<style>
body, main, section {
position: relative;
}
    .green-button {
      background-color: green;
      color: white;
    }
	#saveButton{
		border-radius: 12px;  /* 둥근 모서리를 원하는 크기로 설정 */
		background-color: #BFBBBB;  /* 버튼의 배경 색상 설정 */ -->
		padding: 10px 20px;  /* 버튼 내부의 공간 설정 */
		border: none;  /* 버튼 테두리 제거 */
		cursor: pointer;  /* 마우스 커서 모양 변경 */
		color: white;  /* 버튼의 글자 색상 설정 */
	    font-size: 16px;  /* 글자 크기 설정 */
	    font-weight:bold;
	    width: 150px; /* 버튼의 너비 설정 */
    	height: 50px; /* 버튼의 높이 설정 */
	}    
    /* 마우스가 버튼 위에 있을 때 스타일 */
    #saveButton:hover {
        background-color: #EBDDBD;  /* 배경 색상 변경 */
    }
    #colorButton
    {
		border-radius: 12px;  /* 둥근 모서리를 원하는 크기로 설정 */
		background-color: #BFBBBB;  /* 버튼의 배경 색상 설정 */ -->
		padding: 10px 20px;  /* 버튼 내부의 공간 설정 */
		border: none;  /* 버튼 테두리 제거 */
		cursor: pointer;  /* 마우스 커서 모양 변경 */
		color: white;  /* 버튼의 글자 색상 설정 */
	    font-size: 16px;  /* 글자 크기 설정 */
	    font-weight:bold;
	    width: 150px; /* 버튼의 너비 설정 */
    	height: 50px; /* 버튼의 높이 설정 */
	}
    #colorButton:hover {
       background-color: #EBDDBD;  /* 배경 색상 변경 */
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
	    width: 250px; /* 버튼의 너비 설정 */
    	height: 50px; /* 버튼의 높이 설정 */
	}
	#resultbutton:hover {
        background-color: #0895C4;  /* 배경 색상 변경 */
    }
	#buttonContainer{
	
	display: flex;
    justify-content: center;
    align-items: center;
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
			                <h5 class="card-title text-center fw-bold" style="text-align:left">업로드한 사진</h5>
			            </div>
			            <img src="http://127.0.0.1:5000/images/processed_image.jpg" alt="Processed Image" style="width: 480px; height: 480x;">
			        </div>
			    </div>
			    <div class="col-sm-6">
			        <div class="card border-0">
			            <div class="card-body">
			                <h5 class="card-title text-center mb-4 fw-bold">발견된 객체</h5>
			                <div>
			                	<div id="buttonContainer"></div>
			                	<script>
			                	// 객체 ID와 레이블을 저장할 배열 생성
			                	var objects = [];

			                	// 객체 정보를 기반으로 버튼 생성
			                	<%-- 감지된 객체의 ID 가져오기 --%>
			                	var detectedObjectIDsJson = '<%= request.getParameter("detected_object_ids") %>';
			                	var detectedObjectIDs = JSON.parse(detectedObjectIDsJson);

			                	// 중복을 제거한 객체 ID 목록을 생성
			                	var uniqueObjectIDs = [...new Set(detectedObjectIDs)];

			                	// 중복 제거된 객체 ID를 기반으로 객체 정보를 배열에 저장
			                	for (var i = 0; i < uniqueObjectIDs.length; i++) {
			                	  var objectID = uniqueObjectIDs[i];
			                	  var objectLabel = getObjectLabel(objectID);

			                	  objects.push({ id: objectID, label: objectLabel });
			                	}

			                	// 객체 정보를 이름순으로 정렬
			                	objects.sort(function (a, b) {
			                	  var labelA = a.label.toUpperCase(); // 대소문자 구분 없이 정렬
			                	  var labelB = b.label.toUpperCase();
			                	  if (labelA < labelB) {
			                	    return -1;
			                	  }
			                	  if (labelA > labelB) {
			                	    return 1;
			                	  }
			                	  return 0;
			                	});

			                	// 객체 정보를 기반으로 버튼 생성
			                	var buttonContainer = document.getElementById("buttonContainer");
			                	for (var i = 0; i < objects.length; i++) {
			                	  var object = objects[i];
			                	  var objectID = object.id;
			                	  var objectLabel = object.label;

			                	  // 버튼 요소 생성
			                	  var button = document.createElement("button");
			                	  button.id = objectID;
			                	  button.innerText = objectLabel;

			                	  // 버튼에 클래스 추가
			                	  button.classList.add("white-button");
			                	  
			                	  // 버튼에 스타일 속성 추가
			                	  button.style.width = "70px";
			                	  button.style.height ="40px";
			                	  
			                	  button.style.marginRight= "30px";
			                	  button.style.backgroundColor="whitegray";
			                	  
			                	  button.style.color="black";
			                	  button.style.border="none";
			                	  button.style.fontWeight = "bold";  // 글씨 굵게
			                	  button.style.transition = "box-shadow 0.2s ease"; // box-shadow에 대한 transition 속성 추가

			                	// 버튼에 클릭 이벤트 리스너 추가
			                	  button.addEventListener("click", function () {
			                	      // 버튼이 클릭되었을 때 그림자 변경
			                	      this.style.boxShadow = "0px 0px 5px 2px rgba(0, 0, 0, 0.25)";
			                	      
			                	      // 버튼이 클릭되었을 때 수행할 동작 정의
			                	      if (this.style.backgroundColor === "rgb(173, 216, 230)") { // RGB 코드로 밝은 하늘색 표현
			                	          this.style.backgroundColor = "";
			                	          this.style.boxShadow = "";  // 클릭이 해제됐을 때 그림자 제거
			                	          removeSavedButton(this.id); // 함수로 저장된 버튼 제거
			                	      } else {
			                	          this.style.backgroundColor = "rgb(173, 216, 230)"; // RGB 코드로 밝은 하늘색 표현
			                	          this.style.boxShadow = "0px 0px 10px 4px rgba(0, 0, 0, 0.25)"; // 클릭됐을 때 그림자 추가
			                	          saveButton(this.id); // 함수로 버튼 저장
			                	      }

			                	  });
			                	  // 컨테이너에 버튼 추가
			                	  buttonContainer.appendChild(button);
			                	}
			                	  function getObjectLabel(objectID) {
			                	    switch (objectID) {
			                	      case 0:
			                	        return "침대";
			                	      case 1:
			                	        return "이불";
			                	      case 2:
			                	        return "카펫";
			                	      case 3:
			                	        return "의자";
			                	      case 4:
			                	        return "커튼";
			                	      case 5:
			                	        return "문";
			                	      case 6:
			                	        return "램프";
			                	      case 7:
			                	        return "베개";
			                	      case 8:
			                	        return "선반";
			                	      case 9:
			                	        return "소파";
			                	      case 10:
			                	        return "테이블";
			                	      default:
			                	        return "알 수 없음";
			                	    }
			                	  }
			                	</script>
			                </div>
			                </br>
			                </br>
			                </div>
			                	
			                    
			                   <div style="display: flex; justify-content: center; align-items: center;">
									   <button id="saveButton" type="button" onclick="saveSelectedItem()">선택한 소품 저장</button>
								</div>
								</br>
			                    <div >
			                    <h5 class="card-title text-center mb-4 fw-bold">색상을 선택해주세요</h5>
			                    </div>
			                    <div >
			                    	<div style="display: flex; justify-content: center; align-items: center;">
			                    		<input type="color" id="colorPicker" value="#ff0000">
			                    	</div>
			                    	</br>
								  	<div style="display: flex; justify-content: center; align-items: center;">
								  		<button id="colorButton" type="button" onclick="saveColor()">색상 저장</button>
								  	</div>
								</div>
			        </div>
			    </div>
			</div>
			<div class="row text-center" style="padding-top:50px;">
						<form action="http://127.0.0.1:5000/colorChangeShowImage.do" method="POST" enctype="multipart/form-data" class="text-center" >
			            <button onclick ="submitForm()" id="resultbutton">색상 변경하기</button>
			            </form>
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

<script>
<%-- 			              //밑에 코드는 여러객체할떄
  // 객체 ID와 레이블을 저장할 배열 생성
  	  var objects = [];
  	  // 객체 레이블을 카운팅할 객체 생성
  	  var labelCount = {};

  	  // 객체 정보를 기반으로 버튼 생성
  	  감지된 객체의 ID 가져오기
  	  var detectedObjectIDsJson = '<%= request.getParameter("detected_object_ids") %>';
  	  var detectedObjectIDs = JSON.parse(detectedObjectIDsJson);

  	  // 감지된 객체의 ID를 기반으로 객체 정보를 배열에 저장
  	  for (var i = 0; i < detectedObjectIDs.length; i++) {
  	    var objectID = detectedObjectIDs[i];
  	    var objectLabel = getObjectLabel(objectID);

  	    // 객체 레이블에 카운트 추가
  	    if (labelCount[objectLabel]) {
  	      labelCount[objectLabel]++;
  	    } else {
  	      labelCount[objectLabel] = 1;
  	    }

  	    // 객체 레이블에 카운트를 포함하여 고유한 이름 생성
  	    var uniqueLabel = objectLabel + labelCount[objectLabel];
  	    objects.push({ id: objectID, label: uniqueLabel });
  	  }

  	  // 객체 정보를 이름순으로 정렬
  	  objects.sort(function (a, b) {
  	    var labelA = a.label.toUpperCase(); // 대소문자 구분 없이 정렬
  	    var labelB = b.label.toUpperCase();
  	    if (labelA < labelB) {
  	      return -1;
  	    }
  	    if (labelA > labelB) {
  	      return 1;
  	    }
  	    return 0;
  	  });

  	  // 객체 정보를 기반으로 버튼 생성
  	  var buttonContainer = document.getElementById("buttonContainer");
  	  for (var i = 0; i < objects.length; i++) {
  	    var object = objects[i];
  	    var objectID = object.id;
  	    var objectLabel = object.label;

  	    // 버튼 요소 생성
  	    var button = document.createElement("button");
  	    button.id = objectID;
  	    button.innerText = objectLabel;

  	    // 버튼에 클래스 추가
  	    button.classList.add("green-button");

  	    // 버튼에 클릭 이벤트 리스너 추가
  	    button.addEventListener("click", function () {
  	      // 버튼이 클릭되었을 때 수행할 동작 정의
  	      console.log("객체 " + this.id + "가 클릭되었습니다.");
  	      // ...
  	    });

  	    // 컨테이너에 버튼 추가
  	    buttonContainer.appendChild(button);
  	  } --%>

  	  <%-- 객체 ID에 해당하는 텍스트를 반환하는 함수 --%>
</script>
<script type="text/javascript">

</script>
</body>
</html>