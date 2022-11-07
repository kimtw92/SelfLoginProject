package loti.courseMgr.web;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import loti.common.service.CommonService;
import loti.courseMgr.service.CourseSeqService;
import loti.courseMgr.service.LectureApplyService;
import loti.courseMgr.service.StuEnterService;

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
import ut.lib.util.Constants;
import common.controller.BaseController;

@Controller("courseMgrStuEnterController")
public class StuEnterController extends BaseController {

	@Autowired
	@Qualifier("courseMgrStuEnterService")
	private StuEnterService stuEnterService;
	@Autowired
	private CourseSeqService courseSeqService;
	@Autowired
	private LectureApplyService lectureApplyService;
	@Autowired
	private CommonService commonService;
	
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
				mode = "form";
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
			if(requestMap.getString("commGrcode").equals(""))
				requestMap.setString("commGrcode", (String)session.getAttribute("sess_grcode"));
			if(requestMap.getString("commGrseq").equals(""))
				requestMap.setString("commGrseq", (String)session.getAttribute("sess_grseq"));
			
			model.addAttribute("REQUEST_DATA", requestMap);
			model.addAttribute("LOGIN_INFO", memberInfo);
		} catch (Exception e) {
			throw new BizException(e);
		} finally {
			
		}
		
		return cm;
	}
	
	/**
	 * 교육생(입교자) 조회.
	 */
	@RequestMapping(value="/courseMgr/stuEnter.do", params = "mode=list")
	public String list(@ModelAttribute("cm") CommonMap cm, Model model) throws BizException {
		DataMap requestMap = cm.getDataMap();
		requestMap.setNullToInitialize(true);
		
		//사용자 정보 추출.
		LoginInfo loginInfo = (LoginInfo)cm.getRequest().getAttribute("LOGIN_INFO");
		
		if (requestMap.getString("currPage").equals(""))	requestMap.setInt("currPage", 1); //페이지
		if (requestMap.getString("rowSize").equals(""))		requestMap.setInt("rowSize", 15); //페이지당 보여줄 갯수
		if (requestMap.getString("pageSize").equals("")) 	requestMap.setInt("pageSize", 10); //페이지 블럭 갯수
		
		HttpSession session = cm.getRequest().getSession(); //세션
		String sess_ldapcode = (String)session.getAttribute("sess_ldapcode");
		
		//과정 기수 정보.
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("grcode", requestMap.getString("commGrcode"));
		paramMap.put("grseq", requestMap.getString("commGrseq"));
		
		DataMap grseqMap = courseSeqService.selectGrseqSimpleRow(paramMap);
		
		//교육생 명단 리스트.
		DataMap listMap = stuEnterService.selectAppInfoBySessAndDeptList(requestMap.getString("commGrcode"), requestMap.getString("commGrseq"), sess_ldapcode, loginInfo.getSessClass(), loginInfo.getSessDept(), requestMap);
	
		//기관 리스트
		DataMap depListMap = null;
		if(!loginInfo.getSessClass().equals(Constants.ADMIN_SESS_CLASS_DEPT) &&  !loginInfo.getSessClass().equals(Constants.ADMIN_SESS_CLASS_PART)){
			depListMap = lectureApplyService.selectDeptList();
		}else{
			depListMap = new DataMap();
		}

		//기관담당자 일경우 기관명
		String sessDeptnm = "";
		if(loginInfo.getSessClass().equals(Constants.ADMIN_SESS_CLASS_DEPT)){
			try{ 
				sessDeptnm = commonService.selectDeptnmRow(loginInfo.getSessDept());
			} catch(Exception e) {
				throw new BizException(e);
			} finally {
				
			}
		}
		
		model.addAttribute("GRSEQ_ROW_DATA", grseqMap);
		model.addAttribute("LIST_DATA", listMap);
		model.addAttribute("DEPT_LIST_DATA", depListMap);
		model.addAttribute("DEPTNM_STRING_DATA", sessDeptnm);
		
		return "/courseMgr/stuEnter/stuEnterList";
	}
	
	/**
	 * 수강신청 정보 수정. (팝업)
	 */
	@RequestMapping(value="/courseMgr/stuEnter.do", params = "mode=app_form")
	public String app_form(@ModelAttribute("cm") CommonMap cm, Model model) throws BizException {
		DataMap requestMap = cm.getDataMap();
		requestMap.setNullToInitialize(true);
		
		if (requestMap.getString("currPage").equals(""))	requestMap.setInt("currPage", 1); //페이지
		if (requestMap.getString("rowSize").equals(""))		requestMap.setInt("rowSize", 15); //페이지당 보여줄 갯수
		if (requestMap.getString("pageSize").equals("")) 	requestMap.setInt("pageSize", 10); //페이지 블럭 갯수
		
		//교육생 명단 리스트.
		DataMap rowMap = lectureApplyService.selectAppInfoRow(requestMap.getString("grcode"), requestMap.getString("grseq"), requestMap.getString("userno"));
	
		//기관 리스트
		DataMap depListMap = lectureApplyService.selectDeptByUserYnList("Y");
		
		model.addAttribute("ROW_DATA", rowMap);
		model.addAttribute("DEPT_LIST_DATA", depListMap);
		
		return "/courseMgr/stuEnter/stuEnterAppFormPop";
	}
	
	/**
	 * 교육생 입교자 조회 엑셀 출력
	 */
	@RequestMapping(value="/courseMgr/stuEnter.do", params = "mode=list_excel")
	public String list_excel(@ModelAttribute("cm") CommonMap cm, Model model) throws BizException {
		DataMap requestMap = cm.getDataMap();
		requestMap.setNullToInitialize(true);
		
		//사용자 정보 추출.
		LoginInfo loginInfo = (LoginInfo)cm.getRequest().getAttribute("LOGIN_INFO");

		//과정 기수 정보.
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("grcode", requestMap.getString("commGrcode"));
		paramMap.put("grseq", requestMap.getString("commGrseq"));
		
		DataMap grseqMap = courseSeqService.selectGrseqSimpleRow(paramMap);
		
		HttpSession session = cm.getRequest().getSession(); //세션
		String sess_ldapcode = (String)session.getAttribute("sess_ldapcode");
		//교육생 명단 리스트.
		DataMap listMap = stuEnterService.selectAppInfoBySessAndDeptList2(requestMap.getString("commGrcode"), requestMap.getString("commGrseq"), sess_ldapcode, loginInfo.getSessClass(), loginInfo.getSessDept(), requestMap.getString("dept"));
	
		model.addAttribute("GRSEQ_ROW_DATA", grseqMap);
		model.addAttribute("LIST_DATA", listMap);
		
		return "/courseMgr/stuEnter/stuEnterListByExcel";
	}
	
	/**
	 * 교육생직접입력 폼.
	 */
	@RequestMapping(value="/courseMgr/stuEnter.do", params = "mode=form")
	public String form(@ModelAttribute("cm") CommonMap cm, Model model) throws BizException {
		DataMap requestMap = cm.getDataMap();
		requestMap.setNullToInitialize(true);
		
		//사용자 정보 추출.
		LoginInfo loginInfo = (LoginInfo)cm.getRequest().getAttribute("LOGIN_INFO");
		
		//과정 기수 정보.
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("grcode", requestMap.getString("commGrcode"));
		paramMap.put("grseq", requestMap.getString("commGrseq"));
		
		DataMap grseqMap = courseSeqService.selectGrseqSimpleRow(paramMap);
		
		//유저 정보.
		DataMap userMap = courseSeqService.selectMemberSimpleRow(requestMap.getString("userno"));
		
		//검색된 사용자의 수강신청 리스트
		DataMap lectureMap = courseSeqService.selectMemberLecture(requestMap.getString("userno"));
		
		//기관담당자 일경우 기관명
		String sessDeptnm = "";
		if(loginInfo.getSessClass().equals(Constants.ADMIN_SESS_CLASS_DEPT)){
			try {
				sessDeptnm = commonService.selectDeptnmRow(loginInfo.getSessDept());
			} catch(Exception e) {
				throw new BizException(e);
			} finally {
				
			}
		}
		
		model.addAttribute("GRSEQ_ROW_DATA", grseqMap);
		model.addAttribute("USER_ROW_DATA", userMap);
		model.addAttribute("DEPTNM_STRING_DATA", sessDeptnm);
		model.addAttribute("LECTURE_DATA", lectureMap);
		
		return "/courseMgr/stuEnter/stuEnterForm";
	}

	/**
	 * 교육생 직접 입력.
	 */
	@RequestMapping(value="/courseMgr/stuEnter.do", params = "mode=exec")
	public String exec(@ModelAttribute("cm") CommonMap cm, Model model) throws BizException {
		DataMap requestMap = cm.getDataMap();
		requestMap.setNullToInitialize(true);
		
		//사용자 정보 추출.
		LoginInfo loginInfo = (LoginInfo)cm.getRequest().getAttribute("LOGIN_INFO");
		
		String msg = ""; //결과 메세지.
		int result = 0;
		
		if(requestMap.getString("qu").equals("insert")){ //교육생 직접 입력 등록.
			String grcode = requestMap.getString("commGrcode");
			String grseq = requestMap.getString("commGrseq");
			
			//기관 담당자 일경우.
			if(loginInfo.getSessClass().equals(Constants.ADMIN_SESS_CLASS_DEPT)){
				//수강신청 기관 확인.
				result = stuEnterService.selectGrseqEapplyedChk(grcode, grseq);
				
				if(result > 0){
					msg = "수강신청기간중에는 직접입력이 불가능 합니다.";
					result = -1;
				}else{
					//1차 승인기간 확인.
					result = stuEnterService.selectGrseqEndsentChk(grcode, grseq);
					
					if(result > 0){
						msg = "이미 1차 승인기간이 종료되었습니다";
						result = -1;
					}
				}
			}
			
			if(result >= 0){
				//이미 입력된 과정인지 체크
				result = lectureApplyService.selectStuLecUserCnt(grcode, grseq, requestMap.getString("userno"));
				
				if(result > 0 ){
					msg = "해당 과정은 수강신청되어 있는 과정입니다.";
					result = -1;
				}else{
					requestMap.setString("grcode", grcode);
					requestMap.setString("grseq", grseq);
					
					//교육생 직접 입력 실행.
					result  = stuEnterService.execStuEnter(requestMap, loginInfo.getSessClass(), loginInfo.getSessNo());
					
					if(result == -1 ){
						msg = "이미 입력된 교육생이므로 신규입력이 불가합니다.이름과 주민번호로 검색 후 정보를 입력하세요!";
						result = -1;
					}else if(result == -2 )
						msg = "신규 회원 등록 실패";
					else if (result > 0)
						msg = "처리되었습니다";
					else
						msg = "실패";
				}
			}
		}else if(requestMap.getString("qu").equals("app_update")){  //수강생 정보 수정.
			//교육생 직접 입력 실행.
			result  = stuEnterService.updateAppInfo(requestMap);
			
			if (result > 0)
				msg = "처리되었습니다";
			else
				msg = "실패";
		}else if(requestMap.getString("qu").equals("reenter")){  //재입교 처리.
			//교육생 직접 입력 실행.
			result  = stuEnterService.execReStuEnter(requestMap, loginInfo.getSessNo());
			
			if (result > 0)
				msg = "재입교 처리되었습니다.";
			else
				msg = "실패";
		}else if(requestMap.getString("qu").equals("approval")){  //집합교육선정
			//교육생 직접 입력 실행.
			result  = stuEnterService.execStuEnterApproval(requestMap, loginInfo.getSessNo());
			
			if (result > 0)
				msg = "집합교육선정 처리되었습니다.";
			else
				msg = "실패";
		}

		model.addAttribute("RESULT_MSG", msg);
		
		return "/courseMgr/stuEnter/stuEnterExec";
	}
	
	/**
	 * 입교현황분석
	 */
	public void statistics_com(@ModelAttribute("cm") CommonMap cm, Model model) throws BizException {
		DataMap requestMap = cm.getDataMap();
		requestMap.setNullToInitialize(true);
		
		//과정 기수 정보.
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("grcode", requestMap.getString("commGrcode"));
		paramMap.put("grseq", requestMap.getString("commGrseq"));
		
		DataMap grseqMap = courseSeqService.selectGrseqSimpleRow(paramMap);
		
		//교육인원 기관
		DataMap depListMap = stuEnterService.selectDeptByAppInfoList(requestMap.getString("commGrcode"), requestMap.getString("commGrseq"));
		if(depListMap == null) depListMap = new DataMap();
		depListMap.setNullToInitialize(true);
		
		//기관/계급명 CROSS 통계
		DataMap deptResultList = stuEnterService.selectDeptDogsCrossList(requestMap.getString("commGrcode"), requestMap.getString("commGrseq"), depListMap);
		
		//직렬별 리스트.
		DataMap jikListMap = stuEnterService.selectJikrByAppInfoList(requestMap.getString("commGrcode"), requestMap.getString("commGrseq"));
		if(jikListMap == null) jikListMap = new DataMap();
		jikListMap.setNullToInitialize(true);
		
		//직렬/계급명 CROSS 통계
		DataMap jikrResultList = stuEnterService.selectJikrDogsCrossList(requestMap.getString("commGrcode"), requestMap.getString("commGrseq"), jikListMap);
		
		//재직기간별.
		DataMap yearRowMap = null;
		if(requestMap.getString("commGrcode").equals("0010000003"))
			yearRowMap = stuEnterService.selectAppInfoUpsdateRow(requestMap.getString("commGrcode"), requestMap.getString("commGrseq"));
		else
			yearRowMap = stuEnterService.selectAppInfoUpsdateRowBySysdate(requestMap.getString("commGrcode"), requestMap.getString("commGrseq"));

		//연령별 정보
		DataMap ageRowMap = stuEnterService.selectAppInfoStatisticsByAgeRow(requestMap.getString("commGrcode"), requestMap.getString("commGrseq"));
		
		//학력별 리스트
		DataMap schMap = stuEnterService.selectAppInfoStatisticsBySchoolRow(requestMap.getString("commGrcode"), requestMap.getString("commGrseq"));

		//거주지별
		DataMap addrMap = stuEnterService.selectAppInfoStatisticsByAddrRow(requestMap.getString("commGrcode"), requestMap.getString("commGrseq"));
		
		model.addAttribute("DEPT_LIST_DATA", depListMap);
		model.addAttribute("DEPTDOGS_LIST_DATA", deptResultList);
		
		model.addAttribute("JIKR_LIST_DATA", jikListMap);
		model.addAttribute("JIKRDOGS_LIST_DATA", jikrResultList);
		
		model.addAttribute("YEAR_ROW_DATA", yearRowMap);
		model.addAttribute("AGE_ROW_DATA", ageRowMap);
		model.addAttribute("SCHOOL_ROW_DATA", schMap);
		model.addAttribute("ADDR_ROW_DATA", addrMap);
		
		model.addAttribute("GRSEQ_ROW_DATA", grseqMap);
		
		System.out.println("\n ###4 ");
	}
	
	/**
	 * 입교현황분석
	 */
	@RequestMapping(value="/courseMgr/stuEnter.do", params = "mode=statistics")
	public String statistics(@ModelAttribute("cm") CommonMap cm, Model model) throws BizException {
		statistics_com(cm, model);
		
		return "/courseMgr/stuEnter/stuEnterStatistics";
	}
	
	/**
	 * 입교현황분석 프린트 출력
	 */
	@RequestMapping(value="/courseMgr/stuEnter.do", params = "mode=statistics_print")
	public String statistics_print(@ModelAttribute("cm") CommonMap cm, Model model) throws BizException {
		statistics_com(cm, model);
		
		return "/courseMgr/stuEnter/stuEnterStatisticsHtml";
	}
	
	/**
	 * 입교현황 분석 excel 출력
	 */
	@RequestMapping(value="/courseMgr/stuEnter.do", params = "mode=statistics_excel")
	public String statistics_excel(@ModelAttribute("cm") CommonMap cm, Model model) throws BizException {
		DataMap requestMap = cm.getDataMap();
		requestMap.setNullToInitialize(true);
		
		//과정 기수 정보.
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("grcode", requestMap.getString("commGrcode"));
		paramMap.put("grseq", requestMap.getString("commGrseq"));
		
		DataMap grseqMap = courseSeqService.selectGrseqSimpleRow(paramMap);
		
		//교육인원 기관
		DataMap depListMap = stuEnterService.selectDeptByAppInfoList(requestMap.getString("commGrcode"), requestMap.getString("commGrseq"));
		if(depListMap == null) depListMap = new DataMap();
		depListMap.setNullToInitialize(true);
		
		//기관/계급명 CROSS 통계
		DataMap deptResultList = stuEnterService.selectDeptDogsCrossList(requestMap.getString("commGrcode"), requestMap.getString("commGrseq"), depListMap);
		
		//직렬별 리스트.
		DataMap jikListMap = stuEnterService.selectJikrByAppInfoList(requestMap.getString("commGrcode"), requestMap.getString("commGrseq"));
		if(jikListMap == null) jikListMap = new DataMap();
		jikListMap.setNullToInitialize(true);
		
		//직렬/계급명 CROSS 통계
		DataMap jikrResultList = stuEnterService.selectJikrDogsCrossList(requestMap.getString("commGrcode"), requestMap.getString("commGrseq"), jikListMap);
		
		//연도별.
		DataMap yearRowMap = null;
		if(requestMap.getString("commGrcode").equals("0010000003"))
			yearRowMap = stuEnterService.selectAppInfoUpsdateRow(requestMap.getString("commGrcode"), requestMap.getString("commGrseq"));
		else
			yearRowMap = stuEnterService.selectAppInfoUpsdateRowBySysdate(requestMap.getString("commGrcode"), requestMap.getString("commGrseq"));

		//연령별 정보
		DataMap ageRowMap = stuEnterService.selectAppInfoStatisticsByAgeRow(requestMap.getString("commGrcode"), requestMap.getString("commGrseq"));
		
		//학력별 리스트
		DataMap schMap = stuEnterService.selectAppInfoStatisticsBySchoolRow(requestMap.getString("commGrcode"), requestMap.getString("commGrseq"));
		
		//거주지별
		DataMap addrMap = stuEnterService.selectAppInfoStatisticsByAddrRow(requestMap.getString("commGrcode"), requestMap.getString("commGrseq"));
		
		model.addAttribute("DEPT_LIST_DATA", depListMap);
		model.addAttribute("DEPTDOGS_LIST_DATA", deptResultList);
		
		model.addAttribute("JIKR_LIST_DATA", jikListMap);
		model.addAttribute("JIKRDOGS_LIST_DATA", jikrResultList);
		
		model.addAttribute("YEAR_ROW_DATA", yearRowMap);
		model.addAttribute("AGE_ROW_DATA", ageRowMap);
		model.addAttribute("SCHOOL_ROW_DATA", schMap);
		model.addAttribute("ADDR_ROW_DATA", addrMap);
		
		model.addAttribute("GRSEQ_ROW_DATA", grseqMap);
		model.addAttribute("DEPT_LIST_DATA", depListMap);
		
		return "/courseMgr/stuEnter/stuEnterStatisticsByExcel";
	}
	
	/**
	 * 집합교육대상자승인 리스트
	 */
	@RequestMapping(value="/courseMgr/stuEnter.do", params = "mode=approval_list")
	public String approval_list(@ModelAttribute("cm") CommonMap cm, Model model) throws BizException {
		DataMap requestMap = cm.getDataMap();
		requestMap.setNullToInitialize(true);
		
		//과정 기수 정보.
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("grcode", requestMap.getString("commGrcode"));
		paramMap.put("grseq", requestMap.getString("commGrseq"));
		
		DataMap grseqMap = courseSeqService.selectGrseqSimpleRow(paramMap);
		
		//과정 기수 확인.
		String message = "";
		int tmpResult = 0;
		tmpResult = stuEnterService.selectSubjSeqEndDateChkByCyber(requestMap.getString("commGrcode"), requestMap.getString("commGrseq"));
		if(tmpResult > 0)
			message = "사이버교육이 종료되지 않았습니다. 종료후 선정가능합니다.";
		
		DataMap dParamMap = new DataMap();
		dParamMap.setString("grcode", requestMap.getString("commGrcode"));
		dParamMap.setString("grseq", requestMap.getString("commGrseq"));
		tmpResult = courseSeqService.selectGrResultCnt(dParamMap);
		if(tmpResult > 0)
			message = "이미 수료처리되었습니다. 입교자선정이 불가능합니다.";
		
		//집합교육 입과 대상자
		DataMap listMap = stuEnterService.selectAppInfoByMemberList(requestMap.getString("commGrcode"), requestMap.getString("commGrseq"), "Y");
		
		//집합교육 탈락자
		DataMap fallListMap = stuEnterService.selectAppInfoByMemberList(requestMap.getString("commGrcode"), requestMap.getString("commGrseq"), "P");
		
		model.addAttribute("GRSEQ_ROW_DATA", grseqMap);
		model.addAttribute("LIST_DATA", listMap);
		model.addAttribute("FALL_LIST_DATA", fallListMap);
		model.addAttribute("MESSAGE_STRING", message);
		
		return "/courseMgr/stuEnter/stuEnterApprovalList";
	}
	
	/**
	 * SMS 발송
	 */
	@RequestMapping(value="/courseMgr/stuEnter.do", params = "mode=sms_list")
	public String sms_list(@ModelAttribute("cm") CommonMap cm, Model model) throws BizException {
		DataMap requestMap = cm.getDataMap();
		requestMap.setNullToInitialize(true);
		
		//수강신청 리스트.
		DataMap listMap = stuEnterService.selectMemberBySimpleDataList(requestMap);
		
		model.addAttribute("LIST_DATA", listMap);
		
		return "/courseMgr/stuEnter/stuEnterSmsList";
	}
	
	/**
	 * 교육중인 수강생 모집
	 */
	@RequestMapping(value="/courseMgr/stuEnter.do", params = "mode=stuMemberList")
	public String stuMemberList(@ModelAttribute("cm") CommonMap cm, Model model) throws BizException {
		DataMap requestMap = cm.getDataMap();
		requestMap.setNullToInitialize(true);
		
		//사용자 정보 추출.
		//LoginInfo loginInfo = (LoginInfo)request.getAttribute("LOGIN_INFO");
		
		DataMap listMap = null;
		
		if (requestMap.getString("currPage").equals(""))	requestMap.setInt("currPage", 1); //페이지
		if (requestMap.getString("rowSize").equals(""))		requestMap.setInt("rowSize", 15); //페이지당 보여줄 갯수
		if (requestMap.getString("pageSize").equals("")) 	requestMap.setInt("pageSize", 10); //페이지 블럭 갯수
		
		listMap = stuEnterService.stuMemberList(requestMap);
		
		model.addAttribute("LIST_DATA", listMap);
		
		return "/courseMgr/stuEnter/stuMemberList";
	}
}
