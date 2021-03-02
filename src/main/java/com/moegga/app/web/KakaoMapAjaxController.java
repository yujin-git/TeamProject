package com.moegga.app.web;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Vector;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.collections.map.HashedMap;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.google.gson.JsonObject;
import com.moegga.app.service.BBSService;
import com.moegga.app.service.BBS_ImgService;
import com.moegga.app.service.CategoryService;
import com.moegga.app.service.Like_MeetingService;
import com.moegga.app.service.MeetingDTO;
import com.moegga.app.service.MeetingRoleService;
import com.moegga.app.service.MeetingService;
import com.moegga.app.service.MemberService;
import com.moegga.app.service.PerformanceDTO;
import com.moegga.app.service.PerformanceService;
import com.moegga.app.service.TownService;
import com.moegga.app.service.impl.MemberDAO;

@RestController
public class KakaoMapAjaxController {

   @Resource(name = "meetingService")
   MeetingService meeting;
   @Resource(name = "bbsService")
   BBSService bbs;
   @Resource(name = "bbs_imgService")
   BBS_ImgService bbs_img;
   @Resource(name = "meetingRoleService")
   MeetingRoleService meetingRole;
   @Resource(name="performanceService")
   PerformanceService performance;
   @Resource(name = "categoryService")
   CategoryService category;
   @Resource(name = "like_meetingService")
   Like_MeetingService like_meeting;

   @PostMapping(value = "/kakaoMapAjax.do", produces = "text/html; charset=UTF-8")
   @ResponseBody
   public String kakaoMapAjax(@RequestParam Map map,Authentication auth) {
      // 1]서비스 호출
      String id = ((UserDetails) auth.getPrincipal()).getUsername();
      

      map.put("id", id);
      List<MeetingDTO> list = meeting.selectMeetingList(map);

      List<Map> collections = new Vector<Map>();
      for (MeetingDTO dto : list) {
         Map record = new HashMap();
         // 90자이상이면 ... 아니면 그냥 맵에 추가
         if (dto.getMeetingDescription().length() > 30) {
            dto.setMeetingDescription(dto.getMeetingDescription().substring(0, 30) + ". . .");
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
         
         String userLike = like_meeting.selectMeetingLike(map);

         dto.setUserLike(userLike);

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
         record.put("userLike",dto.getUserLike());

         collections.add(record);
      }

      return JSONArray.toJSONString(collections);

   }
   
   @PostMapping(value = "/kakaoMapPerformAjax.do", produces = "text/html; charset=UTF-8")
   @ResponseBody
   public String kakaoMapPerformAjax(@RequestParam Map map) {
      // 1]서비스 호출
      System.out.println("공연번호 :"+map.get("performanceNo"));
      PerformanceDTO dto = performance.selectOnePerformance(map);
      
      Map record = new HashMap();
      List<Map> list = new Vector<Map>();
      record.put("performDate", dto.getPerform_date().toString());
      record.put("meetingName", dto.getMeetingName());
      record.put("meetingNo", dto.getMeetingNo());
      record.put("operator", dto.getOperator());
      record.put("place", dto.getPlace());
      record.put("main_img", dto.getMain_img());
      record.put("perform_date", dto.getPerform_date().toString());
      record.put("perform_time", dto.getPerform_time());
      
      list.add(record);
      
      
      return JSONArray.toJSONString(list);

   }
   
   @PostMapping(value = "/kakaoMapCategoryAjax.do", produces = "text/html; charset=UTF-8")
   @ResponseBody
   public String kakaoMapCategoryAjax(@RequestParam Map map) {
      // 1]서비스 호출
      System.out.println(map.get("subCategory"));
   
      List<MeetingDTO> list =meeting.selectMeetingList(map);
      List<Map> collection = new Vector<Map>();
      if(!list.isEmpty()) {
      
      for(MeetingDTO dto : list) {
         Map record = new HashMap();
         record.put("meetingName", dto.getMeetingName());
         record.put("meetingNo", dto.getMeetingNo());
         record.put("mainCategory", dto.getMainCategory());
         record.put("subCategory", dto.getSubCategory());
         record.put("bannerImg", dto.getBannerImg());
         record.put("town", dto.getTown());
         record.put("operator", dto.getOperator());
         
         collection.add(record);
      }
      }else {
         Map record = new HashMap();
         record.put("no", "no");
         collection.add(record);
         
      }
      
      return JSONArray.toJSONString(collection);

   }

}///////////// class
