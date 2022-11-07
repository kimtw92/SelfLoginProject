package loti.courseMgr.web;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import jxl.Cell;
import jxl.Sheet;
import jxl.Workbook;
import loti.baseCodeMgr.service.GrCodeService;
import loti.baseCodeMgr.service.QuestionMgrService;
import loti.baseCodeMgr.service.SubjService;
import loti.common.service.CommonService;
import loti.courseMgr.service.CourseSeqService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.transaction.interceptor.TransactionAspectSupport;
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
import ut.lib.util.DateUtil;
import ut.lib.util.SpringUtils;
import common.controller.BaseController;

@Controller
public class CourseSeqController extends BaseController {

	@Autowired
	private CourseSeqService courseSeqService;
	@Autowired
	private CommonService commonService;
	@Autowired
	private GrCodeService grCodeService;
	@Autowired
	private SubjService subjService;
	@Autowired
	private QuestionMgrService questionMgrService;
	
	@ModelAttribute("cm")
	public CommonMap common(CommonMap cm
			              , Model model
			              , HttpServletRequest request
			              , HttpServletResponse response
			              , @RequestParam(value="mode", required=false, defaultValue="") String mode) throws BizException {
		
		try {
			DataMap requestMap = cm.getDataMap();
			requestMap.setNullToInitialize(true);
			
			if (mode.equals("")) {
				mode = "list";
				requestMap.setString("mode", mode);
			}
			
			//관리자 로그인 체크 (관리자 페이지에는 모두 있어야 함.)
			LoginInfo memberInfo = LoginCheck.adminCheck(request, response, requestMap.getString("menuId"));
			if (memberInfo == null) {
				return null;
			}
			
			//공통 Comm Select Box 값 초기 셋팅.
			HttpSession session = request.getSession(); //세션
			if (requestMap.getString("year").equals("")) {
				requestMap.setString("year", (String)session.getAttribute("sess_year"));
			}
			if (requestMap.getString("grcode").equals("")) {
				requestMap.setString("grcode", (String)session.getAttribute("sess_grcode"));
			}
			
			model.addAttribute("REQUEST_DATA", requestMap);
			model.addAttribute("LOGIN_INFO", memberInfo);
		} catch (Exception e) {
			throw new BizException(e);
		} finally {
			
		}
		
		return cm;
	}
	
	@RequestMapping(value="/courseMgr/courseSeq.do")
	public String defaultProcess(@ModelAttribute("cm")CommonMap cm, Model model) throws BizException {
		return list(cm, model);
	}
	/**
	 * 과정 기수 리스트
	 */
	@RequestMapping(value="/courseMgr/courseSeq.do", params = "mode=list")
	public String list(@ModelAttribute("cm")CommonMap cm, Model model) throws BizException {
		DataMap requestMap = cm.getDataMap();
		requestMap.setNullToInitialize(true);
		
		//사용자 정보 추출.
		LoginInfo loginInfo = (LoginInfo)cm.getRequest().getAttribute("LOGIN_INFO");
		
		Map<String, Object> paramMap = new HashMap<String, Object>();
    	paramMap.put("sessClass", loginInfo.getSessClass());
    	paramMap.put("sessClassVal", Constants.ADMIN_SESS_CLASS_COURSEMAN);
    	paramMap.put("sessUserNo", loginInfo.getSessNo());
    	paramMap.put("sessGubun", loginInfo.getSessGubun());
    	
		//년도 selectBox 리스트 
		DataMap yearListMap = courseSeqService.selectGrSeqDistictYearList(paramMap);
		
		//리스트
		DataMap listMap = courseSeqService.selectGrSeqList(requestMap.getString("year"), requestMap.getString("grcode"), loginInfo.getSessGubun());

		model.addAttribute("LIST_DATA", listMap);
		model.addAttribute("YEAR_LIST_DATA", yearListMap);
		
		return "/courseMgr/courseSeq/courseSeqList";
	}
	
	@RequestMapping(value = "/courseMgr/courseSeq.do", params="mode=evlinfoSubjForm")
	public String evlinfoSubjForm(@ModelAttribute("cm") CommonMap cm, Model model) throws BizException, SQLException {
		DataMap requestMap = cm.getDataMap();
		requestMap.setNullToInitialize(true);
		
		Map<String, Object> paramMap = null;
		DataMap evlinfoSubjList = new DataMap();
		DataMap examM = new DataMap();
		DataMap examUnit = new DataMap();
		DataMap examSubject = new DataMap();
		DataMap questionCount = new DataMap();
		DataMap examPaper = new DataMap();
		int examSetCount = 0;
		
		evlinfoSubjList = courseSeqService.findEvlinfoSubjByGrcodeAndGrseqAndSubj(requestMap);
		if (evlinfoSubjList.keySize("subj") > 0) {
			// 시험 정보
			examM = courseSeqService.findExamMByGrcodeAndGrseqAndSubj(evlinfoSubjList);
			if (examM.keySize("idExam") > 0) {
				// 교시 정보
				String idExam = requestMap.getString("idExam");
				if (idExam.equals("")) {
					idExam = examM.getString("idExam",0);
					requestMap.setString("idExam", idExam);
				}
				examUnit = courseSeqService.findExamUnitByIdExam(requestMap);
				
				if (examUnit.keySize("idExam") > 0) {
					paramMap = new HashMap<String, Object>();
					paramMap.put("idExam", idExam);
					paramMap.put("examUnit", examUnit.getString("examUnit"));
					paramMap.put("idSubject", examM.getString("idCourse"));
					examSubject = courseSeqService.selectExamSubject(paramMap);
					
					if (examSubject.keySize("idExam") > 0) {
						examPaper = courseSeqService.selectExamPaper(examSubject.getString("idExam"));
						if (examPaper.keySize("idExam") > 0) {
							examSetCount = courseSeqService.selectExamPaperSetCount(examSubject.getString("idExam"));
							examSubject.put("examSetCount", examSetCount);
						}
					}
				}
			}
			questionCount = courseSeqService.selectQCount(requestMap.getString("subj"));
		}
		
		model.addAttribute("evlinfoSubjList", evlinfoSubjList);
		model.addAttribute("examM", examM);
		model.addAttribute("examUnit", examUnit);
		model.addAttribute("examSubject", examSubject);
		model.addAttribute("questionCount", questionCount);
		model.addAttribute("examPaper", examPaper);
		
		return "/courseMgr/courseSeq/evlinfoSubjForm";
	}
	
