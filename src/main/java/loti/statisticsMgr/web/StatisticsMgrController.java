package loti.statisticsMgr.web;

import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import loti.common.service.CommonService;
import loti.member.service.MemberService;
import loti.statisticsMgr.service.StatisticsMgrService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import ut.lib.login.LoginCheck;
import ut.lib.login.LoginInfo;
import ut.lib.support.CommonMap;
import ut.lib.support.DataMap;
import ut.lib.util.Util;
import common.controller.BaseController;

@Controller
public class StatisticsMgrController extends BaseController {

	@Autowired
	private StatisticsMgrService statisticsMgrService;
	
	@Autowired
	private CommonService commonService;
	
	@Autowired
	private MemberService memberService;
	
	@ModelAttribute("cm")
	public CommonMap common(
				CommonMap cm
				, HttpServletRequest request
				, HttpServletResponse response
			) throws Exception{
		
		// 리퀘스트 받기
		DataMap requestMap = cm.getDataMap();
		requestMap.setNullToInitialize(true);
		
		// default mode
		String mode = Util.getValue(requestMap.getString("mode"));		
		
		//관리자 로그인 체크
		LoginInfo memberInfo = null;
		
		/*memberInfo = LoginCheck.adminCheck(request, response, requestMap.getString("menuId") );
		if (memberInfo == null){			
			return null;
		}
		
		// 공통 Comm Select Box 값 초기 셋팅.
		HttpSession session = request.getSession(); //세션
		if(requestMap.getString("commYear").equals("")){
			requestMap.setString("commYear", (String)session.getAttribute("sess_year"));
		}
		if(requestMap.getString("commGrcode").equals("")){
			requestMap.setString("commGrcode", (String)session.getAttribute("sess_grcode"));
		}
		if(requestMap.getString("commGrseq").equals("")){
			requestMap.setString("commGrseq", (String)session.getAttribute("sess_grseq"));
		}		*/
		
		return cm;
	}
	
	public String findView(String mode, String defaultView){
		return defaultView;
	}
	
	/**
	 * 분야별 통계
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @param requestMap
	 * @param memberInfo
	 * @throws Exception
	 */
	public void majorList(
			Model model,
			DataMap requestMap,
			LoginInfo memberInfo) throws Exception {
		
		DataMap listMap = null;
		DataMap tabMenuMap = null;
		
		// 상단  tab 메뉴
		//tabMenuMap = statisticsMgrService.tabMenu(memberInfo.getSessCurrentAuth());
		
		
		
		String dept = "";
		String yearMonthFrom = requestMap.getString("yearMonthFrom");
		String yearMonthTo = requestMap.getString("yearMonthTo");
		
		if( memberInfo.getSessClass().equals("3")){
			dept = memberInfo.getSessDept();
		}
				
		// 오늘 날짜
		Date today = new Date();
		SimpleDateFormat sdfYearMonth = new SimpleDateFormat("yyyyMM");
		SimpleDateFormat sdfYear = new SimpleDateFormat("yyyy");
		
		if(yearMonthFrom.equals("")){
			yearMonthFrom = sdfYear.format(today) + "01";
			yearMonthTo = sdfYearMonth.format(today);
			
			model.addAttribute("DATE_FROM", yearMonthFrom);
			model.addAttribute("DATE_TO", yearMonthTo);
		}
		
		
		listMap = statisticsMgrService.majorList(dept, yearMonthFrom, yearMonthTo);
				
		//model.addAttribute("TABMENU_DATA", tabMenuMap);
		model.addAttribute("LIST_DATA", listMap);
		
	}
	
	@RequestMapping(value="/statisMgr/stats.do", params="mode=major")
	public String major(
				@ModelAttribute("cm") CommonMap cm
				, Model model
			) throws Exception{
		
		DataMap requestMap = cm.getDataMap();
		
		majorList(model, requestMap, cm.getLoginInfo());
		
		//return findView(requestMap.getString("mode"), "/statisticsMgr/majorStats");
		return "/statisticsMgr/majorStats";
	}
	
	@RequestMapping(value="/statisMgr/stats.do", params="mode=majorPrint")
	public String majorPrint(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			) throws Exception{
		
		DataMap requestMap = cm.getDataMap();
		
		majorList(model, requestMap, cm.getLoginInfo());
		
		return findView(requestMap.getString("mode"), "/statisticsMgr/majorStatsPrint");
	}
	
	@RequestMapping(value="/statisMgr/stats.do", params="mode=majorExcel")
	public String majorExcel(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			) throws Exception{
		
		DataMap requestMap = cm.getDataMap();
		
		majorList(model, requestMap, cm.getLoginInfo());
		
		return findView(requestMap.getString("mode"), "/statisticsMgr/majorStatsByExcel");
	}
	
	/**
	 * 과정별 통계
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @param requestMap
	 * @param memberInfo
	 * @throws Exception
	 */
	public void courseList(
			Model model,
			DataMap requestMap,
			LoginInfo memberInfo) throws Exception {
		
		DataMap listMap = null;
		DataMap tabMenuMap = null;
		DataMap deptMap = null;
		
		
		/**
		 * 상단 TAB
		 */
		//tabMenuMap = statisticsMgrService.tabMenu(memberInfo.getSessCurrentAuth());
		
		
		
		String dept = requestMap.getString("searchDept");
		String yearMonthFrom = requestMap.getString("yearMonthFrom");
		String yearMonthTo = requestMap.getString("yearMonthTo");
		
		if( memberInfo.getSessClass().equals("3")){
			dept = memberInfo.getSessDept();
		}else{
			// 기관리스트
			deptMap = commonService.selectDeptSearch("");
			
		}
		
		// 오늘 날짜
		Date today = new Date();
		SimpleDateFormat sdfYearMonth = new SimpleDateFormat("yyyyMM");
		SimpleDateFormat sdfYear = new SimpleDateFormat("yyyy");
		
		if(yearMonthFrom.equals("")){
			yearMonthFrom = sdfYear.format(today) + "01";
			yearMonthTo = sdfYearMonth.format(today);
			
			model.addAttribute("DATE_FROM", yearMonthFrom);
			model.addAttribute("DATE_TO", yearMonthTo);
		}
		
		
		listMap = statisticsMgrService.courseStats(dept, yearMonthFrom, yearMonthTo);
				
		//model.addAttribute("TABMENU_DATA", tabMenuMap);
		model.addAttribute("LIST_DATA", listMap);
		model.addAttribute("DEPT_DATA", deptMap);
		
	}
	
