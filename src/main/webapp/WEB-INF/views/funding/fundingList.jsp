<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<style>
.pagination {
   display: block;
   text-align: center;
}

.pagination>li>a {
   float: none;
}
</style>

<!-- 배너 -->
    <section class="hero-wrap hero-wrap-2" style="background-image: url('resources/images/banner9.jpg'); margin-bottom: 30px;" data-stellar-background-ratio="0.5">
      <div class="overlay"></div>
      <div class="container">
        <div class="row no-gutters slider-text align-items-center justify-content-center">
          <div class="col-md-9 ftco-animate mb-0 text-center">
          	<!-- 
          	<p class="breadcrumbs mb-0"><span class="mr-2"><a href="index.html">모이까 <i class="fa fa-chevron-right"></i></a></span> <span>펀딩보기 <i class="fa fa-chevron-right"></i></span></p>
             -->
            <h1 class="mb-0 bread">펀딩 보기</h1>
          </div>
        </div>
      </div>
    </section>
<section class="ftco-section">
   <div class="container pt-5">
      <div class="row d-flex">


         <c:if test="${empty list }">
            <div style="margin: 0 auto; padding-top: 20%">펀딩하는 모임이 없어요 !</div>
         </c:if>
         <c:forEach var="item" items="${list }" varStatus="loop">

            <div class="col-md-4 d-flex ftco-animate">
               <div class="blog-entry justify-content-end">
                  <div class="text text-center">
                     <a href="<c:url value='/funding/MeetingViewFun.do?meetingNo=${item.meetingNo }'/>" class="block-20 img"
                        style="background-image: url('<c:url value='/images/meeting/${item.meetingName}/${item.bannerImg }' />');">
                     </a>
                     <div
                        class="meta text-center mb-2 d-flex align-items-center justify-content-center">
                        <div>
                           <span
                              class="yr" style="color: #FF7A5C">${item.subCategory }</span><span class="day">${item.calDateDays }</span> <span class="mos">일 남음</span> 
                        </div>
                     </div>
                     <h3 class="heading mb-3">
                        <a href="<c:url value='/funding/MeetingViewFun.do?meetingNo=${item.meetingNo }'/>">${item.meetingName }</a>
                     </h3>
                     <hr/>
                     <div>
                           <span style="font-style: oblique; font-weight: bold;">펀딩금액
                              :${item.amount }</span><span>원</span></div>
                              <span style="font-style: oblique; font-weight: bold;">서포터
                                 :${item.donationList }</span><span>명</span>
                  </div>
               </div>
            </div>
   </c:forEach>

   </div>
   <!-- class="row" -->


   </div>

   <div class="row">
      <div class="col-md-12">${pagingString }</div>
   </div>

</section>