	@RequestMapping(value = "/courseMgr/courseSeq.do", params="mode=evlinfoSubjOffForm")
	public String evlinfoSubjOffForm(@ModelAttribute("cm") CommonMap cm, Model model) throws BizException, SQLException {
		DataMap requestMap = cm.getDataMap();
		requestMap.setNullToInitialize(true);
		
		Map<String, Object> paramMap = null;
		DataMap evlinfoSubjList = new DataMap();
		DataMap evalSubjInfo = new DataMap();
		DataMap examM = new DataMap();
		DataMap examUnit = new DataMap();
		DataMap examSubject = new DataMap();
		
		paramMap = new HashMap<String, Object>();
		paramMap.put("grcode", requestMap.getString("grcode"));
		paramMap.put("grseq", requestMap.getString("grseq"));
		paramMap.put("subj", requestMap.getString("subj"));
		
		evlinfoSubjList = courseSeqService.selectSubjSeq(paramMap);
		if (evlinfoSubjList.keySize("subj") > 0) {
			evalSubjInfo = courseSeqService.selectEvalSubjectList(requestMap);
			// 시험 정보
			examM = courseSeqService.findExamMByGrcodeAndGrseqAndSubj(evlinfoSubjList);
			String idExam = requestMap.getString("idExam");
			if (idExam.equals("")) {
				idExam = examM.getString("idExam",0);
				requestMap.setString("idExam", idExam);
			}
			if (examM.keySize("idExam") > 0) {
				// 교시 정보
				examUnit = courseSeqService.findExamUnitByIdExam(requestMap);
				
				if (examUnit.keySize("idExam") > 0) {
					paramMap = new HashMap<String, Object>();
					paramMap.put("idExam", idExam);
					paramMap.put("examUnit", examUnit.getString("examUnit"));
					paramMap.put("idSubject", examM.getString("idCourse"));
					examSubject = courseSeqService.selectExamSubject(paramMap);
				}
			}
		}
		
		model.addAttribute("evlinfoSubjList", evlinfoSubjList);
		model.addAttribute("evalSubjInfo", evalSubjInfo);
		model.addAttribute("examM", examM);
		model.addAttribute("examUnit", examUnit);
		model.addAttribute("examSubject", examSubject);
		
		return "/courseMgr/courseSeq/evlinfoSubjOffForm";
	}
	
	/**
	 * 과정기수 등록 수정.
	 */
	@RequestMapping(value="/courseMgr/courseSeq.do", params = "mode=form")
	public String form(@ModelAttribute("cm")CommonMap cm, Model model) throws BizException {
		DataMap requestMap = cm.getDataMap();
		requestMap.setNullToInitialize(true);
		
		//과정 정보
		DataMap grcodeMap = grCodeService.selectGrCodeRow(requestMap.getString("grcode"));
		//과정 기수 정보
		DataMap rowMap = courseSeqService.selectGrSeqRow(requestMap.getString("grcode"), requestMap.getString("grseq"));
		//과정 기수에 속한 학생,부회장 정보
		DataMap grStuMasMap = courseSeqService.selectGrStuMasList(requestMap);

		model.addAttribute("ROW_DATA", rowMap);
		model.addAttribute("GRCODE_ROW_DATA", grcodeMap);
		model.addAttribute("STUMAS_LIST_DATA", grStuMasMap);
		
		return "/courseMgr/courseSeq/courseSeqForm";
	}
	
	/**
	 * 등록, 수정, 삭제  실행.
	 */
	@RequestMapping(value="/courseMgr/courseSeq.do", params = "mode=exec")
	public String exec(@ModelAttribute("cm")CommonMap cm, Model model) throws BizException {
		DataMap requestMap = cm.getDataMap();
		requestMap.setNullToInitialize(true);
		
		//사용자 정보 추출.
		LoginInfo loginInfo = (LoginInfo)cm.getRequest().getAttribute("LOGIN_INFO");
		
		Map<String, Object> paramMap = null;
		
		String msg = ""; //결과 메세지.
		
		if (requestMap.getString("qu").equals("insert")) { //등록
			int result = courseSeqService.insertGrSeq(requestMap, loginInfo.getSessNo());
			
			if (result > 0) {
				msg = "기수가 추가되었습니다.";
			} else {
				msg = "등록 실패.";
			}
		} else if (requestMap.getString("qu").equals("update")) { //수정
			DataMap paramMapD = new DataMap();
			
			paramMapD.setString("grcodeniknm", requestMap.getString("grcodeniknm"));
			paramMapD.setString("useYn", requestMap.getString("useYn"));
			paramMapD.setString("fCyber", requestMap.getString("fCyber"));
			paramMapD.setString("eapplyst", requestMap.getString("eapplyst"));
			paramMapD.setString("eapplysth", requestMap.getString("eapplysth"));
			paramMapD.setString("eapplyed", requestMap.getString("eapplyed"));
			if (requestMap.getString("eapplyedh").equals("24")) {
				requestMap.setString("eapplyedh", "235900");
			} else {
				requestMap.setString("eapplyedh", requestMap.getString("eapplyedh") + "0000");
			}
			paramMapD.setString("eapplyedh", requestMap.getString("eapplyedh"));
			paramMapD.setString("endsent", requestMap.getString("endsent"));
			paramMapD.setString("endaent", requestMap.getString("endaent"));
			paramMapD.setString("started", requestMap.getString("started"));
			paramMapD.setString("enddate", requestMap.getString("enddate"));
			paramMapD.setInt("tdate", requestMap.getInt("tdate"));
			paramMapD.setInt("rpgrad", requestMap.getInt("rpgrad"));
			paramMapD.setInt("tseat", requestMap.getInt("tseat"));
			paramMapD.setString("mexampropose", requestMap.getString("mexampropose"));
			paramMapD.setString("lexampropose", requestMap.getString("lexampropose"));
			paramMapD.setString("classroomNo", requestMap.getString("classroomNo"));
			paramMapD.setString("grPoint", requestMap.getString("grPoint"));
			paramMapD.setString("grseqmanUserno", requestMap.getString("grseqmanUserno"));
			paramMapD.setString("newSexampropose", requestMap.getString("newSexampropose"));
			paramMapD.setString("newEexampropose", requestMap.getString("newEexampropose"));
			paramMapD.setString("peoplesystemYn", requestMap.getString("peoplesystemYn"));
			paramMapD.setString("questionSdate", requestMap.getString("questionSdate"));
			paramMapD.setString("questionEdate", requestMap.getString("questionEdate"));
			paramMapD.setString("endsentUseYn", requestMap.getString("endsentUseYn"));
			paramMapD.setString("endaentUseYn", requestMap.getString("endaentUseYn"));
			paramMapD.setString("startexamYn", requestMap.getString("startexamYn"));
			paramMapD.setString("studentNodata", requestMap.getString("studentNodata"));
			StringBuffer sbApplyLimit = new StringBuffer(); //신청제한대상
			for(int k=0; k< requestMap.keySize("applyLimit"); k++){
				if(!sbApplyLimit.toString().equals("")) {
					sbApplyLimit.append(",");
				}
				sbApplyLimit.append(requestMap.getString("applyLimit", k));
			}
			paramMapD.setString("applyLimit", sbApplyLimit.toString());
			paramMapD.setString("grcode", requestMap.getString("grcode"));
			paramMapD.setString("grseq", requestMap.getString("grseq"));
			
			int result = courseSeqService.updateGrSeq(paramMapD);
			if(result > 0){
				msg = "수정 되었습니다.";
			}else{
				msg = "수정 실패.";
			}
		} else if (requestMap.getString("qu").equals("delete")) { //삭제
			int result = 0;
			
			paramMap = new HashMap<String, Object>();
			
			paramMap.put("grcode", requestMap.getString("grcode"));
	    	paramMap.put("grseq", requestMap.getString("grseq"));
	    	paramMap.put("userNo", loginInfo.getSessNo());
	    	
			result = courseSeqService.selectGrSeqSubjConnectChk(paramMap);
			
			if (result > 0 ) {
				msg = "연계된 과목기수정보가 있습니다. 과정기수에 연계된 과목기수 삭제후 과정코드 삭제가 가능합니다.";
			} else {
				courseSeqService.deleteGrSeq(requestMap.getString("grcode"), requestMap.getString("grseq"));
				msg = "삭제 되었습니다.";
			}
		} else if (requestMap.getString("qu").equals("subj_delete")) { //과목 삭제 및 전체 과목 삭제.
			int result = 0;
			//수료 인원
			
			if (courseSeqService.selectGrResultCnt(requestMap) > 0 || courseSeqService.selectSubjResultCnt(requestMap) > 0 ) {
				msg = "이미 수료자가 있습니다.삭제하실 수 없습니다.과정수료처리취소와 과목이수처리취소후 삭제하실 수 있습니다.";
			} else {
				result = courseSeqService.deleteSubj(requestMap);
				
				if (result > 0) {
					msg = "삭제 되었습니다.";
				} else {
					msg = "에러";
				}
			}
		} else if (requestMap.getString("qu").equals("file_form")) { //첨부파일정보 수정
			//파일 등록.
			int fileGroupNo = -1;
			
			DataMap fileMap = (DataMap)requestMap.get("UPLOAD_FILE");
			if (fileMap == null) {
				fileMap = new DataMap();
			}
			fileMap.setNullToInitialize(true);
			
			if (fileMap.keySize("fileSysName") > 0 || fileMap.keySize("existFile") > 0 || fileMap.keySize("deleteFile") > 0 || fileMap.keySize("fileUploadOk") > 0) {
				fileGroupNo = commonService.insertInnoUploadFile(fileMap, requestMap.getString("INNO_SAVE_DIR"), loginInfo.getSessNo());
			}
			
			paramMap = new HashMap<String, Object>();
			paramMap.put("grcode", requestMap.getString("grcode"));
			paramMap.put("grseq", requestMap.getString("grseq"));
			paramMap.put("groupfileNo", fileGroupNo);
			int result = courseSeqService.updateGrseqByGroupFileNo(paramMap);
			if(result > 0){
				msg = "수정 되었습니다.";
			}else{
				msg = "수정 실패.";
			}
		}
		
		model.addAttribute("RESULT_MSG", msg);
		
		return "/courseMgr/courseSeq/courseSeqExec";
	}
	
