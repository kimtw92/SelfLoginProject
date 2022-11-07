package loti.tutorMgr.web;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import loti.common.service.CommonService;
import loti.tutorMgr.service.AllowanceService;
import loti.tutorMgr.service.TutorMgrService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import ut.lib.login.LoginCheck;
import ut.lib.login.LoginInfo;
import ut.lib.support.CommonMap;
import ut.lib.support.DataMap;
import ut.lib.util.DateUtil;
import ut.lib.util.Util;
import common.controller.BaseController;

@Controller
public class TutorMgrController extends BaseController{

	@Autowired
	private TutorMgrService tutorMgrService;
	
	@Autowired
	private CommonService commonService;
	
	@Autowired
	private AllowanceService allowanceService;
	
	@ModelAttribute("cm")
	public CommonMap common(
				CommonMap cm
				, @RequestParam(value="mode", required=false, defaultValue="") String mode
				, HttpServletRequest request
				, HttpServletResponse response
			) throws Exception{

		// 리퀘스트 받기
		DataMap requestMap = cm.getDataMap();
		requestMap.setNullToInitialize(true);
		
		//관리자 로그인 체크
		LoginInfo memberInfo = null;
		
		if(mode.equals("searchTutorPop") || 
				mode.equals("checkResId") ||
				mode.equals("searchSubjPop")	){
			memberInfo = LoginCheck.adminCheckPopup(request, response);
		}else{
			memberInfo = LoginCheck.adminCheck(request, response, requestMap.getString("menuId") );
		}
			
		if (memberInfo == null){			
			return null;
		}
		
		
		// 리퀘스트 정보를 담고있는 DataMap을 Attribute 에 추가
		request.setAttribute("REQUEST_DATA", requestMap);
		
		return cm;
	}
	
	/*
	@RequestMapping(value="/tutorMgr/tutor.do")
	public String defaultM(@ModelAttribute("cm") CommonMap cm, Model model) throws Exception{
		DataMap requestMap = cm.getDataMap();
		requestMap.setNullToInitialize(true);
		
		return "";
	}
	*/
	
	/**
	 * 강사관리 메인 페이지
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @param requestMap
	 * @throws Exception
	 */
	public void selectTutorFormList(
			Model model,
			DataMap requestMap) throws Exception {
		
		DataMap listMap1 = null;
		DataMap listMap2 = null;
		DataMap listMap3 = null;
		
		
		
		// 담당 분야 리스트
		listMap1 = tutorMgrService.selectTutorField();
		
		// 등급별 강사 인원 리스트
		listMap2 = tutorMgrService.selectTutorLevelTotal();
		
		// 직업별 강사분류 리스트
		listMap3 = tutorMgrService.selectTutorJobList();
		
		model.addAttribute("TUTOR_FIELD_DATA", listMap1);
		model.addAttribute("TUTOR_LEVEL_TOTAL", listMap2);
		model.addAttribute("TUTOR_JOB_LIST", listMap3);
		
	}
	
	@RequestMapping(value="/tutorMgr/tutor.do", params="mode=list")
	public String list(
				@ModelAttribute("cm") CommonMap cm
				, Model model
			) throws Exception{
		selectTutorFormList(model, cm.getDataMap());
		return "/tutorMgr/tutorMgr/tutorList";
	}
	
	/**
	 * 카테고리별 리스트
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @param requestMap
	 * @throws Exception
	 */
	public void selectTutorCategoryList(
			Model model,
			DataMap requestMap) throws Exception {
		
		DataMap listMap1 = null;
		DataMap listMap2 = null;
		DataMap listMap3 = null;
		
		// 페이지
		if (requestMap.getString("currPage").equals("")){
			requestMap.setInt("currPage", 1);
		}
		// 페이지당 보여줄 갯수
		if (requestMap.getString("rowSize").equals("")){
			requestMap.setInt("rowSize", 10); 
		}
		// 페이지 블럭 갯수
		if (requestMap.getString("pageSize").equals("")){
			requestMap.setInt("pageSize", 10);
		}
		
		// 담당 분야 리스트
		listMap1 = tutorMgrService.selectTutorField();
		
		// 등급별 강사 인원 리스트
		listMap2 = tutorMgrService.selectTutorLevelTotal();
		
		// 카테고리별 리스트
		listMap3 = tutorMgrService.selectCategotyTutorList(requestMap);
		
		model.addAttribute("TUTOR_FIELD_DATA", listMap1);
		model.addAttribute("TUTOR_LEVEL_TOTAL", listMap2);
		model.addAttribute("LIST_DATA", listMap3);
	}
	
	@RequestMapping(value="/tutorMgr/tutor.do", params="mode=categoty")
	public String categoty(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			) throws Exception{
		
		selectTutorCategoryList(model, cm.getDataMap());
		
		return "/tutorMgr/tutorMgr/tutorCategoryList";
	}
	
	/**
	 * 강사권한변경
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @param requestMap
	 * @param sessNo
	 * @throws Exception
	 */
	public void updateChangeTutorAuth(
			Model model,
			DataMap requestMap,
			String sessNo) throws Exception {
				
		String msg = "";
		String resultType = "";
		int result = 0;
		
		
		result = tutorMgrService.updateChangeTutorAuth(
					requestMap.getString("disabled"), 
					requestMap.getString("userNo"),
					sessNo);
				
		if(result > 0){
			
			msg = "저장 되었습니다.";						
			resultType = "changeAuthOk";			

		}else{			
			msg = "저장시 오류가 발생했습니다.";
			resultType = "changeAuthError";			
		}				
		
		model.addAttribute("RESULT_MSG", msg);
		model.addAttribute("RESULT_TYPE", resultType);		
	}
	