	@RequestMapping(value="/statisMgr/stats.do", params="mode=course")
	public String course(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			) throws Exception{
		
		DataMap requestMap = cm.getDataMap();
		
		courseList(model, requestMap, cm.getLoginInfo());
		
		//return findView(requestMap.getString("mode"), "/statisticsMgr/courseStats");
		return "/statisticsMgr/courseStats";
	}
	
	@RequestMapping(value="/statisMgr/stats.do", params="mode=courseExcel")
	public String courseExcel(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			) throws Exception{
		
		DataMap requestMap = cm.getDataMap();
		
		courseList(model, requestMap, cm.getLoginInfo());
		
		return findView(requestMap.getString("mode"), "/statisticsMgr/courseStatsByExcel");
	}
	
	/**
	 * 미등록 미수료자 현황
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @param requestMap
	 * @param memberInfo
	 * @throws Exception
	 */
	public void accidentStats(
			Model model,
			DataMap requestMap,
			LoginInfo memberInfo) throws Exception {
		
		DataMap listMap = null;
		DataMap tabMenuMap = null;
		
		
		/**
		 * 상단 TAB
		 */
		tabMenuMap = statisticsMgrService.tabMenu(memberInfo.getSessCurrentAuth());
						
		String searchYear = requestMap.getString("searchYear");
		
		
		// 오늘 날짜
		Date today = new Date();
		SimpleDateFormat sdfYear = new SimpleDateFormat("yyyy");
		
		if(searchYear.equals("")){
			searchYear = sdfYear.format(today);		
			model.addAttribute("DATE_YEAR", searchYear);
		}
			
		listMap = statisticsMgrService.accidentStats(searchYear);
				
		model.addAttribute("TABMENU_DATA", tabMenuMap);
		model.addAttribute("LIST_DATA", listMap);
		
	}
	
	@RequestMapping(value="/statisMgr/stats.do", params="mode=accident")
	public String accident(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			) throws Exception{
		
		DataMap requestMap = cm.getDataMap();
		
		accidentStats(model, requestMap, cm.getLoginInfo());
		
		return findView(requestMap.getString("mode"), "/statisticsMgr/accidentStats");
	}
	
	@RequestMapping(value="/statisMgr/stats.do", params="mode=accidentExcel")
	public String accidentExcel(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			) throws Exception{
		
		DataMap requestMap = cm.getDataMap();
		
		accidentStats(model, requestMap, cm.getLoginInfo());
		
		return findView(requestMap.getString("mode"), "/statisticsMgr/accidentStatsByExcel");
	}
	
	/**
	 * 대상별 교육훈련실적 - 직급별, 소속별
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @param requestMap
	 * @param memberInfo
	 * @throws Exception
	 */
	public void targetEduStatsByPosition(
			Model model,
			DataMap requestMap,
			LoginInfo memberInfo) throws Exception {
		
		DataMap listMap = null;
		DataMap tabMenuMap = null;
		
		
		/**
		 * 상단 TAB
		 */
		tabMenuMap = statisticsMgrService.tabMenu(memberInfo.getSessCurrentAuth());
						
		String searchYear = requestMap.getString("searchYear");
		
		
		// 오늘 날짜
		Date today = new Date();
		SimpleDateFormat sdfYear = new SimpleDateFormat("yyyy");
		
		if(searchYear.equals("")){
			searchYear = sdfYear.format(today);		
			model.addAttribute("DATE_YEAR", searchYear);
		}
		
		model.addAttribute("TABMENU_DATA", tabMenuMap);
		
	}
	
	@RequestMapping(value="/statisMgr/stats.do", params="mode=position")
	public String position(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			) throws Exception{
		
		DataMap requestMap = cm.getDataMap();
		
		targetEduStatsByPosition(model, requestMap, cm.getLoginInfo());
		
		return findView(requestMap.getString("mode"), "/statisticsMgr/targetEduStatsByPosition");
	}
	
	@RequestMapping(value="/statisMgr/stats.do", params="mode=dept")
	public String dept(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			) throws Exception{
		
		DataMap requestMap = cm.getDataMap();
		
		targetEduStatsByPosition(model, requestMap, cm.getLoginInfo());
		
		return findView(requestMap.getString("mode"), "/statisticsMgr/targetEduStatsByDept");
	}
	
