package com.moegga.app.web;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Vector;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.collections.map.HashedMap;
import org.json.simple.JSONArray;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.moegga.app.service.BBSService;
import com.moegga.app.service.BBS_ImgService;
import com.moegga.app.service.CategoryService;
import com.moegga.app.service.ChattingService;
import com.moegga.app.service.FundingDTO;
import com.moegga.app.service.Like_MeetingService;
import com.moegga.app.service.MeetingDTO;

import com.moegga.app.service.MeetingRoleDTO;

import com.moegga.app.service.MeetingRoleService;
import com.moegga.app.service.MeetingService;
import com.moegga.app.service.MemberDTO;
import com.moegga.app.service.MemberService;
import com.moegga.app.service.PerformanceDTO;
import com.moegga.app.service.TownDTO;
import com.moegga.app.service.TownService;
import com.moegga.app.service.impl.PagingUtil;
//import com.sun.org.glassfish.gmbal.ParameterNames;
import sun.net.www.MeteredStream;

@Controller
public class TownViewController {

   @Resource(name = "memberService")
   MemberService member;
   @Resource(name = "townService")
   TownService town;
   @Resource(name = "categoryService")
   CategoryService category;
   @Resource(name = "meetingService")
   MeetingService meeting;
   @Resource(name = "meetingRoleService")
   MeetingRoleService meetingRole;
   @Resource(name = "bbsService")
   BBSService bbs;
   @Resource(name = "bbs_imgService")
   BBS_ImgService bbs_img;
   @Resource(name = "like_meetingService")
   Like_MeetingService like_meeting;
   
   @Resource(name = "chattingService")
   ChattingService chattingService;

   @Value("${MEMBERPAGE_SIZE}")
   private int pageSize;
   @Value("${MEMBERBLOCK_PAGE}")
   private int blockPage;
   
   @RequestMapping(value="/town/AllOfMeeting.do")
   public String meeting(Authentication auth,Model model,@RequestParam Map map) {
      
      List<Map> subCategoryList = category.selectSubCategory(map);
      String id = ((UserDetails) auth.getPrincipal()).getUsername();
      map.put("id", id);
      TownDTO townDTO = town.selectTownById(map);
      String town = null;
      map.put("town", town);
      List<MeetingDTO> allMeetingList = meeting.selectMeetingList(map);
      
      if (townDTO != null) {
         town = townDTO.getTown();
         map.put("town", town);
      }
      
      map.put("start", 1);
      map.put("end", 2);

       List<Map> meetingList =meeting.selectMeetingListInfiniteScroll(map);
      for(Map meeting:meetingList ) {
         
         if (meeting.get("MEETINGDESCRIPTION").toString().length() > 30) {
            meeting.put("MEETINGDESCRIPTION", meeting.get("MEETINGDESCRIPTION").toString().substring(0, 30) + ". . .");
           }else {
               
            }
         
         map.put("meetingNo", meeting.get("MEETINGNO"));
         int meetingRoleList = meetingRole.selectMeetingRoleList(map);

         meeting.put("meetingRoleList", meetingRoleList);

         String userLike = like_meeting.selectMeetingLike(map);

         meeting.put("userLike", userLike);

      }

      map.put("operator", id);
      MeetingDTO Mdto=meeting.selectMeetingByOperator(map);
     
      model.addAttribute("Mdto", Mdto);
      int joinMcount=meetingRole.selectJoinMeetingList(map);
     
      model.addAttribute("joinMcount", joinMcount);
      
      //2021-01-09 동네모임리스트 db에서 꺼내기까지 완료
      model.addAttribute("meetingList",meetingList);
      model.addAttribute("town",town);
      model.addAttribute("allMeetingList",allMeetingList);
      model.addAttribute("subCate",subCategoryList);
      
      return "/town/allOfMeeting.tiles";
   }
//////////////////////////////////////////////////////////////////////////////////////////////////끝
   @RequestMapping(value = "/ShowUser.do", method = RequestMethod.GET)
   public String member(@RequestParam Map map, Model model, Authentication auth, HttpServletRequest req) {
      String id = ((UserDetails) auth.getPrincipal()).getUsername();

      map.put("id", id);
      List categorySize = new Vector<>();
      TownDTO townDTO = town.selectTownById(map);

      String town = null;
      map.put("town", town);
      if (townDTO != null) {
         town = townDTO.getTown();
         map.put("town", town);
      }

      int nowPage = map.get("nowPage") == null ? 1 : Integer.parseInt(map.get("nowPage").toString());
      int totalRecord = member.selectMemberListCount(map);
      int totalPage = (int) Math.ceil((double) totalRecord / pageSize);
      int start = (nowPage - 1) * pageSize + 1;
      int end = nowPage * pageSize;

      map.put("start", start);
      map.put("end", end);

      List<MemberDTO> list = member.selectMemberList(map);
      

      String pagingString = PagingUtil.pagingBootStrapStyle(totalRecord, pageSize, blockPage, nowPage,
            req.getContextPath() + "/ShowUser.do?");

      for (MemberDTO dto : list) {
         if (dto.getPr() == null) {
            dto.setPr("자기소개가 없어요");
         } else {
            if (dto.getPr().length() > 15) {
               dto.setPr(dto.getPr().substring(0, 10) + ". . .");
            }
         }
         map.put("id", dto.getId());
         System.out.println(dto.getId());
         dto.setCategoryList(category.selectCategory(map));
         
      }
      


      model.addAttribute("categorySize", categorySize);
      model.addAttribute("town", town);
      model.addAttribute("list", list);
      model.addAttribute("pagingString", pagingString);
      model.addAttribute("totalRecord", totalRecord);
      model.addAttribute("nowPage", nowPage);
      model.addAttribute("pageSize", pageSize);
      return "/town/showUser.tiles";
   }
   
