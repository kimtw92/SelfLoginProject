package loti.common.web;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import loti.common.service.CommonService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import ut.lib.login.LoginInfo;
import ut.lib.support.CommonMap;
import ut.lib.support.DataMap;
import ut.lib.util.Util;
import common.controller.BaseController;

@Controller
public class CommonAjaxCommSelectBoxController extends BaseController{

	@Autowired
	private CommonService commonService;
	
	@ModelAttribute("cm")
	public CommonMap common(
				CommonMap cm
				, HttpServletRequest request
				, HttpServletResponse response
			){
		
		// 리퀘스트 받기
		DataMap requestMap = cm.getDataMap();
		requestMap.setNullToInitialize(true);
		
		//리퀘스트 정보를 담고있는 DataMap을 Attribute 에 추가
		request.setAttribute("REQUEST_DATA", requestMap);
		
		return cm;
	}
	
	@RequestMapping("/commonInc/ajax/bodyCommSelectBox.do")
	public String defaultProcess(
				@ModelAttribute("cm") CommonMap cm
				, HttpSession session
				, Model model
			) throws Exception{
		return commonCode(cm, session, model);
	}
	
	@RequestMapping(value="/commonInc/ajax/bodyCommSelectBox.do", params="mode=commonCode")
	public String commonCode(
				@ModelAttribute("cm") CommonMap cm
				, HttpSession session
				, Model model
			) throws Exception{

		DataMap requestMap = cm.getDataMap();
		
		//관리자 정보
		LoginInfo memberInfo = cm.getLoginInfo();
		
		DataMap dataMap = null;
		String findCode = ""; //selected 값 확인을 위해.
		
		
		/**
		 * 구분
		 * pmode = 년도/과정/기수 등을 확인하는 변수.
		 * year = 년도, grcode = 과정, grseq = 기수, subj = 과목
		 */
		String pmode = requestMap.getString("pmode");
		// 년도
		String pYear = requestMap.getString("year");
		// 과정 코드
		String pGrCode = requestMap.getString("grCode");
		// 기수
		String pGrSeq = requestMap.getString("grSeq");
		// 과목
		String pSubj = requestMap.getString("subj");
		

		// 과정코드 가져오기
		if(pmode.equals("grCode")){
			
			dataMap = commonService.selectGrCode(pYear, 
							Util.getValue(memberInfo.getSessGubun()),
							Util.getValue(memberInfo.getSessNo()),
							Util.getValue(memberInfo.getSessCurrentAuth()) );
			
			
			if( !pYear.equals(memberInfo.getSessYear()) ){
				
				//세션 정보 등록.
				session.setAttribute("sess_year", "" );
				session.setAttribute("sess_grcode", "" );
				session.setAttribute("sess_grseq", "" );
				session.setAttribute("sess_subj", "" );
				session.setAttribute("sess_year", pYear );
			}
			
			findCode = pGrCode;
		}
		
		// 기수 가져오기
		if(pmode.equals("grSeq")){
			dataMap = commonService.selectGrSeq(pYear, 
							pGrCode, 
							Util.getValue(memberInfo.getSessNo()),
							Util.getValue(memberInfo.getSessCurrentAuth()) );
			
			if( !pGrCode.equals(memberInfo.getSessGrcode()) ){
				
				//세션 정보 등록.
				session.setAttribute("sess_grcode", pGrCode );
				session.setAttribute("sess_grseq", "" );
				session.setAttribute("sess_subj", "" );
			}
			
			findCode = pGrSeq;

		}
		
		// 과목 가져오기
		if(pmode.equals("subj")){
			dataMap = commonService.selectSubj(pGrCode, pGrSeq);
			
			
			if( !pGrSeq.equals(memberInfo.getSessGrseq()) ){
				
				//세션 정보 등록.
				session.setAttribute("sess_grseq", pGrSeq );
				session.setAttribute("sess_subj", "" );
			}
			
			findCode = pSubj;
		}
		
		// Cyber 과정의 기수 가져오기
		if(pmode.equals("cyberGrSeq")){
			dataMap = commonService.selectGrSeqByCyber(pYear);
			
			findCode = pGrSeq;

		}
		
		// Cyber 과정 가져오기
		if(pmode.equals("cyberGrCode")){
			dataMap = commonService.selectGrcodeByCyber(pGrSeq);
			
			findCode = pGrCode;

		}
		
		// Cyber 과정의 과목 가져오기
		if(pmode.equals("cyberSubj")){
			dataMap = commonService.selectSubj(pGrCode, pGrSeq);
			
			findCode = pSubj;

		}
		
		//System.out.println("##" + dataMap);
		model.addAttribute("LIST_MAP", dataMap);
		requestMap.addString("findCode", findCode);
		
		return "/commonInc/ajax/bodyCommSelectBox";
	}
	
	@RequestMapping(value="/commonInc/ajax/bodyCommSelectBox.do", params="mode=commonSession")
	public String commonSession(
			@ModelAttribute("cm") CommonMap cm
			, HttpSession session
			, Model model
			) throws Exception{
		
		DataMap requestMap = cm.getDataMap();
		
		//pmode = 세션에 넣을 정보가 들어있는 값 (grCode, grSeq, subj)
		String pmode = requestMap.getString("selectFieldName");
		String value = requestMap.getString("selectFieldValue");


		// 년도 세션
		if(pmode.equals("year"))
			session.setAttribute("sess_year", value);
		
		// 과정코드 세션
		if(pmode.equals("grCode"))
			session.setAttribute("sess_grcode", value);
		
		// 기수 세션
		if(pmode.equals("grSeq"))
			session.setAttribute("sess_grseq", value);
		
		// 과목 세션
		if(pmode.equals("subj"))
			session.setAttribute("sess_subj", value);
		
		return "/commonInc/ajax/ajaxBlankPage";
	}
	
	@RequestMapping(value="/commonInc/ajax/bodyCommSelectBox.do", params="mode=commonExam")
	public String commonExam(
			@ModelAttribute("cm") CommonMap cm
			, HttpSession session
			, Model model
			) throws Exception{
		
		DataMap requestMap = cm.getDataMap();
		
		String grcode = requestMap.getString("commGrCode"); //과정
		String grseq = requestMap.getString("commGrseq");	//기수
		//String commExam = requestMap.getString("commExam"); //Onload시 사용하는 변수. (Action 에서는 사용하지 않음)

		//평기 리스트 가져 오기.
		DataMap listMap = commonService.selectEtestExamList(grcode, grseq);
		
		model.addAttribute("LIST_DATA", listMap);
		
		return "/commonInc/ajax/bodyCommSelectBoxByExam";
	}
	
	@RequestMapping(value="/commonInc/ajax/bodyCommSelectBox.do", params="mode=commonClass")
	public String commonClass(
			@ModelAttribute("cm") CommonMap cm
			, HttpSession session
			, Model model
			) throws Exception{
		
		DataMap requestMap = cm.getDataMap();

		String grcode = requestMap.getString("commGrCode"); //과정
		String grseq = requestMap.getString("commGrseq");	//기수
		String subj = requestMap.getString("commSubj");	//과목
		//String commClass = requestMap.getString("commClass"); //Onload시 사용하는 변수. (Action 에서는 사용하지 않음)

		//반구성 정보 가져오기.
		DataMap listMap = commonService.selectSubjClassByClassList(grcode, grseq, subj);
		
		model.addAttribute("LIST_DATA", listMap);
		
		return "/commonInc/ajax/bodyCommSelectBoxByClass";
	}
}
