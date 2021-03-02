package com.moegga.app.web;

import java.io.File;
import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Vector;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.moegga.app.service.MeetingViewService;
import com.moegga.app.service.MemberDTO;
import com.moegga.app.service.MemberService;
import com.moegga.app.service.PerformanceDTO;
import com.moegga.app.service.PerformanceService;
import com.moegga.app.service.TownDTO;
import com.moegga.app.service.BBSService;
import com.moegga.app.service.CategoryDTO;
import com.moegga.app.service.CategoryService;
import com.moegga.app.service.ChattingService;
import com.moegga.app.service.DonationDTO;
import com.moegga.app.service.DonationService;
import com.moegga.app.service.FundingDTO;
import com.moegga.app.service.FundingService;
import com.moegga.app.service.MeetingDTO;
import com.moegga.app.service.MeetingRoleDTO;
import com.moegga.app.service.MeetingRoleService;
import com.moegga.app.service.MeetingService;

@Controller
public class MeetingViewController {
   
   
	@Resource(name = "meetingViewService")
	private MeetingViewService meetingViewService;
	@Resource(name = "fundingService")
	FundingService funding;
	@Resource(name = "donationService")
	DonationService donation;
	@Resource(name="memberService")
	MemberService member;
	
	@Resource(name = "performanceService")
	PerformanceService performance;
	@Resource(name = "meetingService")
	MeetingService meeting;
	@Resource(name = "categoryService")
	CategoryService category;
	@Resource(name="meetingRoleService")
	MeetingRoleService meetingRole;
	@Resource(name = "bbsService")
	BBSService bbs;
	
	@Resource(name = "chattingService")
	ChattingService chattingService;
	
