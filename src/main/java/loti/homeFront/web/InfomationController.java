package loti.homeFront.web;

/**
 * prgNM : homepage index
 * auth  : kang
 * date  : 08.08.08
 * default Class
 */

import java.util.Calendar;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import loti.homeFront.service.HtmlService;
import loti.homeFront.service.IntroduceService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import ut.lib.exception.BizException;
import ut.lib.login.LoginInfo;
import ut.lib.support.CommonMap;
import ut.lib.support.DataMap;
import ut.lib.util.Util;

import common.controller.BaseController;

@Controller
public class InfomationController extends BaseController{
	
	@ModelAttribute(value="cm")
	public CommonMap common(CommonMap cm, HttpServletRequest request, HttpSession session, Model model, @RequestParam(value="mode", required=false) String mode) throws BizException{
		
		/**
		 * 로그인 체크
		 */
		LoginInfo loginInfo = (LoginInfo)request.getAttribute("LOGIN_INFO");
		if(loginInfo.isLogin() == false){
			// 로그인 안되어 있음
			log.info("로그인 안되어 있음");
		}

		/**
		 * 페이징 필수
		 */
		
		String currPage = Util.nvl(cm.getDataMap().getString("currPage"));
		String rowSize = Util.nvl(cm.getDataMap().getString("rowSize"));
		String pageSize = Util.nvl(cm.getDataMap().getString("pageSize"));
		
		// 페이지
		if ("".equals(currPage)){
			cm.getDataMap().setInt("currPage", 1);
		}
		// 페이지당 보여줄 갯수
		if ("".equals(rowSize)){
			cm.getDataMap().setInt("rowSize", 10); 
		}
		// 페이지 블럭 갯수
		if ("".equals(pageSize)){
			cm.getDataMap().setInt("pageSize", 10);
		}
		
		// 리퀘스트 정보를 담고있는 DataMap을 Attribute 에 추가
		model.addAttribute("REQUEST_DATA", cm.getDataMap());
		model.addAttribute("LOGIN_INFO", loginInfo);
		
		System.out.println("mode="+mode);
		
		return cm;
	}
	
	@Autowired
	private HtmlService htmlService;
	
	@Autowired
	private IntroduceService introduceService;
	
	@RequestMapping(value="/homepage/infomation.do", params="mode=ht")
	public String ht(CommonMap cm, Model model) throws BizException{
		
		String htmlId = cm.getDataMap().getString("htmlId");		
		
		DataMap listMap = htmlService.htmlTemplete(htmlId);
		
		model.addAttribute("HTML_DATA", listMap);
		
		return "/homepage/htmlTemplete/baseTemplete";
	}
	
	@RequestMapping(value="/homepage/infomation.do", params="mode=eduinfo2-1")
	public String eduinfo2_1() throws BizException{
		return "/homepage/eduInfo/eduinfo2-1";
	}
	@RequestMapping(value="/homepage/infomation.do", params="mode=eduinfo2-2")
	public String eduinfo2_2() throws BizException{
		return "/homepage/eduInfo/eduinfo2-2";
	}
	@RequestMapping(value="/homepage/infomation.do", params="mode=eduinfo2-3")
	public String eduinfo2(@ModelAttribute("cm") CommonMap cm, Model model) throws BizException{
		
		// 일년의  교육과정 AJAX 파라미터를 설정하는 부분 시작	
		
		java.util.Calendar c = java.util.Calendar.getInstance();
		String monthajax = Util.plusZero(c.get(Calendar.MONTH)+1);
		cm.getDataMap().setString("month",monthajax);
		cm.getDataMap().setString("monthajax", monthajax);
		
		model.addAttribute("EDUCATION_MONTH_LIST",introduceService.getEducationMonthAJAXList(cm.getDataMap())  );
		model.addAttribute("REQUEST_DATA", cm.getDataMap());
		
		return "/homepage/eduInfo/eduinfo2-3";
	}
	@RequestMapping(value="/homepage/infomation.do", params="mode=eduinfo2-4")
	public String eduinfo2_4() throws BizException{
		return "/homepage/eduInfo/eduinfo2-4";
	}
	
	@RequestMapping(value="/homepage/infomation.do", params="mode=educationmonthajax")
	public String educationmonthajax(@ModelAttribute("cm") CommonMap cm, Model model, @RequestParam(value="month", defaultValue="") String monthajax) throws BizException{
		
		cm.getDataMap().setString("monthajax", monthajax);
		model.addAttribute("EDUCATION_MONTH_AJAX_LIST",introduceService.getEducationMonthAJAXList(cm.getDataMap())  );
		model.addAttribute("REQUEST_DATA", cm.getDataMap());
		return "/homepage/eduInfo/educationMonthAJAX";
	}
	
}