	@RequestMapping(value="/tutorMgr/tutor.do", params="mode=changeAuth")
	public String changeAuth(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			) throws Exception{
		
		updateChangeTutorAuth(model, cm.getDataMap(), cm.getLoginInfo().getSessNo());
		
		return "/tutorMgr/tutorMgr/tutorExec";
	}
	
	/**
	 * 카테고리별 리스트
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @param requestMap
	 * @throws Exception
	 */
	public void selectTutorCategoryExcelList(
			Model model,
			DataMap requestMap) throws Exception {
		
		DataMap listMap1 = null;
		DataMap listMap2 = null;
		DataMap listMap3 = null;
				
		// 페이지
		if (requestMap.getString("currPage").equals("")){
			requestMap.setInt("currPage", 1);
		}
		// 페이지당 보여줄 갯수
		if (requestMap.getString("rowSize").equals("")){
			requestMap.setInt("rowSize", 10000); 
		}
		// 페이지 블럭 갯수
		if (requestMap.getString("pageSize").equals("")){
			requestMap.setInt("pageSize", 1);
		}
		
		// 담당 분야 리스트
		listMap1 = tutorMgrService.selectTutorField();
		
		// 등급별 강사 인원 리스트
		listMap2 = tutorMgrService.selectTutorLevelTotal();
		
		// 카테고리별 리스트
		listMap3 = tutorMgrService.selectCategotyTutorExcelList(requestMap);
		
		model.addAttribute("TUTOR_FIELD_DATA", listMap1);
		model.addAttribute("TUTOR_LEVEL_TOTAL", listMap2);
		model.addAttribute("LIST_DATA", listMap3);
	}
	
	@RequestMapping(value="/tutorMgr/tutor.do", params="mode=tutor_excel")
	public String tutor_excel(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			) throws Exception{
		
		selectTutorCategoryExcelList(model, cm.getDataMap());
		
		return "/tutorMgr/tutorMgr/tutor_excel";
	}

	/**
	 * 강사 입력/수정 화면 기본정보
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @param requestMap
	 * @throws Exception
	 */
	public void tutorForm(
			Model model,
			DataMap requestMap,
			String sessClass,
			String sessNo) throws Exception {
		
		DataMap gubunMap = null;
		DataMap levelMap = null;		
		DataMap typeMap = null;
		DataMap memberDamoMap = null;
		DataMap tutorDamoMap = null;
		DataMap tutorHistoryMap1 = null;
		DataMap tutorHistoryMap2 = null;
		DataMap tutorHistoryMap3 = null;
		DataMap tutorHistoryMap4 = null;
		//주강사 보조강사 멥
		DataMap classInfoMap = null;
		
		String type = Util.getValue( requestMap.getString("type"), "1" );
		String userno = Util.getValue( requestMap.getString("userno"), sessNo);
		
		
		
		if(sessClass.equals("7")){
			
			// 강사인경우
			userno = sessNo;
			
			typeMap = tutorMgrService.selectSessnoBy7(userno);
			
			if("".equals(typeMap.get("tUserno")) && "".equals(typeMap.get("mUserno"))){
				type = "1";
			}else if(!"".equals(typeMap.get("tUserno")) && !"".equals(typeMap.get("mUserno"))){
				type = "3";
			}else if("".equals(typeMap.get("tUserno")) && !"".equals(typeMap.get("mUserno"))){
				type = "2";
			}												
		}
		
		if(type.equals("1")){
			
		}else if(type.equals("2")){
			
			memberDamoMap = tutorMgrService.selectMemberDamo(userno);
			tutorHistoryMap1 = tutorMgrService.selectTutorHistory(userno, "1");
			tutorHistoryMap2 = tutorMgrService.selectTutorHistory(userno, "2");
			tutorHistoryMap3 = tutorMgrService.selectTutorHistory(userno, "3");
			tutorHistoryMap4 = tutorMgrService.selectTutorHistory(userno, "4");
			
		}else if(type.equals("3")){
			
			memberDamoMap = tutorMgrService.selectMemberDamo(userno);
			tutorDamoMap = tutorMgrService.selectTutorDamo(userno);
			tutorHistoryMap1 = tutorMgrService.selectTutorHistory(userno, "1");
			tutorHistoryMap2 = tutorMgrService.selectTutorHistory(userno, "2");
			tutorHistoryMap3 = tutorMgrService.selectTutorHistory(userno, "3");
			tutorHistoryMap4 = tutorMgrService.selectTutorHistory(userno, "4");
		}
								
		
		// 담당 분야 전체 리스트
		gubunMap = tutorMgrService.selectTutorGubun();
		
		// 강사등급 전체 리스트
		levelMap = tutorMgrService.selectTutorLevel();
		
		
		
		//출강현황 주강사, 보조강사 리스트
		//작성자 : 정윤철
		//추가일 11월 11일
		classInfoMap = tutorMgrService.selectClassInfo(userno);
		
		model.addAttribute("TUTOR_GUBUN_LIST", gubunMap);
		model.addAttribute("TUTOR_LEVEL_LIST", levelMap);
		model.addAttribute("MEMBERDAMO_ROW", memberDamoMap);
		model.addAttribute("TUTORDAMO_ROW", tutorDamoMap);
		
		model.addAttribute("TUTOR_HISTORY1", tutorHistoryMap1);
		model.addAttribute("TUTOR_HISTORY2", tutorHistoryMap2);
		model.addAttribute("TUTOR_HISTORY3", tutorHistoryMap3);
		model.addAttribute("TUTOR_HISTORY4", tutorHistoryMap4);
		model.addAttribute("TUTOR_CLASSINFO_LIST", classInfoMap);
		
		model.addAttribute("TYPE", type);
		
		commonService.selectUploadFileList(tutorDamoMap);
	}
	
	@RequestMapping(value="/tutorMgr/tutor.do", params="mode=regForm")
	public String regForm(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			) throws Exception{
		
		tutorForm(model, cm.getDataMap(), cm.getLoginInfo().getSessClass(), cm.getLoginInfo().getSessNo());
		
		return "/tutorMgr/tutorMgr/tutorForm";
	}
	