   //==============================모임 상세 TOP=========================================
	@RequestMapping("/MeetingViewTop.do")
	public String meetingViewTop(@RequestParam Map map,Model model,Authentication auth) {
    	  
		if(map.get("operator")!= null) {
			System.out.println("쿼리스트링으로 얻은 모임장:"+map.get("operator"));			
		}else {
			System.out.println("쿼리스트링으로 얻은 모임 번호:"+map.get("meetingNo"));					
		}  
		return "meetingViewTop.meetingViewTiles";  
	}
	//=============================================================================================
	
	
	   //==============================모임 상세보기================================================
	   @RequestMapping("/MeetingViewMain.do")
	   public String member(@RequestParam Map map,Model model,Authentication auth) {
	      
		  String id = ((UserDetails) auth.getPrincipal()).getUsername();
		  map.put("id", id);
		  model.addAttribute("id", id);
		   
	      System.out.println("쿼리스트링으로 얻은 모임 번호"+map.get("meetingNo"));
	      MeetingDTO meetingDTO=meeting.selectMeetingByNo(map);
	      model.addAttribute("meetingDTO", meetingDTO);
	      map.put("operator", meetingDTO.getOperator());
	      
	      CategoryDTO categoryDTO=category.selectCategoryOfThisMeeting(map);
	      model.addAttribute("category", categoryDTO);
	      
	      map.put("meetingNo", meetingDTO.getMeetingNo());
	      
	      List<MeetingRoleDTO> thisMeetingRole=meetingRole.selectThisMeetingRole(map);
	      model.addAttribute("thisMeetingRole", thisMeetingRole);
	      
	      List<MeetingRoleDTO>  applicationRoleList = meetingRole.applicationRoleList(map);
	      
	      model.addAttribute("applicationRoleList", applicationRoleList);
	      
	      Map isApplication = meetingRole.isApplication(map);
	      model.addAttribute("isApplication", isApplication);
	      
	      FundingDTO dto =funding.selectFundingOne(map);
	      model.addAttribute("dto",dto);

	      int roleMember=meetingRole.selectMeetingRoleList(map);
	      model.addAttribute("roleMember", roleMember);

	      int meetingNo=meetingDTO.getMeetingNo();
	      model.addAttribute("meetingNo", meetingNo);
	      
	      List<Map> meetingViewMainAppeal = meetingViewService.meetingViewMainAppeal(map);
	      model.addAttribute("meetingViewMainAppeal",meetingViewMainAppeal);
	      
	      map.put("operator", id);
	      map.put("id", id);
	      List<MeetingDTO> Mdto=meeting.selectMeetingById(map);
	      model.addAttribute("Mdto", Mdto);
	      int joinMcount=meetingRole.selectJoinMeetingList(map);
	      model.addAttribute("joinMcount", joinMcount);
	      for(MeetingRoleDTO tmrdto:thisMeetingRole) {
	         if(tmrdto.getId()!=null) {
	            if(tmrdto.getId().equals(id)) {
	               model.addAttribute("myMeetingNo", tmrdto.getMeetingNo());
	               break;
	            }
	         }else {
	            model.addAttribute("myMeetingNo", 0);
	         }
	      }
	      List<MeetingRoleDTO> myMeeting=meetingRole.selectMyMeetingRole(map);
	      model.addAttribute("myMeeting", myMeeting);

	      List<PerformanceDTO> performanceListOfThisMeeting=performance.selectPerformanceListOfThisMeeting(map);
	      if(performanceListOfThisMeeting.isEmpty()) {
	         model.addAttribute("endPerform", true);
	      }else {
	         for(PerformanceDTO perform:performanceListOfThisMeeting) {
	            SimpleDateFormat SimpleDateFormat = new SimpleDateFormat("yyyy-MM-dd");
	            Date curTime = new Date ();
	            String Time = SimpleDateFormat.format (curTime);
	            long caldate = perform.getPerform_date().getTime()-curTime.getTime();  
	             int caldatedays = (int)(caldate / ( 24*60*60*1000)); 
	             System.out.println(caldatedays);
	             //calDateDays = Math.abs(calDateDays);
	             System.out.println(caldatedays+"일");
	             if(caldatedays>0) {
	                model.addAttribute("endPerform", false);
	                break;
	             }else {
	                model.addAttribute("endPerform", true);
	             }
	         }
	      }
	      return "meetingViewMain.meetingViewTiles";  
	   }
	   //=============================================================================

	
	   @RequestMapping("/MeetingViewBBS.do")
	   public String MeetingViewBBS(@RequestParam Map map,Model model,Authentication auth) {
	      
	      System.out.println("쿼리스트링으로 얻은 모임 번호"+map.get("meetingNo"));
	      MeetingDTO meetingDTO=meeting.selectMeetingByNo(map);
	      model.addAttribute("meetingDTO", meetingDTO);
	      map.put("operator", meetingDTO.getOperator());
	      CategoryDTO categoryDTO=category.selectCategoryOfThisMeeting(map);
	      model.addAttribute("category", categoryDTO);
	      
	      map.put("meetingNo", meetingDTO.getMeetingNo());
	      List<MeetingRoleDTO> thisMeetingRole=meetingRole.selectThisMeetingRole(map);
	      model.addAttribute("thisMeetingRole", thisMeetingRole);
	      
	      
	      
	      String id = ((UserDetails) auth.getPrincipal()).getUsername();
	      model.addAttribute("id", id);
	      map.put("id", id);
	      
	      
	       
	      //게시판
	      map.put("meetingno", meetingDTO.getMeetingNo());
	      List<Map> meetingViewBBS = bbs.meetingViewBBS(map);
	      int meetingno = bbs.selectMeetingnoById(map);
	      
	       List<Map> mBBSImg = new Vector<Map>();
	      
	      for(Map bbsMap:meetingViewBBS) {
	         String bbsno=bbsMap.get("BBSNO").toString();
	         
	         map.put("bbsno", bbsno);
	         String userLike =bbs.likeSelect(map);
	            
	         String imgcount =bbs.mBBSListImgCount(bbsno);
	         
	         
	         mBBSImg = bbs.mBBSImg(bbsno);
	         
	         bbsMap.put("userLike", userLike);
	         bbsMap.put("imgcount", imgcount);
	         bbsMap.put("mBBSImg", mBBSImg);
	         
	         bbsMap.put("mBBSImg", mBBSImg);
	            
	      }
	         
	      MemberDTO dto = member.selectOneById(map);
	      model.addAttribute("id",id);
	      model.addAttribute("dto", dto);
	      model.addAttribute("meetingViewBBS", meetingViewBBS);
	      model.addAttribute("meetingno", meetingno);
	       System.out.println("내 모임번호 : " + meetingno);
	        
	      
	      
	      return "/bbs/meetingViewBBS.meetingViewTiles";
	   }

