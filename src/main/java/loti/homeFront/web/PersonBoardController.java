package loti.homeFront.web;

import java.util.Calendar;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import common.controller.BaseController;
import loti.courseMgr.service.ReservationService;
import loti.homeFront.service.PersonBoardService;
import ut.lib.exception.BizException;
import ut.lib.login.LoginInfo;
import ut.lib.support.CommonMap;
import ut.lib.support.DataMap;


@Controller
public class PersonBoardController extends BaseController{

	@Autowired
	private ReservationService reservationService;
	
	@Autowired
	private PersonBoardService personBoardService;
	
	@ModelAttribute("cm")
	public CommonMap common(
					CommonMap cm
					, Model model
					, HttpServletRequest request
					, @RequestParam(value="mode", required=false, defaultValue="") String mode
			) throws BizException {
		
		/**
		 * 로그인 체크
		 */
		LoginInfo loginInfo = (LoginInfo)request.getAttribute("LOGIN_INFO");
		if(loginInfo.isLogin() == false){
			// 로그인 안되어 있음
			log.info("로그인 안되어 있음");
		}

		// 리퀘스트 정보를 담고있는 DataMap을 Attribute 에 추가
		model.addAttribute("REQUEST_DATA", cm.getDataMap());
		model.addAttribute("LOGIN_INFO", loginInfo);
		
		// ui 공휴일 목록을 리턴 한다.
//		holydayUiList(mapping, form, request, response, requestMap);
				
		return cm;
	}

	@ModelAttribute("cmPerson")
	public CommonMap commonPerson(
					CommonMap cm
					, Model model
					, HttpServletRequest request
					, @RequestParam(value="mode", required=false, defaultValue="") String mode
			) throws BizException {
		
				
		// 리퀘스트 정보를 담고있는 DataMap을 Attribute 에 추가
		model.addAttribute("REQUEST_DATA", cm.getDataMap());
				
		return cm;
	}
	
	/**
	 * 감사반장에 바란다. 리스트
	 * 작성일 : 6월 2일
	 * @param mapping
	 * @param form 
	 * @param request
	 * @param response
	 * @param requestMap
	 * @throws Exception
	 */
	@RequestMapping(value="/homepage/person.do", params="mode=personlist")
	public String personList(Model model) throws BizException{
		
		DataMap requestMap = new DataMap();

		requestMap.setNullToInitialize(true);
		
		if (requestMap.getString("currPage").equals("")) {
			requestMap.setInt("currPage", 1);
		}
		if (requestMap.getString("rowSize").equals("")) {
			requestMap.setInt("rowSize", 10);
		}
		if (requestMap.getString("pageSize").equals("")) {
			requestMap.setInt("pageSize", 10);
		}
		
//		DataMap listMap = boardService.selectBoardPersonList(requestMap);
		try {
			model.addAttribute("LIST_DATA", personBoardService.selectBoardPersonList(requestMap)  );
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} 
		
		return findView(requestMap.getString("mode"), "/homepageMgr/board/bbsPerson/list");
	}

	/**
	 * 감사반장에 바란다. 화면 이동
	 * 작성일 : 6월 2일
	 * @param mapping
	 * @param form 
	 * @param request
	 * @param response
	 * @param requestMap
	 * @throws Exception
	 */
	@RequestMapping(value="/homepage/person.do", params="mode=personView")
	public String personView(
					@ModelAttribute("cm") CommonMap cm
					, Model model
					, HttpServletRequest request
//					, @RequestParam(value="mode", required=false, defaultValue="") String mode
			) throws Exception {
		
				
		// 리퀘스트 정보를 담고있는 DataMap을 Attribute 에 추가
		//model.addAttribute("REQUEST_DATA", cm.getRequest());

		DataMap requestMap = new DataMap();
		
		DataMap paramMap = cm.getDataMap();
		String qu = paramMap.getString("qu");
		
		if (qu.equals("select")){
			requestMap = personBoardService.selectBoardPersonView(paramMap);
		}
		model.addAttribute("REQUES_DATA", paramMap);
		model.addAttribute("PERSON_DATA", requestMap);
		
		return findView(requestMap.getString("mode"), "/homepageMgr/board/bbsPerson/form");
	}

	/**
	 * 감사반장에 바란다. 등록
	 * 작성일 : 6월 2일
	 * @param mapping
	 * @param form 
	 * @param request
	 * @param response
	 * @param requestMap
	 * @throws Exception
	 */
	@RequestMapping(value="/homepage/person.do", params="mode=personExec")
	public String personInsert(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			) throws Exception{
		int resultint = 0;
		DataMap requestMap = cm.getDataMap();
		requestMap.setNullToInitialize(true);
		requestMap.set("remoteIp", requestMap.getString("ip"));
		System.out.println("=================================== requestMap: " + requestMap.toString());
		String qu = requestMap.getString("qu");
		if (qu.equals("insert")){
			
			resultint = personBoardService.insertBoardPerson(requestMap);
			requestMap.setString("msg","등록하였습니다.");

			
		}else if (qu.equals("select")){
			resultint = personBoardService.updateBoardPerson(requestMap);
			requestMap.setString("msg","등록하였습니다.");
		}
		System.out.println("=================================== resultint: " + resultint);
		if(resultint < 1){
			requestMap.setString("msg","실패하였습니다.");
		}
		
		model.addAttribute("REQUES_DATA", requestMap);
		
		return findView(requestMap.getString("mode"), "/homepageMgr/board/bbsPerson/result");
		
	}

	public String findView(String mode, String defaultView){
		return defaultView;
	}
	
}

