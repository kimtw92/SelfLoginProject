package loti.courseMgr.web;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import loti.courseMgr.service.ReservationService;
import loti.homeFront.service.IntroduceService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import ut.lib.exception.BizException;
import ut.lib.login.LoginCheck;
import ut.lib.login.LoginInfo;
import ut.lib.support.CommonMap;
import ut.lib.support.DataMap;
import ut.lib.util.Util;
import common.controller.BaseController;

@Controller
public class ReservationController extends BaseController {

	@Autowired
	private ReservationService reservationService;
	@Autowired
	private IntroduceService introduceService;
	
	@ModelAttribute("cm")
	public CommonMap common(CommonMap cm
			              , Model model
			              , HttpServletRequest request
			              , HttpServletResponse response
			              , @RequestParam(value="mode", required=false, defaultValue="") String mode
			              , @RequestParam(value="menuId", required=false, defaultValue="") String menuId) throws BizException {
		
		try {
			DataMap requestMap = cm.getDataMap();
			requestMap.setNullToInitialize(true);
			
			if (mode.equals("")) {
				mode = "list";
				requestMap.setString("mode", mode);
			}
			
			//관리자 로그인 체크 (관리자 페이지에는 모두 있어야 함.)
			LoginInfo memberInfo = LoginCheck.adminCheck(request, response, menuId);
			if (memberInfo == null) {
				return null;
			}
			
			//공통 Comm Select Box 값 초기 셋팅.
			HttpSession session = request.getSession(); //세션
			if(requestMap.getString("commYear").equals(""))
				requestMap.setString("commYear", (String)session.getAttribute("sess_year"));
			if(requestMap.getString("commGrcode").equals(""))
				requestMap.setString("commGrcode", (String)session.getAttribute("sess_grcode"));
			if(requestMap.getString("commGrseq").equals(""))
				requestMap.setString("commGrseq", (String)session.getAttribute("sess_grseq"));
			
			model.addAttribute("REQUEST_DATA", requestMap);
			model.addAttribute("LOGIN_INFO", memberInfo);
			
			holydayUiList(cm, model);
		} catch (Exception e) {
			throw new BizException(e);
		} finally {
			
		}
		
		return cm;
	}
	
	/**
	 * ui에 뿌려질 휴무일 리스트
	 */
	public void holydayUiList(@ModelAttribute("cm") CommonMap cm, Model model) throws BizException {
		DataMap requestMap = cm.getDataMap();
		requestMap.setNullToInitialize(true);
		
		requestMap.setString("pre_year", reservationService.getYear());
		requestMap.setString("pre_month", reservationService.getMonth());
		
		model.addAttribute("HOLYDAYUILIST_DATA", reservationService.selectHolyDayUiList(requestMap));
	}
	
	/**
	 * 공휴일 저장 로직
	 */
	@RequestMapping(value="/courseMgr/reservation.do", params = "mode=saveHolyDayAjaxAction")
	public String saveHolyDayAjaxAction(@ModelAttribute("cm") CommonMap cm, Model model) throws BizException {
		DataMap requestMap = cm.getDataMap();
		requestMap.setNullToInitialize(true);
		
		requestMap.setString("sess_userid", (String)cm.getSession().getAttribute("sess_userid"));
		requestMap.setString("sess_name", (String)cm.getSession().getAttribute("sess_name"));
		
		int errorCode = reservationService.insertHolyDay(requestMap);
		if(errorCode == 1){
			model.addAttribute("result","ok");
		} else if(errorCode == -2){
			model.addAttribute("result","check");
		} else{
			model.addAttribute("result","fail");
		}
		
		requestMap.setString("mode", "reservationConfirmAjaxAction");
		
		return "/homepage/eduInfo/reservationconfirmAjaxAction";
	}
	
	@RequestMapping(value="/courseMgr/reservation.do", params = "mode=updateHolyDayAjaxAction")
	public String updateHolyDayAjaxAction(@ModelAttribute("cm") CommonMap cm, Model model) throws BizException {
		DataMap requestMap = cm.getDataMap();
		requestMap.setNullToInitialize(true);
		
		requestMap.setString("sess_userid", (String)cm.getSession().getAttribute("sess_userid"));
		requestMap.setString("sess_name", (String)cm.getSession().getAttribute("sess_name"));
		
		int errorCode = reservationService.updateHolyDay(requestMap);

		if(errorCode == 1){
			model.addAttribute("result","ok");
		} else if(errorCode == -2){
			model.addAttribute("result","check");
		} else{
			model.addAttribute("result","fail");
		}
		
		requestMap.setString("mode", "reservationConfirmAjaxAction");
		
		return "/homepage/eduInfo/reservationconfirmAjaxAction";
	}	