	/**
	 * 학생장,부학생장 검색.
	 */
	@RequestMapping(value="/courseMgr/courseSeq.do", params = "mode=search_stumas")
	public String search_stumas(@ModelAttribute("cm")CommonMap cm, Model model) throws BizException {
		DataMap requestMap = cm.getDataMap();
		requestMap.setNullToInitialize(true);
		
		//과정 기수에 속한 회원 검색(수강신청 완료된 사람.)
		DataMap listMap = courseSeqService.selectGrSeqAppMemberList(requestMap);
		
		model.addAttribute("LIST_DATA", listMap);
		
		return "/courseMgr/courseSeq/courseSeqSearchStuMasPop";
	}

	/**
	 * 학생장, 부학생장 추가/삭제 실행.
	 */
	@RequestMapping(value="/courseMgr/courseSeq.do", params = "mode=stumas_exec")
	public String stumas_exec(@ModelAttribute("cm")CommonMap cm, Model model) throws BizException {
		DataMap requestMap = cm.getDataMap();
		requestMap.setNullToInitialize(true);
		
		StringBuffer msg = new StringBuffer();
		StringBuffer resultCode = new StringBuffer();
		StringBuffer resultName = new StringBuffer();
		int result = 0;
		
		if(requestMap.getString("qu").equals("insert")){ //등록
			Map<String, Object> paramMap = new HashMap<String, Object>();
			
			paramMap.put("grcode", requestMap.getString("grcode"));
			paramMap.put("grseq", requestMap.getString("grseq"));
			paramMap.put("userno", requestMap.getString("userno"));
			paramMap.put("masGubun", requestMap.getString("masGubun"));
			paramMap.put("addpoint", "0");
			
			//학생장,부학생장 등록
			result = courseSeqService.insertGrSeqStuMas(paramMap);
			
			if (result > 0 ) {
				msg.append(requestMap.getString("title")).append("이 등록 되었습니다.");
			} else {
				msg.append("에러");
			}
		}else if(requestMap.getString("qu").equals("delete")){ //삭제
			//학생장,부학생장 삭제
			result = courseSeqService.deleteGrSeqStuMas(requestMap);
			
			if (result > 0 ) {
				msg.append(requestMap.getString("title")).append("이 삭제 되었습니다.");
			} else {
				msg.append("에러");
			}
		}
		
		// 추가/삭제된 결과 내용을 포함한 학생,학생장 리스트.
		DataMap tmpMas = courseSeqService.selectGrStuMasGubunList(requestMap);
		for(int i = 0; i < tmpMas.keySize("userno"); i++) {
			if (!resultCode.toString().equals("")) {
				resultCode.append(",");
			}
			if (!resultName.toString().equals("")) {
				resultName.append(",");
			}
			
			resultCode.append(tmpMas.getString("userno", i));
			resultName.append(tmpMas.getString("name", i)).append("[" + tmpMas.getString("deptnm", i)).append("/").append(tmpMas.getString("mjiknm", i)).append("]");
		}
		
		model.addAttribute("RESULT_MSG", msg.toString());
		model.addAttribute("RESULT_CODE", resultCode.toString());
		model.addAttribute("RESULT_NAME", resultName.toString());
		
		return "/courseMgr/courseSeq/courseSeqStuMasExec";
	}
	
