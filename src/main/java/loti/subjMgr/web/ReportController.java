package loti.subjMgr.web;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import loti.common.service.CommonService;
import loti.subjMgr.service.ReportService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import ut.lib.login.LoginCheck;
import ut.lib.login.LoginInfo;
import ut.lib.support.CommonMap;
import ut.lib.support.DataMap;
import ut.lib.util.Constants;
import ut.lib.util.Util;
import common.controller.BaseController;

@Controller("subMgrReportController")
public class ReportController extends BaseController{

	@Autowired
	private ReportService reportService;
	
	@Autowired
	private CommonService commonService;
	
	@ModelAttribute("cm")
	public CommonMap common(
				CommonMap cm
				, HttpServletResponse response
				, HttpServletRequest request
				, Model model
			) throws Exception{
		
		 //요청처리 - get, post 방식의 파라미터를 DataMap 에 저장
		DataMap requestMap = cm.getDataMap();
		
		//초기화 옵션(true 일경우 데이터를 뽑을때 null 일경우 초기화 - 빈문자열, 0....)
		requestMap.setNullToInitialize(true);
		
		//관리자 로그인 체크. (관리자 페이지에는 모두 있어야 함)
		LoginInfo memberInfo = LoginCheck.adminCheck(request, response, requestMap.getString("menuId"));
		
		if (memberInfo == null) return null;
		
		// default mode
		String mode = Util.getValue(requestMap.getString("mode"));
		System.out.println("mode === " + mode);
		
		if(mode.equals("")){
			mode = "reportAppList";
		}
		
		// 리퀘스트 정보를 담고있는 DataMap을 Attribute 에 추가
		model.addAttribute("REQUEST_DATA", requestMap);
		
		return cm;
	}
	
	public String findView(String mode, String defaultView){
		return defaultView;
	}
	
	@RequestMapping(value="/subjMgr/report.do")
	public String defaultProcess(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			, HttpSession session
			) throws Exception{
		return reportList(cm, model, session);
	}
	
	/**
	 * 과제물출제 관리 -> 과제물평가관리 리스트
	 * 작성자 : 정윤철
	 * 작성일 : 7월 29일
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @param requestMap
	 * @throws Exception
	 */

	public void selectGradeAppList(	     
			Model model,
			DataMap requestMap) 
			throws Exception {
		
		DataMap listMap = null;
		if(requestMap.getString("classno").equals("")){
			listMap = new DataMap();
		}else{
			 listMap = reportService.selectGradeAppList(requestMap);
		}

		model.addAttribute("LIST_DATA", listMap);

	}	
	
	@RequestMapping(value="/subjMgr/report.do", params="mode=reportGradeAppList")
	public String reportGradeAppList(
				@ModelAttribute("cm") CommonMap cm
				, Model model
			) throws Exception{
		
		DataMap requestMap = cm.getDataMap();
		
		// 과제물평가관리 리스트
		selectGradeAppList(model, requestMap);
		
		return findView(requestMap.getString("mode"), "/subjMgr/report/reportAppGradeList");
	}
	
	/**
	 * 과목과제물평가관리
	 * 작성자 : 정윤철
	 * 작성일 : 7월 29일
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @param requestMap
	 * @throws Exception
	 */
	public void selectReportGradeAppAjaxList(	   
			Model model,
			DataMap requestMap,
			LoginInfo loginInfo,
			HttpSession session
			) 
			throws Exception {

		DataMap listMap = null;
		String cnt = "";
		
		/**
		 * 구분
		 * grcode = 과정, grseq = 기수, subj = 과목
		 */
		// 년도
		String pYear = Util.getValue(requestMap.getString("year"));
		
		// 과정 코드
		String pGrCode = Util.getValue(requestMap.getString("grcode"));
		
		// 반명
		String pSubj = Util.getValue(requestMap.getString("subj"));
		
		session.setAttribute("sess_year", Util.getValue(requestMap.getString("year"), ""));
		session.setAttribute("sess_grcode", Util.getValue(requestMap.getString("grcode"), ""));
		session.setAttribute("sess_grseq", Util.getValue(requestMap.getString("grseq"), ""));
		//session.setAttribute("sess_subj", Util.getValue(requestMap.getString("subj"), ""));
		
		if(requestMap.getString("qu").equals("grcode")){
			// 과정코드 가져오기
			listMap = commonService.selectGrCode(pYear, 
							Util.getValue(loginInfo.getSessGubun()),
							Util.getValue(loginInfo.getSessNo()),
							Util.getValue(loginInfo.getSessCurrentAuth()) );
			
		}else if(requestMap.getString("qu").equals("grseq")){
			//기수 가져오기
			listMap = commonService.selectGrSeq(pYear, 
							pGrCode, 
							Util.getValue(loginInfo.getSessNo()),
							Util.getValue(loginInfo.getSessCurrentAuth()) );
			
		}else if(requestMap.getString("qu").equals("classno")){
			//반정보 가져오기
			listMap = reportService.selectReportClassNoRow(requestMap);
			
		}else if(requestMap.getString("qu").equals("end")){
			 //리스트
			 listMap = reportService.selectGradeAppList(requestMap);
			 
		}
		
		//카운트
		cnt = reportService.selectReportAppGradeCntRow(requestMap);
		
		requestMap.setString("cnt",cnt);
		model.addAttribute("LIST_DATA", listMap);
	}
	
