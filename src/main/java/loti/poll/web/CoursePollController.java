package loti.poll.web;

import java.io.File;
import java.util.Date;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import loti.common.service.CommonService;
import loti.courseMgr.service.CourseSeqService;
import loti.poll.service.CoursePollService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import ut.lib.exception.BizException;
import ut.lib.login.LoginCheck;
import ut.lib.login.LoginInfo;
import ut.lib.support.CommonMap;
import ut.lib.support.DataMap;
import ut.lib.util.Constants;
import ut.lib.util.DateUtil;
import ut.lib.util.SpringUtils;
import ut.lib.util.Util;
import common.controller.BaseController;

@Controller
public class CoursePollController extends BaseController {

	@Autowired
	private CoursePollService coursePollService;
	
	@Autowired
	private CourseSeqService courseSeqService;
	
	@Autowired
	private CommonService commonService;
	
	@ModelAttribute("cm")
	public CommonMap common(
				CommonMap cm
				, HttpServletRequest request
				, HttpServletResponse response
				, HttpSession session
				, Model model
			) throws Exception{
		
		 //요청처리 - get, post 방식의 파라미터를 DataMap 에 저장
		DataMap requestMap = cm.getDataMap();
		//초기화 옵션(true 일경우 데이터를 뽑을때 null 일경우 초기화 - 빈문자열, 0....)
		requestMap.setNullToInitialize(true);
		
		//default mode
		if(requestMap.getString("mode").equals(""))
			requestMap.setString("mode", "list");
		String mode = requestMap.getString("mode");
		
		
		//관리자 로그인 체크. (관리자 페이지에는 모두 있어야 함)
		LoginInfo memberInfo = LoginCheck.adminCheck(request, response, requestMap.getString("menuId"));
		if (memberInfo == null) return null;
		
		
		
		//공통 Comm Select Box 값 초기 셋팅.
		if(requestMap.getString("commYear").equals(""))
			requestMap.setString("commYear", (String)session.getAttribute("sess_year"));
		if( !mode.equals("noneChkPollCyberList") && !mode.equals("cyber_list") ){
			if(requestMap.getString("commGrcode").equals(""))
				requestMap.setString("commGrcode", (String)session.getAttribute("sess_grcode"));
			if(requestMap.getString("commGrseq").equals(""))
				requestMap.setString("commGrseq", (String)session.getAttribute("sess_grseq"));
		}
		
		//리퀘스트 정보를 담고있는 DataMap을 Attribute 에 추가
		model.addAttribute("REQUEST_DATA", requestMap);
		
		return cm;
	}
	
	public String findView(String mode, String defaultView){
		return defaultView;
	}
	
	@RequestMapping(value="/poll/coursePoll.do")
	public String defaultProcess(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			) throws Exception{
		return list(cm, model);
	}
	@RequestMapping(value="/poll/coursePoll.do", params="mode=list")
	public String list(
				@ModelAttribute("cm") CommonMap cm
				, Model model
			) throws Exception{
		
		DataMap requestMap = cm.getDataMap();
		
		//설문 리스트
		DataMap listMap = coursePollService.selectGrinqTtlBySearchList(requestMap.getString("commGrcode"), requestMap.getString("commGrseq"), requestMap);
		
		requestMap.setString("commGrcode", requestMap.getString("commGrcode"));
		requestMap.setString("commGrseq", requestMap.getString("commGrseq"));
		
		//과정 기수 정보.
		DataMap grseqMap = courseSeqService.selectGrseqSimpleRow(requestMap);
		
		model.addAttribute("GRSEQ_ROW_DATA", grseqMap);
		model.addAttribute("LIST_DATA", listMap);
		
		return findView(requestMap.getString("mode"), "/poll/course/coursePollList");
	}
	
