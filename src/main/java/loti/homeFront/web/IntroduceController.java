package loti.homeFront.web;

import java.net.URLDecoder;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import loti.common.service.CommonService;
import loti.courseMgr.service.MailService;
import loti.courseMgr.service.ReservationService;
import loti.homeFront.service.HtmlService;
import loti.homeFront.service.IndexService;
import loti.homeFront.service.IntroduceService;
import loti.homeFront.service.SupportService;
import loti.login.service.LoginService;
import loti.poll.service.CoursePollService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import ut.lib.exception.BizException;
import ut.lib.login.LoginInfo;
import ut.lib.support.CommonMap;
import ut.lib.support.DataMap;
import ut.lib.util.DateUtil;
import ut.lib.util.Util;
import common.controller.BaseController;


@Controller
public class IntroduceController extends BaseController{

	@Autowired
	private ReservationService reservationService;
	
	@Autowired
	private HtmlService htmlService;
	
	@Autowired
	private IntroduceService introduceService;
	
	@Autowired
	private IndexService indexService;
	
	@Autowired
	private MailService mailService;
	
	@Autowired
	private SupportService supportService;
	
	@Autowired
	private CommonService commonService;
	
	@Autowired
	private CoursePollService coursePollService;
	
	@Autowired
	private LoginService loginService;
	
	@ModelAttribute("cm")
	public CommonMap common(
					CommonMap cm
					, Model model
					, HttpServletRequest request
					, @RequestParam(value="mode", required=false, defaultValue="") String mode
			) throws BizException {
		
		/**
		 * 로그인 체크
		 */
		LoginInfo loginInfo = (LoginInfo)request.getAttribute("LOGIN_INFO");
		if(loginInfo.isLogin() == false){
			// 로그인 안되어 있음
			log.info("로그인 안되어 있음");
		}

		// 리퀘스트 정보를 담고있는 DataMap을 Attribute 에 추가
		model.addAttribute("REQUEST_DATA", cm.getDataMap());
		model.addAttribute("LOGIN_INFO", loginInfo);
		
		// ui 공휴일 목록을 리턴 한다.
//		holydayUiList(mapping, form, request, response, requestMap);
		
		cm.getDataMap().setString("pre_year", reservationService.getYear());
		cm.getDataMap().setString("pre_month", reservationService.getMonth());
		
		model.addAttribute("HOLYDAYUILIST_DATA", reservationService.selectHolyDayUiList(cm.getDataMap()));
		
//		saveChack(mapping, form, request, response, requestMap);
		
		int year		= Integer.parseInt(reservationService.getYear());
		int month		= (Integer.parseInt(reservationService.getMonth())-1);
		Calendar cal	= Calendar.getInstance();
		cal.set(year, month, 1);
		
		String timer = reservationService.getYear() + reservationService.getMonth() + reservationService.getDay();
		String today = reservationService.getCurrentdate();
		if("01".equals(reservationService.getDay())) {
			model.addAttribute("saveCheck", "0");
			model.addAttribute("istimer", "1");
		} else {
			int count = reservationService.saveCheck();
			if(count > 0) { 
				model.addAttribute("saveCheck", "1");
			} else {
				model.addAttribute("saveCheck", "0");
			}
			int count2 = reservationService.getDayCheck();
	
			if(count2 > 0) { 
				model.addAttribute("istimer", "1");
			} else {
				model.addAttribute("istimer", "0");
			}
		}
		model.addAttribute("timer", timer + "085700"); //서버 시간이 3분 늦음  9시로 설정 ( 서버 시간 동기화가 안됨 프로그램에서 해결)
		model.addAttribute("today", today);
		
		return cm;
	}
	
	public String findView(HttpSession session, String mode, String view){
		
		if("duplicatereservation".equals(mode)){
			return "/homepage/eduInfo/tempalert";
		}else if("alreadyExist".equals(mode)){
			return "/homepage/eduInfo/tempalert";
		}
		
		// 테스터들은 예외로....
		String sess_no = (String)session.getAttribute("sess_no");
		if("resvReject".equals(mode) || "resvRejectPop".equals(mode)) {
			if("B000000003003".equals(sess_no) || "B000000000770".equals(sess_no) || "A000000005805".equals(sess_no)) {
				return "/homepage/eduInfo/tempalert";
			}else{
				return view;
			}
		}else{
			return view;
		}
		
		
	}
	
	public void htmlTemplete(DataMap dataMap, Model model) throws BizException{
		String htmlId = dataMap.getString("htmlId");		
		DataMap listMap = null;		
		listMap = htmlService.htmlTemplete(htmlId);
		model.addAttribute("HTML_DATA", listMap);
	}
	
	@RequestMapping(value="/homepage/introduce.do", params="mode=eduinfo7-1")
	public String eduinfo71(
				@ModelAttribute("cm") CommonMap cm
				, Model model
				, @RequestParam("mode") String mode
			) throws BizException{
		htmlTemplete(cm.getDataMap(), model);
		return findView(cm.getSession(), mode, "/homepage/eduInfo/eduinfo7-1");
	}
	
