<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>



<div class="container">
	<div class="row">
		<div class="offset-6 col-6">
			<span id="hide" style="display: none; float: right;"> </span> 
			<span style="float: right; width: 45%;">
				<a href="<c:url value='/PerformanceList.do'/>">
					<span style="font-size: 1.0em;">&nbsp;전체 공연&nbsp;</span>
				</a>
				<a href="<c:url value='/MyTownPerformance.do'/>">
					<span style="font-size: 1.0em; font-weight: bold; color: black;" class="border-left">&nbsp;내 동네</span>
				</a>
			</span>
		</div>
	</div>
</div>


	<!-- 배너 -->
    <section class="hero-wrap hero-wrap-2" style="background-image: url('resources/images/banner9.jpg'); margin-bottom: 10%;" data-stellar-background-ratio="0.5">
      <div class="overlay"></div>
      <div class="container">
        <div class="row no-gutters slider-text align-items-center justify-content-center">
          <div class="col-md-9 ftco-animate mb-0 text-center">
          	<p class="breadcrumbs mb-0"><span class="mr-2"><a href="index.html">모이까 <i class="fa fa-chevron-right"></i></a></span> <span>공연보기 <i class="fa fa-chevron-right"></i></span></p>
            <h1 class="mb-0 bread">우리 동네 공연 보기</h1>
          </div>
        </div>
      </div>
    </section>
		
			
			
    	<div class="container-fluid px-md-5">
    		<c:if test="${town ne null}" var="notTown">
    		<div class="row">
    		
    		<c:forEach var="item" items="${myTownPerformanceList }">
    			<div class="col-md-6 col-lg-4 d-flex">
    				<div class="book-wrap d-lg-flex">
    					<div class="img d-flex justify-content-end" style="background-image: url('/app/images/meeting/${item.meetingName }/perform/${item.main_img }');">
    						<div class="in-text">
    							<a href="<c:url value='/MeetingViewCon.do'/>" class="icon d-flex align-items-center justify-content-center" data-toggle="tooltip" data-placement="left" title="자세히 보기">
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

    		</div>

	        
	        </c:if>
	        
	        <c:if test="${not notTown }">
		       <div class="row">
		            <div
		               class="col-md-6 pt-3 d-flex justify-content-center align-items-center">
		               <img id="real_img"
		                  src="<c:url value="/resources/images/quokka.png"/>"
		                  alt="Raised circle image" class="shadow-lg"
		                  style="width: 500px; height: 500px;">
		            </div>
		            <div class="col-md-6 wrap-about pl-md-5 ftco-animate py-5">
		               <div class="heading-section"
		                  style="text-align: center; padding-top: 40%">"주소가 등록되어 있지 않아요 !<br/>마이페이지에서
		                  개인정보수정으로 동네를 설정해보세요!"</div>
		            </div>
		         
		      </div>
          </c:if>
	        
    	</div>
    </section>
    
    
    
    
    
    
    


<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.12.1/jquery-ui.min.js"></script>
<script type="text/javascript">


</script>
    