	@RequestMapping(value="/poll/coursePoll.do", params="mode=form")
	public String form(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			) throws Exception{
		
		DataMap requestMap = cm.getDataMap();
		
		//설문지 정보
		DataMap rowMap = null;
		DataMap setListMap = null; //작성된 설문 세트  List
		DataMap normalSubjList = null; //일반 과목  List
		DataMap needPollMap = null; //필수 항목 목록
		DataMap commPollMap = null; //공통 항목 목록
		DataMap subjPollMap = null; //과목 항목 목록
		
		String chioceSubjSelStr = "";
		
		if(requestMap.getString("qu").equals("update")){ //수정이면
			
			rowMap = coursePollService.selectGrinqTtlRow(requestMap.getInt("titleNo"));
			if(rowMap == null) rowMap = new DataMap();
			rowMap.setNullToInitialize(true);
			
			setListMap = coursePollService.selectGrinqQuestionSetByTtlList(requestMap.getInt("titleNo"));
			normalSubjList = coursePollService.selectGrinqTtlByTimeTableSubjList(requestMap.getString("grcode"), requestMap.getString("grseq"), requestMap.getInt("titleNo"));
			
			needPollMap = coursePollService.selectGrinqBankQuestionByGubunSearchList("need", "");
			commPollMap = coursePollService.selectGrinqBankQuestionByGubunSearchList("comm", rowMap.getString("questionCommGubun"));
			subjPollMap = coursePollService.selectGrinqBankQuestionByGubunSearchList("subj", "");
			chioceSubjSelStr = commonService.commChoiceSubjSelectBoxStr(requestMap.getString("grcode"), requestMap.getString("grseq"), "");
			
		}else{
			rowMap = new DataMap();
			setListMap = new DataMap();
			normalSubjList = new DataMap();
			
			needPollMap = new DataMap();
			commPollMap = new DataMap();
			subjPollMap = new DataMap();
			
		}
		
		//과정 기수 정보.
		DataMap grseqMap = courseSeqService.selectGrseqSimpleRow(requestMap);
		
		model.addAttribute("ROW_DATA", rowMap);
		model.addAttribute("SET_LIST_DATA", setListMap);
		model.addAttribute("SUBJ_LIST_DATA", normalSubjList);
		
		model.addAttribute("NEED_POLL_LIST_DATA", needPollMap);
		model.addAttribute("COMM_POLL_LIST_DATA", commPollMap);
		model.addAttribute("SUBJ_POLL_LIST_DATA", subjPollMap);
		model.addAttribute("CHIOCE_SUBJ_OPTION_STRING", chioceSubjSelStr);
		
		model.addAttribute("GRSEQ_ROW_DATA", grseqMap);
		
		return findView(requestMap.getString("mode"), "/poll/course/coursePollForm");
	}
	
	@RequestMapping(value="/poll/coursePoll.do", params="mode=notapply_pop")
	public String notapply_pop(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			) throws Exception{
		
		DataMap requestMap = cm.getDataMap();
		
		//미응시자  리스트
		DataMap listMap = coursePollService.selectGrinqByNotApplyList(requestMap.getString("grcode"), requestMap.getString("grseq"), requestMap.getInt("titleNo"));
		
		
		model.addAttribute("LIST_DATA", listMap);
		
		return findView(requestMap.getString("mode"), "/poll/course/coursePollNotApplyPop");
	}
	
	@RequestMapping(value="/poll/coursePoll.do", params="mode=total_result")
	public String total_result(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			) throws Exception{
		
		DataMap requestMap = cm.getDataMap();
		
		//설문 결과 리스트
		DataMap listMap = coursePollService.selectGrinqGrseqTotalResultList(requestMap.getString("grcode"));
		
		//설문 결과과목 리스트
		DataMap subjListMap = coursePollService.selectGrinqGrseqTotalResultByTutorList(requestMap.getString("grcode"));
		
		//과정 기수 정보.
		DataMap grseqMap = courseSeqService.selectGrseqSimpleRow(requestMap);
		
		model.addAttribute("GRSEQ_ROW_DATA", grseqMap);
		model.addAttribute("LIST_DATA", listMap);
		model.addAttribute("SUBJ_LIST_DATA", subjListMap);
		
		return findView(requestMap.getString("mode"), "/poll/course/coursePollTotalResultPop");
	}
	