	/**
	 * 대상별 교육훈련실적 - 직렬별
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @param requestMap
	 * @param memberInfo
	 * @throws Exception
	 */
	public void targetEduStatsByJikr(
			Model model,
			DataMap requestMap,
			LoginInfo memberInfo) throws Exception {
		
		DataMap listMap = null;
		DataMap colMap = null;
		DataMap tabMenuMap = null;
		
		/**
		 * 상단 TAB
		 */
		tabMenuMap = statisticsMgrService.tabMenu(memberInfo.getSessCurrentAuth());
						
		String searchYear = requestMap.getString("searchYear");
		String month = requestMap.getString("month");
		
		
		// 오늘 날짜
		Date today = new Date();
		SimpleDateFormat sdfYear = new SimpleDateFormat("yyyy");
		
		if("".equals(searchYear)){
			searchYear = sdfYear.format(today);		
			model.addAttribute("DATE_YEAR", searchYear);
		}
		model.addAttribute("month", month);
		
		StringBuffer sbTotalSQL = new StringBuffer();
		StringBuffer sbSumSQL = new StringBuffer();
		StringBuffer sbDecodeSQL = new StringBuffer();
		
		colMap = statisticsMgrService.selectJikr(searchYear);
		if(colMap == null) colMap = new DataMap();
		colMap.setNullToInitialize(true);				
		if(colMap.keySize("codenm") > 0){		
			for(int i=0; i < colMap.keySize("codenm"); i++){
				if(i==0){
					//SUM(C.COL1) + SUM(C.COL2) + SUM(C.COL3) + SUM(C.COL4) + SUM(C.COL5)
					//SUM(C.COL1) AS COL1,
					//DECODE(B.CODE, '007',B.JIKR_CNT,0) COL1,
					
					sbTotalSQL.append(" SUM(C.COL" + colMap.getString("rowIndex",i) + ") ");
					sbSumSQL.append(" SUM(C.COL" + colMap.getString("rowIndex",i) + ") AS COL" + colMap.getString("rowIndex",i) + " ");
					sbDecodeSQL.append(" DECODE(B.CODE, '" + colMap.getString("code",i) + "',B.JIKR_CNT,0) COL" + colMap.getString("rowIndex",i) + " ");
					
				}else{
					sbTotalSQL.append(" + SUM(C.COL" + colMap.getString("rowIndex",i) + ") ");
					sbSumSQL.append(" , SUM(C.COL" + colMap.getString("rowIndex",i) + ") AS COL" + colMap.getString("rowIndex",i) + " ");
					sbDecodeSQL.append(" , DECODE(B.CODE, '" + colMap.getString("code",i) + "',B.JIKR_CNT,0) COL" + colMap.getString("rowIndex",i) + " ");
				}
			}
			
			listMap = statisticsMgrService.targetEduStatsByJikr(searchYear, sbTotalSQL, sbSumSQL, sbDecodeSQL, month);
			
		}
											
		model.addAttribute("TABMENU_DATA", tabMenuMap);
		model.addAttribute("COL_DATA", colMap);
		model.addAttribute("LIST_DATA", listMap);
		
	}
	
	@RequestMapping(value="/statisMgr/stats.do", params="mode=tjikr")
	public String tjikr(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			) throws Exception{
		
		DataMap requestMap = cm.getDataMap();
		
		targetEduStatsByJikr(model, requestMap, cm.getLoginInfo());
		
		return findView(requestMap.getString("mode"), "/statisticsMgr/targetEduStatsByJikr");
	}
	
	@RequestMapping(value="/statisMgr/stats.do", params="mode=tjikrExcel")
	public String tjikrExcel(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			) throws Exception{
		
		DataMap requestMap = cm.getDataMap();
		
		targetEduStatsByJikr(model, requestMap, cm.getLoginInfo());
		
		return findView(requestMap.getString("mode"), "/statisticsMgr/targetEduStatsByJikrExcel");
	}
	
	/**
	 * 대상별 교육훈련실적 - 남여별
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @param requestMap
	 * @param memberInfo
	 * @throws Exception
	 */
	public void targetEduStatsByHuman(
			Model model,
			DataMap requestMap,
			LoginInfo memberInfo) throws Exception {
		
		DataMap listMap = null;
		DataMap tabMenuMap = null;
		
		
		/**
		 * 상단 TAB
		 */
		tabMenuMap = statisticsMgrService.tabMenu(memberInfo.getSessCurrentAuth());
						
		String searchYear = requestMap.getString("searchYear");
		
		
		// 오늘 날짜
		Date today = new Date();
		SimpleDateFormat sdfYear = new SimpleDateFormat("yyyy");
		
		if(searchYear.equals("")){
			searchYear = sdfYear.format(today);		
			model.addAttribute("DATE_YEAR", searchYear);
		}
			
		listMap = statisticsMgrService.targetEduStatsByHuman(searchYear);
				
		model.addAttribute("TABMENU_DATA", tabMenuMap);
		model.addAttribute("LIST_DATA", listMap);
		
	}
	
	@RequestMapping(value="/statisMgr/stats.do", params="mode=human")
	public String human(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			) throws Exception{
		
		DataMap requestMap = cm.getDataMap();
		
		targetEduStatsByHuman(model, requestMap, cm.getLoginInfo());
		
		return findView(requestMap.getString("mode"), "/statisticsMgr/targetEduStatsByHuman");
	}
	
	@RequestMapping(value="/statisMgr/stats.do", params="mode=humanExcel")
	public String humanExcel(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			) throws Exception{
		
		DataMap requestMap = cm.getDataMap();
		
		targetEduStatsByHuman(model, requestMap, cm.getLoginInfo());
		
		return findView(requestMap.getString("mode"), "/statisticsMgr/targetEduStatsByHumanExcel");
	}
	
	@RequestMapping(value="/statisMgr/stats.do", params="mode=edu")
	public String edu(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			) throws Exception{
		
		DataMap requestMap = cm.getDataMap();
		DataMap listMap = null;
		DataMap tabMenuMap = null;
		
		
		/**
		 * 상단 TAB
		 */
		tabMenuMap = statisticsMgrService.tabMenu(cm.getLoginInfo().getSessCurrentAuth());
						
		String searchYear = requestMap.getString("searchYear");
		
		// 오늘 날짜
		Date today = new Date();
		SimpleDateFormat sdfYear = new SimpleDateFormat("yyyy");
		
		if(searchYear.equals("")){
			searchYear = sdfYear.format(today);		
			model.addAttribute("DATE_YEAR", searchYear);
		}
		
		model.addAttribute("TABMENU_DATA", tabMenuMap);
		
		return findView(requestMap.getString("mode"), "/statisticsMgr/eduPlanStats");
	}
	
