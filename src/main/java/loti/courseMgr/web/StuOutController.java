package loti.courseMgr.web;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import loti.courseMgr.service.CourseSeqService;
import loti.courseMgr.service.StuOutService;

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
import common.controller.BaseController;

@Controller("courseMgrStuOutController")
public class StuOutController extends BaseController {

	@Autowired
	@Qualifier("courseMgrStuOutService")
	private StuOutService stuOutService;
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
	 * 퇴교자 리스트.
	 */
	@RequestMapping(value="/courseMgr/stuOut.do", params = "mode=list")
	public String list(@ModelAttribute("cm")CommonMap cm, Model model) throws BizException {
		list_com(cm, model);
		list_com(cm, model); //원 소스에서 2번 동작하도록 되어 있어 구현함. 불필요한 경우 삭제
		
		return "/courseMgr/stuOut/stuOutList";
	}
	
	/**
	 * 퇴교자 리스트.
	 */
	@RequestMapping(value="/courseMgr/stuOut.do", params = "mode=result_list")
	public String result_list(@ModelAttribute("cm")CommonMap cm, Model model) throws BizException {
		list_com(cm, model);
		
		return "/courseMgr/stuOut/stuOutResultList";
	}
	
	/**
	 * 퇴교자 리스트.
	 */
	@RequestMapping(value="/courseMgr/stuOut.do", params = "mode=result_excel")
	public String result_excel(@ModelAttribute("cm")CommonMap cm, Model model) throws BizException {
		list_com(cm, model);
		
		return "/courseMgr/stuOut/stuOutResultByExcel";
	}
	
	/**
	 * 퇴교자 리스트. 공통
	 */
	public void list_com(@ModelAttribute("cm")CommonMap cm, Model model) throws BizException {
		DataMap requestMap = cm.getDataMap();
		requestMap.setNullToInitialize(true);
		
		//퇴교자 리스트.
		DataMap listMap = stuOutService.selectAppRejectList(requestMap.getString("commGrcode"), requestMap.getString("commGrseq"));
		
		//과정 기수 정보.
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("grcode", requestMap.getString("commGrcode"));
		paramMap.put("grseq", requestMap.getString("commGrseq"));
		
		DataMap grseqMap = courseSeqService.selectGrseqSimpleRow(paramMap);
		
		model.addAttribute("LIST_DATA", listMap);
		model.addAttribute("GRSEQ_ROW_DATA", grseqMap);
	}
	
	/**
	 * 상세 보기.
	 */
	@RequestMapping(value="/courseMgr/stuOut.do", params = "mode=view")
	public String view(@ModelAttribute("cm")CommonMap cm, Model model) throws BizException {
		DataMap requestMap = cm.getDataMap();
		requestMap.setNullToInitialize(true);
		
		//퇴교자 리스트.
		DataMap rowMap = stuOutService.selectAppRejectRow(requestMap.getString("commGrcode"), requestMap.getString("commGrseq"), requestMap.getString("userno"));
		
		//과정 기수 정보.
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("grcode", requestMap.getString("commGrcode"));
		paramMap.put("grseq", requestMap.getString("commGrseq"));
		
		DataMap grseqMap = courseSeqService.selectGrseqSimpleRow(paramMap);
		
		model.addAttribute("ROW_DATA", rowMap);
		model.addAttribute("GRSEQ_ROW_DATA", grseqMap);
		
		return "/courseMgr/stuOut/stuOutView";
	}
	
	/**
	 * 퇴교 처리 폼.
	 */
	@RequestMapping(value="/courseMgr/stuOut.do", params = "mode=form")
	public String form(@ModelAttribute("cm")CommonMap cm, Model model) throws BizException {
		DataMap requestMap = cm.getDataMap();
		requestMap.setNullToInitialize(true);
		
		//수강신청자 이름 검색 리스트.
		DataMap listMap = null;
		
		if(!requestMap.getString("searchName").equals(""))
			listMap = stuOutService.selectAppInfoByNameSearchList(requestMap.getString("commGrcode"), requestMap.getString("commGrseq"), requestMap.getString("searchName"));
		else
			listMap = new DataMap();
		
		//과정 기수 정보.
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("grcode", requestMap.getString("commGrcode"));
		paramMap.put("grseq", requestMap.getString("commGrseq"));
		
		DataMap grseqMap = courseSeqService.selectGrseqSimpleRow(paramMap);
		
		model.addAttribute("LIST_DATA", listMap);
		model.addAttribute("GRSEQ_ROW_DATA", grseqMap);
		
		return "/courseMgr/stuOut/stuOutForm";
	}

	/**
	 * 퇴교 등록/복원/완전삭제 실행.
	 */
	@RequestMapping(value="/courseMgr/stuOut.do", params = "mode=exec")
	public String exec(@ModelAttribute("cm")CommonMap cm, Model model) throws BizException {
		DataMap requestMap = cm.getDataMap();
		requestMap.setNullToInitialize(true);
		
		//사용자 정보 추출.
		LoginInfo loginInfo = (LoginInfo)cm.getRequest().getAttribute("LOGIN_INFO");
		requestMap.setString("luserno", loginInfo.getSessNo());	
		
		String msg = ""; //결과 메세지.
		
		if(requestMap.getString("qu").equals("out")){ //퇴교 처리.
			//수료처리된 이후에는 퇴교처리하지 못하도록 체크
			int result = stuOutService.selectGrResultChk(requestMap.getString("grcode"), requestMap.getString("grseq"), requestMap.getString("userno"));

			if(result > 0){
				msg = "이미 이수처리되어서 퇴교조치가 불가능합니다.";
			}else{
				//퇴교 조치.
				result = stuOutService.execInsertAppReject(requestMap);
				
				if(result > 0)
					msg = "퇴교 처리되었습니다.";
				else
					msg = "실패";
			}
		}else if(requestMap.getString("qu").equals("return")){ //복원
			//퇴교자 정보 완전 삭제.
			int result = stuOutService.execReturnAppReject(requestMap);
			
			if(result > 0)
				msg = "복원 처리되었습니다!";
			else
				msg = "실패";
		}else if(requestMap.getString("qu").equals("delete")){ //퇴교자 완전 삭제.
			//퇴교자 정보 완전 삭제.
			int result = stuOutService.execDeleteAppReject(requestMap);
			
			if(result > 0)
				msg = "삭제 처리되었습니다!";
			else
				msg = "실패";
		}
		
		model.addAttribute("RESULT_MSG", msg);
		
		return "/courseMgr/stuOut/stuOutExec";
	}
}