	@RequestMapping(value="/poll/coursePoll.do", params="mode=tutor_poll_excel")
	public String tutor_poll_excel(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			) throws Exception{
		
		DataMap requestMap = cm.getDataMap();
		
		//설문 리스트
		DataMap listMap = coursePollService.selectGrinqQuestionSetByTutorSubjList(requestMap.getInt("titleNo"), requestMap.getInt("setNo"));
		
		model.addAttribute("LIST_DATA", listMap);
		
		return findView(requestMap.getString("mode"), "/poll/course/coursePollByExcel");
	}
	
	@RequestMapping(value="/poll/coursePoll.do", params="mode=tutor_result_excel")
	public String tutor_result_excel(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			) throws Exception{
		
		DataMap requestMap = cm.getDataMap();
		
		//설문 리스트
		DataMap listMap = coursePollService.selectGrinqQuestionSetByTutorSubjList(requestMap.getInt("titleNo"), requestMap.getInt("setNo"));
		
		//설문 응답 결과 리스트
		DataMap listResultMap = coursePollService.selectGrinqQuestionSetByRequstList(requestMap.getInt("titleNo"), requestMap.getInt("setNo"));
		
		model.addAttribute("LIST_DATA", listMap);
		model.addAttribute("LIST_RESULT_DATA", listResultMap);
		
		
		return findView(requestMap.getString("mode"), "/poll/course/coursePollStatByExcel");
	}
	
	@RequestMapping(value="/poll/coursePoll.do", params="mode=www_poll_preview")
	public String www_poll_preview(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			) throws Exception{
		
		DataMap requestMap = cm.getDataMap();
		
		//설문 리스트
		DataMap listMap = coursePollService.selectGrinqQuestionSetByAddSampList(requestMap.getInt("titleNo"), requestMap.getInt("setNo"));
		
		//설문 내용
		DataMap rowMap = coursePollService.selectGrinqTtlRow(requestMap.getInt("titleNo"));
		
		model.addAttribute("ROW_DATA", rowMap);
		model.addAttribute("LIST_DATA", listMap);
		
		return findView(requestMap.getString("mode"), "/poll/course/wwwPollPreviewPop");
	}
	
	@RequestMapping(value="/poll/coursePoll.do", params="mode=poll_result_preview")
	public String poll_result_preview(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			) throws Exception{
		
		DataMap requestMap = cm.getDataMap();
		
		//설문 결과 리스트
		DataMap listMap = coursePollService.selectGrinqQuestionSetByAddSampResultList(requestMap.getInt("titleNo"), requestMap.getInt("setNo"));
		
		//설문 내용
		DataMap rowMap = coursePollService.selectGrinqTtlRow(requestMap.getInt("titleNo"));
		
		model.addAttribute("ROW_DATA", rowMap);
		model.addAttribute("LIST_DATA", listMap);
		
		return findView(requestMap.getString("mode"), "/poll/course/coursePollResultPreviewPop");
	}
	
	@RequestMapping(value="/poll/coursePoll.do", params="mode=poll_result_answer")
	public String poll_result_answer(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			) throws Exception{
		
		DataMap requestMap = cm.getDataMap();
		
		//설문 결과 리스트
		DataMap listMap = coursePollService.selectGrinqAnswerByTxtList(requestMap.getInt("titleNo"), requestMap.getInt("questionNo"), requestMap.getInt("setNo"));
		
		model.addAttribute("LIST_DATA", listMap);
		
		return findView(requestMap.getString("mode"), "/poll/course/coursePollResultAnswerPop");
	}
	