	@RequestMapping(value="/subjMgr/report.do", params="mode=reportGradeAppListAjax")
	public String reportGradeAppListAjax(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			, HttpSession session
			) throws Exception{
		
		DataMap requestMap = cm.getDataMap();
		
		// 과제물평가관리 리스트
		selectReportGradeAppAjaxList(model, requestMap, cm.getLoginInfo(), session);
		
		return findView(requestMap.getString("mode"), "/subjMgr/report/reportGradeAppListAjax");
	}
	
	public void selectReportList(	       
			Model model,
			DataMap requestMap) 
			throws Exception {
		DataMap listMap = null;
		
		if(requestMap.getString("classno").equals("")){
			listMap = new DataMap();
		}else{
			listMap = reportService.selectReportList(requestMap);
		}
		
		model.addAttribute("LIST_DATA", listMap);
		
	}
	
	@RequestMapping(value="/subjMgr/report.do", params="mode=reportList")
	public String reportList(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			, HttpSession session
			) throws Exception{
		
		DataMap requestMap = cm.getDataMap();
		
		//과제물 출제 리스트
		selectReportList(model, requestMap);
		
		return findView(requestMap.getString("mode"), "/subjMgr/report/reportList");
	}
	
	/**
	 * 셀렉트박스 ajax총관리 
	 * 작성자 : 정윤철
	 * 작성일 : 7월 22일
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @param requestMap
	 * @throws Exception
	 */
	public void selectReportAjaxList(
			Model model,
			DataMap requestMap,
			LoginInfo memberInfo,
			HttpSession session
			) 
			throws Exception {

		DataMap listMap = null;
		
		/**
		 * 구분
		 * grcode = 과정, grseq = 기수, subj = 과목
		 */
		// 년도
		String pYear = Util.getValue(requestMap.getString("year"));
		
		// 과정 코드
		String pGrCode = Util.getValue(requestMap.getString("grcode"));
		
		// 기수
		String pGrSeq = Util.getValue(requestMap.getString("grseq"));
		
		// 반명
		String pSubj = Util.getValue(requestMap.getString("subj"));
		
		session.setAttribute("sess_year", Util.getValue(requestMap.getString("year"), ""));
		session.setAttribute("sess_grcode", Util.getValue(requestMap.getString("grcode"), ""));
		session.setAttribute("sess_grseq", Util.getValue(requestMap.getString("grseq"), ""));
		session.setAttribute("sess_subj", Util.getValue(requestMap.getString("subj"), ""));
		
		if(requestMap.getString("qu").equals("grcode")){
			// 과정코드 가져오기
			listMap = commonService.selectGrCode(pYear, 
							Util.getValue(memberInfo.getSessGubun()),
							Util.getValue(memberInfo.getSessNo()),
							Util.getValue(memberInfo.getSessCurrentAuth()) );
			
		}else if(requestMap.getString("qu").equals("grseq")){
			//기수 가져오기
			listMap = commonService.selectGrSeq(pYear, 
							pGrCode, 
							Util.getValue(memberInfo.getSessNo()),
							Util.getValue(memberInfo.getSessCurrentAuth()) );
			
		}else if(requestMap.getString("qu").equals("subj")){
			// 과목 가져오기
			listMap = commonService.selectSubj(pGrCode, pGrSeq);
			
		}else if(requestMap.getString("qu").equals("classno")){
			//반정보 가져오기
			listMap = reportService.selectReportClassNoList(requestMap);
			
		}else if(requestMap.getString("qu").equals("end")){
			//반정보 가져오기
			 listMap = reportService.selectReportList(requestMap);
			
		}
		
		
		
		model.addAttribute("LIST_DATA", listMap);
	}
	
