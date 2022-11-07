package loti.tutorMgr.web;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import loti.tutorMgr.service.AllowanceService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import ut.lib.login.LoginCheck;
import ut.lib.login.LoginInfo;
import ut.lib.support.CommonMap;
import ut.lib.support.DataMap;
import common.controller.BaseController;

@Controller
public class AllowanceController extends BaseController {

	@Autowired
	private AllowanceService allowanceService;
	
	@ModelAttribute("cm")
	public CommonMap common(
				CommonMap cm
				, HttpServletRequest request
				, HttpServletResponse response
			) throws Exception{
		
		//요청처리 - get, post 방식의 파라미터를 DataMap 에 저장
		DataMap requestMap = cm.getDataMap();
		//초기화 옵션(true 일경우 데이터를 뽑을때 null 일경우 초기화 - 빈문자열, 0....)
		requestMap.setNullToInitialize(true);
		//관리자 로그인 체크. (관리자 페이지에는 모두 있어야 함)
		LoginInfo memberInfo = LoginCheck.adminCheck(request, response, requestMap.getString("menuId"));
		if (memberInfo == null) return null;
		
		//default mode
		if(requestMap.getString("mode").equals(""))
			requestMap.setString("mode", "list");
		
		request.setAttribute("REQUEST_DATA", requestMap);
		
		return cm;
	}
	
	public String findView(String mode, String view){
		return view;
	}
	
	/**
	 * 강사레벨리스트
	 * 작성일 : 7월 9일
	 * 작성자 : 정 윤철
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	public void list(
			Model model
	        , DataMap requestMap) throws Exception {

		DataMap listMap = allowanceService.selectAllowanceList();
		
		model.addAttribute("LIST_DATA", listMap);
	}
	
	@RequestMapping(value="/tutorMgr/allowance.do")
	public String defaultView(
				@ModelAttribute("cm") CommonMap cm
				, Model model
			) throws Exception{
		list(model, cm.getDataMap());
		return findView(cm.getDataMap().getString("mode"), "/tutorMgr/allowance/allowLevelList");
	}
	
	@RequestMapping(value="/tutorMgr/allowance.do", params="mode=list")
	public String list(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			) throws Exception{
		list(model, cm.getDataMap());
		return findView(cm.getDataMap().getString("mode"), "/tutorMgr/allowance/allowLevelList");
	}
	
	/**
	 * 강사레벨관리 폼
	 * 작성일 : 7월 9일
	 * 작성자 : 정 윤철
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	public void form(
			Model model
	        , DataMap requestMap) throws Exception {
		
		DataMap rowMap = null;
		
		if(requestMap.getString("qu").equals("insert")){
			rowMap = new DataMap();
		}else if(requestMap.getString("qu").equals("modify")){
			rowMap = allowanceService.selectAllowanceRow(requestMap.getString("tlevel"));
		}
		
		model.addAttribute("TUTORLEVEL_ROW_DATA", rowMap);
	}
	
	@RequestMapping(value="/tutorMgr/allowance.do", params="mode=form")
	public String form(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			) throws Exception{
		form(model, cm.getDataMap());
		return findView(cm.getDataMap().getString("mode"), "/tutorMgr/allowance/allowLevelFormPop");
	}
	
	/**
	 * 강사지정 리스트
	 * 작성일 7월 9일
	 * 작성자 정윤철
	 * @param tlevel
	 * @return selectLevelgruList
	 * @throws SQLException e
	 */
	public void greadList(
			Model model
	        , DataMap requestMap) throws Exception {
		
		DataMap listMap = allowanceService.selectLevelgruList(requestMap.getString("tlevel"));
		String nameMap = allowanceService.selectLevelName(requestMap.getString("tlevel"));
		requestMap.setString("name", nameMap);
		System.out.println(listMap);
		model.addAttribute("LIST_DATA", listMap);		
	
	}
	
	@RequestMapping(value="/tutorMgr/allowance.do", params="mode=greadList")
	public String greadList(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			) throws Exception{
		greadList(model, cm.getDataMap());
		return findView(cm.getDataMap().getString("mode"), "/tutorMgr/allowance/allowLevelGradeList");
	}
	