	/**
	 * 강사 검색 팝업
	 */
	@RequestMapping(value="/courseMgr/courseSeq.do", params = "mode=search_tutor")
	public String search_tutor(@ModelAttribute("cm")CommonMap cm, Model model) throws BizException {
		DataMap requestMap = cm.getDataMap();
		requestMap.setNullToInitialize(true);
		
		if (requestMap.getString("currPage").equals("")) {
			requestMap.setInt("currPage", 1); //페이지
		}
		if (requestMap.getString("rowSize").equals("")) {
			requestMap.setInt("rowSize", 10); //페이지당 보여줄 갯수
		}
		if (requestMap.getString("pageSize").equals("")) {
			requestMap.setInt("pageSize", 10); //페이지 블럭 갯수
		}
		
		//강시 리스트.
		DataMap listMap = courseSeqService.selectMemberTutorList(requestMap);
		
		model.addAttribute("LIST_DATA", listMap);
		
		return "/courseMgr/courseSeq/searchTutorPop";
	}
	
	
	/**
	 * 개설과정 추가 폼.
	 */
	@RequestMapping(value="/courseMgr/courseSeq.do", params = "mode=grcode_form")
	public String grcode_form(@ModelAttribute("cm")CommonMap cm, Model model) throws BizException {
		DataMap requestMap = cm.getDataMap();
		requestMap.setNullToInitialize(true);
		
		DataMap grseqListMap = courseSeqService.selectGrcodeList(requestMap);
		
		model.addAttribute("LIST_DATA", grseqListMap);
		
		return "/courseMgr/courseSeq/courseSeqGrcodeForm";
	}
	
	
	/**
	 * 개설과정 등록/삭제 실행.
	 */
	@RequestMapping(value="/courseMgr/courseSeq.do", params = "mode=grcode_exec")
	public String grcode_exec(@ModelAttribute("cm")CommonMap cm, Model model) throws BizException {
		DataMap requestMap = cm.getDataMap();
		requestMap.setNullToInitialize(true);
		
		//사용자 정보 추출.
		LoginInfo loginInfo = (LoginInfo)cm.getRequest().getAttribute("LOGIN_INFO");
		
		String msg = ""; //결과 메세지.
		
		if (requestMap.getString("qu").equals("insert")) { //등록
			DataMap grSeqListMap = null;
            String whereStr = "";
            String year = requestMap.getString("year");
            
    		if (year.equals("")) { //year 값이 없으면(어디에서 사용하는지 모름.
    			whereStr = " AND GRCODE = '"+ requestMap.getString("year") + "' ";
    			try{
    				year = requestMap.getString("grseq").substring(0, 4);
    			}catch(Exception e){} //getString.substring Exception
    		} else { //개설과정 추가시.
    			for (int i = 0;i < requestMap.keySize("grcode[]");i++) {
    				if (i == 0) {
    					whereStr += " AND GRCODE IN ( ";
    				} else {
    					whereStr += ", ";
    				}
    				whereStr += "'" + requestMap.getString("grcode[]", i) + "'";
    			}
    			
    			if (!whereStr.equals("")) {
    				whereStr+= ") ";
    			}
    		}
    		
    		if ( !whereStr.equals("") ) {
    			//선택한 과정정보 가져오기.
    			grSeqListMap = courseSeqService.selectGrseqMaxList(year, whereStr);
        		//등록.
    			courseSeqService.insertGrSeqGrcode(requestMap, grSeqListMap, loginInfo.getSessNo());
    			msg = "기수가 추가 되었습니다.";
    		} else {
    			msg = "추가할 과정을 선택해 주세요.";
    		}
		} else if(requestMap.getString("qu").equals("delete")) { //삭제
			int result = courseSeqService.selectAppInfoByGrcodeYearCnt(requestMap);
			
			if (result > 0 ) {
				msg = "수강신청인원이 있는 과정 기수가 존재 합니다.";
			} else {
				courseSeqService.deleteGrSeqGrcode(requestMap);
				msg = "삭제 되었습니다.";
			}
		} else if (requestMap.getString("qu").equals("insert_form2")) { //개설과정 추가(3뎁스)
			//등록.
			courseSeqService.insertGrseqByGrseqMng(requestMap);
			msg = "과정이 추가되었습니다.";
		}
			
		model.addAttribute("RESULT_MSG", msg);
		
		return "/courseMgr/courseSeq/courseSeqGrcodeExec";
	}
	
	/**
	 * 과목 추가 리스트. (팝업)
	 */
	@RequestMapping(value="/courseMgr/courseSeq.do", params = "mode=subj_list")
	public String subj_list(@ModelAttribute("cm")CommonMap cm, Model model) throws BizException {
		DataMap requestMap = cm.getDataMap();
		requestMap.setNullToInitialize(true);

		if (requestMap.getString("currPage").equals("")) {
			requestMap.setInt("currPage", 1); //페이지
		}
		if (requestMap.getString("rowSize").equals("")) {
			requestMap.setInt("rowSize", 20); //페이지당 보여줄 갯수
		}
		if (requestMap.getString("pageSize").equals("")) {
			requestMap.setInt("pageSize", 10); //페이지 블럭 갯수
		}
		
		//과목 리스트.
		DataMap listMap = null;
		//선택한 과목 리스트.
		DataMap selectedListMap  = courseSeqService.selectSubjInGrSeqList(requestMap);
		//인덱스
		DataMap indexMap  = subjService.selectCharIndex();
		
		//검색시 .
		if (requestMap.getString("search").equals("GO")) {
			listMap = courseSeqService.selectSubjByIndexList(requestMap);
		} else {
			listMap = new DataMap();
		}
		
		model.addAttribute("LIST_DATA", listMap);
		model.addAttribute("SELECTED_DATA", selectedListMap);
		model.addAttribute("INDEX_DATA", indexMap);	
		
		return "/courseMgr/courseSeq/courseSeqSubjList";
	}
	
	/**
	 * 과목 수정 폼.
	 */
	@RequestMapping(value="/courseMgr/courseSeq.do", params = "mode=subj_form")
	public String subj_form(@ModelAttribute("cm")CommonMap cm, Model model) throws BizException {
		DataMap requestMap = cm.getDataMap();
		requestMap.setNullToInitialize(true);
		
		//과목 정보.
		DataMap rowMap = courseSeqService.selectSubjSeqRow(requestMap);
		
		//과정 기수 정보
		DataMap grseqMap = courseSeqService.selectGrSeqRow(requestMap.getString("commGrcode"), requestMap.getString("commGrseq"));
		
		//과목의 등록된 콘텐츠 정보
		DataMap contentMappingListMap = subjService.selectSubjByContentMappingList(requestMap.getString("subj"));
		
		model.addAttribute("ROW_DATA", rowMap);
		model.addAttribute("GRSEQ_ROW_DATA", grseqMap);
		model.addAttribute("COTENTMAPPING_LIST_DATA", contentMappingListMap);
		
		return "/courseMgr/courseSeq/courseSeqSubjForm";
	}
	
