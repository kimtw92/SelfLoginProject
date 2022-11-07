package loti.courseMgr.web;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import loti.courseMgr.service.ResultHtmlService;

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
import ut.lib.util.Constants;
import ut.lib.util.Util;
import common.controller.BaseController;

@Controller
public class ResultHtmlController extends BaseController {

	@Autowired
	private ResultHtmlService resultHtmlService;
	
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
				mode = "view";
				requestMap.setString("mode", mode);
			}
			
			//관리자 로그인 체크 (관리자 페이지에는 모두 있어야 함.)
			LoginInfo memberInfo = LoginCheck.adminCheck(request, response, menuId);
			if (memberInfo == null) {
				return null;
			}
			
			model.addAttribute("REQUEST_DATA", requestMap);
			model.addAttribute("LOGIN_INFO", memberInfo);
		} catch (Exception e) {
			throw new BizException(e);
		} finally {
			
		}
		
		return cm;
	}
	
	/**
	 * 수료증 보기
	 */
	@RequestMapping(value="/courseMgr/resultHtml.do", params = "mode=view")
	public String view(@ModelAttribute("cm")CommonMap cm, Model model) throws BizException {
		DataMap requestMap = cm.getDataMap();
		requestMap.setNullToInitialize(true);
		
		//상세보기
		DataMap rowMap = resultHtmlService.selectResultDocRow(Integer.parseInt(Util.getValue(requestMap.getString("no"), "0")));
		
		model.addAttribute("ROW_DATA", rowMap);
		
		return "/courseMgr/resultHtml/resultHtmlView";
	}
	
	/**
	 * 등록 / 수정
	 */
	@RequestMapping(value="/courseMgr/resultHtml.do", params = "mode=form")
	public String form(@ModelAttribute("cm")CommonMap cm, Model model) throws BizException {
		DataMap requestMap = cm.getDataMap();
		requestMap.setNullToInitialize(true);
		
		//상세보기
		DataMap rowMap = resultHtmlService.selectResultDocRow(requestMap.getInt("no"));
		
		model.addAttribute("ROW_DATA", rowMap);
		
		return "/courseMgr/resultHtml/resultHtmlForm";
	}
	
	/**
	 * 실행
	 */
	@RequestMapping(value="/courseMgr/resultHtml.do", params = "mode=exec")
	public String exec(@ModelAttribute("cm")CommonMap cm, Model model) throws BizException {
		DataMap requestMap = cm.getDataMap();
		requestMap.setNullToInitialize(true);
		
		//사용자 정보 추출.
		LoginInfo loginInfo = (LoginInfo)cm.getRequest().getAttribute("LOGIN_INFO");
		
		String qu = requestMap.getString("qu");
		String msg = "";
		
		//실제 데이터 처리. 
		if(qu.equals("reset")){ //초기값 등록
			//Util.saveNamoContent(requestMap, "content", "namoContent", Constants.NAMOUPLOAD_RESULTHTML); //나모로 넘어온값 처리.
			resultHtmlService.execResultHtmlReset(requestMap, loginInfo.getSessNo());
			msg = "등록 되었습니다.";
		}else if(requestMap.getString("qu").equals("update")){ //수정.
			try {
//				Util.saveNamoContent(requestMap, "content", "namoContent", Constants.NAMOUPLOAD_RESULTHTML); //나모로 넘어온값 처리.
				Util.saveDaumContent(requestMap, "content", "namoContent", Constants.NAMOUPLOAD_RESULTHTML); // naver : method명은 다음으로 되어 있지만 네이버 에디터의 컨텐츠를 받아도 작동한다.
			} catch(Exception e) {
	            throw new BizException(e);
			}
			requestMap.setString("content", requestMap.getString("namoContent"));
			resultHtmlService.updateResultHtml(requestMap, loginInfo.getSessNo());
			msg = "수정 되었습니다.";
		}

		model.addAttribute("RESULT_MSG", msg);
		
		return "/courseMgr/resultHtml/resultHtmlExec";
	}
}
