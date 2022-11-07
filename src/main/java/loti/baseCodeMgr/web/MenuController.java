package loti.baseCodeMgr.web;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import loti.baseCodeMgr.service.MenuService;

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
public class MenuController extends BaseController {
	
	@Autowired
	private MenuService menuService;
	
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
	 * 메뉴 리스트
	 */
	@RequestMapping(value="/baseCodeMgr/menu.do", params = "mode=list")
	public String list(@ModelAttribute("cm") CommonMap cm, Model model) throws BizException {
		DataMap requestMap = cm.getDataMap();
		requestMap.setNullToInitialize(true);
		
		//메뉴 리스트
		DataMap listMap = null;
		
		if (requestMap.getString("search").equals("GO") && !requestMap.getString("menuGrade").equals("")) {
			listMap = menuService.selectMenuList(requestMap.getString("menuGrade"));
		} else {
			listMap = new DataMap();
		}
		
		model.addAttribute("LIST_DATA", listMap);
		model.addAttribute("LIST_ADMIN_DATA", menuService.selectMenuAdminList()); //관리자 목록.
		
		return "/baseCodeMgr/menu/menuList";
	}
	
	@RequestMapping(value="/baseCodeMgr/menu.do", params = "mode=insert_exec")
	public String insertExec(@ModelAttribute("cm") CommonMap cm, Model model) throws BizException {
		exec(cm, model);
		return "/baseCodeMgr/menu/menuExec";
	}
	
	@RequestMapping(value="/baseCodeMgr/menu.do", params = "mode=modify_exec")
	public String modifyExec(@ModelAttribute("cm") CommonMap cm, Model model) throws BizException {
		exec(cm, model);
		return "/baseCodeMgr/menu/menuExec";
	}
	
	@RequestMapping(value="/baseCodeMgr/menu.do", params = "mode=delete_exec")
	public String deleteExec(@ModelAttribute("cm") CommonMap cm, Model model) throws BizException {
		exec(cm, model);
		return "/baseCodeMgr/menu/menuExec";
	}
	/**
	 * 메뉴 등록 실행.
	 */
	public void exec(@ModelAttribute("cm") CommonMap cm, Model model) throws BizException {
		DataMap requestMap = cm.getDataMap();
		requestMap.setNullToInitialize(true);
		
		String msg = "";
		String refresh = "Y";
		if(requestMap.getString("mode").equals("insert_exec")){ //등록 실행
			int result = menuService.insertMenu(requestMap);
			if (result > 0)
				msg = "등록 되었습니다.";
			else{
				msg = "메뉴 단계가 중복 되었습니다.";
				refresh = "N";
			}
		}else if(requestMap.getString("mode").equals("modify_exec")){ //수정
			menuService.modifyMenu(requestMap);
			msg = "수정 되었습니다.";
		}else if(requestMap.getString("mode").equals("delete_exec")){ //삭제
			menuService.deleteMenu(requestMap);
			msg = "삭제 되었습니다.";
		}
		
		model.addAttribute("RESULT_MSG", msg);
		model.addAttribute("RESULT_REFRESH", refresh);
		
	}
}
