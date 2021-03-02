<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


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
    
<!-- ======================작성하기 버튼============================================= -->
<c:if test="${meetingDTO['meetingNo'] eq meetingno }" >

<section class="ftco-section"  style="margin-top: 0px;">
   <div class="container">
      <div class="row justify-content-center">
         <div class="col-md-10" style="text-align: right;">
               우리 모임의 활동을 공유해보세요!<a href="<c:url value="/WriteMeetingBBS.do?meetingNo=${meetingDTO['meetingNo'] }"/>"><button class="btn"style="width: 100px; height: 50; background-color: #FF7A5C; color: white; margin-left:15px">작성하기</button></a>
            
         </div>
      </div>
   </div>

</section>
</c:if>
<!-- ======================작성하기 버튼 끝============================================= -->
    
<!-- =======================모임 게시판부분========================= -->
<section>
   <div class="container" style="margin-top: 0px; width: 710px;">
         <div class="row justify content-center" style="margin-right: 0px !important; padding-right: 0px !important; margin-left: 0px; padding-left: 0px; width: 710px; ">
               <!-- ============= 게시글 하나 ============== -->
               <c:forEach items="${meetingViewBBS}" varStatus="status" var="meetingViewBBS">
                   
                  <div class="item wrapper" style="display: inline-block; width: 720px;">
                     <div class="testimony-wrap py-5" style="margin-bottom: 50px; width: 710px;">
                        <!-- 모임 사진, 이름, 작성 날짜, 메뉴 -->
                        <div class="row" style="margin-bottom: 10px; height: 50px; margin-right: 0px; margin-left: 0px; padding-left: 0px; padding-right: 0px;">
                           <img class="icon d-flex align-items-center" style=" width: 50px; height: 50px; border-radius: 50%; border: 2px solid black;"  src="<c:url value="/images/meeting/${meetingViewBBS['MEETINGNAME']}/${meetingViewBBS['BANNERIMG'] }"/>"></img>
                           <div class="col-md-10 col-md-offset-2" style="padding-top: 10px; font-size:20px; font-weight: bold; color: black;">${meetingViewBBS['MEETINGNAME'] }</div>
                           <!-- 드롭다운 -->
                           <c:if test="${meetingViewBBS['ID'] eq id  }">
                         <div class="col-md-1" style="padding-top: 10px;">
                       <div class="dropdown-toggle" type="button" id="dropdownMenuButton" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" >
                         <img alt="image" src="resources/images/menuIcon.png" style="height: 30px; width: 30px;">
                       </div>
                       <div class="dropdown-menu" aria-labelledby="dropdownMenuButton">
                         <a class="dropdown-item" href="<c:url value="/EditMeetingBBS.do?BBSNO=${meetingViewBBS['BBSNO'] }"/>" style="text-align: center;">수정하기</a>
                         <a class="dropdown-item" href="<c:url value="/DeleteMeetingBBS.do?BBSNO=${meetingViewBBS['BBSNO'] }"/>" style="text-align: center;">삭제하기</a>
                       </div>
                    </div>
                  </c:if>
                        </div>
                        <!-- 이미지 -->
                        <div id="carouselExampleIndicators${status.count }" class="carousel slide" data-ride="carousel"  data-interval="false">
                           <!-- 이미지 언더바 -->
                           <c:if test="${meetingViewBBS['imgcount'] != '1' }">
                           <ol class="carousel-indicators">
                              <c:forEach begin="1" end="${meetingViewBBS['imgcount'] }"  varStatus="statusimg">
                                       <li data-target="#carouselExampleCaptions${status.count }" 
                                       <c:if test="${statusimg.count== 1 }">class="active"</c:if> data-slide-to="${statusimg.count }"></li>
                              </c:forEach>
                           </ol>
                           </c:if>
                            <!-- 이미지 언더바 끝 -->
                            
                            <!-- 이미지 -->
                           <div class="carousel-inner" style="height: 500px;">
                              <c:forEach items="${meetingViewBBS['mBBSImg']}" var="mBBSImg" varStatus="statusimglist">
                                     <div class="carousel-item <c:if test="${statusimglist.count eq 1 }">active</c:if>">
                                       <img class="d-block w-100" src="<c:url value="/images/meeting/${meetingViewBBS['MEETINGNAME'] }/BBS/${mBBSImg['IMG'] }"/>" style="max-width: 100%; height: 500px;"> 
                           </div>
                              </c:forEach>
                           </div>
                           <!-- 이미지 끝 -->
                           <c:if test="${meetingViewBBS['imgcount'] != '1' }">
                           <a class="carousel-control-prev" href="#carouselExampleIndicators${status.count }" role="button" data-slide="prev">
                            <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                            <span class="sr-only">Previous</span>
                          </a>
                          <a class="carousel-control-next" href="#carouselExampleIndicators${status.count }" role="button" data-slide="next">
                            <span class="carousel-control-next-icon" aria-hidden="true"></span>
                            <span class="sr-only">Next</span>
                          </a>
                          </c:if>
                        </div>

                        <!-- 좋아요/댓글수 -->
                           <c:if test="${meetingViewBBS['userLike'] ==1}" var="notLike">
                               <img alt="image" id="likeImg${status.count }" 
                                     style="height: 30px; width: 30px; margin-top: 10px; margin-bottom: 10px; margin-right: 10px;"
                                    src="resources/images/heartOn.png"  
                                  onclick="javascript:liketoggle('likeImg${status.count }', '${meetingViewBBS['BBSNO']}')"> 
                          </c:if>
                           <c:if test="${not notLike}">
                          <img alt="image" id="likeImg${status.count }"
                             style="height: 30px; width: 30px; margin-top: 10px; margin-bottom: 10px; margin-right: 10px;"
                              src="resources/images/heartOff.png"  
                         onclick="javascript:liketoggle('likeImg${status.count }', '${meetingViewBBS['BBSNO']}')"> 
                           </c:if>
                    
                           <img alt="image"
                              id="commentImg"
                              style="height: 30px; width: 30px; margin-top: 10px; margin-bottom: 10px;"
                              src="resources/images/comment.png">

                  


                        <!-- 글자 -->
                        <div class="text" style="margin-top: 10px;">
                           <div class="d-flex align-items-center">
                              <div class="position" style="width: 710px;">
                                 ${meetingViewBBS['CONTENTS'] }</div>
                           </div>
                        </div>

                        <!-- 작성 날짜 -->
                        <div class="col-md-12"
                           style="padding-left: 0px; padding-right: 0px; text-align: right; padding-top: 10px; color: gray;"><fmt:formatDate var="resultRegDt" value="${meetingViewBBS['BBSPOSTDATE'] }" pattern="yyyy-MM-dd"/>${resultRegDt}</div>


                        <!-- 댓글 입력창 -->
                        <div class="text" style="margin-top: 20px;">
                           <div class="commentinput" style="align-items: center">
                              <div class="input-group align-items-center">
                              <c:if test="${dto.profileimg == null}" var="notNull">
                                 <div class="icon d-flex align-items-center" style="width: 50px; height: 50px; margin-right: 10px;"></div>
                              </c:if>
                              <c:if test="${not notNull}">
                                 <img class="icon d-flex align-items-center" style="width: 50px; height: 50px; border-radius: 50%; background-color:#FFB8A8;"  src="<c:url value="/images/member/${dto.id}/${dto.profileimg}"/>"></img>
                              </c:if>
                                <input type="hidden" value="${meetingViewBBS['BBSNO'] }" id="bbsno${status.count}">
                                     <input id="commentInputText${status.count}" class="form-control" type="text"
                                    style="height: 32px; width: 360px; margin-left: 10px; padding-top: 10px; color: gray;"
                                    placeholder="댓글을 입력하세요" onfocus="this.placeholder=''"
                                    onblur="this.placeholder='댓글을 입력하세요'" value=""  >
                                 
                                 <button class="commentButton" style="text-align: center; height: 52px; width: 60px; color: white; font-weight: bold; background-color:#FF7A5C; border: 0px; " onclick="javascript:commentbutton('commentInputText${status.count}','bbsno${status.count}')">게시</button>
                                  
                                  
                                  
                              </div>
                           </div>
                        </div>
                        <!-- 댓글 부분 -->
                        <div class="commentall" id="commentall${meetingViewBBS['BBSNO'] }"
                           style="margin-top: 0px; margin-bottom: 0px; margin-left: 0px; margin-right: 0px; padding-left: 0px; padding-right: 0px;" onload="javascript:commentall('commentall${status.count }')">

                        </div>
                       <!-- 댓글 부분 끝 -->
                     </div>
                  </div>
               </c:forEach>
               <!-- ============= 게시글 하나 끝 ============== -->
               
         
         </div>
      </div>
   </div>
