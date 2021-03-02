<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>




<section class="hero-wrap hero-wrap-2" style="background-image: url(<c:url value='/resources/images/banner11.jpg' />); " data-stellar-background-ratio="0.5">
      <div class="overlay"></div>
      <div class="container">
        <div class="row no-gutters slider-text align-items-center justify-content-center">
          <div class="col-md-9 ftco-animate mb-0 text-center">
            <h1 class="mb-0 bread">모임의 소식을 공유해요!</h1>
          </div>
        </div>
      </div>
</section>





<div class="container">
   <div class="row">
      <div class="col-md-12" style="margin-top: 20px;">
         
            <!-- 씨큐리티 적용:csrf취약점 방어용 -->
            <input type="hidden" name="${_csrf.parameterName}"
               value="${_csrf.token}" />
               
               
         <div class="form-group" style="margin-top: 100px;">
            <form id="frm" method="post" enctype="multipart/form-data" action="<c:url value="/EditBBS.do"/>">
               <input type="hidden" value="${mBBSSelectOne['mbbsno'] }" id="mbbsno" name="mbbsno">
               
               <!-- 사진 등록 -->
               <div class="col-sm-12">
                  <label class="col-sm-11 control-label" style="font-size: 20pt; color:#FF7A5C; padding-left: 0px;">이미지 등록</label>
                  <span class="img_insert col-sm-1">
                     <a href="javascript:" onclick="fileUploadAction();" class="my_button" style="font-size: 40px; color:#FF7A5C; ">+</a>
                     <input type="file" name="file" id="input_imgs" multiple="multiple" style="display: none;"/>
                  </span>
                  <hr/>
                  </div>
                  
                  <!-- 미리보기 나오는 곳 -->
                  <div>
                     <div class="imgs_wrap">
                         <c:forEach items="${mBBSSelectOneImg}" varStatus="index" var="mBBSSelectOneImg">
                           <a href="javascript:void(0);" onclick="deleteImageAction(${index.count})" id="img_id_${index.count }">
                              <img name='file' src='<c:url value="/images/meeting/${mBBSSelectOneImg['MEETINGNAME'] }/BBS/${mBBSSelectOneImg['IMG'] }"/>' data-file='"+f.name+"' class='selProductFile' title='Click to remove' style='width:200px; height:200px; margin-right:20px;'>
                           </a>
                         </c:forEach>
                     </div>
                  </div>   
                     
                     
               <!-- 내용 등록 -->
               <label class="col-sm-12 control-label" style="font-size: 20pt; color:#FF7A5C;">내용</label>
               <hr/>
               <div class="col-sm-12">
                  <div class="row">
                     <div class="col-sm-12">
                        <textarea class="form-control" name="contents" rows="10" placeholder="내용을 입력하세요" id="contents">${mBBSSelectOne.contents }</textarea>
                     </div>
                  </div>
               </div>
               
               <!-- 작성 버튼 -->
               <div class="col-sm-12" style="margin-top: 20px;">
                  <a href="javascript:" class="my_button" onclick="submitAction();"><button class="btn col-sm-12" style="background-color: #FF7A5C; width: 1110px; height: 60px; color: white;  border-radius: 25px; font-size:20pt;">수정하기</button></a>
               </div>
            </form>
         </div>
         
         
      </div>
   </div>

</div>

   <!-- 경고창 모달 시작 -->
    <div class="modal fade" id="small-modal" data-backdrop="static">
     <div class="modal-dialog modal-sm">
       <div class="modal-content">
          <div class="modal-body">
             <button class="close" data-dismiss="modal">&times;</button>
             
             <h5 class="modal-title"><span class="glyphicon glyphicon-bullhorn"></span> 경고 메시지</h5>
             <h6 id="warningMessage"></h6>
          </div>
            
       </div>
     </div>
   </div>










<script src="resources/js/jquery.min.js"></script>
<script src="resources/js/bootstrap.min.js"></script>

<script type="text/javascript">
   var focusObject;
   var sel_files=[];

   $(document).ready(function(){
      
      $("#input_imgs").on("change", handleImgFileSelect);
      
   });/////////////document.ready
   
   function fileUploadAction() {
      console.log("fileUploadAction 들어옴");
      $("#input_imgs").trigger('click');
      console.log("input_imgs 트리거 클릭");
   
   }

   function handleImgFileSelect(e) {
      console.log("handleImgFileSelect 들어옴");
      //이미지 정보들 초기화
      sel_files = [];
      $(".imgs_wrap").empty();
      
      var files = e.target.files;
      var filesArr = Array.prototype.slice.call(files);
      var index = 0;
      
      filesArr.forEach(function(f) {
         
         if(!f.type.match("image.*")){
            alert("확장자는 이미지 확장자만 가능합니다.");
            return;
         }
         sel_files.push(f);
         var reader = new FileReader();
         reader.onload = function(e) {
            var html = "<a href=\"javascript:void(0);\" onclick=\"deleteImageAction("+index+")\" id=\"img_id_"+index+"\"><img name='file' src=\"" + e.target.result + "\" data-file='"+f.name+"' class='selProductFile' title='Click to remove' style='width:200px; height:200px; margin-right:20px;'></a>";
            $(".imgs_wrap").append(html);
            index++;
         }
         reader.readAsDataURL(f);
      });
   }
   
   //이미지 클릭 시 삭제
   function deleteImageAction(index) {
      console.log("index : " + index);
      sel_files.splice(index, 1);
      
      var img_id = "#img_id_"+index;
      $(img_id).remove();
      
      console.log(sel_files);
   }
   
   //내용 미입력시 경고창
   $('form').on('submit',function(){
      if($(this).get(0).contents.value==""){
         $('#warningMessage').html("내용를 입력하세요");
         $('#small-modal').modal('show');
         focusObject =$(this).get(0).content;
         return false;               
      }
   });
   
   
   function submitAction(){
      if($('#input_imgs').val() == "" ){
         alert("사진을 입력하세요");
         return;
      }
      else if($('#contents').val() == "" ){
         alert("내용을 입력하세요");
         return;
      }
      else{
         $('#frm').submit();
      }
   }
   
   
   
</script>









