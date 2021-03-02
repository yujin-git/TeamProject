<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<style>
#meetingDescription {
	margin:20px 0 20px 0;
	/* 한 줄 자르기 */ 
	display: block; 
	width: auto; 
/* 	white-space: nowrap;  */
/* 	overflow: hidden;  */
	text-overflow: ellipsis; 
	/* 여러 줄 자르기 추가 스타일 */ 
	white-space: normal;
	line-height: 1.2;
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


<!-- 모임 상세보기 main -->
<section class="ftco-section" style="margin-top: 0;">
   <div class="container">
      <div class="row justify-content-center">
         <div class="col-md-10" style="margin-top: 30px">
            <div class="heading-section text-center ftco-animate pb-4">
            </div>
            
              <div class="col-md-12" style="color: #FF7A5C; font-size: 30px;"> 모임 소개글 </div> 
              <hr/>
            <span class="fa fa-quote-left" style="color: #FF7A5C; font-size: 50px;"></span>
	            <p id="meetingDescription">${meetingDTO['meetingDescription']}</p>
	         <span class="fa fa-quote-right" style="float: right; color: #FF7A5C; font-size: 50px;"></span>
            
            
            <form method="POST" id="contactForm" name="contactForm"
               class="contactForm">
               <blockquote class="blockquote my-5">
               <div class="col-md-12" style="color: #FF7A5C; font-size: 30px;"> 모임 역할
               	<span style="color:grey;font-size:0.7em;margin-left:10px">(${roleMember} / ${meetingDTO['maxrole']})</span>
               
               	<c:forEach var="item" items="${thisMeetingRole}">
                   	<c:if test="${not doneloop }">
                   		<c:if test="${item.id eq id and item.enabled ne 0 }" >
						<c:set var="doneloop" value="true"/>
                    	</c:if>
                       <c:if test="${empty item.id and empty Mdto and joinMcount eq 0 and item.id ne id and myMeetingNo ne item.meetingNo and empty isApplication}" >
						<div class="pull-right">
							<button type="button" class="btn btn-primary btn-lg" data-toggle="modal" data-target="#joinMeetingSubscription">
								모임 가입하기
							</button>
						</div>
						<c:set var="doneloop" value="true"/>
                    	</c:if>
                   	</c:if>
                   <c:if test="${id ne meetingDTO['operator'] and item.id eq id and item.enabled eq 1}">
                   	<div class="pull-right">
						<button type="button" class="btn btn-primary btn-lg" data-toggle="modal" data-target="#deleteMyMeeting">
							모임 탈퇴하기
						</button>
					</div>
                   </c:if>
                   </c:forEach>
              </div>
              <hr/>
                  <div class="row" style="padding-top: 20px;">
                     
                     <c:set var="doneloop" value="false"/>
                     

                     <!-- 역할 -->
                     
                     <div class="col-md-12" style="margin-bottom:80px">
                        <c:forEach var="item" items="${thisMeetingRole}">
                        	<c:choose>
								<c:when test="${item.enabled eq 0 and not empty isApplication and isApplication['ROLENO'] eq item.roleNo}">
									<div class="col-md-5" style="margin:0px 0px 30px 5px">
	                        			<span style="border:#FFB8A8 2px solid;color:#FFB8A8;padding:5px;border-radius:10%">${item.roleName}</span>
	                        			<span style="margin-left:10px">가입 승인 대기 중</span>
	                        		</div>
	                       		</c:when>
	                        	<c:otherwise>
	                        		<div class="col-md-5" style="margin:0px 0px 30px 5px">
	                        			<span style="border:#FFB8A8 2px solid;color:#FFB8A8;padding:5px;border-radius:10%">${item.roleName}</span>
	                        			<span style="margin-left:10px">${item.name}</span>
	                        		</div>
	                        		
	                        		
	                        		
	                        	</c:otherwise>
                        	</c:choose>
                        </c:forEach>
                     </div>

                     <!-- 활동 사진 -->
                      <div class="col-md-12">
                     
                        <div class="form-group">
                           <label style="color: #FF7A5C; font-size: 30px;">활동사진</label> 
                           <div>
                           <hr/>
                            <c:forEach var="meetingViewMainAppeal" items="${meetingViewMainAppeal}">
                              <img alt="image" style="height: 200px; width: 200px;" src="<c:url value="/images/meeting/${meetingDTO['meetingName']}/BBS/${meetingViewMainAppeal['IMG']}"/>"> 
                            </c:forEach>
                           </div>
                        </div>
                     </div>
                     
                  </div>
               </blockquote>
            </form>
         </div>
      </div>
   </div>

</section>

         

<!-- ======================가입신청 모달================== -->
<div class="modal fade bs-example-modal-md" id="joinMeetingSubscription" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-md">
    <div class="modal-content">
      <div class="modal-header">
      	<h4 class="modal-title" id="myModalLabel">모임 가입신청하기</h4>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
      </div>
      <div class="modal-body">
      	하나의 역할을 선택하여 모임 가입 신청을 할 수 있습니다.<br>
      	가입 승인 이후에 선택한 역할을 변경하실 경우 모임 인원들과 협의 후 관리자에게 문의 바랍니다.<br>
      	모임은 2개까지 가입 가능하며 모임장은 다른 모임에 가입 할 수 없습니다.
      	따라서 가입된 모임이 하나라도 있을 경우 모임 개설이 불가합니다.<br>
      	가입 신청이 승인되면 마이페이지의 가입한 모임 목록에서 확인하실 수 있습니다.<br><br>
      
      <form id="frm" method="post" action='<c:url value="/JoinMeetingSubscription.do?meetingNo=${meetingDTO['meetingNo'] }&id=${id }"/>'>
      	<c:forEach var="item" items="${thisMeetingRole}">
      		<c:if test="${empty item.id}">
        		<input type="radio" name="selectRole" value="${item.roleNo }"> ${item.roleName }<br>
        	</c:if>
        </c:forEach>
      </div>
      	<div class="modal-footer">
        	<button type="button" class="btn btn-default" data-dismiss="modal">취소</button>
       		<button class="btn btn-primary" type="submit" id="submitBtn" >가입신청하기</button>
      	</div>
      </form>
    </div>
  </div>
</div>


<!-- ==========모임 탈퇴 Modal============== -->
<div class="modal fade" id="deleteMyMeeting" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
      	<h4 class="modal-title" id="myModalLabel">모임 탈퇴하기</h4>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
      </div>
      <div class="modal-body">
        <c:forEach var="item" items="${myMeeting }">
        	<c:if test="${item.meetingNo eq meetingDTO['meetingNo'] }">
        		정말 "${item.roleName }"역할을  포기하고 ${meetingDTO['meetingName'] }을(를) 탈퇴하시겠습니까?
        	</c:if>
        	<button type="button" class="btn btn-default" data-dismiss="modal">취소</button>
	        <a class="pull-right" href='<c:url value="/DeleteMyMeeting.do?roleNo=${item.roleNo}&meetingNo=${meetingDTO['meetingNo']}"/>' style="margin-right:30px">
	        	<button class="btn btn-primary" type="button" id="submitBtn" >탈퇴하기</button>
	        </a>
        </c:forEach>
      </div>
    </div>
  </div>
</div>


<script>

//모임 메인================================================================================================
//모임 가입신청
$('#submitBtn').click(function() {
		$('#frm').submit();
	});

</script>