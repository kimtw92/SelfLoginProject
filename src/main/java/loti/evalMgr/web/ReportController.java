package loti.evalMgr.web;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import loti.evalMgr.service.ReportService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
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

@Controller("evalMgrReportController")
public class ReportController extends BaseController {

	@Autowired
	@Qualifier("evalMgrReportService")
	private ReportService reportService;
	
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
			if (mode.equals("")) {
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
			if (requestMap.getString("qu").equals("")) {
				requestMap.setString("qu","year");
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
	 * 과제물 미제출자 리스트
	 */
	@RequestMapping(value="/evalMgr/report.do", params = "mode=reportNoneList")
	public String reportNoneList(@ModelAttribute("cm")CommonMap cm, Model model) throws BizException {
		DataMap requestMap = cm.getDataMap();
		requestMap.setNullToInitialize(true);
		
		DataMap listMap = null;
		
		if(requestMap.getString("classno").equals("")){			
			listMap = reportService.selectReportYearList(requestMap.getString("commYear"));			
		}
		
		model.addAttribute("LIST_DATA", listMap);
		
		return "/evalMgr/report/reportAppListByNone";
	}
	
	/**
	 * 상단 검색 뽑아오는 쿼리가 달라 새로운 Ajax로 구현
	 */
	@RequestMapping(value="/evalMgr/report.do", params = "mode=selectReportAjaxList")
	public String selectReportAjaxList(@ModelAttribute("cm")CommonMap cm, Model model) throws BizException {
		DataMap requestMap = cm.getDataMap();
		requestMap.setNullToInitialize(true);
		
		DataMap listMap = null;
		
		if (requestMap.getString("qu").equals("year")) {
			//년도 가져오기
			listMap = reportService.selectReportYearList(Util.getValue(requestMap.getString("commYear")));
		} else if (requestMap.getString("qu").equals("grcode")) {
			// 과정코드 가져오기
			listMap = reportService.selectReportGrCodeList(requestMap);
		} else if (requestMap.getString("qu").equals("grseq")) {
			//기수 가져오기
			listMap = reportService.selectReportGrSeqList(requestMap);
		} else if (requestMap.getString("qu").equals("classno")) {
			//반정보 가져오기
			listMap = reportService.selectReportClassNoList(requestMap);
		} else if (requestMap.getString("qu").equals("end")) {
			//반정보 가져오기
			 listMap = reportService.selectReportList(requestMap);
		}
		
		model.addAttribute("LIST_DATA", listMap);
		
		return "/evalMgr/report/selectReportAjaxList";
	}
	
	/**
	 * 과제물 미제출자 SMS 보내기
	 */
	@RequestMapping(value="/evalMgr/report.do", params = "mode=smsPop")
	public String smsPop(@ModelAttribute("cm")CommonMap cm, Model model) throws BizException {
		DataMap requestMap = cm.getDataMap();
		requestMap.setNullToInitialize(true);
		
		DataMap endDate = new DataMap();
		DataMap stuList = new DataMap();
		//제출 마감 날짜
		endDate = reportService.selectReportEndDate(requestMap);
		//해당 과목 학생 리스트
		stuList = reportService.selectReportStudentList(requestMap);
		
		model.addAttribute("endDate", endDate);
		model.addAttribute("stuList", stuList);
		
		return "/evalMgr/report/smsPop";
	}
	
	/**
	 * SMS 데이터 입력 처리
	 */
	@RequestMapping(value="/evalMgr/report.do", params = "mode=smsPopExec")
	public String smsPopExec(@ModelAttribute("cm")CommonMap cm, Model model) throws BizException {
		DataMap requestMap = cm.getDataMap();
		requestMap.setNullToInitialize(true);
		
		String msg = requestMap.getString("msg");
		String[] resno = cm.getRequest().getParameterValues("h_resno[]");
		String inStr="";
		
		//과정명
		DataMap grname = reportService.selectReportGrcodeNm(requestMap.getString("commGrcode"));
		
		//메세지에 과정명 입력
		String msgReplace = msg.replaceAll("grname", grname.getString("grcodenm"));
		String rmsg = "";
		String resultType = "";
		DataMap insertList = new DataMap();
		DataMap list = new DataMap();
		
		if(resno.length > 0){
			Map<String, Object> paramMap = new HashMap<String, Object>();
			paramMap.put("commGrcode", requestMap.getString("commGrcode"));
			paramMap.put("commGrseq", requestMap.getString("commGrseq"));
			paramMap.put("commSubj", requestMap.getString("commSubj"));
			paramMap.put("classno", requestMap.getString("classno"));
			paramMap.put("dates", requestMap.getString("dates"));
			
			for(int i=0;i<resno.length;i++){
				//체크된 사람들의 resno 리스트
				inStr +="'"+resno[i]+"'";
				if(i != (resno.length-1)){
					inStr+=",";
				}
			}
			
			paramMap.put("inStr", inStr);
			
			//체크된 학생들의 정보
			insertList=reportService.selectReportNoSMSList(paramMap);
			
			//학생들의 정보를 가지고 insert를 수행한다. 실제 입력된 학생들 정보를 리턴 받는다
			list = reportService.insertSMSList(insertList, msgReplace);
			if (list.keySize("name") > 0) {
				rmsg = "저장되었습니다";
				resultType = "ok";
			} else {
				rmsg = "저장시 오류가 발생하였습니다";
				resultType = "saveError";
			}
		}
		
		model.addAttribute("insertList", list);
		model.addAttribute("RESULT_MSG", rmsg);
		model.addAttribute("RESULT_TYPE", resultType);
		
		return "/evalMgr/report/smsPopExec";
	}
}
