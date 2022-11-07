package loti.homepageMgr.web;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import loti.homepageMgr.service.PopupService;

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

@Controller("homepageMgrPopupController")
public class PopupController extends BaseController {

	@Autowired
	@Qualifier("homepageMgrPopupService")
	private PopupService popupService;
	
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
		
		request.setAttribute("REQUEST_DATA", requestMap);
		
		return cm;
	}
	
	public String findView(String mode, String defaultView){
		return defaultView;
	}
	
	@RequestMapping(value="/homepageMgr/popup.do")
	public String defaultProcess(
			@ModelAttribute("cm") CommonMap cm
			, Model model
		) throws Exception{
		return list(cm, model);
	}
	
	/**
	 * 팝업관리 리스트
	 * 작성일 : 6월 16일
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
		
		//	초기화 옵션(true 일경우 데이터를 뽑을때 null 일경우 초기화 - 빈문자열, 0....)
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
		
		DataMap listMap = popupService.selectPopupList(requestMap);
		model.addAttribute("LIST_DATA", listMap);
	}
	
	@RequestMapping(value="/homepageMgr/popup.do", params="mode=list")
	public String list(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			) throws Exception{
		
		DataMap requestMap = cm.getDataMap();
		
		list(model, requestMap);
		
		return findView(requestMap.getString("mode"), "/homepageMgr/popup/popupList");
	}
	
	/**
	 * 팝업관리 상세보기
	 * 작성일 : 6월 16일
	 * 작성자 : 정 윤철
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	public void view(
			Model model
	        , DataMap requestMap) throws Exception {
		
		DataMap rowMap = popupService.selectPopupViewRow(requestMap.getInt("no"));
		model.addAttribute("VIEWROW_DATA", rowMap);
	}
	
	@RequestMapping(value="/homepageMgr/popup.do", params="mode=view")
	public String view(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			) throws Exception{
		
		DataMap requestMap = cm.getDataMap();
		
		view(model, requestMap);
		
		return findView(requestMap.getString("mode"), "/homepageMgr/popup/popupView");
	}
	
	/**
	 * 팝업관리 폼
	 * 작성일 : 6월 16일
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
		//	초기화 옵션(true 일경우 데이터를 뽑을때 null 일경우 초기화 - 빈문자열, 0....)
		requestMap.setNullToInitialize(true);
		
		DataMap rowMap = null;
		if(requestMap.getString("qu").equals("modify")){
			//수정 모드
			rowMap = popupService.selectPopupModifyRow(requestMap.getInt("no"));
			
			//데이터를 가져온후 날자의 구분자를 없앤다
			String strDate = rowMap.getString("pstrDate");
			//기존 날짜가 년 - 월 - 일 형식이기때문에 구분자를 빼준다.->[start]<-
			String[] pstrDate = strDate.split("[-]"); 
			 String strDate1 = pstrDate[0];
			 String strDate2 = pstrDate[1];
			 String strDate3 = pstrDate[2];
			 requestMap.setInt("pstrDate", Integer.parseInt(strDate1+strDate2+strDate3));
			 System.out.println("test======================");
			 System.out.println(rowMap.getString("pstrDate"));
			String endDate = rowMap.getString("pendDate");
			String[] pendDate = endDate.split("[-]"); 
			 String endDate1 = pendDate[0];
			 String endDate2 = pendDate[1];
			 String endDate3 = pendDate[2];
			 requestMap.setInt("pendDate", Integer.parseInt(endDate1+endDate2+endDate3));
			 System.out.println("test======================");
			 System.out.println(rowMap.getString("pendDate"));
			 System.out.println(Integer.parseInt(endDate1+endDate2+endDate3));
			 
		}else if(requestMap.getString("qu").equals("insert")){
			rowMap = new DataMap();
		}
		model.addAttribute("FORMROW_DATA", rowMap);
	}
	
	@RequestMapping(value="/homepageMgr/popup.do", params="mode=form")
	public String form(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			) throws Exception{
		
		DataMap requestMap = cm.getDataMap();
		
		form(model, requestMap);
		
		return findView(requestMap.getString("mode"), "/homepageMgr/popup/popupForm");
	}
	
	/**
	 * 팝업관리 등록, 수정, 삭제 실행
	 * 작성일 : 6월 16일
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
		//	초기화 옵션(true 일경우 데이터를 뽑을때 null 일경우 초기화 - 빈문자열, 0....)
		requestMap.setNullToInitialize(true);
		
		DataMap rowMap = null;
		
		//사용여부 수정이 아닐경우 나모 데이터를 처리한다.
		Util.saveDaumContent(requestMap, "content", "namoContent", Constants.NAMOUPLOAD_POPUP); //나모로 넘어온값 처리.
		
		if(requestMap.getString("qu").equals("insert")){
			 
			int maxNo = popupService.selectMaxNoRow();
			//등록
			popupService.insertPopup(requestMap, maxNo);
			requestMap.setInt("no", maxNo);
			requestMap.setString("msg", "등록하였습니다.");
			
		}else if(requestMap.getString("qu").equals("modify")){
			//수정
			popupService.modifyPopup(requestMap);
			requestMap.setString("msg", "수정하였습니다.");
			
		}else if(requestMap.getString("qu").equals("delete")){
			//삭제
			popupService.deletePopup(requestMap.getInt("no"));
			requestMap.setString("msg", "삭제하였습니다.");
		}
		
		model.addAttribute("FORMROW_DATA", rowMap);
	}
	
	@RequestMapping(value="/homepageMgr/popup.do", params="mode=exec")
	public String exec(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			) throws Exception{
		
		DataMap requestMap = cm.getDataMap();
		
		exec(model, requestMap);
		
		return findView(requestMap.getString("mode"), "/homepageMgr/popup/popupExec");
	}

}