	/**
	 * 과목 추가 실행.
	 */
	@RequestMapping(value="/courseMgr/courseSeq.do", params = "mode=subj_exec")
	public String subj_exec(@ModelAttribute("cm")CommonMap cm, Model model) throws BizException {
		DataMap requestMap = cm.getDataMap();
		requestMap.setNullToInitialize(true);
		
		//사용자 정보 추출.
		LoginInfo loginInfo = (LoginInfo)cm.getRequest().getAttribute("LOGIN_INFO");
		
		String msg = ""; //결과 메세지.
		
		//과목추가, 이전과목복사
		if ("insert".equals(requestMap.getString("qu")) || "insert_copy".equals(requestMap.getString("qu"))) {
			int result = courseSeqService.insertGrSeqSubj(requestMap, loginInfo.getSessNo());
			if (result > 0) {
				msg = "과목이 추가되었습니다.";
			} else {
				msg = "실패";
			}
		} else if(requestMap.getString("qu").equals("update")) {
			//과목 수정
			int result = courseSeqService.updateSubjSeq(requestMap);
			if (result > 0) {
				msg = "과목정보가 수정 되었습니다.";
			} else {
				msg = "실패";
			}
		}
		model.addAttribute("RESULT_MSG", msg);
		
		return "/courseMgr/courseSeq/courseSeqSubjExec";
	}
	
	
	/**
	 * 이전 과목 복사.
	 */
	@RequestMapping(value="/courseMgr/courseSeq.do", params = "mode=copy_subj")
	public String copy_subj(@ModelAttribute("cm")CommonMap cm, Model model) throws BizException {
		DataMap requestMap = cm.getDataMap();
		requestMap.setNullToInitialize(true);
		
		//과정 기수 정보.
		DataMap grseqMap = courseSeqService.selectGrSeqRow(requestMap.getString("grcode"), requestMap.getString("grseq"));
		
		//기수 리스트 
		DataMap copyGrseqList = courseSeqService.selectGrSeqByNotInList(requestMap);
		if (copyGrseqList == null) {
			copyGrseqList = new DataMap();
		}
		copyGrseqList.setNullToInitialize(true);
		
		DataMap subjList = null; //과목리스트
		DataMap copySubjList = null; //복사할 기수의 과목
		
		//첫 로딩시 복사할 과정기수의 목록중 1번째것.
		if (requestMap.getString("copyGrseq").equals("")) {
			requestMap.setString("copyGrseq", copyGrseqList.getString("grseq", 0));
		}
			
		//이전 과정 기수가 존재 한다면.
		if (copyGrseqList.keySize("grseq") > 0) {
			//과정 기수의 과목 리스트.
			subjList = courseSeqService.selectSubjSeqList(requestMap);
			//복사할 기수의 과목 리스트.
			copySubjList = courseSeqService.selectSubjSeqCopyList(requestMap);
		} else {
			subjList = new DataMap();
			copySubjList = new DataMap();
		}
		
		model.addAttribute("GRSEQ_LIST_DATA", copyGrseqList);
		model.addAttribute("GRSEQ_ROW_DATA", grseqMap);
		model.addAttribute("SUBJ_LIST_DATA", subjList);
		model.addAttribute("COPYSUBJ_LIST_DATA", copySubjList);
		
		return "/courseMgr/courseSeq/courseSeqCopySubjPop";
	}
	
	/**
	 * 이전 기수 정보 복사.
	 */
	@RequestMapping(value="/courseMgr/courseSeq.do", params = "mode=copy_grseq")
	public String copy_grseq(@ModelAttribute("cm")CommonMap cm, Model model) throws BizException {
		DataMap requestMap = cm.getDataMap();
		requestMap.setNullToInitialize(true);
		
		//과정 기수 정보.
		DataMap grseqMap = courseSeqService.selectGrSeqRow(requestMap.getString("grcode"), requestMap.getString("grseq"));
		
		//기수 리스트 
		String prevGrseq = courseSeqService.selectGrseqPrevMaxGrseq(requestMap);

		model.addAttribute("PREV_GRSEQ_STRING", prevGrseq);
		model.addAttribute("GRSEQ_ROW_DATA", grseqMap);
		
		return "/courseMgr/courseSeq/courseSeqCopyGrseqPop";
	}
	
	/**
	 * 이전 기수 복사 실행.
	 */
	@RequestMapping(value="/courseMgr/courseSeq.do", params = "mode=copy_exec")
	public String copy_exec(@ModelAttribute("cm")CommonMap cm, Model model) throws BizException {
		DataMap requestMap = cm.getDataMap();
		requestMap.setNullToInitialize(true);
		
		//사용자 정보 추출.
		LoginInfo loginInfo = (LoginInfo)cm.getRequest().getAttribute("LOGIN_INFO");
		
		String msg = ""; //결과 메세지.

		if (requestMap.getString("qu").equals("grseq")) { //이전 기수 정보 복사
			//이전 기수 정보 복사
			int result = courseSeqService.execPrevGrseq(requestMap, loginInfo.getSessNo());
			if (result > 0) {
				msg = "이전 기수가 복사 되었습니다.";
			} else {
				msg = "실패";
			}
		}

		model.addAttribute("RESULT_MSG", msg);
		
		return "/courseMgr/courseSeq/courseSeqCopyExec";
	}
	
	/**
	 * SELECTBOX 과정목록 가져오기.
	 */
	@RequestMapping(value="/courseMgr/courseSeq.do", params = "mode=ajax_grcode")
	public String ajax_grcode(@ModelAttribute("cm")CommonMap cm, Model model) throws BizException {
		DataMap requestMap = cm.getDataMap();
		requestMap.setNullToInitialize(true);
		
		//사용자 정보 추출.
		LoginInfo loginInfo = (LoginInfo)cm.getRequest().getAttribute("LOGIN_INFO");
		
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("year", requestMap.getString("year"));
		paramMap.put("sessClass", loginInfo.getSessClass());
		paramMap.put("sessClassVal", Constants.ADMIN_SESS_CLASS_COURSEMAN);
		paramMap.put("sessUserNo", loginInfo.getSessNo());
		paramMap.put("sessGubun", loginInfo.getSessGubun());
		
		DataMap listMap = courseSeqService.selectSessClassGrCodeList(paramMap);
		
		model.addAttribute("LIST_DATA", listMap);
		
		return "/courseMgr/courseSeq/courseSeqAjaxCourse";
	}
	
	/**
	 * 개설과정 추가
	 */
	@RequestMapping(value="/courseMgr/courseSeq.do", params = "mode=grcode_form2")
	public String grcode_form2(@ModelAttribute("cm")CommonMap cm, Model model) throws BizException {
		DataMap requestMap = cm.getDataMap();
		requestMap.setNullToInitialize(true);
		
		//리스트
		DataMap listMap = courseSeqService.selectGrcodeListByGrseq(requestMap);

		//기수코드 리스트
		DataMap grseqListMap = courseSeqService.selectGrseqMngGrseqList(DateUtil.getYear());
		
		model.addAttribute("LIST_DATA", listMap);
		model.addAttribute("GRSEQ_LIST_DATA", grseqListMap);
		
		return "/courseMgr/courseSeq/courseSeqGrcodeForm2";
	}
	
	/**
	 * 첨부 파일
	 */
	@RequestMapping(value="/courseMgr/courseSeq.do", params = "mode=file_form")
	public String file_form(@ModelAttribute("cm")CommonMap cm, Model model) throws BizException {
		DataMap requestMap = cm.getDataMap();
		requestMap.setNullToInitialize(true);
		
		//기수 파일 정보.
		DataMap rowMap = courseSeqService.selectGrSeqRow(requestMap.getString("grcode"), requestMap.getString("grseq"));
		
		try {
			//파일 정보 가져오기.
			commonService.selectUploadFileList(rowMap);
		}  catch (Exception e) {
            throw new BizException(e);
        } finally {
        	
        }
		
		model.addAttribute("ROW_DATA", rowMap);
		
		return "/courseMgr/courseSeq/courseSeqFileFormPop";
	}
	
