package loti.evalMgr.web;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import loti.evalMgr.service.ResultService;

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
public class ResultController extends BaseController {
	@Autowired
	private ResultService resultService;
	
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
			if(requestMap.getString("mode").equals("")) {
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
			if (requestMap.getString("commYear").equals("")) {
				requestMap.setString("commYear", (String)session.getAttribute("sess_year"));
			}
			if (requestMap.getString("commGrcode").equals("")) {
				requestMap.setString("commGrcode", (String)session.getAttribute("sess_grcode"));
			}
			if (requestMap.getString("commGrseq").equals("")) {
				requestMap.setString("commGrseq", (String)session.getAttribute("sess_grseq"));
			}
	        
			//평가결과 보고 상세정보1/상세정보2/자치리스트/성적우수자리스트
			DataMap resultData = resultService.selectResultList(requestMap);
			DataMap resultData2 = resultService.selectResultList2(requestMap); 
			DataMap jachiData = resultService.selectJachiList(requestMap);
			DataMap sungjukData = resultService.selectSungJukList(requestMap);
			
			model.addAttribute("RESULT_DATA", resultData);
			model.addAttribute("RESULT_DATA2", resultData2);
			model.addAttribute("JACHI_DATA", jachiData);
			model.addAttribute("SUNGJUK_DATA", sungjukData);
			
			model.addAttribute("REQUEST_DATA", requestMap);
			model.addAttribute("LOGIN_INFO", memberInfo);
		} catch (Exception e) {
			throw new BizException(e);
		} finally {
			
		}
		
		return cm;
	}
	
	@RequestMapping(value="/evalMgr/result.do", params = "mode=list")
	public String list(@ModelAttribute("cm")CommonMap cm, Model model) throws BizException {
		return "/evalMgr/result/result";
	}
}