	@RequestMapping(value="/homepage/introduce.do", params="mode=eduinfo7-2")
	public String eduinfo72(@ModelAttribute("cm") CommonMap cm, Model model) throws BizException{
		htmlTemplete(cm.getDataMap(), model);
		return "/homepage/eduInfo/eduinfo7-2";
	}
	
	@RequestMapping(value="/homepage/introduce.do", params="mode=eduinfo7-3")
	public String eduinfo73(@ModelAttribute("cm") CommonMap cm, Model model) throws BizException{
		// 조직및업무
		model.addAttribute("TEAM_LIST", introduceService.getTeamList());
		
		return "/homepage/eduInfo/eduinfo7-3";
	}
	
	@RequestMapping(value="/homepage/introduce.do", params="mode=eduinfo7-4")
	public String eduinfo74(
				@ModelAttribute("cm") CommonMap cm
				, Model model
				, @RequestParam(value="weekcount", required=false, defaultValue="0") int weekCount
			) throws BizException{
		
		model.addAttribute("EAT_LIST_1",indexService.getEatList("1",weekCount));
		model.addAttribute("EAT_LIST_2",indexService.getEatList("2",weekCount));
		model.addAttribute("EAT_LIST_3",indexService.getEatList("3",weekCount));
		
		model.addAttribute("weekcount", String.valueOf(weekCount));
		
		return "/homepage/eduInfo/eduinfo7-4";
	}
	
	@RequestMapping(value="/homepage/introduce.do", params="mode=eduinfo7-6")
	public String eduinfo76(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			) throws BizException{
		
		// 시설현황
		htmlTemplete(cm.getDataMap(), model);	
		
		return "/homepage/eduInfo/eduinfo7-6";
	}
	
	@RequestMapping(value="/homepage/introduce.do", params="mode=eduinfo7-6-2")
	public String eduinfo762() throws BizException{
		
		return "/homepage/eduInfo/eduinfo7-6-2";
	}
	
	@RequestMapping(value="/homepage/introduce.do", params="mode=eduinfo7-6-3")
	public String eduinfo763() throws BizException{
		
		return "/homepage/eduInfo/eduinfo7-6-3";
	}
	
	@RequestMapping(value="/homepage/introduce.do", params="mode=eduinfo7-6-4")
	public String eduinfo764() throws BizException{
		
		return "/homepage/eduInfo/eduinfo7-6-4";
	}
	
	@RequestMapping(value="/homepage/introduce.do", params="mode=eduinfo7-7")
	public String eduinfo77() throws BizException{
		
		return "/homepage/eduInfo/eduinfo7-7";
	}
	
	@RequestMapping(value="/homepage/introduce.do", params="mode=eduinfo7-8")
	public String eduinfo78(@ModelAttribute("cm") CommonMap cm, Model model) throws BizException{
		
		// 동영상소개
		htmlTemplete(cm.getDataMap(), model);
		String mediaFile = "";
		String movieType = Util.getValue(cm.getDataMap().getString("movieType"));
		if("1".equals(movieType)) {
			mediaFile = "인재개발원_영문_2014.avi";
		} else if("2".equals(movieType)) {
			mediaFile = "인재개발원_일문_2014.avi";
		} else if("3".equals(movieType)) {
			mediaFile = "인재개발원_중문_2014.avi";
		} else {
			mediaFile = "인재개발원_국문_2014.avi";
			movieType = "4";
		}
		model.addAttribute("movieType", movieType);
		model.addAttribute("mediaFile", mediaFile);
		
		return "/homepage/eduInfo/eduinfo7-8";
	}
	
	@RequestMapping(value="/homepage/introduce.do", params="mode=teamfindbyname")
	public String teamfindbyname(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			, @RequestParam(value="name", required=false, defaultValue="null") String name) throws BizException{
		
		model.addAttribute("TEAM_LIST_BY_NAME", introduceService.getTeamListByName(name));		
		
		return "/homepage/eduInfo/teamfindbynameAJAX";
	}
	
	@RequestMapping(value="/homepage/introduce.do", params="mode=teamfindbywork")
	public String teamfindbywork(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			, @RequestParam(value="work", required=false, defaultValue="null") String work) throws BizException{
		
		model.addAttribute("TEAM_LIST_BY_WORK", introduceService.getTeamListByWork(work));	
		
		return "/homepage/eduInfo/teamfindbyworkAJAX";
	}
	
