package com.moegga.app.web;

import java.io.File;
import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.Vector;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.moegga.app.service.AndroidService;
import com.moegga.app.service.CategoryDTO;
import com.moegga.app.service.MeetingDTO;
import com.moegga.app.service.MeetingDateDTO;
import com.moegga.app.service.MemberDTO;

@Controller
public class AndroidController {
	
	@Resource(name = "androidService")
	AndroidService service;
	
	/* 로그인 */
	@RequestMapping(value="/Android/Loginprocess.do", produces = "text/html; charset=UTF-8")
	@ResponseBody
	public String login(@RequestParam Map map) {
		Map result = service.login(map);
		JSONObject json = new JSONObject();
		if(result != null) {
			Set keys = result.keySet();
			for(Object key : keys) {
				json.put(key.toString(), result.get(key).toString());
			}
			return json.toJSONString();
		}
		else {
			return "";
		}
	}
	
	/* 홈 추천시스템 이용한 데이터 반환 */
	@RequestMapping(value="/Android/Main.do",produces = "text/html; charset=UTF-8")
	@ResponseBody
	public String main(@RequestParam Map map) {
		List meetingnos = new Vector();
		Set keys = map.keySet();
		for(Object key : keys) {
			meetingnos.add(map.get(key).toString());
		}
		map.put("meetingnos", meetingnos);
		List<MeetingDTO> list = service.getRecommends(map);
		JSONObject json = new JSONObject();
		JSONArray jsonarray = new JSONArray();
		for(MeetingDTO dto : list) {
			JSONObject dtoJson = new JSONObject();
			dtoJson.put("meetingNo", dto.getMeetingNo());
			dtoJson.put("meetingName", dto.getMeetingName());
			dtoJson.put("operator", dto.getOperator());
			dtoJson.put("openDate", dto.getOpenDate());
			dtoJson.put("endDate", dto.getEndDate());
			dtoJson.put("town", dto.getTown());
			dtoJson.put("meetingDescription", dto.getMeetingDescription());
			dtoJson.put("categoryNo", dto.getCategoryNo());
			dtoJson.put("warningCount", dto.getWarningCount());
			dtoJson.put("enabled", dto.getEnabled());
			dtoJson.put("bannerImg", dto.getBannerImg());
			dtoJson.put("currentrole", service.getCurrentRoleCount(dto.getMeetingNo()));
			dtoJson.put("maxrole", dto.getMaxrole());
			dtoJson.put("mainCategory", dto.getMainCategory());
			dtoJson.put("subCategory", dto.getSubCategory());
			
			jsonarray.add(dtoJson);
		}
		json.put("meetingList", jsonarray);
		return json.toJSONString();
	}
	@RequestMapping(value="/Android/JoinedMeetings.do",produces = "text/html; charset=UTF-8")
	@ResponseBody
	public String getjoinmeeting(@RequestParam String id) {
		List<MeetingDTO> list = service.getJoinedMeeting(id);
		JSONObject json = new JSONObject();
		JSONArray jsonarray = new JSONArray();
		for(MeetingDTO dto : list) {
			JSONObject dtoJson = new JSONObject();
			dtoJson.put("meetingNo", dto.getMeetingNo());
			dtoJson.put("meetingName", dto.getMeetingName());
			dtoJson.put("operator", dto.getOperator());
			dtoJson.put("openDate", dto.getOpenDate());
			dtoJson.put("endDate", dto.getEndDate());
			dtoJson.put("town", dto.getTown());
			dtoJson.put("meetingDescription", dto.getMeetingDescription());
			dtoJson.put("categoryNo", dto.getCategoryNo());
			dtoJson.put("warningCount", dto.getWarningCount());
			dtoJson.put("enabled", dto.getEnabled());
			dtoJson.put("bannerImg", dto.getBannerImg());
			dtoJson.put("currentrole", service.getCurrentRoleCount(dto.getMeetingNo()));
			dtoJson.put("maxrole", dto.getMaxrole());
			dtoJson.put("mainCategory", dto.getMainCategory());
			dtoJson.put("subCategory", dto.getSubCategory());
			
			jsonarray.add(dtoJson);
		}
		json.put("meetingList", jsonarray);
		return json.toJSONString();
	}
	
