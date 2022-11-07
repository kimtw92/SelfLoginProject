package loti.poll.web;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import loti.poll.service.PollBankService;

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
public class PollBankController extends BaseController {

	@Autowired
	private PollBankService pollBankService;
	
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
	
	@RequestMapping(value="/poll/pollBank.do")
	public String defaultProcess(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			) throws Exception{
		return list(cm, model);
	}
	@RequestMapping(value="/poll/pollBank.do", params="mode=list")
	public String list(
				@ModelAttribute("cm") CommonMap cm
				, Model model
			) throws Exception{
		
		DataMap requestMap = cm.getDataMap();
		
		if (requestMap.getString("currPage").equals(""))	requestMap.setInt("currPage", 1); //페이지
		if (requestMap.getString("rowSize").equals(""))		requestMap.setInt("rowSize", 20); //페이지당 보여줄 갯수
		if (requestMap.getString("pageSize").equals("")) 	requestMap.setInt("pageSize", 10); //페이지 블럭 갯수
		
		//설문 리스트
		DataMap listMap = pollBankService.selectGrinqBankQuestionBySearchDescList(requestMap.getString("searchKey"), requestMap.getString("searchValue"), requestMap);
		
		model.addAttribute("LIST_DATA", listMap);
		
		return findView(requestMap.getString("mode"), "/poll/pollBank/pollBankList");
	}
	
	@RequestMapping(value="/poll/pollBank.do", params="mode=form")
	public String form(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			) throws Exception{
		
		DataMap requestMap = cm.getDataMap();
		
		DataMap rowMap = null;
		if( requestMap.getString("qu").equals("insert") ){
			rowMap = new DataMap();
		}else{
			//설문 상세 정보
			rowMap = pollBankService.selectGrinqBankQuestionByInSampRow(requestMap.getInt("questionNo"));
		}

		model.addAttribute("ROW_DATA", rowMap);
		
		return findView(requestMap.getString("mode"), "/poll/pollBank/pollBankForm");
	}
	
	@RequestMapping(value="/poll/pollBank.do", params="mode=show_mini")
	public String show_mini(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			) throws Exception{
		
		DataMap requestMap = cm.getDataMap();
		
		//설문 리스트
		DataMap listMap = pollBankService.selectGrinqBankQuestionByNoEqualsSampList(requestMap.getInt("questionNo"));
		
		model.addAttribute("LIST_DATA", listMap);
		
		return findView(requestMap.getString("mode"), "/poll/pollBank/pollBankShowMiniListPop");
	}
	
	@RequestMapping(value="/poll/pollBank.do", params="mode=exec")
	public String exec(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			) throws Exception{
		
		DataMap requestMap = cm.getDataMap();
		
		//사용자 정보 추출.
		LoginInfo loginInfo = cm.getLoginInfo();
		
		String msg = ""; //결과 메세지.

		if(requestMap.getString("qu").equals("insert")){ //설문 미리보기 등록 실행
			
			int result = pollBankService.insertGrinqBankQuestion(requestMap, loginInfo.getSessNo());
			if(result > 0)
				msg = "설문이 완료되었습니다.";
			else
				msg = "실패";
			
		}else if(requestMap.getString("qu").equals("update")){ //수정
			
			int result = pollBankService.updateGrinqBankQuestion(requestMap, loginInfo.getSessNo());
			if(result > 0)
				msg = "설문이 수정되었습니다.";
			else
				msg = "실패";
			
		}else if(requestMap.getString("qu").equals("delete")){ //삭제
			
			int result = pollBankService.deleteBankQuestion(requestMap);
			if(result > 0)
				msg = "삭제 되었습니다.";
			else
				msg = "실패";
		}
		
		model.addAttribute("RESULT_MSG", msg);
		
		return findView(requestMap.getString("mode"), "/poll/pollBank/pollBankExec");
	}
}