	@RequestMapping(value="/subjMgr/report.do", params="mode=selectReportAjaxList")
	public String selectReportAjaxList(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			, HttpSession session
			) throws Exception{
		
		DataMap requestMap = cm.getDataMap();
		
		//검색 ajax
		selectReportAjaxList(model, requestMap, cm.getLoginInfo(), session);
		
		return findView(requestMap.getString("mode"), "/subjMgr/report/selectReportAjaxList");
	}
	
	/**
	 * 과제물출제 관리 -> 과제물 출제 폼데이터
	 * 작성자 : 정윤철
	 * 작성일 : 7월 22일
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @param requestMap
	 * @throws Exception
	 */
	public void form(	       
			Model model,
			DataMap requestMap) 
			throws Exception {

		DataMap listMap = null;
		DataMap tutorRowMap = null;
		DataMap datesMap = null;
		
		tutorRowMap = reportService.selectReportClassTutorRow(requestMap);
		datesMap = reportService.selectReportDatesRow(requestMap);
		
		if(requestMap.getString("qu").equals("modify")){
			//수정 모드 폼일경우 데이터를 가져온다.
			listMap = reportService.selectReportRow(requestMap);
			//파일 정보 가져오기.
			commonService.selectUploadFileList(listMap);
			
		}else if(requestMap.getString("qu").equals("insert")){
			//등록모드일경우 초기화...
			listMap = new DataMap();
		}
		

		
		model.addAttribute("LIST_DATA", listMap);
		model.addAttribute("TUTORROW_DATA", tutorRowMap);
		model.addAttribute("DATES_DATA", datesMap);
	}
	
	@RequestMapping(value="/subjMgr/report.do", params="mode=form")
	public String form(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			, HttpSession session
			) throws Exception{
		
		DataMap requestMap = cm.getDataMap();
		
		//등록 수정폼
		form(model, requestMap);
		
		return findView(requestMap.getString("mode"), "/subjMgr/report/reportForm");
	}
	
	/**
	 * 과제물출제 관리 -> 과제물 출제 수정
	 * 작성자 : 정윤철
	 * 작성일 : 7월 22일
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @param requestMap
	 * @throws Exception
	 */

	public void exec(	          
			DataMap requestMap,
			LoginInfo loginInfo
			) 
			throws Exception {

		
		if(requestMap.getString("qu").equals("insert") || requestMap.getString("qu").equals("modify")){
			/***********************************************************파일관련[s]*****************************************************************/
			int fileGroupNo = -1;	
			//파일 등록.
			DataMap fileMap = (DataMap)requestMap.get("UPLOAD_FILE");
			if(fileMap == null) fileMap = new DataMap();
			fileMap.setNullToInitialize(true);
			
			if(fileMap.keySize("fileSysName") > 0 || fileMap.keySize("existFile") > 0 || fileMap.keySize("deleteFile") > 0 || fileMap.keySize("fileUploadOk") > 0)
				fileGroupNo = commonService.insertInnoUploadFile(fileMap, requestMap.getString("INNO_SAVE_DIR"), loginInfo.getSessNo());
			Util.saveDaumContent(requestMap, "content", "namoContent", Constants.NAMOUPLOAD_REPORT); //나모로 넘어온값 처리.
			/***********************************************************파일관련[e]*****************************************************************/
			
			
			
			//파일넘버와 유저넘버를 리퀘스트멥에 셋
			requestMap.setInt("fileGroupNo",fileGroupNo);
			requestMap.setString("wuserno",loginInfo.getSessNo());
			
		}

		//리턴값 체크
		int returnValue = 0;
		if(requestMap.getString("qu").equals("modify")){
			//수정 시작 
			returnValue =  reportService.updateReport(requestMap);
			
			if(returnValue == 0){
				requestMap.setString("msg", "저장에 실패하였습니다.");
				
			}else{
				requestMap.setString("msg", "저장하였습니다.");
				
			}
		}else if(requestMap.getString("qu").equals("insert")){
			//등록 시작
			returnValue =  reportService.insertReport(requestMap);
			
			if(returnValue == 0){
				requestMap.setString("msg", "저장에 실패하였습니다.");
				
			}else{
				requestMap.setString("msg", "저장하였습니다.");
				
			}
		}else if(requestMap.getString("qu").equals("delete")){
			//삭제 시작
			returnValue =  reportService.deleteReport(requestMap);
			
			if(returnValue == 0){
				requestMap.setString("msg", "삭제를 실패하였습니다.");
				
			}else{
				requestMap.setString("msg", "삭제하였습니다.");
				
			}
		}
	}
	
