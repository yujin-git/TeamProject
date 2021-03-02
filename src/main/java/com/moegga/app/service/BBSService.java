package com.moegga.app.service;

import java.util.List;
import java.util.Map;

import org.json.simple.JSONArray;


public interface BBSService {

   
 

   
   //admin애서 전체asdasdasd 문의게시판 리스트
   List<Map> selectList(Map map);
   
   ///마이 페이지 내문의리스트
   List<Map> myselectList(Map map);
   //전체 레코드 수]
   int getTotalRecord(Map map);
   //상세보기용]
   BBSDTO selectOne(Map map);
   //입력/수정/삭제용]
   int insert(Map map);
   int delete(Map map);
   int update(Map map);

   String selectLatestMeetingBBS(Map map);
   
   
   //=========모임 게시판 입력============
   int MBBSinsert(Map map);
   int MBBSNoselect();
   
   int insertMBBSImg(Map map);
   int deleteMBBSImg(Map map);
   List<BBSDTO> selectMBBSImg(Map map);
   int selectMeetingnoById(Map map);
   String selectMeetingNameById(Map map);

   //=========모임 게시판 입력 끝============
   
   //=====모임 게시판 목록=======
   List<Map> mBBSList();
   String mBBSListImgCount(String bbsno);
   List<Map> mBBSImg(String bbsno);
   
   int mBBSCommentInput(Map map);
   List<BBSDTO> commentList();
   //=====모임 게시판 목록 끝=======   

   //====모임 게시판 수정======
   int mBBSEdit(Map map);
   BBSDTO mBBSSelectOne(Map map);
   int mBBSImgDelete(Map map);
   List<Map> mBBSSelectOneImg(Map map);
   //====모임 게시판 수정 끝======
   
   //====모임 게시판 삭제========
   int DeleteMeetingBBS(Map map);
   //====모임 게시판 삭제 끝========

   
   //===모임 게시판 좋아요=====
   int likeInsert(Map map);
   String likeSelect(Map map);
   int likeDelete(Map map);
  //===모임 게시판 좋아요 끝=====

   List<Map> meetingViewBBS(Map map);

  
    

   
}