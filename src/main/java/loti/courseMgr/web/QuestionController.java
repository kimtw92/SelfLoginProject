package loti.courseMgr.web;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import loti.common.service.CommonService;
import loti.courseMgr.service.QuestionService;

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
public class QuestionController extends BaseController {

	@Autowired
	private QuestionService questionService;
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
	 * 과정 질문 리스트.
	 */
	@RequestMapping(value="/courseMgr/question.do", params = "mode=list")
	public String list(@ModelAttribute("cm") CommonMap cm, Model model) throws BizException {
		DataMap requestMap = cm.getDataMap();
		requestMap.setNullToInitialize(true);
		
		if (requestMap.getString("currPage").equals(""))	requestMap.setInt("currPage", 1); //페이지
		if (requestMap.getString("rowSize").equals(""))		requestMap.setInt("rowSize", 7); //페이지당 보여줄 갯수
		if (requestMap.getString("pageSize").equals("")) 	requestMap.setInt("pageSize", 10); //페이지 블럭 갯수
		
		//리스트
		//DataMap listMap = service.selectGrSuggestionByHighList(requestMap.getString("commGrcode"), requestMap.getString("commGrseq"), requestMap);
		DataMap listMap = questionService.selectGrSuggestionByHighList(requestMap.getString("commGrcode"), requestMap.getString("grseq"), requestMap);
		
		model.addAttribute("REQUEST_DATA", requestMap);
		model.addAttribute("LIST_DATA", listMap);
		
		return "/courseMgr/question/questionList";
	}
	
	/**
	 * 과정 질문 상세 정보. (답변 포함)
	 */
	@RequestMapping(value="/courseMgr/question.do", params = "mode=view")
	public String view(@ModelAttribute("cm") CommonMap cm, Model model) throws BizException {
		DataMap requestMap = cm.getDataMap();
		requestMap.setNullToInitialize(true);
		
		DataMap rowMap = questionService.selectGrSuggestionRow(requestMap.getString("grcode"), requestMap.getString("grseq"), requestMap.getInt("no"), 0);
		//파일 정보 가져오기.
		try {
			commonService.selectUploadFileList(rowMap);
		} catch(Exception e) {
			throw new BizException(e);
		} finally {
			
		}
		
		//답변 내용 가져오기.
		if(rowMap == null) rowMap = new DataMap();
		rowMap.setNullToInitialize(true);
		DataMap replyMap = questionService.selectGrSuggestionByLowRow(rowMap.getString("grcode"), rowMap.getString("grseq"), rowMap.getInt("no"));
		//파일 정보 가져오기.
		try {
			commonService.selectUploadFileList(replyMap);
		} catch(Exception e) {
			throw new BizException(e);
		} finally {
			
		}
		
		model.addAttribute("ROW_DATA", rowMap);
		model.addAttribute("REPLY_ROW_DATA", replyMap);
		
		return "/courseMgr/question/questionView";
	}
	
	/**
	 * 과정 질문 등록, 수정 폼.
	 */
	@RequestMapping(value="/courseMgr/question.do", params = "mode=form")
	public String form(@ModelAttribute("cm") CommonMap cm, Model model) throws BizException {
		DataMap requestMap = cm.getDataMap();
		requestMap.setNullToInitialize(true);
		
		String qu = requestMap.getString("qu");
		
		DataMap rowMap = null;
		
		if(qu.equals("update")){ //질문 수정  폼
			rowMap = questionService.selectGrSuggestionRow(requestMap.getString("grcode"), requestMap.getString("grseq"), requestMap.getInt("no"), 0);
		}else if(qu.equals("reply_update")){ //답변 수정
			rowMap = questionService.selectGrSuggestionRow(requestMap.getString("grcode"), requestMap.getString("grseq"), requestMap.getInt("no"), 1);
		}else if(qu.equals("reply_insert")){ //답변 등록
			rowMap = new DataMap();
		}
		
		//파일 정보 가져오기.
		try {
			commonService.selectUploadFileList(rowMap);
		} catch(Exception e) {
			throw new BizException(e);
		} finally {
			
		}
		
		model.addAttribute("ROW_DATA", rowMap);
		
		return "/courseMgr/question/questionForm";
	}
	
	/**
	 * 과정 질문 수정/답변등록/답변수정 실행.
	 */
	@RequestMapping(value="/courseMgr/question.do", params = "mode=exec")
	public String exec(@ModelAttribute("cm") CommonMap cm, Model model) throws BizException {
		DataMap requestMap = cm.getDataMap();
		requestMap.setNullToInitialize(true);
		
		//사용자 정보 추출.
		LoginInfo loginInfo = (LoginInfo)cm.getRequest().getAttribute("LOGIN_INFO");
		
		// 결과 메세지.
		String msg = "";
		
		String qu = requestMap.getString("qu");
		
		//답변등록, 답변수정시만 파일업로드 처리.
		int fileGroupNo = -1;
		if(!qu.equals("update") && !qu.equals("delete")) {
			//파일 등록.
			DataMap fileMap = (DataMap)requestMap.get("UPLOAD_FILE");
			if(fileMap == null) fileMap = new DataMap();
			fileMap.setNullToInitialize(true);
			
			if(fileMap.keySize("fileSysName") > 0 || fileMap.keySize("existFile") > 0 || fileMap.keySize("deleteFile") > 0 || fileMap.keySize("fileUploadOk") > 0)
				fileGroupNo = commonService.insertInnoUploadFile(fileMap, requestMap.getString("INNO_SAVE_DIR"), loginInfo.getSessNo());
		}

		if(qu.equals("update")) { //수정
			int result = questionService.updateGrSuggestion(requestMap);
			
			if(result > 0) msg = "수정 되었습니다.";
			else msg = "수정 실패";
		} else if(qu.equals("reply_insert")) { //답변 등록
			requestMap.setInt("groupFileNo", fileGroupNo);
			requestMap.setString("userno", loginInfo.getSessNo());
			requestMap.setString("name", loginInfo.getSessName());
			
			int result = questionService.insertGrSuggestionByReply(requestMap);
			
			if(result > 0) msg = "등록 되었습니다.";
			else msg = "등록 실패";
		} else if(qu.equals("reply_update")) { //답변 수정
			requestMap.setInt("groupFileNo", fileGroupNo);
			requestMap.setString("userno", loginInfo.getSessNo());
			requestMap.setString("name", loginInfo.getSessName());
			
			int result = questionService.updateGrSuggestionByReply(requestMap);
			
			if(result > 0) msg = "수정 되었습니다.";
			else msg = "수정 실패";
		} else if("delete".equals(qu)) { //질문 및 답변 삭제
			int result = questionService.deleteGrSuggestion(requestMap);
			
			if(result > 0) msg = "삭제 되었습니다.";
			else msg = "삭제 실패";
		}
		model.addAttribute("RESULT_MSG", msg);
		
		return "/courseMgr/question/questionExec";
	}
}
