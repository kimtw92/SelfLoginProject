package loti.baseCodeMgr.web;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import loti.baseCodeMgr.service.GrCodeService;
import loti.baseCodeMgr.service.MainCodeService;

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
public class GrCodeController extends BaseController {
	
	@Autowired
	private GrCodeService grCodeService;
	@Autowired
	private MainCodeService mainCodeService;
	
	@ModelAttribute("cm")
	public CommonMap common(CommonMap cm
			              , Model model
			              , HttpServletRequest request
			              , HttpServletResponse response
			              , @RequestParam(value="mode", required=false, defaultValue="") String mode
			              , @RequestParam(value="menuId", required=false, defaultValue="") String menuId) throws BizException {
		
		try {
			//관리자 로그인 체크 (관리자 페이지에는 모두 있어야 함.)
			LoginInfo memberInfo = LoginCheck.adminCheck(request, response, menuId);
			if (memberInfo == null) {
				return null;
			}
			
			if (mode.equals("")) {
				mode = "list";
				cm.getDataMap().setString("mode", mode);
			}
			
			model.addAttribute("REQUEST_DATA", cm.getDataMap());
			model.addAttribute("LOGIN_INFO", memberInfo);
		} catch (Exception e) {
			throw new BizException(e);
		} finally {
			
		}
		
		return cm;
	}
	
	/**
	 * 코드 관리 리스트
	 */
	@RequestMapping(value="/baseCodeMgr/grCode.do", params = "mode=list")
	public String list(@ModelAttribute("cm") CommonMap cm, Model model) throws BizException {
		DataMap requestMap = cm.getDataMap();
		requestMap.setNullToInitialize(true);
		
		/**
		 * 페이징 필수
		 */
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
		
		DataMap listMap = null;
		listMap = grCodeService.selectGrCodeList(requestMap);
		
		model.addAttribute("LIST_DATA", listMap);
		
		return "/baseCodeMgr/grCode/grCodeList";
	}
	
	@RequestMapping(value="/baseCodeMgr/grCode.do", params = "mode=form")
	public String form(@ModelAttribute("cm") CommonMap cm, Model model) throws BizException {
		DataMap rowMap = null;
		
		DataMap requestMap = cm.getDataMap();
		if(requestMap.getString("qu").equals("insert")) {//등록
			rowMap = new DataMap();
		} else if(requestMap.getString("qu").equals("update")) {//수정
			rowMap = grCodeService.selectGrCodeRow(requestMap.getString("grcode"));
		} else { //그외(예외)
			rowMap = new DataMap();
		}
		
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("cdGubun", "G");
		paramMap.put("useYn", "Y");
		DataMap mainCodeListMap = (DataMap)mainCodeService.selectMainCodeGubunUseYnList(paramMap);
		
		model.addAttribute("ROW_DATA", rowMap);
		model.addAttribute("MAINCODE_LIST_DATA", mainCodeListMap);
		
		return "/baseCodeMgr/grCode/grCodeForm";
	}
	
	/**
	 * 메뉴 등록 실행.
	 */
	@RequestMapping(value="/baseCodeMgr/grCode.do", params = "mode=exec")
	public String exec(@ModelAttribute("cm") CommonMap cm, Model model) throws BizException {
		String msg = ""; //결과메시지
		
		LoginInfo loginInfo = (LoginInfo)cm.getRequest().getAttribute("LOGIN_INFO");
		
		DataMap requestMap = cm.getDataMap();
		
		requestMap.add("userNo", loginInfo.getSessNo());
		
		if(requestMap.getString("qu").equals("insert")) { //등록
			grCodeService.insertGrCode(requestMap);
			msg = "등록되었습니다.";
		} else if(requestMap.getString("qu").equals("update")){ //수정
			grCodeService.modifyGrCode(requestMap);
			msg = "수정되었습니다.";
		} else if(requestMap.getString("qu").equals("delete")){ //삭제.
			int result = grCodeService.deleteGrCode(requestMap.getString("grcode"));
			
			//결과 정보.
			if (result > 0) {
				msg = "삭제되었습니다.";
			} else if (result == -1) {
				msg = "해당 과정은 사용중에 있어서 삭제할수 없습니다.";
			} else if (result == 0) {
				msg = "에러.";
			}
		}
		
		model.addAttribute("RESULT_MSG", msg);
		
		return "/baseCodeMgr/grCode/grCodeExec";
	}
}
