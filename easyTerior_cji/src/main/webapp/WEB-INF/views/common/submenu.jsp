<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %><%-- JSTL --%>
<c:set var="contextPath" value="${ pageContext.request.contextPath }" />
<%-- --%>
<div class="fixed-top position-relative navbar border-end border-dark border-5 bg-white" style="width:100px;height:100vh;">
	<button class="btn " style="position:absolute;top:15px;left:15px;" type="button" data-bs-toggle="offcanvas" data-bs-target="#offcanvasScrolling" aria-controls="offcanvasScrolling">
		<i class="bi bi-list fw-bolder fs-1"></i>
	</button>
</div>

<div class="offcanvas offcanvas-start border-end border-dark border-5 bg-white m-auto" data-bs-scroll="true" data-bs-backdrop="false" tabindex="-1" id="offcanvasScrolling" aria-labelledby="offcanvasScrollingLabel" style="position:abosolute; top:0; left:100px;">
    <div class="offcanvas-header position-relative">
        <h1 class="offcanvas-title m-auto" id="offcanvasExampleLabel">
        	<a class="nav-link active" aria-current="page" href="${ contextPath }/"><img style="width:100px;height:100px;" src="${ contextPath }/resources/images/common/ET_logo.png" class="rounded mx-auto d-block" alt="logo"></a>
        </h1>
        <button type="button" class="btn-close text-reset" data-bs-dismiss="offcanvas" aria-label="Close" style="position: absolute;top: 15px;right: 15px;"></button>
    </div>
    <div class="offcanvas-body">
    	<ul>
    		<li class="mb-3"><a href="${ contextPath }/styleRoom.do" class="px-3 nav-link link-dark">스타일 분석</a></li>
    		<li class="mb-3"><a href="${ contextPath }/colorChange.do" class="px-3 nav-link link-dark">색깔 변경하기</a></li>
    		<li class="mb-3"><a href="${ contextPath }/boardMain.do" class="px-3 nav-link link-dark">커뮤니티</a>
    		</li>
    	</ul>
        <div>
        EasyTerior
        </div>
    </div>
</div>
<!-- Javascript -->