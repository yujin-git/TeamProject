package com.moegga.app.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;


import com.moegga.app.service.MeetingRoleDTO;
import com.moegga.app.service.MeetingRoleService;


@Service("meetingRoleService")
public class MeetingRoleServiceImpl implements MeetingRoleService {

   
   @Resource(name="meetingRoleDAO")
   MeetingRoleDAO dao;

   @Override
   public int selectMeetingRoleList(Map map) {
      // TODO Auto-generated method stub
      return dao.selectMeetingRoleList(map);
   }

	@Override
	public int insertMemberRole(Map map) {
		// TODO Auto-generated method stub
		return dao.insertMemberRole(map);
	}
	
	@Override
	public int insertOperator(Map map) {
		// TODO Auto-generated method stub
		return dao.insertOperator(map);
	}

	@Override
	public List<MeetingRoleDTO> selectThisMeetingRole(Map map) {
		// TODO Auto-generated method stub
		return dao.selectThisMeetingRole(map);
	}

	@Override
	public int updateOperatorRole(Map map) {
		// TODO Auto-generated method stub
		return dao.updateOperatorRole(map);
	}

	@Override
	public int updateMemberRole(Map map) {
		// TODO Auto-generated method stub
		return dao.updateMemberRole(map);
	}

	@Override
	public int joinMeetingDescription(Map map) {
		// TODO Auto-generated method stub
		return dao.joinMeetingDescription(map);
	}

	@Override
	public int selectJoinMeetingList(Map map) {
		// TODO Auto-generated method stub
		return dao.selectJoinMeetingList(map);
	}

	@Override
	public List<MeetingRoleDTO> selectMyMeetingRole(Map map) {
		// TODO Auto-generated method stub
		return dao.selectMyMeetingRole(map);
	}

	@Override
	public int joinMeetingOk(Map map) {
		// TODO Auto-generated method stub
		return dao.joinMeetingOk(map);
	}

	@Override
	public int joinMeetingReject(Map map) {
		// TODO Auto-generated method stub
		return dao.joinMeetingReject(map);
	}

	@Override
	public int deleteMyMeeting(Map map) {
		// TODO Auto-generated method stub
		return dao.deleteMyMeeting(map);
	}

	@Override
	public List<MeetingRoleDTO> applicationRoleList(Map map) {
		// TODO Auto-generated method stub
		return dao.applicationRoleList(map);
	}

	@Override
	public Map isApplication(Map map) {
		// TODO Auto-generated method stub
		return dao.isApplication(map);
	}

	@Override
	public int deleteApplicationRole(Map map) {
		// TODO Auto-generated method stub
		return dao.deleteApplicationRole(map);
	}


}