	@RequestMapping(value="/homepage/introduce.do", params="mode=reservationform")
	public String reservationform(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			, @RequestParam(value="mode", required=false) String mode
			, @RequestParam(value="year", required=false, defaultValue="") String year
			, @RequestParam(value="month", required=false, defaultValue="") String month
			, @RequestParam(value="day", required=false, defaultValue="") String day
			, @RequestParam(value="place", required=false, defaultValue="0") String place
			, @RequestParam(value="gubun", required=false, defaultValue="") String gubun
			) throws BizException{
		
		model.addAttribute("year", year);
		model.addAttribute("month", month);
		model.addAttribute("day", day);
		model.addAttribute("gubun", gubun);
		model.addAttribute("place", place);
		
		// 예약 중복체크
		if(month.length() == 1)	month = "0" + month;
		if(day.length() == 1)	day   = "0" + day;
		
		String resv_day	 = year + month + day;
		
		//예약 중복체크
		int cntExist = introduceService.existAlreadyReservation(resv_day, place, gubun);
		if("6".equals(place) || "7".equals(place) || "1".equals(place)) {
		} else {
			if(cntExist > 0)	mode = "alreadyExist";
		}
		
		//시설임대신청 메뉴 사용여부
		DataMap resultMap = reservationService.getResvUse2("0".equals(place) ? "GROUND":"TENNIS");
		
		if(Util.nvl(resultMap.get("useYn")).equals("N")) {
			mode 	= "resvReject";
		}
		
		model.addAttribute("mode", mode);
		//request.setAttribute("RESV_USEYN", resultMap);
		
		return findView(cm.getSession(), mode, "/homepage/eduInfo/reservationform");
		
	}
	
	@RequestMapping(value="/homepage/introduce.do", params="mode=reservation")
	public String reservation(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			, @RequestParam(value="mode") String mode
			, @RequestParam(value="year", required=false) Integer yearP
			, @RequestParam(value="month", required=false) Integer monthP
			, @RequestParam(value="place", required=false, defaultValue="0") String place
			) throws Exception{
		
		DataMap requestMap = cm.getDataMap();
		
		Calendar cal = Calendar.getInstance();
		
		int year	= Integer.parseInt(reservationService.getYear());
		int month	= Integer.parseInt(reservationService.getMonth());
		int day	= Integer.parseInt(reservationService.getDay());
		
		model.addAttribute("year", year);
		model.addAttribute("month", month);
		model.addAttribute("day", day);
		
		if(yearP != null && monthP != null) {
			year = yearP;
			month = monthP;
		}
		
		cal.set(year, month, 1); 

		String setYear	= String.valueOf(year);
		String setMonth	= "";
		
		if(month < 10) {
			setMonth = "0" + String.valueOf(month);
		} else {
			setMonth = String.valueOf(month);
		}
		model.addAttribute("RESERVATION_LIST", introduceService.getReservationList(setYear + setMonth, place));
		
		DataMap resultMap = reservationService.getResvUse();
		
		if(resultMap.size() > 0) {
			
			int yCount = 0;	//사용중인 메뉴의 갯수를 카운트하는 변수.
			for(int i=0; i < resultMap.keySize("menucd"); i++) {
				if("Y".equals(resultMap.getString("useYn", i))) {
					yCount++;
				}
			}
			
			//사용중인 메뉴가 없다면 예약불가
			if(yCount == 0) {
				mode    = "resvReject";
			}
		}
		
		requestMap.setString("yyyy", setYear);
		requestMap.setString("mm", String.valueOf(month));
		requestMap.setString("price", place);
		
		model.addAttribute("yyyy", requestMap.getString("yyyy"));
		model.addAttribute("mm", requestMap.getString("mm"));
		model.addAttribute("SAVEMGRYNLIST", reservationService.SaveMgrYnList(requestMap));
		
		
		model.addAttribute("MENU_USEYN", resultMap);	//메뉴코드, 메뉴사용여부
		model.addAttribute("mode", mode);
		
		model.addAttribute("MENU_USEYN", resultMap);	//메뉴코드, 메뉴사용여부
		model.addAttribute("mode", mode);
		
		return findView(cm.getSession(), mode, "/homepage/eduInfo/reservation1");
	}
	
