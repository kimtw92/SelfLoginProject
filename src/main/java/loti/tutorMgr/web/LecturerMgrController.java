package loti.tutorMgr.web;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import loti.common.service.CommonService;
import loti.homeFront.service.LecturerService;
import loti.tutorMgr.service.LecturerMgrService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import ut.lib.login.LoginCheck;
import ut.lib.login.LoginInfo;
import ut.lib.support.CommonMap;
import ut.lib.support.DataMap;
import ut.lib.util.Util;

import common.controller.BaseController;

@Controller
public class LecturerMgrController extends BaseController {

	private Map<String, String> views;
	
	public LecturerMgrController() {
		this.views = new HashMap<String, String>();
	}
	
	@Autowired
	private LecturerMgrService lecturerMgrService;
	
	@Autowired
	private LecturerService lecturerService;
	
	@Autowired
	private CommonService commonService;
	
	@ModelAttribute("cm")
	public CommonMap common(
				CommonMap cm
				, HttpServletRequest request
				, HttpServletResponse response
			) throws Exception{
		
		// 리퀘스트 받기
		DataMap requestMap = cm.getDataMap();
		requestMap.setNullToInitialize(true);

		String mode = Util.getValue(requestMap.getString("mode"));
		String name = Util.getValue(requestMap.getString("name"));	
		String checkyn = Util.getValue(requestMap.getString("checkyn"));	
		
		//관리자 로그인 체크
		LoginInfo memberInfo = null;
		
		if(mode.equals("searchTutorPop") || 
				mode.equals("checkResId") ||
				mode.equals("searchSubjPop")	){
			memberInfo = LoginCheck.adminCheckPopup(request, response);
		}else{
			memberInfo = LoginCheck.adminCheck(request, response, requestMap.getString("menuId") );
		}
		
		if (memberInfo == null){			
			return null;
		}
		
		request.setAttribute("REQUEST_DATA", requestMap);
		request.setAttribute("mode", mode);
		request.setAttribute("name", name);
		
		return cm;
	}
	
	public String findView(String mode, String defaultView){
		String view = views.get(mode);
		if(view == null){
			return defaultView;
		}else{
			return view;
		}
	}
	
	public void selectLecturerInfoList (
			Model model
			, DataMap requestMap) throws Exception {
			
		DataMap lecturerInfoList = null;

		if (requestMap.getString("rowSize").equals(""))		requestMap.setInt("rowSize", 10);
		lecturerInfoList = lecturerMgrService.selectLecturerInfoList(requestMap);
		
		model.addAttribute("LECTURERINFO_LIST", lecturerInfoList);
	}
	
	@RequestMapping(value="/tutorMgr/lecturerInfoList.do", params="mode=lecturerInfoList")
	public String lecturerInfoList(
				@ModelAttribute("cm") CommonMap cm
				, Model model
			) throws Exception{
		
		String checkyn = Util.getValue(cm.getDataMap().getString("checkyn"));	
		model.addAttribute("checkyn", checkyn);
		selectLecturerInfoList(model, cm.getDataMap());
		
		return findView(cm.getDataMap().getString("mode"), "/tutorMgr/tutorMgr/LecturerInfoList");
	}
	
	public void viewLecturerInfoPopup (
			Model model
			, DataMap requestMap
			, LoginInfo memberInfo
			, String seqno
			, HttpSession session) throws Exception {
		
		String groupFileNo = lecturerService.getLecturerFileNo(seqno);
		
		model.addAttribute("groupFileNo", groupFileNo);
		model.addAttribute("LECTURER_LIST" , lecturerService.getLecturerView(seqno));
		model.addAttribute("LECTURER_HISTORY_LIST1" , lecturerService.lecturerHistoryList(seqno, "1"));
		model.addAttribute("LECTURER_HISTORY_LIST2" , lecturerService.lecturerHistoryList(seqno, "2"));
		model.addAttribute("LECTURER_HISTORY_LIST3" , lecturerService.lecturerHistoryList(seqno, "3"));
		model.addAttribute("LECTURER_HISTORY_LIST4" , lecturerService.lecturerHistoryList(seqno, "4"));
		
		try {
			if(!"".equals(groupFileNo)) {
				model.addAttribute("FILE_GROUP_LIST", commonService.selectUploadFileList(Integer.valueOf(groupFileNo)));
			}	
		} catch(Exception e) {
			
		}
		
		/*
		 * 	파일 다운로드 세션으로 처리
		 * */
		session.setAttribute("filedownload_admin_yn", memberInfo.getSessAdminYN());
	}
	
	@RequestMapping(value="/tutorMgr/lecturerInfoList.do", params="mode=viewLecturerInfoPopup")
	public String viewLecturerInfoPopup(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			, @RequestParam(value="seqno", required=false, defaultValue="") String seqno
			, HttpSession session
			) throws Exception{
		
		viewLecturerInfoPopup(model, cm.getDataMap(), cm.getLoginInfo(), seqno, session);
		
		return findView(cm.getDataMap().getString("mode"), "/tutorMgr/tutorMgr/viewLecturerInfoPopup");
	}
	
	public void getAjaxCheckYN (
			Model model
			, DataMap requestMap) throws Exception {
		
			model.addAttribute("checkyn", lecturerMgrService.getAjaxCheckYN(requestMap));
		}
	
	@RequestMapping(value="/tutorMgr/lecturerInfoList.do", params="mode=ajaxCheckYN")
	public String ajaxCheckYN(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			) throws Exception{
		
		getAjaxCheckYN(model, cm.getDataMap());
		
		return findView(cm.getDataMap().getString("mode"), "/tutorMgr/tutorMgr/ajaxCheckYN");
	}
	
	public void getAjaxUpdateYN (
			Model model
			, DataMap requestMap) throws Exception {
		
		requestMap.setString("checkyn", "Y");
		model.addAttribute("errorcode", lecturerMgrService.getAjaxUpdakYN(requestMap));
	}
	
	@RequestMapping(value="/tutorMgr/lecturerInfoList.do", params="mode=ajaxUpdateYN")
	public String ajaxUpdateYN(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			) throws Exception{
		
		getAjaxUpdateYN(model, cm.getDataMap());
		
		return findView(cm.getDataMap().getString("mode"), "/tutorMgr/tutorMgr/ajaxUpdateYN");
	}
}