	/**
	 * 교육훈련성적 리스트
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @param requestMap
	 * @param memberInfo
	 * @throws Exception
	 */
	public void eduPlanList(
			Model model,
			DataMap requestMap,
			LoginInfo memberInfo) throws Exception {
		
		DataMap listMap = null;
						
		String searchYear = requestMap.getString("searchYear");
		String oldYear = "";
		
		
		// 오늘 날짜
		Date today = new Date();
		SimpleDateFormat sdfYear = new SimpleDateFormat("yyyy");
		
		if(searchYear.equals("")){
			searchYear = sdfYear.format(today);		
			model.addAttribute("DATE_YEAR", searchYear);
		}
		oldYear = String.valueOf(Integer.parseInt(searchYear) - 1);
		
		String mode = Util.getValue(requestMap.getString("mode"));	
		
		if(mode.equals("eduAvg") || mode.equals("eduAvgExcel")){
			listMap = statisticsMgrService.eduPlanAvgScore(searchYear, oldYear);
		}else{
			listMap = statisticsMgrService.eduPlanRange(searchYear, oldYear);
		}
		
		model.addAttribute("LIST_DATA", listMap);
		
	}
	
	@RequestMapping(value="/statisMgr/stats.do", params="mode=eduAvg")
	public String eduAvg(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			) throws Exception{
		
		DataMap requestMap = cm.getDataMap();
		
		eduPlanList(model, requestMap, cm.getLoginInfo());
		
		return findView(requestMap.getString("mode"), "/statisticsMgr/eduPlanStatsAvgScoreByAjax");
	}
	
	@RequestMapping(value="/statisMgr/stats.do", params="mode=eduAvgExcel")
	public String eduAvgExcel(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			) throws Exception{
		
		DataMap requestMap = cm.getDataMap();
		
		eduPlanList(model, requestMap, cm.getLoginInfo());
		
		return findView(requestMap.getString("mode"), "/statisticsMgr/eduPlanStatsAvgScoreByExcel");
	}
	
	@RequestMapping(value="/statisMgr/stats.do", params="mode=eduRange")
	public String eduRange(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			) throws Exception{
		
		DataMap requestMap = cm.getDataMap();
		
		eduPlanList(model, requestMap, cm.getLoginInfo());
		
		return findView(requestMap.getString("mode"), "/statisticsMgr/eduPlanStatsRangeByAjax");
	}
	
	@RequestMapping(value="/statisMgr/stats.do", params="mode=eduRangeExcel")
	public String eduRangeExcel(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			) throws Exception{
		
		DataMap requestMap = cm.getDataMap();
		
		eduPlanList(model, requestMap, cm.getLoginInfo());
		
		return findView(requestMap.getString("mode"), "/statisticsMgr/eduPlanStatsRangeByExcel");
	}
	
	/**
	 * 사이버교육통계
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @param requestMap
	 * @param memberInfo
	 * @throws Exception
	 */
	public void cyberCourseStats(
			Model model,
			DataMap requestMap,
			LoginInfo memberInfo) throws Exception {
		
		DataMap listMap = null;
						
		
		
		String key = requestMap.getString("key");	
		if (key.equals("")) {
			key = statisticsMgrService.getMaxGrSeq();
		}
		
		//if(!subjType.equals("")){
			listMap = statisticsMgrService.cyberCourseStats(key);
		//}
		
		
		model.addAttribute("LIST_DATA", listMap);
		//model.addAttribute("TABMENU_DATA", tabMenuMap);
	}
	
	@RequestMapping(value="/statisMgr/stats.do", params="mode=cyber")
	public String cyber(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			) throws Exception{
		
		DataMap requestMap = cm.getDataMap();
		
		cyberCourseStats(model, requestMap, cm.getLoginInfo());
		
		//return findView(requestMap.getString("mode"), "/statisticsMgr/cyberCourseStats");
		//return "/statisticsMgr/cyberCourseStats";
		return "/homepage/attend/cityFinishList";
	}
	
	/**
	 * 신규 작업
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @param requestMap
	 * @param memberInfo
	 * @throws Exception
	 */
	public void departBestStats(
			Model model,
			DataMap requestMap,
			LoginInfo memberInfo) throws Exception {
		
		DataMap listMap = null;
						
		String yearMonthFrom = requestMap.getString("yearMonthFrom");
		String yearMonthTo = requestMap.getString("yearMonthTo");
		String subjType = requestMap.getString("subjType");
		
		String key = requestMap.getString("key");	
		if (key.equals("")) {
			key = statisticsMgrService.getMaxGrSeq();
		}
		
		//if(!subjType.equals("")){
			listMap = statisticsMgrService.departBestStats(key);
		//}
		
		model.addAttribute("LIST_DATA", listMap);
		//model.addAttribute("TABMENU_DATA", tabMenuMap);
	}
	
	
	@RequestMapping(value="/statisMgr/stats.do", params="mode=departBest")
	public String departBest(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			) throws Exception{
		
		DataMap requestMap = cm.getDataMap();
		
		departBestStats(model, requestMap, cm.getLoginInfo());
		
		//return findView(requestMap.getString("mode"), "/statisticsMgr/cyberCourseStats");
		//return "/statisticsMgr/cyberCourseStats";
		return "/homepage/attend/departBest";
	}
	
	
	
	/**
	 * 신규 작업 연령별
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @param requestMap
	 * @param memberInfo
	 * @throws Exception
	 */
	public void ageBestStats(
			Model model,
			DataMap requestMap,
			LoginInfo memberInfo) throws Exception {
		
		DataMap listMap = null;
						
		String key = requestMap.getString("key");	
		if (key.equals("")) {
			key = statisticsMgrService.getMaxGrSeq();
		}
		
		listMap = statisticsMgrService.ageBestStats(key);
		
		model.addAttribute("LIST_DATA", listMap);
		//model.addAttribute("TABMENU_DATA", tabMenuMap);
	}
	
	
	@RequestMapping(value="/statisMgr/stats.do", params="mode=ageBest")
	public String agetBest(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			) throws Exception{
		
		DataMap requestMap = cm.getDataMap();
		
		ageBestStats(model, requestMap, cm.getLoginInfo());
		
		return "/homepage/attend/ageBest";
	}
	
