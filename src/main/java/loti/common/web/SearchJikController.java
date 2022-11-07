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
public class SearchJikController extends BaseController {

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
		LoginInfo memberInfo = LoginCheck.adminCheck(request, response, requestMap.getString("menuId"));
		
		if (memberInfo == null) return null;
		
		return cm;
	}
	
	@RequestMapping(value="/search/searchDept.do")
	public String defaultProcess(
			@ModelAttribute("cm") CommonMap cm
			, Model model
		){
		return form(cm, model);
	}
	
	@RequestMapping(value="/search/searchDept.do", params="mode=form")
	public String form(
				@ModelAttribute("cm") CommonMap cm
				, Model model
			){
		
		//직급검색 폼은  데이터가 없기때문에 전부다 널처리한다.
		DataMap listMap = null;
		
		listMap = new DataMap();
		model.addAttribute("LIST_DATA", listMap);
		
		return "/commonInc/search/searchDeptPop";
	}
	
	@RequestMapping(value="/search/searchDept.do", params="mode=list")
	public String list(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			) throws Exception{
		
		DataMap requestMap = cm.getDataMap();
		
		DataMap listMap = null;
		
		String jiknm = requestMap.getString("jiknm");
		jiknm = "%" + jiknm + "%" ;
		listMap = commonService.selectSearchDept(jiknm);
		
		model.addAttribute("LIST_DATA", listMap);
		
		return "/commonInc/search/searchDeptPop";
	}
}
