<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
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
      			<h1 class="mb-0 bread">동네 이웃 둘러보기</h1>
    		</div>
  		</div>
	</div>
</section>


<div class="container">
   <div class="row">
      <div class="offset-5 col-7">
         <span style="float: right;"> 
			<a href="<c:url value='/town/AllOfMeeting.do"'/> id="meeting"> 
				<span style="font-size: 1.2em; color: black;">&nbsp;모임&nbsp;&nbsp;</span>
			</a>
			<a href="<c:url value='/ShowUser.do'/>"> 
				<span style="font-size: 1.2em; font-weight: bold; color: #FFB8A8;" class="border-left">&nbsp;&nbsp;&nbsp;회원</span>
			</a>
		</span>
      </div>
   </div>
</div>



<!-- 동네 둘러보기-->

<section class="ftco-section ftco-degree-bg">
   <div class="container">
      <c:if test="${town ne null}" var="notTown">
         <div class="row">
            <div class="col-lg-12 ftco-animate">

               <div class="row">
                  <c:forEach var="item" items="${list }">
                     <div class="col-md-4 d-flex">
                        <div class="book-wrap">
                           <c:if test="${item.profileimg != null}" var="notProfile">
                              <div class="img d-flex justify-content-end w-100"
                                 style="background-image: url(/app/images/member/${item.id}/${item.profileimg });">
                                 <div class="in-text">
                                    <a href="<c:url value='javascript:showModal(${item.id })'/>"
                                       class="icon d-flex align-items-center justify-content-center">
                                       <span class="flaticon-search"></span>
                                    </a>
                                 </div>
                              </div>
                           </c:if>
                           <c:if test="${not notProfile}">
                              <div class="img d-flex justify-content-end w-100"
                                 style="background-image: url('resources/images/anony.PNG');">
                                 <div class="in-text">
                                    <a href="<c:url value='javascript:showModal(${item.id })'/>"
                                       class="icon d-flex align-items-center justify-content-center">
                                       <span class="flaticon-search"></span>
                                    </a>
                                 </div>
                              </div>
                           </c:if>
                           <div class="text px-4 py-3 order-md-first w-100">
                              <p class="mb-2">
                                 <span class="price">${item.name }</span>
                              </p>
                              <h2>${item.pr }</h2>
                              <span> <c:forEach var="category"
                                    items="${item.categoryList}" varStatus="loop">
                           |${category['MAINCATEGORY'] }·${category['SUBCATEGORY'] }|
                           </c:forEach>
                              </span>
                           </div>
                        </div>
                     </div>
                     
                     
                  </c:forEach>

               </div>

            </div>
            <!-- .col-md-8 -->

            <div class="col-md-12">${pagingString }</div>

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
                  style="text-align: center; padding-top: 40%">
                  "주소가 등록되어 있지 않아요 !<br />마이페이지에서 개인정보수정으로 동네를 설정해보세요!"
               </div>
            </div>

         </div>
      </c:if>

   </div>
</section>
<!-- .section -->
<div id="modalDiv">

</div>
<!-- 회원 상세보기 Modal  data-toggle="modal" data-target="#myModal" style="color: #FFB8A8; cursor: pointer;" -->
<c:forEach var="item" items="${list }">
<div class="modal fade" id="${item.id }" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
      <div class="modal-header">
         <h4 class="modal-title" id="myModalLabel">"${item.name }"님의 프로필</h4>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
      </div>
      <div class="modal-body">

