package loti.courseMgr.web;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import loti.courseMgr.service.CourseSeqService;
import loti.courseMgr.service.StudyStaService;

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
import common.controller.BaseController;

@Controller
public class StudyStaController extends BaseController {

	@Autowired
	private StudyStaService studyStaService;
	@Autowired
	private CourseSeqService courseSeqService;
	
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
				mode = "subj_list";
				requestMap.setString("mode", mode);
			}
			
			//관리자 로그인 체크 (관리자 페이지에는 모두 있어야 함.)
			LoginInfo memberInfo = LoginCheck.adminCheck(request, response, menuId);
			if (memberInfo == null) {
				return null;
			}
			
			//공통 Comm Select Box 값 초기 셋팅.
			HttpSession session = cm.getRequest().getSession(); //세션
			if(requestMap.getString("commYear").equals(""))
				requestMap.setString("commYear", (String)session.getAttribute("sess_year"));
			if(!mode.equals("cyber_list") && !mode.equals("cyber_sms") && !mode.equals("cyber_excel")){  //사이버 과정은 제외.
				if(requestMap.getString("commGrcode").equals(""))
					requestMap.setString("commGrcode", (String)session.getAttribute("sess_grcode"));
				if(requestMap.getString("commGrseq").equals(""))
					requestMap.setString("commGrseq", (String)session.getAttribute("sess_grseq"));
				if(requestMap.getString("commSubj").equals(""))
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
	 * 과목별 학습 현황
	 */
	@RequestMapping(value="/courseMgr/studySta.do", params = "mode=subj_list")
	public String subj_list(@ModelAttribute("cm") CommonMap cm, Model model) throws BizException {
		DataMap requestMap = cm.getDataMap();
		requestMap.setNullToInitialize(true);
		
		//사용자 정보 추출.
		LoginInfo loginInfo = (LoginInfo)cm.getRequest().getAttribute("LOGIN_INFO");
		   
		HttpSession session = cm.getRequest().getSession(); //세션
		String sess_ldapcode = (String)session.getAttribute("sess_ldapcode");

		//리스트
		DataMap listMap = studyStaService.selectStuLecBySubjStudyStaList(requestMap, loginInfo, sess_ldapcode);

		model.addAttribute("LIST_DATA", listMap);
		
		return "/courseMgr/studySta/subjStatisticsList";
	}
	
	/**
	 * 전체 학습현황
	 */
	@RequestMapping(value="/courseMgr/studySta.do", params = "mode=total_list")
	public String total_list(@ModelAttribute("cm") CommonMap cm, Model model) throws BizException {
		DataMap requestMap = cm.getDataMap();
		requestMap.setNullToInitialize(true);
		
		//사용자 정보 추출.
		LoginInfo loginInfo = (LoginInfo)cm.getRequest().getAttribute("LOGIN_INFO");
		
		String grcode = requestMap.getString("commGrcode");
		String grseq = requestMap.getString("commGrseq");
		
		DataMap listMap = null; //수강생 리스트
		DataMap subjListMap = null; //과정 기수의 과목 리스트.
		DataMap subjStuPointListMap = null; //과목별 수강생 취득점수
		
		if(!grcode.equals("") && !grseq.equals("")){
			HttpSession session = cm.getRequest().getSession(); //세션
			String sess_ldapcode = (String)session.getAttribute("sess_ldapcode");	
			subjListMap = studyStaService.selectSubjSeqByTotalSubjList(grcode, grseq);
			subjStuPointListMap = studyStaService.selectSubjSeqBySubjPointList(grcode, grseq);
			listMap = studyStaService.selectAppInfoByStuTotPointList(grcode, grseq, loginInfo, sess_ldapcode);
		}else{
			listMap = new DataMap();
			subjListMap = new DataMap();
			subjStuPointListMap = new DataMap();
		}
		
		model.addAttribute("LIST_DATA", listMap);
		model.addAttribute("SUBJ_LIST_DATA", subjListMap);
		model.addAttribute("STUPOINT_LIST_DATA", subjStuPointListMap);
		
		return "/courseMgr/studySta/totalStatisticsList";
	}
	
	/**
	 * 전체 학습현황 엑셀출력
	 */
	@RequestMapping(value="/courseMgr/studySta.do", params = "mode=total_excel")
	public String total_excel(@ModelAttribute("cm") CommonMap cm, Model model) throws BizException {
		DataMap requestMap = cm.getDataMap();
		requestMap.setNullToInitialize(true);
		
		//사용자 정보 추출.
		LoginInfo loginInfo = (LoginInfo)cm.getRequest().getAttribute("LOGIN_INFO");
		
		String grcode = requestMap.getString("commGrcode");
		String grseq = requestMap.getString("commGrseq");
		
		DataMap listMap = null; //수강생 리스트
		DataMap subjListMap = null; //과정 기수의 과목 리스트.
		DataMap subjStuPointListMap = null; //과목별 수강생 취득점수
		
		if(!grcode.equals("") && !grseq.equals("")){
			HttpSession session = cm.getRequest().getSession(); //세션
			String sess_ldapcode = (String)session.getAttribute("sess_ldapcode");	
			subjListMap = studyStaService.selectSubjSeqByTotalSubjList(grcode, grseq);
			subjStuPointListMap = studyStaService.selectSubjSeqBySubjPointList(grcode, grseq);
			listMap = studyStaService.selectAppInfoByStuTotPointList(grcode, grseq, loginInfo, sess_ldapcode);
		}else{
			listMap = new DataMap();
			subjListMap = new DataMap();
			subjStuPointListMap = new DataMap();
		}
		
		model.addAttribute("LIST_DATA", listMap);
		model.addAttribute("SUBJ_LIST_DATA", subjListMap);
		model.addAttribute("STUPOINT_LIST_DATA", subjStuPointListMap);
		
		return "/courseMgr/studySta/totalStatisticsListByExcel";
	}
	
	/**
	 * 과목별 학습현황
	 */
	@RequestMapping(value="/courseMgr/studySta.do", params = "mode=subj_excel")
	public String subj_excel(@ModelAttribute("cm") CommonMap cm, Model model) throws BizException {
		DataMap requestMap = cm.getDataMap();
		requestMap.setNullToInitialize(true);
		
		//사용자 정보 추출.
		LoginInfo loginInfo = (LoginInfo)cm.getRequest().getAttribute("LOGIN_INFO");
		
		String grcode = requestMap.getString("commGrcode");
		String grseq = requestMap.getString("commGrseq");
		
		DataMap listMap = null; //수강생 리스트
		DataMap subjListMap = null; //과정 기수의 과목 리스트.
		DataMap subjStuPointListMap = null; //과목별 수강생 취득점수
		
		if(!grcode.equals("") && !grseq.equals("")){
			HttpSession session = cm.getRequest().getSession(); //세션
			String sess_ldapcode = (String)session.getAttribute("sess_ldapcode");	
			subjListMap = studyStaService.selectSubjSeqByTotalSubjList(grcode, grseq);
			subjStuPointListMap = studyStaService.selectSubjSeqBySubjPointList(grcode, grseq);
			listMap = studyStaService.selectStuLecBySubjStudyStaList(requestMap, loginInfo, sess_ldapcode);
		}else{
			listMap = new DataMap();
			subjListMap = new DataMap();
			subjStuPointListMap = new DataMap();
		}
		
		model.addAttribute("LIST_DATA", listMap);
		model.addAttribute("SUBJ_LIST_DATA", subjListMap);
		model.addAttribute("STUPOINT_LIST_DATA", subjStuPointListMap);
		
		return "/courseMgr/studySta/subjStatisticsListByExcel";
	}
	
	/**
	 * 사이버과목 학습현황
	 */
	public void cyber_list_com(@ModelAttribute("cm") CommonMap cm, Model model) throws BizException {
		DataMap requestMap = cm.getDataMap();
		requestMap.setNullToInitialize(true);
		
		//사용자 정보 추출.
		LoginInfo loginInfo = (LoginInfo)cm.getRequest().getAttribute("LOGIN_INFO");
		
		if(requestMap.getString("searchStartpt").equals(""))
			requestMap.setString("searchStartpt", "0");
		if(requestMap.getString("searchEndpt").equals(""))
			requestMap.setString("searchEndpt", "100");
		
		DataMap listMap = null; //수강생 리스트
		
		if(!requestMap.getString("commGrseq").equals(""))
			listMap = studyStaService.selectCyberStuStudyPointList(requestMap, loginInfo);
		else
			listMap = new DataMap();
		
		model.addAttribute("LIST_DATA", listMap);
	}
	
	/**
	 * 사이버과목 학습현황
	 */
	@RequestMapping(value="/courseMgr/studySta.do", params = "mode=cyber_list")
	public String cyber_list(@ModelAttribute("cm") CommonMap cm, Model model) throws BizException {
		cyber_list_com(cm, model);
		
		return "/courseMgr/studySta/cyberStatisticsList";
	}
	
	/**
	 * 사이버과목 학습현황 엑셀출력
	 */
	@RequestMapping(value="/courseMgr/studySta.do", params = "mode=cyber_excel")
	public String cyber_excel(@ModelAttribute("cm") CommonMap cm, Model model) throws BizException {
		cyber_list_com(cm, model);
		
		return "/courseMgr/studySta/cyberStatisticsListByExcel";
	}
	
	/**
	 * 사이버 과정 학습독려 SMS발송 리스트
	 */
	@RequestMapping(value="/courseMgr/studySta.do", params = "mode=cyber_sms")
	public String cyber_sms(@ModelAttribute("cm") CommonMap cm, Model model) throws BizException {
		DataMap requestMap = cm.getDataMap();
		requestMap.setNullToInitialize(true);
		
		//사용자 정보 추출.
		LoginInfo loginInfo = (LoginInfo)cm.getRequest().getAttribute("LOGIN_INFO");
		
		//회원정보 리스트.
		DataMap listMap = studyStaService.selectCyberSMSStuStudyPointList(requestMap, loginInfo);
		
		model.addAttribute("LIST_DATA", listMap);
		
		return "/courseMgr/studySta/cyberStatisticsListBySMS";
	}
	
	/**
	 * 혼합교육 학습현황
	 */
	public void mix_list_com(@ModelAttribute("cm") CommonMap cm, Model model) throws BizException {
		DataMap requestMap = cm.getDataMap();
		requestMap.setNullToInitialize(true);
		
		//사용자 정보 추출.
		LoginInfo loginInfo = (LoginInfo)cm.getRequest().getAttribute("LOGIN_INFO");
		
		String grcode = requestMap.getString("commGrcode");
		String grseq = requestMap.getString("commGrseq");
		
		if(requestMap.getString("searchStartpt").equals(""))
			requestMap.setString("searchStartpt", "0");
		if(requestMap.getString("searchEndpt").equals(""))
			requestMap.setString("searchEndpt", "100");
		
		DataMap listMap = null; //수강생 리스트
		DataMap subjListMap = null; //과정 기수의 과목 리스트.
		DataMap subjStuPointListMap = null; //과목별 수강생 취득점수
		
		//과정 기수 정보.
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("grcode", requestMap.getString("commGrcode"));
		paramMap.put("grseq", requestMap.getString("commGrseq"));
		
		DataMap grseqMap = courseSeqService.selectGrseqSimpleRow(paramMap);
		if(!grcode.equals("") && !grseq.equals("")){
			subjListMap = studyStaService.selectSubjSeqByCyberSubjList(grcode, grseq);
			subjStuPointListMap = studyStaService.selectSubjSeqByCyberStuPointList(grcode, grseq);
			if(subjStuPointListMap == null) subjStuPointListMap = new DataMap();
			listMap = studyStaService.selectAppInfoByCyberStuTotPointList(requestMap, subjStuPointListMap, loginInfo);
		}else{
			listMap = new DataMap();
			subjListMap = new DataMap();
			subjStuPointListMap = new DataMap();
		}
		
		model.addAttribute("GRSEQ_ROW_DATA", grseqMap);
		model.addAttribute("LIST_DATA", listMap);
		model.addAttribute("SUBJ_LIST_DATA", subjListMap);
		model.addAttribute("STUPOINT_LIST_DATA", subjStuPointListMap);
	}
	
	/**
	 * 혼합교육 학습현황
	 */
	@RequestMapping(value="/courseMgr/studySta.do", params = "mode=mix_list")
	public String mix_list(@ModelAttribute("cm") CommonMap cm, Model model) throws BizException {
		mix_list_com(cm, model);
		
		return "/courseMgr/studySta/mixStatisticsList";
	}
	
	/**
	 * 혼합교육 학습현황
	 */
	@RequestMapping(value="/courseMgr/studySta.do", params = "mode=mix_excel")
	public String mix_excel(@ModelAttribute("cm") CommonMap cm, Model model) throws BizException {
		mix_list_com(cm, model);
		
		return "/courseMgr/studySta/mixStatisticsListByExcel";
	}
	
	/**
	 * 혼합교육 학습현황 독려SMS발송
	 */
	@RequestMapping(value="/courseMgr/studySta.do", params = "mode=mix_sms")
	public String mix_sms(@ModelAttribute("cm") CommonMap cm, Model model) throws BizException {
		DataMap requestMap = cm.getDataMap();
		requestMap.setNullToInitialize(true);
		
		//회원정보 리스트.
		DataMap listMap = studyStaService.selectMemberBySimpleDataList(requestMap);
		
		model.addAttribute("LIST_DATA", listMap);
		
		return "/courseMgr/studySta/mixStatisticsListBySMS";
	}

	/**
	 * 온라인 평가현황 
	 */
	public void online_list_com(CommonMap cm, Model model) throws BizException {
		DataMap requestMap = cm.getDataMap();
		requestMap.setNullToInitialize(true);
		
		//사용자 정보 추출.
		LoginInfo loginInfo = (LoginInfo)cm.getRequest().getAttribute("LOGIN_INFO");
		
		//평가 정보
		DataMap examMap = studyStaService.selectEtestExamRow(requestMap.getString("commExam"));; //과정 기수의 과목 리스트.
		
		//수강생 리스트
		DataMap listMap = studyStaService.selectOnlineExamStuList(requestMap.getString("commGrcode"), requestMap.getString("commGrseq"), requestMap.getString("commExam"), loginInfo);
		
		model.addAttribute("EXAM_ROW_DATA", examMap);
		model.addAttribute("LIST_DATA", listMap);
	}
	
	/**
	 * 온라인 평가현황 
	 */
	@RequestMapping(value="/courseMgr/studySta.do", params = "mode=online_list")
	public String online_list(@ModelAttribute("cm") CommonMap cm, Model model) throws BizException {
		online_list_com(cm, model);
		return "/courseMgr/studySta/onLineExamStatisticsList";
	}
	
	/**
	 * 온라인 평가현황  엑셀출력
	 */
	@RequestMapping(value="/courseMgr/studySta.do", params = "mode=online_excel")
	public String online_excel(@ModelAttribute("cm") CommonMap cm, Model model) throws BizException {
		online_list_com(cm, model);
		
		return "/courseMgr/studySta/onLineExamStatisticsListByExcel";
	}
	
	/**
	 * 온라인평가현황 SMS발송
	 */
	@RequestMapping(value="/courseMgr/studySta.do", params = "mode=online_sms")
	public String online_sms(@ModelAttribute("cm") CommonMap cm, Model model) throws BizException {
		DataMap requestMap = cm.getDataMap();
		requestMap.setNullToInitialize(true);
		
		//수강생 리스트
		DataMap listMap = studyStaService.selectOnlineExamStuListBySms(requestMap);
		
		model.addAttribute("LIST_DATA", listMap);
		
		return "/courseMgr/studySta/onLineExamStatisticsListBySMS";
	}
	
	/**
	 * 학습 독려 SMS 발송 
	 */
	@RequestMapping(value="/courseMgr/studySta.do", params = "mode=sms_exec")
	public String sms_exec(@ModelAttribute("cm") CommonMap cm, Model model) throws BizException {
		DataMap requestMap = cm.getDataMap();
		requestMap.setNullToInitialize(true);
		
		//사용자 정보 추출.
		LoginInfo loginInfo = (LoginInfo)cm.getRequest().getAttribute("LOGIN_INFO");
		
		String qu = requestMap.getString("qu");

		if(qu.equals("cyber_sms")){  //사이버 학습 현황 학습 독려 SMS
			DataMap listMap = studyStaService.insertSmsMsgStudyCyber(requestMap, loginInfo);
			if(listMap == null) listMap = new DataMap();
			
			model.addAttribute("LIST_DATA", listMap);
		}else if(qu.equals("mix_sms")){  //혼합교육 학습 독려 SMS
			DataMap listMap = studyStaService.insertSmsMsgStudyMix(requestMap);
			if(listMap == null) listMap = new DataMap();
			
			model.addAttribute("LIST_DATA", listMap);
		}else if(qu.equals("online_sms")){  //온라인 평가현황 미응시자 SMS
			DataMap listMap = studyStaService.insertSmsMsgStudyOnline(requestMap);
			if(listMap == null) listMap = new DataMap();
			
			model.addAttribute("LIST_DATA", listMap);
		}
		
		return "/courseMgr/mail/courseSMSExecPop";
	}
}
