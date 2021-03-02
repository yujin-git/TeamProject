package com.moegga.app.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.moegga.app.service.AdminService;
import com.moegga.app.service.BBS_ImgService;
import com.moegga.app.service.MemberDTO;
import com.moegga.app.service.MemberService;
import com.moegga.app.service.TownDTO;
import com.moegga.app.service.TownService;

@Service("bbs_imgService")
public class BBS_ImgServiceImpl implements BBS_ImgService {
	
	@Resource(name="bbs_imgDAO")
	BBS_ImgDAO dao;

	@Override
	public List<Map> selectMeetingBBSImgList(Map map) {
		// TODO Auto-generated method stub
		return dao.selectMeetingBBSImgList(map);
	}

	

	
	
	

}
