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

#pagination {
   margin: 10px auto;
   text-align: center;
}

#pagination a {
   display: inline-block;
   margin-right: 10px;
}

#pagination .on {
   font-weight: bold;
   cursor: default;
   color: #777;
}
</style>

<!-- 배너 -->
<section class="hero-wrap hero-wrap-2" style="background-image: url('/app/resources/images/banner9.jpg'); margin-bottom: 30px;" data-stellar-background-ratio="0.5">
   <div class="overlay"></div>
   <div class="container">
       <div class="row no-gutters slider-text align-items-center justify-content-center">
          <div class="col-md-9 ftco-animate mb-0 text-center">
               <h1 class="mb-0 bread">동네 둘러보기</h1>
          </div>
        </div>
   </div>
</section>


<div class="container">
   <div class="row">
      <div class="offset-6 col-6">
         <span id="hide" style="display: none; float: right;"> </span> 
         <span style="float: right; width: 45%;">
            <c:if test="${empty Mdto and joinMcount eq 0}" var="NoJoinMeeting">
               <a href="#">
                  <span style="font-size: 1.2em; font-weight: bold; color: black;">&nbsp;모임&nbsp;&nbsp;</span>
               </a>
               <a href="<c:url value="/ShowUser.do"/>" id="meeting">
                  <span style="font-size: 1.2em;" class="border-left">&nbsp;&nbsp;&nbsp;회원</span>
               </a>
               <a href="<c:url value='/CreateMeeting.do'/>">
                  <button class="btn btn-primary pull-right" style="width:auto; height:50;font-size:1.0em">모임 만들기</button>
               </a>
            </c:if>
            <c:if test="${not NoJoinMeeting}">
               <span style="float: right;"> 
                  <a href="#" id="meeting"> 
                     <span style="font-size: 1.2em; font-weight: bold;">&nbsp;모임&nbsp;&nbsp;</span>
                  </a>
                  <a href="<c:url value='/ShowUser.do'/>"> 
                     <span style="font-size: 1.2em;color: black;" class="border-left">&nbsp;&nbsp;&nbsp;회원</span>
                  </a>
               </span>
            </c:if>
         </span>
      </div>
   </div>
</div>


<!-- 지도 -->
<section class="ftco-section ftco-degree-bg">
   <div class="container">
      <div class="row">

         <div class="map_wrap">
            <div id="map"
               style="width: 100%; height: 100%; position: relative; overflow: hidden; z-index:0"></div>

            <div id="menu_wrap" class="bg_white">
               <div class="option">
                  <div>
                     관심있는 카테고리를 검색해보세요 ! <select name="subCategory" id="subCategory">
                        <option disabled selected>소분류</option>
                        <c:forEach var="subCate" items="${subCate }">
                           <option>${subCate["SUBCATEGORY"] }</option>
                        </c:forEach>
                     </select> <input type="button" class='btn btn-success' value='검색'
                        id='searchCategoryBtn' />

                  </div>
               </div>
               <hr>
               <div id="placesList"></div>
               <div id="pagination"></div>
            </div>
         </div>
      </div>
   </div>
</section>


<!-- 동네 둘러보기-->
<div id="seeTown">
   <section class="ftco-section" id="section">
      <div class="container">
         <div class="row mb-5">
            <c:if test="${not empty meetingList }" var="meeting">
               <div class="col-lg-12">
                  <div class="row" id="infinite">

                     <c:forEach var="item" items="${meetingList }" varStatus="loop">
                        <div class="col-md-6 d-flex">
                           <div class="book-wrap">
                              <div class="img img-5 d-flex d-flex justify-content-end"
                                 style="background-image: url('/app/images/meeting/${item['MEETINGNAME'] }/${item['BANNERIMG'] }'); width: 100%;">
                                 <div class="in-text">

                                    <c:if test="${item['userLike'] ==1 }" var="notLike">
                                       <a
                                          href="javascript:meetingLike(meetingLike${loop.count },${item['MEETINGNO']});"
                                          class="icon d-flex align-items-center justify-content-center">
                                          <img alt="image" id="meetingLike${loop.count }"
                                          style="height: 25px; width: 25px; margin-top: 10px"
                                          src="/app/resources/images/heartOn.png">
                                       </a>
                                    </c:if>
                                    <c:if test="${not notLike }">
                                       <a
                                          href="javascript:meetingLike(meetingLike${loop.count },${item['MEETINGNO']});"
                                          class="icon d-flex align-items-center justify-content-center">
                                          <img alt="image" id="meetingLike${loop.count }"
                                          style="height: 25px; width: 25px; margin-top: 10px"
                                          src="/app/resources/images/heartOff.png">
                                       </a>
                                    </c:if>

                                    <a
                                       href="<c:url value='/MeetingViewMain.do?meetingNo=${item["MEETINGNO"] }'/>"
                                       class="icon d-flex align-items-center justify-content-center">
                                       <span class="flaticon-search"></span>
                                    </a>
                                 </div>
                              </div>
                              <div class="text p-4">
                                 <h2>${item['MEETINGNAME'] }</h2>
                                 <p class="mb-2">
                                    <span class="place">${item['TOWN'] }</span>
                                 </p>
                                 <span class="position">${item['MAINCATEGORY'] } |
                                    ${item['SUBCATEGORY'] } |
                                    ${item['meetingRoleList']}/${item['MAXROLE'] }</span>

                              </div>
                              <div>
                                 <p style="margin-left: 20px;">${item['MEETINGDESCRIPTION'] }</p>
                              </div>
                           </div>
                        </div>

                     </c:forEach>


                  </div>
               </div>
            </c:if>
            <c:if test="${not meeting }">
               <div class="offset-md-5">&nbsp;내동네에 모임이 없어요!</div>
            </c:if>
         </div>

      </div>
   </section>