	@RequestMapping(value="/tutorMgr/tutor.do", params="mode=tutorPopView")
	public String tutorPopView(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			) throws Exception{
		
		tutorForm(model, cm.getDataMap(), cm.getLoginInfo().getSessClass(), cm.getLoginInfo().getSessNo());
		
		return "/tutorMgr/tutorMgr/tutorPopView";
	}
	
	@RequestMapping(value="/tutorMgr/tutor.do", params="mode=tutorPrint")
	public String tutorPrint(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			) throws Exception{
		
		tutorForm(model, cm.getDataMap(), cm.getLoginInfo().getSessClass(), cm.getLoginInfo().getSessNo());
		
		return "/tutorMgr/tutorMgr/tutorPopPrint";
	}
	
	/**
	 * 우수강사 리스트
	 * 작성일 7월 11일
	 * 작성자 정 윤철
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @param requestMap
	 * @throws Exception
	 */
	public void selectGoodTutor(
			Model model
			, DataMap requestMap) throws Exception {
		
		DataMap listMap = null;
		if(requestMap.getString("qu").equals("search")){
			//검색모드일때
			listMap = tutorMgrService.selectGoodTutorlList(requestMap);
			
		}else{
			//첫페이지일때는  널처리
			listMap = new DataMap();
			
		}
		
		model.addAttribute("LIST_DATA", listMap);
	}
	
	@RequestMapping(value="/tutorMgr/goodTutor.do", params="mode=goodTutorList")
	public String goodTutorList(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			) throws Exception{
		
		selectGoodTutor(model, cm.getDataMap());
		
		return "/tutorMgr/tutorMgr/goodTutorList";
	}
	
	/**
	 * 우수강사 엑셀출력
	 * 작성일 7월 11일
	 * 작성자 정 윤철
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @param requestMap
	 * @throws Exception
	 */
	public void goodTutorexcel(
			Model model
			, DataMap requestMap) throws Exception {
		
		DataMap listMap = null;
		
		//엑셀출력
		listMap = tutorMgrService.selectGoodTutorlList(requestMap);
		
		model.addAttribute("LIST_DATA", listMap);
	}
	
	@RequestMapping(value="/tutorMgr/goodTutor.do", params="mode=goodTutorexcel")
	public String goodTutorexcel(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			) throws Exception{
		
		goodTutorexcel(model, cm.getDataMap());
		
		return "/tutorMgr/tutorMgr/goodTutorByExcel";
	}
	
	/**
	 * 강사이력관리 리스트
	 * 작성일 7월 11일
	 * 작성자 정 윤철
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @param requestMap
	 * @throws Exception
	 */
	public void selectHistoryList(
			Model model
			, DataMap requestMap) throws Exception {
		
		DataMap listMap = null;
		DataMap allowanceMap = null;
		// 페이지
		if (requestMap.getString("currPage").equals("")){
			requestMap.setInt("currPage", 1);
		}
		// 페이지당 보여줄 갯수
		if (requestMap.getString("rowSize").equals("")){
			requestMap.setInt("rowSize", 15); 
		}
		// 페이지 블럭 갯수
		if (requestMap.getString("pageSize").equals("")){
			requestMap.setInt("pageSize", 10);
		}
		//selectAllowanceList
		//강사이력관리 리스트
		listMap = tutorMgrService.selectHistoryList(requestMap);
		allowanceMap = allowanceService.selectAllowanceList();
		
		DataMap levelNameListMap = tutorMgrService.selectTutorLevelName();
		DataMap levelCountListMap = tutorMgrService.selectTutorLevelCount(requestMap);
		
		
		model.addAttribute("LIST_DATA", listMap);
		model.addAttribute("ALLOWANCELIST_DATA", allowanceMap);
		model.addAttribute("NAMELIST_DATA", levelNameListMap);
		model.addAttribute("COUNTLIST_DATA", levelCountListMap);
	}
	
	@RequestMapping(value="/tutorMgr/historyTutor.do", params="mode=historyTutorList")
	public String historyTutorList(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			) throws Exception{
		
		selectHistoryList(model, cm.getDataMap());
		
		return "/tutorMgr/tutorMgr/historyTutorList";
	}
	
	/**
	 * 강사이력관리 엑셀 출력
	 * 작성일 9월 17일
	 * 작성자 정 윤철
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @param requestMap
	 * @throws Exception
	 */
	public void selectExcelHistoryList(
			Model model
			, DataMap requestMap) throws Exception {
		
		DataMap listMap = null;

		//강사이력관리 리스트
		listMap = tutorMgrService.selectHistoryList(requestMap);
		
		model.addAttribute("LIST_DATA", listMap);
	}
	
	@RequestMapping(value="/tutorMgr/historyTutor.do", params="mode=historyTutorexcel")
	public String historyTutorexcel(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			) throws Exception{
		
		selectExcelHistoryList(model, cm.getDataMap());
		
		return "/tutorMgr/tutorMgr/historyTutorByExcel";
	}
	
	/**
	 * 외래강사 수강료 관리 리스트
	 * 작성일 7월 11일
	 * 작성자 정 윤철
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @param requestMap
	 * @throws Exception
	 */
	public void selectSalaryList(
			Model model
			, DataMap requestMap) throws Exception {
		
		DataMap listMap = null;
		DataMap courseListMap = null;
		
		if(requestMap.getString("salaryType").equals("cyber") || requestMap.getString("salaryType").equals("")){
			//사이버 강사 수당관리
			listMap = tutorMgrService.selectSalaryCyberList(requestMap);
			
		}else if(requestMap.getString("salaryType").equals("collec")){
			//집합강사 수당내역
			listMap = tutorMgrService.selectSalaryCollecList(requestMap);
			
		}else if(requestMap.getString("salaryType").equals("copyPay")){
			//원고료 수당내역
			listMap = tutorMgrService.selectSalaryCopyPayList(requestMap);
			
		}else if(requestMap.getString("salaryType").equals("exam")){
			//출제료 수당내역
			listMap = tutorMgrService.selectSalaryExamList(requestMap);
		}
		
		courseListMap = tutorMgrService.selectCoursorList();
		
		model.addAttribute("COURSTLIST_DATA", courseListMap);
		model.addAttribute("LIST_DATA", listMap);
	}
	