	@RequestMapping(value="/poll/coursePoll.do", params="mode=etc_exec")
	public String etc_exec(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			) throws Exception{
		
		DataMap requestMap = cm.getDataMap();
		
		//사용자 정보 추출.
		LoginInfo loginInfo = cm.getLoginInfo();
		
		String msg = ""; //결과 메세지.
		

		if(requestMap.getString("qu").equals("www_preview")){ //설문 미리보기 등록 실행
			
			//이미 참여 했는지 확인.
			int result = coursePollService.selectGrinqAnswerBySetUserChk(requestMap.getInt("titleNo"), requestMap.getInt("setNo"), loginInfo.getSessNo());

			if(result > 0){
				
				msg = "이미 설문에 참여 하셨습니다.";
				
			}else{
				
				DataMap ttlMap = coursePollService.selectGrinqTtlRow(requestMap.getInt("titleNo"));
				if(ttlMap == null){
					
					msg = "실패";
				}else{
					ttlMap.setNullToInitialize(true);
					
					if(!ttlMap.getString("sdate").equals("") && ttlMap.getString("sdate").length() == 8 
							&& !ttlMap.getString("sdateHh").equals("") && ttlMap.getString("sdateHh").length() == 2 
							&& !ttlMap.getString("sdateMm").equals("") && ttlMap.getString("sdateMm").length() == 2 
							&& !ttlMap.getString("edate").equals("") && ttlMap.getString("edate").length() == 8 
							&& !ttlMap.getString("edateHh").equals("") && ttlMap.getString("edateHh").length() == 2 
							&& !ttlMap.getString("edateMm").equals("") && ttlMap.getString("edateMm").length() == 2 ){
						
						//설문 삭제.
						long sDate = Long.parseLong(ttlMap.getString("sdate") + ttlMap.getString("sdateHh") + ttlMap.getString("sdateMm")+"00");
						long eDate = Long.parseLong(ttlMap.getString("edate") + ttlMap.getString("edateHh") + ttlMap.getString("edateMm")+"59");
						
						if( sDate > Long.parseLong(DateUtil.getDateTimeMinSec())){
							msg = "설문조사 예정입니다.";
							result = -1;
						}
						
						if( eDate < Long.parseLong(DateUtil.getDateTimeMinSec())){
							msg = "설문조사가 종료되었습니다";
							result = -1;
						}
						
						if(result != -1){
							
							DataMap listMap = coursePollService.selectGrinqQuestionSetByAddSampList(requestMap.getInt("titleNo"), requestMap.getInt("setNo"));
							if(listMap != null){
								
								result = coursePollService.insertGrinqAnser(requestMap, listMap, loginInfo.getSessNo());
								if(result > 0)
									msg = "설문이 완료되었습니다.";
								else
									msg = "실패";
							}else
								msg = "실패";
						}
					}else
						msg = "실패";
				}
				
			}	
			
		}else if(requestMap.getString("qu").equals("update")){ //과정 설문 수정
			
		}
		
		model.addAttribute("RESULT_MSG", msg);
		
		return findView(requestMap.getString("mode"), "/poll/course/coursePollEtcExec");
	}
	
	@RequestMapping(value="/poll/coursePoll.do", params="mode=exec")
	public String exec(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			) throws Exception{
		
		DataMap requestMap = cm.getDataMap();
		
		
		//사용자 정보 추출.
		LoginInfo loginInfo = cm.getLoginInfo();
		requestMap.setString("luserno", loginInfo.getSessNo());	
		
		
		String msg = ""; //결과 메세지.
		
		String qu = requestMap.getString("qu");

		if(qu.equals("insert")){ //과정 설문 등록
			
			//등록
			int result = coursePollService.insertGrinqTtl(requestMap);
			
			if(result > 0)
				msg = "입력이 완료되었습니다.";
			else
				msg = "실패";
				
			
		}else if(qu.equals("update")){ //과정 설문 수정
			
			//응답자가 있을경우는 삭제 불가
			/*
			int result = service.selectGrinqAnswerChk(requestMap.getInt("titleNo"));

			if(result > 0){
				
				msg = "이미 설문이 진행되어 삭제가 불가합니다";
				
			}else{
				
				//설문 수정 및 세트 추가.
				result = service.updateGrinqTtl(requestMap);
				
				if(result > 0){
					if(requestMap.getString("setOn").equals("on"))
						msg = "설문세트가 구성 되었습니다.";
					else
						msg = "수정  되었습니다.";
				}else
					msg = "실패";
				
			}*/	
			
			//설문 수정 및 세트 추가.
			int result = coursePollService.updateGrinqTtl(requestMap);
			
			if(result > 0){
				if(requestMap.getString("setOn").equals("on"))
					msg = "설문세트가 구성 되었습니다.";
				else
					msg = "수정  되었습니다.";
			}else
				msg = "실패";
			
		}else if(qu.equals("all_del") || qu.equals("all_del_cyber")){ //과정 설문 삭제
			
			//응답자가 있을경우는 삭제 불가
			int result = coursePollService.selectGrinqAnswerChk(requestMap.getInt("titleNo"));

			if(result > 0){
				
				msg = "이미 설문이 진행되어 삭제가 불가합니다";
				
			}else{
				
				//설문 삭제.
				result = coursePollService.deleteGrinqTtl(requestMap.getInt("titleNo"));
				
				if(result > 0)
					msg = "삭제되었습니다.";
				else
					msg = "실패";
				
			}

		}else if(qu.equals("set_delete")){ //과정 설문의 Set 삭제
			
			//응답자가 있을경우는 삭제 불가
			int result = coursePollService.selectGrinqAnswerBySetChk(requestMap.getInt("titleNo"), requestMap.getInt("setNo"));

			if(result > 0){
				
				msg = "이미 설문이 진행되어 삭제가 불가합니다.";
				
			}else{
				
				//설문 삭제.
				result = coursePollService.deleteGrinqQuestionSet(requestMap.getInt("titleNo"), requestMap.getInt("setNo"));
				
				if(result > 0)
					msg = "삭제되었습니다.";
				else
					msg = "실패";
				
			}
			
		}
		
		model.addAttribute("RESULT_MSG", msg);
		
		return findView(requestMap.getString("mode"), "/poll/course/coursePollExec");
	}
	
