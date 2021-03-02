<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<style>

#image {
  width: 100%;
  height: 100%;
  text-align: center;
  position: relative;
  z-index: 1;
}
#image::after {
  width: 100%;
  height: 100%;
  content: "";
  position: absolute;
  top: 0;
  left: 0;
  z-index: -1;
  opacity: 0.3!important; filter:alpha(opacity=30);

}

</style>

<!-- 모임 상세보기 menu -->
<section class="ftco-section ftco-no-pt mt-5 mt-md-3">
   <div class="container justify-content-center">
      <div class="col-lg-12" style="max-width: none; padding-left:3%;">
         <div class="row">
            <div class="col-md-3" role="group" style="padding: 0; margin-left: 0px;">
            <a href='<c:url value="/MeetingViewMain.do?meetingNo=${meetingDTO['meetingNo'] }"/>'><button class="btn btn-primary" style="width: 95%; height: 70px; font-size: 20px; background-color: #FF7A5C;"> HOME</button></a>
            </div>
            <div class="col-md-3" role="group" style="padding: 0; margin-left: 0px;">
            <a href='<c:url value="/MeetingViewBBS.do?meetingNo=${meetingDTO['meetingNo'] }"/>'><button class="btn btn-primary" style="width: 95%; height: 70px;font-size: 20px;background-color: #FF7A5C;"> 모임 게시판</button></a>
            </div>
            <div class="col-md-3" role="group" style="padding: 0; margin-left: 0px;">
            <a href='<c:url value="/MeetingViewCon.do?meetingNo=${meetingDTO['meetingNo'] }"/>'><button class="btn btn-primary" style="width: 95%; height: 70px;font-size: 20px;background-color: #FF7A5C;"> 공연</button></a>
            </div>
            <div class="col-md-3" role="group" style="padding: 0; margin-left: 0px;">
            <a href='<c:url value="/funding/MeetingViewFun.do?meetingNo=${meetingDTO['meetingNo'] }"/>'><button class="btn btn-primary" style="width: 95%; height: 70px;font-size: 20px;"> 펀딩</button></a>
            </div>
         </div>
      </div>
   </div>
</section>
   
   <section class="ftco-section">
   <div class="container">
      <div class="row justify-content-center mb-5">
         <div class="col-md-7 heading-section text-center ftco-animate">
            
            <h2>현재 진행중인 공연</h2>
         </div>
      </div>
      </div>
      </section>
