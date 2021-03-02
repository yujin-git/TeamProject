package com.moegga.app.service;

import java.util.List;
import java.util.Map;

public interface AndroidService {
	/* 안드로이드 로그인 */
	Map login(Map map);
	
	/*아이디 중복채크용*/
   int idchecked(Map map);
   /*모바일 회원가입*/
   int insertandroidMember(Map map);
   List<Map> getAndroidprofile(String id);
   List<CategoryDTO> maincategorylist(Map map);
   List<CategoryDTO> subcategorylist(Map map);
   List<MeetingDateDTO> meetingdayselect(Map map);
   String categoryNoselect(Map map);
   int interestInsert(Map map);
   
   int interestchecked(Map map);
   /*모바일 주소*/
   int insertandroidTown(Map map); 
   int updateInfoandroid(Map map);
   
   /* 안드로이드 메인용 */
   List<MeetingDTO> getRecommends(Map map);
   List<MeetingDTO> getJoinedMeeting(String id);
	
   /* 동네 둘러보기 */
	String getTown(String id);
	
	List<MeetingDTO> getMeeting(String town);
	int getCurrentRoleCount(int meetingno);
	
	List<MemberDTO> getMember(String town);
	List<Map> getInterests(String id);
	
	Map getMemberInfo(String id);
	List getAppealImg(String id);
	
	/* 게시판 */
	List<Map> getBBS(Map map);
	List<String> getBBSImg(Map map);
	String insertBBS(Map map);
	Map getMeetingNoAndOperator(String bbsno);
	int insertBBSImg(Map map);
	/* 공연 */
	List<Map> getPerform(String town);
	/* 펀딩 */
	List<Map> getFunding();
	String getSupporter(String meetingno);
	
	/* FCM */
	int insertToken(String token);
	
	
}