   @RequestMapping(value = "/profileView.do", produces = "text/html; charset=UTF-8")
   @ResponseBody
   public String profileView(@RequestParam Map map, Model model,Authentication auth) {
      String id =map.get("id").toString();
      
      MemberDTO memberDTO = member.selectOneById(map);
      TownDTO townDTO =town.selectTownById(map);
      String userTown=null;
      if(townDTO != null) {
         userTown =townDTO.getTown();
      }
      List<Map> appealList = member.selectAppealList(map);
   
      Map record = new HashMap();
      List<Map> list = new Vector<Map>();
      List<Map> joinedMeetingList =meeting.selectJoinedMeetingList(map);
      
      for (Map joinedMeeting : joinedMeetingList) {

         if (joinedMeeting.get("MEETINGDESCRIPTION").toString().length() > 15) {
            joinedMeeting.put("MEETINGDESCRIPTION", joinedMeeting.get("MEETINGDESCRIPTION").toString().substring(0, 15) + ". . .");
         }
         
         map.put("meetingNo", joinedMeeting.get("MEETINGNO"));

         int meetingRoleList = meetingRole.selectMeetingRoleList(map);
         map.put("id", ((UserDetails) auth.getPrincipal()).getUsername()); //프로필뷰를 보는사람의 아이디를 map에다 넣어서 미팅좋아요 유무판단
         String userLike = like_meeting.selectMeetingLike(map);
         map.put("id", id); //다시 프로필을 보여지는 사람의 아이디를 map에 넣음

         joinedMeeting.put("userLike", userLike);

         joinedMeeting.put("meetingRoleList", meetingRoleList);
      }
      System.out.println("가입한 모임 :"+joinedMeetingList);
      record.put("about_me", memberDTO.getAbout_me());
      record.put("age", memberDTO.getAge());
      record.put("gender", memberDTO.getGender());
      record.put("id", memberDTO.getId());
      record.put("name", memberDTO.getName());
      record.put("postDate", memberDTO.getPostdate().toString());
      record.put("pr", memberDTO.getPr());
      record.put("profileImg", memberDTO.getProfileimg());
      record.put("town", userTown);
      record.put("appealList", appealList);
      record.put("joinedMeetingList", joinedMeetingList); //이게 jsp로 에이작스 넘어가면서 에이작스가 안됨. dto로 받고있느,ㄴ걸 map으로 한번 받아보자 ㅆㅃ
      

      list.add(record);

      return JSONArray.toJSONString(list);
      
   }
////////////////////////////////////////////////////////////////////////////////////////////////
   @RequestMapping(value = "/CreateMeeting.do", method = RequestMethod.GET)
   public String createMeeting(Model model) {
      List<Map> mainCategory = category.selectMainCategory(); // select distinct * maincategory from category
                                                // ->음악,예술,공연,스포츠
      System.out.println(mainCategory.size());
      for (Map maincate : mainCategory) {
         System.out.println("메인카테고리 :" + maincate.get("MAINCATEGORY"));
      }
      model.addAttribute("mainCategory", mainCategory);
      return "/meeting/createMeeting.tiles";
   }

      
   ///CreateNewMeeting.do
   @RequestMapping(value="/CreateNewMeeting.do")
   public String createNewMeeting(@RequestParam("cma_file") MultipartFile upload,@RequestParam Map map,HttpServletRequest req,Authentication auth) {
      
      String id = ((UserDetails) auth.getPrincipal()).getUsername();
      map.put("operator", id); // #{operator}

      int maxrole = 1;
      for (String memberRole : req.getParameterValues("memberRole")) {
         maxrole++;
      }

      map.put("maxRole", maxrole);
      map.put("content", map.get("content").toString().replace("<p>", "").replace("</p>", ""));
      //map.put("content", map.get("content").toString().substring(3, map.get("content").toString().lastIndexOf("<")));
      
      int categoryNo=category.selectCategoryNo(map);

      map.put("categoryNo", categoryNo);
      
      System.out.println("여기:"+upload.getOriginalFilename());
      map.put("bannerImg", upload.getOriginalFilename());
      System.out.println("dkfoWHr"+map.get("bannerImg"));
      
      meeting.insertNewMeeting(map);

      MeetingDTO meetingDTO = meeting.selectMeetingByOperator(map);

      map.put("meetingNo", meetingDTO.getMeetingNo());


      map.put("img", upload.getOriginalFilename().toString());

      String path = req.getSession().getServletContext().getRealPath("/images"+File.separator+"meeting"+File.separator+meetingDTO.getMeetingName());
      File pathFile = new File(path);
        if(!pathFile.exists()) {
           pathFile.mkdirs();
        }

      File file = new File(path+File.separator + upload.getOriginalFilename());
      try {
         upload.transferTo(file);
      } catch (IllegalStateException e) {
         // TODO Auto-generated catch block
         e.printStackTrace();
      } catch (IOException e) {
         // TODO Auto-generated catch block
         e.printStackTrace();
      }

      map.put("id", id);
      MemberDTO memberDTO = member.selectOneById(map);
      map.put("name", memberDTO.getName());
      meetingRole.insertOperator(map);
      for (String memberRole : req.getParameterValues("memberRole")) {
         map.put("memberRole", memberRole); // meetingRole이라는 name값 , 처음에 베이스 라는 value;
         meetingRole.insertMemberRole(map); // #{meetingRole} ->베이스
      }
      
      
      /* 그룹 채팅 생성 및 가입용 */
      /* 모임정보(meetingno, meetingname) 가져오기 */
		Map getMeetingInfo = chattingService.getMeetingInfo(map);
		System.out.println(getMeetingInfo);
		
		String meetingno = map.get("meetingNo").toString();
		String meetingname = getMeetingInfo.get("MEETINGNAME").toString();
		System.out.println("meetingno:"+meetingno+", meetingname:"+meetingname);
		
		/* 채팅방 생성용 */
		chattingService.createChatRoom(getMeetingInfo);
		System.out.println("채팅방 생성 성공!!!");
		
		/* 채팅방 가입용 */
		int chatno = chattingService.getChatno(meetingno);
		String roleNo = getMeetingInfo.get("ROLENO").toString();
		String name = map.get("name").toString();
		Map chatMap = new HashedMap();
		chatMap.put("chatno", chatno);
		chatMap.put("name", name);
		chatMap.put("roleNo", roleNo);
		chattingService.chatMemberInsert(chatMap);
		System.out.println("채팅방 참가도 성공!!!");
		
		
		map.clear();

      return "redirect:MeetingViewMain.do?meetingNo="+meetingDTO.getMeetingNo();
   }

