package loti.homepageMgr.web;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import loti.homepageMgr.service.HtmlService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import ut.lib.exception.BizException;
import ut.lib.login.LoginCheck;
import ut.lib.login.LoginInfo;
import ut.lib.support.CommonMap;
import ut.lib.support.DataMap;
import ut.lib.util.Constants;
import ut.lib.util.Util;
import common.controller.BaseController;

@Controller("homepageMgrHtmlController")
public class HtmlController extends BaseController {

	@Autowired
	@Qualifier("homepageMgrHtmlService")
	private HtmlService htmlService;
	
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
	
	/**
	 * html관리 리스트
	 */
	@RequestMapping(value="/homepageMgr/html.do", params="mode=list")
	public String list(@ModelAttribute("cm") CommonMap cm, Model model) throws BizException{
		DataMap requestMap = cm.getDataMap();
		requestMap.setNullToInitialize(true);
		
		if (requestMap.getString("currPage").equals("")) {
			requestMap.setInt("currPage", 1);
		}
		if (requestMap.getString("rowSize").equals("")) {
			requestMap.setInt("rowSize", 15);
		}
		if (requestMap.getString("pageSize").equals("")) {
			requestMap.setInt("pageSize", 10);
		}
		
		DataMap listMap = htmlService.selectHtmlList(requestMap);
		model.addAttribute("LIST_DATA", listMap);
		
		return "/homepageMgr/html/htmlList";
	}
	
	/**
	 * html관리 리스트
	 */
	@RequestMapping(value="/homepageMgr/html.do", params="mode=view")
	public String view(@ModelAttribute("cm") CommonMap cm, Model model) throws BizException{
		DataMap requestMap = cm.getDataMap();
		requestMap.setNullToInitialize(true);
		
		DataMap rowMap = htmlService.selectHtmlRow(requestMap.getString("htmlId"));
		model.addAttribute("ROWMAP_DATA", rowMap);
		
		return "/homepageMgr/html/htmlView";
	}
	
	/**
	 * html관리 폼
	 */
	@RequestMapping(value="/homepageMgr/html.do", params="mode=form")
	public String form(@ModelAttribute("cm") CommonMap cm, Model model) throws BizException{
		DataMap requestMap = cm.getDataMap();
		requestMap.setNullToInitialize(true);
		
		DataMap rowMap = null;
		
		if(requestMap.getString("qu").equals("insert")){
			rowMap = new DataMap();
		}else if(requestMap.getString("qu").equals("modify")){
			rowMap = htmlService.selectHtmlRow(requestMap.getString("htmlId"));
		}
		
		model.addAttribute("ROWMAP_DATA", rowMap);
		
		return "/homepageMgr/html/htmlForm";
	}
	
	/**
	 * html관리 등록,수정,삭제 실행
	 */
	@RequestMapping(value="/homepageMgr/html.do", params="mode=exec")
	public String exec(@ModelAttribute("cm") CommonMap cm, Model model) throws BizException{
		DataMap requestMap = cm.getDataMap();
		requestMap.setNullToInitialize(true);
		
		//	초기화 옵션(true 일경우 데이터를 뽑을때 null 일경우 초기화 - 빈문자열, 0....)
		requestMap.setNullToInitialize(true);
		
		DataMap faqRowMap = null;
		//성공유부 리턴 변수 
		int returnValue = 0;
		if(!requestMap.getString("qu").equals("delete")){
			//삭제 모드가 아닐경우 디코딩 해준다
			try {
				Util.saveNamoContent(requestMap, "content", "namoContent", Constants.NAMOUPLOAD_FAQ); //나모로 넘어온값 처리.
			} catch (Exception e) {
				throw new BizException(e);
			} finally {
				
			}
		}
		
		if(requestMap.getString("qu").equals("insert")){
			//등록 시작
			returnValue = htmlService.insertHtml(requestMap);
		}else if(requestMap.getString("qu").equals("modify")){
			//수정시작
			returnValue = htmlService.modifyHtml(requestMap);
			
			if(returnValue > 0){//성공여부 메시지 처리
				requestMap.setString("msg","수정 하였습니다.");
			}else{
				requestMap.setString("msg","실패하였습니다..");
			}
		}else if(requestMap.getString("qu").equals("delete")){
			//삭제 시작
			returnValue = htmlService.deleteHtml(requestMap.getString("htmlId"));
			
			if(returnValue > 0){//성공여부 메시지 처리
				requestMap.setString("msg","삭제 하였습니다.");
			}else{
				requestMap.setString("msg","실패하였습니다..");
			}
		}
		
		model.addAttribute("FAQROW_DATA", faqRowMap);
		
		return "/homepageMgr/html/htmlExec";
	}
}
