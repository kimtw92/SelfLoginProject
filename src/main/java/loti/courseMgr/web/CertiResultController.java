package loti.courseMgr.web;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import loti.courseMgr.service.CertiResultService;
import loti.courseMgr.service.CourseSeqService;
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
import common.controller.BaseController;

@Controller
public class CertiResultController extends BaseController {

	@Autowired
	private CertiResultService certiResultService;
	@Autowired
	private CourseSeqService courseSeqService;
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
				mode = "grcode_list";
				requestMap.setString("mode", mode);
			}
			
			//관리자 로그인 체크 (관리자 페이지에는 모두 있어야 함.)
			LoginInfo memberInfo = LoginCheck.adminCheck(request, response, menuId);
			if (memberInfo == null) {
				return null;
			}
			
			//공통 Comm Select Box 값 초기 셋팅.
			HttpSession session = request.getSession(); //세션
			if(requestMap.getString("commYear").equals(""))
				requestMap.setString("commYear", (String)session.getAttribute("sess_year"));
			
			if(!mode.equals("cyber_list") && !mode.equals("cyber_excel")){
				if(requestMap.getString("commGrcode").equals(""))
					requestMap.setString("commGrcode", (String)session.getAttribute("sess_grcode"));
				if(requestMap.getString("commGrseq").equals(""))
					requestMap.setString("commGrseq", (String)session.getAttribute("sess_grseq"));
				if(mode.equals("subj_list"))  // 과목이수현황은 과목정보가 있음.
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
	 * 기관별 수려자 조회 (수료 EXCEL)
	 */
	@RequestMapping(value="/courseMgr/certiResult.do", params = "mode=gove_excel")
	public String gove_excel(@ModelAttribute("cm") CommonMap cm, Model model) throws BizException {
		DataMap requestMap = cm.getDataMap();
		requestMap.setNullToInitialize(true);
		
		//사용자 정보 추출.
		LoginInfo loginInfo = (LoginInfo)cm.getRequest().getAttribute("LOGIN_INFO");
		
		//기관 담당자 일경우 기관 코드 셋팅.
		if(loginInfo.getSessClass().equals(Constants.ADMIN_SESS_CLASS_DEPT))
			requestMap.setString("searchDept", loginInfo.getSessDept());
		
		if(requestMap.getString("searchOrder").equals(""))
			requestMap.setString("searchOrder", "DEPT");

		//리스트
		
		HttpSession session = cm.getRequest().getSession(); //세션
		String sess_ldapcode = (String)session.getAttribute("sess_ldapcode");
		//리스트
		DataMap listMap = certiResultService.selectGrResultListByDept(requestMap, sess_ldapcode, loginInfo.getSessDept());
		model.addAttribute("LIST_DATA", listMap);
		
		return "/courseMgr/certiResult/goveResultByExcel";
	}
	
	/**
	 * 수료관리(과목/과정전체)
	 */
	@RequestMapping(value="/courseMgr/certiResult.do", params = "mode=grcode_list")
	public String grcode_list(@ModelAttribute("cm") CommonMap cm, Model model) throws BizException {
		DataMap requestMap = cm.getDataMap();
		requestMap.setNullToInitialize(true);
		
		//사용자 정보 추출.
		LoginInfo loginInfo = (LoginInfo)cm.getRequest().getAttribute("LOGIN_INFO");
		
		//과정 기수 정보.
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("grcode", requestMap.getString("commGrcode"));
		paramMap.put("grseq", requestMap.getString("commGrseq"));
		
		DataMap grseqMap = courseSeqService.selectGrseqSimpleRow(paramMap);
		
		//기관 담당자 일경우 기관 코드 셋팅.
		if(loginInfo.getSessClass().equals(Constants.ADMIN_SESS_CLASS_DEPT))
			requestMap.setString("searchDept", loginInfo.getSessDept());
		
		if(requestMap.getString("searchOrder").equals(""))
			requestMap.setString("searchOrder", "DEPT");
		
		//리스트
		DataMap listMap = certiResultService.selectGrResultByAllList(requestMap);

		DataMap resultCntMap = null;
		if(!requestMap.getString("commGrcode").equals("") && !requestMap.getString("commGrseq").equals(""))
			resultCntMap = certiResultService.selectGrResultCompletionCntRow(requestMap.getString("commGrcode"), requestMap.getString("commGrseq"));
		else
			resultCntMap = new DataMap();
		
		//검색시 사용하는 수료자의 기관 리스트
		DataMap grResultDeptList = null;
		if(loginInfo.getSessClass().equals(Constants.ADMIN_SESS_CLASS_ADMIN) 
				|| loginInfo.getSessClass().equals(Constants.ADMIN_SESS_CLASS_COURSE)
				|| loginInfo.getSessClass().equals(Constants.ADMIN_SESS_CLASS_COURSEMAN))
			grResultDeptList = certiResultService.selectGrResultDeptList(requestMap.getString("commGrcode"), requestMap.getString("commGrseq"));
		else
			grResultDeptList = new DataMap();
		
		model.addAttribute("GRSEQ_ROW_DATA", grseqMap);
		model.addAttribute("LIST_DATA", listMap);
		model.addAttribute("RESULT_CNT_ROW_DATA", resultCntMap);
		model.addAttribute("RESULT_DEPT_LIST_DATA", grResultDeptList);
		
		return "/courseMgr/certiResult/grcodeResultList";
	}
	
	/**
	 * 수료관리(과목/과정전체) 엑셀 
	 */
	@RequestMapping(value="/courseMgr/certiResult.do", params = "mode=grcode_excel")
	public String grcode_excel(@ModelAttribute("cm") CommonMap cm, Model model) throws BizException {
		DataMap requestMap = cm.getDataMap();
		requestMap.setNullToInitialize(true);
		
		//과정 기수 정보.
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("grcode", requestMap.getString("commGrcode"));
		paramMap.put("grseq", requestMap.getString("commGrseq"));
		
		DataMap grseqMap = courseSeqService.selectGrseqSimpleRow(paramMap);
		
		//리스트
		DataMap listMap = certiResultService.selectGrResultByAllList(requestMap);

		model.addAttribute("GRSEQ_ROW_DATA", grseqMap);
		model.addAttribute("LIST_DATA", listMap);
		
		return  "/courseMgr/certiResult/grcodeResultByExcel";
	}
	
	/**
	 * 수료증발급대장
	 */
	@RequestMapping(value="/courseMgr/certiResult.do", params = "mode=certi_list")
	public String certi_list(@ModelAttribute("cm") CommonMap cm, Model model) throws BizException {
		DataMap requestMap = cm.getDataMap();
		requestMap.setNullToInitialize(true);
		
		//과정 기수 정보.
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("grcode", requestMap.getString("commGrcode"));
		paramMap.put("grseq", requestMap.getString("commGrseq"));
		
		DataMap grseqMap = courseSeqService.selectGrseqSimpleRow(paramMap);
		
		//리스트
		DataMap listMap = certiResultService.selectGrResultByAllNotSearchList(requestMap.getString("commGrcode"), requestMap.getString("commGrseq"));

		model.addAttribute("GRSEQ_ROW_DATA", grseqMap);
		model.addAttribute("LIST_DATA", listMap);
		
		return "/courseMgr/certiResult/certificateList";
	}
	
	/**
	 * 교육수료증/상장발급
	 */
	@RequestMapping(value="/courseMgr/certiResult.do", params = "mode=certi_ach")
	public String certi_ach(@ModelAttribute("cm") CommonMap cm, Model model) throws BizException {
		DataMap requestMap = cm.getDataMap();
		requestMap.setNullToInitialize(true);
		
		//과정 기수 정보.
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("grcode", requestMap.getString("commGrcode"));
		paramMap.put("grseq", requestMap.getString("commGrseq"));
		
		DataMap grseqMap = courseSeqService.selectGrseqSimpleRow(paramMap);
		
		if(requestMap.getString("searchOrder").equals(""))
			requestMap.setString("searchOrder", "eduno");
		
		//리스트
		DataMap listMap = certiResultService.selectGrResultByAllCertiList(requestMap);

		model.addAttribute("GRSEQ_ROW_DATA", grseqMap);
		model.addAttribute("LIST_DATA", listMap);
		
		return "/courseMgr/certiResult/certificateAch";
	}
	
	/**
	 * 수료증 출력
	 */
	@RequestMapping(value="/courseMgr/certiResult.do", params = "mode=certi_html")
	public String certi_html(@ModelAttribute("cm") CommonMap cm, Model model) throws BizException {
		DataMap requestMap = cm.getDataMap();
		requestMap.setNullToInitialize(true);
		
		//리스트
		DataMap listMap = certiResultService.selectGrResultByResultDocList(requestMap);

		DataMap resultDocMap = resultHtmlService.selectResultDocRow(0);
		
		model.addAttribute("LIST_DATA", listMap);
		model.addAttribute("RESULTDOC_ROW_DATA", resultDocMap);
		
		return "/courseMgr/certiResult/certificateHtml";
	}
	
	/**
	 * Ajax 으로 상장일괄삭제 / 수료번호일괄삭제 / 수료번호재생성  실행.
	 */
	@RequestMapping(value="/courseMgr/certiResult.do", params = "mode=ajax_exec")
	public String ajax_exec(@ModelAttribute("cm") CommonMap cm, Model model) throws BizException {
		DataMap requestMap = cm.getDataMap();
		requestMap.setNullToInitialize(true);
		
		String qu = requestMap.getString("qu");
		String grcode = requestMap.getString("grcode");
		String grseq = requestMap.getString("grseq");
		
		if(qu.equals("rawardno_del")){  //상장일괄삭제
			//상장일괄삭제
			certiResultService.updateGrResultByAllRawardnoNull(grcode, grseq);
		}else if(qu.equals("rno_del")){ //수료번호일괄삭제
			//수료번호일괄삭제
			certiResultService.updateGrResultByAllRnoNull(grcode, grseq);
		}else if(qu.equals("rno_add")){  //수료번호재생성
			certiResultService.updateGrResultByGrseqAllRno(grcode, grseq, requestMap.getInt("certino"));
		}
		
		return "/commonInc/ajax/ajaxBlankPage";
	}
	
	/**
	 * 상장 번호 등록 실행.
	 */
	@RequestMapping(value="/courseMgr/certiResult.do", params = "mode=certi_exec")
	public String certi_exec(@ModelAttribute("cm") CommonMap cm, Model model) throws BizException {
		DataMap requestMap = cm.getDataMap();
		requestMap.setNullToInitialize(true);
		
		String qu = requestMap.getString("qu");
		
		String msg = "";
		
		if(qu.equals("award_print")){  //상장 번호 등록
            int certino = requestMap.getInt("certino"); //사용자가 입력한 상장 시작 숫자.
            int nextNo = certiResultService.selectGrResultNextRawardNo(requestMap.getString("year")); //시스템의 최고 상장 번호
            
            //System.out.println("\n ## certino = " + certino);
            //System.out.println("\n ## nextNo = " + nextNo);
            
            if (certino != 0 && certino < nextNo){
            	msg = "상장번호는 " + nextNo + " 보다 커야 합니다.";
            	model.addAttribute("RESULT_DATA", "0");
            }else{
                if ( certino <= 0)
                	certino = nextNo;
                
                requestMap.setInt("rawardno", certino);
                	
    			//상장 번호 등록
    			int result = certiResultService.updateGrResultRawardNo(requestMap);
    				
    			if(result > 0)
    				msg = "상장이 정상적으로 부여되었습니다.";
    			else
    				msg = "실패";
            }
		}
		
		model.addAttribute("RESULT_MSG", msg);

		return "/courseMgr/certiResult/certificateExec";
	}
	
	/**
	 * 개인별수료이력조회
	 */
	@RequestMapping(value="/courseMgr/certiResult.do", params = "mode=person_list")
	public String person_list(@ModelAttribute("cm") CommonMap cm, Model model) throws BizException {
		DataMap requestMap = cm.getDataMap();
		requestMap.setNullToInitialize(true);
		
		//사용자 정보 추출.
		LoginInfo loginInfo = (LoginInfo)cm.getRequest().getAttribute("LOGIN_INFO");
		
		//리스트
		DataMap listMap = null;
		HttpSession session = cm.getRequest().getSession(); //세션
		String sess_ldapcode = (String)session.getAttribute("sess_ldapcode");		
		if(!requestMap.getString("searchName").equals(""))
			listMap = certiResultService.selectGrResultListBySearch(requestMap.getString("searchName"), loginInfo.getSessClass(), loginInfo.getSessDept(), sess_ldapcode);
		else
			listMap = new DataMap();
		
		model.addAttribute("LIST_DATA", listMap);
		
		return "/courseMgr/certiResult/personResultList";
	}
	
	/**
	 * 개인별수료이력조회 상세 조회
	 */
	@RequestMapping(value="/courseMgr/certiResult.do", params = "mode=person_view")
	public String person_view(@ModelAttribute("cm") CommonMap cm, Model model) throws BizException {
		DataMap requestMap = cm.getDataMap();
		requestMap.setNullToInitialize(true);
		
		//사용자 정보 추출.
		LoginInfo loginInfo = (LoginInfo)cm.getRequest().getAttribute("LOGIN_INFO");
		
		//리스트
		DataMap listMap = certiResultService.selectGrResultListByUserno(requestMap.getString("userno"), loginInfo.getSessClass(), loginInfo.getSessDept());

		model.addAttribute("LIST_DATA", listMap);
		
		return "/courseMgr/certiResult/personResultView";
	}
	
	/**
	 * 기관별 수료자 조회
	 */
	@RequestMapping(value="/courseMgr/certiResult.do", params = "mode=gove_list")
	public String gove_list(@ModelAttribute("cm") CommonMap cm, Model model) throws BizException {
		DataMap requestMap = cm.getDataMap();
		requestMap.setNullToInitialize(true);
		
		//사용자 정보 추출.
		LoginInfo loginInfo = (LoginInfo)cm.getRequest().getAttribute("LOGIN_INFO");
		
		//과정 기수 정보.
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("grcode", requestMap.getString("commGrcode"));
		paramMap.put("grseq", requestMap.getString("commGrseq"));
		
		DataMap grseqMap = courseSeqService.selectGrseqSimpleRow(paramMap);
		
		//기관 담당자 및 부서 담당자 일경우 기관 코드 셋팅.
		if( loginInfo.getSessClass().equals(Constants.ADMIN_SESS_CLASS_DEPT)
				|| loginInfo.getSessClass().equals(Constants.ADMIN_SESS_CLASS_PART) )
			requestMap.setString("searchDept", loginInfo.getSessDept());
		
		
		//검색시 사용하는 수료자의 기관 리스트
		DataMap grResultDeptList = null;
		if(loginInfo.getSessClass().equals(Constants.ADMIN_SESS_CLASS_ADMIN) 
				|| loginInfo.getSessClass().equals(Constants.ADMIN_SESS_CLASS_COURSE)
				|| loginInfo.getSessClass().equals(Constants.ADMIN_SESS_CLASS_COURSEMAN))
			grResultDeptList = certiResultService.selectGrResultDeptList(requestMap.getString("commGrcode"), requestMap.getString("commGrseq"));
		else
			grResultDeptList = new DataMap();
		
		//전체 인원
		//requestMap.setInt("totalCnt", seqService.selectGrResultCnt(requestMap.getString("commGrcode"), requestMap.getString("commGrseq")));
		
	
		HttpSession session = cm.getRequest().getSession(); //세션
		String sess_ldapcode = (String)session.getAttribute("sess_ldapcode");
		//리스트
		DataMap listMap = certiResultService.selectGrResultListByDept(requestMap, sess_ldapcode, loginInfo.getSessDept());
		requestMap.setInt("totalCnt", listMap.keySize("userno"));		
		
		model.addAttribute("GRSEQ_ROW_DATA", grseqMap);
		model.addAttribute("LIST_DATA", listMap);
		model.addAttribute("RESULT_DEPT_LIST_DATA", grResultDeptList);
		
		return "/courseMgr/certiResult/goveResultList";
	}
	
	/**
	 * 사이버 과정의 수료/미수료자 조회
	 */
	@RequestMapping(value="/courseMgr/certiResult.do", params = "mode=cyber_list")
	public String cyber_list(@ModelAttribute("cm") CommonMap cm, Model model) throws BizException {
		DataMap requestMap = cm.getDataMap();
		requestMap.setNullToInitialize(true);
		
		//사용자 정보 추출.
		LoginInfo loginInfo = (LoginInfo)cm.getRequest().getAttribute("LOGIN_INFO");
		
		//기관 담당자 일경우 기관 코드 셋팅.
		if(loginInfo.getSessClass().equals(Constants.ADMIN_SESS_CLASS_DEPT))
			requestMap.setString("searchDept", loginInfo.getSessDept());
		
		if(requestMap.getString("searchOrder").equals(""))
			requestMap.setString("searchOrder", "DEPT");
		
		if (requestMap.getString("rowSize").equals(""))		requestMap.setInt("rowSize", 2000); //페이지당 보여줄 갯수
		//리스트
		DataMap listMap = certiResultService.selectGrResultByAllListForCyber(requestMap);

		DataMap resultCntMap = null;
		
		resultCntMap = certiResultService.selectGrResultCompletionCntRowForCyber(requestMap.getString("commGrcode"), requestMap.getString("commGrseq"));
		
//		if(!requestMap.getString("commGrcode").equals("") && !requestMap.getString("commGrseq").equals(""))
		
		//검색시 사용하는 수료자의 기관 리스트
		DataMap grResultDeptList = null;
		if(loginInfo.getSessClass().equals(Constants.ADMIN_SESS_CLASS_ADMIN) 
				|| loginInfo.getSessClass().equals(Constants.ADMIN_SESS_CLASS_COURSE)
				|| loginInfo.getSessClass().equals(Constants.ADMIN_SESS_CLASS_COURSEMAN))
			grResultDeptList = certiResultService.selectGrResultDeptListForCyber(requestMap.getString("commGrcode"), requestMap.getString("commGrseq"));
		else
			grResultDeptList = new DataMap();
		
		model.addAttribute("LIST_DATA", listMap);
		model.addAttribute("RESULT_CNT_ROW_DATA", resultCntMap);
		model.addAttribute("RESULT_DEPT_LIST_DATA", grResultDeptList);
		
		return "/courseMgr/certiResult/grcodeCyberResultList";
	}
	
	/**
	 * 수료 미수료자 조회 (사이버 EXCEL)
	 */
	@RequestMapping(value="/courseMgr/certiResult.do", params = "mode=cyber_excel")
	public String cyber_excel(@ModelAttribute("cm") CommonMap cm, Model model) throws BizException {
		DataMap requestMap = cm.getDataMap();
		requestMap.setNullToInitialize(true);
		
		//사용자 정보 추출.
		LoginInfo loginInfo = (LoginInfo)cm.getRequest().getAttribute("LOGIN_INFO");
		
		//기관 담당자 일경우 기관 코드 셋팅.
		if(loginInfo.getSessClass().equals(Constants.ADMIN_SESS_CLASS_DEPT))
			requestMap.setString("searchDept", loginInfo.getSessDept());
		
		if(requestMap.getString("searchOrder").equals(""))
			requestMap.setString("searchOrder", "DEPT");
		
		//리스트
		DataMap listMap = certiResultService.selectGrResultByAllListForCyber2(requestMap);

		model.addAttribute("LIST_DATA", listMap);
		
		return "/courseMgr/certiResult/grcodeCyberResultByExcel";
	}
	
	/**
	 * 과목이수현황
	 */
	@RequestMapping(value="/courseMgr/certiResult.do", params = "mode=subj_list")
	public String subj_list(@ModelAttribute("cm") CommonMap cm, Model model) throws BizException {
		DataMap requestMap = cm.getDataMap();
		requestMap.setNullToInitialize(true);
		
		//사용자 정보 추출.
		//LoginInfo loginInfo = (LoginInfo)request.getAttribute("LOGIN_INFO");
		
		String grcode = requestMap.getString("commGrcode");
		String grseq = requestMap.getString("commGrseq");
		String subj = requestMap.getString("commSubj");
		
		//검색시 사용하는 수료자의 기관 리스트
		DataMap grResultDeptList = certiResultService.selectGrResultDeptList(grcode, grseq);
		
		//수강생 리스트 
		DataMap listMap = null;
		if(!grcode.equals("") && !grseq.equals("") && !subj.equals(""))
			listMap = certiResultService.selectStuLectBySubjStudyList(grcode, grseq, subj, requestMap);
		else
			listMap = new DataMap();
		
		model.addAttribute("LIST_DATA", listMap);
		model.addAttribute("RESULT_DEPT_LIST_DATA", grResultDeptList);
		
		return "/courseMgr/certiResult/subjResultList";
	}
	
	/**
	 * 수료자 SMS 발송
	 */
	@RequestMapping(value="/courseMgr/certiResult.do", params = "mode=sms_list")
	public String sms_list(@ModelAttribute("cm") CommonMap cm, Model model) throws BizException {
		DataMap requestMap = cm.getDataMap();
		requestMap.setNullToInitialize(true);
		
		//수강신청 리스트.
		DataMap listMap = certiResultService.selectMemberBySimpleDataList(requestMap);
		
		model.addAttribute("LIST_DATA", listMap);
		
		return "/courseMgr/certiResult/certiResultSmsList";
	}
}
