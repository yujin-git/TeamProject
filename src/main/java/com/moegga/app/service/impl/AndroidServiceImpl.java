package com.moegga.app.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.moegga.app.service.AdminService;
import com.moegga.app.service.AndroidService;
import com.moegga.app.service.BBSAccusationDTO;
import com.moegga.app.service.BBSDTO;
import com.moegga.app.service.CategoryDTO;
import com.moegga.app.service.FundingDTO;
import com.moegga.app.service.MeetingAccusationDTO;
import com.moegga.app.service.MeetingDTO;
import com.moegga.app.service.MeetingDateDTO;
import com.moegga.app.service.MemberDTO;

@Service("androidService")
public class AndroidServiceImpl implements AndroidService {
	
	@Resource(name="androidDAO")
	AndroidDAO dao;
	
	/* 안드 로그인 */
	@Override
	public Map login(Map map) {
		return dao.login(map);
	}
		
	   @Override
	   public int idchecked(Map map) {
	      // TODO Auto-generated method stub
	      return dao.idchecked(map);
	   }
	
	   /*회원가입*/
	   @Override
	   public int insertandroidMember(Map map) {
	      
	      return dao.insertandroidMember(map);
	   }
	   @Override
	   public List<Map> getAndroidprofile(String id) {
	      // TODO Auto-generated method stub
	      return dao.getAndroidprofile(id);
	   }

	   @Override
	   public List<CategoryDTO> maincategorylist(Map map) {

	      return dao.maincategorylist(map);
	   }
	    
	   @Override
	   public List<CategoryDTO> subcategorylist(Map map) {

	      return dao.subcategorylist(map);
	   }

	   @Override
	   public List<MeetingDateDTO> meetingdayselect(Map map) {

	      return dao.meetingdayselect(map);
	   }

	   @Override
	   public String categoryNoselect(Map map) {

	      return dao.categoryNoselect(map);
	   }

	   @Override
	   public int interestInsert(Map map) {
	      
	      return dao.interestInsert(map);
	   }

	   @Override
	   public int interestchecked(Map map) {
	      
	      return dao.interestchecked(map);
	   }
	      
	
	   /*회원가입 주소*/
	   @Override
	   public int insertandroidTown(Map map) {
	      // TODO Auto-generated method stub
	      return dao.insertandroidTown(map);
	   }
	
	   //프로필 설정용
	   @Override
	   public int updateInfoandroid(Map map) {
	      // TODO Auto-generated method stub
	      return dao.updateInfoandroid(map);
	   }
	   
	   /* 안드 메인 */
	   @Override
		public List<MeetingDTO> getRecommends(Map map) {
			// TODO Auto-generated method stub
			return dao.getRecommends(map);
		}
	   @Override
		public List<MeetingDTO> getJoinedMeeting(String id) {
			// TODO Auto-generated method stub
			return dao.getJoinedMeeting(id);
		}

	   /* 동네 둘러보기 */
	@Override
	public String getTown(String id) {
		// TODO Auto-generated method stub
		return dao.getTown(id);
	}
	@Override
	public List<MeetingDTO> getMeeting(String town) {
		// TODO Auto-generated method stub
		return dao.getMeeting(town);
	}
	@Override
	public int getCurrentRoleCount(int meetingno) {
		return dao.getCurrentRoleCount(meetingno);
	}
	
	@Override
	public List<MemberDTO> getMember(String town) {
		return dao.getMember(town);
	}

	@Override
	public List<Map> getInterests(String id) {
		return dao.getInterests(id);
	}
	
	@Override
	public Map getMemberInfo(String id) {
		return dao.getMemberInfo(id);
	}
	
	@Override
	public List getAppealImg(String id) {
		return dao.getAppealImg(id);
	}
	
	/* 게시글 */
	@Override
	public List<Map> getBBS(Map map) {
		return dao.getBBS(map);
	}
	@Override
	public List<String> getBBSImg(Map map) {
		return dao.getBBSImg(map);
	}
	@Override
	public String insertBBS(Map map) {
		return dao.insertBBS(map);
	}
	@Override
	public Map getMeetingNoAndOperator(String bbsno) {	
		return dao.getMeetingNoAndOperator(bbsno);
	}
	@Override
	public int insertBBSImg(Map map) {
		return dao.insertBBSImg(map);
	}
	
	/* 공연 */
	@Override
	public List<Map> getPerform(String town) {
		return dao.getPerform(town);
	}
	
	/* 펀딩 */
	@Override
	public List<Map> getFunding() {
		return dao.getFunding();
	}
	
	@Override
	public String getSupporter(String meetingno) {
		return dao.getSupporter(meetingno);
	}
	
	/* FCM */
	@Override
	public int insertToken(String token) {
		return dao.insertToken(token);
	}

	
	
}