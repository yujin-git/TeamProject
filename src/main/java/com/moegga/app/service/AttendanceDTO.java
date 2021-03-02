package com.moegga.app.service;



import java.util.Date;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class AttendanceDTO {

   private String id;
   private String attendno;
   private String meetingno;
   private String meetingdayno;
   private Date attendtime;
}