package loti.member.web;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import loti.member.service.EmployeeService;

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
public class EmployeeController extends BaseController {

	@Autowired
	private EmployeeService employeeService;
	
	@ModelAttribute("cm")
	public CommonMap common(
				CommonMap cm
				, HttpServletRequest request
				, HttpServletResponse response
				, Model model
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
		String mode = requestMap.getString("mode");
		
		
		//리퀘스트 정보를 담고있는 DataMap을 Attribute 에 추가
		model.addAttribute("REQUEST_DATA", requestMap);
		
		return cm;
	}
	
	public String findView(String mode, String defaultView){
		return defaultView;
	}
	
	
	@RequestMapping(value="/member/employee.do")
	public String defaultProcess(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			) throws Exception{
		return list(cm, model);
	}
	@RequestMapping(value="/member/employee.do", params="mode=list")
	public String list(
				@ModelAttribute("cm") CommonMap cm
				, Model model
			) throws Exception{
		
		DataMap  requestMap = cm.getDataMap();
		
		DataMap listMap = null;
		
		if (requestMap.getString("currPage").equals(""))	requestMap.setInt("currPage", 1); //페이지
		if (requestMap.getString("rowSize").equals(""))		requestMap.setInt("rowSize", 15); //페이지당 보여줄 갯수
		if (requestMap.getString("pageSize").equals("")) 	requestMap.setInt("pageSize", 10); //페이지 블럭 갯수
		
		
		listMap = employeeService.selectMemberStatsList(requestMap);
		model.addAttribute("LIST_DATA", listMap);
		
		return findView(requestMap.getString("mode"), "/member/employee/employeeList");
	}
	
	/** 
	 * 직원관리 폼
	 * 작성일 8월 18일
	 * 작성자 정윤철
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @param requestMap
	 * @throws Exception
	 */
	@RequestMapping(value="/member/employee.do", params="mode=from")
	public String from(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			) throws Exception{
		
		DataMap  requestMap = cm.getDataMap();
		
		DataMap rowMap = null;
		
		if(requestMap.getString("qu").equals("insert")){
			rowMap = new DataMap();
			
		}else if(requestMap.getString("qu").equals("modify")){
			rowMap = employeeService.selectMemberStatsRow(requestMap);
			
		}

		model.addAttribute("ROWLIST_DATA", rowMap);
		
		return findView(requestMap.getString("mode"), "/member/employee/employeeFrom");
	}
	
	/** 
	 * 직원관리 등록,수정,삭제 실행
	 * 작성일 8월 18일
	 * 작성자 정윤철
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @param requestMap
	 * @throws Exception
	 */
	@RequestMapping(value="/member/employee.do", params="mode=exec")
	public String exec(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			) throws Exception{
		
		DataMap  requestMap = cm.getDataMap();
		
		int returnValue = 0;
		
		if(requestMap.getString("qu").equals("insert")){
			returnValue = employeeService.insertMemberStats(requestMap);
			if(returnValue == 0){
				requestMap.setString("msg", "저장에 실패하였습니다.");
				
			}else if(returnValue == 1){
				requestMap.setString("msg", "저장 하였습니다.");
			}
			
			
		}else if(requestMap.getString("qu").equals("modify")){
			returnValue = employeeService.modifyMemberStats(requestMap);
			
			if(returnValue == 0){
				requestMap.setString("msg", "저장에 실패하였습니다.");
				
			}else if(returnValue == 1){
				requestMap.setString("msg", "저장 하였습니다.");
			}
			
		}else if(requestMap.getString("qu").equals("delete")){
			returnValue = employeeService.deleteMemberStats(requestMap);
			
			if(returnValue == 0){
				requestMap.setString("msg", "저장에 실패하였습니다.");
				
			}else if(returnValue == 1){
				requestMap.setString("msg", "삭제 하였습니다.");
			}
		}
		
		return findView(requestMap.getString("mode"), "/member/employee/employeeExec");
	}
	
	@RequestMapping(value="/member/employee.do", params="mode=ajaxEmployee")
	public String ajaxEmployee(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			) throws Exception{
		
		DataMap  requestMap = cm.getDataMap();
		
		return findView(requestMap.getString("mode"), "/member/employee/ajaxEmployList");
	}
	
}