	@RequestMapping(value="/homepage/introduce.do", params="mode=reservationaction")
	public String reservationaction(@ModelAttribute("cm") CommonMap cm
			, Model model
			, HttpServletRequest request
			, @RequestParam(value="mode") String mode
			) throws BizException{
		
		//대여장소 (잔디구장:0, 테니스장:1)
		String place="";
		if(request.getParameter("place")==null) place = "0";
		else place = request.getParameter("place");
		
		//예약일 관련 세팅
		String setDay 		= request.getParameter("day");
		String setMonth 	= request.getParameter("month");

		if(setDay.length() == 1)	setDay   = "0" + setDay;
		if(setMonth.length() == 1) 	setMonth = "0" + setMonth;
		
		//파라미터
		String resv_day 	= request.getParameter("year") + setMonth + setDay;
		String gubun 		= request.getParameter("gubun");
		String groupname	= request.getParameter("groupname");
		String resvname		= request.getParameter("resvname");
		String content		= request.getParameter("content");
		String homeaddr		= request.getParameter("homeAddr");
		String person		= request.getParameter("person");
		String sum			= request.getParameter("sum");		// 사용요금 합계
		String jumin		= request.getParameter("jumin1")+request.getParameter("jumin2");
		String tel			= request.getParameter("tel1")+"-"+request.getParameter("tel2")+"-"+request.getParameter("tel3");
		String room50		= request.getParameter("room50");
		String room100		= request.getParameter("room100");
		String starttime	= request.getParameter("starttime");
		String endtime		= request.getParameter("endtime");
		String sexm			= request.getParameter("sexm");
		String sexf			= request.getParameter("sexf");
		String startdate	= request.getParameter("startdate");
		String enddate		= request.getParameter("enddate");
		
		
		//String setprice		= request.getParameter("setprice");
		
		//ReservationSV rsv = new ReservationSV();
		
		//예약 중복체크
		int alreadyExist = introduceService.existAlreadyReservation(resv_day, request.getParameter("place"), request.getParameter("gubun"));
		int duplication	 = introduceService.getDuplicateReservationCount(jumin, resv_day);
		
		
		if("6".equals(request.getParameter("place")) || "7".equals(request.getParameter("place")) || "1".equals(request.getParameter("place")) ) {
			alreadyExist = 0;
		}
		
		//한 사람이 월 1회만 신청 가능.
		//같은 날, 동일한 시간대에(오전, 오후, 종일) 한 건의 신청만 받음.
		if( duplication <= 0 && alreadyExist <= 0) {	
			request.setAttribute("resvname", resvname);
			int result = introduceService.setReservation(resvname,  homeaddr, tel, jumin, resv_day, content , person,  groupname,  place , gubun, sum, room50, room100, starttime, endtime, sexm, sexf, startdate, enddate);
			
			// SMS 발송을 위한 신청정보
			model.addAttribute("resvname", resvname);
			model.addAttribute("place", place);
			model.addAttribute("gubun", gubun);
			model.addAttribute("resv_day", resv_day);
			
		} else {
			if(alreadyExist > 0)	mode = "alreadyExist";
			if(duplication > 0)		mode = "duplicatereservation"; // find forward ... struts에 설정해 놓음.
		}
		
		//시설임대신청 메뉴 사용여부
		DataMap resultMap = reservationService.getResvUse2("0".equals(place) ? "GROUND":"TENNIS");
		
		if("N".equals(resultMap.get("useYn"))) {
			mode 	= "resvReject";
		}
		request.setAttribute("mode", mode);
		
		return findView(cm.getSession(), mode, "/homepage/eduInfo/reservationresult");
	}
	
	@RequestMapping(value="/homepage/introduce.do", params="mode=reservationConfirm")
	public String reservationConfirm(@ModelAttribute("cm") CommonMap cm
			, Model model
			, HttpServletRequest request
			, @RequestParam(value="mode") String mode
			) throws BizException{
		
		try {
			String name = URLDecoder.decode(request.getParameter("name"), "UTF-8");
			String jumin1 = request.getParameter("jumin1");
			String jumin2 = request.getParameter("jumin2");
		
			request.setAttribute("name", name);
			request.setAttribute("jumin1", jumin1);
			request.setAttribute("jumin2", jumin2);
			request.setAttribute("RESERVATION_LIST" , introduceService.getReservationConfirm(name,jumin1,jumin2) );
		} catch(Exception e) {
		}
		
		return "/homepage/eduInfo/reservationconfirm";
	}
	
	@RequestMapping(value="/homepage/introduce.do", params="mode=reservationConfirmAjaxAction")
	public String reservationConfirmAjaxAction(
				@ModelAttribute("cm") CommonMap cm
				, HttpServletRequest request
				, @RequestParam(value="name", required=false, defaultValue="") String name
				, @RequestParam(value="jumin1", required=false, defaultValue="") String jumin1
				, @RequestParam(value="jumin2", required=false, defaultValue="") String jumin2
			)throws Exception{
		
		//String revDate = request.getParameter("revDate");
		
		//DataMap listmap=sv.getReservationConfirm(name,jumin1,jumin2,revDate);
		DataMap listmap=introduceService.getReservationConfirm(name,jumin1,jumin2);
		
		if(listmap == null){
			request.setAttribute("result","notExist");
		}else{
			for(int i=0;i<listmap.size();i++){
				String result=listmap.get("taAgreement")+"";
				if(result.equals("N")){
					request.setAttribute("result","notRecog");
				}else if(result.equals("Y")){
					request.setAttribute("result","recog");
				}
			}
		}	
		
		return "/homepage/eduInfo/reservationconfirmAjaxAction";
	}
	
	@RequestMapping(value="/homepage/introduce.do", params="mode=reservationConfirmAction")
	public String reservationConfirmAction(
			@ModelAttribute("cm") CommonMap cm
			, HttpServletRequest request
			, @RequestParam(value="name", required=false, defaultValue="") String name
			, @RequestParam(value="jumin1", required=false, defaultValue="") String jumin1
			, @RequestParam(value="jumin2", required=false, defaultValue="") String jumin2
			)throws Exception{
		
		name = URLDecoder.decode(name, "UTF-8");
		//String revDate = request.getParameter("revDate");
		
		//request.setAttribute("RESERVATION_CONFIRM_LIST" , sv.getReservationConfirm(name,jumin1,jumin2,revDate) );
		request.setAttribute("RESERVATION_CONFIRM_LIST" , introduceService.getReservationConfirm(name,jumin1,jumin2) );		
		
		return "/homepage/eduInfo/reservationconfirmResult";
	}
	
