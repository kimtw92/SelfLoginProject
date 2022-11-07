package loti.baseCodeMgr.web;

import java.util.Calendar;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import loti.baseCodeMgr.service.GrannaeService;
import loti.baseCodeMgr.service.GrCodeService;

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
public class GrannaeController extends BaseController {
	
	@Autowired
	private GrannaeService grannaeService;
	@Autowired
	private GrCodeService grCodeService;
	
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
			LoginInfo memberInfo = null;
			if (mode.equals("copy_form") || mode.equals("copy_exec")) {
				memberInfo = LoginCheck.adminCheckPopup(request, response);
			} else {
				memberInfo = LoginCheck.adminCheck(request, response, menuId);
			}
			
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
	 * 교육계획 리스트
	 */
	@RequestMapping(value="/baseCodeMgr/grannae.do", params = "mode=list")
	public String list(@ModelAttribute("cm") CommonMap cm, Model model) throws BizException {
		DataMap requestMap = cm.getDataMap();
		requestMap.setNullToInitialize(true);

		String year = requestMap.getString("year");
		
		//입력된 교육년도 없을시 현재 년도.
		if (year.equals("")) {
			year = Integer.toString(Calendar.getInstance().get(java.util.Calendar.YEAR));
			requestMap.setString("year", year);
		}
		
		//리스트
		DataMap listMap = (DataMap)grannaeService.selectGrAnnaeList(year);

		model.addAttribute("LIST_DATA", listMap);
		
		return "/baseCodeMgr/grannae/grannaeList";
	}
	
	/**
	 * 교육계획수정.
	 */
	@RequestMapping(value="/baseCodeMgr/grannae.do", params = "mode=view")
	public String view(@ModelAttribute("cm") CommonMap cm, Model model) throws BizException {
		form_view_com(cm, model);
		
		return "/baseCodeMgr/grannae/grannaeView";
	}
	
	/**
	 * 교육계획 등록/수정.
	 */
	@RequestMapping(value="/baseCodeMgr/grannae.do", params = "mode=form")
	public String form(@ModelAttribute("cm") CommonMap cm, Model model) throws BizException {
		form_view_com(cm, model);
		
		return "/baseCodeMgr/grannae/grannaeForm";
	}
	
	/**
	 * 교육계획 등록/수정.
	 */
	public void form_view_com(@ModelAttribute("cm") CommonMap cm, Model model) throws BizException {
		DataMap requestMap = cm.getDataMap();
		requestMap.setNullToInitialize(true);
		
		//과정정보.
		DataMap grRowMap = grCodeService.selectGrCodeRow(requestMap.getString("grcode"));
		
		DataMap grannaeMap = null; //교육계획 상세(TB_GRANNAE)
		DataMap grannae2Map = null; //교육계획 상세 소양/직무/행정 리스트(TB_GRANNAE2)
		DataMap grSeqMap = null; //과정 기수 정보.(기간별 인원 및 교육기간)
		
		if (requestMap.getString("qu").equals("insert")) { //등록
			grannaeMap = new DataMap();
			grannae2Map = new DataMap();
			grSeqMap = new DataMap();
		} else if(requestMap.getString("qu").equals("update")) {//수정
			grannaeMap = grannaeService.selectGrannaeRow(requestMap);
			grannae2Map = grannaeService.selectGrannae2List(requestMap);
			grSeqMap = grannaeService.selectGrSeqList(requestMap);
		} else { //미리보기 일경우.qu값이 들어오지 않음.
			grannaeMap = grannaeService.selectGrannaeRow(requestMap);
			grannae2Map = grannaeService.selectGrannae2List(requestMap);
			grSeqMap = grannaeService.selectGrSeqList(requestMap);
		}
		
		model.addAttribute("GR_ROW_DATA", grRowMap);
		model.addAttribute("GRANNAE_ROW_DATA", grannaeMap);
		model.addAttribute("GRANNAE2_LIST_DATA", grannae2Map);
		model.addAttribute("GRSEQ_ROW_DATA", grSeqMap);
	}
	
	/**
	 * 교육계획 등록/수정 실행.
	 */
	@RequestMapping(value="/baseCodeMgr/grannae.do", params = "mode=exec")
	public String exec(@ModelAttribute("cm") CommonMap cm, Model model) throws BizException {
		DataMap requestMap = cm.getDataMap();
		requestMap.setNullToInitialize(true);
		
		String msg = ""; //결과 메세지.
		
		if(requestMap.getString("qu").equals("insert")){ //등록
			grannaeService.insertGrannae(requestMap);
			msg = "등록되었습니다.";
		}else if(requestMap.getString("qu").equals("update")){ //수정
			grannaeService.updateGrannae(requestMap);
			msg = "수정되었습니다.";
		}
		
		model.addAttribute("RESULT_MSG", msg);
		
		return "/baseCodeMgr/grannae/grannaeExec";
	}
	
	/**
	 * 교육계획 복사.
	 */
	@RequestMapping(value="/baseCodeMgr/grannae.do", params = "mode=copy_form")
	public String copy_form(@ModelAttribute("cm") CommonMap cm, Model model) throws BizException {
		DataMap requestMap = cm.getDataMap();
		requestMap.setNullToInitialize(true);
		
		//리스트
		DataMap listMap = grannaeService.selectGrannaeByPrevYearList(requestMap);

		model.addAttribute("LIST_DATA", listMap);
		
		return "/baseCodeMgr/grannae/grannaeCopyFormPop";
	}
	
	/**
	 * 교육계획 복사 실행.
	 */
	@RequestMapping(value="/baseCodeMgr/grannae.do", params = "mode=copy_exec")
	public String copy_exec(@ModelAttribute("cm") CommonMap cm, Model model) throws BizException {
		DataMap requestMap = cm.getDataMap();
		requestMap.setNullToInitialize(true);
		
		String msg = ""; //결과 메세지.
		
		if (requestMap.getString("qu").equals("ALL")) { //교육계획 전체.
			int result = grannaeService.insertGrannaeCopyAll(requestMap);
			msg = result+"건이 복사되었습니다.";
		} else if (requestMap.getString("qu").equals("ONE")) { //선택된 과정.
			int result = grannaeService.insertGrannaeCopy(requestMap);
			if(result > 0) {
				msg = "복사 되었습니다.";
			} else {
				msg = "선택하신 년도의 교육계획이 없습니다.";
			}
		}
		
		model.addAttribute("RESULT_MSG", msg);
		
		return "/baseCodeMgr/grannae/grannaeExec";
	}
}
