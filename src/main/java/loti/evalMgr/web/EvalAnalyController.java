package loti.evalMgr.web;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import loti.evalMgr.service.EvalAnalyService;

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
public class EvalAnalyController extends BaseController {
	
	@Autowired
	private EvalAnalyService evalAnalyService;
	
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
			if (requestMap.getString("commClass").equals("")) {
				requestMap.setString("commClass", (String)session.getAttribute("sess_class"));
			}
			if (requestMap.getString("commDept").equals("")) {
				requestMap.setString("commDept", (String)session.getAttribute("sess_dept"));
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
	 * 평가점수조회
	 */
	@RequestMapping(value="/evalMgr/evalAnaly.do", params = "mode=score")
	public String scoreList(@ModelAttribute("cm")CommonMap cm, Model model) throws BizException {
		DataMap requestMap = cm.getDataMap();
		requestMap.setNullToInitialize(true);
		
		//사용자 정보 추출.
		//LoginInfo loginInfo = (LoginInfo)cm.getRequest().getAttribute("LOGIN_INFO");
		
		//총점
		DataMap totData = evalAnalyService.selectScoreTotData(requestMap);
		//평균
		DataMap avgData = evalAnalyService.selectScoreAvgData(requestMap);		
		if(!avgData.getString("avgpoint").equals("") && !avgData.getString("avgpoint").equals("0")){
			avgData.setString("avgpoint",avgData.getString("avgpoint"));		
		}
		
		//리스트
		DataMap scoreList = evalAnalyService.selectScoreList(requestMap);
		
		model.addAttribute("TOT_DATA", totData);
		model.addAttribute("AVG_DATA", avgData);
		model.addAttribute("SCORE_LIST", scoreList);
		
		return "/evalMgr/evalAnaly/scoreList";
	}
	
	/**
	 * 평가결과 분석 리스트
	 */
	@RequestMapping(value="/evalMgr/evalAnaly.do", params = "mode=analyList")
	public String analyList(@ModelAttribute("cm")CommonMap cm, Model model) throws BizException {
		DataMap requestMap = cm.getDataMap();
		requestMap.setNullToInitialize(true);
		
		String reportString = "";
		DataMap resultMap = null;
		if(!requestMap.getString("commGrcode").equals("") && !requestMap.getString("commGrseq").equals("") && !requestMap.getString("commSubj").equals("") && !requestMap.getString("ptype").equals("")){
			resultMap = evalAnalyService.selectAnalyListParam(requestMap);	
			
			//평가유형 타입 입력
			if (requestMap.getString("ptype").equals("M")) {
				resultMap.setString("a_ptype_nm", "중간평가");
			} else if (requestMap.getString("ptype").equals("T")) {
				resultMap.setString("a_ptype_nm", "최종평가");
			} else if (requestMap.getString("ptype").equals("1")) {
				resultMap.setString("a_ptype_nm", "상시1회평가");
			} else if (requestMap.getString("ptype").equals("2")) {
				resultMap.setString("a_ptype_nm", "상시2회평가");
			} else if (requestMap.getString("ptype").equals("3")) {
				resultMap.setString("a_ptype_nm", "상시3회평가");
			} else if (requestMap.getString("ptype").equals("4")) {
				resultMap.setString("a_ptype_nm", "상시4회평가");
			} else if (requestMap.getString("ptype").equals("5")) {
				resultMap.setString("a_ptype_nm", "상시5회평가");
			}
			
			int mscore = Integer.parseInt(resultMap.getString("mscore"));
			int totaledu = Integer.parseInt(resultMap.getString("totaledu"));
			String v_avgpoint = "";
			if(totaledu == 0) {
				v_avgpoint = "0"; 
			} else {
				mscore += mscore*100;
				totaledu += totaledu*100;				
				v_avgpoint = String.valueOf(Math.round(mscore/totaledu)/100);
			}			
			reportString = "window.setTimeout(\"report_dis1()\", 500)";
			resultMap.setString("v_avgpoint", v_avgpoint);
		}
		requestMap.setString("reportString", reportString);
		model.addAttribute("resultMap", resultMap);
		
		return "/evalMgr/evalAnaly/evalAnalyList";
	}
	
	/**
	 * 과정평균 추이도
	 */
	@RequestMapping(value="/evalMgr/evalAnaly.do", params = "mode=courseHistory")
	public String courseHistory(@ModelAttribute("cm")CommonMap cm, Model model) throws BizException {
		DataMap requestMap = cm.getDataMap();
		requestMap.setNullToInitialize(true);

		DataMap grcodeMap=null;
		if(requestMap.getString("startyear").equals("")){
			java.util.Date today = new java.util.Date(); 
			java.text.DateFormat df = new java.text.SimpleDateFormat("yyyy");
			String strDate = df.format(today);
			requestMap.setString("startyear",	strDate );			
		}
		
		if(requestMap.getString("endyear").equals("")){
			java.util.Date today = new java.util.Date(); 
			java.text.DateFormat df = new java.text.SimpleDateFormat("yyyy");
			String strDate = df.format(today);
			requestMap.setString("endyear",	strDate );			
		}
		
		grcodeMap = evalAnalyService.selectCourseHistoryGrcode();
		model.addAttribute("grcodeMap", grcodeMap);
		
		return "/evalMgr/evalAnaly/evalAnalyCourseHistory";
	}
	
	/**
	 * 과목평균추이도

	 */
	@RequestMapping(value="/evalMgr/evalAnaly.do", params = "mode=subjHistory")
	public String subjHistory(@ModelAttribute("cm")CommonMap cm, Model model) throws BizException {
		DataMap requestMap = cm.getDataMap();
		requestMap.setNullToInitialize(true);
		
		if(requestMap.getString("startyear").equals("")){
			java.util.Date today = new java.util.Date(); 
			java.text.DateFormat df = new java.text.SimpleDateFormat("yyyy");
			String strDate = df.format(today);
			requestMap.setString("startyear",	strDate );			
		}
		
		if(requestMap.getString("endyear").equals("")){
			java.util.Date today = new java.util.Date(); 
			java.text.DateFormat df = new java.text.SimpleDateFormat("yyyy");
			String strDate = df.format(today);
			requestMap.setString("endyear",	strDate );			
		}
		
		return "/evalMgr/evalAnaly/evalAnalySubjHistory";
	}
}