	/**
	 * 공휴일 삭제 로직
	 */
	@RequestMapping(value="/courseMgr/reservation.do", params = "mode=deleteHolyDayAjaxAction")
	public String deleteHolyDayAjaxAction(@ModelAttribute("cm") CommonMap cm, Model model) throws BizException {
		DataMap requestMap = cm.getDataMap();
		requestMap.setNullToInitialize(true);
		
		int errorCode = reservationService.deleteHolyDay(requestMap);
		if(errorCode == 1){
			model.addAttribute("result","ok");
		} else{
			model.addAttribute("result","fail");
		}
		
		String mode = "reservationConfirmAjaxAction";
		requestMap.setString("mode", mode);
		
		return "/homepage/eduInfo/reservationconfirmAjaxAction";
	}
	
	/**
	 * 시설임대예약 리스트
	 * */
	@RequestMapping(value="/courseMgr/reservation.do", params = "mode=list")
	public String list(@ModelAttribute("cm") CommonMap cm, Model model) throws BizException {
		DataMap requestMap = cm.getDataMap();
		requestMap.setNullToInitialize(true);
		
		//신청내역: N, 승인내역: Y
		String type = Util.getValue(requestMap.getString("type"), "N");
	
		//신청내역, 승인내역 리스트
		DataMap resultMap = reservationService.selectResvList(type);
		//관리자SMS 리스트
		DataMap adminMap  = reservationService.selectResvAdmin();
		
		model.addAttribute("type", type);
		model.addAttribute("RESERVATION_LIST", resultMap);
		model.addAttribute("ADMIN_SMS_LIST", adminMap);
		
		return "/courseMgr/reservation/reservationList";
	}
	
	/**
	 * 시설임대예약 싱글데이터 조회
	 * */
	@RequestMapping(value="/courseMgr/reservation.do", params = "mode=modify")
	public String formResv(@ModelAttribute("cm") CommonMap cm, Model model) throws BizException {
		DataMap requestMap = cm.getDataMap();
		requestMap.setNullToInitialize(true);
		
		String taPk=(String)requestMap.getString("taPk");
		model.addAttribute("RESERVATION", introduceService.getReservationModify(taPk));
		
		return "/courseMgr/reservation/reservationModify";
	}
	
	/**
	 * 시설임대예약 수정 처리
	 * */
	@RequestMapping(value="/courseMgr/reservation.do", params = "mode=modifyAction")
	public String updateResv(@ModelAttribute("cm") CommonMap cm, Model model) throws BizException {
		HttpServletRequest request = cm.getRequest();
		String place="";
		
		if(request.getParameter("place")==null){
			place="0";
		}else {
			place=request.getParameter("place");
		}
		
		String setDay = request.getParameter("day");
		if(setDay.length()==1) {
			setDay = "0"+setDay;
		}
		
		String setMonth = request.getParameter("month");
		if(setMonth.length()==1) {
			setMonth = "0"+setMonth;
		}
		
		String resv_day 	= request.getParameter("year")+setMonth+setDay;	//예약일
		String gubun 		= request.getParameter("gubun");
		String taPk 		= request.getParameter("taPk");
		String groupname 	= request.getParameter("groupname");
		String resvname 	= request.getParameter("resvname");
		String content 		= request.getParameter("content");
		String homeaddr 	= request.getParameter("homeAddr");
		String tel 			= request.getParameter("tel1")+"-"+request.getParameter("tel2")+"-"+request.getParameter("tel3");
		String person 		= request.getParameter("person");
		String agrno 		= request.getParameter("agrno");	// 사용승인번호
		
		introduceService.modifyReservation(taPk, resvname, homeaddr, tel, resv_day, content, person, groupname, place , gubun, agrno);
		
		return "";
	}
	