	@RequestMapping(value="/subjMgr/report.do", params="mode=exec")
	public String exec(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			, HttpSession session
			) throws Exception{
		
		DataMap requestMap = cm.getDataMap();
		
		//등록 수정 실행
		exec(requestMap, cm.getLoginInfo());
		
		return findView(requestMap.getString("mode"), "/subjMgr/report/reportExec");
	}
	
	/**
	 * 과제물출제 관리 -> 과제물 출제 평가등급 설정 리스트
	 * 작성자 : 정윤철
	 * 작성일 : 7월 23일
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @param requestMap
	 * @throws Exception
	 */

	public void selectReportGradeList(	      
			Model model,
			DataMap requestMap) 
			throws Exception {

		DataMap listMap = null;
		DataMap maxPoint = null;
		DataMap point = null;
		DataMap grade = null;
		
		listMap = reportService.selectReportGradeList(requestMap);
		maxPoint = reportService.selectReportGradeMaxPointRow(requestMap);
		point = reportService.selectReportGradePointRow(requestMap);
		
	    if(grade == null) grade = new DataMap();
	    grade.setNullToInitialize(true);	
	    
		model.addAttribute("GRADELIST_DATA", listMap);
		model.addAttribute("MAXPOINT_DATA", maxPoint);
		model.addAttribute("POINT_DATA", point);
	}
	
	@RequestMapping(value="/subjMgr/report.do", params="mode=gradeList")
	public String gradeList(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			, HttpSession session
			) throws Exception{
		
		DataMap requestMap = cm.getDataMap();
		
		//평가등급별 리스트
		selectReportGradeList(model, requestMap);
		
		return findView(requestMap.getString("mode"), "/subjMgr/report/reportAppGradePop");
	}
	
	/**
	 * 과제물출제 관리 -> 과제물 출제 평가등급 등록 수정
	 * 작성자 : 정윤철
	 * 작성일 : 7월 23일
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @param requestMap
	 * @throws Exception
	 */

	public void reportGradeExec(	          
			DataMap requestMap) 
			throws Exception {

		int returnValue = 0;
		
		//등록 수정시작
		returnValue = reportService.insertReportGrade(requestMap);
		
		if(returnValue == 1){
			requestMap.setString("msg", "저장하였습니다.");
		}
	}
	
	@RequestMapping(value="/subjMgr/report.do", params="mode=reportGradeExec")
	public String reportGradeExec(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			, HttpSession session
			) throws Exception{
		
		DataMap requestMap = cm.getDataMap();
		
		//평가등급별 리스트
		reportGradeExec(requestMap);
		
		return findView(requestMap.getString("mode"), "/subjMgr/report/reportExec");
	}
	
	/**
	 * 과제물출제 관리 -> 과제물 출제 평가등급 등록 수정
	 * 작성자 : 정윤철
	 * 작성일 : 7월 23일
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @param requestMap
	 * @throws Exception
	 */

	public void reportAppList(	     
			Model model,
			DataMap requestMap) 
			throws Exception {

		DataMap listMap = null;
		DataMap rowMap = null;
		DataMap evlCntMap = null;
		DataMap classNameMap = null;
		DataMap grcodeMap = null;
		DataMap pointRowMap = null;
		
		//평가리스트
		listMap = reportService.reportAppList(requestMap);
		//등급리스트
		rowMap = reportService.selectReportGradeList(requestMap);
		//제출자수
		evlCntMap = reportService.selectGradeEvalCnt(requestMap);
		//반명, 반 번호
		classNameMap = reportService.reportAppClassNameRow(requestMap);
		//과제물 제출기간, 과정명
		grcodeMap = reportService.selectGradeGrcode(requestMap);
		//과제물 평가등급 점수 selectReportGradePointRow
		pointRowMap = reportService.selectReportGradePointRow(requestMap);
		
		
		
		model.addAttribute("GRADELIST_DATA", rowMap);
		model.addAttribute("LIST_DATA", listMap);
		model.addAttribute("EVLCNTROW_DATA", evlCntMap);
		model.addAttribute("CLASSNAMEROW_DATA", classNameMap);
		model.addAttribute("GRCODEROW_DATA", grcodeMap);
		model.addAttribute("POINTROW_DATA", pointRowMap);

	}
	