<section class="ftco-section ftco-no-pt" id="section">
   <div class="container">
      <div class="row">

         <div class="select_img col-md-12 text-center">
            <c:if test="${item.profileimg == null}" var="notNull">
               <img id="real_img"
                  src="<c:url value="resources/images/anony.PNG"/>"
                  alt="Raised circle image"
                  class="img-fluid rounded-circle shadow-lg"
                  style="width: 300px; height: 300px;">

            </c:if>
            <c:if test="${not notNull}">
               <img id="real_img"
                  src="<c:url value="/images/member/${item.id}/${item.profileimg}"/>"
                  alt="Raised circle image"
                  class="img-fluid rounded-circle shadow-lg"
                  style="width: 300px; height: 300px;">
            </c:if>

         </div>
         <div class="select_img col-md-12 text-center pt-3">
            <span
               style="display: inline-block; font-size: 2em; font-weight: bold;">${dto.name }</span>
         </div>

         <div class="col-md-12 text-center"
            style="text-align: center;">
            <div class="balloon">
               <c:if test="${item.pr ==null }">
                  <p style="font-size: 1.2em; line-height: 200px">입력된 상태메세지가 없어요 !</p>
               </c:if>
               <c:if test="${item.pr !=null }">
                  <p style="font-size: 1.2em;">${item.pr }</p>
                  </c:if>
            </div>
         </div>
         <div class="col-md-3 text-center"> 
            <div style="font-weight:bold; color :#FF7A5C; font-size: 1.5em">가입일</div>
            <hr/>
         </div>
         <br/>
         <div class="col-md-3 text-center">
         <div style="font-weight:bold; color :#FF7A5C; font-size: 1.5em">성별</div>
         <hr/>
         </div>
         <div class="col-md-3 text-center">
         <div style="font-weight:bold; color :#FF7A5C; font-size: 1.5em">나이</div>
         <hr/>
         </div>
         <div class="col-md-3 text-center">
         <div style="font-weight:bold; color :#FF7A5C; font-size: 1.5em">주소</div>
         <hr/>
         </div>
         <div class="col-md-3 text-center">
            <div style="font-size: 1.5em">${item.postdate }</div>
         </div>
         <div class="col-md-3 text-center">
            <div style="font-size: 1.5em">${item.gender }</div>
         </div>
         <div class="col-md-3 text-center">
            <div style="font-size: 1.5em">${item.age }</div>
         </div>
         <div class="col-md-3 text-center">
            <c:if test="${townDTO.town !=null }">
                     
                     <span style="font-size: 1.5em">${townDTO.town }</span>
                  </c:if>
                  <c:if test="${townDTO.town ==null }">
                     
                     <span style="color: red;">입력된 주소정보가 없어요 !</span>
                  </c:if>
         </div>
         
         
         <div class="select_img col-md-12 text-center "style="padding-top: 10%;">
            <span
               style="display: inline-block; font-size: 1.5em; font-weight: bold; color:#FF7A5C ">어필용 사진 </span>
               <hr/>
         </div>
   
         <c:if test="${empty appealList}" var="appealResult">
            <div class="offset-md-5">&nbsp;등록된 사진이 없어요!</div>

         </c:if>
         <c:if test="${not appealResult}">
         
         <div></div>
            <c:forEach var="item" items="${appealList }" varStatus="loop">

               <div class="offset-1">
                  <div class="imageText">
                     <img id="appeal_img${loop.index }"
                        src="<c:url value="/images/member/${item.id}/${item['IMG']}"/>"
                        alt="Raised circle image" class="img-fluid shadow-lg"
                        style="width: 200px; height: 200px;">
                     <div class="btn">
                        <a href="javascript:isDelete(${item['APPEALNO']});">삭제</a>
                     </div>

                  </div>
               </div>
            </c:forEach>
         </c:if>






         <div class="select_img col-md-12 text-center" style="padding-top: 10%;">
            <span
               style="display: inline-block; font-size: 1.5em; font-weight: bold; color:#FF7A5C ">가입한 모임</span>
               <hr/>
         </div>
      </div>
      <c:if test="${not empty meetingList }" var="meeting">
         <div class="col-lg-12">
            <div class="row">
               <c:forEach var="item" items="${meetingList }" varStatus="loop">
                  <div class="col-md-12">
                     <div class="book-wrap book-wrap-2 d-md-flex">
                        <div class="row" style="margin: 0px;">
                           <div class="img img-2">
                              <c:forEach var="list" items="${item.meetingBBSImgList }">
                                 <div class="img d-flex justify-content-end"
                                    style="background-image: url(images/meeting/${list['MEETINGNAME']}/bbs/${list['IMG'] }); width: 100%; height: 170px;"></div>
                              </c:forEach>
                           </div>
                        </div>
                        <div class="img img-5 d-flex d-flex justify-content-end"
                           style="background-image: url('images/meeting/${item.meetingName }/${item.bannerImg }'); width: 100%;">
                           
                        </div>
                        <div class="text p-4">
                           <h2>${item.meetingName }</h2>
                           <p class="mb-2">
                              <span class="place">${item.town }</span>
                           </p>
                           <span class="position">${item.mainCategory } |
                              ${item.subCategory } | ${item.meetingRoleList}/${item.maxrole }</span>
                           <p>${item.meetingDescription }</p>
                        </div>
                     </div>
                  </div>
               </c:forEach>


            </div>
         </div>
      </c:if>
      <c:if test="${not meeting }">
         <div class="offset-md-5">&nbsp;가입한 모임이 없어요!</div>
      </c:if>
   </div>