	@RequestMapping(value="/tutorMgr/salary.do", params="mode=salaryList")
	public String salaryList(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			) throws Exception{
		
		selectSalaryList(model, cm.getDataMap());
		
		return "/tutorMgr/tutorSalary/salaryList";
	}
	
	/**
	 * 외래강사 검색 조건 중 날짜 특정요일 데이터
	 * 작성일 7월 14일
	 * 작성자 정 윤철
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @param requestMap
	 * @throws Exception
	 */
	public void ajaxDateChk(
			Model model
			, DataMap requestMap) throws Exception {
		
		String returnValue = "";
		
		returnValue = DateUtil.getDayOfWeekNum(requestMap.getString("sDate"));
		requestMap.setString("date", returnValue);
	}	
	
	@RequestMapping(value="/tutorMgr/salary.do", params="mode=ajaxDateChk")
	public String ajaxDateChk(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			) throws Exception{
		
		ajaxDateChk(model, cm.getDataMap());
		
		return "/tutorMgr/tutorSalary/ajaxDateChk";
	}
	
	/**
	 * 외래강사 사이버 집합강사 팝업 리스트
	 * 작성일 7월 14일
	 * 작성자 정 윤철
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @param requestMap
	 * @throws Exception
	 */
	public void selectTutorCyberAndCollecPop(
			Model model
			, DataMap requestMap) throws Exception {
		
		DataMap listMap = null;

		//사이버강사 모드일때 사이버강사 수강료 과제물출제 수당과 질의 응답수당의 값을 가져온다.
		DataMap cyberRowMap = null;
		
		listMap = tutorMgrService.selectTutorCyberAndCollecPop();
		
		if(requestMap.getString("mode").equals("salaryCyberPop")){
			//사이버 강사 모드
			cyberRowMap = tutorMgrService.selectTutorSalaryQustionRow();
			
		}else{
			//집합강사 모드
			cyberRowMap = new DataMap();
			
		}
		
		model.addAttribute("LIST_DATA", listMap);
		model.addAttribute("CYBERROW_DATA", cyberRowMap);
	}
	
	@RequestMapping(value="/tutorMgr/salary.do", params="mode=salaryCyberPop")
	public String salaryCyberPop(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			) throws Exception{
		
		selectTutorCyberAndCollecPop(model, cm.getDataMap());
		
		return "/tutorMgr/tutorSalary/salaryCyberPop";
	}
	
	/**
	 * 외래강사 수당 지급확정 및 취소
	 * 작성일 7월 14일
	 * 작성자 정 윤철
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @param requestMap
	 * @throws Exception
	 */
	public void tutorSalaryExec(
			Model model
			, DataMap requestMap) throws Exception {
		
		int returnValue = 0;
		
		if(requestMap.getString("salaryType").equals("cyber")){
			//사이버강사 수당확정 및 취소 메소드
			returnValue = tutorMgrService.insertTutorSalaryNcyberPay(requestMap);
		}else if(requestMap.getString("salaryType").equals("collec")){
			//집합강사수당관리
			returnValue = tutorMgrService.insertTutorSalaryNcollecPay(requestMap);
		}else if(requestMap.getString("salaryType").equals("copyPay")){
			//원고수당관리
			returnValue = tutorMgrService.insertCopyPay(requestMap);
		}else if(requestMap.getString("salaryType").equals("exam")){
			//출제료 수당 관리
			returnValue = tutorMgrService.insertExam(requestMap);
		}
		
		if(returnValue == 1){
			requestMap.setString("msg","저장되었습니다.");
		}else if(returnValue ==0){
			requestMap.setString("msg","저장에 실패하였습니다.");
		}
		
	}
	
	@RequestMapping(value="/tutorMgr/salary.do", params="mode=tutorSalaryExec")
	public String tutorSalaryExec(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			) throws Exception{
		
		tutorSalaryExec(model, cm.getDataMap());
		
		return "/tutorMgr/tutorSalary/salaryExec";
	}
	
	/**
	 * 외래강사 수당관리 팝업페이지 관리 
	 * 작성일 7월 14일
	 * 작성자 정 윤철
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @param requestMap
	 * @throws Exception
	 */
	public void salaryPopExec(
			DataMap requestMap) throws Exception {
		
			if(requestMap.getString("qu").equals("cyber")){
				tutorMgrService.tutorSubjectExec(requestMap);
				tutorMgrService.insertAllowance(requestMap);
				
			}else if(requestMap.getString("qu").equals("collec")){
				tutorMgrService.insertAllowance(requestMap);
				requestMap.setString("msg", "등록하였습니다.");

			}else if(requestMap.getString("qu").equals("copyPay")){
				tutorMgrService.execCopyPay(requestMap);
				if(requestMap.getString("subMode").equals("insert")){
					requestMap.setString("msg", "등록하였습니다.");
				}else{
					requestMap.setString("msg", "삭제하였습니다.");
				}
				
			}else if(requestMap.getString("qu").equals("exam")){
				tutorMgrService.execSalaryExamPop(requestMap);
				requestMap.setString("msg", "등록하였습니다.");
				
			}
			
	}	
	