	/**
	 * 신규 작업 연령별
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @param requestMap
	 * @param memberInfo
	 * @throws Exception
	 */
	public void genderBestStats(
			Model model,
			DataMap requestMap,
			LoginInfo memberInfo) throws Exception {
		
		DataMap listManMap = null;
		DataMap listWomanMap = null;
						
		String key = requestMap.getString("key");	
		if (key.equals("")) {
			key = statisticsMgrService.getMaxGrSeq();
		}
		
		listManMap = statisticsMgrService.genderManBestStats(key);
		listWomanMap = statisticsMgrService.genderWomanBestStats(key);
		
		model.addAttribute("LIST_MAN_DATA", listManMap);
		model.addAttribute("LIST_WOMAN_DATA", listWomanMap);
	}
	
	
	@RequestMapping(value="/statisMgr/stats.do", params="mode=genderBest")
	public String gendertBest(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			) throws Exception{
		
		DataMap requestMap = cm.getDataMap();
		
		genderBestStats(model, requestMap, cm.getLoginInfo());
		
		//return findView(requestMap.getString("mode"), "/statisticsMgr/cyberCourseStats");
		//return "/statisticsMgr/cyberCourseStats";
		return "/homepage/attend/genderBest";
	}
	
	
	@RequestMapping(value="/statisMgr/stats.do", params="mode=cyberExcel")
	public String cyberExcel(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			) throws Exception{
		
		DataMap requestMap = cm.getDataMap();
		
		cyberCourseStats(model, requestMap, cm.getLoginInfo());
		
		return findView(requestMap.getString("mode"), "/statisticsMgr/cyberCourseStatsByExcel");
	}
	
	/**
	 * 과정별 설문 통계
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @param requestMap
	 * @param memberInfo
	 * @throws Exception
	 */
	public void pollStats(
			Model model,
			DataMap requestMap,
			LoginInfo memberInfo) throws Exception {
		
		DataMap listMap = null;
		DataMap tabMenuMap = null;
		DataMap questionMap = null;
		
		/**
		 * 상단 TAB
		 */
		tabMenuMap = statisticsMgrService.tabMenu(memberInfo.getSessCurrentAuth());
		
						
		String commYear = requestMap.getString("commYear");
		String commGrcode = requestMap.getString("commGrcode");
		String commGrseq = requestMap.getString("commGrseq");
		String searchQuestion = requestMap.getString("searchQuestion");
		String searchYn = Util.getValue( requestMap.getString("searchYn"), "N");
		String searchType = Util.getValue( requestMap.getString("searchType"), "1");
		
		String sqlWhere = " AND C.GRSEQ  LIKE '" + commYear + "' || '%' ";
		
		// 검색 조건
		if(!commGrcode.equals("")){
			sqlWhere += " AND C.GRCODE = '" + commGrcode + "' ";
		}
		if(!commGrseq.equals("")){
			sqlWhere += " AND C.GRSEQ = '" + commGrseq + "' ";
		}
		if(!searchQuestion.equals("")){
			sqlWhere += " AND A.QUESTION = '" + searchQuestion + "' ";
		}
		
		
		questionMap = statisticsMgrService.pollStatsQuestion();
		
		if(searchYn.equals("Y")){
			
			listMap = statisticsMgrService.pollStats(sqlWhere, searchType);
			
		}
		
		
		model.addAttribute("LIST_DATA", listMap);
		model.addAttribute("QUESTION_DATA", questionMap);
		model.addAttribute("TABMENU_DATA", tabMenuMap);
	}
	
	@RequestMapping(value="/statisMgr/stats.do", params="mode=poll")
	public String poll(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			) throws Exception{
		
		DataMap requestMap = cm.getDataMap();
		
		pollStats(model, requestMap, cm.getLoginInfo());
		
		return findView(requestMap.getString("mode"), "/statisticsMgr/pollStats");
	}
	
	@RequestMapping(value="/statisMgr/stats.do", params="mode=pollExcel")
	public String pollExcel(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			) throws Exception{
		
		DataMap requestMap = cm.getDataMap();
		
		pollStats(model, requestMap, cm.getLoginInfo());
		
		return findView(requestMap.getString("mode"), "/statisticsMgr/pollStatsByExcel");
	}
	
	/**
	 * 접속통계
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @param requestMap
	 * @param memberInfo
	 * @throws Exception
	 */
	public void logStats(
			Model model,
			DataMap requestMap,
			LoginInfo memberInfo) throws Exception {
		
		DataMap listMap = null;
		DataMap tabMenuMap = null;
		
		
		/**
		 * 상단 TAB
		 */
		tabMenuMap = statisticsMgrService.tabMenu(memberInfo.getSessCurrentAuth());
		
						
		String ptype = Util.getValue(requestMap.getString("ptype"),"day");
		String sDate = requestMap.getString("sDate");
		String eDate = requestMap.getString("eDate");
		
		// 오늘 날짜
		Date today = new Date();
		SimpleDateFormat sdfDay;
		SimpleDateFormat sdfDay2;
		sdfDay2 = new SimpleDateFormat("yyyyMMdd");
		
		if(sDate.equals("")){
			
			if(ptype.equals("day")){
				sdfDay = new SimpleDateFormat("yyyyMM");				
				sDate = sdfDay.format(today) + "01";
				eDate = sdfDay2.format(today);
			}else{
				sdfDay = new SimpleDateFormat("yyyy");				
				sDate = sdfDay.format(today) + "01";
				eDate = sdfDay.format(today) + "12";
			}
								
			model.addAttribute("DATE_FROM", sDate);
			model.addAttribute("DATE_TO", eDate);
			
		}
		model.addAttribute("DATE_TODAY", sdfDay2.format(today));
						
		listMap = statisticsMgrService.logStats(ptype, sDate, eDate);
		
		model.addAttribute("LIST_DATA", listMap);		
		model.addAttribute("TABMENU_DATA", tabMenuMap);
	}
	