<!-- ================================모임 공연 소개글 부분==================================== -->
<c:if test="${not empty performanceList}" var="performList">
    <c:forEach var="item" items="${performanceList }">

       <div class="container"  style="margin-top: 100px;">
         <div class="row justify-content-center mb-5 filebox">
            <div class="col-md-6" id="cma_image" style="float: left; height: 376px; width: 100%; border:1px solid gray; 
                background-repeat: no-repeat; background-size: cover; background-image: url('/app/images/meeting/${item.meetingName }/perform/${item.main_img }');">
            </div>
            <div class="col-md-6" style="float: right;">
               <div class="heading-section">
                  
                  <c:choose>
                     <c:when test="${id eq item.operator }">
                        <div class="btn-group justify-content-right" style="text-align: right; float: right;">
                           <button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown" aria-expanded="false">
                              ● ● ● <span class="caret"></span>
                           </button>
                           <ul class="dropdown-menu" role="menu">
                              <li><a href='<c:url value="/UpdatePerformance.do?performanceNo=${item.performanceNo }"/>'>수정하기</a></li>
                              <li><a href='<c:url value="/DeletePerformance.do?performanceNo=${item.performanceNo }"/>'>삭제하기</a></li>
                           </ul>
                        </div>
                     </c:when>
                     <c:when test="${id ne item.operator }">
                        <div class="btn-group justify-content-right" style="text-align: right; float: right;">
                           <button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown" aria-expanded="false">
                              &nbsp <span class="caret"></span>
                           </button>
                        </div>
                     </c:when>
                  </c:choose>
                  
                  <br/>
                  <h2 class="mb-4" style="font-size: 35px">${item.title }</h2>
                  <hr />
                  <p>공연 날짜: ${item.perform_date }</p>
                  <p>공연 시간: ${item.perform_time }</p>
                  <p>공연 장소: ${item.place }</p>  
               </div>
            </div>
         </div>            
      </div>
      
         <div class="container">
            <div class="form-group">
               <hr />
                  <span class="fa fa-quote-left"></span>
                     ${item.content }
                  <span class="fa fa-quote-right" style="float: right;"></span>
                  <br>
               <hr />
               <h5 class="col-md-12" style="text-align:center;margin:50px 0 30px 0">공연 보러 오시는 길</h5>   
            </div>
         </div>
         
         
           <section>
         <div class="row no-gutters">
            
            <div class="col-md-1">
               <div class="contact-wrap w-100 p-md-5 p-4">
                  <h3 class="mb-4">&nbsp;</h3>
                  <form method="POST" id="contactForm" name="contactForm" class="contactForm">
                     <div class="row">
                        <div class="col-md-11">
                           <div class="form-group">
                              <!-- 
                              <label class="label" for="#"></label>
                              <textarea name="message" class="form-control" id="message" cols="30" rows="4" placeholder="Message"></textarea>
                               -->
                           </div>
                        </div>
                        <div class="col-md-1">
                           <div class="form-group">
                           <!-- 
                              <input type="submit" value="참석 할게요" class="btn btn-primary">
                              <div class="submitting"></div>
                            -->
                           </div>
                        </div>
                     </div>
                  </form>
               </div>
            </div>
            <div class="col-md-10 offset-1 order-md-first d-flex align-items-stretch">
               <div id="map" class="map pull-right" style="margin:auto;height:400px;width:700px"></div>
            </div>
         </div>
         </section>      
   </c:forEach>
   </c:if>
   <c:if test="${not performList}">

    <!-- ================================모임 공연 소개글 부분 끝==================================== -->
    
    <!-- ================공연글 없을 때========================= -->
    <section class="ftco-section">
         <div class="container" style="margin-top: 100px;">
            <div class="row justify-content-center">
               <div class="col-md-10" style="margin-top: 100px; margin-bottom: 100px; text-align: center;">
               
                        진행중인 공연이 없어요 !


               </div>
            </div>
         </div>
   </section>
   </c:if>
   
   <section class="ftco-section">
   <div class="container">
      <div class="row justify-content-center mb-5">
         <div class="col-md-7 heading-section text-center ftco-animate">
            <hr/>
            <h2 style="color:#FFB8A8 ">이전 공연목록</h2>
         </div>
      </div>
      </div>
      </section>
      
      <c:if test="${not empty oldPerformanceList}" var="oldPerformList">
    <c:forEach var="item" items="${oldPerformanceList }">

       <div class="container"  style="margin-top: 100px;">
         <div class="row justify-content-center mb-5 filebox">
            <div class="col-md-6" id="cma_image" style="float: left; height: 376px; width: 100%; border:1px solid gray; 
                background-repeat: no-repeat; background-size: cover; background-image: url('/app/images/meeting/${item.meetingName }/perform/${item.main_img }');">
            </div>
            <div class="col-md-6" style="float: right;">
               <div class="heading-section">
                  <br/>
                  <h2 class="mb-4" style="font-size: 35px">${item.title }</h2>
                  <hr />
                  <p>공연 날짜: ${item.perform_date }</p>
                  <p>공연 시간: ${item.perform_time }</p>
                  <p>공연 장소: ${item.place }</p>  
               </div>
            </div>
         </div>            
      </div>
         
   </c:forEach>
   </c:if>
   <c:if test="${not oldPerformList}">

    <!-- ================================모임 공연 소개글 부분 끝==================================== -->
    
    <!-- ================공연글 없을 때========================= -->
    <section class="ftco-section">
         <div class="container" style="margin-top: 100px;">
            <div class="row justify-content-center">
               <div class="col-md-10" style="margin-top: 100px; margin-bottom: 100px; text-align: center;">
               
                        이전에 진행했던 공연이 없어요 !


               </div>
            </div>
         </div>
   </section>
   </c:if>
   <!-- ================공연글 없을 때 끝========================= -->

