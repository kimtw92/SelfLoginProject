package loti.homepageMgr.web;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import loti.homepageMgr.service.ClassRoomService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import ut.lib.login.LoginCheck;
import ut.lib.login.LoginInfo;
import ut.lib.support.CommonMap;
import ut.lib.support.DataMap;
import ut.lib.util.DateUtil;
import common.controller.BaseController;

@Controller("homepageMgrClassRoomController")
public class ClassRoomController extends BaseController {

	@Autowired
	@Qualifier("homepageMgrClassRoomService")
	private ClassRoomService classRoomService;
	
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
		
		model.addAttribute("REQUEST_DATA", requestMap);
		
		return cm;
	}
	
	public String findView(String mode, String defaultView){
		return defaultView;
	}
	
	@RequestMapping(value="/homepageMgr/classRoom.do")
	public String defaultProcess(
			@ModelAttribute("cm") CommonMap cm
			, Model model
		) throws Exception{
		return list(cm, model);
	}
	
	/**
	 * 강의실관리 리스트
	 * 작성일 : 6월 17일
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
	
		DataMap listMap = classRoomService.selectClassRoomList(requestMap);
		
		model.addAttribute("LIST_DATA", listMap);
	}
	
	@RequestMapping(value="/homepageMgr/classRoom.do", params="mode=list")
	public String list(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			) throws Exception{
		
		DataMap requestMap = cm.getDataMap();
		
		list(model, requestMap);
		
		return findView(requestMap.getString("mode"), "/homepageMgr/classRoom/classRoomList");
	}
	
	/**
	 * 강의실관리 폼 
	 * 작성일 : 6월 17일
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
	
		DataMap listMap = null;
		
		if(requestMap.getString("qu").equals("modify")){
			//수정 모드일때
			listMap = classRoomService.selectClassRoomList(requestMap);
			
		}else if(requestMap.getString("qu").equals("insert")){
			//등록 모드일때
			listMap = new DataMap();
		}
		
		model.addAttribute("CLASSROMROW_DATA", listMap);
	}
	
	@RequestMapping(value="/homepageMgr/classRoom.do", params="mode=form")
	public String form(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			) throws Exception{
		
		DataMap requestMap = cm.getDataMap();
		
		form(model, requestMap);
		
		return findView(requestMap.getString("mode"), "/homepageMgr/classRoom/classRoomForm");
	}
	
	/**
	 * 강의실관리 수정
	 * 작성일 : 6월 17일
	 * 작성자 : 정 윤철
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	public void exec(
			Model model
	        , DataMap requestMap) throws Exception {
	
		//	초기화 옵션(true 일경우 데이터를 뽑을때 null 일경우 초기화 - 빈문자열, 0....)
		requestMap.setNullToInitialize(true);
		
		int returnValue = 0;
		
		if(requestMap.getString("qu").equals("modify")){
			
			//수정 모드일때
			if(requestMap.getString("no").equals(requestMap.getString("classroomNo"))){
				
				//기존 코드값과 같을경우 수정
				int result = classRoomService.modifyClassRoom(requestMap);
				
				if(result > 0 ){
					requestMap.setString("msg","수정 하였습니다.");
				}else{
					requestMap.setString("msg","실패");
				}
				
				
			}else{
				//기존 코드값과 다를경우 현재 수정할려는 코드값과 중복된 값이 잇는지 체크
				returnValue = classRoomService.selectClassRoomNoChk(requestMap.getString("classroomNo"));
				
				if(returnValue >0){
					requestMap.setString("msg","back");
					
				}else{
					//기존 코드값과 같을경우 수정
					classRoomService.modifyClassRoom(requestMap);
					requestMap.setString("msg","수정 하였습니다.");
					
				}
			}

		}else if(requestMap.getString("qu").equals("insert")){
			
				//기존 코드값과 다를경우 현재 수정할려는 코드값과 중복된 값이 잇는지 체크
				returnValue = classRoomService.selectClassRoomNoChk(requestMap.getString("classroomNo"));
				
				if(returnValue >0){
					requestMap.setString("msg","back");
					
				}else{
					//기존 코드값과 같을경우 수정
					classRoomService.insertClassRoom(requestMap);
					requestMap.setString("msg","등록 하였습니다.");
					
				}

		}else if(requestMap.getString("qu").equals("delete")){
			//삭제
			classRoomService.deleteClassRoom(requestMap);
			requestMap.setString("msg","삭제 하였습니다.");
		}
	}
	
	@RequestMapping(value="/homepageMgr/classRoom.do", params="mode=exec")
	public String exec(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			) throws Exception{
		
		DataMap requestMap = cm.getDataMap();
		
		exec(model, requestMap);
		
		return findView(requestMap.getString("mode"), "/homepageMgr/classRoom/classRoomExec");
	}
	
	/**
	 * 강의실 엑셀 출력
	 * 작성일 : 6월 17일
	 * 작성자 : 정 윤철
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	public void selectExcelList(
			Model model
	        , DataMap requestMap) throws Exception {
	
		DataMap listMap =  classRoomService.selectExcelList(requestMap.getString("date"));
		int day = DateUtil.getMonthDate(requestMap.getString("date").substring(0, 4), requestMap.getString("date").substring(4, 6));
		listMap.setInt("day", day);
		model.addAttribute("EXCEL_DATA", listMap);
		
	}
	
	@RequestMapping(value="/homepageMgr/classRoom.do", params="mode=excel")
	public String excel(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			) throws Exception{
		
		DataMap requestMap = cm.getDataMap();
		
		selectExcelList(model, requestMap);
		
		return findView(requestMap.getString("mode"), "/homepageMgr/classRoom/classRoomByExcel");
	}
	
	/**
	 * 강의실관리 강의코드중복 체크
	 * 작성일 : 6월 17일
	 * 작성자 : 정 윤철
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	public void selectClassRoomNoChk(
			Model model
	        , DataMap requestMap) throws Exception {
	
		 int returnValue = classRoomService.selectClassRoomNoChk(requestMap.getString("classroomNo"));
		
		requestMap.setInt("count", returnValue);
	}
	
	@RequestMapping(value="/homepageMgr/classRoom.do", params="mode=ajaxClassRoomCodeChk")
	public String ajaxClassRoomCodeChk(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			) throws Exception{
		
		DataMap requestMap = cm.getDataMap();
		
		selectClassRoomNoChk(model, requestMap);
		
		return findView(requestMap.getString("mode"), "/homepageMgr/classRoom/ajaxClassRoomNoChk");
	}
	
	
}