</div>



<script
   src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.12.1/jquery-ui.min.js"></script>
<!-- <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=5df4291e2d99c275b1ea40e928f7d96c&libraries=services"></script> -->

<script type="text/javascript"
   src="//dapi.kakao.com/v2/maps/sdk.js?appkey=15e0184946508cca73d2f3bc2dcfd8dc&libraries=services,clusterer"></script>
<script>
var nowPage =1;
$(window).scroll(function() {
	console.log("d::", $(document).height());
	console.log("w::", $(window).height());
	console.log('scrolltop::',$(window).scrollTop());
	
	var scrollTop = $(window).scrollTop();
	console.log("type::",typeof(scrollTop));
	
   if($(window).scrollTop() == $(document).height() - $(window).height()) {
      nowPage++;
      console.log('맨밑에 닿았다?');
      $.ajax({
            url : "<c:url value='/infiniteScroll.do'/>",
            data : {
               'nowPage' : nowPage
            },
            dataType : 'json',//필수
            success : function(data) {
               if(data==""){
                  alert("모임이 더이상 존재하지 않아요 !");
                  return;
               }
         var section="";
                for (var i = 0; i < data.length; i++) {

                     section +="<div class='col-md-6 d-flex'>";
                     section +="<div class='book-wrap'>"

                     section += "<div class='img img-5 d-flex d-flex justify-content-end' style='background-image: url(/app/images/meeting/"
                           + data[i].meetingName
                           + "/"
                           + data[i].bannerImg
                           + "); width: 100%;'>"
                     section += "<div class='in-text'>"
                     if (data[i].userLike == 1) {
                        var id = 'meetingLike' + (i+data[i].start);
                        section += "<a href='javascript:meetingLike("
                              + id
                              + ","
                              + data[i].meetingNo
                              + ");' class='icon d-flex align-items-center justify-content-center'> <img alt='image' id='meetingLike"+(i+data[i].start)+"' style='height: 25px; width: 25px; margin-top: 10px' src='/app/resources/images/heartOn.png'></a>";
                     } else {
                        section += "<a href='javascript:meetingLike(meetingLike"+(i+data[i].start)+","+data[i].meetingNo+");' class='icon d-flex align-items-center justify-content-center'> <img alt='image' id='meetingLike"+(i+data[i].start)+"' style='height: 25px; width: 25px; margin-top: 10px' src='/app/resources/images/heartOff.png'></a>";
                     }

                     section += "<a href='<c:url value='/MeetingViewMain.do?meetingNo="
                           + data[i].meetingNo
                           + "'/>' class='icon d-flex align-items-center justify-content-center' > <span class='flaticon-search'></span></a>"
                     section += "</div></div>";
                     section += "<div class='text p-4'> <h2>"
                           + data[i].meetingName
                           + "</h2> <p class='mb-2'> <span class='place'>"
                           + data[i].town
                           + "</span> </p> <span class='position'>"
                           + data[i].mainCategory + " |"
                           + data[i].subCategory + " | "
                           + data[i].meetingRoleList + "/"
                           + data[i].maxrole + "</span><p>"
                           
                     section += "</div>"
                     section +="<p style='margin-left: 20px;'>"+data[i].meetingDescription+"</p></div></div>"

                  }
                $('#infinite').append(section);
            }

         });
   }
});
   $('#freebbs').click(function() {

      if ($('#hide').css('display') == 'none') {
         $('#hide').show("slide");
         $('#freebbs').css('backgroundColor', '');
      } else {
         $('#hide').hide("slide");
         $('#freebbs').css('backgroundColor', '');
      }

   })

   $('#searchCategory').keydown(function(e) {
      if (e.keyCode == 13) {
         $('#searchCategoryBtn').click();
      }
   });

   $('#searchCategoryBtn')
         .click(
               function() {
                  $
                        .ajax({
                           url : "<c:url value="/kakaoMapCategoryAjax.do"/>",
                           type : 'post',
                           dataType : 'json',
                           data : "subCategory="
                                 + $('#subCategory').val(),
                           success : function(data) {
                              $('#placesList').children('div')
                                    .remove();
                              if (data[0].no == "no") {
                                 var div = "<div>";
                                 div += "<span style='color : red;'>"
                                       + $('#subCategory').val()
                                       + "</span> 로(으로) 검색한 결과가 없어요 !"
                                 div += "</div>";
                                 $('#placesList').append(div);
                              } else {
                                 for (var i = 0; i < data.length; i++) {
                                    var div = "<div>";
                                    if (data[i].bannerImg == null) {
                                       div += "<img src='<c:url value='/resources/images/anony.PNG'/>' alt='Raised circle image' style='width: 200px; height: 200px; margin-left: 7%; margin-top:5%'>";
                                    } else {
                                       div += "<img src='<c:url value='/images/meeting/"+data[i].meetingName+"/"+data[i].bannerImg+"'/>' alt='Raised circle image' style='width: 200px; height: 200px; margin-left: 7%; margin-top:5%'>";
                                    }
                                    div += "<br/><span style='color : #FFB8A8;font-weight: bold; font-size :1.2em'>"
                                          + data[i].meetingName
                                          + "</span>";
                                    div += "<br/><span style='font-weight :bold;'>장소 : "
                                          + data[i].town
                                          + "</span>";
                                    div += "<br/><a href='<c:url value='/MeetingViewMain.do?meetingNo="
                                          + data[i].meetingNo
                                          + "'/>' style='float: right; font-size:1.3em'>자세히보기</a>"
                                    div += "<div style='display :block;'>분류 :"
                                          + data[i].mainCategory
                                          + ">"
                                          + data[i].subCategory
                                          + "</div>"
                                    div += "<hr/>"

                                    $('#placesList').append(div);
                                 }
                              }
                           }
                        });

               })

   //likeMeeting
   function meetingLike(likeid, meetingNo) {
      console.log("likeid =", likeid)
      console.log(meetingNo)
      var src = ($(likeid).attr('src') == '/app/resources/images/heartOff.png') ? '/app/resources/images/heartOn.png'
            : '/app/resources/images/heartOff.png';
      console.log(src);
      if (src == '/app/resources/images/heartOn.png') {

         $.ajax({
            url : "<c:url value='/meetingLike.do'/>",
            data : {
               'meetingNo' : meetingNo
            },
            success : function(data) {

               $(likeid).attr('src', src)

            }

         });
      } else {
         $.ajax({
            url : "<c:url value='/meetingLikeDelete.do'/>",
            data : {
               'meetingNo' : meetingNo
            },
            success : function(data) {

               $(likeid).attr('src', src)

            }

         });
      }

   }

   //KakaoMap

   var gap = '${town}';

   var geocoder = new kakao.maps.services.Geocoder();

   var latLng = {
      'positions' : []
   };

   <c:forEach items='${allMeetingList}' var='item' varStatus="loop">

   geocoder.addressSearch('${item.town}', function(result, status) {

      // 정상적으로 검색이 완료됐으면,
      if (status == kakao.maps.services.Status.OK) {

         var coords = new kakao.maps.LatLng(result[0].y, result[0].x);

         y = result[0].x;
         x = result[0].y;

         latLng.positions.push({
            'town' : '${item.town}',
            'lat' : x,
            'lng' : y
         }); //모임하나당 주소,X,Y
         console.log('test' + latLng)
      }

   });
   </c:forEach>

   function makeOverListener(map, marker, infowindow) {
      return function() {
         infowindow.open(map, marker);
         console.log('마우스 올라감');
      };
   }

   // 인포윈도우를 닫는 클로저를 만드는 함수입니다 
   function makeOutListener(infowindow) {
      return function() {
         console.log('마우스 내려감')
         infowindow.close();
      };
   }

   function clickMarker(town) {
      return function() {

         $
               .ajax({
                  url : "<c:url value="/kakaoMapAjax.do"/>",
                  type : 'post',
                  dataType : 'json',
                  data : "town=" + town,
                  success : function(data) {

                     $('#section').remove();
                     var section = "<section class='ftco-section' id='section'>";
                     section += "<div class='container'>";
                     section += "<div class='row mb-5'>";
                     section += "<div class='col-lg-12'>";
                     section += "<div class='row'>";

                     console.log(data[0].meetingName)
                     for (var i = 0; i < data.length; i++) {

                        section +="<div class='col-md-6 d-flex'>"
                        section +="<div class='book-wrap'>"

                        section += "<div class='img img-5 d-flex d-flex justify-content-end' style='background-image: url(/app/images/meeting/"
                              + data[i].meetingName
                              + "/"
                              + data[i].bannerImg
                              + "); width: 100%;'>"
                        section += "<div class='in-text'>"
                        if (data[i].userLike == 1) {
                           var id = 'meetingLike' + i;
                           section += "<a href='javascript:meetingLike("
                                 + id
                                 + ","
                                 + data[i].meetingNo
                                 + ");' class='icon d-flex align-items-center justify-content-center'> <img alt='image' id='meetingLike"+i+"' style='height: 25px; width: 25px; margin-top: 10px' src='/app/resources/images/heartOn.png'></a>";
                        } else {
                           section += "<a href='javascript:meetingLike(meetingLike"+i+","+data[i].meetingNo+");' class='icon d-flex align-items-center justify-content-center'> <img alt='image' id='meetingLike"+i+"' style='height: 25px; width: 25px; margin-top: 10px' src='/app/resources/images/heartOff.png'></a>";
                        }

                        section += "<a href='<c:url value='/MeetingViewMain.do?meetingNo="
                              + data[i].meetingNo
                              + "'/>' class='icon d-flex align-items-center justify-content-center' > <span class='flaticon-search'></span></a>"
                        section += "</div></div>";
                        section += "<div class='text p-4'> <h2>"
                              + data[i].meetingName
                              + "</h2> <p class='mb-2'> <span class='place'>"
                              + data[i].town
                              + "</span> </p> <span class='position'>"
                              + data[i].mainCategory + " |"
                              + data[i].subCategory + " | "
                              + data[i].meetingRoleList + "/"
                              + data[i].maxrole + "</span><p>"
                              
                        section += "</div>"
                        section +="<p style='margin-left: 20px;'>"+data[i].meetingDescription+"</p></div></div>"

                     }
                     section += "</section>";
                     $('#seeTown').append(section);

                  }
               });

      };
   }
   setTimeout(function() {
            // 주소로 좌표를 검색
            geocoder.addressSearch(gap,function(result, status) {
            // 정상적으로 검색이 완료됐으면,
               if (status == kakao.maps.services.Status.OK) {
                  var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
                  y = result[0].x;
                  x = result[0].y;
                  // 마커를 생성합니다
                  var myMarker = new kakao.maps.Marker({
                     position : new kakao.maps.LatLng(x,y),
                     clickable : true
                        });

                  var container = document.getElementById('map'); //지도를 담을 영역의 DOM 레퍼런스
                  var options = { //지도를 생성할 때 필요한 기본 옵션
                     center : new kakao.maps.LatLng(x, y), //지도의 중심좌표.
                     level : 13
                        };
                  var map = new kakao.maps.Map(container,options); //지도 생성 및 객체 리턴

                  var clusterer = new kakao.maps.MarkerClusterer(
                     {
                        map : map, // 마커들을 클러스터로 관리하고 표시할 지도 객체 
                        averageCenter : true, // 클러스터에 포함된 마커들의 평균 위치를 클러스터 마커 위치로 설정 
                        minLevel : 8
                     });
                  var allMarkers = [];
                  for (var i = 0; i < latLng.positions.length; i++) {
                        var x = latLng.positions[i].lat;
                        var y = latLng.positions[i].lng;
                        var marker = new kakao.maps.Marker(
                              {
                                 map : map, // 마커를 표시할 지도
                                 position : new kakao.maps.LatLng(x, y), // 마커의 위치
                                 clickable : true
                                 });
                  var infowindow = new kakao.maps.InfoWindow(
                        {
                           content : latLng.positions[i].town
                        });

                  kakao.maps.event.addListener(marker,'mouseover',makeOverListener(map,marker,infowindow));
                  kakao.maps.event.addListener(marker,'mouseout',makeOutListener(infowindow));
                  kakao.maps.event.addListener(marker,'click',clickMarker(latLng.positions[i].town));
                  allMarkers.push(marker);
                  }
                  clusterer.addMarkers(allMarkers);
                  myMarker.setMap(map);
                  var iwContent = '<div style="padding:2px; font-size :0.4em">내위치 : ${town}</div>', // 인포윈도우에 표출될 내용으로 HTML 문자열이나 document element가 가능합니다
                  iwPosition = new kakao.maps.LatLng(x, y); //인포윈도우 표시 위치입니다
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