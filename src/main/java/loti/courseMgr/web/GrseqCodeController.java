package loti.courseMgr.web;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import loti.courseMgr.service.GrseqCodeService;

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
import ut.lib.util.Util;
import common.controller.BaseController;

@Controller
public class GrseqCodeController extends BaseController {

	@Autowired
	private GrseqCodeService grseqCodeService;
	
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
			
			model.addAttribute("REQUEST_DATA", requestMap);
			model.addAttribute("LOGIN_INFO", memberInfo);
		} catch (Exception e) {
			throw new BizException(e);
		} finally {
			
		}
		
		return cm;
	}
	
	/**
	 * 기수 코드 관리 리스트.
	 */
	@RequestMapping(value="/courseMgr/grseqCode.do", params = "mode=list")
	public String list(@ModelAttribute("cm")CommonMap cm, Model model) throws BizException {
		DataMap requestMap = cm.getDataMap();
		requestMap.setNullToInitialize(true);
		
		//사용자 정보 추출.
		LoginInfo loginInfo = (LoginInfo)cm.getRequest().getAttribute("LOGIN_INFO");
		
		//리스트
		DataMap listMap = grseqCodeService.selectGrseqMngList(requestMap.getString("commYear"), loginInfo.getSessDept());

		model.addAttribute("LIST_DATA", listMap);
		
		return "/courseMgr/grseqCode/grseqCodeList";
	}
	
	/**
	 * 기수 코드 관리 등록/수정 폼.
	 */
	@RequestMapping(value="/courseMgr/grseqCode.do", params = "mode=form")
	public String form(@ModelAttribute("cm")CommonMap cm, Model model) throws BizException {
		DataMap requestMap = cm.getDataMap();
		requestMap.setNullToInitialize(true);
		
		//사용자 정보 추출.
		LoginInfo loginInfo = (LoginInfo)cm.getRequest().getAttribute("LOGIN_INFO");
		
		//기수 코드 정보
		DataMap rowMap = null;
		
		if(requestMap.getString("qu").equals("insert")){
			//추가할 기수 번호 생성.
			requestMap.setString("seq", Util.plusZero(grseqCodeService.selectGrseqMngMaxSeq(requestMap.getString("year"), Util.getValue(loginInfo.getSessDept(), ""))));
			rowMap = new DataMap();
		}else if(requestMap.getString("qu").equals("update")){
			rowMap = grseqCodeService.selectGrseqMngRow(requestMap.getString("year")+requestMap.getString("seq"), loginInfo.getSessDept());
		}
		model.addAttribute("ROW_DATA", rowMap);
		
		return "/courseMgr/grseqCode/grseqCodeFormPop";
	}
	
	/**
	 * 기수 코드 등록/수정/삭제 실행.
	 */
	@RequestMapping(value="/courseMgr/grseqCode.do", params = "mode=exec")
	public String exec(@ModelAttribute("cm")CommonMap cm, Model model) throws BizException {
		DataMap requestMap = cm.getDataMap();
		requestMap.setNullToInitialize(true);
		
		//사용자 정보 추출.
		LoginInfo loginInfo = (LoginInfo)cm.getRequest().getAttribute("LOGIN_INFO");
		
		String msg = ""; //결과 메세지.
		int result = 0;
		
		if(requestMap.getString("qu").equals("insert")){ //등록
			result = grseqCodeService.insertGrseqMng(loginInfo.getSessDept(), requestMap);
			
			if(result > 0){
				msg = requestMap.getString("year") + "년 " + Util.plusZero(result) + " 기수로 등록 되었습니다.";
			}else{
				msg = "실패";
			}
		}else if(requestMap.getString("qu").equals("update")){ //수정
			result = grseqCodeService.updateGrseqMng(loginInfo.getSessDept(), requestMap);
			
			if(result > 0)
				msg = "수정 되었습니다.";
			else
				msg = "실패";
		}else if(requestMap.getString("qu").equals("delete")){ //삭제
			result = grseqCodeService.deleteGrseqMng(loginInfo.getSessDept(), requestMap.getString("year")+requestMap.getString("seq"));
			
			if(result > 0)
				msg = "삭제 되었습니다.";
			else
				msg = "실패";
		}
		model.addAttribute("RESULT_MSG", msg);
		
		return "/courseMgr/grseqCode/grseqCodeExec";
	}
}
