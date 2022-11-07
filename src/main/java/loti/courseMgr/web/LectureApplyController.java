package loti.courseMgr.web;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import loti.courseMgr.service.CourseSeqService;
import loti.courseMgr.service.LectureApplyService;

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
import ut.lib.util.StringReplace;
import ut.lib.util.Util;
import common.controller.BaseController;

@Controller
public class LectureApplyController extends BaseController {

	@Autowired
	private LectureApplyService lectureApplyService;
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
			if(requestMap.getString("commYear").equals(""))
				requestMap.setString("commYear", (String)session.getAttribute("sess_year"));
			if(!mode.equals("cyber_list") && !mode.equals("cyber_dept_list")){  //사이버 과정은 제외.
				if(requestMap.getString("commGrcode").equals(""))
					requestMap.setString("commGrcode", (String)session.getAttribute("sess_grcode"));
				if(requestMap.getString("commGrseq").equals(""))
					requestMap.setString("commGrseq", (String)session.getAttribute("sess_grseq"));
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
	 * 수강신청 조회/승인 리스트
	 */
	@RequestMapping(value="/courseMgr/lectureApply.do", params = "mode=list")
	public String list(@ModelAttribute("cm")CommonMap cm, Model model) throws BizException {
		DataMap requestMap = cm.getDataMap();
		requestMap.setNullToInitialize(true);
		
		//파라미터로 넘기는 부서 코드
		String deptHiddenStr = "";
		for(int i=0; i < requestMap.keySize("dept[]"); i++){
			deptHiddenStr += requestMap.getString("dept[]", i)+",";
		}
		if(requestMap.keySize("dept[]") > 0) //마지막 , 없애기
			deptHiddenStr = StringReplace.subString(deptHiddenStr, 0, deptHiddenStr.length()-1);
		requestMap.setString("deptStr", deptHiddenStr);
		
		//리스트 인원리스트
		DataMap listMap = lectureApplyService.selectAppInfoByDeptList(requestMap.getString("commGrcode"), requestMap.getString("commGrseq"), deptHiddenStr);

		//기관명 리스트
		DataMap deptList = lectureApplyService.selectDeptList();
		
		//이전기수 수료 리스트
		DataMap finishMemberList = lectureApplyService.selectGrseqFinishMember(requestMap.getString("commGrcode"), requestMap.getString("commGrseq"), deptHiddenStr);
		
		//부서별 인원수. (map.getString(부서코드) 로 숫자를 가져오기 위해)
		DataMap deptCnt = new DataMap();
		DataMap tempCntList = lectureApplyService.selectAppInfoByDeptCntList(requestMap.getString("commGrcode"), requestMap.getString("commGrseq"));
		if(tempCntList == null)
			tempCntList = new DataMap();
		tempCntList.setNullToInitialize(true);
		for(int i = 0; i < tempCntList.keySize("dept"); i++){
			deptCnt.addString(tempCntList.getString("dept", i), tempCntList.getString("cnt", i));
		}
		
		//과정 기수 정보.
		DataMap grseqRowMap = courseSeqService.selectGrSeqRow(requestMap.getString("commGrcode"), requestMap.getString("commGrseq"));
		
		model.addAttribute("LIST_DATA", listMap);
		model.addAttribute("DEPT_LIST_DATA", deptList);
		model.addAttribute("GRSEQ_ROW_DATA", grseqRowMap);
		model.addAttribute("FINISHMEMBER_LIST_DATA", finishMemberList);
		model.addAttribute("DEPT_CNT_ROW_DATA", deptCnt);
		model.addAttribute("DEPT_CNT_LIST_DATA", tempCntList);
		
		return "/courseMgr/lectureApply/lectureApplyList";
	}
	
	/**
	 * 수강신청 조회/승인 리스트 (사이버용)
	 */
	@RequestMapping(value="/courseMgr/lectureApply.do", params = "mode=cyber_list")
	public String cyber_list(@ModelAttribute("cm")CommonMap cm, Model model) throws BizException {
		DataMap requestMap = cm.getDataMap();
		requestMap.setNullToInitialize(true);
		
		//파라미터로 넘기는 부서 코드
		String deptHiddenStr = "";
		for(int i=0; i < requestMap.keySize("dept[]"); i++){
			deptHiddenStr += requestMap.getString("dept[]", i)+",";
		}
		if(requestMap.keySize("dept[]") > 0) //마지막 , 없애기
			deptHiddenStr = StringReplace.subString(deptHiddenStr, 0, deptHiddenStr.length()-1);
		requestMap.setString("deptStr", deptHiddenStr);
		
		//기관명 리스트
		DataMap deptList = lectureApplyService.selectDeptList();
		
		//리스트 인원리스트
		DataMap listMap = lectureApplyService.selectAppInfoByDeptListForCyber(requestMap.getString("commGrcode"), requestMap.getString("commGrseq"), deptHiddenStr);

		//이전기수 수료 리스트
		//DataMap finishMemberList = service.selectGrseqFinishMemberForCyber(requestMap.getString("commGrcode"), requestMap.getString("commGrseq"), deptHiddenStr);
		DataMap finishMemberList = lectureApplyService.selectGrseqFinishMember(requestMap.getString("commGrcode"), requestMap.getString("commGrseq"), deptHiddenStr);
		
		//부서별 인원수. (map.getString(부서코드) 로 숫자를 가져오기 위해)
		DataMap deptCnt = new DataMap();
		DataMap tempCntList = lectureApplyService.selectAppInfoByDeptCntListForCyber(requestMap.getString("commGrcode"), requestMap.getString("commGrseq"));
		if(tempCntList == null)
			tempCntList = new DataMap();
		tempCntList.setNullToInitialize(true);
		for(int i = 0; i < tempCntList.keySize("dept"); i++){
			deptCnt.addString(tempCntList.getString("dept", i), tempCntList.getString("cnt", i));
		}
		
		//과정 기수 정보.
		DataMap grseqRowMap = courseSeqService.selectGrSeqRowForCyber(requestMap);
		
		model.addAttribute("LIST_DATA", listMap);
		model.addAttribute("DEPT_LIST_DATA", deptList);
		model.addAttribute("GRSEQ_ROW_DATA", grseqRowMap);
		model.addAttribute("FINISHMEMBER_LIST_DATA", finishMemberList);
		model.addAttribute("DEPT_CNT_ROW_DATA", deptCnt);
		
		return "/courseMgr/lectureApply/lectureApplyCyberList";
	}
	
	/**
	 * 수료이력 조회 (팝업)
	 */
	@RequestMapping(value="/courseMgr/lectureApply.do", params = "mode=hist_view")
	public String hist_view(@ModelAttribute("cm")CommonMap cm, Model model) throws BizException {
		DataMap requestMap = cm.getDataMap();
		requestMap.setNullToInitialize(true);
		
		//간단한 유저 정보
		DataMap userRowMap = lectureApplyService.selectMemberDeptSimpleRow(requestMap.getString("userno"));
		
		//수료이력
		DataMap listMap = lectureApplyService.selectMemberFinishList(requestMap.getString("userno"));
		
		model.addAttribute("LIST_DATA", listMap);
		model.addAttribute("USER_ROW_DATA", userRowMap);
		
		return "/courseMgr/lectureApply/stuLectureApplyHistoryPop";
	}
	
	/**
	 * 수강생 정보 수정
	 */
	@RequestMapping(value="/courseMgr/lectureApply.do", params = "mode=stu_form")
	public String stu_form(@ModelAttribute("cm")CommonMap cm, Model model) throws BizException {
		DataMap requestMap = cm.getDataMap();
		requestMap.setNullToInitialize(true);
		
		//기수 코드 정보
		DataMap rowMap = lectureApplyService.selectAppInfoRow(requestMap.getString("grcode"), requestMap.getString("grseq"), requestMap.getString("userno"));
		if(rowMap == null) rowMap = new DataMap();
		rowMap.setNullToInitialize(true);
		
		//간단한 유저 정보
		DataMap userRowMap = lectureApplyService.selectMemberDeptSimpleRow(requestMap.getString("userno"));

		//기관 리스트.
		DataMap deptList = lectureApplyService.selectDeptByUserYnList("Y");
		
		model.addAttribute("ROW_DATA", rowMap);
		model.addAttribute("USER_ROW_DATA", userRowMap);
		model.addAttribute("DEPT_LIST_DATA", deptList);
		
		return "/courseMgr/lectureApply/studentInfoFormPop";
	}
	
	/**
	 * 수강신청승인/수강신청승인취소/수강신청취소 처리.
	 */
	@RequestMapping(value="/courseMgr/lectureApply.do", params = "mode=exec")
	public String exec(@ModelAttribute("cm")CommonMap cm, Model model) throws BizException {
		DataMap requestMap = cm.getDataMap();
		requestMap.setNullToInitialize(true);
		 
		//사용자 정보 추출.
		LoginInfo loginInfo = (LoginInfo)cm.getRequest().getAttribute("LOGIN_INFO");
		
		String msg = ""; //결과 메세지.
		int result = 0;
		
		if(requestMap.getString("qu").equals("agree")) {//최종승인
			// 1차 승인
			result = lectureApplyService.execAppInfoAgreeByDept(loginInfo.getSessNo(), requestMap, loginInfo.getSessDept());
			// 최종승인
			result = lectureApplyService.execAppInfoAgree(loginInfo.getSessNo(), requestMap);
			
			if(result > 0){
				msg = "처리하였습니다";
			}else{
				msg = "실패";
			}
		} else if(requestMap.getString("qu").equals("dept_agree")) { //1차 승인 (기관담당자 일경우)
			System.out.println("def");
			/**20181109 기관담당자(외부 승인일경우 ldapcode 추가 처리)*/
			if("6289999".equals(loginInfo.getSessDept())){
				HttpSession session = cm.getRequest().getSession(); //세션
				String sess_ldapcode = (String)session.getAttribute("sess_ldapcode");
				result = lectureApplyService.execAppInfoAgreeByDeptOuter(loginInfo.getSessNo(), requestMap, loginInfo.getSessDept(), sess_ldapcode);				
			}else{
				result = lectureApplyService.execAppInfoAgreeByDept(loginInfo.getSessNo(), requestMap, loginInfo.getSessDept());
			}
			/**20181109 기관담당자(외부 승인일경우 ldapcode 추가 처리)*/
			if(result > 0)
				msg = "처리하였습니다";
			else
				msg = "실패";
		} else if(requestMap.getString("qu").equals("cancel")) { //최종 승인취소
			result = lectureApplyService.execAppInfoCancel(loginInfo.getSessNo(), requestMap);
			
			if(result > 0)
				msg = "처리하였습니다";
			else
				msg = "실패";
		} else if(requestMap.getString("qu").equals("dept_cancel")) { //1차 승인취소
			result = lectureApplyService.execAppInfoCancelByDept(loginInfo.getSessNo(), requestMap);
			
			if(result > 0)
				msg = "처리하였습니다";
			else
				msg = "실패";
		} else if(requestMap.getString("qu").equals("appinfo_update")) { //수강 개인 정보 수정.
			result = lectureApplyService.updateAppInfoDeptAndPart(requestMap);
			
			if(result > 0)
				msg = "수정 되었습니다.";
			else
				msg = "실패";
		} else if(requestMap.getString("qu").equals("cyber_agree")) { //사이버 과정의 수강신청 승인처리.
			result = lectureApplyService.execAppInfoAgreeForCyber(loginInfo.getSessNo(), requestMap);
			
			if(result > 0)
				msg = "처리하였습니다";
			else
				msg = "실패";
		} else if(requestMap.getString("qu").equals("cyber_cancel")) { //사이버 과정의 승인취소
			result = lectureApplyService.execAppInfoCancelForCyber(loginInfo.getSessNo(), requestMap);
			
			if(result > 0)
				msg = "처리하였습니다";
			else
				msg = "실패";
		} else if(requestMap.getString("qu").equals("appinfo_delete")) { //수강신청정보 삭제
			//파라미터
			result = lectureApplyService.deleteAppInfo(requestMap);
			
			if(result > 0)
				msg = "삭제하였습니다.";
			else
				msg = "실패";
		}
		
		model.addAttribute("RESULT_MSG", msg);
		
		return "/courseMgr/lectureApply/lectureApplyExec";
	}
	
	/**
	 * ajax 부서 select Box
	 */
	@RequestMapping(value="/courseMgr/lectureApply.do", params = "mode=ajax_part")
	public String ajax_part(@ModelAttribute("cm")CommonMap cm, Model model) throws BizException {
		DataMap requestMap = cm.getDataMap();
		requestMap.setNullToInitialize(true);
		
		//부서 리스트
		DataMap listMap = null;

		if("6289999".equals(requestMap.getString("dept"))) {
			listMap = lectureApplyService.selectLdapcodeList(requestMap.getString("dept"));
		} else {
			listMap = lectureApplyService.selectPartUseList(requestMap.getString("dept"));
		}		

		model.addAttribute("LIST_DATA", listMap);
		
		return "/courseMgr/lectureApply/lectureApplyPartcdAjax";
	}
	
	/**
	 * ajax 통신 (교번부여)
	 */
	@RequestMapping(value="/courseMgr/lectureApply.do", params = "mode=ajax_exec")
	public String ajax_exec(@ModelAttribute("cm")CommonMap cm, Model model) throws BizException {
		DataMap requestMap = cm.getDataMap();
		requestMap.setNullToInitialize(true);
		
		//사용자 정보 추출.
		LoginInfo loginInfo = (LoginInfo)cm.getRequest().getAttribute("LOGIN_INFO");
		
		
		String msg = ""; //결과 메세지.

		if(requestMap.getString("qu").equals("eduno")){ //교번부여
			lectureApplyService.updateAppInfoEduNo(loginInfo.getSessNo(), requestMap);
		}else if(requestMap.getString("qu").equals("cyber_eduno")){ //cyber_교번부여
			lectureApplyService.execCAppInfoEduNoForCyber(loginInfo.getSessNo(), requestMap);
		}
		
		model.addAttribute("RESULT_MSG", msg);
		
		return "/commonInc/ajax/ajaxBlankPage";
	}
	
	/**
	 * 수강신청 승인현황 리스트
	 */
	@RequestMapping(value="/courseMgr/lectureApply.do", params = "mode=status_list")
	public String status_list(@ModelAttribute("cm")CommonMap cm, Model model) throws BizException {
		DataMap requestMap = cm.getDataMap();
		requestMap.setNullToInitialize(true);
		
		//사용자 정보 추출.
		LoginInfo loginInfo = (LoginInfo)cm.getRequest().getAttribute("LOGIN_INFO");
		
		if (requestMap.getString("currPage").equals(""))	requestMap.setInt("currPage", 1); //페이지
		if (requestMap.getString("rowSize").equals(""))		requestMap.setInt("rowSize", 15); //페이지당 보여줄 갯수
		if (requestMap.getString("pageSize").equals("")) 	requestMap.setInt("pageSize", 10); //페이지 블럭 갯수
		
		HttpSession session = cm.getRequest().getSession(); //세션
		String sess_ldapcode = (String)session.getAttribute("sess_ldapcode");
		//수강신청 리스트.
		DataMap listMap = lectureApplyService.selectAppInfoBySessDeptList(requestMap.getString("commGrcode"), requestMap.getString("commGrseq"), sess_ldapcode, loginInfo, requestMap);
		
		//과정 기수 정보.
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("grcode", requestMap.getString("grcode"));
		paramMap.put("grseq", requestMap.getString("grseq"));
		DataMap grseqMap = courseSeqService.selectGrseqSimpleRow(paramMap);
		
		model.addAttribute("LIST_DATA", listMap);
		model.addAttribute("GRSEQ_ROW_DATA", grseqMap);
		
		return "/courseMgr/lectureApply/lectureApplyStatusList";
	}
	
	/**
	 * 메일 발송
	 */
	@RequestMapping(value="/courseMgr/lectureApply.do", params = "mode=sms_list")
	public String sms_list(@ModelAttribute("cm")CommonMap cm, Model model) throws BizException {
		DataMap requestMap = cm.getDataMap();
		requestMap.setNullToInitialize(true);
		
		//수강신청 리스트.
		DataMap listMap = lectureApplyService.selectMemberBySimpleDataList(requestMap);
		
		model.addAttribute("LIST_DATA", listMap);
		
		return "/courseMgr/lectureApply/lectureApplySmsList";
	}
	
	/**
	 * 수강신청조회/승인 리스트 (기관담당자)
	 */
	@RequestMapping(value="/courseMgr/lectureApply.do", params = "mode=dept_list")
	public String dept_list(@ModelAttribute("cm")CommonMap cm, Model model) throws BizException {
		DataMap requestMap = cm.getDataMap();
		requestMap.setNullToInitialize(true);
		
		//사용자 정보 추출.
		LoginInfo loginInfo = (LoginInfo)cm.getRequest().getAttribute("LOGIN_INFO");
		
		//이전기수 수료 리스트
		DataMap finishMemberList = lectureApplyService.selectGrseqFinishMember(requestMap.getString("commGrcode"), requestMap.getString("commGrseq"), loginInfo.getSessDept());
		
		HttpSession session = cm.getRequest().getSession(); //세션
		String sess_ldapcode = (String)session.getAttribute("sess_ldapcode");
		//리스트 인원리스트
		DataMap listMap = lectureApplyService.selectAppInfoBySessDeptList(requestMap.getString("commGrcode"), requestMap.getString("commGrseq"), sess_ldapcode, loginInfo);

		//과정 기수 정보.
		DataMap grseqRowMap = courseSeqService.selectGrSeqRow(requestMap.getString("commGrcode"), requestMap.getString("commGrseq"));
		
		//기관 정보.
		DataMap deptRowMap = lectureApplyService.selectDeptBySimpleRow(Util.getValue(loginInfo.getSessDept(), ""));
		
		model.addAttribute("LIST_DATA", listMap);
		model.addAttribute("GRSEQ_ROW_DATA", grseqRowMap);
		model.addAttribute("DEPT_ROW_DATA", deptRowMap);
		model.addAttribute("FINISHMEMBER_LIST_DATA", finishMemberList);
		
		return "/courseMgr/lectureApply/lectureApplyDeptList";
	}
	
	/**
	 * 수강신청 조회/승인 리스트( 기관담당자 )
	 */
	@RequestMapping(value="/courseMgr/lectureApply.do", params = "mode=cyber_dept_list")
	public String cyber_dept_list(@ModelAttribute("cm")CommonMap cm, Model model) throws BizException {
		DataMap requestMap = cm.getDataMap();
		requestMap.setNullToInitialize(true);
		
		//사용자 정보 추출.
		LoginInfo loginInfo = (LoginInfo)cm.getRequest().getAttribute("LOGIN_INFO");
		
		HttpSession session = cm.getRequest().getSession(); //세션
		String sess_ldapcode = (String)session.getAttribute("sess_ldapcode");
		
		//리스트 인원리스트
		DataMap listMap = lectureApplyService.selectAppInfoByDeptListForCyber(requestMap.getString("commGrcode"), requestMap.getString("commGrseq"), sess_ldapcode, loginInfo);

		//이전기수 수료 리스트
		DataMap finishMemberList = lectureApplyService.selectGrseqFinishMemberForCyber(requestMap.getString("commGrcode"), requestMap.getString("commGrseq"), loginInfo);
		
		//과정 기수 정보.
		DataMap grseqRowMap = courseSeqService.selectGrSeqRowForCyber(requestMap);
		
		//기관 정보.
		DataMap deptRowMap = lectureApplyService.selectDeptBySimpleRow(Util.getValue(loginInfo.getSessDept(), ""));
		
		model.addAttribute("LIST_DATA", listMap);
		model.addAttribute("GRSEQ_ROW_DATA", grseqRowMap);
		model.addAttribute("DEPT_ROW_DATA", deptRowMap);
		model.addAttribute("FINISHMEMBER_LIST_DATA", finishMemberList);
		
		return "/courseMgr/lectureApply/lectureApplyDeptCyberList";
	}
}