	@RequestMapping(value="/subjMgr/report.do", params="mode=reportAppList")
	public String reportAppList(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			, HttpSession session
			) throws Exception{
		
		DataMap requestMap = cm.getDataMap();
		
		//과제물제출 평가리스트
		reportAppList(model, requestMap);
		
		return findView(requestMap.getString("mode"), "/subjMgr/report/reportAppList");
	}
	
	@RequestMapping(value="/subjMgr/report.do", params="mode=reportAppExcel")
	public String reportAppExcel(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			, HttpSession session
			) throws Exception{
		
		DataMap requestMap = cm.getDataMap();
		
		//과제물제출 평가리스트
		reportAppList(model, requestMap);
		
		return findView(requestMap.getString("mode"), "/subjMgr/report/reportAppByExcel");
	}
	
	@RequestMapping(value="/subjMgr/report.do", params="mode=reportAppSmsExcel")
	public String reportAppSmsExcel(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			, HttpSession session
			) throws Exception{
		
		DataMap requestMap = cm.getDataMap();
		
		//과제물제출 평가리스트
		reportAppList(model, requestMap);
		
		return findView(requestMap.getString("mode"), "/subjMgr/report/reportAppByExcelSms");
	}
	
	@RequestMapping(value="/subjMgr/report.do", params="mode=reportAppExec")
	public String reportAppExec(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			, HttpSession session
			) throws Exception{
		
		DataMap requestMap = cm.getDataMap();
		
		//과제물 평가 저장
		reportAppExec(cm, model, session);
		
		return findView(requestMap.getString("mode"), "/subjMgr/report/reportExec");
	}
	
	@RequestMapping(value="/subjMgr/report.do", params="mode=reportNoneList")
	public String reportNoneList(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			, HttpSession session
			) throws Exception{
		
		DataMap requestMap = cm.getDataMap();
		
		return findView(requestMap.getString("mode"), "/subjMgr/report/reportAppListByNone");
	}
	
	/**
	 * 파일업로드 팝업창
	 * 작성자 : 최석호
	 * 작성일 : 2009-04-21
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @param requestMap
	 * @throws Exception
	**/ 
	
	public void reportFileUploadPop(
			Model model,
	         DataMap requestMap,
	         LoginInfo loginInfo) throws Exception {
		
		String groupfileNo = Util.getValue( requestMap.getString("groupfileNo"), "0");
		DataMap listMap = commonService.selectUploadFileList( Integer.parseInt(groupfileNo) );
		listMap.setNullToInitialize(true);
		
		//파일 제출하는 교육생
		if(listMap.getString("luserno").equals("") || listMap.getString("luserno") == null)
			listMap.setString("luserno", requestMap.getString("luserno"));
		
		model.addAttribute("LIST_DATA", listMap);
	}
	
	@RequestMapping(value="/subjMgr/report.do", params="mode=reportFileUploadPop")
	public String reportFileUploadPop(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			, HttpSession session
			) throws Exception{
		
		DataMap requestMap = cm.getDataMap();
		
		reportFileUploadPop(model, requestMap, cm.getLoginInfo());
		
		return findView(requestMap.getString("mode"), "/subjMgr/report/reportFileUploadPop");
	}
	
	@RequestMapping(value="/subjMgr/report.do", params="mode=reportFileUploadExec")
	public String reportFileUploadExec(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			, HttpSession session
			) throws Exception{
		
		DataMap requestMap = cm.getDataMap();
		
		if (requestMap.getString("grcode").length() > 0){
			session.setAttribute("sess_grcode", 	Util.getValue(requestMap.getString("grcode"), ""));
			session.setAttribute("sess_grseq", 		Util.getValue(requestMap.getString("grseq"), ""));
			session.setAttribute("sess_subj", 		Util.getValue(requestMap.getString("subj"), ""));
		} else {
			requestMap.setString("grcode",(String)session.getAttribute("sess_grcode"));
			requestMap.setString("grseq",(String)session.getAttribute("sess_grseq"));
		}
		
		reportFileUploadExec(cm, model, session);
		
		return findView(requestMap.getString("mode"), "/commonInc/popup/commonFileUploadExec");
	}
}