	@RequestMapping(value="/homepage/introduce.do", params="mode=reservationInfoPop")
	public String reservationInfoPop(
			@ModelAttribute("cm") CommonMap cm
			, HttpServletRequest request
			, @RequestParam("mode") String mode
			)throws Exception{
		
		String year 	= "";
		String month 	= "";
		String day 		= "";
		String place="";
		if(request.getParameter("place") == null)	place="0";
		else	place=request.getParameter("place");
		if(request.getParameter("year") != null) year = request.getParameter("year");
		if(request.getParameter("month") != null) month = request.getParameter("month");
		if(request.getParameter("day") != null) day = request.getParameter("day");
		
		request.setAttribute("year", request.getParameter("year"));
		request.setAttribute("month", request.getParameter("month"));
		request.setAttribute("day", request.getParameter("day"));
		request.setAttribute("gubun", request.getParameter("gubun"));
		request.setAttribute("place", request.getParameter("place"));
		
		
		if(month.length() == 1)	month = "0" + month;
		if(day.length() == 1)	day   = "0" + day;
		String resv_day	 = request.getParameter("year") + month + day;
		
		//예약 중복체크
		int cntExist = introduceService.existAlreadyReservation(resv_day, request.getParameter("place"), request.getParameter("gubun"));
		
		if("6".equals(place) || "7".equals(place) || "1".equals(place)) {
		} else {
			if(cntExist > 0)	mode = "alreadyExistPop";
		}
		
		//시설임대신청 메뉴 사용여부
		DataMap resultMap = reservationService.getResvUse2("0".equals(place) ? "GROUND":"TENNIS");
		
		if(resultMap.get("useYn").equals("N")) {
			mode 	= "resvRejectPop";
		}
		
		request.setAttribute("mode", mode);		
		
		return findView(cm.getSession(), mode, "/homepage/eduInfo/reservationInfoPop");
	}
	
	@RequestMapping(value="/homepage/introduce.do", params="mode=reservationSurvey")
	public String reservationSurvey(
			@ModelAttribute("cm") CommonMap cm
			, HttpServletRequest request
			, @RequestParam("mode") String mode
			)throws Exception{
		
		String timer = reservationService.getYear() +"-"+ reservationService.getMonth() +"-"+ reservationService.getDay();
		
		request.setAttribute("ftoday",	timer );	
		
		return findView(cm.getSession(), mode, "/homepage/eduInfo/reservationSurvey");
	}
	
	@RequestMapping(value="/homepage/introduce.do", params="mode=cancelReservation")
	public String cancelReservation(
			@ModelAttribute("cm") CommonMap cm
			, HttpServletRequest request
			, @RequestParam("mode") String mode
			)throws Exception{
		
		String day = request.getParameter("day");
		String section = request.getParameter("section");
		String place = request.getParameter("place");
//		ReservationSV sv = new ReservationSV();
		//sv.setReservation(day,section,place,"4");
		
		return findView(cm.getSession(), mode, "/homepage/eduInfo/reservationconfirm");
	}
	
	@RequestMapping(value="/homepage/introduce.do", params="mode=sms_rsv_action")
	public String sms_rsv_action(
			@ModelAttribute("cm") CommonMap cm
			, HttpServletRequest request
			, HttpServletResponse response
			, @RequestParam("mode") String mode
			)throws Exception{
		
		cm.getDataMap().setNullToInitialize(true);
		
		//시설대여신청 정보
		String resvname = cm.getDataMap().getString("resvname");
		String place = cm.getDataMap().getString("place");

		//신청한 시설이름 설정
		if("0".equals(place))		place = "잔디구장";
		else if("1".equals(place))	place = "테니스장";
		
		// SMS 내용 설정
		String txtMessage = resvname + "님으로부터 "+place+" 신청이 접수 되었습니다 [인천인재개발원]"; 
		cm.getDataMap().setString("txtMessage", txtMessage);
		cm.getDataMap().setString("callback", "032-440-7632");	//회신 번호 - 서무과 송기주 주사(2009.04.10 현재)
		mailService.insertSmsMsgReservationAction(cm.getDataMap());
		
		return "redirect:/homepage/introduce.do?mode=reservation";
	}
	