   @RequestMapping(value = "/meetingLikeMypage.do", produces = "text/html; charset=UTF-8")
   @ResponseBody
   public String meetingLikeMypage(@RequestParam Map map, Authentication auth) {

      String id = ((UserDetails) auth.getPrincipal()).getUsername();
      map.put("id", id);
      like_meeting.insertMeetingLike(map);

      MeetingDTO dto = meeting.selectOneMeetingByNoAndId(map);

      Map record = new HashMap();
      List<Map> list = new Vector<Map>();
      
      if (dto.getMeetingDescription().length() > 25) {
         dto.setMeetingDescription(dto.getMeetingDescription().substring(0, 25) + ". . .");
         record.put("meetingDescription", dto.getMeetingDescription());
      } else {
         record.put("meetingDescription", dto.getMeetingDescription());
      }
      //
      map.put("meetingNo", dto.getMeetingNo());

      String latestMeetingBBSNo = bbs.selectLatestMeetingBBS(map);

      map.put("bbsNo", latestMeetingBBSNo); // 가장최근 모임게시판 3

      if (latestMeetingBBSNo != null) {
         List<Map> bbs_imgList = bbs_img.selectMeetingBBSImgList(map);
         dto.setMeetingBBSImgList(bbs_imgList);
         record.put("meetingBBSImgList", dto.getMeetingBBSImgList());

      }
      int meetingRoleList = meetingRole.selectMeetingRoleList(map);

      dto.setMeetingRoleList(meetingRoleList);
      record.put("meetingNo", dto.getMeetingNo());
      record.put("meetingName", dto.getMeetingName());
      record.put("bannerImg", dto.getBannerImg());
      record.put("categoryNo", dto.getCategoryNo());
      record.put("endDate", dto.getEndDate().toString());
      record.put("mainCategory", dto.getMainCategory());
      record.put("maxrole", dto.getMaxrole());
      record.put("meetingRoleList", dto.getMeetingRoleList());
      record.put("openDate", dto.getOpenDate().toString());
      record.put("subCategory", dto.getSubCategory());
      record.put("town", dto.getTown());
      record.put("operator", dto.getOperator());

      list.add(record);

      return JSONArray.toJSONString(list);
      
   }