	/**
	 * 시설임대예약 예약완료 처리
	 * */
	@RequestMapping(value="/courseMgr/reservation.do", params = "mode=confirmaction")
	public String execResvConfirm(@ModelAttribute("cm") CommonMap cm, Model model) throws BizException {
		HttpServletRequest request = cm.getRequest();
		String taPk=request.getParameter("taPk");
		String taAgrNo = request.getParameter("taAgrNo");
		reservationService.setReservation(taPk,"Y", taAgrNo);
		
		return "redirect:/courseMgr/reservation.do?mode=list&amp;menuId=1-5-2";
	}
	
	/**
	 * 시설임대예약 취소 처리
	 * */
	@RequestMapping(value="/courseMgr/reservation.do", params = "mode=cancelaction")
	public String execResvCancel(@ModelAttribute("cm") CommonMap cm, Model model) throws BizException {
		HttpServletRequest request = cm.getRequest();
		String taPk = request.getParameter("taPk");
		reservationService.setReservation(taPk, "C");
		//sv.delReservation(taPk);
		
		return "redirect:/courseMgr/reservation.do?mode=list&amp;menuId=1-5-2";
	}
	
	/**
	 * 시설임대예약 관리자 직접입력
	 * */
	@RequestMapping(value="/courseMgr/reservation.do", params = "mode=reservationaction")
	public String execResv(@ModelAttribute("cm") CommonMap cm, Model model) throws BizException {
		HttpServletRequest request = cm.getRequest();
		String place 		= request.getParameter("place");
		String resv_day 	= request.getParameter("resv_day");
		String gubun 		= request.getParameter("gubun");
		String groupname	= request.getParameter("groupname");
		String resvname		= request.getParameter("resvname");
		String content		= request.getParameter("content");
		String homeaddr		= request.getParameter("homeAddr");
		String tel			= request.getParameter("tel1")+"-"+request.getParameter("tel2")+"-"+request.getParameter("tel3");
		String jumin		= request.getParameter("jumin1")+request.getParameter("jumin2");
		String person		= request.getParameter("person");
		String sum			= request.getParameter("sum");		// 사용요금 합계
		String room50		= request.getParameter("room50");
		String room100		= request.getParameter("room100");
		String starttime	= request.getParameter("starttime");
		String endtime		= request.getParameter("endtime");
		String sexm			= request.getParameter("sexm");
		String sexf			= request.getParameter("sexf");
		String startdate	= request.getParameter("startdate");
		String enddate		= request.getParameter("enddate");		
		
		introduceService.setReservation(resvname,  homeaddr, tel, jumin, resv_day, content , person,  groupname,  place , gubun, sum, room50, room100, starttime, endtime, sexm, sexf, startdate, enddate);
		
		return "redirect:/courseMgr/reservation.do?mode=list&amp;menuId=1-5-2";
	}
	
	/**
	 * 관리자SMS 등록/삭제
	 */
	@RequestMapping(value="/courseMgr/reservation.do", params = "mode=exec")
	public String exec(@ModelAttribute("cm") CommonMap cm, Model model) throws BizException {
		DataMap requestMap = cm.getDataMap();
		requestMap.setNullToInitialize(true);
		
		requestMap.setString("luserno", (String)cm.getSession().getAttribute("sess_no"));
		
		//등록, 삭제 구분
		String qu = requestMap.getString("qu");
		//결과 메세지.
		String msg = "";
		
		//등록
		if(qu.equals("add")) {
			int result = reservationService.insertResvAdmin(requestMap);
			if(result > 0) msg = "등록 되었습니다.";
			else msg = "실패";
			
		//삭제
		} else if(qu.equals("del")) {
			int result = reservationService.deleteResvAdmin(requestMap);
			if(result > 0) msg = "삭제 되었습니다.";
			else msg = "실패";
		}
		model.addAttribute("RESULT_MSG", msg);
		model.addAttribute("REQUEST_DATA", requestMap);
		
		return "/courseMgr/reservation/reservationExec";
	}
	
	/**
	 * 시설임대예약 메뉴사용여부 화면
	 * */
	@RequestMapping(value="/courseMgr/reservation.do", params = "mode=useForm")
	public String formUseYn(@ModelAttribute("cm") CommonMap cm, Model model) throws BizException {
		DataMap resultMap = reservationService.getResvUse();
		model.addAttribute("LIST_DATA", resultMap);
		
		return "/courseMgr/reservation/reservationUse";
	}
	
