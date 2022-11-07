package loti.courseMgr.web;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import loti.courseMgr.service.CompleteProgressService;
import loti.courseMgr.service.CourseSeqService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
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
public class CompleteProgressController extends BaseController {
	
	@Autowired
	private CompleteProgressService completeProgressService;
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
			if (requestMap.getString("commYear").equals("")) {
				requestMap.setString("commYear", (String)session.getAttribute("sess_year"));
			}
			if (requestMap.getString("commGrcode").equals("")) {
				requestMap.setString("commGrcode", (String)session.getAttribute("sess_grcode"));
			}
			if (requestMap.getString("commGrseq").equals("")) {
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
	 * 과정이수처리
	 */
	@RequestMapping(value="/courseMgr/complete.do", params = "mode=list")
	public String list(@ModelAttribute("cm") CommonMap cm, Model model) throws BizException {
		DataMap requestMap = cm.getDataMap();
		requestMap.setNullToInitialize(true);
		
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("grcode", requestMap.getString("commGrcode"));
		paramMap.put("grseq", requestMap.getString("commGrseq"));
		//과정 기수 정보.
		DataMap grseqMap = courseSeqService.selectGrseqSimpleRow(paramMap);
		
		int tmpInt = 0;
		
		//이수처리할 항목이 있는지 체크후 결과 담은 Map
		DataMap rowMap = new DataMap();
		rowMap.setNullToInitialize(true);
		
		if (!requestMap.getString("commGrcode").equals("") && !requestMap.getString("commGrcode").equals("")) {
			// 임시이수처리
			tmpInt = completeProgressService.selectSubjSeqCloseChkByAllSubj(paramMap);
			if (tmpInt > 0) {
				rowMap.setString("subjSeqCloseChkByAll", "Y");
			}
		
			//수료 처리할 과목이 있는지 체크 한다.
			tmpInt = completeProgressService.selectSubjSeqCloseChk(paramMap);
			if (tmpInt == 0) {
				rowMap.setString("subjSeqCloseYn", "Y");
			}
			
			// 수료임시처리
			tmpInt = completeProgressService.selectGrseqCloseYesChk(paramMap);
			if (tmpInt > 0) {
				rowMap.setString("grseqCloseYesCh", "Y");
			}
			
			//수료처리 완료 여부 체크
			tmpInt = completeProgressService.selectGrseqCloseChk(paramMap);
			if (tmpInt == 0) {
				rowMap.setString("grseqCloseYn", "Y");
			}
			
		}
		
		model.addAttribute("GRSEQ_ROW_DATA", grseqMap);
		model.addAttribute("ROW_DATA", rowMap);
		
		return "/courseMgr/complete/complete";
	}
	
	/**
	 * 과정이수처리 실행
	 */
	@RequestMapping(value="/courseMgr/complete.do", params = "mode=exec")
	@Transactional
	public String exec(@ModelAttribute("cm") CommonMap cm, Model model) throws BizException {
		DataMap requestMap = cm.getDataMap();
		requestMap.setNullToInitialize(true);
		
		//사용자 정보 추출.
		LoginInfo loginInfo = (LoginInfo)cm.getRequest().getAttribute("LOGIN_INFO");
		
		String grcode = requestMap.getString("grcode");
		String grseq = requestMap.getString("grseq");
		String qu = requestMap.getString("qu");
		
		String msg = "";
		
		int tmpInt = 0;
		
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("grcode", grcode);
		paramMap.put("grseq", grseq);
		paramMap.put("luserno", loginInfo.getSessNo());
		paramMap.put("closing", requestMap.getString("closing"));
		if (qu.equals("act1")) {  //임시이수처리 실행
			//수강생 존재 여부 확인.
			if (courseSeqService.selectStuLecCnt(paramMap) == 0 ) {
				msg = "선정 대상자가 없습니다.";
			} else if (completeProgressService.selectSubjSeqCloseChkByAllSubj(paramMap) > 0 ) {//이수처리 완결 상태인 과목 확인.
				msg = "이수처리 완결 상태인 과목이 있습니다. 일괄 임시이수처리 할 수 없습니다.";
			} else {
				//임시 이수처리 실행
				tmpInt = completeProgressService.execSubjTempCompletion(paramMap);
				if(tmpInt == -1) {
					msg = "이미 이수처리 완결 상태 입니다.";
				} else if(tmpInt > 0) {
					msg = "임시이수처리 되었습니다.";
				} else {
					msg = "실패";
				}
			}
		} else if(qu.equals("act2")) { //전체과목 이수처리
			//임시 이수처리 실행
			tmpInt = completeProgressService.execSubjCompletion(paramMap);
			if(tmpInt == -1) {
				msg = "이미 이수처리 완결 상태 입니다.";
			} else if(tmpInt > 0) {
				msg = "이수처리완료 되었습니다.";
			} else {
				msg = "실패";
			}
		} else if(qu.equals("act3")) {  //전체과목 이수처리 완결 취소
			if(courseSeqService.selectSubjAllResultCnt(requestMap) == 0) {
				msg = "취소처리할 이수결과가 없습니다.";
			} else{
				tmpInt = completeProgressService.execSubjCompletionCancel(paramMap); //
				
				if(tmpInt > 0) {
					msg = "이수처리완료 취소되었습니다.";
				} else {
					msg = "실패";
				}
			}
		} else if(qu.equals("act4")) {  //수료임시처리
			if (courseSeqService.selectStuLecCnt(paramMap) == 0 ) {
				msg = "선정 대상자가 없습니다.";
			} else if (completeProgressService.selectSubjSeqBySubjTypeCloseChk(paramMap) > 0 ) { //이수처리 완결 상태인 과목 확인.
				msg = "이수처리 완료되지 않은 온라인과목이 있습니다. 확인후 처리하십시요.";
			} else if (completeProgressService.selectGrseqCloseYesChk(paramMap) > 0 ) { //이수처리 완결 상태인 과목 확인.
				msg = "수료처리 완결 상태입니다.시스템 관리자에게 요청하십시요.";
			} else {
				tmpInt = completeProgressService.execGrseqTempCompletion(paramMap); //

				if (tmpInt > 0) {
					if(requestMap.getString("closing").equals("Y"))
						msg = "수료처리완료 되었습니다.";
					else
						msg = "임시수료처리 되었습니다.";
				} else {
					msg = "실패";
				}
			}
		} else if(qu.equals("act6")) {  //수료처리완료 취소
			if (courseSeqService.selectGrResultCnt(requestMap) == 0 ) {
				msg = "수료처리 취소할 대상자가 없습니다.";
			} else {
				tmpInt = completeProgressService.execGrseqCompletionCancel(paramMap); //
				if(tmpInt > 0) {
					msg = "수료처리완료 취소되었습니다.";
				} else {
					msg = "실패";
				}
			}
		}
		model.addAttribute("RESULT_MSG", msg);
		
		return "/courseMgr/complete/completeExec";
	}
}
