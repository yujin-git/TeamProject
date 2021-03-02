<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<style>
.map_wrap, .map_wrap * {
	margin: 0;
	padding: 0;
	font-family: 'Malgun Gothic', dotum, '돋움', sans-serif;
	font-size: 12px;
}

.map_wrap a, .map_wrap a:hover, .map_wrap a:active {
	color: #000;
	text-decoration: none;
}

.map_wrap {
	position: relative;
	width: 100%;
	height: 500px;
}

#menu_wrap {
	position: absolute;
	top: 0;
	left: 0;
	bottom: 0;
	width: 250px;
	margin: 10px 0 30px 10px;
	padding: 5px;
	overflow-y: auto;
	background: rgba(255, 255, 255, 0.7);
	z-index: 1;
	font-size: 12px;
	border-radius: 10px;
}

.bg_white {
	background: #fff;
}

#menu_wrap hr {
	display: block;
	height: 1px;
	border: 0;
	border-top: 2px solid #5F5F5F;
	margin: 3px 0;
}
</style>
<!-- 배너 -->
    <section class="hero-wrap hero-wrap-2" style="background-image: url('resources/images/banner9.jpg'); margin-bottom: 30px;" data-stellar-background-ratio="0.5">
      <div class="overlay"></div>
      <div class="container">
        <div class="row no-gutters slider-text align-items-center justify-content-center">
          <div class="col-md-9 ftco-animate mb-0 text-center">
          	<!-- 
          	<p class="breadcrumbs mb-0"><span class="mr-2"><a href="index.html">모이까 <i class="fa fa-chevron-right"></i></a></span> <span>공연보기 <i class="fa fa-chevron-right"></i></span></p>
             -->
            <h1 class="mb-0 bread">공연 보기</h1>
          </div>
        </div>
      </div>
    </section>

<!-- 
<div class="container">
	<div class="row">
		<div class="offset-6 col-6">
			<span id="hide" style="display: none; float: right;"> </span> 
			<span style="float: right; width: 45%;">
				<a href="#">
					<span style="font-size: 1.0em; font-weight: bold; color: black;">&nbsp;전체 공연&nbsp;</span>
				</a>
				<a href="<c:url value='/MyTownPerformance.do'/>">
					<span style="font-size: 1.0em;" class="border-left">&nbsp;내 동네</span>
				</a>
			</span>
		</div>
	</div>
</div>
 -->


<section class="ftco-section" style="margin-top: 0;">
	

	<section class="ftco-section ftco-degree-bg" style="margin-top: 0; margin-bottom: 5%;">
		<div class="container">
			<div class="row">
				<div class="map_wrap">
					<div id="map" style="width:100%;height:100%;position:relative;overflow:hidden;"></div>
					<div id="menu_wrap" class="bg_white">
						<ul id="performance">
							<li style="text-align: center; color: red">알고싶은 공연을 클릭하세요 !</li>
							<hr />

						</ul>
						<div id='selectPerform'>
						

						</div>
					</div>
				</div>
			</div>
		</div>

	</section>
	

    	<div class="container-fluid px-md-5">
    		<div class="row">
    		
    		<c:forEach var="item" items="${performanceList }">
    			<div class="col-md-6 col-lg-4 d-flex">
    				<div class="book-wrap d-lg-flex">
    					<div class="img d-flex justify-content-end" style="background-image: url('/app/images/meeting/${item.meetingName }/perform/${item.main_img }');">
    						<div class="in-text">
    							<a href="<c:url value='/MeetingViewCon.do?meetingNo=${item.meetingNo }'/>" class="icon d-flex align-items-center justify-content-center" data-toggle="tooltip" data-placement="left" title="자세히 보기">
    								<span class="flaticon-search"></span>
    							</a>
    						</div>
    					</div>
    					<div class="text p-4">
    						<p class="mb-2"><span class="price">${item.meetingName }</span></p>
    						<h2><a href="<c:url value='/MeetingViewCon.do'/>">${item.title }</a></h2>
    						<span class="position">${item.place }</span>
    						<span class="position">${item.perform_date }</span>
    						<span class="position">${item.perform_time }</span>
    					</div>
    				</div>
    			</div>
    		</c:forEach>

    		</div><!-- row -->

	        
    	</div>
    </section>
    
  
<script type="text/javascript"
	src="//dapi.kakao.com/v2/maps/sdk.js?appkey=15e0184946508cca73d2f3bc2dcfd8dc&libraries=services,clusterer"></script>