	@RequestMapping(value="/poll/coursePoll.do", params="mode=guide_list")
	public String guide_list(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			) throws Exception{
		
		DataMap requestMap = cm.getDataMap();
		
		if (requestMap.getString("currPage").equals(""))	requestMap.setInt("currPage", 1); //페이지
		if (requestMap.getString("rowSize").equals(""))		requestMap.setInt("rowSize", 10); //페이지당 보여줄 갯수
		if (requestMap.getString("pageSize").equals("")) 	requestMap.setInt("pageSize", 10); //페이지 블럭 갯수
		
		//설문 리스트
		DataMap listMap = coursePollService.selectGrinqGuideList(requestMap.getString("searchKey"), requestMap.getString("searchValue"), requestMap);
		
		model.addAttribute("LIST_DATA", listMap);
		
		return findView(requestMap.getString("mode"), "/poll/course/guideListPop");
	}
	
	@RequestMapping(value="/poll/coursePoll.do", params="mode=guide_form")
	public String guide_form(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			) throws Exception{
		
		DataMap requestMap = cm.getDataMap();
		
		DataMap rowMap = null;
		if(requestMap.getString("qu").equals("update")){ //수정이면
			
			rowMap = coursePollService.selectGrinqGuideRow(requestMap.getInt("guideNo"));
			
		}else{
			rowMap = new DataMap();
			
		}
		
		model.addAttribute("ROW_DATA", rowMap);
		
		return findView(requestMap.getString("mode"), "/poll/course/guideFormPop");
	}
	
