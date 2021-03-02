<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<div class="container-fluid pt-2">
<c:if test="${empty userId }" var="isNotKakaoLogin">
	<sec:authorize access="isAuthenticated()">
		<div class="offset-8 col-md-4">
			<a href="<c:url value="/logout.do"/>"><span
				style="font-size: 0.9em;color: #FFB8A8" class="border-bottom">로그아웃 </span></a>
				&nbsp;&nbsp; <a href="<c:url value='/Mypage.do'/>"><span
				style="font-size: 0.9em;color: #FFB8A8" class="border-bottom">마이페이지</span></a>
		</div>
	</sec:authorize>
	<sec:authorize access="isAnonymous()">
		<div class="offset-8 col-md-4">

			<a href="<c:url value='/login.do'/>">
				<span style="font-size: 0.9em;color: #FFB8A8" class="border-bottom">로그인 </span></a>
			&nbsp;&nbsp;
			<a href="<c:url value='/Join.do'/>">
				<span style="font-size: 0.9em;color: #FFB8A8" class="border-bottom">회원가입</span></a>


		</div>
	</sec:authorize>
</c:if>
<c:if test="${not isNotKakaoLogin }">
	<div class="offset-8 col-md-4">
		<a href="<c:url value="/kakaoLogout"/>"><span
			style="font-size: 0.9em;color: #FFB8A8" class="border-bottom">로그아웃 </span></a>
			&nbsp;&nbsp; <a href="<c:url value='#'/>"><span
			style="font-size: 0.9em;color: #FFB8A8" class="border-bottom">카카오톡 로그인</span></a>
	</div>
</c:if>



</div>

<div class="container-fluid px-md-12  pt-2 ">
	<div class="row justify-content-between">
		<div class="col-md-8 order-md-last">
			<div class="row">
				<div class="col-md-6 text-center">
					<a class="navbar-brand" href="<c:url value="/"/>"><h1>모이까</h1><span></span>
						<small style="font-size:0.9em;text-transform:none;">moikka</small>
					</a>
				</div>
				<div class="d-md-flex justify-content-end mb-md-0 mb-3"></div>
			</div>
		</div>
		<!-- 로고 가운데 배치용 -->
		<div class="col-md-4 d-flex"></div>
	</div>
</div>

<!-- =========== 상단 메뉴 =========== -->
<nav class="navbar navbar-expand-lg navbar-dark ftco_navbar bg-dark ftco-navbar-light" id="ftco-navbar">
	<div class="container-fluid">
		<button class="navbar-toggler" type="button" data-toggle="collapse"
			data-target="#ftco-nav" aria-controls="ftco-nav"
			aria-expanded="false" aria-label="Toggle navigation">
			<span class="fa fa-bars"></span> Menu
		</button>
		<div class="collapse navbar-collapse justify-content-center" id="ftco-nav">
			<ul class="navbar-nav m-auto">
				<li class="nav-item"><a href="<c:url value='/town/AllOfMeeting.do'/>" class="nav-link" style="font-size:1.1em;"> 동네 둘러보기</a></li>
				<li class="nav-item"><a href="<c:url value='/MeetingBBS.do'/>" class="nav-link" style="font-size:1.1em;">게시글</a></li>
				<li class="nav-item"><a href="<c:url value='/PerformanceList.do'/>" class="nav-link" style="font-size:1.1em;">공연</a></li>
				<li class="nav-item"><a href="<c:url value='/FundingList.do'/>" class="nav-link" style="font-size:1.1em;">펀딩</a></li>
				<li>&nbsp;</li>
			</ul>
		</div>
	</div>
</nav>
<!-- =========== 상단 메뉴 END =========== -->

