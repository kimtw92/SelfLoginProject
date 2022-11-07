package loti.baseCodeMgr.web;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import loti.baseCodeMgr.service.DicService;
import loti.common.service.CommonService;

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
public class DicController extends BaseController {

	@Autowired
	private DicService dicService;
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
			
			mode = Util.getValue(requestMap.getString("mode"), "");
			
			LoginInfo memberInfo = null;
			//관리자 로그인 체크 (관리자 페이지에는 모두 있어야 함.)
			if (mode.equals("typeList") || mode.equals("dicList") || mode.equals("dicReg") || mode.equals("dicModify") || mode.equals("testList")) {
				memberInfo = LoginCheck.adminCheck(request, response, requestMap.getString("menuId"));
			} else {
				memberInfo = LoginCheck.adminCheckPopup(request, response);
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
	 * 용어분류 리스트
	 */
	@RequestMapping(value="/baseCodeMgr/dic.do", params = "mode=typeList")
	public String selectDicTypeList(@ModelAttribute("cm")CommonMap cm, Model model) throws BizException {
		DataMap requestMap = cm.getDataMap();
		requestMap.setNullToInitialize(true);
		
		DataMap listMap = null;				
		listMap = dicService.selectDicTypeList();
		
		model.addAttribute("LIST_DATA", listMap);
		
		return "/baseCodeMgr/dic/typeList";
	}
	
	@RequestMapping(value="/baseCodeMgr/dic.do", params = "mode=typeRegPop")
	public String typeRegPop(@ModelAttribute("cm")CommonMap cm, Model model) throws BizException {
		return "/baseCodeMgr/dic/typeFormPop";
	}
	
	/**
	 * 용어분류 Row 조회
	 */
	@RequestMapping(value="/baseCodeMgr/dic.do", params = "mode=typeModifyPop")
	public String selectDicTypeRow(@ModelAttribute("cm")CommonMap cm, Model model) throws BizException {
		DataMap requestMap = cm.getDataMap();
		requestMap.setNullToInitialize(true);
		
		DataMap rowMap = null;
		
		String types = requestMap.getString("types");	
		
		rowMap = dicService.selectDicTypeRow(types);
		
		model.addAttribute("ROW_DATA", rowMap);
		
		return "/baseCodeMgr/dic/typeFormPop";
	}
	
	/**
	 * 용어분류코드 중복 체크
	 * 0 : 중복없음, 1 이상 : 중복
	 */
	@RequestMapping(value="/baseCodeMgr/dic.do", params = "mode=typecheck")
	public String selectDicTypesCheck(@ModelAttribute("cm")CommonMap cm, Model model) throws BizException {
		DataMap requestMap = cm.getDataMap();
		requestMap.setNullToInitialize(true);
		
		DataMap rowMap = null;
		
		String types = requestMap.getString("types");		
		
		rowMap = dicService.selectDicTypesCheck(types);
		
		model.addAttribute("ROW_DATA", rowMap);
		
		return "/baseCodeMgr/dic/typeCheckByAjax";
	}
	
	/**
	 * 용어분류코드 insert
	 */
	@RequestMapping(value="/baseCodeMgr/dic.do", params = "mode=insertTypes")
	public String insertDicType(@ModelAttribute("cm")CommonMap cm, Model model) throws BizException {
		DataMap requestMap = cm.getDataMap();
		requestMap.setNullToInitialize(true);
		
		String msg = "";
		String resultType = "";
		
		int result = dicService.insertDicType(requestMap);
		
		if(result > 0){
			msg = "등록 되었습니다.";
			resultType = "ok";
		}else{
			if(result == -1){
				msg = "분류코드가 중복 되었습니다.";
				resultType = "pkError";
			}else{				
				msg = "등록시 오류가 발생했습니다.";
				resultType = "saveError";
			}
		}
		
		model.addAttribute("RESULT_MSG", msg);
		model.addAttribute("RESULT_TYPE", resultType);
		
		return "/baseCodeMgr/dic/typeExec";
	}
	
	/**
	 * 용어분류코드 update
	 */
	@RequestMapping(value="/baseCodeMgr/dic.do", params = "mode=updateTypes")
	public String updateDicType(@ModelAttribute("cm")CommonMap cm, Model model) throws BizException {
		DataMap requestMap = cm.getDataMap();
		requestMap.setNullToInitialize(true);
		
		String msg = "";
		String resultType = "";
		
		int result = dicService.updateDicType(requestMap);
		
		if(result > 0){
			msg = "수정 되었습니다.";
			resultType = "ok";
		}else{
					
			msg = "수정시 오류가 발생했습니다.";
			resultType = "saveError";
			
		}
		
		model.addAttribute("RESULT_MSG", msg);
		model.addAttribute("RESULT_TYPE", resultType);
		
		return "/baseCodeMgr/dic/typeExec";
	}
	
	/**
	 * 용어사전 리스트
	 */
	@RequestMapping(value="/baseCodeMgr/dic.do", params = "mode=dicList")
	public String selectDicList(@ModelAttribute("cm")CommonMap cm, Model model) throws BizException {
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
		
		
		listMap = dicService.selectDicList(requestMap);	
		
		model.addAttribute("LIST_DATA", listMap);
		
		return "/baseCodeMgr/dic/dicList";
	}
	
	@RequestMapping(value="/baseCodeMgr/dic.do", params = "mode=dicReg")
	public String dicReg(@ModelAttribute("cm")CommonMap cm, Model model) throws BizException {
		return "/baseCodeMgr/dic/dicForm";
	}
	
	/**
	 * 용어사전 수정시 데이타 조회
	 */
	@RequestMapping(value="/baseCodeMgr/dic.do", params = "mode=dicModify")
	public String selectDicRow(@ModelAttribute("cm")CommonMap cm, Model model) throws BizException {
		DataMap requestMap = cm.getDataMap();
		requestMap.setNullToInitialize(true);
		
		DataMap rowMap = null;
		
		rowMap = dicService.selectDicRow(requestMap);
		
		model.addAttribute("ROW_DATA", rowMap);
		
		return "/baseCodeMgr/dic/dicForm";
	}

	/**
	 * 용어사전 등록
	 */
	@RequestMapping(value="/baseCodeMgr/dic.do", params = "mode=insertDic")
	public String insertDic(@ModelAttribute("cm")CommonMap cm, Model model) throws BizException {
		DataMap requestMap = cm.getDataMap();
		requestMap.setNullToInitialize(true);
		
		String msg = "";
		String resultType = "";
		
		int result = dicService.insertDic(requestMap);
		
		if(result > 0){
			
			msg = "등록 되었습니다.";
			resultType = "ok";
			
		}else{			
			msg = "등록시 오류가 발생했습니다.";
			resultType = "saveError";			
		}
		model.addAttribute("RESULT_MSG", msg);
		model.addAttribute("RESULT_TYPE", resultType);
		
		return "/baseCodeMgr/dic/dicExec";
	}
	
	/**
	 * 용어사전 수정
	 */
	@RequestMapping(value="/baseCodeMgr/dic.do", params = "mode=updateDic")
	public String updateDic(@ModelAttribute("cm")CommonMap cm, Model model) throws BizException {
		DataMap requestMap = cm.getDataMap();
		requestMap.setNullToInitialize(true);
		
		String msg = "";
		String resultType = "";
		
		int result = dicService.updateDic(requestMap);
		
		if(result > 0){
			
			msg = "수정 되었습니다.";
			resultType = "ok";
			
		}else{			
			msg = "수정시 오류가 발생했습니다.";
			resultType = "saveError";			
		}
		model.addAttribute("RESULT_MSG", msg);
		model.addAttribute("RESULT_TYPE", resultType);
		
		return "/baseCodeMgr/dic/dicExec";
	}
	
	/**
	 * 용어사전 삭제
	 */
	@RequestMapping(value="/baseCodeMgr/dic.do", params = "mode=deleteDic")
	public String deleteDic(@ModelAttribute("cm")CommonMap cm, Model model) throws BizException {
		DataMap requestMap = cm.getDataMap();
		requestMap.setNullToInitialize(true);
		
		String msg = "";
		String resultType = "";
		
		int result = dicService.deleteDic(requestMap);
		
		if(result > 0){
			
			msg = "삭제 되었습니다.";
			resultType = "ok";
			
		}else{			
			msg = "삭제시 오류가 발생했습니다.";
			resultType = "saveError";			
		}
		model.addAttribute("RESULT_MSG", msg);
		model.addAttribute("RESULT_TYPE", resultType);
		
		return "/baseCodeMgr/dic/dicExec";
	}
	
	/**
	 * 용어사전 테스트화면 리스트
	 */
	@RequestMapping(value="/baseCodeMgr/dic.do", params = "mode=testList")
	public String selectDicTestList(@ModelAttribute("cm")CommonMap cm, Model model) throws BizException {
		DataMap requestMap = cm.getDataMap();
		requestMap.setNullToInitialize(true);
		
		DataMap listMap = null;				
		listMap = dicService.selectDicTestList();
		
		model.addAttribute("LIST_DATA", listMap);
		
		return "/baseCodeMgr/dic/dicTestList";
	}
	
	/**
	 * 용어사전용 과목명
	 */
	@RequestMapping(value="/baseCodeMgr/dic.do", params = "mode=dicView")
	public String selectDicViewBySubj(@ModelAttribute("cm")CommonMap cm, Model model) throws BizException {
		DataMap requestMap = cm.getDataMap();
		requestMap.setNullToInitialize(true);
		
		DataMap rowMap = null;
		DataMap groupsMap = null;
		
		rowMap = dicService.selectDicViewBySubj(requestMap);
		groupsMap = commonService.selectDicGroupCodeByCbo();
		
		model.addAttribute("ROW_DATA", rowMap);
		model.addAttribute("GROUPS_DATA", groupsMap);
		
		return "/baseCodeMgr/dic/dicViewPop";
	}
	
	/**
	 * 용어사전 검색 리스트
	 */
	@RequestMapping(value="/baseCodeMgr/dic.do", params = "mode=searchDic")
	public String selectSearchDic(@ModelAttribute("cm")CommonMap cm, Model model) throws BizException {
		DataMap requestMap = cm.getDataMap();
		requestMap.setNullToInitialize(true);
		
		DataMap listMap = null;				
		listMap = dicService.selectSearchDic(requestMap);
		
		model.addAttribute("LIST_DATA", listMap);
		
		return "/baseCodeMgr/dic/dicViewDataByAjax";
	}
}