	/**
	 * 휴무일 목록
	 */
	@RequestMapping(value="/courseMgr/reservation.do", params = "mode=holyday")
	public String holydayList(@ModelAttribute("cm") CommonMap cm, Model model) throws BizException {
		DataMap requestMap = cm.getDataMap();
		requestMap.setNullToInitialize(true);
		
		DataMap resultMap = reservationService.getHolyDay(requestMap);
		DataMap yearGroupMap = reservationService.getYearGroup();
		
		model.addAttribute("yyyy", "".equals(requestMap.getString("yyyy")) ? reservationService.getYear():requestMap.getString("yyyy"));
		model.addAttribute("LIST_YEAR", yearGroupMap);
		model.addAttribute("LIST_DATA", resultMap);
		
		return "/courseMgr/reservation/holyday";
	}
	
	/**
	 * 시설임대예약 메뉴사용여부 수정
	 * */
	@RequestMapping(value="/courseMgr/reservation.do", params = "mode=useModify")
	public String execUseYn(@ModelAttribute("cm") CommonMap cm, Model model) throws BizException {
		DataMap requestMap = cm.getDataMap();
		requestMap.setNullToInitialize(true);
		
		requestMap.setString("luserno", (String)cm.getSession().getAttribute("sess_no"));
		
		reservationService.updateUseMenu(requestMap);
		
		return "redirect:/courseMgr/reservation.do?mode=useForm";
	}
	
	/**
	 * 시설임대관리 리스트
	 * @throws Exception 
	 */
	@RequestMapping(value="/courseMgr/reservation.do", params = "mode=mgr")
	public String listResvMgr(@ModelAttribute("cm") CommonMap cm, Model model) throws Exception {
		HttpServletRequest request = cm.getRequest();
		DataMap requestMap = cm.getDataMap();
		
		java.util.Calendar cal = java.util.Calendar.getInstance();
		int year = cal.get(java.util.Calendar.YEAR);
		int month = cal.get(java.util.Calendar.MONTH) + 1;
		
		if(request.getParameter("year") != null && request.getParameter("month") != null) {
			year = Integer.parseInt(request.getParameter("year"));
			month = Integer.parseInt(request.getParameter("month"));
		}

		cal.set(year, month, 1); 
		
		String place="";
		if(request.getParameter("place")==null){
			place="0";
		}else {
			place=request.getParameter("place");
		}
		String setYear=String.valueOf(year);
		String setMonth="";
		
		if(month < 10) {
			setMonth = "0"+String.valueOf(month);
		} else {
			setMonth = String.valueOf(month);
		}
		
		requestMap.setString("yyyy", setYear);
		requestMap.setString("mm", String.valueOf(month));
		requestMap.setString("price", place);
		
		request.setAttribute("yyyy", requestMap.getString("yyyy"));
		request.setAttribute("mm", requestMap.getString("mm"));
		request.setAttribute("SAVEMGRYNLIST", reservationService.SaveMgrYnList(requestMap));
		
		model.addAttribute("RESERVATION_LIST", introduceService.getReservationList(setYear+setMonth,place));
		
		return "/courseMgr/reservation/reservationMgr";
	}
	
	/**
	 * 시설임대관리 등록/수정 폼
	 */
	@RequestMapping(value="/courseMgr/reservation.do", params = "mode=adminRev")
	public String formResvMgr(@ModelAttribute("cm") CommonMap cm, Model model) throws BizException {
		HttpServletRequest request = cm.getRequest();
		
		model.addAttribute("year", request.getParameter("year"));
		model.addAttribute("month", request.getParameter("month"));
		model.addAttribute("day", request.getParameter("day"));
		model.addAttribute("gubun", request.getParameter("gubun"));
		model.addAttribute("place", request.getParameter("place"));
		
		return "/courseMgr/reservation/reservationAdminReg";
	}
	