	@RequestMapping(value="/tutorMgr/salary.do", params="mode=salaryPopExec")
	public String salaryPopExec(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			) throws Exception{
		
		salaryPopExec(cm.getDataMap());
		
		return "/tutorMgr/tutorSalary/salaryExec";
	}
	
	@RequestMapping(value="/tutorMgr/salary.do", params="mode=salaryCollecPop")
	public String salaryCollecPop(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			) throws Exception{
		
		selectTutorCyberAndCollecPop(model, cm.getDataMap());
		
		return "/tutorMgr/tutorSalary/salaryCollecPop";
	}
	
	/**
	 * 원고료수당관리 및 평가 출제 수당관리
	 * 작성일 7월 14일
	 * 작성자 정 윤철
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @param requestMap
	 * @throws Exception
	 */
	public void selectTutorSalaryCopyPayRow(
			Model model
			, DataMap requestMap) throws Exception {
		
		DataMap listMap = null;
		
		listMap = tutorMgrService.selectTutorSalaryCopyPayRow(requestMap);
		
		model.addAttribute("LIST_DATA", listMap);
	}
	
	@RequestMapping(value="/tutorMgr/salary.do", params="mode=salaryCopyPayPop")
	public String salaryCopyPayPop(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			) throws Exception{
		
		selectTutorSalaryCopyPayRow(model, cm.getDataMap());
		
		return "/tutorMgr/tutorSalary/salaryCopyPayPop";
	}
	
	@RequestMapping(value="/tutorMgr/salary.do", params="mode=salaryExamPop")
	public String salaryExamPop(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			) throws Exception{
		
		selectTutorSalaryCopyPayRow(model, cm.getDataMap());
		
		return "/tutorMgr/tutorSalary/salaryExamPop";
	}
	
	/**
	 * 외래강사 수강료 엑셀출력
	 * 작성일 7월 11일
	 * 작성자 정 윤철
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @param requestMap
	 * @throws Exception
	 */
	public void salaryExcel(
			Model model
			, DataMap requestMap) throws Exception {
		
		DataMap listMap = null;
		DataMap courseListMap = null;
		
		if(requestMap.getString("salaryType").equals("cyber") || requestMap.getString("salaryType").equals("")){
			//사이버 강사 수당관리
			listMap = tutorMgrService.selectSalaryCyberList(requestMap);
			
		}else if(requestMap.getString("salaryType").equals("collec")){
			//집합강사 수당내역
			listMap = tutorMgrService.selectSalaryCollecList(requestMap);
			
		}else if(requestMap.getString("salaryType").equals("copyPay")){
			//원고료 수당내역
			listMap = tutorMgrService.selectSalaryCopyPayList(requestMap);
			
		}else if(requestMap.getString("salaryType").equals("exam")){
			//출제료 수당내역
			listMap = tutorMgrService.selectSalaryExamList(requestMap);
		}
		
		courseListMap = tutorMgrService.selectCoursorList();
		
		model.addAttribute("COURSTLIST_DATA", courseListMap);
		model.addAttribute("LIST_DATA", listMap);
	}	
	
	@RequestMapping(value="/tutorMgr/salary.do", params="mode=salaryExcel")
	public String salaryExcel(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			) throws Exception{
		
		salaryExcel(model, cm.getDataMap());
		
		return "/tutorMgr/tutorSalary/salaryListByExcel";
	}
	
	
	/**
	 * 강사별 수당내역
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @param requestMap
	 * @throws Exception
	 */
	public void selectTutorSalaryList(
			Model model
			, DataMap requestMap) throws Exception {
		
		DataMap listMap = null;
		DataMap tutorLevleMap = null;
		
		//강사별 수당 내역
		listMap = tutorMgrService.selectTutorSalaryList(requestMap);
		//강사등급 레벨
		tutorLevleMap = tutorMgrService.selectTutorLevelList(requestMap); 
		
		model.addAttribute("LIST_DATA", listMap);
		model.addAttribute("TUTORLEVEL_LIST_DATA", tutorLevleMap);
		
	}
	
	@RequestMapping(value="/tutorMgr/salary.do", params="mode=pluralFormSalaryList")
	public String pluralFormSalaryList(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			) throws Exception{
		
		selectTutorSalaryList(model, cm.getDataMap());
		
		return "/tutorMgr/tutorSalary/salaryTutorResultList";
	}
	
	@RequestMapping(value="/tutorMgr/salary.do", params="mode=pluralFormSalaryExcel")
	public String pluralFormSalaryExcel(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			) throws Exception{
		
		selectTutorSalaryList(model, cm.getDataMap());
		
		return "/tutorMgr/tutorSalary/salaryTutorResultExcel";
	}
	
	/**
	 * 등급별 수당내역
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @param requestMap
	 * @throws Exception
	 */
	public void selectGreadeResultList(
			Model model
			, DataMap requestMap) throws Exception {
		
		DataMap listMap = null;
		DataMap tseatMap = null;
		
		
		//외래강사 등급별 수당내역
		listMap = tutorMgrService.selectGreadeResultList(requestMap);
		//교육인원 카운터
		tseatMap = tutorMgrService.selectTseat(requestMap);
		
		if(tseatMap == null){
			tseatMap = new DataMap();
		}
		model.addAttribute("LIST_DATA", listMap);
		model.addAttribute("TSEATLIST_DATA", tseatMap);
	}
	
	@RequestMapping(value="/tutorMgr/salary.do", params="mode=selectGreadeResultList")
	public String selectGreadeResultList(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			) throws Exception{
		
		selectGreadeResultList(model, cm.getDataMap());
		
		return "/tutorMgr/tutorSalary/salaryGradeResultList";
	}
	
	/**
	 * 강사검색 팝업 (이름, 주민번호로 검색)
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @param requestMap
	 * @throws Exception
	 */
	public void selectSearchTutorPop(
			Model model
			, DataMap requestMap) throws Exception {
		
		DataMap listMap = null;
		
		// 담당 분야 리스트
		listMap = tutorMgrService.selectSearchTutorPop(requestMap);
		
		model.addAttribute("LIST_DATA", listMap);
		
	}
	
