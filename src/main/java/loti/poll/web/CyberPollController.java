package loti.poll.web;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import loti.poll.service.CyberPollService;

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
public class CyberPollController extends BaseController {

	@Autowired
	private CyberPollService cyberPollService;
	
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
		
		return cm;
	}
	
	public String findView(String mode, String defaultView){
		return defaultView;
	}
	
	@RequestMapping(value="/poll/homepage.do")
	public String defaultProcess(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			) throws Exception{
		return list(cm, model);
	}
	@RequestMapping(value="/poll/homepage.do", params="mode=list")
	public String list(
				@ModelAttribute("cm") CommonMap cm
				, Model model
			) throws Exception{
		
		DataMap requestMap = cm.getDataMap();
		
		if (requestMap.getString("currPage").equals("")) {
			requestMap.setInt("currPage", 1);
		}
		if (requestMap.getString("rowSize").equals("")) {
			requestMap.setInt("rowSize", 15);
		}
		if (requestMap.getString("pageSize").equals("")) {
			requestMap.setInt("pageSize", 10);
		}
		
		DataMap listMap = cyberPollService.selectCyberPollList(requestMap);
		model.addAttribute("LIST_DATA", listMap);
		
		return findView(requestMap.getString("mode"), "/poll/homepage/cyberPollList");
	}
	
	@RequestMapping(value="/poll/homepage.do", params="mode=form")
	public String form(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			) throws Exception{
		
		DataMap requestMap = cm.getDataMap();
		
		DataMap rowMap = null;
		if(requestMap.getString("qu").equals("insert")){
			rowMap = new DataMap();
		}else if(requestMap.getString("qu").equals("modify")){
			rowMap = cyberPollService.selectCyberPollTitleRow(requestMap.getInt("titleNo"));
		}
		
		model.addAttribute("INQTTLROW_DATA", rowMap);
		
		return findView(requestMap.getString("mode"), "/poll/homepage/cyberPollForm");
	}
	
	@RequestMapping(value="/poll/homepage.do", params="mode=subForm")
	public String subForm(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			) throws Exception{
		
		DataMap requestMap = cm.getDataMap();
		
		DataMap inqSamMap = null;
		DataMap questionListMap = null;
		DataMap questionRowMap = null;
		
		//타이틀에 속해 있는 질문 번호를 가져온다.
		DataMap questNo = cyberPollService.selectCyberPollQuestionNoRow(requestMap.getInt("titleNo"));
		
		//질문 리스트
		questionListMap = cyberPollService.selectCyberPollInqQustionList(requestMap.getInt("titleNo"));
		
		if(!requestMap.getString("qu").equals("insertSamp")){
			
			if(questionListMap.keySize() > 0){
				
				if(!requestMap.getString("questionNo").equals("")){//페이지로부터 질문넘버가 넘어왔을경우.
					inqSamMap = cyberPollService.selectCyberPollInqSampRow(requestMap.getInt("titleNo"), requestMap.getInt("questionNo"));
		
				}else{//없을경우
					inqSamMap = cyberPollService.selectCyberPollInqSampRow(requestMap.getInt("titleNo"), questNo.getInt("questionNo"));
					//현재 가지고있는 데이터의 넘버값을 셋시킨다. 이유는 현재 선택된 값의 리스트를 여주기 위해서 이다.
					requestMap.setString("questionNo",questNo.getString("questionNo"));
		
				}
	
				//질문 상세정보
				questionRowMap = cyberPollService.selectCyberPollInqQustionRow(requestMap.getInt("titleNo"), requestMap.getInt("questionNo"));
				

			}else{		
					questionListMap = new DataMap();
					inqSamMap = new DataMap();
					questionRowMap = new DataMap();
			
			}

		}else{//등록폼일경우
			inqSamMap = new DataMap();
			questionRowMap = new DataMap();
			
		}
		
		
		model.addAttribute("INQSAMPROW_DATA", inqSamMap);
		model.addAttribute("QUESTIONROW_DATA", questionRowMap);
		model.addAttribute("QUESTIONLIST_DATA", questionListMap);
		
		return findView(requestMap.getString("mode"), "/poll/homepage/cyberPollSubForm");
	}
	
	@RequestMapping(value="/poll/homepage.do", params="mode=resultPop")
	public String resultPop(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			) throws Exception{
		
		DataMap requestMap = cm.getDataMap();
		
		DataMap rowMap = null;
		
		rowMap = cyberPollService.selectHtmlPreviewPop(requestMap.getInt("titleNo"));
		
		model.addAttribute("VIEWLIST_DATA", rowMap);
		
		return findView(requestMap.getString("mode"), "/poll/homepage/cyberPollResultPop");
	}
	
	@RequestMapping(value="/poll/homepage.do", params="mode=previewPop")
	public String previewPop(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			) throws Exception{
		
		DataMap requestMap = cm.getDataMap();
		
		DataMap rowMap = null;

		String subTitle = cyberPollService.selectSubTitleCyberRow(requestMap.getInt("titleNo"));
		rowMap = cyberPollService.selectPreviewPop(requestMap.getInt("titleNo"));
		
		int answerCnt = 0;
		int nameCnt = 0;
		int nameTotalCnt = 0;
		if(rowMap.keySize() > 0){
			for(int i = 0; rowMap.keySize() > i; i++){
				if(rowMap.getString("pflag", i).equals("A")){
					for(int j = 0; j < rowMap.getInt("answerCnt", i); j++){
						answerCnt = cyberPollService.selectAnswerNoCount(
								rowMap.getInt("titleNo", i), 
								rowMap.getInt("questionNo", i), 
								(j+1));
						rowMap.addInt("questionCnt_"+nameCnt, answerCnt);
						nameCnt++;
					}
					
					
					
					for(int j = 0; j < 1; j++){
						answerCnt = cyberPollService.selectAnswerTotalNoCount(
								rowMap.getInt("titleNo", i), 
								rowMap.getInt("questionNo", i));
						rowMap.addInt("questionTotalCnt_"+nameTotalCnt, answerCnt);		
					}
				}
			}
		}
		requestMap.setString("subTitle", subTitle);
		rowMap.setInt("nameCnt", nameCnt);
		model.addAttribute("VIEWLIST_DATA", rowMap);
		
		return findView(requestMap.getString("mode"), "/poll/homepage/cyberPollPreviewPop");
	}
	
	@RequestMapping(value="/poll/homepage.do", params="mode=exec")
	public String exec(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			) throws Exception{
		
		DataMap requestMap = cm.getDataMap();
		
		//	초기화 옵션(true 일경우 데이터를 뽑을때 null 일경우 초기화 - 빈문자열, 0....)
		requestMap.setNullToInitialize(true);
		
		DataMap faqRowMap = null;
		//성공유부 리턴 변수 
		int returnValue = 0;
		if(!requestMap.getString("qu").equals("delete")){
			//삭제 모드가 아닐경우 디코딩 해준다
//			Util.saveNamoContent(requestMap, "guideText", "namoContent", Constants.NAMOUPLOAD_FAQ); //나모로 넘어온값 처리.
			Util.saveDaumContent(requestMap, "guideText", "namoContent", Constants.NAMOUPLOAD_FAQ); //나모로 넘어온값 처리.
		}
		
		if(requestMap.getString("qu").equals("insertTitleInfo")){
			
			int titleNo = cyberPollService.selectCyberPollMaxTitleNo();
			requestMap.setInt("titleNo", titleNo);
			
			int questionNo = cyberPollService.selectCyberPollMaxQuestionNo(titleNo);
			requestMap.setInt("questionNo", questionNo);
			
			/***********************************등록[S]****************************************************/
			
			//설문 타이틀 테이블에  등록 TALBE : TB_INQ_TTL
			returnValue = cyberPollService.insertCyberPollTitleInfo(requestMap);
			
			/***********************************등록[E]****************************************************/
			
			if(returnValue > 0){//성공여부 메시지 처리
				requestMap.setString("msg","등록 하였습니다.");
				
			}else{
				requestMap.setString("msg","실패 하였습니다..");
				
			}
			
		}else if(requestMap.getString("qu").equals("titleInfoModify")){
			//수정시작
			returnValue = cyberPollService.modifyCyberPollTitleInfo(requestMap);
			
			if(returnValue > 0){//성공여부 메시지 처리
				requestMap.setString("msg","수정 하였습니다.");
				
			}else{
				requestMap.setString("msg","실패 하였습니다..");
				
			}
			
		}
		
		model.addAttribute("FAQROW_DATA", faqRowMap);
		
		return findView(requestMap.getString("mode"), "/poll/homepage/cyberPollExec");
	}
	
	@RequestMapping(value="/poll/homepage.do", params="mode=subExec")
	public String subExec(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			) throws Exception{
		
		DataMap requestMap = cm.getDataMap();
		
		int returnValue = 0;

		if(requestMap.getString("qu").equals("insertSamp")){
			//설문 질문,항목 등록
			returnValue = cyberPollService.insertCyberPollQuestion(requestMap);
			
			if(returnValue 	== 1){
				requestMap.setString("msg", "등록하였습니다.");
				
			}else{
				requestMap.setString("msg", "실패하였습니다.");
				
			}
			
		}else if(requestMap.getString("qu").equals("deleteSamp")){ //항목 삭제 
			returnValue = cyberPollService.deleteSampRow(requestMap);
			
			if(returnValue == 1){
				requestMap.setString("msg", "삭제하였습니다.");
				
			}else if(returnValue == 2){
				requestMap.setString("msg", "설문에대한 답변이 있어서 삭제 할 수 없습니다.");
				
			}else if(returnValue == 0){
				requestMap.setString("msg", "실패하였습니다.");
				
			}
			
		}else if(requestMap.getString("qu").equals("allDelete")){//글전체 삭제
			returnValue = cyberPollService.deleteTtl(requestMap);
			if(returnValue == 1){
				requestMap.setString("msg", "삭제하였습니다.");
				
			}else if(returnValue == 2){
				requestMap.setString("msg", "설문에대한 답변이 있어서 삭제 할 수 없습니다.");
				
			}else if(returnValue == 0){
				requestMap.setString("msg", "실패하였습니다.");
				
			}
			
		}else if(requestMap.getString("qu").equals("resultInsert")){
			//설문답변
			returnValue = cyberPollService.resultInsert(requestMap);
			
			if(returnValue == 1){
				requestMap.setString("msg", "등록하였습니다.");
				
			}else if(returnValue == 3){
				requestMap.setString("msg", "이미 답변을 하셨습니다.");
				
			}else{
				requestMap.setString("msg", "실패하였습니다.");
				
			}
		}else{
			//설문 질문,항목 수정
			returnValue = cyberPollService.modifyCyberPollQuestion(requestMap);
			
			if(returnValue == 1){
				requestMap.setString("msg", "수정하였습니다.");
				
			}else if(returnValue == 2){
				requestMap.setString("msg", "설문에대한 답변이 있어서 수정 할 수 없습니다.");
				
			}else if(returnValue == 0){
				requestMap.setString("msg", "실패하였습니다.");
				
			}
			
		}
		
		return findView(requestMap.getString("mode"), "/poll/homepage/cyberPollExec");
	}
}
