package com.moegga.app.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.moegga.app.service.AdminService;
import com.moegga.app.service.BBSDTO;
import com.moegga.app.service.BBSService;

@Service("bbsService")
public class BBSServiceImpl implements BBSService {
   
   @Resource(name="BBSDAO")
   private BBSDAO dao;

   @Override
   public List<Map> selectList(Map map) {
      
      return dao.selectList(map);
   }

   @Override
   public int getTotalRecord(Map map) {
    System.out.println("들어옴");
      return dao.getTotalRecord(map);
   }

   @Override
   public BBSDTO selectOne(Map map) {
      System.out.println("selectOne 들어옴");
      return dao.selectOne(map);
   }

   @Override
   public int insert(Map map) {
      
      return    dao.insert(map);
   }

   @Override
   public int delete(Map map) {
      
      return 0;
   }

   @Override
   public int update(Map map) {
      
      return dao.update(map);
   }
   
   
   //==============모임 게시판 목록================
   @Override
   public List<Map> mBBSList() {
      
      return dao.mBBSList();
   }
   
   @Override
   public String mBBSListImgCount(String bbsno) {
      
      return dao.mBBSListImgCount(bbsno);
   }

   @Override
   public List<Map> mBBSImg(String bbsno) {
      
      return dao.mBBSImg(bbsno);
   }
   
   @Override
   public int mBBSCommentInput(Map map) {
      
      return dao.mBBSCommentInput(map);
   }
   
   @Override
   public List<BBSDTO> commentList() {      
      return dao.commentList();
   }
   //==============모임 게시판 목록 끝================
 
   
   @Override
   public List<Map> myselectList(Map map) {
      
      return dao.myselectList(map);
   }

   @Override
   public String selectLatestMeetingBBS(Map map) {
      
      return dao.selectLatestMeetingBBS(map);
   }
   
   
   //============모임 게시판 입력==================
   @Override
   public int MBBSinsert(Map map) {
      
      return dao.MBBSinsert(map);
   }
   
   @Override
   public int insertMBBSImg(Map map) {
      
      return dao.insertMBBSImg(map);
   }

   @Override
   public int MBBSNoselect() {
      return dao.MBBSNoselect();
   }
   
   @Override
   public int deleteMBBSImg(Map map) {
      
      return dao.deleteMBBSImg(map);
   }
   @Override
   public List<BBSDTO> selectMBBSImg(Map map) {
      
      return dao.selectMBBSImg(map);
   }

   //============모임 게시판 입력 끝==================
   
   //============모임 게시판 수정 ==================
   @Override
   public int mBBSEdit(Map map) {

      return dao.mBBSEdit(map);
   }

   @Override
   public BBSDTO mBBSSelectOne(Map map) {
      return dao.mBBSSelectOne(map);
   }
   @Override
   public int mBBSImgDelete(Map map) {
      return dao.mBBSImgDelete(map);
   }
   
   @Override
   public List<Map> mBBSSelectOneImg(Map map) {
      return dao.mBBSSelectOneImg(map);
   }
   //============모임 게시판 수정 끝 ==================
   //============모임 게시판 삭제 ==================
   @Override
   public int DeleteMeetingBBS(Map map) {
      return dao.DeleteMeetingBBS(map);
   }
   //============모임 게시판 삭제 끝 ==================
   
   
   //============게시판 좋아요===================
   @Override
   public int likeInsert(Map map) {
      // TODO Auto-generated method stub
      return dao.likeInsert(map);
   }

   @Override
   public String likeSelect(Map map) {
      // TODO Auto-generated method stub
      return dao.likeSelect(map);
   }

   @Override
   public int likeDelete(Map map) {
      // TODO Auto-generated method stub
      return dao.likeDelete(map);
   }
   
   @Override
   public List<Map> meetingViewBBS(Map map) {
      // TODO Auto-generated method stub
      return dao.meetingViewBBS(map);
   }
   
   @Override
   public int selectMeetingnoById(Map map) {
      // TODO Auto-generated method stub
      return dao.selectMeetingnoById(map);
   }

   @Override
   public String selectMeetingNameById(Map map) {
      // TODO Auto-generated method stub
      return dao.selectMeetingNameById(map);
   }
   
}