	@RequestMapping(value="/tutorMgr/tutor.do", params="mode=searchTutorPop")
	public String searchTutorPop(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			) throws Exception{
		
		// 강사회원검색
		if(!cm.getDataMap().getString("hidSearchType").equals("")){
			selectSearchTutorPop( model, cm.getDataMap());
		}
		
		return "/tutorMgr/tutorMgr/searchTutorPop";
	}
	
	/**
	 * 주민등록버호, 유저ID 중복여부 체크
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @param requestMap
	 * @throws Exception
	 */
	public void checkResnoAndUserId(
			Model model
			, DataMap requestMap) throws Exception {
		
		DataMap rowMap = null;
		
		String retValue = "";
						
		String ptype = requestMap.getString("ptype");	// 주민번호 또는 아이디 구분
		String searchTxt = requestMap.getString("searchTxt");
		
		if(ptype.equals("resno")){
			// 주민번호 중복 체크
			rowMap = tutorMgrService.checkMemberDamoByResno(searchTxt);
		}else{
			// 아이디 중복 체크
			rowMap = tutorMgrService.checkMemberDamoByUserId(searchTxt);
		}
		
		if(rowMap == null) rowMap = new DataMap();
		
		if(rowMap.size() > 0 ){
			if(Util.parseInt(rowMap.get("countNum")) == 0){
				retValue = "ok";
			}else{
				retValue = "dup";
			}
		}else{
			retValue = "error";
		}				
		
		model.addAttribute("RESULT_VALUE", retValue);				
	}
	
	@RequestMapping(value="/tutorMgr/tutor.do", params="mode=checkResId")
	public String checkResId(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			) throws Exception{
		
		// 주민번호 중복, 유저ID 중복 체크
		checkResnoAndUserId(model, cm.getDataMap());
		
		return "/tutorMgr/tutorMgr/checkResNoAndUserIdByAjax";
	}
	
	/**
	 * 과목 검색 리스트
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @param requestMap
	 * @throws Exception
	 */
	public void selectSubjCode(
			Model model
			, DataMap requestMap) throws Exception {
		
		DataMap listMap = null;
		
		// 과목 리스트
		listMap = tutorMgrService.selectSubjCode(requestMap.getString("searchTxt"));
		
		model.addAttribute("LIST_DATA", listMap);				
	}
	
	@RequestMapping(value="/tutorMgr/tutor.do", params="mode=searchSubjPop")
	public String searchSubjPop(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			) throws Exception{
		
		// 과목 검색 팝업
		
		if( !cm.getDataMap().getString("searchTxt").equals("") ){
			selectSubjCode(model, cm.getDataMap());
		}
		
		return "/tutorMgr/tutorMgr/searchSubjPop";
	}
	
	/**
	 * 강사 신규 추가 등록
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @param requestMap
	 * @throws Exception
	 */
	public void insertTutorForm(
			Model model,
			CommonMap cm
			) throws Exception {
		
		DataMap requestMap = cm.getDataMap();
		
		String msg = "";
		String resultType = "";
		int result = 0;
		
		
		DataMap tmpMap = null;
		boolean pkFlag = false;
		
		
		String type = requestMap.getString("type");
		
		String resno = requestMap.getString("resno");
		String userId = requestMap.getString("userId");
		
		String homeTel = requestMap.getString("homeTel1") + "-" + requestMap.getString("homeTel2") + "-" + requestMap.getString("homeTel3");
		String hp = requestMap.getString("hp1") + "-" + requestMap.getString("hp2") + "-" + requestMap.getString("hp3");
		String officeTel = requestMap.getString("officeTel1") + "-" + requestMap.getString("officeTel2") + "-" + requestMap.getString("officeTel3");
		String fax = requestMap.getString("fax1") + "-" + requestMap.getString("fax2") + "-" + requestMap.getString("fax3");
		
		String authority = "5";
		String sex = "";
		String birth = "";
		String pwd = "";
		
		requestMap.setString("luserno", cm.getLoginInfo().getSessNo());
		
		
		if(type.equals("1")){
		
			if(!requestMap.getString("chk_foreigner").equals("Y")){
			
				// 주민번호 중복체크
				tmpMap = tutorMgrService.checkMemberDamoByResno( resno );
				if(tmpMap == null) tmpMap = new DataMap();
				
				if(tmpMap.size() > 0 ){
					if(Util.parseInt(tmpMap.get("countNum")) == 0){
						pkFlag = true;
					}else{
						pkFlag = false;
						resultType = "pkDup";
						msg = "주민번호가 중복되었습니다.";
					}
				}else{
					pkFlag = false;
					resultType = "saveError";
					msg = "주민번호 체크시 오류가 발생했습니다.";
				}
				
			}else{
				pkFlag = true;
			}
			
			if(pkFlag == true){
				
				
				// 아이디 중복체크
				if(!userId.equals("")){  //아이디가 비어있을수도 있음 --2008.11.13 이용문
					tmpMap = tutorMgrService.checkMemberDamoByUserId( userId );
					if(tmpMap == null) tmpMap = new DataMap();
					
					if(tmpMap.size() > 0 ){
						if(Util.parseInt(tmpMap.get("countNum")) == 0){
							pkFlag = true;
						}else{
							pkFlag = false;
							resultType = "pkDup";
							msg = "아이디가 중복되었습니다.";
						}
					}else{
						pkFlag = false;
						resultType = "saveError";
						msg = "아이디 체크시 오류가 발생했습니다.";
					}
				}

			}
		}else{
			pkFlag = true;
		}
		
		
		
		if(!resno.equals("")){
			
			try{
				
				// 남여구분
				int tmpSex =  Integer.parseInt( resno.substring(6,7) ) % 2  ;
				if(tmpSex == 1){
					sex = "M";
				}else{
					sex = "F";
				}
				
				// 생년월일
				if( resno.substring(6,7).equals("1") || resno.substring(6,7).equals("2") ){
					birth = "19" + resno.substring(0,6);
				}else{
					birth = "20" + resno.substring(0,6);
				}
				
				pwd = resno.substring(6);

			}catch(Exception e){}

		}
		
		LoginInfo loginInfo = cm.getLoginInfo();
		
		if(pkFlag == true){
		
			// 저장
			String mode = requestMap.getString("mode");
			
			int fileGroupNo = -1;
			if( mode.equals("saveTutorForm")){
				
				//등록 및 수정시만 파일 업로드 처리.
				//파일 등록.
				DataMap fileMap = (DataMap)requestMap.get("UPLOAD_FILE");
				if(fileMap == null) fileMap = new DataMap();
				fileMap.setNullToInitialize(true);

				if(fileMap.keySize("fileSysName") > 0 || fileMap.keySize("existFile") > 0 || fileMap.keySize("deleteFile") > 0 || fileMap.keySize("fileUploadOk") > 0)
					fileGroupNo = commonService.insertInnoUploadFile(fileMap, requestMap.getString("INNO_SAVE_DIR"), loginInfo.getSessNo());
			}
			
			requestMap.setInt("fileGroupNo", fileGroupNo);
			requestMap.setString("homeTel", homeTel);
			requestMap.setString("hp", hp);
			requestMap.setString("officeTel", officeTel);
			requestMap.setString("fax", fax);
			
			result = tutorMgrService.saveTutorForm(requestMap);

			if(result > 0){
		
				if(!type.equals("3") ){
				
					msg = "저장 되었습니다.";						
					resultType = "tutorRegOk";
				}else{
					msg = "수정 되었습니다.";						
					resultType = "tutorUpdateOk";
				}
				//파일넘버값을 셋시킨다
				requestMap.setInt("fileGroupNo",fileGroupNo);
				
				requestMap.setString("wuserno",loginInfo.getSessNo());
				requestMap.setString("username",loginInfo.getSessName());
				requestMap.setInt("groupfileNo",fileGroupNo);
			}else{			
				msg = "저장시 오류가 발생했습니다.";
				resultType = "saveError";			
			}
		}
		
		model.addAttribute("SESSCLASS", cm.getLoginInfo().getSessClass());
		model.addAttribute("RESULT_MSG", msg);
		model.addAttribute("RESULT_TYPE", resultType);		
	}
	