	/* 동네 둘러보기 - 모임 */
	@RequestMapping(value="/Android/Town/Meeting.do", produces = "text/html; charset=UTF-8")
	@ResponseBody
	public String meeting(@RequestParam String id) {
		
		String town = service.getTown(id);
		List<MeetingDTO> list = service.getMeeting(town);
		
		JSONObject json = new JSONObject();
		JSONArray jsonarray = new JSONArray();
		json.put("town", town);
		for(MeetingDTO dto : list) {
			JSONObject dtoJson = new JSONObject();
			dtoJson.put("meetingNo", dto.getMeetingNo());
			dtoJson.put("meetingName", dto.getMeetingName());
			dtoJson.put("operator", dto.getOperator());
			dtoJson.put("openDate", dto.getOpenDate());
			dtoJson.put("endDate", dto.getEndDate());
			dtoJson.put("town", dto.getTown());
			dtoJson.put("meetingDescription", dto.getMeetingDescription());
			dtoJson.put("categoryNo", dto.getCategoryNo());
			dtoJson.put("warningCount", dto.getWarningCount());
			dtoJson.put("enabled", dto.getEnabled());
			dtoJson.put("bannerImg", dto.getBannerImg());
			dtoJson.put("currentrole", service.getCurrentRoleCount(dto.getMeetingNo()));
			dtoJson.put("maxrole", dto.getMaxrole());
			dtoJson.put("mainCategory", dto.getMainCategory());
			dtoJson.put("subCategory", dto.getSubCategory());
			
			jsonarray.add(dtoJson);
		}
		json.put("meetingList", jsonarray);
		return json.toJSONString();
	}
	/* 동네 둘러보기 - 회원 */
	@RequestMapping(value="/Android/Town/Member.do", produces = "text/html; charset=UTF-8")
	@ResponseBody
	public String member(@RequestParam String id) {
		String town = service.getTown(id);
		List<MemberDTO> list = service.getMember(town);
		JSONObject json = new JSONObject();
		JSONArray jsonarray = new JSONArray();
		json.put("town", town);
		for(MemberDTO dto : list) {
			JSONObject dtoJson = new JSONObject();
			dtoJson.put("id", dto.getId());
			dtoJson.put("name", dto.getName());
			dtoJson.put("profileimg", dto.getProfileimg());
			dtoJson.put("pr", dto.getPr());
			List<Map> interests =  service.getInterests(dto.getId());
			JSONArray interarray = new JSONArray();
			for(Map value: interests) {
				JSONObject interobj = new JSONObject();
				interobj.put("maincategory", value.get("MAINCATEGORY"));
				interobj.put("subcategory", value.get("SUBCATEGORY"));
				interarray.add(interobj);
			}
			
			dtoJson.put("interArray", interarray);
			jsonarray.add(dtoJson);
		}
		json.put("memberList", jsonarray);
		return json.toJSONString();
		
	}
	
	/* 회원 상세보기 */
	@RequestMapping(value="/Android/Town/MemberInfo.do", produces = "text/html; charset=UTF-8")
	@ResponseBody
	public String memberInfo(@RequestParam String id){
		Map list = service.getMemberInfo(id);
		
		JSONObject obj = new JSONObject();
		Set keys = list.keySet();
		for(Object key : keys) {
			obj.put(key.toString().toLowerCase(), list.get(key).toString());
		}
		JSONArray array = new JSONArray();
		List appealimg = service.getAppealImg(id);
		for(int i=0; i<appealimg.size(); i++) {
			JSONObject json = new JSONObject();
			json.put("img", appealimg.get(i));
			array.add(json);
		}
		obj.put("appealimgs",array);
		return obj.toJSONString();
	}
	