	/**
	 * 시험정보 저장
	 */
	@RequestMapping(value="/courseMgr/courseSeq.do", params = "mode=saveExamInfo")
	public String saveExamInfo(@ModelAttribute("cm")CommonMap cm, Model model) throws BizException {
		DataMap requestMap = cm.getDataMap();
		requestMap.setNullToInitialize(true);
		
		LoginInfo loginInfo = (LoginInfo)cm.getRequest().getAttribute("LOGIN_INFO");
		requestMap.setString("userno", loginInfo.getSessNo());
		int result = 0;
		if (!requestMap.getString("idExam").equals("")) {
			result = courseSeqService.updateExam(requestMap);
		} else {
			result = courseSeqService.insertExam(requestMap);
		}
		
		String msg = "";
		String resultType = "";
		if (result > 0) {
			msg = "저장했습니다.";
			resultType = "OK";
		} else {
			msg = "저장에 실패했습니다.";
			resultType = "Error";
		}
		
		model.addAttribute("RESULT_MSG", msg);
		model.addAttribute("RESULT_TYPE", resultType);
		
		return "/courseMgr/courseSeq/examExec";
	}
	
	/**
	 * 시험날짜 저장
	 */
	@RequestMapping(value="/courseMgr/courseSeq.do", params = "mode=saveExamDate")
	public String saveExamDate(@ModelAttribute("cm")CommonMap cm, Model model) throws BizException {
		DataMap requestMap = cm.getDataMap();
		requestMap.setNullToInitialize(true);
		
		System.out.println("====================================================================================");
		
		LoginInfo loginInfo = (LoginInfo)cm.getRequest().getAttribute("LOGIN_INFO");
		requestMap.setString("userno", loginInfo.getSessNo());
		int result = 0;
		result = courseSeqService.updateExamDate(requestMap);
		
		String msg = "";
		String resultType = "";
		if (result > 0) {
			msg = "저장했습니다.";
			resultType = "OK";
		} else {
			msg = "저장에 실패했습니다.";
			resultType = "Error";
		}
		
		model.addAttribute("RESULT_MSG", msg);
		model.addAttribute("RESULT_TYPE", resultType);
		
		return "/courseMgr/courseSeq/examExec";
	}
	
	/**
	 * 시험지 미리보기
	 */
	@RequestMapping(value="/courseMgr/courseSeq.do", params = "mode=previewExam")
	public String previewExam(@ModelAttribute("cm")CommonMap cm, Model model) throws BizException {
		DataMap requestMap = cm.getDataMap();
		requestMap.setNullToInitialize(true);
		
		DataMap listMap = courseSeqService.selectExamPaperBySet(requestMap);
		model.addAttribute("LIST_DATA", listMap);
		
		return "/courseMgr/courseSeq/previewExam";
	}
	
	/**
	 * 시험지 미리보기
	 */
	@RequestMapping(value="/courseMgr/courseSeq.do", params = "mode=previewOffExam")
	public String previewOffExam(@ModelAttribute("cm")CommonMap cm, Model model) throws BizException {
		DataMap requestMap = cm.getDataMap();
		requestMap.setNullToInitialize(true);
		
		DataMap listMap = courseSeqService.selectOffExamPaperBySet(requestMap);
		model.addAttribute("LIST_DATA", listMap);
		
		return "/courseMgr/courseSeq/previewOffExam";
	}
	
	/**
	 * 시험 (불)가능 상태로 만들기 
	 */
	@RequestMapping(value="/courseMgr/courseSeq.do", params = "mode=updateYnEnable")
	public String updateYnEnable(@ModelAttribute("cm")CommonMap cm, Model model) throws BizException {
		DataMap requestMap = cm.getDataMap();
		requestMap.setNullToInitialize(true);
		
		LoginInfo loginInfo = (LoginInfo)cm.getRequest().getAttribute("LOGIN_INFO");
		requestMap.setString("userid", loginInfo.getSessNo());
		
		int result = courseSeqService.updateYNEnable(requestMap);
		
		String msg = "";
		String resultType = "";
		if (result > 0) {
			msg = "저장했습니다.";
			resultType = "OK";
		} else {
			msg = "저장에 실패했습니다.";
			resultType = "Error";
		}
		model.addAttribute("RESULT_MSG", msg);
		model.addAttribute("RESULT_TYPE", resultType);
		
		return "/courseMgr/courseSeq/examExec";
	}
		
