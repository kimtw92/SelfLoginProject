package loti.common.web;

import java.util.HashMap;
import java.util.List;

import loti.common.service.CommonService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import ut.lib.support.CommonMap;
import ut.lib.support.DataMap;
import common.controller.BaseController;

/**
 * 강의실 관련 클래스.
 *
 * @author LYM
 *
 */
@Controller
public class ClassRoomController extends BaseController {

	@Autowired
	private CommonService service;
	
	@RequestMapping(value="/commonInc/classRoom.do")
	public String defaultProcess(CommonMap reqDataMap, ModelMap model) throws Exception{

		//default mode
		if(reqDataMap.getDataMap().getString("mode").equals(""))
			reqDataMap.getDataMap().setString("mode", "list");
		
		return list(reqDataMap, model);
	}
	@RequestMapping(value="/commonInc/classRoom.do", params="mode=list")
	public String list(CommonMap reqDataMap, ModelMap model) throws Exception{
		
		//초기화 옵션(true 일경우 데이터를 뽑을때 null 일경우 초기화 - 빈문자열, 0....)
		reqDataMap.getDataMap().setNullToInitialize(true);
		
		//강의실 리스트.
		DataMap listMap = service.selectClassRoomList();

		model.addAttribute("LIST_DATA", listMap); 
		
		return "/commonInc/popup/classRoomList";
	}
	
	/*public ActionForward execute(
			final ActionMapping mapping,
			final ActionForm form,
			final HttpServletRequest request,
			final HttpServletResponse response) throws Exception {
		
		 //요청처리 - get, post 방식의 파라미터를 DataMap 에 저장
		DataMap requestMap = RequestUtil.getRequest(request);
		//초기화 옵션(true 일경우 데이터를 뽑을때 null 일경우 초기화 - 빈문자열, 0....)
		requestMap.setNullToInitialize(true);
		
		
		//default mode
		if(requestMap.getString("mode").equals(""))
			requestMap.setString("mode", "list");
		String mode = requestMap.getString("mode");
		
		
		if(mode.equals("list")) //리스트
			list(mapping, form, request, response, requestMap);

		
		//리퀘스트 정보를 담고있는 DataMap을 Attribute 에 추가
		request.setAttribute("REQUEST_DATA", requestMap);
		
		return mapping.findForward(mode);
		
	}
	
	
	*//**
	 * 강의실 리스트
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @param requestMap
	 * @throws Exception
	 *//*
	public void list(
			ActionMapping mapping, 
			ActionForm form, 
			HttpServletRequest request, 
			HttpServletResponse response, 
			DataMap requestMap) throws Exception {
		
		//service Instance
		CommonSV service = new CommonSV();
		
		//강의실 리스트.
		DataMap listMap = service.selectClassRoomList();
		
		request.setAttribute("LIST_DATA", listMap);
		
	}*/
	
	
}
