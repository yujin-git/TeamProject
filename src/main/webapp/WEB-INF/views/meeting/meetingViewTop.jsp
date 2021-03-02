
<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


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
.img-cover{
   position: absolute;
   height: 100%;
   width: 100%;
   background-color: rgba(0, 0, 0, 0.4);                                                                 
   z-index:1;
}

</style>

<!--     모임 상세보기 TOP -->
    
	<div id="image"
		 style="margin:0 auto; margin-top: 5%; height: 400px; width: 75%;  border: 1px solid gray;
		 background-repeat: no-repeat; background-size: cover; background-position:center; background-image: url('/app/images/meeting/${meetingDTO.meetingName }/${meetingDTO.bannerImg }');">
		
		<div class="overlay"></div>      
      		<c:choose>
				<c:when test="${id eq meetingDTO['operator'] }">
					<div class="btn-group justify-content-right" style="text-align: right; float: right;">
						<button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown" aria-expanded="false" style="color:white">
							● ● ● <span class="caret"></span>
						</button>
						<ul class="dropdown-menu" role="menu">
							<li><a href='<c:url value="/UpdateMeeting.do?meetingNo=${meetingDTO['meetingNo']}"/>'>모임 수정하기</a></li>
							<li><a href='<c:url value="/DeleteMeeting.do?meetingNo=${meetingDTO['meetingNo']}"/>'>모임 삭제하기</a></li>
							<c:if test="${endPerform }">
								<li><a href='<c:url value="/CreatePerformance.do?meetingNo=${meetingDTO['meetingNo']}"/>'>공연 만들기</a></li>
							</c:if>
							<c:if test="${empty dto }">
								<li data-toggle="modal" data-target="#myModal" style="color: #FFB8A8; cursor: pointer;">펀딩 신청하기</li>
							</c:if>
							<li data-toggle="modal" data-target="#joinMeetinglist" style="color: #FFB8A8; cursor: pointer;">가입신청목록</li>
						</ul>
					</div>
				</c:when>
				<c:when test="${id ne meetingDTO['operator']}">
					<div class="btn-group justify-content-right" style="text-align: right; float: right;">
						<button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown" aria-expanded="false">
							&nbsp <span class="caret"></span>
						</button>
					</div>
				</c:when>
			</c:choose>
	      
	      
	      <div class="container" style="width: 100%;">
               <div class="col-md-12 ftco-animate mb-0 text-left" style="margin-top: 10%">
                  <div class="col-md-12" style="max-width: initial; text-align: center; font-size: 20px; color: white;">
                   ${category['maincategory'] } > ${category['subcategory'] }
              </div>
               <div class="col-md-12" style="max-width: initial; text-align: center; font-size: 60px; font-weight: bold; color: #FF7A5C;">
                     ${meetingDTO['meetingName']}
               </div>
               <div class="col-md-12" style="text-align: center; font-size: 20px; color: white;">
                  ${meetingDTO['town']}
               </div>
		</div>
	      
	 </div>
</div>

<!--     모임 상세보기 TOP 끝 -->




<!-- ==========펀딩 신청 Modal============== -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
      	<h4 class="modal-title" id="myModalLabel">펀딩 신청하기</h4>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
      </div>
      <div class="modal-body">
      펀딩을 통해 모임 활동과 공연을 개최하는 데에 도움을 받을 수 있습니다.<br><br>
      펀딩은 모임 종료일로부터 7일 전에 종료됩니다.<br>
      펀딩은 신청 후에 수정 또는 삭제 불가합니다.<br>
      모임이 정지되었을 경우 또는 관리자에 의해 펀딩이 강제로 정지 또는 종료 될 수 있습니다.<br>
      정상 종료가 아닌 펀딩 종료시에는 펀딩으로 모인 금액 전액 환불처리 됩니다.<br>
      펀딩 신청 후 펀딩의 내용은 모임 상세페이지의 펀딩 탭에서 확인 가능합니다.<br>
      <br>여러분의 모임을 응원하는 소중한 팬들의 기대에 부응해주세요!<br>
        
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-default" data-dismiss="modal">취소</button>
        <a href='<c:url value="/CreateFunding.do?meetingNo=${meetingDTO['meetingNo'] }"/>'>
        	<button class="btn btn-primary" type="button" id="submitBtn" >신청 보내기</button>
        </a>
      </div>
    </div>
  </div>
</div>


<!-- ======================가입신청 리스트 모달================== -->
<div class="modal fade" id="joinMeetinglist" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h4 class="modal-title" id="myModalLabel">모임 가입신청 목록</h4>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
      </div>
      <div class="modal-body">
      	<input type="hidden" id='zero' value='0'/>
		<c:forEach var="item" items="${applicationRoleList}" varStatus="loop">
			선택 역할 : ${item.roleName }&nbsp;&nbsp;/&nbsp;&nbsp;신청인 : <a  href="#" onclick="javascript:showModal('${item.id}')" style="color:#FF7A5C">${item.name}</a>
			<input id="application_id${loop.count}" type="hidden" name="application" value="${item.id}"/>
			<a href='<c:url value="/JoinMeetingReject.do?roleNo=${item.roleNo }&meetingNo=${item.meetingNo}&id=${item.id}&name=${item.name}"/>'>
				<button class="btn" type="button" id="submitBtn" style="color:#FFB8A8;margin-left:20px">거절하기</button>
			</a>  
			<a href='<c:url value="/JoinMeetingOk.do?roleNo=${item.roleNo }&meetingNo=${item.meetingNo}&id=${item.id}&name=${item.name}"/>'>
	        	<button class="btn btn-primary" type="button" id="submitBtn" style="padding: 0.5%;">수락하기</button>
	        </a><br>
		</c:forEach>
      </div>
    </div>
  </div>
</div>

<div id="modalDiv"></div>


<script>

   function showModal(id){
    var userId=$(id).attr('id');
    
    console.log('userId::',id);
    $.ajax({
       url : "<c:url value='/profileView.do'/>",
       data : {
          'id' : id
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
       	  $('#modalDiv').empty();
          
          $('#modalDiv').append(showModal);
          $('#testModal').modal({backdrop: 'static'});
          $('#testModal').modal("show");

       }

    });
 }
</script>