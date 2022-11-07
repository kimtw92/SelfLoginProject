package loti.homepageMgr.web;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import loti.homepageMgr.service.PersonInfoService;

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
public class PersonInfoController extends BaseController {

	@Autowired
	private PersonInfoService personInfoService;
	
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
	 * 개인정보조회출력
	 */
	@RequestMapping(value="/homepageMgr/personInfo.do", params="mode=list")
	public String list(@ModelAttribute("cm") CommonMap cm, Model model) throws BizException {
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
		
		DataMap listMap = personInfoService.selectPersonInfoList(requestMap);
		
		model.addAttribute("LIST_DATA", listMap);
		
		return "/homepageMgr/personInfo/personInfoList";
	}
	
	/**
	 * 개인정보조회 excel출력
	 */
	@RequestMapping(value="/homepageMgr/personInfo.do", params="mode=excel")
	public String excel(@ModelAttribute("cm") CommonMap cm, Model model) throws BizException {
		DataMap requestMap = cm.getDataMap();
		requestMap.setNullToInitialize(true);
		
		DataMap listMap = personInfoService.selectPersonInfoExcel(requestMap);
		
		model.addAttribute("LIST_DATA", listMap);
		
		return "/homepageMgr/personInfo/personInfoExcel";
	}
}
