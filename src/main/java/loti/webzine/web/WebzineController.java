package loti.webzine.web;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import loti.webzine.service.WebzineService;

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
public class WebzineController extends BaseController {

	@Autowired
	private WebzineService webzineService;
	
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
	
	public String findView(String mode, String defaultView){
		return defaultView;
	}
	
	@RequestMapping(value="/webzine.do", params="mode=complateList")
	public String complateList(
				@ModelAttribute("cm") CommonMap cm
				, Model model
			) throws Exception{
		
		DataMap requestMap = cm.getDataMap();
		
		if (requestMap.getString("currPage").equals("")) {
			requestMap.setInt("currPage", 1);
		}
		if (requestMap.getString("rowSize").equals("")) {
			requestMap.setInt("rowSize", 8);
		}
		if (requestMap.getString("pageSize").equals("")) {
			requestMap.setInt("pageSize", 10);
		}
		
		DataMap yearListMap = webzineService.selectNewYearList();
		DataMap listMap = webzineService.selectComplateList(requestMap);
			
		model.addAttribute("LIST_DATA", listMap);
		model.addAttribute("YEARLIST_DATA", yearListMap);
		
		return findView(requestMap.getString("mode"), "/webzine/complateList");
	}
	
	/**
	 * 사진관리 Row데이터
	 * 작성일 : 7월 2일
	 * 작성자 : 정 윤철
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	public void complateForm(
			Model model
	        , DataMap requestMap) throws Exception {
	
		DataMap rowMap = null;
		
		if(requestMap.getString("qu").equals("modifyComplate") || requestMap.getString("qu").equals("preView")){
			rowMap = webzineService.selectComplateRow(requestMap.getInt("photoNo"));
		}else{
			rowMap = new DataMap();
		}
		model.addAttribute("PHOTOROW_DATA", rowMap);
	}
	
	@RequestMapping(value="/webzine.do", params="mode=complateForm")
	public String complateForm(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			) throws Exception{
		
		DataMap requestMap = cm.getDataMap();
		
		complateForm(model, requestMap);
		
		return  findView(requestMap.getString("mode"), "/webzine/complateForm");
	}
	
	/**
	 * 사진관리 등록 수정 실행
	 * 작성일 : 7월 2일
	 * 작성자 : 정 윤철
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping(value="/webzine.do", params="mode=complateExec")
	public String complateExec(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			) throws Exception{
		
		DataMap requestMap = cm.getDataMap();
		
		DataMap fileMap = (DataMap)requestMap.get("UPLOAD_FILE");
		if(fileMap == null) fileMap = new DataMap();
		fileMap.setNullToInitialize(true);
		
		if(requestMap.getString("qu").equals("insertComplate")){
			
			webzineService.insertInnoUploadFile(fileMap, requestMap.getString("INNO_SAVE_DIR"),requestMap.getString("wcomments"), requestMap.getString("date"));
			requestMap.setString("msg", "등록하였습니다.");
			
		}else if(requestMap.getString("qu").equals("modifyComplate")){
			webzineService.modifyComplate(fileMap, requestMap.getString("INNO_SAVE_DIR"),requestMap.getString("wcomments"), requestMap.getInt("photoNo"),requestMap.getString("imgPath"), requestMap.getString("date"));
			requestMap.setString("msg", "수정하였습니다.");
			
		}
		
		return  findView(requestMap.getString("mode"), "/webzine/complateExec");
	}
	
	@RequestMapping(value="/webzine.do", params="mode=complatePreView")
	public String complatePreView(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			) throws Exception{
		
		DataMap requestMap = cm.getDataMap();
		
		complateForm(model, requestMap);
		
		return  findView(requestMap.getString("mode"), "/webzine/complatePreView");
	}
	
	/**
	 * Ebook관리 리스트
	 * 작성일 : 7월 4일
	 * 작성자 : 정 윤철
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping(value="/webzine.do", params="mode=ebookList")
	public String ebookList(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			) throws Exception{
		
		DataMap requestMap = cm.getDataMap();
		
		if (requestMap.getString("currPage").equals("")) {
			requestMap.setInt("currPage", 1);
		}
		if (requestMap.getString("rowSize").equals("")) {
			requestMap.setInt("rowSize", 5);
		}
		if (requestMap.getString("pageSize").equals("")) {
			requestMap.setInt("pageSize", 10);
		}
		
		DataMap listMap = webzineService.selectEbookList(requestMap);
			
		model.addAttribute("LIST_DATA", listMap);
		
		return findView(requestMap.getString("mode"), "/webzine/ebookList");
	}
	
	/**
	 * Ebook관리 폼데이터
	 * 작성일 : 7월 4일
	 * 작성자 : 정 윤철
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping(value="/webzine.do", params="mode=ebookForm")
	public String ebookForm(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			) throws Exception{
		
		DataMap requestMap = cm.getDataMap();
		
		DataMap rowMap = null;
		
		if(requestMap.getString("qu").equals("modifyEbook")){
			rowMap = webzineService.selectEbookRow(requestMap.getInt("ebookNo"));
		}else{
			rowMap = new DataMap();
		}
		model.addAttribute("EBOOKROW_DATA", rowMap);
		
		return findView(requestMap.getString("mode"), "/webzine/ebookForm");
	}
	
	/**
	 * EBOOK 등록 수정 실행
	 * 작성일 : 7월 4일
	 * 작성자 : 정 윤철
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping(value="/webzine.do", params="mode=ebookExec")
	public String ebookExec(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			) throws Exception{
		
		DataMap requestMap = cm.getDataMap();
		
		DataMap fileMap = (DataMap)requestMap.get("UPLOAD_FILE");
		if(fileMap == null) fileMap = new DataMap();
		fileMap.setNullToInitialize(true);
		
		if(requestMap.getString("qu").equals("insertEbook")){
			webzineService.insertEbook(fileMap, requestMap);
			requestMap.setString("msg", "등록하였습니다.");
			
		}else if(requestMap.getString("qu").equals("modifyEbook")){
			webzineService.modifyEbook(fileMap, requestMap);
			requestMap.setString("msg", "수정하였습니다.");
			
		}else if(requestMap.getString("qu").equals("delete")){
			webzineService.deleteEbook(requestMap);
			requestMap.setString("msg", "삭제 하였습니다.");			
		}
		
		return findView(requestMap.getString("mode"), "/webzine/complateExec");
	}
}
