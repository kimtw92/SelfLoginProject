package loti.homeFront.web;

/**
 * prgNM : homepage index
 * auth  : kang
 * date  : 08.08.08
 * default Class
 */

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import loti.baseCodeMgr.service.GrannaeService;
import loti.common.service.CommonService;
import loti.homeFront.service.CourseService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import ut.lib.exception.BizException;
import ut.lib.login.LoginInfo;
import ut.lib.support.CommonMap;
import ut.lib.support.DataMap;
import ut.lib.util.Util;
import common.controller.BaseController;

@Controller
public class CourseController extends BaseController{
	
	@Autowired
	private CourseService courseService;
	
	@Autowired
	private GrannaeService grannaeService;
	
	@Autowired
	private CommonService commonService;
	
	
	@ModelAttribute(value="cm")
	public CommonMap common(CommonMap cm, HttpServletRequest request, HttpSession session, Model model, @RequestParam(value="mode", required=false) String mode) throws BizException{
		
		/**
		 * 로그인 체크
		 */
		LoginInfo loginInfo = (LoginInfo)request.getAttribute("LOGIN_INFO");
		if(loginInfo.isLogin() == false){
			// 로그인 안되어 있음
			log.debug("로그인 안되어 있음");
		}
		
		/**
		 * 험난한..교육과정 시작
		 * 
		 */

		
		/**
		 * 페이징 필수
		 */
		String currPage = Util.nvl(cm.getDataMap().getString("currPage"));
		String rowSize = Util.nvl(cm.getDataMap().getString("rowSize"));
		String pageSize = Util.nvl(cm.getDataMap().getString("pageSize"));
		
		// 페이지
		if ("".equals(currPage)){
			cm.getDataMap().setInt("currPage", 1);
		}
		// 페이지당 보여줄 갯수
		if ("".equals(rowSize)){
			cm.getDataMap().setInt("rowSize", 10); 
		}
		// 페이지 블럭 갯수
		if ("".equals(pageSize)){
			cm.getDataMap().setInt("pageSize", 10);
		}
		
		// 리퀘스트 정보를 담고있는 DataMap을 Attribute 에 추가
		model.addAttribute("REQUEST_DATA", cm.getDataMap());
		model.addAttribute("LOGIN_INFO", loginInfo);
		
		log.info("mode="+mode + ", DataMap : " + cm.getDataMap());
		
		return cm;
	}
	
	
	@RequestMapping(value="/homepage/course.do", params="mode=eduinfo3-1")
	public String eduinfo3_1(@ModelAttribute("cm") CommonMap cm, Model model) throws BizException{
		model.addAttribute("BASIC_COURSE_DATA", courseService.getBasicCourseData(cm.getDataMap()));
		return "/homepage/eduInfo/eduinfo3-1";
	}
	@RequestMapping(value="/homepage/course.do", params="mode=pageing1")
	public String pageing1(@ModelAttribute("cm") CommonMap cm, Model model) throws BizException{
		return eduinfo3_1(cm, model);
	}
	
	@RequestMapping(value="/homepage/course.do", params="mode=eduinfo3-2")
	public String eduinfo3_2(@ModelAttribute("cm") CommonMap cm, Model model) throws BizException{
		
		model.addAttribute("LONG_COURSE_DATA", courseService.getLongCourseData(cm.getDataMap()));
		
		return "/homepage/eduInfo/eduinfo3-2";
	}
	@RequestMapping(value="/homepage/course.do", params="mode=pageing2")
	public String pageing2(@ModelAttribute("cm") CommonMap cm, Model model) throws BizException{
		return eduinfo3_2(cm, model);
	}
	
	@RequestMapping(value="/homepage/course.do", params="mode=eduinfo3-3")
	public String eduinfo3_3(@ModelAttribute("cm") CommonMap cm, Model model) throws BizException{
		model.addAttribute("PROF_COURSE_DATA", courseService.getProfCourseData(cm.getDataMap()));
		return "/homepage/eduInfo/eduinfo3-3";
	}
	@RequestMapping(value="/homepage/course.do", params="mode=pageing3")
	public String pageing3(@ModelAttribute("cm") CommonMap cm, Model model) throws BizException{
		return eduinfo3_3(cm, model);
	}
	