</section>
        
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
        <a href='<c:url value="#"/>'><!-- ${item.id } -->
           <button class="btn btn-primary" type="button" id="submitBtn" >모임 가입 제안하기</button>
        </a>
      </div>
    </div>
  </div>
</div>

</c:forEach>

               
            </div>
         </div>
      </div>
   </div>
<script>

//likeMeeting
function meetingLike(likeid,meetingNo){
  console.log(likeid)
  console.log(meetingNo)
  var src = ($(likeid).attr('src') == '/app/resources/images/heartOff.png') ? '/app/resources/images/heartOn.png' : '/app/resources/images/heartOff.png'; 
  console.log(src);
  if(src=='/app/resources/images/heartOn.png'){
     
     $.ajax({
          url:"<c:url value='/meetingLikeMypage.do'/>",
          data:{'meetingNo':meetingNo},
          dataType : 'json',
          success:function(data){ 
             $(likeid).attr('src',src)
          }
          
       });
  }else{
     $.ajax({
          url:"<c:url value='/meetingLikeDelete.do'/>",
          data:{'meetingNo':meetingNo},
          success:function(data){
             $(likeid).attr('src',src)   
          }
          
       });
  }
  
  
}
   function showModal(id){
      if($('#testModal').attr('style')=='display: none;'){
         $('#modalDiv').empty();
      }
      var userId=$(id).attr('id');
      $.ajax({
         url : "<c:url value='/profileView.do'/>",
         data : {
            'id' : userId
         },
         type : 'post',
         dataType : 'json',
         success : function(data) {
            
            var showModal ="<div class='modal fade' id='testModal' tabindex='-1' role='dialog' aria-labelledby='exampleModalLabel' aria-hidden='true'>";
            showModal +="<div class='modal-dialog modal-lg'><div class='modal-content'><div class='modal-header'>"
            showModal +="<h4 class='modal-title' id='exampleModalLabel'>'"+data[0].name+"'님의 프로필</h4><button type='button' class='close' data-dismiss='modal'><span aria-hidden='true'>&times;</span></button></div>"
            showModal +="<div class='modal-body'><section class='ftco-section ftco-no-pt' id='section'><div class='container'><div class='row'>"
            showModal +="<div class='select_img col-md-12 text-center'>";
            if(data[0].profileImg ==null){
               showModal +="<img id='real_img' src='<c:url value='resources/images/anony.PNG'/>' alt='Raised circle image' class='img-fluid rounded-circle shadow-lg' style='width: 300px; height: 300px;'></div>";
            }else{
               showModal +="<img id='real_img' src='<c:url value='/images/member/"+data[0].id+"/"+data[0].profileImg+"'/>' alt='Raised circle image' class='img-fluid rounded-circle shadow-lg' style='width: 300px; height: 300px;'></div>";
            }
            showModal +="<div class='select_img col-md-12 text-center pt-3'> <span style='display: inline-block; font-size: 2em; font-weight: bold;'>"+data[0].name+"</span></div>";
            showModal +="<div class='col-md-12 text-center' style='text-align: center;'> <div class='balloon'>";
            if(data[0].pr ==null){
               showModal +="<p style='font-size: 1.2em; line-height: 200px'>입력된 상태메세지가 없어요 !</p>";
            }else{
               showModal +="<p style='font-size: 1.2em;'>"+data[0].pr+"</p>"
            }
            showModal +="</div></div>"
            showModal +="<div class='col-md-3 text-center'><div style='font-weight:bold; color :#FF7A5C; font-size: 1.5em'>가입일</div><hr/></div><br/>";
            showModal +="<div class='col-md-3 text-center'><div style='font-weight:bold; color :#FF7A5C; font-size: 1.5em'>성별</div><hr/></div>";
            showModal +="<div class='col-md-3 text-center'><div style='font-weight:bold; color :#FF7A5C; font-size: 1.5em'>나이</div><hr/></div>";
            showModal +="<div class='col-md-3 text-center'><div style='font-weight:bold; color :#FF7A5C; font-size: 1.5em'>주소</div><hr/></div>";
            showModal +="<div class='col-md-3 text-center'><div style='font-size: 1.5em'>"+data[0].postDate+"</div></div>";
            showModal +="<div class='col-md-3 text-center'><div style='font-size: 1.5em'>"+data[0].gender+"</div></div>";
            showModal +="<div class='col-md-3 text-center'><div style='font-size: 1.5em'>"+data[0].age+"</div></div>";
            showModal +="<div class='col-md-3 text-center'>";
            if(data[0].town != null){
               showModal +="<span style='font-size: 1.5em'>"+data[0].town+"</span></div>";
            }else{
               showModal+="<span style='color: red;'>입력된 주소정보가 없어요 !</span></div>"
            }
            showModal +="<div class='select_img col-md-12 text-center'style='padding-top: 10%;'> <span style='display: inline-block; font-size: 1.5em; font-weight: bold; color:#FF7A5C'>어필용 사진 </span><hr/></div>";
            if(data[0].appealList ==""){
               showModal+="<div style='margin-left:39%; '>등록된 사진이 없어요!</div>"
            }else{
               for(var i=0; i<data[0].appealList.length; i++){
                  showModal +="<div class='offset-2'><div class='imageText'>"
                  showModal +="<img id='real_img' src='<c:url value='/images/member/"+data[0].id+"/"+data[0].appealList[i]["IMG"]+"'/>' alt='Raised circle image' class='img-fluid shadow-lg' style='width: 200px; height: 200px;'></div></div>";
               }
            }
            showModal +="<div class='select_img col-md-12 text-center' style='padding-top: 10%;'><span style='display: inline-block; font-size: 1.5em; font-weight: bold; color:#FF7A5C '>가입한 모임</span><hr/></div></div>";
            if(data[0].joinedMeetingList !=""){
               showModal +="<div class='col-lg-12'><div class='row'>"
               for(var i=0; i<data[0].joinedMeetingList.length; i++){
                  showModal +="<div class='col-md-6 d-flex'><div class='book-wrap'>";
                  showModal +="<div class='img img-5 d-flex justify-content-end' style='background-image: url(images/meeting/"+data[0].joinedMeetingList[i]["MEETINGNAME"]+"/"+data[0].joinedMeetingList[i]["BANNERIMG"]+"); width: 100%;'>";
                  showModal +="<div class='in-text'>";
                  if(data[0].joinedMeetingList[i]["userLike"] ==1){
                     showModal +="<a href='javascript:meetingLike(meetingLike"+i+","+data[0].joinedMeetingList[i]["MEETINGNO"]+");' class='icon d-flex align-items-center justify-content-center'>";
                     showModal +="<img alt='image' id='meetingLike"+i+"' style='height: 25px; width: 25px; margin-top: 10px' src='/app/resources/images/heartOn.png'></a>";   
                  }else{
                     showModal +="<a href='javascript:meetingLike(meetingLike"+i+","+data[0].joinedMeetingList[i]["MEETINGNO"]+");' class='icon d-flex align-items-center justify-content-center'>";
                     showModal +="<img alt='image' id='meetingLike"+i+"' style='height: 25px; width: 25px; margin-top: 10px' src='/app/resources/images/heartOff.png'></a>";   
                  }
                  showModal +="<a href='<c:url value='/MeetingViewMain.do?meetingNo="+data[0].joinedMeetingList[i]["MEETINGNO"]+"'/>' class='icon d-flex align-items-center justify-content-center'><span class='flaticon-search'></span></a></div></div>";
                  showModal +="<div class='p-4'> <h2>"+data[0].joinedMeetingList[i]["MEETINGNAME"]+"</h2><p class='mb-2'><span class='place'>"+data[0].joinedMeetingList[i]["TOWN"]+"</span></p>";
                  showModal +="<span class='position'>"+data[0].joinedMeetingList[i]["MAINCATEGORY"]+"| "+data[0].joinedMeetingList[i]["SUBCATEGORY"]+"| "+data[0].joinedMeetingList[i]["meetingRoleList"]+"/"+data[0].joinedMeetingList[i]["MAXROLE"]+"</span></div>";
                  showModal +="<p style='margin-left: 20px;'>"+data[0].joinedMeetingList[i]["MEETINGDESCRIPTION"]+"</p></div></div>";
               }//for
               showModal+="</div></div>";
            }else{
               showModal+="<div style='margin-left:38%;'>&nbsp;가입한 모임이 없어요!</div>";
            }
            
            
            showModal +="</div></section></div></div></div></div>"
            $('#modalDiv').append(showModal);
            $('#testModal').modal({backdrop: 'static'});
            $('#testModal').modal("show");

         }

      });
   }
   
   

</script>
