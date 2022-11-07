package loti.mypage.web;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletResponse;

import loti.mypage.service.PaperService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import ut.lib.exception.BizException;
import ut.lib.login.LoginInfo;
import ut.lib.support.CommonMap;
import ut.lib.support.DataMap;
import ut.lib.util.Util;
import common.controller.BaseController;

@Controller
@RequestMapping("/mypage/paper.do")
public class PaperController extends BaseController {

	@Autowired
	private PaperService paperService;

	@ModelAttribute("cm")
	public CommonMap common(CommonMap cm, Model model, HttpServletResponse response) throws IOException{
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
			System.out.println("로그인 안되어 있음");
			response.sendRedirect("/");
		} else {
			requestMap.setString("userno", loginInfo.getSessNo());
			requestMap.setString("userName", loginInfo.getSessName());
		}

		// 메시지함 구분자가 없는경우 받은 메시지 함으로
		
		if (requestMap.getString("mode").equals("recieve")){
			requestMap.setString("kind","RECIEVE");
		} else if (requestMap.getString("mode").equals("send")){
			requestMap.setString("kind","SEND");
		}
		
		// 리퀘스트 정보를 담고있는 DataMap을 Attribute 에 추가
		model.addAttribute("REQUEST_DATA", requestMap);
		
		log.info("mode="+mode);
		
		return cm;
	}
	
	public void memberList(DataMap requestMap, Model model) throws BizException{
		
		//	초기화 옵션(true 일경우 데이터를 뽑을때 null 일경우 초기화 - 빈문자열, 0....)
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
		
		DataMap listMap = paperService.selectMemberList(requestMap); 
		
		model.addAttribute("LIST_DATA", listMap);
	}
	
	@RequestMapping(params="mode=recieve")
	public String recieve(
				@ModelAttribute("cm") CommonMap cm
				, Model model
			) throws BizException{
		
		DataMap requestMap = cm.getDataMap();
		
		//	초기화 옵션(true 일경우 데이터를 뽑을때 null 일경우 초기화 - 빈문자열, 0....)
		requestMap.setNullToInitialize(true);
		
		// 메시지함 구분자가 없는경우 받은 메시지 함으로
		
		if (requestMap.getString("mode").equals("recieve")){
			requestMap.setString("kind","RECIEVE");
		} else if (requestMap.getString("mode").equals("send")){
			requestMap.setString("kind","SEND");
		}
		
		if (requestMap.getString("currPage").equals("")) {
			requestMap.setInt("currPage", 1);
		}
		if (requestMap.getString("rowSize").equals("")) {
			requestMap.setInt("rowSize", 10);
		}
		if (requestMap.getString("pageSize").equals("")) {
			requestMap.setInt("pageSize", 10);
		}
		
		if (requestMap.getString("kind").equals("RECIEVE")){
			//새로 받은 데이터 받은날자 갱신
			paperService.paperUpdate(requestMap);
		}
		
		DataMap listMap = paperService.selectPaperList(requestMap); 
		
		model.addAttribute("LIST_DATA", listMap);
		
		return "/homepage/mypage/paper/paperList";
	}
	
	@RequestMapping(params="mode=send")
	public String send(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			) throws BizException{
		
		recieve(cm, model);
		
		return "/homepage/mypage/paper/paperList";
	}
	
	@RequestMapping(params="mode=form")
	public String form(
			) throws BizException{
		
		return "/homepage/mypage/paper/paperForm";
	}
	
	
	@RequestMapping(params="mode=memberList")
	public String memberList(
				@ModelAttribute("cm") CommonMap cm
				, Model model
			) throws BizException{
	
		DataMap requestMap = cm.getDataMap(); 
		
		// 등록된 회원명 검색
		if (requestMap.getString("search").length() > 0){
			memberList(requestMap, model );
		}
		return "/homepage/mypage/paper/memSearch";
	}
	
	@RequestMapping(params="mode=exec")
	public String exec(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			) throws BizException{
		
		//	초기화 옵션(true 일경우 데이터를 뽑을때 null 일경우 초기화 - 빈문자열, 0....)
		cm.getDataMap().setNullToInitialize(true);
		
		int iNums = paperService.sendPaper(cm.getDataMap()); 
		
		return "/homepage/mypage/paper/paperExec";
	}
	
	@RequestMapping(params="mode=delete")
	public String delete(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			) throws BizException{
		
		//	초기화 옵션(true 일경우 데이터를 뽑을때 null 일경우 초기화 - 빈문자열, 0....)
		cm.getDataMap().setNullToInitialize(true);
		
		int iNums = paperService.paperDelete(cm.getDataMap()); 
		
		return "/homepage/mypage/paper/paperExec";
	}
	
	@RequestMapping(params="mode=delAll")
	public String delAll(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			) throws BizException{
		
		//	초기화 옵션(true 일경우 데이터를 뽑을때 null 일경우 초기화 - 빈문자열, 0....)
		cm.getDataMap().setNullToInitialize(true);
		
		int iNums = paperService.paperDelAll(cm.getDataMap()); 
		
		return "/homepage/mypage/paper/paperExec";
	}
}
