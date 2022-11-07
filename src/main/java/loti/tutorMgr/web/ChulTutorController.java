package loti.tutorMgr.web;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import loti.tutorMgr.service.ChulTutorService;

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
public class ChulTutorController extends BaseController {

	@Autowired
	private ChulTutorService chulTutorService;
	
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
		
		model.addAttribute("REQUEST_DATA", requestMap);
		
		return cm;
	}
	
	@RequestMapping("/tutorMgr/chulTutor.do")
	public String defaultMode(
				@ModelAttribute("cm") CommonMap cm
				, Model model
			) throws Exception{
		return list(cm, model);
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
		
		if (requestMap.getString("currPage").equals("")) {
			requestMap.setInt("currPage", 1);
		}
		if (requestMap.getString("rowSize").equals("")) {
			requestMap.setInt("rowSize", 15);
		}
		if (requestMap.getString("pageSize").equals("")) {
			requestMap.setInt("pageSize", 10);
		}
		
		//출강강사 리스트
		DataMap listMap = null;
		
		//엑셀 모드가 아닐때에는 페이징을 타서는 안된다.
		if(!requestMap.getString("mode").equals("excel")){
			listMap = chulTutorService.selectChulTutorList(requestMap);
		}else{
			listMap = chulTutorService.selectChulTutorListExcel(requestMap);
		}
		
		//전체 출강 강사 카운터
		DataMap selectChulTutorAllCountRow = chulTutorService.selectChulTutorAllCountRow();
		requestMap.setInt("total"
				, selectChulTutorAllCountRow.getInt("tcnt",0)+selectChulTutorAllCountRow.getInt("tcnt",1)
			);
		
		//과정별 총 카운트
		DataMap selectChulTutorCourseAllCountRow = null;
		if(!requestMap.getString("grcode").equals("")){
			selectChulTutorCourseAllCountRow = chulTutorService.selectChulTutorCourseAllCountRow(requestMap.getString("grcode"));
			
		}else{
			selectChulTutorCourseAllCountRow = new DataMap();
		}
		
		//과정별 카운트
		DataMap selectChulTutorCourseCountRow = null;
		if(!requestMap.getString("grcode").equals("")){
			selectChulTutorCourseCountRow = chulTutorService.selectChulTutorCourseCountRow(requestMap.getString("grcode"));
			
		}else{
			selectChulTutorCourseCountRow = new DataMap();
		}
		
		//과정별 소계 옵션박스리스트
		DataMap selectCoursorList = chulTutorService.selectCoursorList();
		
		
		model.addAttribute("LIST_DATA", listMap);
		model.addAttribute("TOTALCOUNT_DATA", selectChulTutorAllCountRow);
		model.addAttribute("COURSETOTALCOUNT_DATA", selectChulTutorCourseAllCountRow);
		model.addAttribute("COURSECOUNT_DATA", selectChulTutorCourseCountRow);		
		model.addAttribute("COURSELIST_DATA", selectCoursorList);
	}
	
	@RequestMapping(value="/tutorMgr/chulTutor.do", params="mode=list")
	public String list(
				@ModelAttribute("cm") CommonMap cm
				, Model model
			) throws Exception{
		list(model, cm.getDataMap());
		return "/tutorMgr/chulTutor/chulTutorList";
	}
	
	@RequestMapping(value="/tutorMgr/chulTutor.do", params="mode=excel")
	public String excel(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			) throws Exception{
		list(model, cm.getDataMap());
		return "/tutorMgr/chulTutor/chulTutorByExcel";
	}
	
	/**
	 * 출강강사 관리
	 * 작성일 : 7월 11일
	 * 작성자 : 정 윤철
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	public void totalList(
			Model model
	        , DataMap requestMap) throws Exception {
		
		if (requestMap.getString("currPage").equals("")) {
			requestMap.setInt("currPage", 1);
		}
		if (requestMap.getString("rowSize").equals("")) {
			requestMap.setInt("rowSize", 15);
		}
		if (requestMap.getString("pageSize").equals("")) {
			requestMap.setInt("pageSize", 10);
		}
		
		//출강강사 리스트
		DataMap listMap = chulTutorService.selectTotalList(requestMap);
		
		//과정별 소계 옵션박스리스트
		DataMap selectCoursorList = chulTutorService.selectCoursorList();
		
		model.addAttribute("LIST_DATA", listMap);
		model.addAttribute("COURSELIST_DATA", selectCoursorList);
	}
	
	@RequestMapping(value="/tutorMgr/chulTutor.do", params="mode=totalList")
	public String totalList(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			) throws Exception{
		totalList(model, cm.getDataMap());
		return "/tutorMgr/chulTutor/chulTotalList";
	}
}