	public void boardList(
			Model model,
	          DataMap requestMap,
	          String tableName) throws Exception {
				
		DataMap listMap = null;
		
		/**
		 * 페이징 필수
		 */
		// 페이지
		if (requestMap.getString("currPage").equals("")){
			requestMap.setInt("currPage", 1);
		}
		// 페이지당 보여줄 갯수
		if (requestMap.getString("rowSize").equals("")){
			requestMap.setInt("rowSize", 10); 
		}
		// 페이지 블럭 갯수
		if (requestMap.getString("pageSize").equals("")){
			requestMap.setInt("pageSize", 10);
		}
		
		// 리스트 가져오기
		
		requestMap.setString("key",commonService.keywordFilter(requestMap.getString("key")));
		requestMap.setString("search",commonService.keywordFilter(requestMap.getString("search")));
		
		listMap = supportService.boardList(tableName, requestMap);
		model.addAttribute("LIST_DATA", listMap);
		
	}
	
	@RequestMapping(value="/homepage/introduce.do", params="mode=lawsList")
	public String lawsList(
			@ModelAttribute("cm") CommonMap cm
			, HttpServletRequest request
			, @RequestParam("mode") String mode
			, Model model
			)throws Exception{
		
		boardList(model, cm.getDataMap(), "TB_BOARD_LAWS");
		
		return findView(cm.getSession(), mode, "/homepage/bbs/lawsList");
	}
	
	/**
	 * 게시판 뷰
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @param requestMap
	 * @param strKind
	 * @throws Exception
	 */
	public void boardView(
			Model model,
	          DataMap requestMap) throws Exception {
		
		DataMap viewMap = null;
		DataMap memberMap = null;
		
		// 로그인후 회원정보에 관련된 내용을 가져오는 부분 
		if (!requestMap.getString("qu").equals("selectBbsBoardview")){
			if (requestMap.getString("userId").length() > 0){
				memberMap = supportService.memberView(requestMap.getString("userId"));
			} else {
				memberMap = new DataMap();
			}
		} else {
			memberMap = new DataMap();
		}
		
		if(requestMap.getString("qu").equals("insertBbsBoardForm")){
			//인서트폼일경우 모든데이터를 초기화 시킨다.
			viewMap = new DataMap();
		}else{//수정폼이거나 또는 뷰페이지, 답글일경우
			
			requestMap.setString("seq",commonService.keywordFilter(requestMap.getString("seq")));
			
			if(requestMap.getString("qu").equals("selectBbsBoardview")){
				//쿼리
				String query = "SELECT VISIT FROM TB_BOARD_"+requestMap.getString("boardId")+" WHERE SEQ ="+requestMap.getString("seq");
				//카운터값
				int visit = supportService.selectBbsBoardCount(query);
				//테이블네임 지정
				String tableName = "TB_BOARD_"+requestMap.getString("boardId");
		
				//업데이트시작
				supportService.updateBbsBoardVisit(visit, tableName, requestMap.getString("seq"));
			}
			//게시물 상세 정보
			viewMap = supportService.selectbbsBoardView(requestMap.getString("boardId"),requestMap.getString("seq"));
			
			
			// 파일 정보 가져오기.fileGroupList
			
			if(requestMap.getString("qu").equals("insertReplyBbsBoard")){
				// viewMap.setInt("groupfileNo", 0);
			}
			commonService.selectUploadFileList(viewMap);
		}
		
		model.addAttribute("MEMBER_DATA",memberMap);
		model.addAttribute("BOARDVIEW_DATA", viewMap);
	}
	
	@RequestMapping(value="/homepage/introduce.do", params="mode=lawsView")
	public String lawsView(
			@ModelAttribute("cm") CommonMap cm
			, @RequestParam("mode") String mode
			, Model model
			)throws Exception{
		
		boardView(model, cm.getDataMap());
		
		return findView(cm.getSession(), mode, "/homepage/bbs/lawsView");
	}
	
	@RequestMapping(value="/homepage/introduce.do", params="mode=alreadyExist")
	public String alreadyExist(
			@ModelAttribute("cm") CommonMap cm
			)throws Exception{
		
		return findView(cm.getSession(), cm.getDataMap().getString("mode"), "/homepage/eduInfo/tempalert");
	}
	
	@RequestMapping(value="/homepage/introduce.do", params="mode=alreadyExistPop")
	public String alreadyExistPop(
			@ModelAttribute("cm") CommonMap cm
			)throws Exception{
		
		return findView(cm.getSession(), cm.getDataMap().getString("mode"), "/homepage/eduInfo/tempalert");
	}
	
	@RequestMapping(value="/homepage/introduce.do", params="mode=saveReservationSurvey")
	public String saveReservationSurvey(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			)throws Exception{
		
		cm.getDataMap().setString("enterip", Util.getClientIpAddr(cm.getRequest()));
		model.addAttribute("result", reservationService.saveReservationSurvey(cm.getDataMap()));
		
		return findView(cm.getSession(), cm.getDataMap().getString("mode"), "/homepage/eduInfo/saveReservationSurvey");
	}
	
	@RequestMapping(value="/homepage/introduce.do", params="mode=cyberList")
	public String cyberList(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			)throws Exception{
		
		String tableName = "TB_BOARD_CYBER";
		boardList(model, cm.getDataMap(), tableName);
		
		return findView(cm.getSession(), cm.getDataMap().getString("mode"), "/homepage/bbs/cyberList");
	}
	
