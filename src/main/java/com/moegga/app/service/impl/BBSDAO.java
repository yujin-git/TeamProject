package com.moegga.app.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.moegga.app.service.BBSDTO;
import com.moegga.app.service.BBSService;

@Repository("BBSDAO")
public class BBSDAO implements BBSService{

   @Resource(name="template")
   private SqlSessionTemplate bbsTemplate;


   
   @Override
   public List<Map> selectList(Map map) {
      
      return bbsTemplate.selectList("BBSSelectList",map);
   }

   @Override
   public int insert(Map map) {
      
      return bbsTemplate.insert("BBSInsert",map);
      
   }
   
   
   public int getTotalRecord(Map map) {
      System.out.println("들어옴");
      return bbsTemplate.selectOne("BBSGetTotalRecord",map);
   }


   @Override
   public BBSDTO selectOne(Map map) {
      
      return bbsTemplate.selectOne("BBSSelectOne",map);
   }

   @Override
   public int delete(Map map) {
   
      return 0;
   }

   @Override
   public int update(Map map) {
      
      return bbsTemplate.update("BBSUpdate",map);
   
   }

   
   //내 문의함
   @Override
   public List<Map> myselectList(Map map) {
       System.out.println("DAO들어옴");
      return bbsTemplate.selectList("BBSMySelectList",map);
   }
   //===========모임 게시판 목록==============
   @Override
   public List<Map> mBBSList() {
   
      return bbsTemplate.selectList("mBBSList");
   }
   
   
   
   
   
   @Override
   public String mBBSListImgCount(String bbsno) {
   
      return bbsTemplate.selectOne("mBBSListImgCount",bbsno);
   }
   

   @Override
   public List<Map> mBBSImg(String bbsno) {
   
      return bbsTemplate.selectList("mBBSImg",bbsno);
   }

   
   
   public int mBBSCommentInput(Map map) {
      
      return bbsTemplate.insert("mBBSCommentInput", map);
   }

   @Override
   public List<BBSDTO> commentList() {
      
      return bbsTemplate.selectList("commentList");
   }

   
   
   //===========모임 게시판 목록 끝==============

   
   @Override
   public String selectLatestMeetingBBS(Map map) {
      // TODO Auto-generated method stub
      return bbsTemplate.selectOne("selectLatestMeetingBBS",map);
   }


   
   
   //=============모임 게시판 입력==================
   
   @Override
   public int MBBSinsert(Map map) {
      
      return bbsTemplate.insert("MBBSInsert", map);
   }
   
   @Override
   public int insertMBBSImg(Map map) {
      
      return bbsTemplate.insert("insertMBBSImg", map);
   }

   @Override
   public int MBBSNoselect() {
      return bbsTemplate.selectOne("MBBSNoselect");
   }
   public int deleteMBBSImg(Map map) {
      return bbsTemplate.delete("deleteMBBSImg",map);
      
   }
   public List<BBSDTO> selectMBBSImg(Map map) {
      
      return bbsTemplate.selectList("selectMBBSImg",map);
   }
   //=============모임 게시판 입력 끝==================
   
   
   
   
   
   
   //=============모임 게시판 수정 ==================
   @Override
   public int mBBSEdit(Map map) {
      return bbsTemplate.update("mBBSEdit", map);
   }

   @Override
   public BBSDTO mBBSSelectOne(Map map) {
      return bbsTemplate.selectOne("mBBSSelectOne", map);
   }
   
   @Override
   public int mBBSImgDelete(Map map) {
      
      return bbsTemplate.delete("mBBSImgDelete", map);
   }

   @Override
   public List<Map> mBBSSelectOneImg(Map map) {
      return bbsTemplate.selectList("mBBSSelectOneImg",map);
   }

   //=============모임 게시판 수정 끝==================
   //=============모임 게시판 삭제==================
   @Override
   public int DeleteMeetingBBS(Map map) {
      return bbsTemplate.delete("mBBSDelete", map);
   }
   //=============모임 게시판 삭제 끝==================   

   @Override
   public int likeInsert(Map map) {
      
      return bbsTemplate.insert("likeInsert", map);
   }


   @Override
   public String likeSelect(Map map) {
      // TODO Auto-generated method stub
      return bbsTemplate.selectOne("likeSelect", map);
   }

   @Override
   public int likeDelete(Map map) {
      // TODO Auto-generated method stub
      return bbsTemplate.delete("likeDelete", map);
   }

   @Override
   public List<Map> meetingViewBBS(Map map) {
      // TODO Auto-generated method stub
      return bbsTemplate.selectList("meetingViewBBS", map);
   }
   
   @Override
   public int selectMeetingnoById(Map map) {
      // TODO Auto-generated method stub
      return bbsTemplate.selectOne("selectMeetingnoById", map);
   }

   @Override
   public String selectMeetingNameById(Map map) {
      // TODO Auto-generated method stub
      return bbsTemplate.selectOne("selectMeetingNameById", map);
   }

   

   
   
}