	/* 게시판 */
	@RequestMapping(value="/Android/MeetingBBS.do", produces = "text/html; charset=UTF-8")
	@ResponseBody
	public String bbs(@RequestParam Map map) {
		List<Map> list = service.getBBS(map);
		JSONObject json = new JSONObject();
		JSONArray jsonarray = new JSONArray();
		for(Map value : list) {
			JSONObject dtoJson = new JSONObject();
			List<String> imglist = service.getBBSImg(value);
			StringBuffer imgs = new StringBuffer();
			for(String img : imglist) {
				
				imgs.append(img+":");
			}
			value.put("imgs", imgs.toString().substring(0,imgs.length()-1));
			Set keys = value.keySet();
			for(Object key : keys) {
				dtoJson.put(key.toString().toLowerCase(), value.get(key).toString());
				
			}
			jsonarray.add(dtoJson);
		}
		json.put("bbslist", jsonarray);
		return json.toJSONString();
	}
	/* 게시판 글 작성 */
	@RequestMapping(value="/Android/MeetingBBS/Write.do", produces = "text/html; charset=UTF-8")
	@ResponseBody
	public String write(@RequestParam Map map) {
		String bbsno = service.insertBBS(map);
		return bbsno;
	}
	@RequestMapping(value="/Android/MeetingBBS/Write/Img.do", produces = "text/html; charset=UTF-8")
	@ResponseBody
	public String insertImg(@RequestParam("files") MultipartFile files, @RequestParam String bbsno, HttpServletRequest req) {
		Map map = service.getMeetingNoAndOperator(bbsno);
		map.put("filename", files.getOriginalFilename());
		map.put("bbsno", bbsno);
		service.insertBBSImg(map);
		
		String path = req.getSession().getServletContext().getRealPath("/images"+File.separator +"meeting"+File.separator+ map.get("MEETINGNAME")+File.separator+"bbs");
		File pathFile = new File(path);
		if(!pathFile.exists()) {
			pathFile.mkdirs();
		}

		File file = new File(path+ File.separator+files.getOriginalFilename());
		try {
			files.transferTo(file);
		} catch (IllegalStateException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return "success";
		
	}
	
	/* 공연 */
	@RequestMapping(value="/Android/Perform.do", produces = "text/html; charset=UTF-8")
	@ResponseBody
	public String perform(@RequestParam String town) {
		List<Map> list= service.getPerform(town);
		JSONObject json = new JSONObject();
		JSONArray jsonarray = new JSONArray();
		for(Map map : list) {
			JSONObject dtoJson = new JSONObject();
			Set keys = map.keySet();
			for(Object key : keys) {
				dtoJson.put(key.toString().toLowerCase(), map.get(key).toString());
			}
			jsonarray.add(dtoJson);
		}
		json.put("performlist", jsonarray);
		return json.toJSONString();
	}
	/* 펀딩 */
	@RequestMapping(value="/Android/Funding.do", produces="text/html; charset=UTF-8")
	@ResponseBody
	public String funding() {
		List<Map> list = service.getFunding();
		for(Map map : list) {
	
			Date currentTime = new Date();
			long calDate = currentTime.getTime() - ((Date)map.get("FUNDINGENDDATE")).getTime();  
		    int calDateDays = (int)(calDate / ( 24*60*60*1000)); 
		    calDateDays = Math.abs(calDateDays);
		    String supporter = service.getSupporter(map.get("MEETINGNO").toString());
		    map.put("calDateDays", String.valueOf(calDateDays));
		    map.put("OPENDATE", map.get("OPENDATE").toString().substring(0,10));
			map.put("FUNDINGENDDATE", map.get("FUNDINGENDDATE").toString().substring(0,10));
			map.put("ENDDATE", map.get("ENDDATE").toString().substring(0,10));
			map.put("supporter", supporter);
			
		}
		
		return JSONArray.toJSONString(list);
	}
	
	@RequestMapping(value="/Android/Funding/Support.do", produces="text/html; charset=UTF-8")
	public String support() {
		return "funding/androidFunding";
	}
	
	 	
	@Value("${PAGE_SIZE}")
   private int pageSize;
   @Value("${BLOCK_PAGE}")
   private int blockPage;

	   
	      
	   ///아이디 중복체크
	      @RequestMapping(value="/Android/Idchecked.do", produces = "text/html; charset=UTF-8")
	      @ResponseBody
	      public String idchecked(@RequestParam Map map) {
	      
	         int result = service.idchecked(map);
	         if(result ==1) {
	          
	            return  Integer.toString(result);
	         }
	         else {
	            return "";
	         }
	      }///아이디 중복체크
	      
	      
	      
	      /*회원가입용*/
	      @RequestMapping(value="/Android/Join.do", produces = "text/html; charset=UTF-8")
	      @ResponseBody
	      public String join(@RequestParam Map map) {
	         int member = service.insertandroidMember(map);
	         int town = service.insertandroidTown(map);
	         
	         String result ="";
	         
	         if(member ==1 && town ==1) {
	          
	            result=map.get("id").toString();
	            return  result;
	         }
	         else {
	            return "";
	         }
	      }
	      
	      
	      
	      /*프로필 내용추가용*/
	         @RequestMapping(value="Android/ProfileAdd.do", produces = "text/html; charset=UTF-8")
	         @ResponseBody
	         public String inserttext(@RequestParam Map map, HttpServletRequest req) {

	           map.put("pr",map.get("pr").toString().replace("\n","<br/>"));
	            map.put("about_me",map.get("about_me").toString().replace("\n","<br/>"));
	       
	       
	            System.out.println(map.get("pr").toString().replace("\n","<br/>"));
	            System.out.println( map.get("about_me").toString().replace("\n","<br/>")); 
	        
	            String id = map.get("id").toString();
	            
	            service.updateInfoandroid(map);
	            
	            return "success";
	            
	         }

	         
	         
	         /*프로필 이미지추가용*/
	         @RequestMapping(value="Android/ProfileImageAdd.do", produces = "text/html; charset=UTF-8")
	         @ResponseBody
	         public String insertImg(@RequestParam("files") MultipartFile files,@RequestParam Map map, HttpServletRequest req) {

	        
	            map.put("img", files.getOriginalFilename());
	       
	            System.out.println( files.getOriginalFilename());
	            String id = map.get("id").toString();
	            System.out.println("id");
	            service.updateInfoandroid(map);
	            String path = req.getSession().getServletContext().getRealPath("/images"+File.separator +"member"+File.separator +id);

	       
	    
	            File pathFile = new File(path);
	            if(!pathFile.exists()) {
	               pathFile.mkdirs();
	            }

	            File file = new File(path+ File.separator+files.getOriginalFilename());
	            try {
	               files.transferTo(file);
	            } catch (IllegalStateException e) {
	               // TODO Auto-generated catch block
	               e.printStackTrace();
	            } catch (IOException e) {
	               // TODO Auto-generated catch block
	               e.printStackTrace();
	            }
	            
	            return "success";
	            
	         }
	      
	         @RequestMapping(value="/Android/Profile.do", produces = "text/html; charset=UTF-8")
	         @ResponseBody
	         public String androidprofile(@RequestParam String id) {
	           System.out.println("프로필 들어왔어요");
	          System.out.println("id:"+id);
	            List<Map> list = service.getAndroidprofile(id);
	            JSONObject json = new JSONObject();
	            JSONArray jsonarray = new JSONArray();
	          
	            for(Map m : list) {
	               JSONObject dtoJson = new JSONObject();
	              
	               System.out.println("town"+ m.get("TOWN"));
	               System.out.println("name"+ m.get("NAME"));
	               dtoJson.put("id", m.get("ID"));
	               dtoJson.put("name", m.get("NAME"));
	               dtoJson.put("tel", m.get("TEL"));
	               dtoJson.put("age", m.get("AGE"));
	               dtoJson.put("profileimg", m.get("PROFILEIMG"));
	               dtoJson.put("gender", m.get("GENDER"));
	               dtoJson.put("town", m.get("TOWN"));
	          
	               dtoJson.put("pr", m.get("PR"));
	               
	               dtoJson.put("about_me", m.get("ABOUT_ME"));
	               
	               
	               jsonarray.add(dtoJson);
	            }
	            json.put("profileList", jsonarray);
	            return json.toJSONString();
	         }
	         
	         
	         /* 동네 둘러보기 - 모임 */
	         @RequestMapping(value="/Android/Maincategorylist.do", produces = "text/html; charset=UTF-8")
	         @ResponseBody
	         public String maincategorylist(@RequestParam Map map) {
	           System.out.println(" 들어왔어요");
	         
	            List<CategoryDTO> list = service.maincategorylist(map);
	            JSONObject json = new JSONObject();
	            JSONArray jsonarray = new JSONArray();
	          
	            for(CategoryDTO cdto : list) {
	               JSONObject dtoJson = new JSONObject();
	                       
	               dtoJson.put("maincategory",cdto.getMaincategory());
	            
	               
	               
	               jsonarray.add(dtoJson);
	            }
	            json.put("maincategoryList", jsonarray);
	            return json.toJSONString();
	         }
	         
	         
	        
	         @RequestMapping(value="/Android/subcategorylist.do", produces = "text/html; charset=UTF-8")
	         @ResponseBody
	         public String subcategorylist(@RequestParam Map map) {
	           System.out.println(" 들어왔어요");
	           System.out.println(map.get("maincategory"));
	         
	            List<CategoryDTO> list = service.subcategorylist(map);
	          
	            JSONObject json = new JSONObject();
	            JSONArray jsonarray = new JSONArray();
	          
	            for(CategoryDTO cdto : list) {
	               JSONObject dtoJson = new JSONObject();
	                       
	               dtoJson.put("subcategory",cdto.getSubcategory());
	            
	               
	               
	               jsonarray.add(dtoJson);
	            }
	            json.put("subcategoryList", jsonarray);
	            return json.toJSONString();
	         }
	         
	      
	         @RequestMapping(value="/Android/Attendcheck.do", produces = "text/html; charset=UTF-8")
	         @ResponseBody
	         public String attendcheck(@RequestParam Map map) {
	          
	         System.out.println("들어옴");
	            List<MeetingDateDTO> list = service.meetingdayselect(map);
	          
	            Date curDate = new Date();
	            
	           
	            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm");
	            long curDateTime =0;
	           
	            try {
	            curDate = dateFormat.parse(dateFormat.format(curDate));
	             curDateTime = curDate.getTime();
	              System.out.println(" curDateTime"+ curDateTime);
	         } catch (ParseException e) {
	            
	            e.printStackTrace();
	         }
	           
	            
	            JSONObject json = new JSONObject();
	            JSONArray jsonarray = new JSONArray();
	          
	            
	            
	            for(MeetingDateDTO mdto : list) {
	               JSONObject dtoJson = new JSONObject();
	                      
	               long reqDateTime=0;
	           
	               
	               Date reqDate = mdto.getMeetingday();
	             
	             
	               try {
	            reqDate = dateFormat.parse(dateFormat.format(reqDate));
	         
	               reqDateTime = reqDate.getTime();
	         
	               System.out.println("reqDateTime"+reqDateTime);
	         } catch (ParseException e) {
	      
	            e.printStackTrace();
	         }
	               
	               
	             
	               long minute = ( curDateTime -reqDateTime) / 60000;
	               
	               System.out.println(minute);
	               if(!(minute<= 60 && minute >= 0)) {
	                  continue;
	               }
	               dtoJson.put("meetingdayno",mdto.getMeetingdayno());
	               jsonarray.add(dtoJson);
	               
	            }
	            json.put("meetingdateList", jsonarray);
	            return json.toJSONString();
	         }
	         
	         
	         @RequestMapping(value="Android/InsertInterest.do", produces = "text/html; charset=UTF-8")
	         @ResponseBody
	         public String insertInterests(@RequestParam Map map) {
	          
	            
	            System.out.println("maincategory"+map.get("maincategory"));
	            System.out.println("subcategory"+map.get("subcategory"));
	            System.out.println("id"+map.get("id"));
	            String categoryno = service.categoryNoselect(map);
	            System.out.println(categoryno);
	            map.put("categoryno", categoryno);
	      
	             service.interestInsert(map);
	            
	            return "success";
	         }
	    
	         
	         

	         @RequestMapping(value="/Android/Interestcheckded.do", produces = "text/html; charset=UTF-8")
	         @ResponseBody
	         public String interestchecked(@RequestParam Map map) {
	           System.out.println(" 들어왔어요");
	           System.out.println(map.get("maincategory"));
	         
	         String categoryno = service.categoryNoselect(map);
	          System.out.println(categoryno);
	          map.put("categoryno", categoryno);
	           
	          int success = service.interestchecked(map);
	           
	           String result =map.get("subcategory").toString();
	           
	           if(success ==1) {
	              
	              result = "";
	           }
	           
	            return result;
	         }
	         
	         @RequestMapping(value="/Android/InsertToken.do", produces = "text/html; charset=UTF-8")
	         @ResponseBody
	         public String insertToken(@RequestParam String token) {
	        	 System.out.println("insertToken token: "+token);
	        	 int result = service.insertToken(token);
	        	 return "";
	         }
	        	    
}