</section>






<script src="resources/js/jquery.min.js"></script>
<script>

 
   showComments();
   
   var bbsno="";
   var commentallid="";
  
   
   //좋아요 함수
   function liketoggle(likeid,bbsno){
      
      var src = ($('#'+likeid).attr('src') == 'resources/images/heartOff.png') ? 'resources/images/heartOn.png' : 'resources/images/heartOff.png'; 
      if(src=='resources/images/heartOn.png'){
         
         $.ajax({
              url:"<c:url value='/BBSLike.do'/>",
              data:{'bbsno':bbsno},
              success:function(data){
                 $('#'+likeid).attr('src',src)
                 
              }
              
           });
      }else{
         console.log("조항요 해제"+likeid)
         $.ajax({
              url:"<c:url value='/BBSLikeDelete.do'/>",
              data:{'bbsno':bbsno},
              success:function(data){
                 $('#'+likeid).attr('src',src)
                 
              }
              
           });
      }
      
      
   }


   var comment_hidden = $('#comment_hidden').val();
   console.log("comment_hidden::",comment_hidden);
   //댓글 입력클릭시
  
   function commentbutton(commentinputtext,bbsnoid){
   //$('#commentButton').click(function(){
   //$('#'+comment_hidden).click(function(){
       //console.log(commentbuttonid);
      console.log("댓글 입력 버튼 클릭!",commentinputtext);
     
      
       var comment = $('#'+commentinputtext).val();
      
       if(comment==""){
       console.log("메소드 종료");
          return; 
       
      }
      
       
       
       bbsno = $('#'+bbsnoid).val();
       
       console.log(comment);
       console.log("코멘트 버튼에 BBSNO : ",bbsno);
       console.log("댓글 입력중");
       
       $.ajax({
          url:"<c:url value='/CommentInsert.do'/>",
          data:{'comment':comment, 'bbsno':bbsno},
          success:function(){
             
             console.log("댓글 입력 성공");
             showComments();
          
             $('#'+commentinputtext).val('');
             $('#'+commentinputtext).focus();
          }
          
       });
       
    //});
   
   }
    
   //현재 글번호에 대한 모든 댓글을 요청하는 함수
   function showComments() {
      $.ajax({
         url : "<c:url value='/CommentView.do'/>",
         dataType : 'json',
         type : 'post',
         success : function(data){
            showComments_(data,'commentall');
            
         },
         error : function(e) {
            console.log(e);
         }
   
      });
   
   }//////////////showComments
   
   
   //댓글목록 뿌려주는 함수
   function showComments_(data, id) {
      console.log('코멘트 목록:', data);
      $('.'+id).html("");
     
      
      $.each(data,function(index,element){
//          bbsno= $("#bbsno").val();
            var comments ="";
         
            comments+= "<div class='text' style='margin-top: 20px;'>";
            comments+="<div class='comment' style='align-items: center'>";
            comments+="<div class='input-group align-items-center'>";
            //comments+="<img class='icon d-flex align-items-center' style='width: 32px; height: 32px; border-radius: 50%'  src='<c:url value='/images/"+profileimg+"'/>'></img>"+element["id"];   
            if(element["profileimg"]==null){
               comments+="<div class='icon d-flex align-items-center' style='width: 50px; height: 50px; margin-right: 10px;'></div>"
            }
            else{
               comments+="<img class=icon d-flex align-items-center' style='width: 50px; height: 50px; border-radius: 50%; background-color:#FFB8A8;'  src='<c:url value='/images/member/"+element["id"]+"/"+element["profileimg"]+"'/>'></img>"
             }
            comments+="<div class='col-md-2 col-md-offset-1'>"+element["id"]+"</div>"
            comments+="<div class='comments col-md-8 col-md-offset-3' style='margin-left: 0px; width: 450px; height: 32px; '>"+element["commentContents"]+"</div>";
           $("#"+id+element["bbsno"]).html($("#"+id+element["bbsno"]).html()+comments);
      });
      
     
      
   }/////////////////////showComments_
   


   
</script>