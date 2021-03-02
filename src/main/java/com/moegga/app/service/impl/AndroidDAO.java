package com.moegga.app.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.moegga.app.service.BBSAccusationDTO;
import com.moegga.app.service.BBSDTO;
import com.moegga.app.service.CategoryDTO;
import com.moegga.app.service.FundingDTO;
import com.moegga.app.service.MeetingAccusationDTO;
import com.moegga.app.service.MeetingDTO;
import com.moegga.app.service.MeetingDateDTO;
import com.moegga.app.service.MemberDTO;

@Repository("androidDAO")
public class AndroidDAO {
	
	@Resource(name="template")
	private SqlSessionTemplate sqlMapper;
	
	public Map login(Map map) {
		return sqlMapper.selectOne("androidlogin",map);
	}
	
	 /*아이디 중복 체크용*/
	   public int idchecked(Map map) {
	         
	      return sqlMapper.selectOne("idchecked",map);
	   }

	   /*회원가입 */
	   public int insertandroidMember(Map map) {
	      
	      return sqlMapper.insert("insertandroidMember",map);
	   }

	   public List<CategoryDTO> maincategorylist(Map map) {
	   
	      return sqlMapper.selectList("maincategorylist",map);
	   }
	   
	   public List<CategoryDTO> subcategorylist(Map map) {

	       return sqlMapper.selectList("subcategorylist",map);
	   }
	   
	   
	   
	   public List<MeetingDateDTO> meetingdayselect(Map map) {
	      
	      return sqlMapper.selectList("meetingdayselect",map);
	   }
	   

	   public String categoryNoselect(Map map) {

	      return sqlMapper.selectOne("categoryNoselect",map);
	      
	   }
	   
	   
	   public int interestInsert(Map map) {
	      
	      return sqlMapper.insert("interestInsert",map);
	   }
	      
	   public int interestchecked(Map map) {
	      
	      return sqlMapper.selectOne("interestchecked",map);
	   }
	   
	   /*회원가입 주소*/

	   public int insertandroidTown(Map map) {
	      
	      return sqlMapper.insert("insertandroidTown",map);
	   }
	   
	   //프로필 설정용
	   public int updateInfoandroid(Map map) {

	      return sqlMapper.update("updateInfoandroid",map);
	   }
	   public List<Map> getAndroidprofile(String id) {
		   
		      return sqlMapper.selectList("getAndroidprofile", id);
		   }
	   
	   
	   /* 안드 메인 */
	   public List<MeetingDTO> getRecommends(Map map) {
			// TODO Auto-generated method stub
			return sqlMapper.selectList("getRecommends",map);

		}
	   public List<MeetingDTO> getJoinedMeeting(String id) {
			// TODO Auto-generated method stub
			return sqlMapper.selectList("getJoinedMeeting",id);
		}
	

	   /* 동네둘러보기 */
	public String getTown(String id) {
		return sqlMapper.selectOne("androidgetTown", id);
	}
	public List<MeetingDTO> getMeeting(String town) {
		return sqlMapper.selectList("androidgetMeetings", town);
	}

	public int getCurrentRoleCount(int meetingno) {
		return sqlMapper.selectOne("androidgetCurrentRoleCount", meetingno);
	}

	public List<MemberDTO> getMember(String town) {
		return sqlMapper.selectList("androidgetMembers", town);
	}

	public List<Map> getInterests(String id) {
		return sqlMapper.selectList("androidgetInterests", id);
	}
	
	public Map getMemberInfo(String id) {
		return sqlMapper.selectOne("androidgetMemberInfo",id);
	}
	
	public List getAppealImg(String id) {
		return sqlMapper.selectList("androidgetAppealImg",id);
	}
	
	/* 게시판 */
	public List<Map> getBBS(Map map) {
		return sqlMapper.selectList("androidgetBBS",map);
	}
	public List<String> getBBSImg(Map map) {
		return sqlMapper.selectList("androidgetBBSImg",map);
	}
	public String insertBBS(Map map) {
		sqlMapper.insert("androidinsertBBS",map);
		return sqlMapper.selectOne("androidgetBBSNo",map);
	}
	public Map getMeetingNoAndOperator(String bbsno) {	
		return sqlMapper.selectOne("androidgetMeetingNoAndOperator",bbsno);
	}
	public int insertBBSImg(Map map) {
		return sqlMapper.insert("androidinsertBBSImg",map);
	}
	
	
	/* 공연 */
	public List<Map> getPerform(String town) {
		return sqlMapper.selectList("androidgetPerform",town);
	}
	/* 펀딩 */
	public List<Map> getFunding() {
		return sqlMapper.selectList("androidgetFunding");
	}
	
	public String getSupporter(String meetingno) {
		return sqlMapper.selectOne("androidgetSupporter",meetingno);
	}
	
	/* FCM */
	public int insertToken(String token) {
		return sqlMapper.insert("insertToken",token);
	}

	
		
}