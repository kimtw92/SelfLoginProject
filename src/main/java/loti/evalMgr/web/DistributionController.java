package loti.evalMgr.web;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import loti.evalMgr.service.DistributionService;

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
import ut.lib.util.Util;
import common.controller.BaseController;

@Controller
public class DistributionController extends BaseController {
	
	@Autowired
	private DistributionService distributionService;
	
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
			
			mode = Util.getValue(requestMap.getString("mode"));
			if(requestMap.getString("mode").equals("")) {
				mode = "list";
				requestMap.setString("mode", mode);
			}
			
			//관리자 로그인 체크 (관리자 페이지에는 모두 있어야 함.)
			LoginInfo memberInfo = LoginCheck.adminCheck(request, response, menuId);
			if (memberInfo == null) {
				return null;
			}
			
			//공통 Comm Select Box 값 초기 셋팅.
			HttpSession session = request.getSession(); //세션
			if (requestMap.getString("commYear").equals("")) {
				requestMap.setString("commYear", (String)session.getAttribute("sess_year"));
			}
			if (requestMap.getString("commGrcode").equals("")) {
				requestMap.setString("commGrcode", (String)session.getAttribute("sess_grcode"));
			}
			if (requestMap.getString("commGrseq").equals("")) {
				requestMap.setString("commGrseq", (String)session.getAttribute("sess_grseq"));
			}
			if (requestMap.getString("commSubj").equals("")) {
				requestMap.setString("commSubj", (String)session.getAttribute("sess_subj"));
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
	 * 기간별 리스트 
	 */
	@RequestMapping(value="/evalMgr/distribution.do", params = "mode=date_list")
	public String dateList(@ModelAttribute("cm")CommonMap cm, Model model) throws BizException {
		DataMap requestMap = cm.getDataMap();
		requestMap.setNullToInitialize(true);
		
		//사용자 정보 추출.
		//LoginInfo loginInfo = (LoginInfo)cm.getRequest().getAttribute("LOGIN_INFO");
		
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("started", requestMap.getString("a_started"));
		paramMap.put("enddate", requestMap.getString("a_enddate"));
		//개인 그룹 공지 관리 리스트
		//총점/직급/기관/연령/성별
		DataMap totMap = distributionService.selectDateList(paramMap);
		DataMap jikMap = distributionService.selectJikList(paramMap);
		DataMap deptMap = distributionService.selectDeptList(paramMap);
		DataMap ageMap = distributionService.selectAgeList(paramMap);
		DataMap sexMap = distributionService.selectSexList(paramMap);
		
		model.addAttribute("TOT_DATA", totMap);
		model.addAttribute("JIK_DATA", jikMap);
		model.addAttribute("DEPT_DATA", deptMap);
		model.addAttribute("AGE_DATA", ageMap);
		model.addAttribute("SEX_DATA", sexMap);
		
		return "/evalMgr/distribution/dateStats";
	}
	
	/**
	 * 점수별 리스트
	 */
	@RequestMapping(value="/evalMgr/distribution.do", params = "mode=list")
	public String scoreList(@ModelAttribute("cm")CommonMap cm, Model model) throws BizException {
		DataMap requestMap = cm.getDataMap();
		requestMap.setNullToInitialize(true);
		
		//사용자 정보 추출.
		//LoginInfo loginInfo = (LoginInfo)cm.getRequest().getAttribute("LOGIN_INFO");
		
		DataMap optionList = null;
		DataMap paramData = null;
		
		String reportString="";
		
		//select box 옵션 목록
		if(!requestMap.getString("commGrcode").equals("") && !requestMap.getString("commGrseq").equals("")){			
			optionList = distributionService.selectSubjOption(requestMap);		
		}		

		if(!requestMap.getString("commGrcode").equals("") && !requestMap.getString("commGrseq").equals("") && !requestMap.getString("commSubj").equals("")){
			paramData = distributionService.selectScoreParam(requestMap);
			reportString = "window.setTimeout(\"report_dis1()\", 500);";
		}
		
		model.addAttribute("reportString", reportString);
		model.addAttribute("paramData", paramData);
		model.addAttribute("optionList", optionList);
		
		return "/evalMgr/distribution/scoreStats";
	}
	
	/**
	 * 과목별 리스트
	 */
	@RequestMapping(value="/evalMgr/distribution.do", params = "mode=subj_list")
	public String subjList(@ModelAttribute("cm")CommonMap cm, Model model) throws BizException {
		DataMap requestMap = cm.getDataMap();
		requestMap.setNullToInitialize(true);
		
		//사용자 정보 추출.
		//LoginInfo loginInfo = (LoginInfo)cm.getRequest().getAttribute("LOGIN_INFO");
		
		DataMap optionList = null;		
		
		String reportStr="";
		//select box 옵션 목록
		if(!requestMap.getString("commGrcode").equals("") && !requestMap.getString("commGrseq").equals("")){			
			optionList=distributionService.selectSubjOption(requestMap);		
		}				
		if(!requestMap.getString("commGrcode").equals("") && !requestMap.getString("commGrseq").equals("") && !requestMap.getString("commSubj").equals("")){
			reportStr="window.setTimeout(\"report_dis1()\", 500);";
		}
		
		model.addAttribute("reportStr", reportStr);
		model.addAttribute("optionList", optionList);
		
		return "/evalMgr/distribution/subjStats";
	}
	
	/**
	 * 직급/기관/연령별 리스트
	 */
	@RequestMapping(value="/evalMgr/distribution.do", params = "mode=dept_list")
	public String deptList(@ModelAttribute("cm")CommonMap cm, Model model) throws BizException {
		DataMap requestMap = cm.getDataMap();
		requestMap.setNullToInitialize(true);
		
		//사용자 정보 추출.
		//LoginInfo loginInfo = (LoginInfo)cm.getRequest().getAttribute("LOGIN_INFO");
		
		DataMap optionList=null;		
		
		String reportStr="";
		//select box 옵션 목록
		if(!requestMap.getString("commGrcode").equals("") && !requestMap.getString("commGrseq").equals("")){			
			optionList = distributionService.selectSubjOption(requestMap);		
		}				
		if(!requestMap.getString("commGrcode").equals("") && !requestMap.getString("commGrseq").equals("") && !requestMap.getString("commSubj").equals("")){
			reportStr="window.setTimeout(\"report_dis1()\", 500)";
		}
		
		model.addAttribute("reportStr", reportStr);
		model.addAttribute("optionList", optionList);
		
		return "/evalMgr/distribution/deptStats";
	}
}
