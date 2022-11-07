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

import ut.lib.login.LoginCheck;
import ut.lib.login.LoginInfo;
import ut.lib.support.CommonMap;
import ut.lib.support.DataMap;

import common.controller.BaseController;

@Controller
public class PageAdminInfoController extends BaseController {

	@Autowired
	private CommonService commonService;
	
	@ModelAttribute("cm")
	public CommonMap common(
				CommonMap cm
				, HttpServletRequest request
				, HttpServletResponse response
				, Model model
			) throws Exception{
		
		DataMap requestMap = cm.getDataMap();
		requestMap.setNullToInitialize(true);
		
		LoginInfo memberInfo = LoginCheck.adminCheck(request, response, requestMap.getString("menuId"));
		if (memberInfo == null) return null;
		if(requestMap.getString("mode").equals(""))
			requestMap.setString("mode", "list");
		
		request.setAttribute("REQUEST_DATA", requestMap);
		
		return cm;
	}
	
	public String findView(String mode, String defaultView){
		
		if("pageAdminInfoAjaxAction".equals(mode)){
			return "/homepage/eduInfo/reservationconfirmAjaxAction";
		}
		
		return defaultView;
	}
	
	@RequestMapping(value="/homepageMgr/pageAdminInfo.do")
	public String defaultProcess(
			@ModelAttribute("cm") CommonMap cm
			, Model model
		) throws Exception{
		return list(cm, model);
	}
	
	/**
	 * 페이지별관리자목록정보
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @param requestMap
	 * @throws Exception
	 */
	public void pageAdmininfoList (
			Model model
			, DataMap requestMap) throws Exception {
		//리스트
		DataMap listMap = null;	
		listMap = commonService.selectPageAdminInfoList();
	
		model.addAttribute("LIST_DATA", listMap);
	}
	
	@RequestMapping(value="/homepageMgr/pageAdminInfo.do", params="mode=list")
	public String list(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			) throws Exception{
		
		DataMap requestMap = cm.getDataMap();
		
		pageAdmininfoList(model, requestMap);
		
		return findView(requestMap.getString("mode"), "/homepageMgr/pageAdminInfo/pageAdminInfo");
	}
	
	/**
	 * 페이지별 관리자 수정
	 * @throws Exception
	 */
	public void ajaxSavePageAdmininfo (
		Model model
		, DataMap requestMap
		, HttpServletRequest request
		) throws Exception {
		
		String menucode = StringUtil.nvl(request.getParameter("menucode"), "");
		String deptname = StringUtil.nvl(request.getParameter("deptname"), "");
		String adminName = StringUtil.nvl(request.getParameter("adminName"), "");
		String adminTel = StringUtil.nvl(request.getParameter("adminTel"), "");
		String adminUseyn = StringUtil.nvl(request.getParameter("adminUseyn"), "");
	
		int errorCode = commonService.savePageAdmininfo(menucode, deptname, adminName, adminTel, adminUseyn);

		if(errorCode > 0){
			request.setAttribute("result","ok");
		}else{
			request.setAttribute("result","fail");
		}
	}
	
	@RequestMapping(value="/homepageMgr/pageAdminInfo.do", params="mode=ajaxSavePageAdmininfo")
	public String pageAdminInfoAjaxAction(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			, HttpServletRequest request
			) throws Exception{
		
		DataMap requestMap = cm.getDataMap();
		
		pageAdmininfoList(model, requestMap);
		
		ajaxSavePageAdmininfo(model, requestMap, request);
		requestMap.setString("mode", "pageAdminInfoAjaxAction");
		
		return findView(requestMap.getString("mode"), "/homepage/eduInfo/reservationconfirmAjaxAction");
	}
	
}