	@RequestMapping("/MeetingViewCal.do")
	public String MeetingViewCal() {
		return "/calendar/meetingViewCal.meetingViewTiles";
	}

	
	//=================공연 상세보기==========================================================
   @RequestMapping("/MeetingViewCon.do")
   public String MeetingViewCon(@RequestParam Map map,Model model,Authentication auth) {

      System.out.println("쿼리스트링으로 얻은 모임 번호"+map.get("meetingNo"));      
      CategoryDTO categoryDTO=category.selectCategoryOfThisMeeting(map);
      model.addAttribute("category", categoryDTO);
      
      map.put("meetingNo", categoryDTO.getMeetingNo());
      List<MeetingRoleDTO> thisMeetingRole=meetingRole.selectThisMeetingRole(map);
      model.addAttribute("thisMeetingRole", thisMeetingRole);
      
      FundingDTO dto =funding.selectFundingOne(map);
      model.addAttribute("dto",dto);
      
      List<PerformanceDTO> performanceListOfThisMeeting=performance.selectPerformanceListOfThisMeeting(map);
      List<PerformanceDTO> performanceList = new Vector<PerformanceDTO>();
      List<PerformanceDTO> oldPerformanceList = new Vector<PerformanceDTO>();
      if(performanceListOfThisMeeting.isEmpty()) {
         
      }else {
         for(PerformanceDTO perform:performanceListOfThisMeeting) {
            
            SimpleDateFormat SimpleDateFormat = new SimpleDateFormat("yyyy-MM-dd");
            Date curTime = new Date ();
            String Time = SimpleDateFormat.format (curTime);
            long caldate = perform.getPerform_date().getTime()-curTime.getTime();  
            System.out.println(caldate);
             int caldatedays = (int)(caldate / ( 24*60*60*1000)); 
             System.out.println(caldatedays+"일");
             if(caldatedays>=0) {
                performanceList.add(perform);
                model.addAttribute("realAdd",perform.getPlace().substring(0, perform.getPlace().indexOf(",")).trim());
             }else {
                oldPerformanceList.add(perform);
             }
         }
      }
      CategoryDTO categoryOfThisMeeting=category.selectCategoryOfThisMeeting(map);
      model.addAttribute("meetingDTO",categoryOfThisMeeting);
      model.addAttribute("performanceList",performanceList);
      model.addAttribute("oldPerformanceList",oldPerformanceList);
      
      
      String id = ((UserDetails) auth.getPrincipal()).getUsername();
      model.addAttribute("id", id);
      
      return "/concert/meetingViewCon.meetingViewTiles";
   }

	
	@RequestMapping("/funding/MeetingViewFun.do")
	public String MeetingViewFun(@RequestParam Map map,Model model,Authentication auth) {
		
		String id = ((UserDetails) auth.getPrincipal()).getUsername();
		model.addAttribute("id", id);
		System.out.println("쿼리스트링으로 얻은 모임 번호"+map.get("meetingNo"));
		MeetingDTO meetingDTO=meeting.selectMeetingByNo(map);
		map.put("operator", meetingDTO.getOperator());
		CategoryDTO categoryDTO=category.selectCategoryOfThisMeeting(map);
		model.addAttribute("category", categoryDTO);
		model.addAttribute("meetingDTO", meetingDTO);
		map.put("meetingNo", meetingDTO.getMeetingNo());
		List<MeetingRoleDTO> thisMeetingRole=meetingRole.selectThisMeetingRole(map);
		model.addAttribute("thisMeetingRole", thisMeetingRole);
		
		FundingDTO dto =funding.selectFundingOne(map);
		if(dto==null) {
			model.addAttribute("dto",null);
		}else {
			SimpleDateFormat mSimpleDateFormat = new SimpleDateFormat("yyyy-MM-dd");
			Date currentTime = new Date ();
			String mTime = mSimpleDateFormat.format (currentTime);
			try {
				currentTime=mSimpleDateFormat.parse(mTime);
			} catch (ParseException e) {
				e.printStackTrace();
			}
			//펀딩 끝나는날과 현재날 빼서 일수 계산 로직
			long calDate = currentTime.getTime() - dto.getFundingEnddate().getTime();  
		    int calDateDays = (int)(calDate / ( 24*60*60*1000)); 
		    calDateDays = Math.abs(calDateDays);
		    dto.setCalDateDays(calDateDays);
		    List<DonationDTO> donationList =donation.selectDonationList(map);
		    dto.setDonationList(donationList.size());
		    dto.setMeetingDescription(dto.getMeetingDescription().replace("\n","<br/>"));
			model.addAttribute("dto",dto);
		}
		List<PerformanceDTO> performanceListOfThisMeeting=performance.selectPerformanceListOfThisMeeting(map);
		if(performanceListOfThisMeeting.isEmpty()) {
			model.addAttribute("endPerform", true);
		}else {
			for(PerformanceDTO perform:performanceListOfThisMeeting) {
				SimpleDateFormat SimpleDateFormat = new SimpleDateFormat("yyyy-MM-dd");
				Date curTime = new Date ();
				String Time = SimpleDateFormat.format (curTime);
				long caldate = perform.getPerform_date().getTime()-curTime.getTime();  
			    int caldatedays = (int)(caldate / ( 24*60*60*1000)); 
			    System.out.println(caldatedays);
			    //calDateDays = Math.abs(calDateDays);
			    System.out.println(caldatedays+"일");
			    if(caldatedays>0) {
			    	model.addAttribute("endPerform", false);
			    	break;
			    }else {
			    	model.addAttribute("endPerform", true);
			    }
			}
		}
		
		return "/funding/meetingViewFun.meetingViewTiles";
	}
	
	
	//모임 수정=================================================================================
	@RequestMapping(value="/UpdateMeeting.do")
	public String createNewMeeting(@RequestParam Map map,HttpServletRequest req,Authentication auth,Model model) {
		
		String id = ((UserDetails) auth.getPrincipal()).getUsername();
		map.put("operator", id);
		//System.out.println("쿼리스트링으로 얻은 모임 번호"+map.get("meetingNo"));
		MeetingDTO thisMeeting=meeting.selectMeetingByOperator(map);
		System.out.println("모임 정보 맞게 잘 뽑아오나 보자");
		model.addAttribute("thisMeeting", thisMeeting);
		
		List<Map> mainCategory =category.selectMainCategory(); //select distinct * maincategory from category ->음악,예술,공연,스포츠
		System.out.println(mainCategory.size());
		for(Map maincate : mainCategory) {
			System.out.println("메인카테고리 :"+maincate.get("MAINCATEGORY"));
			}
		model.addAttribute("mainCategory",mainCategory);
		
		CategoryDTO categoryDTO=category.selectCategoryByMeetingNo(map);
		String mainCate=categoryDTO.getMaincategory();
		String subCate=categoryDTO.getSubcategory();
		model.addAttribute("mainCate",mainCate);
		model.addAttribute("subCate",subCate);
		
		System.out.println("쿼리스트링으로 얻은 모임 번호"+map.get("meetingNo"));
		List<MeetingRoleDTO> memberRole=meetingRole.selectThisMeetingRole(map);

		model.addAttribute("memberRole",memberRole);
		return "/meeting/updateMeeting.tiles";
	}
	
	
	@RequestMapping(value = "/UpdateMeetingProcess.do")
	public String uUpdatePerformanceProcess(@RequestParam("cma_file") MultipartFile upload,@RequestParam Map map,HttpServletRequest req,Authentication auth) {
		System.out.println("수정 시작합니다.");
		
		System.out.println("모임 수정 파라미터 : " + map);
		
		String id = ((UserDetails) auth.getPrincipal()).getUsername();
		map.put("operator", id); //#{operator}
		MeetingDTO meetingDTO = meeting.selectMeetingByOperator(map);
		System.out.println(map.get("operator"));
		
		System.out.println(map.get("subCategory"));
		int categoryNo=category.selectCategoryNo(map);
		map.put("categoryNo", categoryNo);
			
		map.put("content", map.get("content").toString());
			
		int maxrole=1;
		for(String memberRole : req.getParameterValues("memberRole")) {
			maxrole++;
		}
		map.put("maxRole", maxrole);

		String path = req.getSession().getServletContext().getRealPath("/images"+File.separator+"meeting"+File.separator+meetingDTO.getMeetingName());
		File pathFile = new File(path);
        if(!pathFile.exists()) {
           pathFile.mkdirs();
        }

		File file = new File(path + File.separator + upload.getOriginalFilename());
		
		if(upload.getOriginalFilename().equals("")) {
			System.out.println("배너이미지 널");
			map.put("bannerImg", null);
			meeting.updateMeetingByOperator(map);
			System.out.println("디비에 모임 데이터 수정 완료,이미지는 미변경");
		}else {
			System.out.println("배너이미지 널 아님");
			map.put("bannerImg", upload.getOriginalFilename());
			meeting.updateMeetingByOperator(map);
			System.out.println("디비에 모임 데이터 수정 완료");
			try {
				upload.transferTo(file);
			} catch (IllegalStateException | IOException e) {
				e.printStackTrace();
			}
		}
		
		System.out.println("모임장 id : "+map.get("operator"));
		System.out.println("모임 수정할 때 얻은 모임장 역할:"+map.get("operatorRole"));
		meetingRole.updateOperatorRole(map);
		
		map.put("meetingNo", meetingDTO.getMeetingNo());
		List<MeetingRoleDTO> mRole=meetingRole.selectThisMeetingRole(map);
		int i=0;
		for(MeetingRoleDTO dto:mRole) {
			System.out.println("역할 번호  : "+dto.getRoleNo());
			if(dto.getId()==null) {
				map.put("roleNo", dto.getRoleNo());
				String[] memberRole=req.getParameterValues("memberRole");
				System.out.println(i+"번째 배열의 역할:"+memberRole[i]);
				map.put("memberRole", memberRole[i]);//meetingRole이라는 name값 , 처음에 베이스 라는 value;
				System.out.println("map에 저장한 "+i+"번째 역할 : "+req.getParameterValues("memberRole")[i]);
				meetingRole.updateMemberRole(map); //#{meetingRole} ->베이스
				i++;
			}
		}
		System.out.println("수정 다 끝났어?");
			
		return "redirect:/MeetingViewMain.do?meetingNo="+meetingDTO.getMeetingNo();
	}
	//======================================================================
	
		
	//모임 삭제=========================================================	
	@RequestMapping("/DeleteMeeting.do")
	public String noticeDeleteProcess(@RequestParam Map map) {
		System.out.println("쿼리스트링으로 얻은 공연 번호:"+map.get("meetingNo"));
		meeting.deleteMeeting(map);
		return "redirect:/town/AllOfMeeting.do";
	}
	//================================================================
	
	
	//모임 가입신청하기===================================================
	@RequestMapping("/JoinMeetingSubscription.do")
	public String joinMeetingSubscription(@RequestParam Map map,HttpServletRequest req,Model model) {
		
		MemberDTO dto=member.selectOneById(map);
		String name=dto.getName();
		String JoinMeetingSubscriptionId=(String) map.get("id");
		System.out.println("쿼리스트링으로 가져 모임 신청 id:"+JoinMeetingSubscriptionId);
		String meetingNo=(String) map.get("meetingNo");
		System.out.println("쿼리스트링으로 가져온 모임 번호:"+map.get("meetingNo"));
		String SubscriptionroleNo=req.getParameter("selectRole");
		System.out.println("역할 번호:"+SubscriptionroleNo);
		map.put("id", JoinMeetingSubscriptionId);
		map.put("name", name);
		map.put("meetingNo", meetingNo);
		map.put("roleNo", SubscriptionroleNo);
		meetingRole.joinMeetingDescription(map);
		
		return "redirect:/MeetingViewMain.do?meetingNo="+ meetingNo;
		
	}
	//===================================================================
	
	
	//====모임 가입 신청 승인=================================================
	@RequestMapping("/JoinMeetingOk.do")
	public String joinMeetingOk(@RequestParam Map map) {
		
		meetingRole.deleteApplicationRole(map);
		meetingRole.joinMeetingOk(map);
		
		/* 그룹 채팅방 참가 구현 */
		String meetingno = map.get("meetingNo").toString();
		int chatno = chattingService.getChatno(meetingno);
		map.put("chatno", chatno);
		chattingService.chatMemberInsert(map);
		
		return "redirect:/MeetingViewMain.do?meetingNo="+ map.get("meetingNo");
	}
	//===================================================================
	
	
	//====모임 가입 신청 거절=================================================
	@RequestMapping("/JoinMeetingReject.do")
	public String joinMeetingReject(@RequestParam Map map) {
		
		meetingRole.deleteApplicationRole(map);
		
		meetingRole.joinMeetingReject(map);
		
		return "redirect:/MeetingViewMain.do?meetingNo="+ map.get("meetingNo");
	}
	//===================================================================
	
	
	//====모임 탈퇴=================================================
	@RequestMapping("/DeleteMyMeeting.do")
	public String deleteMyMeeting(@RequestParam Map map) {
		
		meetingRole.deleteMyMeeting(map);
		
		return "redirect:/MeetingViewMain.do?meetingNo="+ map.get("meetingNo");
	}
	//===================================================================
	
}
