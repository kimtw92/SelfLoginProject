package loti.homeFront.web;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import ut.lib.support.CommonMap;
import ut.lib.support.DataMap;

import common.controller.BaseController;

@Controller
public class CpController extends BaseController {

	@ModelAttribute("cm")
	public CommonMap common(
				CommonMap cm
				, HttpServletRequest request
				, HttpServletResponse response
			){
		
		/**
		 * 필수
		 */
		DataMap requestMap = cm.getDataMap();
		requestMap.setNullToInitialize(true);				
		
		request.setAttribute("REQUEST_DATA", requestMap);
		
		return cm;
	}
	
	@RequestMapping(value="/homepage/cp", params="mode=main")
	public String main(){
		return "/CP/checkplus_main";
	}
	
	@RequestMapping(value="/homepage/cp", params="mode=success")
	public String success(){
		return "/CP/checkplus_success";
	}
	
	@RequestMapping(value="/homepage/cp", params="mode=fail")
	public String fail(){
		return "/CP/checkplus_fail";
	}
}
