package com.moegga.app.service;

import java.sql.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class BBSDTO {

   String bbsNo;//게시글 번호
   String mbbsno;
   String title;      //제목
   String contents;   //내용
   String meetingNo;   //모임 번호
   String id;         //아이디        //작성자 아이디
   String division;   //구분         //1.모임게시판
   String subCategoryNO;//모임 카테고리 // 1.음악
   Date bbsPostdate;   //작성 날짜
   String like;
   String mbbsImg;
   String imgname;
   String imgno;
   String commentContents;
   String commentLike;
   String profileimg;
   String likecount;
   String meetingno;

}