	@RequestMapping(value="/statisMgr/stats.do", params="mode=log")
	public String log(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			) throws Exception{
		
		DataMap requestMap = cm.getDataMap();
		
		logStats(model, requestMap, cm.getLoginInfo());
		
		return findView(requestMap.getString("mode"), "/statisticsMgr/logStats");
	}
	
	@RequestMapping(value="/statisMgr/stats.do", params="mode=logExcel")
	public String logExcel(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			) throws Exception{
		
		DataMap requestMap = cm.getDataMap();
		
		logStats(model, requestMap, cm.getLoginInfo());
		
		return findView(requestMap.getString("mode"), "/statisticsMgr/logStatsByExcel");
	}
	
	/**
	 * 가입회원 통계 리스트 
	 * 작성자 : 정윤철
	 * 작성일 : 8월 12일
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @param requestMap
	 * @param memberInfo
	 * @throws Exception
	 */
	public void selectAgeMemberStatsList(
			Model model,
			DataMap requestMap,
			LoginInfo memberInfo) throws Exception {
		
		DataMap listMap = null;
		DataMap educationMap = null;
		DataMap tabMenuMap = null;
		/**
		 * 상단 TAB
		 */
		tabMenuMap = statisticsMgrService.tabMenu(memberInfo.getSessCurrentAuth());
		//검색조건
		String searchType = requestMap.getString("searchType");
		
		//학력조회
		educationMap  = memberService.selectEducationalRow();
		if(searchType.equals("") || searchType.equals("month") && requestMap.getString("sDate").equals("")){
	        if(listMap == null) listMap = new DataMap();
	        listMap.setNullToInitialize(true);
	        
		}else{
			if(searchType.equals("resno")){
				listMap = statisticsMgrService.selectMemberAgeStatsList(requestMap);
				
			}else{
				listMap = statisticsMgrService.selectMemberStatsList(requestMap);
				
			}
		}
		
		model.addAttribute("LIST_DATA", listMap);
		model.addAttribute("EDUCATION_LIST_DATA", educationMap);
		model.addAttribute("TABMENU_DATA", tabMenuMap);
	}	
	
	@RequestMapping(value="/statisMgr/stats.do", params="mode=memberStats")
	public String memberStats(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			) throws Exception{
		
		DataMap requestMap = cm.getDataMap();
		
		selectAgeMemberStatsList(model, requestMap, cm.getLoginInfo());
		
		return findView(requestMap.getString("mode"), "/statisticsMgr/memberStats");
	}
	
	@RequestMapping(value="/statisMgr/stats.do", params="mode=memberStatsExcel")
	public String memberStatsExcel(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			) throws Exception{
		
		DataMap requestMap = cm.getDataMap();
		
		selectAgeMemberStatsList(model, requestMap, cm.getLoginInfo());
		
		return findView(requestMap.getString("mode"), "/statisticsMgr/memberStatsExcel");
	}
	
	@RequestMapping(value="/statisMgr/stats.do", params="mode=tutorWorkStats")
	public String tutorWorkStats(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			) throws Exception{
		
		DataMap requestMap = cm.getDataMap();
		
		DataMap listMap = null;
		DataMap tabMenuMap = null;
		/**
		 * 상단 TAB
		 */
		tabMenuMap = statisticsMgrService.tabMenu(cm.getLoginInfo().getSessCurrentAuth());
		
		if (requestMap.getString("currPage").equals("")) {
			requestMap.setInt("currPage", 1);
		}
		if (requestMap.getString("rowSize").equals("")) {
			requestMap.setInt("rowSize", 10);
		}
		if (requestMap.getString("pageSize").equals("")) {
			requestMap.setInt("pageSize", 10);
		}
		
		listMap = statisticsMgrService.selectTutorWorkStatsList(requestMap);
		
		model.addAttribute("LIST_DATA", listMap);
		model.addAttribute("TABMENU_DATA", tabMenuMap);
		
		return findView(requestMap.getString("mode"), "/statisticsMgr/tutorWorkStats");
	}
	
	@RequestMapping(value="/statisMgr/stats.do", params="mode=mobileMonth")
	public String mobileMonth(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			) throws Exception{
		
		DataMap requestMap = cm.getDataMap();
		
		model.addAttribute("mobileMemberCnt", statisticsMgrService.mobileMemberCnt());

		DataMap listMap = null;
		
		// 한페이지에서 다보여줌 (나중에 페이징요청시 rowsze, pagesize 10으로 변경)
		
		if (requestMap.getString("currPage").equals("")) {
			requestMap.setInt("currPage", 1);
		}
		if (requestMap.getString("rowSize").equals("")) {
			requestMap.setInt("rowSize", 100);
		}
		if (requestMap.getString("pageSize").equals("")) {
			requestMap.setInt("pageSize", 100);
		}
		
		listMap = statisticsMgrService.selectMobileMonthList(requestMap);
		
		model.addAttribute("LIST_DATA", listMap);
		
		return findView(requestMap.getString("mode"), "/statisticsMgr/mobileMonth");
	}
	
