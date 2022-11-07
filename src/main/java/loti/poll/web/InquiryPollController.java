package loti.poll.web;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import loti.poll.service.InquiryPollService;

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
public class InquiryPollController extends BaseController {
	
	@Autowired
	private InquiryPollService inquiryPollService;

	@ModelAttribute("cm")
	public CommonMap common(
				CommonMap cm
				, HttpServletRequest request
				, HttpServletResponse response
				, Model model
				, HttpSession session
			) throws Exception{
		
		 //요청처리 - get, post 방식의 파라미터를 DataMap 에 저장
		DataMap requestMap = cm.getDataMap();
		//초기화 옵션(true 일경우 데이터를 뽑을때 null 일경우 초기화 - 빈문자열, 0....)
		requestMap.setNullToInitialize(true);
		//관리자 로그인 체크. (관리자 페이지에는 모두 있어야 함)
		LoginInfo memberInfo = LoginCheck.adminCheck(request, response, requestMap.getString("menuId"));
		if (memberInfo == null) return null;
		//default mode
		if(requestMap.getString("mode").equals(""))
			requestMap.setString("mode", "list");
		String mode = requestMap.getString("mode");
		
		/** 
		 * 상단 검색에 년도, 과정, 기수, 과목 셀렉트 박스 사용시 필수 
		 * 명칭 변경하면 안됨 
		 **/
		// 공통 Comm Select Box 값 초기 셋팅.
		if(requestMap.getString("commYear").equals("")) {
			requestMap.setString("commYear", (String)session.getAttribute("sess_year"));
		}
		if(requestMap.getString("commGrcode").equals("")) {
			requestMap.setString("commGrcode", (String)session.getAttribute("sess_grcode"));
		}
		if(requestMap.getString("commGrseq").equals("")) {
			requestMap.setString("commGrseq", (String)session.getAttribute("sess_grseq"));
		}        
        if(requestMap.getString("commSubj").equals("")) {
			requestMap.setString("commSubj", (String)session.getAttribute("sess_subj"));
		}
        if(requestMap.getString("sessNo").equals("")) {
			requestMap.setString("sessNo",(String)session.getAttribute("sess_no"));
        }
		
        model.addAttribute("REQUEST_DATA", requestMap);
        
		return cm;
	}
	
	public String findView(String mode, String defaultView){
		return defaultView;
	}
	
	@RequestMapping(value="/poll/inquiryPoll.do", params="mode=list")
	public String list(
				@ModelAttribute("cm") CommonMap cm
				, Model model
				, HttpSession session
			) throws Exception{
		
		DataMap requestMap = cm.getDataMap();
		
		DataMap listMap = null;
		listMap = new DataMap();
		
		requestMap.setString("year", (String)session.getAttribute("sess_year"));
		requestMap.setString("grcode", (String)session.getAttribute("sess_grcode"));
		requestMap.setString("grseq", (String)session.getAttribute("sess_grseq"));
		
		// 과정 코드
		String pGrCode = Util.getValue(requestMap.getString("grcode"));
		
		// 기수 코드
		String pGrSeq = Util.getValue(requestMap.getString("grseq"));
		
		if(!pGrCode.equals("") && !pGrSeq.equals("")){
			//회차
			listMap = inquiryPollService.selectInquiryPollAjax(requestMap);
		}
		
		model.addAttribute("LIST_DATA", listMap);
		
		return findView(requestMap.getString("mode"), "/poll/inquiry/inquiryList");
	}
	
	@RequestMapping(value="/poll/inquiryPoll.do", params="mode=inquiryAjax")
	public String inquiryAjax(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			, HttpSession session
			) throws Exception{
		
		DataMap requestMap = cm.getDataMap();
		
		DataMap listMap = null;
		
		if(!requestMap.getString("qu").equals("")){
			session.setAttribute("sess_year", 	Util.getValue(requestMap.getString("year"), ""));
			session.setAttribute("sess_grcode", Util.getValue(requestMap.getString("grcode"), ""));
			session.setAttribute("sess_grseq", 	Util.getValue(requestMap.getString("grseq"), ""));
		}

			
		// 과정 코드
		String pGrCode = Util.getValue(requestMap.getString("grcode"));
		
		// 기수 코드
		String pGrSeq = Util.getValue(requestMap.getString("grseq"));
		
		if(requestMap.getString("qu").equals("sequence") && !pGrCode.equals("") && !pGrSeq.equals("")){
			//회차가져오기
			listMap = inquiryPollService.selectInquiryPollAjax(requestMap);
			
		}else if(requestMap.getString("qu").equals("end") && !pGrCode.equals("") && !pGrSeq.equals("") && !requestMap.getString("sequence").equals("")){
			//설문SET번호
			listMap = inquiryPollService.selectInquirySetPollAjax(requestMap);
			
		}
		
		model.addAttribute("LIST_DATA", listMap);
		
		return findView(requestMap.getString("mode"), "/poll/inquiry/inquiryAjax");
	}
}
