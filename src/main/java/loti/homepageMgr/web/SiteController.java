package loti.homepageMgr.web;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import loti.homepageMgr.service.SiteService;

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
public class SiteController extends BaseController {
	
	@Autowired
	private SiteService siteService;
	
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
	
	public String findView(String mode, String defaultView){
		return defaultView;
	}
	
	@RequestMapping(value="/homepageMgr/site.do")
	public String defaultProcess(
			@ModelAttribute("cm") CommonMap cm
			, Model model
		) throws Exception{
		return list(cm, model);
	}
	
	/**
	 * 사이트관리 리스트
	 * 작성일 : 6월 22일
	 * 작성자 : 정 윤철
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	public void list(
			Model model
	        , DataMap requestMap) throws Exception {
	
		if (requestMap.getString("currPage").equals("")) {
			requestMap.setInt("currPage", 1);
		}
		if (requestMap.getString("rowSize").equals("")) {
			requestMap.setInt("rowSize", 15);
		}
		if (requestMap.getString("pageSize").equals("")) {
			requestMap.setInt("pageSize", 10);
		}
		
		DataMap listMap = siteService.selectSiteList(requestMap);
		
		model.addAttribute("LIST_DATA", listMap);
	}
	
	@RequestMapping(value="/homepageMgr/site.do", params="mode=list")
	public String list(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			) throws Exception{
		
		DataMap requestMap = cm.getDataMap();
		
		list(model, requestMap);
		
		return findView(requestMap.getString("mode"), "/homepageMgr/site/siteList");
	}
	
	/**
	 * 사이트관리 폼
	 * 작성일 : 6월 22일
	 * 작성자 : 정 윤철
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	public void form(
			Model model
	        , DataMap requestMap) throws Exception {
	
		DataMap rowMap = null; 
		
		if(requestMap.getString("qu").equals("insert")){
			rowMap = new DataMap();
			
		}else{
			rowMap = siteService.selectSiteRow(requestMap.getInt("siteNo"));
			
		}
		
		model.addAttribute("FORMROW_DATA", rowMap);
	}	
	
	@RequestMapping(value="/homepageMgr/site.do", params="mode=form")
	public String form(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			) throws Exception{
		
		DataMap requestMap = cm.getDataMap();
		
		form(model, requestMap);
		
		return findView(requestMap.getString("mode"), "/homepageMgr/site/siteFormPop");
	}
	
	/**
	 * 사이트관리 등록, 수정, 삭제 실행
	 * 작성일 : 6월 22일
	 * 작성자 : 정 윤철
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	public void exec(
			Model model
	        , DataMap requestMap) throws Exception {
	
		DataMap rowMap = null; 
		int returnValue = 0;
		
		if(requestMap.getString("qu").equals("insert")){//등록
				returnValue = siteService.insertSite(requestMap);
			
			if(returnValue > 0){//등록 성공여부
				requestMap.setString("msg", "등록 하였습니다.");
				
			}else{
				requestMap.setString("msg", "실패하였습니다.");
				
			}
			
		}else if(requestMap.getString("qu").equals("modify")){//수정
			returnValue = siteService.modifySite(requestMap);
			
			if(returnValue > 0){//등록 성공여부
				requestMap.setString("msg", "수정 하였습니다.");
				
			}else{
				requestMap.setString("msg", "실패하였습니다.");
				
			}
			
		}else if(requestMap.getString("qu").equals("delete")){//삭제
			for(int i = 0; requestMap.getInt("keySize") > i; i++ ){
				if(requestMap.getString("check"+i).equals("Y")){
					returnValue = siteService.deleteSite(requestMap.getInt("siteNo"+i));
				}
			}
			
			if(returnValue > 0){//등록 성공여부
				requestMap.setString("msg", "삭제 하였습니다.");
				
			}else{
				requestMap.setString("msg", "실패하였습니다.");
				
			}
			
		}else{
			requestMap.setString("msg", "실패하였습니다.");
		}
		
		model.addAttribute("LIST_DATA", rowMap);
	}	
	
	@RequestMapping(value="/homepageMgr/site.do", params="mode=exec")
	public String exec(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			) throws Exception{
		
		DataMap requestMap = cm.getDataMap();
		
		exec(model, requestMap);
		
		return findView(requestMap.getString("mode"), "/homepageMgr/site/siteExec");
	}
}
