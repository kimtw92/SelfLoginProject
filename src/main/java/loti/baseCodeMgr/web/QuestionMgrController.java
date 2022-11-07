package loti.baseCodeMgr.web;

import gov.mogaha.gpin.sp.util.StringUtil;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import jxl.Cell;
import jxl.Sheet;
import jxl.Workbook;
import loti.baseCodeMgr.service.QuestionMgrService;
import loti.baseCodeMgr.service.SubjService;

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
import ut.lib.util.SpringUtils;
import ut.lib.util.Util;
import common.controller.BaseController;

@Controller
public class QuestionMgrController extends BaseController {
	
	@Autowired
	private QuestionMgrService questionMgrService;
	@Autowired
	private SubjService subjService;
	
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
			//default mode		
			if (mode.equals("")) {
				mode = "subjList";
				requestMap.setString("mode", mode);
			}
			
			//관리자 로그인 체크 (관리자 페이지에는 모두 있어야 함.)
			LoginInfo memberInfo = LoginCheck.adminCheck(request, response, requestMap.getString("menuId"));
			if (memberInfo == null) {
				return null;
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
	 * 과목코드 목록
	 */
	@RequestMapping(value="/baseCodeMgr/questionMgr.do", params = "mode=subjList")
	public String subjList(@ModelAttribute("cm")CommonMap cm, Model model) throws BizException {
		DataMap requestMap = cm.getDataMap();
		requestMap.setNullToInitialize(true);
		
		DataMap listMap = null;				
		listMap = subjService.selectCharIndex();
		model.addAttribute("CHARINDEX_DATA", listMap);
		
		if (requestMap.getString("s_indexSeq").equals("")) {
			selectSubjWithQuestionList(cm, model);
		} else {
			// 한글 인덱스 클릭시
			selectSubjWithQuestionByIndex(cm, model);
		}
			
		return "/baseCodeMgr/questionMgr/subjList";
	}
	
	/**
	 * 인덱스 미사용 목록
	 */
	public void selectSubjWithQuestionList(@ModelAttribute("cm")CommonMap cm, Model model) throws BizException {
		DataMap requestMap = cm.getDataMap();
		requestMap.setNullToInitialize(true);
		
		DataMap listMap = null;
		
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
		
		listMap = questionMgrService.selectSubjWithQuestionList(requestMap);
		model.addAttribute("LIST_DATA", listMap);
	}
	
	/**
	 * 인덱스 사용 목록
	 */
	public void selectSubjWithQuestionByIndex(@ModelAttribute("cm")CommonMap cm, Model model) throws BizException {
		DataMap requestMap = cm.getDataMap();
		requestMap.setNullToInitialize(true);
		
		DataMap listMap = null;
		
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
		
		listMap = questionMgrService.selectSubjWithQuestionByIndex(requestMap);
		model.addAttribute("LIST_DATA", listMap);
	}
	
	/**
	 * 과목코드별 문항 리스트 - 화면
	 */
	@RequestMapping(value="/baseCodeMgr/questionMgr.do", params = "mode=questionList")
	public String questionList(@ModelAttribute("cm")CommonMap cm, Model model) throws BizException {
		DataMap requestMap = cm.getDataMap();
		requestMap.setNullToInitialize(true);
		
		// 페이지
		if (requestMap.getString("currPage").equals("")){
			requestMap.setInt("currPage", 1);
		}
		// 페이지당 보여줄 갯수
		if (requestMap.getString("rowSize").equals("")){
			requestMap.setInt("rowSize", 20); 
		}
		// 페이지 블럭 갯수
		if (requestMap.getString("pageSize").equals("")){
			requestMap.setInt("pageSize", 10);
		}
		
		DataMap rowMap = null;
		DataMap listMap = null;
		rowMap = subjService.selectSubjRow(requestMap.getString("subj"));
		listMap = questionMgrService.selectQuestionListBySubj(requestMap);
		
		model.addAttribute("SUBJ_ROW_DATA", rowMap);
		model.addAttribute("QUESTION_LIST_DATA", listMap);
		
		return "/baseCodeMgr/questionMgr/questionList";
	}
	
	/**
	 * 과목코드별 문항 리스트 - 엑셀
	 */
	@RequestMapping(value="/baseCodeMgr/questionMgr.do", params = "mode=questionExcel")
	public String questionExcel(@ModelAttribute("cm")CommonMap cm, Model model) throws BizException {
		DataMap requestMap = cm.getDataMap();
		requestMap.setNullToInitialize(true);
		
		DataMap rowMap = null;
		DataMap listMap = null;
		rowMap = subjService.selectSubjRow(requestMap.getString("subj"));
		listMap = questionMgrService.selectQuestionExcelBySubj(requestMap);
		
		model.addAttribute("SUBJ_ROW_DATA", rowMap);
		model.addAttribute("QUESTION_LIST_DATA", listMap);
		
		return "/baseCodeMgr/questionMgr/questionExcel";
	}
	
	/**
	 * 문항 사용여부 설정
	 */
	@RequestMapping(value="/baseCodeMgr/questionMgr.do", params = "mode=setUseYn")
	public String setUseYn(@ModelAttribute("cm")CommonMap cm, Model model) throws BizException {
		DataMap requestMap = cm.getDataMap();
		requestMap.setNullToInitialize(true);
		
		String msg = "";
		String resultType = "";
		int result = 0;
		
		result = questionMgrService.updateUseYn(requestMap);
		
		if (result > 0) {
			msg = "저장되었습니다.";
			resultType = "SetUseYnOK";
		} else {
			msg = "저장에 실패하였습니다.";
			resultType = "SetUseYnError";
		}
		
		model.addAttribute("RESULT_MSG", msg);
		model.addAttribute("RESULT_TYPE", resultType);
		return "/baseCodeMgr/questionMgr/questionExec";
	}
	
	/**
	 * 오류 답안 처리 폼
	 */
	@RequestMapping(value="/baseCodeMgr/questionMgr.do", params = "mode=errorQuestion")
	public String errorQuestion(@ModelAttribute("cm")CommonMap cm, Model model
				, @RequestParam(value="idQ", required=false, defaultValue="-1") String idQ
			) throws BizException {
		
		DataMap question = questionMgrService.selectQuestion(idQ);
		
		model.addAttribute("question", question);
		
		return "/baseCodeMgr/questionMgr/errorQuestion";
	}
	
	/**
	 * 오류 답안 처리
	 */
	@RequestMapping(value="/baseCodeMgr/questionMgr.do", params = "mode=updateErrorQuestion")
	public String updateErrorQuestion(@ModelAttribute("cm")CommonMap cm, Model model
			, @RequestParam(value="idQ", required=false, defaultValue="-1") String idQ
			, @RequestParam(value="validType1", required=false, defaultValue="") String validType1
			, @RequestParam(value="validType2", required=false, defaultValue="") String validType2
			) throws BizException {
		
		cm.getDataMap().setString("idValidType", validType1.length() != 0 ? validType1 : validType2);

		int res = questionMgrService.updateErrorQuestion(cm.getDataMap());
		
		String msg = null;
		
		switch (res) {
		case 1:
			msg = "오류 문제 처리를 하였습니다.";
			break;
		default:
			msg = "";
			break;
		}
		
		model.addAttribute("msg", msg);
		model.addAttribute("mode", "errorQuestion");
		model.addAttribute("idQ", idQ);
		
		return "redirect:/baseCodeMgr/questionMgr.do";
	}
	
	/**
	 * 문항 삭제
	 */
	@RequestMapping(value="/baseCodeMgr/questionMgr.do", params = "mode=mDelete")
	public String mDelete(@ModelAttribute("cm")CommonMap cm, Model model) throws BizException {
		DataMap requestMap = cm.getDataMap();
		requestMap.setNullToInitialize(true);
		
		String msg = "";
		String resultType = "";
		int result = 0;
		
		result = questionMgrService.deleteQuestion(requestMap);
		
		if (result > 0) {
			msg = "삭제되었습니다.";
			resultType = "SetUseYnOK";
		} else {
			msg = "삭제에 실패하였습니다.";
			resultType = "SetUseYnError";
		}
		
		model.addAttribute("RESULT_MSG", msg);
		model.addAttribute("RESULT_TYPE", resultType);
		return "/baseCodeMgr/questionMgr/questionExec";
	}
	
	/**
	 * 문항 등록/수정 입력 폼
	 */
	@RequestMapping(value="/baseCodeMgr/questionMgr.do", params = "mode=questionForm")
	public String questionForm(@ModelAttribute("cm")CommonMap cm, Model model) throws BizException {
		DataMap requestMap = cm.getDataMap();
		requestMap.setNullToInitialize(true);
		
		DataMap rowMap = null;
		rowMap = subjService.selectSubjRow(requestMap.getString("subj"));
		
		DataMap qRowMap = new DataMap();
		if (StringUtil.nvl(requestMap.getString("idQ"),"").equals("")) {
			qRowMap.setString("idQ", "");
			qRowMap.setInt("excount", 0);
		} else {
			qRowMap = questionMgrService.selectQuestion(requestMap.getString("idQ"));
		}
		
		model.addAttribute("ROW_DATA", rowMap);
		model.addAttribute("QUESTION_DATA", qRowMap);
		
		return "/baseCodeMgr/questionMgr/questionForm";
	}
	
	/**
	 * 단일 문항 등록
	 */
	@RequestMapping(value="/baseCodeMgr/questionMgr.do", params = "mode=sInsert")
	public String sInsert(@ModelAttribute("cm")CommonMap cm, Model model) throws BizException {
		DataMap requestMap = cm.getDataMap();
		requestMap.setNullToInitialize(true);
		
		Map<String, Object> paramMap = null;
		String msg = "";
		String resultType = "";
		int result = 0;
		
		String qfile = "", qfileRn = "", qfileTp = "";
		String ex1file = "", ex1fileRn = "", ex1fileTp = "";
		String ex2file = "", ex2fileRn = "", ex2fileTp = "";
		String ex3file = "", ex3fileRn = "", ex3fileTp = "";
		String ex4file = "", ex4fileRn = "", ex4fileTp = "";
		String ex5file = "", ex5fileRn = "", ex5fileTp = "";
		String xfile = "", xfileRn = "", xfileTp = "";
		String hfile = "", hfileRn = "", hfileTp = "";
		
		DataMap fileMap = (DataMap)requestMap.get("UPLOAD_FILE");
		
		if (fileMap != null) {
			fileMap.setNullToInitialize(true);
			
			if (fileMap.keySize("fileUploadOk") > 0) {
				if (fileMap.getLong("qfile_fileSize") > 0 ) {
					qfileRn = fileMap.getString("qfile_fileName");
					qfile = fileMap.getString("qfile_fileOrgName");
					qfileTp = requestMap.getString("qFileType");
				}
				switch (requestMap.getInt("qType")) {
				case 2:
					if (fileMap.getLong("ex21file_fileSize") > 0) {
						ex1fileRn = fileMap.getString("ex21file_fileName");
						ex1file = fileMap.getString("ex21file_fileOrgName");
						ex1fileTp = requestMap.getString("ex21FileType");
					}
					if (fileMap.getLong("ex22file_fileSize") > 0 ) {
						ex2fileRn = fileMap.getString("ex22file_fileName");
						ex2file = fileMap.getString("ex22file_fileOrgName");
						ex2fileTp = requestMap.getString("ex22FileType");
					}
					if (fileMap.getLong("ex23file_fileSize") > 0  && requestMap.getInt("excount2") >= 3) {
						ex3fileRn = fileMap.getString("ex23file_fileName");
						ex3file = fileMap.getString("ex23file_fileOrgName");
						ex3fileTp = requestMap.getString("ex23FileType");
					}
					if (fileMap.getLong("ex24file_fileSize") > 0  && requestMap.getInt("excount2") >= 4) {
						ex4fileRn = fileMap.getString("ex24file_fileName");
						ex4file = fileMap.getString("ex24file_fileOrgName");
						ex4fileTp = requestMap.getString("ex24FileType");
					}
					if (fileMap.getLong("ex25file_fileSize") > 0  && requestMap.getInt("excount2") >= 5) {
						ex5fileRn = fileMap.getString("ex25file_fileName");
						ex5file = fileMap.getString("ex25file_fileOrgName");
						ex5fileTp = requestMap.getString("ex25FileType");
					}
					break;
				case 3:
					if (fileMap.getLong("ex31file_fileSize") > 0) {
						ex1fileRn = fileMap.getString("ex31file_fileName");
						ex1file = fileMap.getString("ex31file_fileOrgName");
						ex1fileTp = requestMap.getString("ex31FileType");
					}
					if (fileMap.getLong("ex32file_fileSize") > 0 ) {
						ex2fileRn = fileMap.getString("ex32file_fileName");
						ex2file = fileMap.getString("ex32file_fileOrgName");
						ex2fileTp = requestMap.getString("ex32FileType");
					}
					if (fileMap.getLong("ex33file_fileSize") > 0  && requestMap.getInt("excount3") >= 3) {
						ex3fileRn = fileMap.getString("ex33file_fileName");
						ex3file = fileMap.getString("ex33file_fileOrgName");
						ex3fileTp = requestMap.getString("ex33FileType");
					}
					if (fileMap.getLong("ex34file_fileSize") > 0  && requestMap.getInt("excount3") >= 4) {
						ex4fileRn = fileMap.getString("ex34file_fileName");
						ex4file = fileMap.getString("ex34file_fileOrgName");
						ex4fileTp = requestMap.getString("ex34FileType");
					}
					if (fileMap.getLong("ex35file_fileSize") > 0  && requestMap.getInt("excount3") >= 5) {
						ex5fileRn = fileMap.getString("ex35file_fileName");
						ex5file = fileMap.getString("ex35file_fileOrgName");
						ex5fileTp = requestMap.getString("ex35FileType");
					}
					break;
				case 4:
					if (fileMap.getLong("ex41file_fileSize") > 0) {
						ex1fileRn = fileMap.getString("ex41file_fileName");
						ex1file = fileMap.getString("ex41file_fileOrgName");
						ex1fileTp = requestMap.getString("ex41FileType");
					}
					break;
				case 5:
					if (fileMap.getLong("ex51file_fileSize") > 0) {
						ex1fileRn = fileMap.getString("ex51file_fileName");
						ex1file = fileMap.getString("ex51file_fileOrgName");
						ex1fileTp = requestMap.getString("ex51FileType");
					}
					break;
					default:
						break;
				}
				if (fileMap.getLong("xfile_fileSize") > 0 ) {
					xfileRn = fileMap.getString("xfile_fileName");		
					xfile = fileMap.getString("xfile_fileOrgName");
					xfileTp = requestMap.getString("xFileType");
				}
				if (fileMap.getLong("hfile_fileSize") > 0 ) {
					hfileRn = fileMap.getString("hfile_fileName");		
					hfile = fileMap.getString("hfile_fileOrgName");
					hfileTp = requestMap.getString("hFileType");
				}
			}
		}
		
		DataMap rowMap = null;
		rowMap = questionMgrService.selectChapter(requestMap.getString("subj"));
		
		if (rowMap.keySize("idCourse") == 0) {
			result = 0;
			
			paramMap = new HashMap<String, Object>();
			paramMap.put("idCourse", requestMap.getString("subj"));
			paramMap.put("idSubject", requestMap.getString("subj"));
			paramMap.put("chapter", requestMap.getString("subjnm"));
			paramMap.put("chapterOrder", 1);
			paramMap.put("courseCode", requestMap.getString("subj"));
			
			result = questionMgrService.insertChapter(paramMap);
			
			rowMap = questionMgrService.selectChapter(requestMap.getString("subj"));
		}
		
		result = 0;
		LoginInfo loginInfo = (LoginInfo)cm.getRequest().getAttribute("LOGIN_INFO");
		String userno = loginInfo.getSessNo();
		
		paramMap = new HashMap<String, Object>();
		paramMap.put("idCourse", rowMap.getString("idCourse"));
		paramMap.put("idSubject", rowMap.getString("idSubject"));
		paramMap.put("idChapter", rowMap.getString("idChapter"));
		paramMap.put("chapter", rowMap.getString("chapter"));
		paramMap.put("idQtype", requestMap.getString("qType"));
		paramMap.put("idDifficulty1", requestMap.getString("difficulty"));
		paramMap.put("q", requestMap.getString("question"));
		
		StringBuffer sbParam = null;
		StringBuffer sbRequest = null;
		switch (requestMap.getInt("qType")) {
		case 1:
			paramMap.put("excount", 2);
			paramMap.put("cacount", 1);
			paramMap.put("ex1", "O");
			paramMap.put("ex2", "X");
			paramMap.put("ex3", "");
			paramMap.put("ex4", "");
			paramMap.put("ex5", "");
			paramMap.put("ca", requestMap.getString("exOX"));
			break;
		case 2:
			paramMap.put("excount", requestMap.getString("excount2"));
			paramMap.put("cacount", 1);
			for(int i=1; i<=5; i++) {
				sbParam = new StringBuffer();
				sbRequest = new StringBuffer();
				sbParam.append("ex").append(String.valueOf(i));
				sbRequest.append("ex2").append(String.valueOf(i));
				if (requestMap.getInt("excount2") >= i) {
					paramMap.put(sbParam.toString(), requestMap.getString(sbRequest.toString()));
				} else {
					paramMap.put(sbParam.toString(), "");
				}
			}
			paramMap.put("ca", requestMap.getString("ca2"));
			break;
		case 3:
			paramMap.put("excount", requestMap.getString("excount3"));
			for(int i=1; i<=5; i++) {
				sbParam = new StringBuffer();
				sbRequest = new StringBuffer();
				sbParam.append("ex").append(String.valueOf(i));
				sbRequest.append("ex3").append(String.valueOf(i));
				if (requestMap.getInt("excount3") >= i) {
					paramMap.put(sbParam.toString(), requestMap.getString(sbRequest.toString()));
				} else {
					paramMap.put(sbParam.toString(), "");
				}
			}
			StringBuffer sbCa = new StringBuffer();
			int caCount = 0;
			for(int i=0; i<requestMap.keySize("ca3[]"); i++) {
				if (requestMap.getInt("ca3[]", i) <= requestMap.getInt("excount3")) {
					if (i == 0) {
						sbCa.append(requestMap.getString("ca3[]", i));
						caCount++;
					} else {
						sbCa.append("{|}");
						sbCa.append(requestMap.getString("ca3[]", i));
						caCount++;
					}
				}
			}
			paramMap.put("ca", sbCa.toString());
			paramMap.put("cacount", caCount);
			break;
		case 4:
			paramMap.put("excount", 0);
			paramMap.put("cacount", 1);
			paramMap.put("ex1", "");
			paramMap.put("ex2", "");
			paramMap.put("ex3", "");
			paramMap.put("ex4", "");
			paramMap.put("ex5", "");
			paramMap.put("ca", requestMap.getString("ca4"));
			break;
		case 5:
			paramMap.put("excount", 0);
			paramMap.put("cacount", 0);
			paramMap.put("ex1", "");
			paramMap.put("ex2", "");
			paramMap.put("ex3", "");
			paramMap.put("ex4", "");
			paramMap.put("ex5", "");
			paramMap.put("ca", requestMap.getString("ca5"));
			break;
			default:
				break;
		}
		paramMap.put("explain", requestMap.getString("explain"));
		paramMap.put("hint", requestMap.getString("hint"));
		paramMap.put("userid", userno);
		paramMap.put("useYn", requestMap.getString("use_yn"));
		
		paramMap.put("qfile", qfile);
		paramMap.put("qfileRn", qfileRn);
		paramMap.put("qfileTp", qfileTp);
		paramMap.put("ex1file", ex1file);
		paramMap.put("ex1fileRn", ex1fileRn);
		paramMap.put("ex1fileTp", ex1fileTp);
		paramMap.put("ex2file", ex2file);
		paramMap.put("ex2fileRn", ex2fileRn);
		paramMap.put("ex2fileTp", ex2fileTp);
		paramMap.put("ex3file", ex3file);
		paramMap.put("ex3fileRn", ex3fileRn);
		paramMap.put("ex3fileTp", ex3fileTp);
		paramMap.put("ex4file", ex4file);
		paramMap.put("ex4fileRn", ex4fileRn);
		paramMap.put("ex4fileTp", ex4fileTp);
		paramMap.put("ex5file", ex5file);
		paramMap.put("ex5fileRn", ex5fileRn);
		paramMap.put("ex5fileTp", ex5fileTp);
		paramMap.put("xfile", xfile);
		paramMap.put("xfileRn", xfileRn);
		paramMap.put("xfileTp", xfileTp);
		paramMap.put("hfile", hfile);
		paramMap.put("hfileRn", hfileRn);
		paramMap.put("hfileTp", hfileTp);
		
		result = questionMgrService.insertQuestion(paramMap);
		
		if (result > 0) {
			msg = "저장되었습니다.";
			resultType = "sInsertOK";
		} else {
			msg = "저장에 실패하였습니다.";
			resultType = "sInsertError";
		}
		
		model.addAttribute("RESULT_MSG", msg);
		model.addAttribute("RESULT_TYPE", resultType);
		return "/baseCodeMgr/questionMgr/questionExec";
	}
	
	/**
	 * 단일 문항 수정
	 */
	@RequestMapping(value="/baseCodeMgr/questionMgr.do", params = "mode=sUpdate")
	public String sUpdate(@ModelAttribute("cm")CommonMap cm, Model model) throws BizException {
		DataMap requestMap = cm.getDataMap();
		requestMap.setNullToInitialize(true);
		
		Map<String, Object> paramMap = null;
		String msg = "";
		String resultType = "";
		int result = 0;
		
		String qfile = "", qfileRn = "", qfileTp = "";
		String ex1file = "", ex1fileRn = "", ex1fileTp = "";
		String ex2file = "", ex2fileRn = "", ex2fileTp = "";
		String ex3file = "", ex3fileRn = "", ex3fileTp = "";
		String ex4file = "", ex4fileRn = "", ex4fileTp = "";
		String ex5file = "", ex5fileRn = "", ex5fileTp = "";
		String xfile = "", xfileRn = "", xfileTp = "";
		String hfile = "", hfileRn = "", hfileTp = "";
		
		DataMap fileMap = (DataMap)requestMap.get("UPLOAD_FILE");
		
		if (fileMap != null) {
			fileMap.setNullToInitialize(true);
			
			if (fileMap.keySize("fileUploadOk") > 0) {
				if (fileMap.getLong("qfile_fileSize") > 0 ) {
					qfileRn = fileMap.getString("qfile_fileName");
					qfile = fileMap.getString("qfile_fileOrgName");
					qfileTp = requestMap.getString("qFileType");
				}
				switch (requestMap.getInt("qType")) {
				case 2:
					if (fileMap.getLong("ex21file_fileSize") > 0) {
						ex1fileRn = fileMap.getString("ex21file_fileName");
						ex1file = fileMap.getString("ex21file_fileOrgName");
						ex1fileTp = requestMap.getString("ex21FileType");
					}
					if (fileMap.getLong("ex22file_fileSize") > 0 ) {
						ex2fileRn = fileMap.getString("ex22file_fileName");
						ex2file = fileMap.getString("ex22file_fileOrgName");
						ex2fileTp = requestMap.getString("ex22FileType");
					}
					if (fileMap.getLong("ex23file_fileSize") > 0  && requestMap.getInt("excount2") >= 3) {
						ex3fileRn = fileMap.getString("ex23file_fileName");
						ex3file = fileMap.getString("ex23file_fileOrgName");
						ex3fileTp = requestMap.getString("ex23FileType");
					}
					if (fileMap.getLong("ex24file_fileSize") > 0  && requestMap.getInt("excount2") >= 4) {
						ex4fileRn = fileMap.getString("ex24file_fileName");
						ex4file = fileMap.getString("ex24file_fileOrgName");
						ex4fileTp = requestMap.getString("ex24FileType");
					}
					if (fileMap.getLong("ex25file_fileSize") > 0  && requestMap.getInt("excount2") >= 5) {
						ex5fileRn = fileMap.getString("ex25file_fileName");
						ex5file = fileMap.getString("ex25file_fileOrgName");
						ex5fileTp = requestMap.getString("ex25FileType");
					}
					break;
				case 3:
					if (fileMap.getLong("ex31file_fileSize") > 0) {
						ex1fileRn = fileMap.getString("ex31file_fileName");
						ex1file = fileMap.getString("ex31file_fileOrgName");
						ex1fileTp = requestMap.getString("ex31FileType");
					}
					if (fileMap.getLong("ex32file_fileSize") > 0 ) {
						ex2fileRn = fileMap.getString("ex32file_fileName");
						ex2file = fileMap.getString("ex32file_fileOrgName");
						ex2fileTp = requestMap.getString("ex32FileType");
					}
					if (fileMap.getLong("ex33file_fileSize") > 0  && requestMap.getInt("excount3") >= 3) {
						ex3fileRn = fileMap.getString("ex33file_fileName");
						ex3file = fileMap.getString("ex33file_fileOrgName");
						ex3fileTp = requestMap.getString("ex33FileType");
					}
					if (fileMap.getLong("ex34file_fileSize") > 0  && requestMap.getInt("excount3") >= 4) {
						ex4fileRn = fileMap.getString("ex34file_fileName");
						ex4file = fileMap.getString("ex34file_fileOrgName");
						ex4fileTp = requestMap.getString("ex34FileType");
					}
					if (fileMap.getLong("ex35file_fileSize") > 0  && requestMap.getInt("excount3") >= 5) {
						ex5fileRn = fileMap.getString("ex35file_fileName");
						ex5file = fileMap.getString("ex35file_fileOrgName");
						ex5fileTp = requestMap.getString("ex35FileType");
					}
					break;
				case 4:
					if (fileMap.getLong("ex41file_fileSize") > 0) {
						ex1fileRn = fileMap.getString("ex41file_fileName");
						ex1file = fileMap.getString("ex41file_fileOrgName");
						ex1fileTp = requestMap.getString("ex41FileType");
					}
					break;
				case 5:
					if (fileMap.getLong("ex51file_fileSize") > 0) {
						ex1fileRn = fileMap.getString("ex51file_fileName");
						ex1file = fileMap.getString("ex51file_fileOrgName");
						ex1fileTp = requestMap.getString("ex51FileType");
					}
					break;
					default:
						break;
				}
				if (fileMap.getLong("xfile_fileSize") > 0 ) {
					xfileRn = fileMap.getString("xfile_fileName");		
					xfile = fileMap.getString("xfile_fileOrgName");
					xfileTp = requestMap.getString("xFileType");
				}
				if (fileMap.getLong("hfile_fileSize") > 0 ) {
					hfileRn = fileMap.getString("hfile_fileName");		
					hfile = fileMap.getString("hfile_fileOrgName");
					hfileTp = requestMap.getString("hFileType");
				}
			}
		}
		
		DataMap rowMap = null;
		rowMap = questionMgrService.selectChapter(requestMap.getString("subj"));
		
		LoginInfo loginInfo = (LoginInfo)cm.getRequest().getAttribute("LOGIN_INFO");
		String userno = loginInfo.getSessNo();
		
		paramMap = new HashMap<String, Object>();
		paramMap.put("idQ", requestMap.getString("idQ"));
		paramMap.put("idCourse", rowMap.getString("idCourse"));
		paramMap.put("idSubject", rowMap.getString("idSubject"));
		paramMap.put("idChapter", rowMap.getString("idChapter"));
		paramMap.put("chapter", rowMap.getString("chapter"));
		paramMap.put("idDifficulty1", requestMap.getString("difficulty"));
		paramMap.put("q", requestMap.getString("question"));
		
		StringBuffer sbParam = null;
		StringBuffer sbRequest = null;
		switch (requestMap.getInt("idQtype")) {
		case 1:
			paramMap.put("ex1", "O");
			paramMap.put("ex2", "X");
			paramMap.put("ex3", "");
			paramMap.put("ex4", "");
			paramMap.put("ex5", "");
			paramMap.put("cacount", 1);
			paramMap.put("ca", requestMap.getString("exOX"));
			break;
		case 2:
			paramMap.put("cacount", 1);
			for(int i=1; i<=5; i++) {
				sbParam = new StringBuffer();
				sbRequest = new StringBuffer();
				sbParam.append("ex").append(String.valueOf(i));
				sbRequest.append("ex2").append(String.valueOf(i));
				if (requestMap.getInt("excount") >= i) {
					paramMap.put(sbParam.toString(), requestMap.getString(sbRequest.toString()));
				} else {
					paramMap.put(sbParam.toString(), "");
				}
			}
			paramMap.put("ca", requestMap.getString("ca2"));
			break;
		case 3:
			for(int i=1; i<=5; i++) {
				sbParam = new StringBuffer();
				sbRequest = new StringBuffer();
				sbParam.append("ex").append(String.valueOf(i));
				sbRequest.append("ex3").append(String.valueOf(i));
				if (requestMap.getInt("excount") >= i) {
					paramMap.put(sbParam.toString(), requestMap.getString(sbRequest.toString()));
				} else {
					paramMap.put(sbParam.toString(), "");
				}
			}
			StringBuffer sbCa = new StringBuffer();
			int caCount = 0;
			for(int i=0; i<requestMap.keySize("ca3[]"); i++) {
				if (requestMap.getInt("ca3[]", i) <= requestMap.getInt("excount")) {
					if (i == 0) {
						sbCa.append(requestMap.getString("ca3[]", i));
						caCount++;
					} else {
						sbCa.append("{|}");
						sbCa.append(requestMap.getString("ca3[]", i));
						caCount++;
					}
				}
			}
			paramMap.put("ca", sbCa.toString());
			paramMap.put("cacount", caCount);
			break;
		case 4:
			paramMap.put("ex1", "");
			paramMap.put("ex2", "");
			paramMap.put("ex3", "");
			paramMap.put("ex4", "");
			paramMap.put("ex5", "");
			paramMap.put("cacount", 1);
			paramMap.put("ca", requestMap.getString("ca4"));
			break;
		case 5:
			paramMap.put("ex1", "");
			paramMap.put("ex2", "");
			paramMap.put("ex3", "");
			paramMap.put("ex4", "");
			paramMap.put("ex5", "");
			paramMap.put("cacount", 0);
			paramMap.put("ca", requestMap.getString("ca5"));
			break;
			default:
				break;
		}
		paramMap.put("explain", requestMap.getString("explain"));
		paramMap.put("hint", requestMap.getString("hint"));
		paramMap.put("userid", userno);
		paramMap.put("useYn", requestMap.getString("use_yn"));
		
		paramMap.put("qfile", qfile);
		paramMap.put("qfileRn", qfileRn);
		paramMap.put("qfileTp", qfileTp);
		paramMap.put("ex1file", ex1file);
		paramMap.put("ex1fileRn", ex1fileRn);
		paramMap.put("ex1fileTp", ex1fileTp);
		paramMap.put("ex2file", ex2file);
		paramMap.put("ex2fileRn", ex2fileRn);
		paramMap.put("ex2fileTp", ex2fileTp);
		paramMap.put("ex3file", ex3file);
		paramMap.put("ex3fileRn", ex3fileRn);
		paramMap.put("ex3fileTp", ex3fileTp);
		paramMap.put("ex4file", ex4file);
		paramMap.put("ex4fileRn", ex4fileRn);
		paramMap.put("ex4fileTp", ex4fileTp);
		paramMap.put("ex5file", ex5file);
		paramMap.put("ex5fileRn", ex5fileRn);
		paramMap.put("ex5fileTp", ex5fileTp);
		paramMap.put("xfile", xfile);
		paramMap.put("xfileRn", xfileRn);
		paramMap.put("xfileTp", xfileTp);
		paramMap.put("hfile", hfile);
		paramMap.put("hfileRn", hfileRn);
		paramMap.put("hfileTp", hfileTp);
		
		result = questionMgrService.updateQuestion(paramMap);
		
		if (result > 0) {
			msg = "저장되었습니다.";
			resultType = "sUpdateOK";
		} else {
			msg = "저장에 실패하였습니다.";
			resultType = "sUpdateError";
		}
		
		model.addAttribute("RESULT_MSG", msg);
		model.addAttribute("RESULT_TYPE", resultType);
		
		return "/baseCodeMgr/questionMgr/questionExec";
	}
	
	/**
	 * 직급구분코드관리 일괄 입력
	 */	
	@RequestMapping(value="/baseCodeMgr/questionMgr.do", params = "mode=excelUpload")
	public String excelUpload(@ModelAttribute("cm")CommonMap cm, Model model) throws BizException {
		return "/baseCodeMgr/questionMgr/questionUpload";
	}
	
	/**
	 * 문항 등록 - 엑셀 일괄 등록
	 */
	@Transactional
	@RequestMapping(value="/baseCodeMgr/questionMgr.do", params = "mode=mInsert")
	public String mInsert(@ModelAttribute("cm")CommonMap cm, Model model) throws BizException {
		DataMap requestMap = cm.getDataMap();
		requestMap.setNullToInitialize(true);
		
		Map<String, Object> paramMap = null;
		StringBuffer sb = null;
		String msg = "";
		int result = 0;
		
		DataMap rowMap = null;
		rowMap = questionMgrService.selectChapter(requestMap.getString("subj"));
		
		if (rowMap.keySize("idCourse") == 0) {
			result = 0;
			
			paramMap = new HashMap<String, Object>();
			paramMap.put("idCourse", requestMap.getString("subj"));
			paramMap.put("idSubject", requestMap.getString("subj"));
			paramMap.put("chapter", requestMap.getString("subjnm"));
			paramMap.put("chapterOrder", 1);
			paramMap.put("courseCode", requestMap.getString("subj"));
			
			result = questionMgrService.insertChapter(paramMap);
			
			rowMap = questionMgrService.selectChapter(requestMap.getString("subj"));
		}
		
		result = 0;
		LoginInfo loginInfo = (LoginInfo)cm.getRequest().getAttribute("LOGIN_INFO");
		String userno = loginInfo.getSessNo();
		
		Workbook workbook = null;
		Sheet sheet = null;
		
		try {
			DataMap fileMap = (DataMap)requestMap.get("UPLOAD_FILE");
			if(fileMap == null) fileMap = new DataMap();
			fileMap.setNullToInitialize(true);
			
			sb = new StringBuffer();
			sb.append(SpringUtils.getRealPath()).append(Constants.UPLOAD).append(fileMap.getString("file_filePath")).append(fileMap.getString("file_fileName"));
			String root = sb.toString();
			
			//엑셀파일을 인식 
			workbook = Workbook.getWorkbook( new java.io.File(root));
			
			if( workbook != null) {
				//엑셀파일에서 첫번째 Sheet를 인식
				sheet = workbook.getSheet(0);
				
		    	if( sheet != null) {
		    		int sheetRowCnt = sheet.getRows();
		    		System.out.println(sheetRowCnt);
		    		
		    		if (sheetRowCnt > 1) {
			    		for(int i = 1; i < sheetRowCnt; i++ ) {
			    			paramMap = new HashMap<String, Object>();
			    			paramMap.put("idCourse", rowMap.getString("idCourse"));
			    			paramMap.put("idSubject", rowMap.getString("idSubject"));
			    			paramMap.put("idChapter", rowMap.getString("idChapter"));
			    			paramMap.put("chapter", rowMap.getString("chapter"));
			    			paramMap.put("userid", userno);
			    			paramMap.put("useYn", "Y");
			    			
			    			Cell[] cells = sheet.getRow(i);
			    			
			    			String qType = "";
			    			try {
			    				qType = cells[0].getContents();
			    			} catch(Exception e) {
			    				qType = "";
			    			}
			    			
			    			String difficulty = "";
			    			try {
			    				difficulty = cells[1].getContents();
			    			} catch(Exception e) {
			    				difficulty = "";
			    			}
			    			
			    			String q = "";
			    			try {
			    				q = cells[2].getContents();
			    			} catch(Exception e) {
			    				q = "";
			    			}
			    			
			    			String ex1 = "";
			    			try {
			    				ex1 = cells[3].getContents();
			    			} catch(Exception e) {
			    				ex1 = "";
			    			}
			    			
			    			String ex2 = "";
			    			try {
			    				ex2 = cells[4].getContents();
			    			} catch(Exception e) {
			    				ex2 = "";
			    			}
			    			
			    			String ex3 = "";
			    			try {
			    				ex3 = cells[5].getContents();
			    			} catch(Exception e) {
			    				ex3 = "";
			    			}
			    			
			    			String ex4 = "";
			    			try {
			    				ex4 = cells[6].getContents();
			    			} catch(Exception e) {
			    				ex4 = "";
			    			}
			    			
			    			String ex5 = "";
			    			try {
			    				ex5 = cells[7].getContents();
			    			} catch(Exception e) {
			    				ex5 = "";
			    			}
			    			
			    			String ca = "";
			    			try {
			    				ca = cells[8].getContents();
			    			} catch(Exception e) {
			    				ca = "";
			    			}
			    			
			    			String explain = "";
			    			try {
			    				explain = cells[9].getContents();
			    			} catch(Exception e) {
			    				explain = "";
			    			}
			    			
			    			String hint = "";
			    			try {
			    				hint = cells[10].getContents();
			    			} catch(Exception e) {
			    				hint = "";
			    			}
			    			
			    			if (qType.equals("")) {
			    				sb = new StringBuffer();
			    				sb.append(String.valueOf(i+1)).append("행의 문제유형을 입력해 주십시오!");
			    				msg = sb.toString();
			    				TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
			    				break;
			    			}
			    			
			    			if (difficulty.equals("")) {
			    				sb = new StringBuffer();
			    				sb.append(String.valueOf(i+1)).append("행의 난이도를 입력해 주십시오!");
			    				msg = sb.toString();
			    				TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
			    				break;
			    			}
			    			
			    			if (q.equals("")) {
			    				sb = new StringBuffer();
			    				sb.append(String.valueOf(i+1)).append("행의 문항을 입력해 주십시오!");
			    				msg = sb.toString();
			    				TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
			    				break;
			    			}
			    			
			    			paramMap.put("q", q);
			    			
			    			if (qType.equals("OX형")) {
			    				paramMap.put("idQtype", 1);
			    				if (ex1.equals("")) {
			    					sb = new StringBuffer();
				    				sb.append(String.valueOf(i+1)).append("행의 보기1을 입력해 주십시오!");
				    				msg = sb.toString();
				    				TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
				    				break;
			    				}
			    				if (ex2.equals("")) {
			    					sb = new StringBuffer();
				    				sb.append(String.valueOf(i+1)).append("행의 보기2를 입력해 주십시오!");
				    				msg = sb.toString();
				    				TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
				    				break;
			    				}
			    				paramMap.put("ex1", ex1);
			    				paramMap.put("ex2", ex2);
			    				paramMap.put("ex3", "");
			    				paramMap.put("ex4", "");
			    				paramMap.put("ex5", "");
			    				paramMap.put("excount", 2);
			    				paramMap.put("cacount", 1);
			    				if (ca.equals("") || Integer.parseInt(ca) > 2) {
			    					sb = new StringBuffer();
				    				sb.append(String.valueOf(i+1)).append("행의 정답이 잘못되었습니다.!");
				    				msg = sb.toString();
				    				TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
				    				break;
			    				}
			    			} else if (qType.equals("선다형")) {
			    				paramMap.put("idQtype", 2);
			    				if (ex1.equals("")) {
			    					sb = new StringBuffer();
				    				sb.append(String.valueOf(i+1)).append("행의 보기1을 입력해 주십시오!");
				    				msg = sb.toString();
				    				TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
				    				break;
			    				}
			    				if (ex2.equals("")) {
			    					sb = new StringBuffer();
				    				sb.append(String.valueOf(i+1)).append("행의 보기2를 입력해 주십시오!");
				    				msg = sb.toString();
				    				TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
				    				break;
			    				}
			    				paramMap.put("ex1", ex1);
			    				paramMap.put("ex2", ex2);
			    				paramMap.put("ex3", ex3);
			    				paramMap.put("ex4", ex4);
			    				paramMap.put("ex5", ex5);
			    				
			    				int excount = 0;
			    				for(int j=3; j<=7; j++) {
			    					if (!cells[j].getContents().equals("")) {
			    						excount++;
			    					}
			    				}
			    				paramMap.put("excount", excount);
			    				if (ca.equals("") || Integer.parseInt(ca) > excount) {
			    					sb = new StringBuffer();
				    				sb.append(String.valueOf(i+1)).append("행의 정답이 잘못되었습니다.!");
				    				msg = sb.toString();
				    				TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
				    				break;
			    				}
			    				paramMap.put("cacount", 1);
			    			} else if (qType.equals("복수 답안형")) {
			    				paramMap.put("idQtype", 3);
			    				if (ex1.equals("")) {
			    					sb = new StringBuffer();
				    				sb.append(String.valueOf(i+1)).append("행의 보기1을 입력해 주십시오!");
				    				msg = sb.toString();
				    				TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
				    				break;
			    				}
			    				if (ex2.equals("")) {
			    					sb = new StringBuffer();
				    				sb.append(String.valueOf(i+1)).append("행의 보기2를 입력해 주십시오!");
				    				msg = sb.toString();
				    				TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
				    				break;
			    				}
			    				paramMap.put("ex1", ex1);
			    				paramMap.put("ex2", ex2);
			    				paramMap.put("ex3", ex3);
			    				paramMap.put("ex4", ex4);
			    				paramMap.put("ex5", ex5);
			    				int excount = 0;
			    				for(int j=3; j<=7; j++) {
			    					if (!cells[j].getContents().equals("")) {
			    						excount++;
			    					}
			    				}
			    				paramMap.put("excount", excount);
			    				
			    				int cacount = 0;
			    				if (!ca.equals("")) {
				    				for(int j=0; j<ca.length(); j++) {
				    					char ch = ca.charAt(j);
				    					if (ch == '1' || ch == '2' || ch == '3' || ch == '4' || ch == '5') {
				    						if (Integer.parseInt(String.valueOf(ch)) > excount) {
				    							sb = new StringBuffer();
							    				sb.append(String.valueOf(i+1)).append("행의 정답이 잘못되었습니다.!");
							    				msg = sb.toString();
							    				TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
							    				break;
				    						} else {
				    							cacount++;
				    						}
				    					} else {
				    						if (ch != '{' && ch != '|' && ch != '}') {
				    							sb = new StringBuffer();
							    				sb.append(String.valueOf(i+1)).append("행의 정답이 잘못되었습니다.!");
							    				msg = sb.toString();
							    				TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
							    				break;
				    						}
				    					}
				    				}
			    				}
			    				
			    				if (!msg.equals("")) {
		    						break;
		    					}
		    					
		    					if (cacount > excount) {
		    						sb = new StringBuffer();
				    				sb.append(String.valueOf(i+1)).append("행의 정답이 잘못되었습니다.!");
				    				msg = sb.toString();
				    				TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
				    				break;
		    					}
		    					
			    				paramMap.put("cacount", cacount);
			    			} else if (qType.equals("단답형")) {
			    				paramMap.put("idQtype", 4);
			    				paramMap.put("ex1", "");
			    				paramMap.put("ex2", "");
			    				paramMap.put("ex3", "");
			    				paramMap.put("ex4", "");
			    				paramMap.put("ex5", "");
			    				paramMap.put("excount", 0);
			    				paramMap.put("cacount", 1);
			    				
			    				if (ca.equals("")) {
				    				sb = new StringBuffer();
				    				sb.append(String.valueOf(i+1)).append("행의 정답을 입력해 주십시오!");
				    				msg = sb.toString();
				    				TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
				    				break;
				    			}
			    			} else if (qType.equals("논술형")) {
			    				paramMap.put("idQtype", 5);
			    				paramMap.put("ex1", "");
			    				paramMap.put("ex2", "");
			    				paramMap.put("ex3", "");
			    				paramMap.put("ex4", "");
			    				paramMap.put("ex5", "");
			    				paramMap.put("excount", 0);
			    				paramMap.put("cacount", 1);
			    				
			    				if (ca.equals("")) {
				    				sb = new StringBuffer();
				    				sb.append(String.valueOf(i+1)).append("행의 정답을 입력해 주십시오!");
				    				msg = sb.toString();
				    				TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
				    				break;
				    			}
			    			}
			    			
			    			if (difficulty.equals("없음")) {
			    				paramMap.put("idDifficulty1", 0);
			    			} else if (difficulty.equals("최상")) {
			    				paramMap.put("idDifficulty1", 1);
			    			} else if (difficulty.equals("상")) {
			    				paramMap.put("idDifficulty1", 2);
			    			} else if (difficulty.equals("중")) {
			    				paramMap.put("idDifficulty1", 3);
			    			} else if (difficulty.equals("하")) {
			    				paramMap.put("idDifficulty1", 4);
			    			} else if (difficulty.equals("최하")) {
			    				paramMap.put("idDifficulty1", 5);
			    			}
			    			
			    			paramMap.put("ca", ca);
			    			paramMap.put("explain", explain);
			    			paramMap.put("hint", hint);
			    			
			    			paramMap.put("qfile", "");
			    			paramMap.put("ex1file", "");
			    			paramMap.put("ex2file", "");
			    			paramMap.put("ex3file", "");
			    			paramMap.put("ex4file", "");
			    			paramMap.put("ex5file", "");
			    			
			    			result = questionMgrService.insertQuestion(paramMap);
			    		}
		    		} else {
		    			msg = "등록할 내용이 없습니다.";
		    		}
		    	} else {
		    		System.out.println( "Sheet is null!!" );
		    	}
		    }
		} catch( Exception e) {	
			msg = "엑셀 데이터가 잘못 입력 되었습니다. 다시 확인하신 후 등록하여 주십시오.";
			TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
		    e.printStackTrace();
		} finally {
		    if( workbook != null) {
		        workbook.close();
		    }
		}
		
		if (msg.equals("")) {
			sb = new StringBuffer();
			if (result > 0) {
				msg = "저장되었습니다.";
			} else {
				sb.append("저장에 실패하였습니다.");
				msg = sb.toString();
			}
		}
		
		requestMap.setString("msg", msg);
		
		return "/baseCodeMgr/questionMgr/questionMsg";
	}
}