	@RequestMapping(value="/statisMgr/stats.do", params="mode=mobileDay")
	public String mobileDay(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			) throws Exception{
		
		DataMap requestMap = cm.getDataMap();
		
		model.addAttribute("mobileMemberCnt", statisticsMgrService.mobileMemberCnt());

		DataMap listMap = null;
		
		// 한페이지에서 다보여줌 (나중에 페이징요청시 rowsze, pagesize 10으로 변경)
		
		if (requestMap.getString("currPage").equals("")) {
			requestMap.setInt("currPage", 1);
		}
		if (requestMap.getString("rowSize").equals("")) {
			requestMap.setInt("rowSize", 100);
		}
		if (requestMap.getString("pageSize").equals("")) {
			requestMap.setInt("pageSize", 100);
		}
		
		listMap = statisticsMgrService.selectMobileDayList(requestMap);
		
		model.addAttribute("LIST_DATA", listMap);
		
		return findView(requestMap.getString("mode"), "/statisticsMgr/mobileDay");
	}
	
	public void courseRgister(
			Model model,
			DataMap requestMap,
			LoginInfo memberInfo) throws Exception {
		
		DataMap listMap = null;
		DataMap listMapTotal = null;
		DataMap tabMenuMap = null;
		
		/**
		 * 상단 TAB
		 */
		tabMenuMap = statisticsMgrService.tabMenu(memberInfo.getSessCurrentAuth());
						
		String rgrayn = requestMap.getString("rgrayn");
		String grseq = requestMap.getString("grseq");
		
		if(!"".equals(grseq)) {
			listMap = statisticsMgrService.courseRgister(rgrayn, grseq);
			listMapTotal = statisticsMgrService.courseRgisterTotal(rgrayn, grseq);
		}
		
		model.addAttribute("rgrayn", rgrayn);
		model.addAttribute("grseq", grseq);
		model.addAttribute("LIST_DATA", listMap);
		model.addAttribute("LIST_DATA_TOTAL", listMapTotal);
		model.addAttribute("TABMENU_DATA", tabMenuMap);
	}
	
	@RequestMapping(value="/statisMgr/stats.do", params="mode=courseRgister")
	public String courseRgister(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			) throws Exception{
		
		DataMap requestMap = cm.getDataMap();
		
		courseRgister(model, requestMap, cm.getLoginInfo());
		
		return findView(requestMap.getString("mode"), "/statisticsMgr/courseRgister");
	}
	
	@RequestMapping(value="/statisMgr/stats.do", params="mode=courseRgisterExcel")
	public String courseRgisterExcel(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			) throws Exception{
		
		DataMap requestMap = cm.getDataMap();
		
		courseRgister(model, requestMap, cm.getLoginInfo());
		
		return findView(requestMap.getString("mode"), "/statisticsMgr/courseRgisterExcel");
	}
	
	public void cyberDeptRgister(
			Model model,
			DataMap requestMap,
			LoginInfo memberInfo) throws Exception {
		
		DataMap listMap = null;
		DataMap listMapTotal = null;
		DataMap tabMenuMap = null;
		
		/**
		 * 상단 TAB
		 */
		tabMenuMap = statisticsMgrService.tabMenu(memberInfo.getSessCurrentAuth());
						
		String rgrayn = requestMap.getString("rgrayn");
		String grseq = requestMap.getString("grseq");
		
		if(!"".equals(grseq)) {
			listMap = statisticsMgrService.cyberDeptRgister(rgrayn, grseq);
			listMapTotal = statisticsMgrService.cyberDeptRgisterTotal(rgrayn, grseq);
		}
		
		model.addAttribute("rgrayn", rgrayn);
		model.addAttribute("grseq", grseq);
		model.addAttribute("LIST_DATA", listMap);
		model.addAttribute("LIST_DATA_TOTAL", listMapTotal);
		model.addAttribute("TABMENU_DATA", tabMenuMap);
	}
	
	@RequestMapping(value="/statisMgr/stats.do", params="mode=cyberDeptRgister")
	public String cyberDeptRgister(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			) throws Exception{
		
		DataMap requestMap = cm.getDataMap();
		
		cyberDeptRgister(model, requestMap, cm.getLoginInfo());
		
		return findView(requestMap.getString("mode"), "/statisticsMgr/cyberDeptRgister");
	}
	
	@RequestMapping(value="/statisMgr/stats.do", params="mode=cyberDeptRgisterExcel")
	public String cyberDeptRgisterExcel(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			) throws Exception{
		
		DataMap requestMap = cm.getDataMap();
		
		cyberDeptRgister(model, requestMap, cm.getLoginInfo());
		
		return findView(requestMap.getString("mode"), "/statisticsMgr/cyberDeptRgisterExcel");
	}
	
	public void cyberDetailDeptRgister(
			Model model,
			DataMap requestMap,
			LoginInfo memberInfo) throws Exception {
		
		DataMap listMap = null;
		DataMap listMapTotal = null;
		DataMap tabMenuMap = null;
		
		/**
		 * 상단 TAB
		 */
		tabMenuMap = statisticsMgrService.tabMenu(memberInfo.getSessCurrentAuth());
						
		String rgrayn = requestMap.getString("rgrayn");
		String grseq = requestMap.getString("grseq");
		
		if(!"".equals(grseq)) {
			listMap = statisticsMgrService.cyberDetailDeptRgister(rgrayn, grseq);
			listMapTotal = statisticsMgrService.cyberDetailDeptRgisterTotal(rgrayn, grseq);
		}
		
		model.addAttribute("rgrayn", rgrayn);
		model.addAttribute("grseq", grseq);
		model.addAttribute("LIST_DATA", listMap);
		model.addAttribute("LIST_DATA_TOTAL", listMapTotal);
		model.addAttribute("TABMENU_DATA", tabMenuMap);
	}
	
	@RequestMapping(value="/statisMgr/stats.do", params="mode=cyberDetailDeptRgister")
	public String cyberDetailDeptRgister(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			) throws Exception{
		
		DataMap requestMap = cm.getDataMap();
		
		cyberDetailDeptRgister(model, requestMap, cm.getLoginInfo());
		
		return findView(requestMap.getString("mode"), "/statisticsMgr/cyberDetailDeptRgister");
	}
	