	/**
	 * 집합교육 정답 파일로 문제 및 시험지 생성하기
	 */
	@Transactional
	@RequestMapping(value="/courseMgr/courseSeq.do", params = "mode=saveAns")
	public String saveAns(@ModelAttribute("cm")CommonMap cm, Model model) throws BizException {
		DataMap requestMap = cm.getDataMap();
		requestMap.setNullToInitialize(true);
		
		String msg = "";
		String resultType = "";
		int result = 0;
		
		Map<String, Object> map = new HashMap<String, Object>();
		Map<String, Object> paramMap = null;
		String idCompany = "10034";
		requestMap.set("idCompany", idCompany);
		String idExam = requestMap.getString("idExam");
		String subj = requestMap.getString("subj");
		String grcode = requestMap.getString("grcode");
		String grseq = requestMap.getString("grseq");
		String afile = "", afileRn = "";
		String idChapter = "";
		List<String> subjList = new ArrayList<String>();
		int qcount = requestMap.getInt("qcount");
		int setcount = requestMap.getInt("setcount");
		double allotting = requestMap.getDouble("allotting");
		double allottingPerQ = allotting / qcount;
		int nrQ = 0;
		LoginInfo loginInfo = (LoginInfo)cm.getRequest().getAttribute("LOGIN_INFO");
		String userno = loginInfo.getSessNo();
		requestMap.set("userid", userno);
		
		Workbook workbook = null;
		Sheet sheet = null;
		StringBuffer sb = null;
		
		try {
			DataMap fileMap = (DataMap)requestMap.get("UPLOAD_FILE");
			if(fileMap == null) fileMap = new DataMap();
			fileMap.setNullToInitialize(true);
			
			if (fileMap.keySize("fileUploadOk") > 0) {
				if (fileMap.getLong("afile_fileSize") > 0 ) {
					afileRn = fileMap.getString("afile_fileName");
					afile = fileMap.getString("afile_fileOrgName");
				}
			}
			
			sb = new StringBuffer();
			sb.append(SpringUtils.getRealPath()).append(Constants.UPLOAD).append(fileMap.getString("file_filePath")).append(fileMap.getString("file_fileName"));
			String root = sb.toString();
			
			//엑셀파일을 인식 
			workbook = Workbook.getWorkbook( new java.io.File(root));
			
			if( workbook != null) {
				//엑셀파일에서 첫번째 Sheet를 인식
				sheet = workbook.getSheet(0);
				
		    	if( sheet != null) {
		    		Cell[] cells = sheet.getRow(0);
		    		int cellLen = cells.length;
		    		if (cellLen > 0 && cellLen % 2 == 0) {
		    			String[] arySubj = new String[cellLen/2];
		    			int inx = 0;
		    			int qCnt = 0;
			    		for(int i=0; i<cellLen; i++) {
			    			if (i%2 == 0) {
			    				try {
			    					arySubj[inx++] = cells[i].getContents();
			    				} catch(Exception e) {
	    							result = 0;
	    							msg = "1행의 과목정보가 잘못되었습니다.";
			    					resultType = "Error";
			    					break;
	    						}
			    			} else {
			    				Cell[] ansCells = sheet.getColumn(i);
			    				List<Integer> ansList = new ArrayList<Integer>();
			    				int chkR = 0, chkL = 0;
			    				for(int j=1; j<ansCells.length; j++) {
			    					try {
			    						if (ansCells[j] != null) {
			    							int cellCont = Integer.parseInt(ansCells[j].getContents());
			    							chkR = 1;
			    							if (cellCont == -1) {
			    								break;
			    							} else {
			    								ansList.add(cellCont);
			    							}
			    							qCnt++;
			    						} else {
			    							ansList.add(-1);
			    							chkL = 2;
			    						}
			    					} catch(Exception e) {
			    						ansList.add(-1);
		    							chkL = 2;
		    						}
			    				}
			    				if (chkR + chkL == 1) {
			    					subjList.add(arySubj[inx-1]);
			    					map.put(arySubj[inx-1], ansList);
			    					//qCnt = qCnt + aryAns.length;
			    				} else if (chkR + chkL == 3) {
			    					result = 0;
	    							sb = new StringBuffer();
	    							sb.append(String.valueOf(i+1)).append("열의 정답이 잘못되었습니다.");
	    							msg = sb.toString();
			    					resultType = "Error";
			    					break;
			    				}
			    			}
			    		}
			    		
			    		DataMap mainChapterMap = null;
						DataMap subChapterMap = null;
						
			    		if (!resultType.equals("Error")) {
			    			if (qCnt == qcount && qcount > 0) {
			    				for(int i=0; i<subjList.size(); i++) {
			    					String subjCd = subjList.get(i);
			    					List<Integer> ansList = (ArrayList<Integer>) map.get(subjCd);
			    					if (ansList != null && ansList.size() > 0) {
			    						if (idExam.equals("")) {
			    							mainChapterMap = courseSeqService.selectMainChapterBySubj(subj);
			    							if (mainChapterMap.keySize("idChapter") == 0) {
				    							result = 0;
				    							result = courseSeqService.insertMainChapter(subj, idCompany);
				    							
				    							if (result > 0) {
				    								mainChapterMap = courseSeqService.selectMainChapterBySubj(subj);
				    								result = 0;
				    								idChapter = questionMgrService.selectIdChapterFromDual(idCompany);
				    								result = courseSeqService.insertSubChapter(subj, subjCd, idChapter, grseq, idCompany);
				    								if (result > 0) {
				    									subChapterMap = courseSeqService.selectSubChapterBySubj(subj, subjCd, idChapter);
				    								} else {
				    									result = 0;
						    							msg = "기초정보 저장에 실패하였습니다.";
								    					resultType = "Error";
								    					TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
								    					break;
				    								}
				    							} else {
				    								result = 0;
					    							msg = "기초정보 저장에 실패하였습니다.";
							    					resultType = "Error";
							    					TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
							    					break;
				    							}
				    						} else {
				    							result = 0;
				    							idChapter = questionMgrService.selectIdChapterFromDual(idCompany);
			    								result = courseSeqService.insertSubChapter(subj, subjCd, idChapter, grseq, idCompany);
			    								if (result > 0) {
			    									subChapterMap = courseSeqService.selectSubChapterBySubj(subj, subjCd, idChapter);
			    								} else {
			    									result = 0;
					    							msg = "기초정보 저장에 실패하였습니다.";
							    					resultType = "Error";
							    					TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
							    					break;
			    								}
				    						}
			    						} else {
			    							mainChapterMap = courseSeqService.selectMainChapterBySubj(subj);
			    							if (mainChapterMap.keySize("idChapter") > 0) {
			    								subChapterMap = courseSeqService.selectChapterByIdExam(idExam, subjCd);
			    								if (subChapterMap.keySize("idChapter") == 0) {
			    									result = 0;
					    							msg = "기초정보 조회에 실패하였습니다.";
							    					resultType = "Error";
							    					TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
							    					break;
			    								}
			    							} else {
			    								result = 0;
				    							msg = "기초정보 조회에 실패하였습니다.";
						    					resultType = "Error";
						    					TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
						    					break;
			    							}
			    						}
			    						
			    						if (!resultType.equals("Error")) {
			    							paramMap = new HashMap<String, Object>();
			    							paramMap.put("idCourse", subChapterMap.getString("idCourse"));
			    							paramMap.put("idSubject", subChapterMap.getString("idSubject"));
			    							paramMap.put("idChapter", subChapterMap.getString("idChapter"));
			    							paramMap.put("nrSet", setcount+1);
			    							courseSeqService.deleteOffQuestions(paramMap);
			    							for(int j=0; j<ansList.size(); j++) {
			    								paramMap = new HashMap<String, Object>();
				    							paramMap.put("idCourse", subChapterMap.getString("idCourse"));
				    							paramMap.put("idSubject", subChapterMap.getString("idSubject"));
				    							paramMap.put("idChapter", subChapterMap.getString("idChapter"));
				    							paramMap.put("q", subjCd);
				    							paramMap.put("ex1", grcode);
				    							paramMap.put("ex2", grseq);
				    							paramMap.put("ex3", setcount+1);
				    							paramMap.put("ex4", (nrQ++)+1);
				    							paramMap.put("ca", ansList.get(j));
				    							paramMap.put("idCompany", idCompany);
				    							paramMap.put("userid", userno);
				    							paramMap.put("useYn", "Y");
				    							
				    							result = questionMgrService.insertQForOff(paramMap);
				    							if (result == 0) {
				    								msg = "문항 및 정답 저장에 실패하였습니다.";
							    					resultType = "Error";
							    					TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
							    					break;
				    							}
			    							}
			    							
			    							if (resultType.equals("Error")) {
			    								break;
			    							}
			    						}
			    					}
			    				}
			    				
			    				if (!resultType.equals("Error")) {
			    					mainChapterMap.setString("afile", afile);
			    					mainChapterMap.setString("afileRn", afileRn);
			    					if (idExam.equals("")) {
			    						idExam = courseSeqService.selectIdExamFromDual(idCompany);
				    					result = courseSeqService.insertOffExamInfo(requestMap, mainChapterMap);
			    					} else {
			    						result = courseSeqService.updateOffExamInfo(requestMap, mainChapterMap);
			    					}
			    					
			    					if (result > 0) {
				    					paramMap = new HashMap<String, Object>();
				    					paramMap.put("idExam", idExam);
						    			paramMap.put("idSubject", mainChapterMap.getString("idSubject"));
						    			courseSeqService.deleteQuestionFromPaper(paramMap);
						    			courseSeqService.deleteQuestionFromQ(paramMap);
						    			
						    			DataMap questionMap = new DataMap();
						    			questionMap = courseSeqService.selectOffExamQuestion(requestMap, mainChapterMap);
						    			if (questionMap.keySize("idQ") > 0) {
											Map<String, Object> paramMap2 = null;
											for(int j=0; j<questionMap.keySize("idQ"); j++) {
												paramMap2 = new HashMap<String, Object>();
												paramMap2.put("idExam", idExam);
												paramMap2.put("examUnit", 1);
												paramMap2.put("idSubject", subChapterMap.getString("idSubject"));
												paramMap2.put("nrSet", questionMap.getInt("ex3", j));
												paramMap2.put("nrQ", questionMap.getInt("ex4", j));
												paramMap2.put("idQ", questionMap.getInt("idQ", j));
												paramMap2.put("exOrder", "1,2,3,4");
												paramMap2.put("allotting", allottingPerQ);
												paramMap2.put("page", questionMap.getInt("ex4", j));
												
												result = courseSeqService.insertQuestionIntoPaper(paramMap2);
												int examQCnt = 0;
												if (result > 0) {
													examQCnt = courseSeqService.selectExamQCnt(paramMap2);
													if (examQCnt == 0) {
														result = courseSeqService.insertQuestionIntoQ(paramMap2);
														
														if (result > 0) {
															msg = "저장했습니다.";
															resultType = "offOK";
														} else {
															result = 0;
															TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
															msg = "저장에 실패하였습니다.";
								    						resultType = "Error";
															break;
														}
													}
												} else {
													result = 0;
													TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
													msg = "저장에 실패하였습니다.";
						    						resultType = "Error";
													break;
												}
											}
						    			} else {
						    				result = 0;
					    					TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
				    						msg = "저장에 실패하였습니다.";
				    						resultType = "Error";
					    				}
				    				} else {
				    					result = 0;
				    					TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
			    						msg = "저장에 실패하였습니다.";
			    						resultType = "Error";
				    				}
			    				}
			    			} else {
			    				result = 0;
			    				sb = new StringBuffer();
			    				sb.append("입력한 문항 수(").append(String.valueOf(qcount)).append(")와 등록하려는 문항 수(").append(String.valueOf(qCnt)).append(")가 일치하지 않습니다.");
    							msg = sb.toString();
		    					resultType = "Error";
			    			}
			    		}
		    		} else {
		    			result = 0;
			    		msg = "1행의 과목정보가 잘못되었습니다.";
			    		resultType = "Error";
		    		}
		    	} else {
		    		result = 0;
		    		msg = "Sheet가 없습니다.";
		    		resultType = "Error";
		    	}
			} else {
				result = 0;
				msg = "엑셀 데이터가 잘못 입력 되었습니다. 다시 확인하신 후 등록하여 주십시오.";
				resultType = "Error";
			}
		} catch( Exception e) {	
			result = 0;
			msg = "엑셀 데이터가 잘못 입력 되었습니다. 다시 확인하신 후 등록하여 주십시오.";
			resultType = "Error";
			TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
		    e.printStackTrace();
		} finally {
		    if( workbook != null) {
		        workbook.close();
		    }
		}
		
		model.addAttribute("RESULT_MSG", msg);
		model.addAttribute("RESULT_TYPE", resultType);
		
		return "/courseMgr/courseSeq/examExec";
	}
	
