package loti.tutorMgr.web;

import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import loti.tutorMgr.service.StatisticsService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import ut.lib.login.LoginCheck;
import ut.lib.login.LoginInfo;
import ut.lib.support.CommonMap;
import ut.lib.support.DataMap;
import ut.lib.util.DateUtil;
import ut.lib.util.Util;

import common.controller.BaseController;

@Controller
public class StatisticsController extends BaseController {

	@Autowired
	private StatisticsService statisticsService;
	
	@ModelAttribute("cm")
	public CommonMap common(
				CommonMap cm
				, HttpServletRequest request
				, HttpServletResponse response
				, Model model
			) throws Exception{
		
		// 리퀘스트 받기
		DataMap requestMap = cm.getDataMap();
		requestMap.setNullToInitialize(true);
		
		// default mode
		String mode = Util.getValue(requestMap.getString("mode"));		
		
		//관리자 로그인 체크
		LoginInfo memberInfo = null;
		
		
		if( mode.equals("excel") ){
			memberInfo = LoginCheck.adminCheckPopup(request, response);
		}else{
			memberInfo = LoginCheck.adminCheck(request, response, requestMap.getString("menuId") );
		}
		
					
		if (memberInfo == null){			
			return null;
		}
		
		// 리퀘스트 정보를 담고있는 DataMap을 Attribute 에 추가
		request.setAttribute("REQUEST_DATA", requestMap);
		
		return cm;
	}
	
	public String findView(String mode, String view){
		return view;
	}
	
	/**
	 * 강사활용실적
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @param requestMap
	 * @throws Exception
	 */
	public void salaryStatsList(
			Model model
			, DataMap requestMap) throws Exception {
		
		
		DataMap listMap = null;
		
		String sType = Util.getValue(requestMap.getString("sType"),"1");
		String yearMonthFrom = requestMap.getString("yearMonthFrom");
		String yearMonthTo = requestMap.getString("yearMonthTo");
		
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
		
		
		listMap = statisticsService.salaryStatsList(sType, yearMonthFrom, yearMonthTo);
				
		model.addAttribute("LIST_DATA", listMap);
		
	}
	
	@RequestMapping(value="/tutorMgr/stati.do", params="mode=list")
	public String list(
				@ModelAttribute("cm") CommonMap cm
				, Model model
			) throws Exception{
		
		salaryStatsList(model, cm.getDataMap());
		
		return findView(cm.getDataMap().getString("mode"), "/tutorMgr/statistics/salaryStatsList");
	}
	
	@RequestMapping(value="/tutorMgr/stati.do", params="mode=excel")
	public String excel(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			) throws Exception{
		
		salaryStatsList(model, cm.getDataMap());
		
		return findView(cm.getDataMap().getString("mode"), "/tutorMgr/statistics/salaryStatsListByExcel");
	}
	
	/**
	 * 강사등급별실적
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @param requestMap
	 * @throws Exception
	 */
	public void tutorGradeStats(
			Model model
			, DataMap requestMap) throws Exception {
		
		DataMap listMap = null;
		
		String sDate = requestMap.getString("sDate");
		String eDate = requestMap.getString("eDate");
		
		if( !sDate.equals("") && !eDate.equals("") ){
		
			listMap = statisticsService.tutorGradeStats(requestMap);
		}
				
		model.addAttribute("LIST_DATA", listMap);
		
	}
	
	@RequestMapping(value="/tutorMgr/stati.do", params="mode=tlevel")
	public String tlevel(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			) throws Exception{
		
		tutorGradeStats(model, cm.getDataMap());
		
		return findView(cm.getDataMap().getString("mode"), "/tutorMgr/statistics/gradeStats");
	}
	
	public void tutorMemberList(
			Model model
			, DataMap requestMap) throws Exception {
		
		DataMap listMap = null;
		
		requestMap.setNullToInitialize(true);
		
		String year = requestMap.getString("year");
		
		int getYear = DateUtil.getYear();
		if("".equals(year)) {
			year = String.valueOf(getYear);
		}
		
		int startDate = 2003; // 최조  데이타 
		int endDate = (getYear+3);
		
		listMap = statisticsService.tutorMemberList(year);

		requestMap.setInt("startDate", startDate);
		requestMap.setInt("endDate", endDate);
		requestMap.setInt("year", Integer.valueOf(year));
		model.addAttribute("LIST_DATA", listMap);
	}
	
	@RequestMapping(value="/tutorMgr/stati.do", params="mode=tutorMemberList")
	public String tutorMemberList(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			) throws Exception{
		
		tutorMemberList(model, cm.getDataMap());
		
		return findView(cm.getDataMap().getString("mode"), "/tutorMgr/statistics/tutorMemberList");
	}
	
	@RequestMapping(value="/tutorMgr/stati.do", params="mode=tutorMemberListExcel")
	public String tutorMemberListExcel(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			) throws Exception{
		
		tutorMemberList(model, cm.getDataMap());
		
		return findView(cm.getDataMap().getString("mode"), "/tutorMgr/statistics/tutorMemberListExcel");
	}
}