	@RequestMapping(value="/homepage/introduce.do", params="mode=cyberView")
	public String cyberView(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			)throws Exception{

		boardView(model, cm.getDataMap());
		
		return findView(cm.getSession(), cm.getDataMap().getString("mode"), "/homepage/bbs/cyberView");
	}
	
	@RequestMapping(value="/homepage/introduce.do", params="mode=new_poll_list")
	public String new_poll_list(
			 @ModelAttribute("cm") CommonMap cm
			,Model model
			,HttpServletRequest request) throws Exception{
		
		
		DataMap requestMap = cm.getDataMap();
		String userno = requestMap.getString("checknumber");
		
		
		DataMap userInfo = coursePollService.selectUsernoChk(userno);
		
		
		if(userInfo != null){
			
			HttpSession session = request.getSession();
			session.setAttribute("sess_loginYn", "Y");
			session.setAttribute("sess_no", Util.getValue(userInfo.getString("userno"), ""));
			session.setAttribute("sess_name", Util.getValue(userInfo.getString("name"), ""));
			session.setAttribute("sess_userid", Util.getValue(userInfo.getString("userid"), ""));
			session.setAttribute("sess_userhp", Util.getValue(userInfo.getString("hp"), ""));		
			loginService.updateLoginInfo(userno);			
		}		
		
		String month   = new java.text.SimpleDateFormat("MM").format(new java.util.Date());
		
		userInfo.add("month",month);
		
		//설문 리스트
		DataMap listMap = coursePollService.selectPollList(userInfo);		
		model.addAttribute("LIST_DATA", listMap);		
		
		return "/poll/course/newPollList";
	}
	
	@RequestMapping(value="/homepage/introduce.do", params="mode=new_poll_list2")
	public String new_poll_list2(
			 @ModelAttribute("cm") CommonMap cm
			,Model model
			,HttpServletRequest request) throws Exception{
		
		
		DataMap requestMap = cm.getDataMap();
		String userno = requestMap.getString("checknumber");
		int titleNo = 7902;
		int setNo = 1;

		DataMap userInfo = coursePollService.selectUsernoChk(userno);
		
		
		if(userInfo != null){
			
			HttpSession session = request.getSession();
			session.setAttribute("sess_loginYn", "Y");
			session.setAttribute("sess_no", Util.getValue(userInfo.getString("userno"), ""));
			session.setAttribute("sess_name", Util.getValue(userInfo.getString("name"), ""));
			session.setAttribute("sess_userid", Util.getValue(userInfo.getString("userid"), ""));
			session.setAttribute("sess_userhp", Util.getValue(userInfo.getString("hp"), ""));		
			loginService.updateLoginInfo(userno);			
		}		
		
		String month   = new java.text.SimpleDateFormat("MM").format(new java.util.Date());
		
		userInfo.add("month",month);
		
		//설문 리스트
		DataMap listMap = coursePollService.selectGrinqQuestionSetList(titleNo, setNo);		
		model.addAttribute("LIST_DATA", listMap);		
		
		return "/poll/course/newPollList2";
	}
	
	@RequestMapping(value="/poll/coursePoll.do", params="mode=new_poll_preview")
	public String new_poll_preview(
			@ModelAttribute("cm") CommonMap cm
			, Model model			
			,@RequestParam Map<String,Object> pollparam
			,HttpServletRequest request
			) throws Exception{	
		
		DataMap requestMap = new DataMap();
		HttpSession session = request.getSession();		
		
		requestMap.addString("titleNo",pollparam.get("titleNo").toString());
		requestMap.addString("setNo",pollparam.get("setNo").toString());
		
		
		//설문 리스트
		DataMap listMap = coursePollService.selectGrinqQuestionSetByAddSampList(requestMap.getInt("titleNo"), requestMap.getInt("setNo"));
		
		//설문 내용
		DataMap rowMap = coursePollService.selectGrinqTtlRow(requestMap.getInt("titleNo"));
		
		//설문조사 수정용
		requestMap.addString("userno",session.getAttribute("sess_no").toString());
		DataMap scoreMap = coursePollService.selectScore(requestMap);
		
		model.addAttribute("ROW_DATA", rowMap);
		model.addAttribute("LIST_DATA", listMap);
		model.addAttribute("SCORE_DATA", scoreMap);
		model.addAttribute("grcode", pollparam.get("grcode").toString());
		model.addAttribute("grseq", pollparam.get("grseq").toString());
		
		
		return "/poll/course/newPollPreviewPop";
	}
	
