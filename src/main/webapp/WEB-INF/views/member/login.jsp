<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>
<title>로그인</title>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">

<link
	href="https://fonts.googleapis.com/css?family=Roboto:300,400,500,700&display=swap"
	rel="stylesheet">
<link
	href="https://fonts.googleapis.com/css2?family=Lora:ital,wght@0,400;0,500;0,600;0,700;1,400;1,500;1,600;1,700&display=swap"
	rel="stylesheet">

<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">

<link rel="stylesheet" href="resources/css/animate.css">

<link rel="stylesheet" href="resources/css/owl.carousel.min.css">
<link rel="stylesheet" href="resources/css/owl.theme.default.min.css">
<link rel="stylesheet" href="resources/css/magnific-popup.css">

<link rel="stylesheet" href="resources/css/flaticon.css">
<link rel="stylesheet" href="resources/css/style.css">
<style>
#loginBtn {
	background-color: #FF7A5C;
	border: none;
}
</style>
</head>

<body>

	<div class="container-fluid px-md-12  pt-5 ">

		<div class="row justify-content-between">
			<div class="col-md-8 order-md-last">
				<div class="row">
					<div class="col-md-6 text-center">
						<a class="navbar-brand" href="<c:url value="/"/>"><h1>모이까</h1><span></span>
							<small style="font-size:0.9em;text-transform:none;">moikka</small>
						</a>
					</div>
					<div class="col-md-7 pt-3">
						<div class="contact-wrap w-100 p-md-4 p-4">
							<form id="frm" class="contactForm">
								<div class="row">
									<div class="offset-md-1 col-md-8" style="display: block;">
										<div class="form-group">
											<label class="label" for="id" style="font: bold;">아이디</label>
											<input type="text" class="form-control" name="id" id="id">

										</div>
									</div>
									<div class="offset-md-1 col-md-8">
										<div class="form-group">
											<label class="label" for="password">비밀번호</label> <input
												type="password" class="form-control" name="pwd" id="pwd">

										</div>
									</div>
									<div class="offset-md-1 col-md-8 pt-3">
										<div class="form-group">
											<input id="loginBtn" type="button" value="로그인" class="btn btn-success btn-block">
										</div>
									</div>
									<div class="offset-md-1 col-md-8 pt-3"">
										<span style="font-size: 0.9em">아직 회원이 아니신가요?</span> <a
											href="<c:url value='/Join.do'/>" style="font-size: 0.9em">회원가입</a>
									</div>
<!-- 									<div class="offset-md-1 col-md-8 pt-3""> -->
<!-- 									<div style="float: left; margin-top: 3%"> -->
<!-- 									<span style="font-size: 0.8em">카카오톡으로 로그인하기</span> -->
<!-- 									</div> -->
									
<!-- 									<div style="float: left; margin-left: 2%;"> -->
									
<!-- 										<a -->
<!-- 											href="https://kauth.kakao.com/oauth/authorize?client_id=2b4f4d1814f7666b6933614cbc2fac01&redirect_uri=http://localhost:8080/app/kakaoLogin&response_type=code" -->
<!-- 											class="m-b-20"> <img style="width: 60px; height: 60px;" -->
<%-- 											src="<c:url value="/resources/images/kakaoimg.PNG"/>" --%>
<!-- 											alt="KAKAO"> -->
<!-- 										</a> -->
<!-- 										</div> -->
<!-- 										</div> -->
									</div>
							</form>
						</div>
					</div>


				</div>
			</div>
			<!-- 로고 가운데 배치용 -->
			<div class="col-md-4 d-flex"></div>
		</div>



	</div>
	<div id="ftco-loader" class="show fullscreen">
		<svg class="circular" width="48px" height="48px">
			<circle class="path-bg" cx="24" cy="24" r="22" fill="none"
				stroke-width="4" stroke="#eeeeee" />
			<circle class="path" cx="24" cy="24" r="22" fill="none"
				stroke-width="4" stroke-miterlimit="10" stroke="#F96D00" /></svg>
	</div>


	<script src="resources/js/jquery.min.js"></script>
	<script src="resources/js/jquery-migrate-3.0.1.min.js"></script>
	<script src="resources/js/popper.min.js"></script>
	<script src="resources/js/bootstrap.min.js"></script>
	<script src="resources/js/jquery.easing.1.3.js"></script>
	<script src="resources/js/jquery.waypoints.min.js"></script>
	<script src="resources/js/jquery.stellar.min.js"></script>
	<script src="resources/js/owl.carousel.min.js"></script>
	<script src="resources/js/jquery.magnific-popup.min.js"></script>
	<script src="resources/js/jquery.animateNumber.min.js"></script>
	<script src="resources/js/scrollax.min.js"></script>
	<script
		src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBVWaKrjvy3MaE7SQ74_uJiULgl1JY0H2s&sensor=false"></script>
	<script src="resources/js/google-map.js"></script>
	<script src="resources/js/main.js"></script>
	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>

	<script>
		//회원가입 버튼 클릭
		$('#loginBtn').click(function() {

			//form태그의 action속성 및 method속성 설정
			$('#frm').prop({
				action : '<c:url value="/loginProcess.do"/>',
				method : 'post'
			});
			//폼객체의 submit()함수로 서버로 전송
			$('#frm').submit();
		});
		
		
		//enter 눌러서 로그인하기
		$("#frm").keypress(function(e){
			if(e.keyCode==13){
				$('#loginBtn').click();
			}
		});
	</script>
</body>
</html>