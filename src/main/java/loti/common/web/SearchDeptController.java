package loti.common.web;

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
public class SearchDeptController extends BaseController {

	@Autowired
	private CommonService commonService;
	
	@ModelAttribute("cm")
	public CommonMap common(
				CommonMap cm
				, HttpServletRequest request
				, HttpServletResponse response
			) throws Exception{
		
		 //요청처리 - get, post 방식의 파라미터를 DataMap 에 저장
		DataMap requestMap = cm.getDataMap();
		//초기화 옵션(true 일경우 데이터를 뽑을때 null 일경우 초기화 - 빈문자열, 0....)
		requestMap.setNullToInitialize(true);
		
		
		//관리자 로그인 체크. (관리자 페이지에는 모두 있어야 함)
		LoginInfo memberInfo = LoginCheck.adminCheckPopup(request, response);
		if (memberInfo == null) return null;
		
		//default mode
		if(requestMap.getString("mode").equals(""))
			requestMap.setString("mode", "list");
		
		//리퀘스트 정보를 담고있는 DataMap을 Attribute 에 추가
		request.setAttribute("REQUEST_DATA", requestMap);
		
		return cm;
	}
	
	public String findView(String mode, String defaultView){
		return defaultView;
	}
	
	@RequestMapping(value="/commonInc/searchDept.do")
	public String defaultProcess(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			) throws Exception{
		return list(cm, model);
	}
	/**
	 * 기관 검색.
	 * @throws Exception 
	 */
	@RequestMapping(value="/commonInc/searchDept.do", params="mode=list")
	public String list(
				@ModelAttribute("cm") CommonMap cm
				, Model model
			) throws Exception{
		
		DataMap requestMap = cm.getDataMap();
		
		//리스트
		DataMap listMap = null;
		
		if( requestMap.getString("search").equals("GO") ){ //검색 버튼을 클릭시.
			
			listMap = commonService.selectDeptSearch(requestMap.getString("searchValue"));
			
		}else{
			
			listMap = new DataMap();
			
		}
		
		model.addAttribute("LIST_DATA", listMap);
		
		return findView(requestMap.getString("mode"), "/commonInc/popup/searchDeptPop");
	}
}