	@RequestMapping(value="/tutorMgr/tutor.do", params="mode=saveTutorForm")
	public String saveTutorForm(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			) throws Exception{
		
		insertTutorForm(model, cm);
		
		return "/tutorMgr/tutorMgr/tutorExec";
	}
	
	@RequestMapping(value="/tutorMgr/tutor.do", params="mode=imgUploadForm")
	public String imgUploadForm(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			) throws Exception{
		
		return "/tutorMgr/tutorMgr/imgUploadForm";
	}
	
	/**
	 * 강사 사진 업로드
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @param requestMap
	 * @throws Exception
	 */
	public void uploadImg(
			Model model
			, DataMap requestMap) throws Exception {
				
		String msg = "";
		String resultType = "";
		int result = 0;
		
		DataMap fileMap = (DataMap)requestMap.get("UPLOAD_FILE");
		
		if(fileMap.keySize("memberImg_fileSize") > 0){
			if(fileMap.getLong("memberImg_fileSize") > 0 ){
				result = 1;
			}else{
				result = 0;
			}
		}else{
			result = 0;
		}
		
		
		if(result > 0){
			
			msg = "업로드가 완료되었습니다.";						
			resultType = "ok";			

		}else{			
			msg = "업로드시 오류가 발생했습니다.";
			resultType = "saveError";			
		}				
		
		model.addAttribute("RESULT_MSG", msg);
		model.addAttribute("RESULT_TYPE", resultType);		
	}
	
	@RequestMapping(value="/tutorMgr/tutor.do", params="mode=imgUpload")
	public String imgUpload(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			) throws Exception{
		
		uploadImg(model, cm.getDataMap());
		
		return "/tutorMgr/tutorMgr/imgUploadExec";
	}
	
	/**
	 * 강사원고관리 리스트
	 * 작성일 8월 4일
	 * 작성자 정 윤철
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @param requestMap
	 * @throws Exception
	 */
	public void selectTutorPaperList(
			Model model
			, DataMap requestMap) throws Exception {
		
		DataMap listMap = null;
		
		if (requestMap.getString("currPage").equals("")) {
			requestMap.setInt("currPage", 1);
		}
		if (requestMap.getString("rowSize").equals("")) {
			requestMap.setInt("rowSize", 10);
		}
		if (requestMap.getString("pageSize").equals("")) {
			requestMap.setInt("pageSize", 10);
		}
		
		//강사원고관리 리스트
		listMap = tutorMgrService.selectTutorPaperList(requestMap);

		model.addAttribute("LIST_DATA", listMap);
	}
	
	@RequestMapping(value="/tutorMgr/tutorPaper.do", params="mode=tutorPaperList")
	public String tutorPaperList(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			) throws Exception{
		
		selectTutorPaperList(model, cm.getDataMap());
		
		return "/tutorMgr/tutorPaper/tutorPaperList";
	}
	