	/**
	 * 시험지 삭제
	 */
	@RequestMapping(value="/courseMgr/courseSeq.do", params = "mode=deleteExam")
	public String deleteExam(@ModelAttribute("cm")CommonMap cm, Model model) throws BizException {
		DataMap requestMap = cm.getDataMap();
		requestMap.setNullToInitialize(true);
		
		String msg = "";
		String resultType = "";
		String idExam = requestMap.getString("idExam");
		
		int result = courseSeqService.deleteExam(idExam);
		
		if (result > 0) {
			msg = "삭제했습니다.";
			resultType = "OK";
		} else {
			msg = "삭제에 실패했습니다.";
			resultType = "Error";
		}
		
		model.addAttribute("RESULT_MSG", msg);
		model.addAttribute("RESULT_TYPE", resultType);
		
		return "/courseMgr/courseSeq/examExec";
	}
	
	/**
	 * 시험지 삭제
	 */
	@RequestMapping(value="/courseMgr/courseSeq.do", params = "mode=deleteOffExam")
	public String deleteOffExam(@ModelAttribute("cm")CommonMap cm, Model model) throws BizException {
		DataMap requestMap = cm.getDataMap();
		requestMap.setNullToInitialize(true);
		
		String msg = "";
		String resultType = "";
		String idExam = requestMap.getString("idExam");
		DataMap chapterMap = new DataMap();
		int result = 0;
		
		chapterMap = courseSeqService.selectChapterByIdExam(idExam, "");
		result = courseSeqService.deleteOffQuestionSet(chapterMap);
		result = courseSeqService.deleteOffExam(idExam);
		
		if (result > 0) {
			msg = "삭제했습니다.";
			resultType = "offOK";
		} else {
			msg = "삭제에 실패했습니다.";
			resultType = "Error";
		}
		
		model.addAttribute("RESULT_MSG", msg);
		model.addAttribute("RESULT_TYPE", resultType);
		
		return "/courseMgr/courseSeq/examExec";
	}
	
	/**
	 * 시험지 신규
	 */
	@RequestMapping(value="/courseMgr/courseSeq.do", params = "mode=newExam")
	public String newExam(@ModelAttribute("cm")CommonMap cm, Model model) throws BizException, SQLException {
		return evlinfoSubjForm(cm, model);
	}
	
	/**
	 * 시험지 신규
	 */
	@RequestMapping(value="/courseMgr/courseSeq.do", params = "mode=newOffExam")
	public String newOffExam(@ModelAttribute("cm")CommonMap cm, Model model) throws BizException, SQLException {
		return evlinfoSubjOffForm(cm, model);
	}
	
	/**
	 * 과목코드별 문항 리스트 - 엑셀
	 */
	@RequestMapping(value="/courseMgr/courseSeq.do", params = "mode=downloadForm")
	public String downloadForm(@ModelAttribute("cm")CommonMap cm, Model model) throws BizException {
		DataMap requestMap = cm.getDataMap();
		requestMap.setNullToInitialize(true);
		
		DataMap listMap = null;
		listMap = courseSeqService.selectEvalSubjectList(requestMap);
		
		model.addAttribute("LIST_DATA", listMap);
		
		return "/courseMgr/courseSeq/downloadForm";
	}
}