	/**
	 * 강사지정 폼
	 * 작성일 7월 9일
	 * 작성자 정윤철
	 * @param tlevel, gruCode
	 * @return selectAllowanceList
	 * @throws SQLException e
	 */
	public void greadForm(
			Model model
	        , DataMap requestMap) throws Exception {
		DataMap RowMap = null;
		if(requestMap.getString("qu").equals("modify")  ){
			RowMap = allowanceService.selectLevelgruRow(requestMap.getString("tlevel"), requestMap.getString("gruCode"));
			
		}else if(requestMap.getString("qu").equals("insert")){
			RowMap = new DataMap();
			
		}
		model.addAttribute("LEVELGRU_ROW_DATA", RowMap);		
	
	}
	
	@RequestMapping(value="/tutorMgr/allowance.do", params="mode=greadForm")
	public String greadForm(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			) throws Exception{
		greadForm(model, cm.getDataMap());
		return findView(cm.getDataMap().getString("mode"), "/tutorMgr/allowance/allowLevelGradeFormPop");
	}
	
	/**
	 * 강사지정 폼
	 * 작성일 7월 9일
	 * 작성자 정윤철
	 * @param tlevel, gruCode
	 * @return selectAllowanceList
	 * @throws SQLException e
	 */
	public void greadExec(
	          DataMap requestMap) throws Exception {
		int returnValue = 0;
		
		if(requestMap.getString("qu").equals("insert")  ){
			returnValue = allowanceService.insertLevelgru(requestMap);
			
			if(returnValue == 0){
				requestMap.setString("msg","실패하였습니다.");
			}else if(returnValue == 1){
				requestMap.setString("msg","등록하였습니다.");
			}
			
		}else if(requestMap.getString("qu").equals("modify")){
			returnValue = allowanceService.modifyLevelgru(requestMap);
			
			if(returnValue == 0){
				requestMap.setString("msg","실패하였습니다.");
			}else if(returnValue == 1){
				requestMap.setString("msg","수정하였습니다.");
			}
			
		}else if(requestMap.getString("qu").equals("delete")){
			returnValue = allowanceService.deleteLevelgru(requestMap);
			
			if(returnValue == 0){
				requestMap.setString("msg","실패하였습니다.");
			}else if(returnValue == 1){
				requestMap.setString("msg","삭제하였습니다.");
			}
			
		}
	
	}
	
	@RequestMapping(value="/tutorMgr/allowance.do", params="mode=greadExec")
	public String greadExec(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			) throws Exception{
		greadExec(cm.getDataMap());
		return findView(cm.getDataMap().getString("mode"), "/tutorMgr/allowance/allowLevelExec");
	}
	
	/**
	 * 강사코드 중복체크
	 * 작성일 : 7월 9일
	 * 작성자 : 정 윤철
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	public void ajaxLevelChk(
	          DataMap requestMap) throws Exception {
		
		int returnValue = allowanceService.selectAllowanceCount(requestMap.getString("tlevel"));
		
		requestMap.setInt("count", returnValue);
	}
	
	@RequestMapping(value="/tutorMgr/allowance.do", params="mode=ajaxLevelChk")
	public String ajaxLevelChk(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			) throws Exception{
		ajaxLevelChk(cm.getDataMap());
		return findView(cm.getDataMap().getString("mode"), "/tutorMgr/allowance/ajaxLevelChk");
	}
	
	/**
	 * 강사레벨관리 폼
	 * 작성일 : 7월 9일
	 * 작성자 : 정 윤철
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	public void exec(
	          DataMap requestMap) throws Exception {
		
		int returnValue = 0;
		
		if(requestMap.getString("qu").equals("insert")){//등록 실행
			returnValue = allowanceService.insertAllowance(requestMap);
			
			if(returnValue == 0){
				requestMap.setString("msg","등록에 실패하였습니다.");
				
			}else if(returnValue == 1){
				requestMap.setString("msg","등록 하였습니다.");
				
			}else if(returnValue == 3){
				requestMap.setString("msg","중복된 강사코드가 있어서 등록이 불가능 합니다.");
				
			}
			
		}else if(requestMap.getString("qu").equals("modify")){//수정 실행
			returnValue = allowanceService.modifyAllowance(requestMap);
			
			if(returnValue == 0){
				requestMap.setString("msg","등록에 실패하였습니다.");
				
			}else if(returnValue == 1){
				requestMap.setString("msg","수정 하였습니다.");
				
			}
		}
	}
	
	@RequestMapping(value="/tutorMgr/allowance.do", params="mode=exec")
	public String exec(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			) throws Exception{
		exec(cm.getDataMap());
		return findView(cm.getDataMap().getString("mode"), "/tutorMgr/allowance/allowLevelExec");
	}
}
