package loti.homepageMgr.web;

import gov.mogaha.gpin.sp.util.StringUtil;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import loti.common.service.CommonService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import ut.lib.exception.BizException;
import ut.lib.login.LoginCheck;
import ut.lib.login.LoginInfo;
import ut.lib.support.CommonMap;
import ut.lib.support.DataMap;
import common.controller.BaseController;

@Controller
public class MenuScoreController extends BaseController {

	@Autowired
	private CommonService commonService;
	
	@ModelAttribute("cm")
	public CommonMap common(
				CommonMap cm
				, HttpServletRequest request
				, HttpServletResponse response
				, Model model
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
		
		model.addAttribute("REQUEST_DATA", requestMap);
		
		return cm;
	}
	
	@RequestMapping(value="/homepageMgr/menuScore.do", params="mode=list")
	public String list(@ModelAttribute("cm") CommonMap cm, Model model) throws BizException{
		DataMap listMap = new DataMap();	
		
		listMap = commonService.selectMenuScoreList();
	
		model.addAttribute("LIST_DATA", listMap);
		
		return "/homepageMgr/menuScore/menuScoreList";
	}
	
	@RequestMapping(value="/homepageMgr/menuScore.do", params="mode=menuTotalScoreList")
	public String menuTotalScoreList (@ModelAttribute("cm") CommonMap cm, Model model) throws BizException{
		//service Instance
		String menucode = StringUtil.nvl(cm.getRequest().getParameter("menucode"), "");
		//리스트
		DataMap listMap = new DataMap();
		
		listMap = commonService.selectTotalMenuScoreList(menucode);
	
		model.addAttribute("LIST_DATA", listMap);
		
		return "/homepageMgr/menuScore/menuTotalScoreList";
	}
	
	/**
	 * 페이지별 관리자 수정
	 * @throws Exception
	 */
	@RequestMapping(value="/homepageMgr/menuScore.do", params="mode=ajaxSaveMenuScore")
	public String ajaxSaveMenuScore (@ModelAttribute("cm") CommonMap cm, Model model) throws BizException{
		String rtnString = "/homepage/eduInfo/reservationconfirmAjaxAction";
		
		if(!"POST".equals(cm.getRequest().getMethod())) { // get 방식 차단
			model.addAttribute("result","nopost");
			return rtnString;
		}
		
		LoginInfo loginInfo = (LoginInfo)cm.getRequest().getAttribute("LOGIN_INFO");
		if(!loginInfo.isLogin()) {
			model.addAttribute("result","loginfail");
			return rtnString;
		}
		
		String menucode = StringUtil.nvl(cm.getRequest().getParameter("menucode"), "");
		String menuScore = StringUtil.nvl(cm.getRequest().getParameter("menuScore"), "");
		String opinion = StringUtil.nvl(cm.getRequest().getParameter("opinion"), "");
		String userIp = StringUtil.nvl(getClientIpAddr(cm.getRequest()),"");
		String userNo = StringUtil.nvl(loginInfo.getSessNo(), "");
	
		if(!commonService.isMenuScore(menucode, userNo)) {
			model.addAttribute("result","cnt");
			return rtnString;
		}
		
		int errorCode = commonService.saveMenuScore(menucode, menuScore, opinion, userIp, userNo);

		if(errorCode > 0){
			model.addAttribute("result","ok");
		}else{
			model.addAttribute("result","fail");
		}
		
		return rtnString;
	}
	
	/**
	 * 만족도보임여부
	 */
	@RequestMapping(value="/homepageMgr/menuScore.do", params="mode=ajaxUpdateMenuScoreUseyn")
	public String ajaxUpdateMenuScoreUseyn (@ModelAttribute("cm") CommonMap cm, Model model) throws BizException{
		String menucode = StringUtil.nvl(cm.getRequest().getParameter("menucode"), "");
		String menuscoreUseyn = StringUtil.nvl(cm.getRequest().getParameter("menuscoreUseyn"), "");
		
		int errorCode = commonService.updateMenuScoreUseyn(menucode, menuscoreUseyn);

		if(errorCode > 0){
			model.addAttribute("result","ok");
		}else{
			model.addAttribute("result","fail");
		}
		
		DataMap requestMap = cm.getDataMap();
		requestMap.setNullToInitialize(true);
		requestMap.setString("mode", "ajaxSaveMenuScore");
		
		return "/homepage/eduInfo/reservationconfirmAjaxAction";
	}
	
	public static String getClientIpAddr(HttpServletRequest request) { 
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
	    	ip = request.getRemoteAddr(); 
	    }
	    
	    return ip;
	}
}
