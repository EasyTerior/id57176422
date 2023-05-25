<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %><%-- JSTL --%>
<%-- --%>
<c:set var="contextPath" value="${ pageContext.request.contextPath }" />
<nav class="fixed-top navbar navbar-light navbar-expand-lg border-bottom border-dark border-5">
  <div class="container">
    <!-- <a class="navbar-brand" href="#">BIGBANG</a> -->
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarSupportedContent">
      <ul class="navbar-nav me-auto mb-2 mb-lg-0">
        <li class="nav-item ms-5">
          <a class="nav-link active" aria-current="page" href="${ contextPath }/"><img style="width:100px;height:100px;" src="${ contextPath }/resources/images/common/ET_logo.png" class="rounded mx-auto d-block" alt="logo"></a>
          <!-- <a class="nav-link active" aria-current="page" href="/controller/">Home</a> -->
          <!-- /controller/ == context path 지만 직접적으로 쓰면 일일이 바꿔야 하므로 -->
        </li>
        <!-- 
        <li class="nav-item">
          <a class="nav-link" href="boardMain.do">게시판</a>
        </li>
         -->
      </ul>
      <c:if test="${ empty memResult }"> <!-- session.setAttribute("memResult", memResult); 로그인 안 함. -->
      	<ul class="nav navbar-nav navbar-right">
      	<li class="nav-item">
      		<a href="${ contextPath }/joinForm.do" class="nav-link link-dark"><i class="bi bi-person-plus-fill"></i><span class="px-2 align-middle">회원가입</span></a>
      	</li>
        <li class="nav-item">
        	<a href="${ contextPath }/loginForm.do" class="nav-link link-dark"><i class="bi bi-box-arrow-in-right"></i><span class="px-2 align-middle">로그인</span></a>
        </li>
      </ul>
      </c:if>
      <c:if test="${ not empty memResult }"> <!-- session.setAttribute("memResult", memResult); -->
      	<ul class="nav navbar-nav navbar-right">
      	<li class="nav-item">
      		<c:if test="${ memResult.memProfile ne ''}">
      			<img alt="${memResult.memProfile}" src="${ contextPath }/resources/profile/${memResult.memProfile}" class="rounded-circle align-middle" style="width:50px;height:50px;" />
      		</c:if>
      		<c:if test="${ memResult.memProfile eq ''}">
      			<img alt="${memResult.memProfile}" src="${ contextPath }/resources/images/person.png" class="rounded-circle align-middle" style="width:50px;height:50px;" />
      		</c:if>
      		<span class="navbar-text align-middle"><strong class="px-2">${ memResult.memName }</strong>님 안녕하세요!</span>
      	</li>
      	<li class="nav-item">
      		<a href="${ contextPath }/updateForm.do" class="nav-link link-dark"><i class="bi bi-wrench align-middle"></i><span class="px-2 align-middle">회원정보수정</span></a>
      	</li>
        <li class="nav-item">
        	<a href="${ contextPath }/imageForm.do" class="nav-link link-dark"><i class="bi bi-camera-fill align-middle"></i><span class="px-2 align-middle">프로필사진등록</span></a>
        </li>
        <li class="nav-item">
        	<a href="${ contextPath }/logout.do" class="nav-link link-dark"><i class="bi bi-box-arrow-right align-middle"></i><span class="px-2 align-middle">로그아웃</span></a>
        </li>
      </ul>
      </c:if>
    </div>
  </div>
</nav>