	@RequestMapping(value="/statisMgr/stats.do", params="mode=cyberDetailDeptRgisterExcel")
	public String cyberDetailDeptRgisterExcel(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			) throws Exception{
		
		DataMap requestMap = cm.getDataMap();
		
		cyberDetailDeptRgister(model, requestMap, cm.getLoginInfo());
		
		return findView(requestMap.getString("mode"), "/statisticsMgr/cyberDetailDeptRgisterExcel");
	}
	
	public void cyberGrseqInfo(
			Model model,
			DataMap requestMap,
			LoginInfo memberInfo) throws Exception {
		
		DataMap listMap = null;
		DataMap listMapTotal = null;
		DataMap tabMenuMap = null;
		
		/**
		 * 상단 TAB
		 */
		tabMenuMap = statisticsMgrService.tabMenu(memberInfo.getSessCurrentAuth());
						
		String grseq = requestMap.getString("grseq");
		
		if(!"".equals(grseq)) {
			listMap = statisticsMgrService.cyberGrseqInfo(grseq);
			listMapTotal = statisticsMgrService.cyberGrseqInfoTotal(grseq);
		}
		
		model.addAttribute("grseq", grseq);
		model.addAttribute("LIST_DATA", listMap);
		model.addAttribute("LIST_DATA_TOTAL", listMapTotal);
		model.addAttribute("TABMENU_DATA", tabMenuMap);
	}	
	
	@RequestMapping(value="/statisMgr/stats.do", params="mode=cyberGrseqInfo")
	public String cyberGrseqInfo(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			) throws Exception{
		
		DataMap requestMap = cm.getDataMap();
		
		cyberGrseqInfo(model, requestMap, cm.getLoginInfo());
		
		return findView(requestMap.getString("mode"), "/statisticsMgr/cyberGrseqInfo");
	}
	
	@RequestMapping(value="/statisMgr/stats.do", params="mode=cyberGrseqInfoExcel")
	public String cyberGrseqInfoExcel(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			) throws Exception{
		
		DataMap requestMap = cm.getDataMap();
		
		cyberGrseqInfo(model, requestMap, cm.getLoginInfo());
		
		return findView(requestMap.getString("mode"), "/statisticsMgr/cyberGrseqInfoExcel");
	}
	
	public void cyberDeptInfo(
			Model model,
			DataMap requestMap,
			LoginInfo memberInfo) throws Exception {
		
		DataMap listMap = null;
		DataMap listMapTotal = null;
		DataMap tabMenuMap = null;
		
		/**
		 * 상단 TAB
		 */
		tabMenuMap = statisticsMgrService.tabMenu(memberInfo.getSessCurrentAuth());
						
		String grseq = requestMap.getString("grseq");
		
		if(!"".equals(grseq)) {
			listMap = statisticsMgrService.cyberDeptInfo(grseq);
			listMapTotal = statisticsMgrService.cyberDeptInfoTotal(grseq);
		}
		
		model.addAttribute("grseq", grseq);
		model.addAttribute("LIST_DATA", listMap);
		model.addAttribute("LIST_DATA_TOTAL", listMapTotal);
		model.addAttribute("TABMENU_DATA", tabMenuMap);
	}	
	
	@RequestMapping(value="/statisMgr/stats.do", params="mode=cyberDeptInfo")
	public String cyberDeptInfo(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			) throws Exception{
		
		DataMap requestMap = cm.getDataMap();
		
		cyberDeptInfo(model, requestMap, cm.getLoginInfo());
		
		return findView(requestMap.getString("mode"), "/statisticsMgr/cyberDeptInfo");
	}
	
	@RequestMapping(value="/statisMgr/stats.do", params="mode=cyberDeptInfoExcel")
	public String cyberDeptInfoExcel(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			) throws Exception{
		
		DataMap requestMap = cm.getDataMap();
		
		cyberDeptInfo(model, requestMap, cm.getLoginInfo());
		
		return findView(requestMap.getString("mode"), "/statisticsMgr/cyberDeptInfoExcel");
	}
	
	@RequestMapping(value="/statisMgr/stats.do", params="mode=language")
	public String language(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			) throws Exception{
		
		DataMap requestMap = cm.getDataMap();
		
		//courseList(model, requestMap, cm.getLoginInfo());
		
		//return findView(requestMap.getString("mode"), "/statisticsMgr/courseStats");
		return "/homepage/attend/languageStats";
	}
	
	@RequestMapping(value="/statisMgr/stats.do", params="mode=2015")
	public String lastYear(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			) throws Exception{
		
		return "/homepage/attend/LastYearList";
	}
	
	@RequestMapping(value="/statisMgr/stats.do", params="mode=2016")
	public String yearof2016(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			) throws Exception{
		
		return "/homepage/attend/yearof2016";
	}
	
	
	/**
	 * 신규 작업
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @param requestMap
	 * @param memberInfo
	 * @throws Exception
	 */
	public void tierBestStats(
			Model model,
			DataMap requestMap,
			LoginInfo memberInfo) throws Exception {
		
		DataMap listMap = null;
		
		String key = requestMap.getString("key");	
		if (key.equals("")) {
			key = statisticsMgrService.getMaxGrSeq();
		}
		
		//if(!subjType.equals("")){
			listMap = statisticsMgrService.tierBestStats(key);
		//}
		
		model.addAttribute("LIST_DATA", listMap);
	}
	
	
	@RequestMapping(value="/statisMgr/stats.do", params="mode=tierBest")
	public String tierBest(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			) throws Exception{
		
		DataMap requestMap = cm.getDataMap();
		
		tierBestStats(model, requestMap, cm.getLoginInfo());
		
		//return findView(requestMap.getString("mode"), "/statisticsMgr/cyberCourseStats");
		//return "/statisticsMgr/cyberCourseStats";
		return "/homepage/attend/tierBest";
	}
	
	
	
}
