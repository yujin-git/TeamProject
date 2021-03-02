package com.moegga.app.service;



import java.util.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class MeetingDateDTO {

   
   private String meetingno;
   private String meetingdayno;
   private Date meetingday;
}