	@RequestMapping(value="/homepage/course.do", params="mode=eduinfo3-4")
	public String eduinfo3_4(@ModelAttribute("cm") CommonMap cm, Model model) throws BizException{
		model.addAttribute("CYBER_COURSE_DATA", courseService.getCyberCourseData(cm.getDataMap()));
		return "/homepage/eduInfo/eduinfo3-4";
	}
	@RequestMapping(value="/homepage/course.do", params="mode=pageing4")
	public String pageing4(@ModelAttribute("cm") CommonMap cm, Model model) throws BizException{
		return eduinfo3_4(cm, model);
	}
	
	@RequestMapping(value="/homepage/course.do", params="mode=eduinfo3-5")
	public String eduinfo3_5(@ModelAttribute("cm") CommonMap cm, Model model) throws BizException{
		model.addAttribute("ETC_COURSE_DATA", courseService.getEtcCourseData(cm.getDataMap()));
		return "/homepage/eduInfo/eduinfo3-5";
	}
	@RequestMapping(value="/homepage/course.do", params="mode=pageing5")
	public String pageing5(@ModelAttribute("cm") CommonMap cm, Model model) throws BizException{
		return eduinfo3_5(cm, model);
	}
	
	@RequestMapping(value="/homepage/course.do", params="mode=eduinfo3-7")
	public String eduinfo3_7(@ModelAttribute("cm") CommonMap cm, Model model) throws BizException{
		model.addAttribute("SPECIAL_COURSE_DATA", courseService.getSpecialCourseData(cm.getDataMap()));
		return "/homepage/eduInfo/eduinfo3-7";
	}
	@RequestMapping(value="/homepage/course.do", params="mode=pageing7")
	public String pageing7(@ModelAttribute("cm") CommonMap cm, Model model) throws BizException{
		return eduinfo3_7(cm, model);
	}
	
	@RequestMapping(value="/homepage/course.do", params="mode=searchcourse")
	public String searchcourse(
						@ModelAttribute("cm") CommonMap cm
						, Model model
						, @RequestParam(value="coursename", defaultValue="", required=false) String courseName
					) throws Exception{
		courseName = commonService.keywordFilter(courseName);
		model.addAttribute("SEARCH_COURSE_DATA", courseService.searchCourseData(cm.getDataMap(),courseName));
		model.addAttribute("courseName", courseName);
		return "/homepage/eduInfo/eduinfo3-6";
	}
	@RequestMapping(value="/homepage/course.do", params="mode=pageing6")
	public String pageing6(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			, @RequestParam(value="coursename", defaultValue="", required=false) String courseName
			) throws Exception{
		return searchcourse(cm, model, courseName);
	}
	
	@RequestMapping(value="/homepage/course.do", params="mode=courseinfopopup")
	public String courseinfopopup(
					@ModelAttribute("cm") CommonMap cm
					, Model model
					, @RequestParam(value="grcode", required=false, defaultValue="") String grcode
					, @RequestParam(value="grseq", required=false, defaultValue="") String grseq
					) throws BizException{
		
		model.addAttribute("COURSE_INFO_POPUP1"    , courseService.getCourseInfoPopup1(grcode));
		model.addAttribute("COURSE_INFO_POPUP2"    , courseService.getCourseInfoPopup2(grcode));
		model.addAttribute("COURSE_INFO_SUM"       , courseService.getCourseInfoSum(grcode));
		model.addAttribute("COURSE_INFO_SUB_SUM1"  , courseService.getCourseInfoSubSum(grcode, "1"));
		model.addAttribute("COURSE_INFO_SUB_SUM2"  , courseService.getCourseInfoSubSum(grcode, "2"));
		model.addAttribute("COURSE_INFO_SUB_SUM3"  , courseService.getCourseInfoSubSum(grcode, "3"));
		model.addAttribute("COURSE_INFO_DETAIL"    , courseService.getCourseInfoDetail(grcode));
		
		DataMap requestMap = cm.getDataMap();
		// 급한 인원및 기간 관련 땜빵
		String year = "";
		if (grseq.length() > 4){
			year = grseq.substring(0,4);
			requestMap.setString("year", year);
		}
		
		DataMap grSeqMap =  grannaeService.selectGrSeqList(requestMap);
		
		model.addAttribute("COURSE_INFO_PERSON", grSeqMap);
		model.addAttribute("YEAR", year);
		
		return "/homepage/eduInfo/courseinfopopup";
	}
	
}