	@RequestMapping(value="/poll/coursePoll.do", params="mode=guide_exec")
	public String guide_exec(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			) throws Exception{
		
		DataMap requestMap = cm.getDataMap();
		
		//사용자 정보 추출.
		LoginInfo loginInfo = cm.getLoginInfo();
		requestMap.setString("luserno", loginInfo.getSessNo());	
		
		
		String msg = ""; //결과 메세지.
		
		File makeDir = new File(SpringUtils.getRealPath() + Constants.UPLOAD + "/gr_poll/"); // 디렉토리 생성.
		if(!makeDir.exists())
			makeDir.mkdir();
		makeDir = null;
		

		if(requestMap.getString("qu").equals("insert")){ //과정 안내문 등록
			
			int guideNo = coursePollService.selectGrinqGuideMaxKey();
			requestMap.setInt("guideNo", guideNo);
//			Util.saveNamoContent(requestMap, "guideText", "namoContent", Constants.NAMOUPLOAD_GUIDE + guideNo + "/"); //나모로 넘어온값 처리.
			Util.saveDaumContent(requestMap, "guideText", "namoContent", Constants.NAMOUPLOAD_GUIDE + guideNo + "/"); //나모로 넘어온값 처리.
			
			int result = coursePollService.insertGrinqGuide(requestMap); //과정 안내문 등록
			
			if(result > 0)
				msg = "등록 되었습니다.";
			else
				msg = "실패";
			
		}else if(requestMap.getString("qu").equals("update")){ //과정 설문 수정
			
//			Util.saveNamoContent(requestMap, "guideText", "namoContent", Constants.NAMOUPLOAD_GUIDE + requestMap.getString("guideNo") + "/"); //나모로 넘어온값 처리.
			Util.saveDaumContent(requestMap, "guideText", "namoContent", Constants.NAMOUPLOAD_GUIDE + requestMap.getString("guideNo") + "/"); //나모로 넘어온값 처리.
			int result = coursePollService.updateGrinqGuide(requestMap); //과정 안내문 수정
			
			if(result > 0)
				msg = "수정 되었습니다.";
			else
				msg = "실패";

		}else if(requestMap.getString("qu").equals("delete")){ //안내문 삭제
			
			//과정 안내문 삭제
			int result = coursePollService.deleteGrinqTtl(requestMap.getInt("titleNo"));
			
			if(result > 0)
				msg = "삭제되었습니다.";
			else
				msg = "실패";
				
		}
		
		model.addAttribute("RESULT_MSG", msg);
		
		return findView(requestMap.getString("mode"), "/poll/course/guideExec");
	}
	
	@RequestMapping(value="/poll/coursePoll.do", params="mode=noneChkPollList")
	public String noneChkPollList(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			) throws Exception{
		
		DataMap requestMap = cm.getDataMap();
		
		DataMap listMap = null;
		listMap = coursePollService.selectNoneChkPollList(requestMap);
		
		model.addAttribute("LIST_DATA", listMap);
		
		return findView(requestMap.getString("mode"), "/poll/course/noneChkPollList");
	}
	
	@RequestMapping(value="/poll/coursePoll.do", params="mode=noneChkPollSmsList")
	public String noneChkPollSmsList(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			) throws Exception{
		
		DataMap requestMap = cm.getDataMap();
		
		DataMap listMap = coursePollService.selectGrinqByNotApplyList(requestMap.getString("grcode"), requestMap.getString("grseq"), requestMap.getInt("titleNo"));
		
		model.addAttribute("LIST_DATA", listMap);
		
		return findView(requestMap.getString("mode"), "/poll/course/noneChkSMSPop");
	}
	
	@RequestMapping(value="/poll/coursePoll.do", params="mode=noneChkPollSmsExec")
	public String noneChkPollSmsExec(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			) throws Exception{
		
		DataMap requestMap = cm.getDataMap();
		
		DataMap listMap = null;
		
		listMap = coursePollService.noneChkPollSmsExec(requestMap);
		
		model.addAttribute("LIST_DATA", listMap);
		
		return findView(requestMap.getString("mode"), "/poll/course/noneChkSMSExec");
	}
	
	@RequestMapping(value="/poll/coursePoll.do", params="mode=cyber_list")
	public String cyber_list(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			) throws Exception{
		
		DataMap requestMap = cm.getDataMap();
		
		DataMap listMap = null;
		if( !requestMap.getString("commGrseq").equals("") )
			listMap = coursePollService.selectGrinqTtlByCyberList(requestMap.getString("commGrcode"), requestMap.getString("commGrseq"));
		else
			listMap = new DataMap();
		
		model.addAttribute("LIST_DATA", listMap);
		
		return findView(requestMap.getString("mode"), "/poll/course/coursePollCyberList");
	}
	
	@RequestMapping(value="/poll/coursePoll.do", params="mode=noneChkPollCyberList")
	public String noneChkPollCyberList(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			) throws Exception{
		
		DataMap requestMap = cm.getDataMap();
		
		DataMap listMap = null;
		if( !requestMap.getString("commGrseq").equals("") )
			listMap = coursePollService.selectGrinqTtlByCyberList(requestMap.getString("commGrcode"), requestMap.getString("commGrseq"));
		else
			listMap = new DataMap();
		
		model.addAttribute("LIST_DATA", listMap);
		
		return findView(requestMap.getString("mode"), "/poll/course/noneChkPollCyberList");
	}

}