	@RequestMapping(value="/poll/coursePoll.do", params="mode=newEtc_exec")
	public String newEtc_exec(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			, HttpServletRequest request
			) throws Exception{
		
		HttpSession session = request.getSession();
		DataMap requestMap = cm.getDataMap();
		DataMap userMap = new DataMap();
		DataMap userinfo = new DataMap();

		int result = 0;
		int ipcheck = 0;
		String msg = ""; // 결과 메세지.

		if (requestMap.getString("qu").equals("new_preview")) { // 설문 미리보기 등록 실행

			userMap = coursePollService.selectNewPollList(requestMap);
			
			/*userinfo = coursePollService.selectIpList(requestMap);
			if (userMap != null && userinfo != null) {

				String ip = request.getHeader("X-Forwarded-For");
				if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
					ip = request.getHeader("Proxy-Client-IP");
				}
				if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
					ip = request.getHeader("WL-Proxy-Client-IP");
				}
				if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
					ip = request.getHeader("HTTP_CLIENT_IP");
				}
				if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
					ip = request.getHeader("HTTP_X_FORWARDED_FOR");
				}
				if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
					ip = request.getHeader("X-Real-IP");
				}
				if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
					ip = request.getHeader("X-RealIP");
				}
				if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
					ip = request.getRemoteAddr();
				}

				for (int i = 0; i < userinfo.keySize("ip"); i++) {
					if (userinfo.getString("ip", i) != null && userinfo.getString("ip", i).equals(ip)) {
						msg = "이미 설문에 참여 하셨습니다.";
						ipcheck = 1;
						break;
					}
				}*/

				if (ipcheck == 0) {

					DataMap ttlMap = coursePollService.selectGrinqTtlRow(requestMap.getInt("titleNo"));

					if (ttlMap == null) {

						msg = "실패";
					} else {
						
						/*

						for (int i = nSize; i < nSize + 1; i++) {

							userno = userMap.getString("userno", i);
						}*/

						//userinfo.add("userno", userno);						
						//userinfo.add("ip", ip);
						//coursePollService.insertIp(userinfo);
						
						userinfo.clear();
						userinfo.add("userno",(String)session.getAttribute("sess_no"));			
						userinfo.add("grcode", requestMap.get("grcode"));
						userinfo.add("grseq", requestMap.get("grseq"));
						
					int nSize = coursePollService.selectNewPollYN(userinfo);
					
					if (nSize == userMap.keySize("userno")) {
						msg = "현재 모든 인원이 설문에 참여 하셨습니다.";
					}					
						
					else {

						ttlMap.setNullToInitialize(true);						
						if (!ttlMap.getString("sdate").equals("") && ttlMap.getString("sdate").length() == 8
								&& !ttlMap.getString("sdateHh").equals("") && ttlMap.getString("sdateHh").length() == 2
								&& !ttlMap.getString("sdateMm").equals("") && ttlMap.getString("sdateMm").length() == 2
								&& !ttlMap.getString("edate").equals("") && ttlMap.getString("edate").length() == 8
								&& !ttlMap.getString("edateHh").equals("") && ttlMap.getString("edateHh").length() == 2
								&& !ttlMap.getString("edateMm").equals("")
								&& ttlMap.getString("edateMm").length() == 2) {

							// 설문 삭제.
							long sDate = Long.parseLong(ttlMap.getString("sdate") + ttlMap.getString("sdateHh")
									+ ttlMap.getString("sdateMm") + "00");
							long eDate = Long.parseLong(ttlMap.getString("edate") + ttlMap.getString("edateHh")
									+ ttlMap.getString("edateMm") + "59");

							if (sDate > Long.parseLong(DateUtil.getDateTimeMinSec())) {
								msg = "설문조사 예정입니다.";
								result = -1;
							}

							if (eDate < Long.parseLong(DateUtil.getDateTimeMinSec())) {
								msg = "설문조사가 종료되었습니다";
								result = -1;
							}

							if (result != -1) {

								DataMap listMap = coursePollService.selectGrinqQuestionSetByAddSampList(
										requestMap.getInt("titleNo"), requestMap.getInt("setNo"));
								if (listMap != null) {

									requestMap.add("userno",(String)session.getAttribute("sess_no"));
									DataMap scoreMap = coursePollService.selectScore(requestMap);

									if (scoreMap.keySize("ansNo") > 1) {
										coursePollService.deleteAnsNo(requestMap);
									}

									result = coursePollService.insertGrinqAnser(requestMap, listMap, (String)session.getAttribute("sess_no"));
									log.debug("===================== 등록건수 =========================== " +result);
									if (result > 0) {
										log.debug("===================== updatePollYN =========================== ");
										coursePollService.updatePollYN(userinfo);
										log.debug("===================== msg =========================== ");
										msg = "설문이 완료되었습니다.";
									} else {
										msg = "실패";
									}

								} else {
									msg = "실패";
								}
							}
						} else {
							msg = "실패";
						}
					}

				}

			}
		}
		// }
		
		String poolYN = coursePollService.selectPollYNChk(userinfo);                            
		
		if(poolYN.equals("N") || poolYN == "N" ){
			coursePollService.updatePollYN(userinfo);                     
		}
		
		session.invalidate();
		
		model.addAttribute("RESULT_MSG", msg);		
		return "/poll/course/newcoursePollEtcExec";
	}
	
	
}

