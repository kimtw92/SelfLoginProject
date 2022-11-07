package loti.homeFront.web;

import loti.homeFront.service.EBookService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import ut.lib.exception.BizException;
import ut.lib.login.LoginInfo;
import ut.lib.support.CommonMap;
import ut.lib.support.DataMap;
import ut.lib.util.Util;

import common.controller.BaseController;

@Controller
public class EBookController extends BaseController{

	@Autowired
	private EBookService eBookService;
	
	@RequestMapping(value="/homepage/ebook.do", params="mode=eduinfo6-1")
	public String eduinfo61(CommonMap cm, Model model) throws BizException{

		/**
		 * 필수
		 */
		DataMap requestMap = cm.getDataMap();
		requestMap.setNullToInitialize(true);				
		String mode = Util.getValue(requestMap.getString("mode"));			
		
		
		/**
		 * 로그인 체크
		 */
		LoginInfo loginInfo = (LoginInfo)cm.getRequest().getAttribute("LOGIN_INFO");
		if(loginInfo.isLogin() == false){
			// 로그인 안되어 있음
			//System.out.println("로그인 안되어 있음");
		}
		
		
		
		if(mode.equals("eduinfo6-1")){
			// EBook list
			eBookList( requestMap, model );				
		}
		
		
		
		// 리퀘스트 정보를 담고있는 DataMap을 Attribute 에 추가
		model.addAttribute("REQUEST_DATA", requestMap);
		
		System.out.println("mode="+mode);
		
		return "/homepage/eduInfo/eduinfo6-1";
	}
	
	void eBookList(DataMap requestMap, Model model) throws BizException{
		
		DataMap listMap = null;
		
		/**
		 * 페이징 필수
		 */
		// 페이지
		if (requestMap.getString("currPage").equals("")){
			requestMap.setInt("currPage", 1);
		}
		// 페이지당 보여줄 갯수
		if (requestMap.getString("rowSize").equals("")){
			requestMap.setInt("rowSize", 4); 
		}
		// 페이지 블럭 갯수
		if (requestMap.getString("pageSize").equals("")){
			requestMap.setInt("pageSize", 10);
		}
		
		listMap = eBookService.ebookList(requestMap);
		
		model.addAttribute("LIST_DATA", listMap);
	}
}
