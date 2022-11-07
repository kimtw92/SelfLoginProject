package loti.homepageMgr.web;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import loti.homepageMgr.service.FaqService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import ut.lib.login.LoginCheck;
import ut.lib.login.LoginInfo;
import ut.lib.support.CommonMap;
import ut.lib.support.DataMap;
import ut.lib.util.Constants;
import ut.lib.util.Util;
import common.controller.BaseController;

@Controller
public class FaqController extends BaseController {

	@Autowired
	private FaqService faqService;
	
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
	
	@RequestMapping(value="/homepageMgr/faq.do")
	public String defaultProcess(
			@ModelAttribute("cm") CommonMap cm
			, Model model
		) throws Exception{
		return list(cm, model);
	}
	
	/**
	 * FAQ 리스트
	 * 작성일 : 6월 5일
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
	
		//	초기화 옵션(true 일경우 데이터를 뽑을때 null 일경우 초기화 - 빈문자열, 0....)
		requestMap.setNullToInitialize(true);
		
		if (requestMap.getString("currPage").equals("")) {
			requestMap.setInt("currPage", 1);
		}
		if (requestMap.getString("rowSize").equals("")) {
			requestMap.setInt("rowSize", 15);
		}
		if (requestMap.getString("pageSize").equals("")) {
			requestMap.setInt("pageSize", 10);
		}
		
		DataMap listMap = faqService.selectFaqList(requestMap);
		DataMap faqListMap = faqService.selectSubCodeFaqList();
		
		model.addAttribute("LIST_DATA", listMap);
		model.addAttribute("FAQLIST_DATA", faqListMap);
	}
	
	@RequestMapping(value="/homepageMgr/faq.do", params="mode=list")
	public String list(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			) throws Exception{
		
		DataMap requestMap = cm.getDataMap();
		
		list(model, requestMap);
		
		return findView(requestMap.getString("mode"), "/homepageMgr/faq/faqList");
	}
	
	/**
	 * FAQ 상세페이지
	 * 작성일 : 6월 13일
	 * 작성자 : 정 윤철
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	public void selectFaqViewRow(
			Model model
	        , DataMap requestMap) throws Exception {
	
		//	초기화 옵션(true 일경우 데이터를 뽑을때 null 일경우 초기화 - 빈문자열, 0....)
		requestMap.setNullToInitialize(true);
		
		DataMap faqRowMap = faqService.selectFaqViewRow(requestMap.getString("fno"));
		
		//카운터수 수정
		faqService.modifyFaqFno(requestMap.getInt("fno"));
		
		model.addAttribute("FAQROW_DATA", faqRowMap);
	}
	
	@RequestMapping(value="/homepageMgr/faq.do", params="mode=view")
	public String view(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			) throws Exception{
		
		DataMap requestMap = cm.getDataMap();
		
		selectFaqViewRow(model, requestMap);
		
		return findView(requestMap.getString("mode"), "/homepageMgr/faq/faqView");
	}
	
	/**
	 * FAQ 폼
	 * 작성일 : 6월 13일
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
	
		//	초기화 옵션(true 일경우 데이터를 뽑을때 null 일경우 초기화 - 빈문자열, 0....)
		requestMap.setNullToInitialize(true);

		DataMap faqRowMap = null;
		
		if(requestMap.getString("qu").equals("insertFaq")){
			faqRowMap = new DataMap();
		}else{
			faqRowMap = faqService.selectFaqViewRow(requestMap.getString("fno"));
		}
		
		DataMap faqListMap = faqService.selectSubCodeFaqList();
		model.addAttribute("FAQLIST_DATA", faqListMap);
		
		model.addAttribute("FAQROW_DATA", faqRowMap);
	}
	
	@RequestMapping(value="/homepageMgr/faq.do", params="mode=form")
	public String form(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			) throws Exception{
		
		DataMap requestMap = cm.getDataMap();
		
		form(model, requestMap);
		
		return findView(requestMap.getString("mode"), "/homepageMgr/faq/faqForm");
	}
	
	/**
	 * FAQ 등록
	 * 작성일 : 6월 13일
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
	
		DataMap faqRowMap = null;
		if(!requestMap.getString("qu").equals("modifyFaqUseYn")){
			//사용여부 수정이 아닐경우 나모 데이터를 처리한다.
//			Util.saveNamoContent(requestMap, "content", "namoContent", Constants.NAMOUPLOAD_FAQ); //나모로 넘어온값 처리.
			Util.saveDaumContent(requestMap, "content", "namoContent", Constants.NAMOUPLOAD_FAQ); //나모로 넘어온값 처리.
			
		}
		
		if(requestMap.getString("qu").equals("insertFaq")){
			//fno넘버값을 가져온다.
			int fno = faqService.selectFaqFnoRow();
			
			//인서트 시작
			faqService.insertFaq(requestMap, fno);
			requestMap.setString("msg","등록하였습니다.");
			
			//등록후 이동할 뷰페이지 넘버
			requestMap.setInt("fno", fno);
			
		}else if(requestMap.getString("qu").equals("modifyFaqUseYn")){
			//사용여부 수정
			faqService.modifyFaqUseYn(requestMap.getInt("fno"), requestMap.getString("useYn"));
			requestMap.setString("msg","수정하였습니다.");
		}else if(requestMap.getString("qu").equals("modifyFaq")){
			
			//fno정의
			int fno = requestMap.getInt("fno");
			//수정 시작
			faqService.modifyFaq(requestMap, fno);
			requestMap.setString("msg","수정하였습니다.");
			
			//등록후 이동할 뷰페이지 넘버
			requestMap.setInt("fno", fno);
			
		}else if(requestMap.getString("qu").equals("deleteFaq")){
			//fno정의
			int fno = requestMap.getInt("fno");
			//수정 시작
			faqService.deleteFaq(fno);
			requestMap.setString("msg","삭제하였습니다..");
			
		}
		
		
		model.addAttribute("FAQROW_DATA", faqRowMap);
	}
	
	@RequestMapping(value="/homepageMgr/faq.do", params="mode=exec")
	public String exec(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			) throws Exception{
		
		DataMap requestMap = cm.getDataMap();
		
		exec(model, requestMap);
		
		return findView(requestMap.getString("mode"), "/homepageMgr/faq/faqExec");
	}
}