	/**
	 * 시설임대관리 등록/수정 처리
	 */
	@RequestMapping(value="/courseMgr/reservation.do", params = "mode=adminReg")
	public String execResvMgr(@ModelAttribute("cm") CommonMap cm, Model model) throws BizException {
		HttpServletRequest request = cm.getRequest();
		String place="";
		
		if(request.getParameter("place")==null){
			place="0";
		}else {
			place=request.getParameter("place");
		}
		
		String setDay = request.getParameter("day");
		if(setDay.length()==1) {
			setDay = "0"+setDay;
		}
		
		String setMonth = request.getParameter("month");
		if(setMonth.length()==1) {
			setMonth = "0"+setMonth;
		}
		//예약일
		String resv_day = request.getParameter("year")+setMonth+setDay;
		String gubun = request.getParameter("gubun");
		
		String groupname = request.getParameter("groupname");
		String resvname = request.getParameter("resvname");
		String content = request.getParameter("content");
		String homeaddr = request.getParameter("homeAddr");
		String tel = request.getParameter("tel1")+"-"+request.getParameter("tel2")+"-"+request.getParameter("tel3");
		String jumin = request.getParameter("jumin");
		String person = request.getParameter("person");
		String sum = request.getParameter("sum");
		
		String room50		= request.getParameter("room50");
		String room100		= request.getParameter("room100");
		String starttime	= request.getParameter("starttime");
		String endtime		= request.getParameter("endtime");
		String sexm			= request.getParameter("sexm");
		String sexf			= request.getParameter("sexf");
		String startdate	= request.getParameter("startdate");
		String enddate		= request.getParameter("enddate");		
		
		introduceService.setReservation(resvname,  homeaddr, tel, jumin, resv_day, content , person,  groupname,  place , gubun, sum, room50, room100, starttime, endtime, sexm, sexf, startdate, enddate);
		
		return "";
	}

	/**
	 * 시설 설문지
	 */
	@RequestMapping(value="/courseMgr/reservation.do", params = "mode=reservationSurvey")
	public String getReservationSurvey(@ModelAttribute("cm") CommonMap cm, Model model) throws BizException {
		model.addAttribute("RESERVATION_LIST", introduceService.getReservationSurvey());
		
		return "/courseMgr/reservation/reservationSurvey";
	}
	
	/**
	 * 시설 설문 상세 보기
	 */
	@RequestMapping(value="/courseMgr/reservation.do", params = "mode=reservationSurveyDetail")
	public String getReservationSurveyDetail(@ModelAttribute("cm") CommonMap cm, Model model) throws BizException {
		DataMap requestMap = cm.getDataMap();
		requestMap.setNullToInitialize(true);
		
		model.addAttribute("RESERVATION_LIST", introduceService.getReservationSurveyDetail());
		model.addAttribute("listnum", requestMap.getString("listnum"));
		
		return "/courseMgr/reservation/reservationSurveyDetail";
	}
	
	@RequestMapping(value="/courseMgr/reservation.do", params = "mode=form")
	public String form(@ModelAttribute("cm") CommonMap cm, Model model) throws BizException {
		return "/courseMgr/reservation/reservationForm";
	}
	
	@RequestMapping(value="/courseMgr/reservation.do", params = "mode=addAdminSMS")
	public String addAdminSMS(@ModelAttribute("cm") CommonMap cm, Model model) throws BizException {
		return "redirect:/courseMgr/reservation.do?mode=list&amp;menuId=1-5-2";
	}
	
	@RequestMapping(value="/courseMgr/reservation.do", params = "mode=delAdminSMS")
	public String delAdminSMS(@ModelAttribute("cm") CommonMap cm, Model model) throws BizException {
		return "redirect:/courseMgr/reservation.do?mode=list&amp;menuId=1-5-2";
	}
	
	@RequestMapping(value="/courseMgr/reservation.do", params = "mode=duplicatereservation")
	public String duplicatereservation(@ModelAttribute("cm") CommonMap cm, Model model) throws BizException {
		return "/homepage/eduInfo/tempalert";
	}
	
	public void ajaxSaveMgrYn(
			Model model
			, DataMap requestMap
			, HttpSession session
			) throws Exception {
		
		requestMap.setString("userno", (String)session.getAttribute("sess_no"));
		DataMap CheckResultMap =  reservationService.CheckSaveMgrYn(requestMap);
		
		int errorCode = 0;
		if(CheckResultMap.getInt("cnt",0) <= 0) {
			model.addAttribute("result","insert");
			errorCode = reservationService.ajaxSaveMgrYn(requestMap); // 인서트
		} else {
			errorCode = reservationService.ajaxDeleteMgrYn(requestMap); // 수정
			model.addAttribute("result","update");
		}
		
	}
	
	@RequestMapping(value="/courseMgr/reservation.do", params = "mode=mgrYn")
	public String mgrYn(@ModelAttribute("cm") CommonMap cm, Model model, HttpSession session) throws Exception {
		ajaxSaveMgrYn(model, cm.getDataMap(), session);
		return "/homepage/eduInfo/reservationmgrYn";
	}
}