	/**
	 * 강사원고관리 검색 조건 중 날짜 특정요일 데이터 체크
	 * 작성일 8월 4일
	 * 작성자 정 윤철
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @param requestMap
	 * @throws Exception
	 */
	public void ajaxDateChechk(
			Model model
			, DataMap requestMap) throws Exception {
		//월요일
		String returnValue = "";
		//금요일
		String returnValue2 = "";
		//월수 합하기
		int sumDate = 0;
		//해당월의 월수를 가져오기
		int sAllDate = 0;
		int sEndDate = 0;
		
		sAllDate = DateUtil.getMonthDate(requestMap.getString("sDate").substring(0, 4), requestMap.getString("sDate").substring(4, 6));
		
		
		returnValue = DateUtil.getDayOfWeekNum(requestMap.getString("sDate"));
		returnValue2 = DateUtil.getDayOfWeekNum(requestMap.getString("eDate"));
		
		if(requestMap.getString("gubun").equals("form")){
			returnValue2 = "6";
		}
		
		if(!returnValue.equals("2")){
			//시작일자가 월요일이 아닐경우
			requestMap.setString("date", "1");
			
		}else if(returnValue.equals("2") && !returnValue2.equals("6")){
			//마지막일자가 금요일이 아닐경
			requestMap.setString("date", "2");
			
		}else{
			
			
			if(requestMap.getString("sDate").substring(0,6).equals(requestMap.getString("eDate").substring(0, 6))){
				sumDate = requestMap.getInt("eDate") - requestMap.getInt("sDate")+1;
				
			}else{
				//일수구하기
				sEndDate = sAllDate - Integer.parseInt(requestMap.getString("sDate").substring(6, 8)) + 1;
				sumDate = sEndDate  + Integer.parseInt(requestMap.getString("eDate").substring(6, 8));
				
			}

			if(sumDate  != 5){
				//일주일단위가 넘어갔을경우 
				requestMap.setString("date", "4");
			}else{
				//월요일과 금요일 모두 맞을경우
				requestMap.setString("date", "0");
			}
		}
		
		//폼일경우 데이터 구해오는것이 틀리므로 따로 만든다.
		if(requestMap.getString("gubun").equals("form")){
			requestMap.setString("date", returnValue);
			
		}
	}
	
	@RequestMapping(value="/tutorMgr/tutorPaper.do", params="mode=ajaxDateChechk")
	public String ajaxDateChechk(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			) throws Exception{
		
		ajaxDateChechk(model, cm.getDataMap());
		
		return "/tutorMgr/tutorPaper/tutorPaperAjax";
	}
	
	/**
	 * 강사원고관리 등록 폼
	 * 작성일 8월 4일
	 * 작성자 정 윤철
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @param requestMap
	 * @throws Exception
	 */
	
	public void tutorPaperForm(
			Model model
			, DataMap requestMap) throws Exception {

		DataMap grocdeListMap = null;
		DataMap grseqListMap = null;
		DataMap subjListMap = null;
		DataMap tutorNameListMap = null;
		
		//기본적폼데이터 과정명
		grocdeListMap = tutorMgrService.seleteTutorPaperGrcodeList();
		
		if(requestMap.getString("qu").equals("grcode")){
			//과정기수
			grseqListMap = tutorMgrService.seleteTutorPaperGrseqList(requestMap);
			
		}else if(requestMap.getString("qu").equals("grseq")){
			//과목코드
			subjListMap = tutorMgrService.seleteTutorPaperSubjList(requestMap);
		}else if(requestMap.getString("qu").equals("subj")){
			//지정 강사
			tutorNameListMap = tutorMgrService.seleteTutorPaperTutorNameList(requestMap);
		}
		
		if(grseqListMap == null){
			grseqListMap = new DataMap();
			
		}
		
		if(subjListMap == null){
			subjListMap = new DataMap();
			
		}
		
		if(tutorNameListMap == null){
			tutorNameListMap = new DataMap();
			
		}

		model.addAttribute("GRCODETLIST_DATA", grocdeListMap);
		model.addAttribute("GRSEQTLIST_DATA", grseqListMap);
		model.addAttribute("SUBJTLIST_DATA", subjListMap);
		model.addAttribute("TUTORNAMETLIST_DATA", tutorNameListMap);
	}
	
	@RequestMapping(value="/tutorMgr/tutorPaper.do", params="mode=tutorPaperForm")
	public String tutorPaperForm(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			) throws Exception{
		
		tutorPaperForm(model, cm.getDataMap());
		
		return "/tutorMgr/tutorPaper/tutorPaperForm";
	}
	
	@RequestMapping(value="/tutorMgr/tutorPaper.do", params="mode=ajaxPaperList")
	public String ajaxPaperList(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			) throws Exception{
		
		tutorPaperForm(model, cm.getDataMap());
		
		return "/tutorMgr/tutorPaper/tutorPaperFormAjax";
	}
	
	/**
	 * 강사원고관리 등록, 삭제
	 * 작성일 8월 4일
	 * 작성자 정 윤철
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @param requestMap
	 * @throws Exception
	 */
	public void exec(
			DataMap requestMap) throws Exception {
		
		int returnValue = 0;
		
		if(requestMap.getString("qu").equals("insert")){
			//강사원고관리 등록
			returnValue = tutorMgrService.insertTutorPaper(requestMap);
			
			if(returnValue == 0){
				requestMap.setString("msg", "중복되는 원고 등록 데이터가 있습니다. 과목별로 한주에 한번씩만 등록하실 수 있습니다.");
				
			}else{
				requestMap.setString("msg", "저장하였습니다.");
				
			}
		}else{
			//강사원고관리 삭제
			returnValue = tutorMgrService.deleteTutorPaper(requestMap);
			
			if(returnValue == 0){
				requestMap.setString("msg", "실패하였습니다.");
				
			}else{
				requestMap.setString("msg", "삭제하였습니다.");
				
			}
		}

	}
	
	@RequestMapping(value="/tutorMgr/tutorPaper.do", params="mode=exec")
	public String exec(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			) throws Exception{
		
		exec(cm.getDataMap());
		
		return "/tutorMgr/tutorPaper/tutorPaperExec";
	}
	
	
	
}
