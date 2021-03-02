package com.moegga.app.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.moegga.app.service.MemberDTO;
import com.moegga.app.service.TownDTO;

@Repository("bbs_imgDAO")
public class BBS_ImgDAO {

	@Resource(name="template")
	private SqlSessionTemplate bbs_imgTemplate;

	public List<Map> selectMeetingBBSImgList(Map map) {
		// TODO Auto-generated method stub
		return bbs_imgTemplate.selectList("selectMeetingBBSImgList",map);
	}

	
	

}