<script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>
<script type="text/javascript"
   src="//dapi.kakao.com/v2/maps/sdk.js?appkey=15e0184946508cca73d2f3bc2dcfd8dc&libraries=services"></script>

  <script>
  
  var gap = '${realAdd}';

  var geocoder = new kakao.maps.services.Geocoder();
  
  geocoder.addressSearch(gap, function(result, status) {
     if (status == kakao.maps.services.Status.OK) {

            var coords = new kakao.maps.LatLng(result[0].y, result[0].x);

            y = result[0].x;
            x = result[0].y;
          
            var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
           mapOption = { 
                  center: new kakao.maps.LatLng(x, y), // 지도의 중심좌표
                  level: 3 // 지도의 확대 레벨
           };
   
         var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다
   
   //마커가 표시될 위치입니다 
         var markerPosition  = new kakao.maps.LatLng(x, y); 
   
   //마커를 생성합니다
         var marker = new kakao.maps.Marker({
           position: markerPosition
         });
   
   //마커가 지도 위에 표시되도록 설정합니다
         marker.setMap(map);
        }
  });
   
   //아래 코드는 지도 위의 마커를 제거하는 코드입니다
   //marker.setMap(null); 
   

    $(function(){
        $('#likeImgOff').on({ 'click': function() { 
           var src = ($(this).attr('src') === 'resources/images/heartOff.png') ? 'resources/images/heartOn.png' : 'resources/images/heartOff.png'; $(this).attr('src', src); } });
   });
    
    
    $('#commentImg').click(function(){
       $('.commentall').toggle();
       $('.commentinput').focus();
       
    });
    
    
    
    $(function(){
        $('#likeImgOff2').on({ 'click': function() { 
           var src = ($(this).attr('src') === 'resources/images/heartOff.png') ? 'resources/images/heartOn.png' : 'resources/images/heartOff.png'; $(this).attr('src', src); } });
   });
    
    $(function(){
        $('#likeImgOff3').on({ 'click': function() { 
           var src = ($(this).attr('src') === 'resources/images/heartOff.png') ? 'resources/images/heartOn.png' : 'resources/images/heartOff.png'; $(this).attr('src', src); } });
   });
    
    $(function(){
        $('#commentLikeImgOff').on({ 'click': function() { 
           var src = ($(this).attr('src') === 'resources/images/heartOff.png') ? 'resources/images/heartOn.png' : 'resources/images/heartOff.png'; $(this).attr('src', src); } });
   });
    
    $(function(){
        $('#commentLikeImgOff2').on({ 'click': function() { 
           var src = ($(this).attr('src') === 'resources/images/heartOff.png') ? 'resources/images/heartOn.png' : 'resources/images/heartOff.png'; $(this).attr('src', src); } });
   });
    
    $(function(){
        $('#commentLikeImgOff3').on({ 'click': function() { 
           var src = ($(this).attr('src') === 'resources/images/heartOff.png') ? 'resources/images/heartOn.png' : 'resources/images/heartOff.png'; $(this).attr('src', src); } });
   });
    
    $(function(){
        $('#commentLikeImgOff4').on({ 'click': function() { 
           var src = ($(this).attr('src') === 'resources/images/heartOff.png') ? 'resources/images/heartOn.png' : 'resources/images/heartOff.png'; $(this).attr('src', src); } });
   });
    
    $(function(){
        $('#commentLikeImgOff5').on({ 'click': function() { 
           var src = ($(this).attr('src') === 'resources/images/heartOff.png') ? 'resources/images/heartOn.png' : 'resources/images/heartOff.png'; $(this).attr('src', src); } });
   });
    
    
    $('.commentall').hide();
    
    
    $('.commentview').click(function(){
       $('.commentall').toggle();
       
    });
    
    
    
    
//=============공연 삭제하기===============
$('#withdrawBtn').click(function(){
   if($('#withdrawPwdCheck').val()=='no'){
      $('#withdrawPwd').focus();
      return;
   }
   
   if(confirm('이 공연을 정말 삭제하시겠어요?')){
   
   $('#withdrawFrm').prop({
      action : "<c:url value='/Withdraw.do'/>",
      method : 'POST'
   });
   //폼객체의 submit()함수로 서버로 전송
   $('#withdrawFrm').submit();
   }
   
});
    
    
    
  </script>  
  
  
 