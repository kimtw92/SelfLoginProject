package loti.common.web;

import javax.servlet.http.HttpServletRequest;

import loti.mypage.service.MyClassService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import ut.lib.login.LoginInfo;
import ut.lib.support.CommonMap;
import ut.lib.support.DataMap;
import ut.lib.util.Util;

import common.controller.BaseController;

@Controller
public class PopupController extends BaseController {

	@Autowired
	private MyClassService myClassService;
	
	@ModelAttribute("cm")
	public CommonMap common(
				CommonMap cm
				, HttpServletRequest request
			){
		
		// 리퀘스트 받기
		DataMap requestMap = cm.getDataMap();
		requestMap.setNullToInitialize(true);
		
		//관리자 로그인 체크
		LoginInfo loginInfo = (LoginInfo)request.getAttribute("LOGIN_INFO");
		
		String mode = Util.getValue(requestMap.getString("mode"));
		
		if(loginInfo.isLogin() == false){
			// 로그인 안되어 있음
			System.out.println("로그인 안되어 있음");
			mode = "LoginForm";
			requestMap.setString("mode", mode);
		} else {
			requestMap.setString("userno", loginInfo.getSessNo());
			requestMap.setString("userName", loginInfo.getSessName());
			requestMap.setString("userId", loginInfo.getSessUserId());
		}
		
		//리퀘스트 정보를 담고있는 DataMap을 Attribute 에 추가
		request.setAttribute("REQUEST_DATA", requestMap);
		
		return cm;
	}
	
	public String findView(String mode, String defaultView){
		
		if("LoginForm".equals(mode)){
			return "redirect:/"; // 실소스에 LoginForm의 path를 못찾음
		}
		
		return defaultView;
	}
	
	public void attendList(
			Model model
	        , DataMap requestMap) throws Exception {
				
		
		DataMap listMap = null;
		
		// 리스트 가져오기
		listMap = myClassService.attendPopupList(requestMap);
		
		
		model.addAttribute("LIST_DATA", listMap);
	}
	
	@RequestMapping(value="/commonInc/popup.do", params="mode=grcodelist")
	public String grcodelist(
				@ModelAttribute("cm") CommonMap cm
				, Model model
			) throws Exception{
		
		DataMap requestMap = cm.getDataMap();
		
		attendList(model, requestMap);
		
		return findView(requestMap.getString("mode"), "/commonInc/popup/grcodeList");
	}
	
	@RequestMapping(value="/commonInc/popup.do", params="mode=basiclist")
	public String basiclist(
				@ModelAttribute("cm") CommonMap cm
				, Model model
			) throws Exception{
		
		DataMap requestMap = cm.getDataMap();
		
		attendBasicList(model, requestMap);
		
		return findView(requestMap.getString("mode"), "/commonInc/popup/basicList");
	}
	
	public void attendBasicList(
			Model model
	        , DataMap requestMap) throws Exception {
				
		
		DataMap listMap = null;
		
		// 리스트 가져오기
		listMap = myClassService.attendPopupBasicList(requestMap);
		model.addAttribute("LIST_DATA", listMap);
	}
}