   @RequestMapping(value = "/meetingLikeDelete.do", produces = "text/html; charset=UTF-8")
   @ResponseBody
   public String meetingLikeDelete(@RequestParam Map map, Authentication auth) {

      String id = ((UserDetails) auth.getPrincipal()).getUsername();
      map.put("id", id);
      like_meeting.deleteBookMark(map);
      return "";
   }
   
   @RequestMapping(value = "/meetingLike.do", produces = "text/html; charset=UTF-8")
   @ResponseBody
   public String meetingLike(@RequestParam Map map, Authentication auth) {
      System.out.println("adsafsd"+map.get("meetingNo"));
      String id = ((UserDetails) auth.getPrincipal()).getUsername();
      map.put("id", id);
      like_meeting.insertMeetingLike(map);
      return "";
   }
   
   @RequestMapping(value = "/infiniteScroll.do", produces = "text/html; charset=UTF-8")
   @ResponseBody
   public String infiniteScroll(@RequestParam Map map, Authentication auth) {
      map.put("id", ((UserDetails) auth.getPrincipal()).getUsername()); //프로필뷰를 보는사람의 아이디를 map에다 넣어서 미팅좋아요 유무판단
      int nowPage =Integer.parseInt(map.get("nowPage").toString());
      
      int start = 2*nowPage-1;
      int end = 2*nowPage;
      map.put("start", start);
      map.put("end", end);
      List<Map> meetingListInfinite =meeting.selectMeetingListInfiniteScroll(map);
      System.out.println(meetingListInfinite);
      
      List<Map> list = new Vector<Map>();
      
      for(Map dto : meetingListInfinite) {
         Map record = new HashMap();
      if (dto.get("MEETINGDESCRIPTION").toString().length() > 30) {
         dto.put("MEETINGDESCRIPTION", dto.get("MEETINGDESCRIPTION").toString().substring(0, 30) + ". . .");
         record.put("meetingDescription", dto.get("MEETINGDESCRIPTION"));
      } else {
         record.put("meetingDescription", dto.get("MEETINGDESCRIPTION"));
      }
      //
      map.put("meetingNo", dto.get("MEETINGNO"));

      int meetingRoleList = meetingRole.selectMeetingRoleList(map);

      
      String userLike = like_meeting.selectMeetingLike(map);
      record.put("meetingRoleList", meetingRoleList);
      record.put("userLike", userLike);
      record.put("meetingNo", dto.get("MEETINGNO"));
      record.put("meetingName", dto.get("MEETINGNAME"));
      record.put("bannerImg", dto.get("BANNERIMG"));
      record.put("categoryNo", dto.get("CATEGORYNO"));
      record.put("endDate", dto.get("ENDDATE").toString());
      record.put("mainCategory", dto.get("MAINCATEGORY"));
      record.put("maxrole", dto.get("MAXROLE"));
      record.put("openDate", dto.get("OPENDATE").toString());
      record.put("subCategory", dto.get("SUBCATEGORY"));
      record.put("town", dto.get("TOWN"));
      record.put("operator", dto.get("OPERATOR"));
      record.put("start",start);
      record.put("end", end);

      list.add(record);
      }

      return JSONArray.toJSONString(list);
      
      
   }
   

}