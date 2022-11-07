package loti.homepageMgr.web;

import java.util.ArrayList;
import java.util.List;

import loti.courseMgr.service.CourseSeqService;
import loti.homeFront.service.CourseService;
import loti.homepageMgr.service.TimeTableService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import ut.lib.exception.BizException;
import ut.lib.login.LoginInfo;
import ut.lib.support.CommonMap;
import ut.lib.support.DataMap;
import ut.lib.util.Functions;
import common.controller.BaseController;

@Controller("homepageMgrTimeTableController")
@RequestMapping("/mypage/timeReport.do")
public class TimeTableController extends BaseController {

	@Autowired
	@Qualifier("homepageMgrTimeTableService")
	private TimeTableService timeTableService;
	
	@Autowired
	private CourseSeqService courseSeqService;
	
	@RequestMapping
	public String list(CommonMap cm, Model model) throws BizException{
		
		//사용자 정보 추출.
		LoginInfo loginInfo = cm.getLoginInfo();
		
		DataMap requestMap = cm.getDataMap();
		
		
		DataMap grseqRowMap = null;
		DataMap listMap = null;
		DataMap grseqClassroomMap = null; //기수의 강의실 정보.
		
		if("".equals(requestMap.getString("searchKey")))
			requestMap.setString("searchKey", "MORNING");
		
		if(!"".equals(requestMap.getString("commGrcode")) && !"".equals(requestMap.getString("commGrseq"))){
			
			//과정 기수 정보
			grseqRowMap = courseSeqService.selectGrSeqRow(requestMap.getString("commGrcode"), requestMap.getString("commGrseq"));
			if(grseqRowMap == null) grseqRowMap = new DataMap();
			grseqRowMap.isNullToInitialize();
			
			//리스트
			listMap = timeTableService.selectTimeTableList(requestMap, grseqRowMap, loginInfo);
			
			//기수의 강의실 및 과정장.
			grseqClassroomMap = timeTableService.selectClassRoomByGrseqRow(requestMap.getString("commGrcode"), requestMap.getString("commGrseq")); //기수의 강의실 정보.
		
		}else{
			grseqRowMap = new DataMap();
			listMap = new DataMap();
			grseqClassroomMap = new DataMap(); //기수의 강의실 정보.
		}
		
		model.addAttribute("LIST_DATA", listMap);
		model.addAttribute("GRSEQ_ROW_DATA", grseqRowMap);
		model.addAttribute("GRSEQ_CLASSROOM_ROW_DATA", grseqClassroomMap);
		
		return "/homepage/mypage/timeTableList";
	}
}