<script type="text/javascript">
	//도시 선택===========================================================================
	$('#meeting').click(function() {

		if ($('#hide').css('display') == 'none') {
			$('#hide').show("slide");
			$('#meeting').css('backgroundColor', 'red');
		} else {
			$('#hide').hide("slide");
			$('#meeting').css('backgroundColor', '');
		}

	})

	var gap = '${town}';

	var geocoder = new kakao.maps.services.Geocoder();

	var latLng = {
		'positions' : []
	};

	var i = 0;

	<c:forEach items='${performanceList}' var='item' varStatus="loop">

	geocoder.addressSearch('${item.place}', function(result, status) {

		// 정상적으로 검색이 완료됐으면,
		if (status == kakao.maps.services.Status.OK) {

			var coords = new kakao.maps.LatLng(result[0].y, result[0].x);

			y = result[0].x;
			x = result[0].y;

			latLng.positions[i] = {
				'place' : '${item.meetingName}',
				'performanceNo' : '${item.performanceNo}',
				'lat' : x,
				'lng' : y
			}; //모임하나당 주소,X,Y

			console.log(latLng.positions[i].place)
			console.log(latLng.positions[i].lat)
			console.log(latLng.positions[i].lng)
			console.log(latLng.positions[i].performanceNo)
			i++;
			console.log(i);
		}

	});
	</c:forEach>

	function makeOverListener(map, marker, infowindow) {
		return function() {
			infowindow.open(map, marker);
		};
	}

	// 인포윈도우를 닫는 클로저를 만드는 함수입니다 
	function makeOutListener(infowindow) {
		return function() {
			infowindow.close();
		};
	}

	function clickMarker(performanceNo) {
		return function() {
			$.ajax({
				url : "<c:url value="/kakaoMapPerformAjax.do"/>",
				type : 'post',
				dataType : 'json',
				data : "performanceNo=" + performanceNo,
				success : function(data) {
				console.log(data[0].meetingName);
					$('#selectPerform').children('div').remove();
					var div="<div>";
					div +="<img src='<c:url value='images/meeting/"+data[0].meetingName+"/perform/"+data[0].main_img+"'/>' alt='Raised circle image' style='width: 200px; height: 200px; margin-left: 8%; margin-top:5%'>";
					div +="<span style='color : #FFB8A8;font-weight: bold; margin-left :35%; font-size :1.2em'>"+data[0].meetingName+"</span><br/>";
					div +="<span style='font-weight :bold;'>날짜 : "+data[0].perform_date+" / "+data[0].perform_time+"</span>";
					div +="<br/><span style='font-weight :bold;'>장소 : "+data[0].place+"</span>";
					div +="<br/><a href='<c:url value='/MeetingViewMain.do?meetingNo="+data[0].meetingNo+"'/>' style='float: right; font-size:1.3em'>자세히보기</a>"
					div +="</div>";
					$('#selectPerform').append(div);
				}
			});
		};

	}
	setTimeout(
			function() {
				geocoder
						.addressSearch(
								gap,
								function(result, status) {
									console.log(latLng);
									// 정상적으로 검색이 완료됐으면,
									if (status == kakao.maps.services.Status.OK) {

										var coords = new kakao.maps.LatLng(
												result[0].y, result[0].x);

										y = result[0].x;
										x = result[0].y;

										// 마커를 생성합니다
										var myMarker = new kakao.maps.Marker({
											position : new kakao.maps.LatLng(x,
													y),
											clickable : true
										});

										var container = document
												.getElementById('map'); //지도를 담을 영역의 DOM 레퍼런스
										var options = { //지도를 생성할 때 필요한 기본 옵션
											center : new kakao.maps.LatLng(x, y), //지도의 중심좌표.
											level : 13
										};
										var map = new kakao.maps.Map(container,
												options); //지도 생성 및 객체 리턴

										var clusterer = new kakao.maps.MarkerClusterer(
												{
													map : map, // 마커들을 클러스터로 관리하고 표시할 지도 객체 
													averageCenter : true, // 클러스터에 포함된 마커들의 평균 위치를 클러스터 마커 위치로 설정 
													minLevel : 8
												});

										// 데이터에서 좌표 값을 가지고 마커를 표시합니다
										// 마커 클러스터러로 관리할 마커 객체는 생성할 때 지도 객체를 설정하지 않습니다

										var allMarkers = [];
										for (var i = 0; i < latLng.positions.length; i++) {

											var x = latLng.positions[i].lat;
											var y = latLng.positions[i].lng;
											console.log(x, y);
											var marker = new kakao.maps.Marker(
													{
														map : map, // 마커를 표시할 지도
														position : new kakao.maps.LatLng(
																x, y), // 마커의 위치
														clickable : true
													});

											// 마커에 표시할 인포윈도우를 생성합니다 
											var infowindow = new kakao.maps.InfoWindow(
													{
														content : latLng.positions[i].place
													// 인포윈도우에 표시할 내용
													});

											// 마커에 mouseover 이벤트와 mouseout 이벤트를 등록합니다
											// 이벤트 리스너로는 클로저를 만들어 등록합니다 
											// for문에서 클로저를 만들어 주지 않으면 마지막 마커에만 이벤트가 등록됩니다
											kakao.maps.event
													.addListener(marker,
															'mouseover',
															makeOverListener(
																	map,
																	marker,
																	infowindow));
											kakao.maps.event
													.addListener(
															marker,
															'mouseout',
															makeOutListener(infowindow));
											kakao.maps.event
													.addListener(
															marker,
															'click',
															clickMarker(latLng.positions[i].performanceNo));

											allMarkers[i] = marker;
											console.log(i + '   '
													+ marker.position)

										}

										clusterer.addMarkers(allMarkers);

										myMarker.setMap(map);

										var iwContent = '<div style="padding:2px; font-size :0.4em">내위치 : ${town}</div>', // 인포윈도우에 표출될 내용으로 HTML 문자열이나 document element가 가능합니다
										iwPosition = new kakao.maps.LatLng(x, y); //인포윈도우 표시 위치입니다

										// 인포윈도우를 생성합니다
										var infowindow = new kakao.maps.InfoWindow(
												{
													position : iwPosition,
													content : iwContent,
													removable : true
												});

										infowindow.open(map, myMarker);

										kakao.maps.event.addListener(myMarker,
												'click', function() {
													// 마커 위에 인포윈도우를 표시합니다
													infowindow.open(map,
															myMarker);
												});

									}
									//만약 주소가 없으면 클러스터링만
									else {
										alert('주소를 설정해주세요 !')
										location.href = '<c:url value="/Mypage.do"/>';
									}

								});
			}, 300);
</script>


