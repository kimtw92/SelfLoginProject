package loti.common.web;

/**
 * default Class
 */
////////////////////////////////////////////////////////
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import loti.common.service.CommonService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import ut.lib.login.LoginInfo;
import ut.lib.support.CommonMap;
import ut.lib.support.DataMap;
import ut.lib.util.Util;
import common.controller.BaseController;

/**
 * Left Menu 과정, 기수, 년도 Ajax 용
 * 
 * @author kang
 * 
 */
@Controller
public class CommonAjaxController extends BaseController {

	@Autowired
	private CommonService commonService;
	
	@ModelAttribute("cm")
	public CommonMap common(
				CommonMap cm
				, HttpServletRequest request
				, HttpServletResponse response
			) throws Exception{
		
		// 리퀘스트 받기
		DataMap requestMap = cm.getDataMap();
		requestMap.setNullToInitialize(true);
		
		//관리자 로그인 체크
		LoginInfo memberInfo = cm.getLoginInfo();
				
		
		DataMap dataMap = null;
		
		/**
		 * 구분
		 * grcode = 과정, grseq = 기수, subj = 과목
		 */
		String pmode = Util.getValue(requestMap.getString("pmode"));
		
		// 년도
		String pYear = Util.getValue(requestMap.getString("year"));
		
		// 과정 코드
		String pGrCode = Util.getValue(requestMap.getString("grCode"));
		
		// 기수
		String pGrSeq = Util.getValue(requestMap.getString("grSeq"));
		
		// 과목
		String pSubj = Util.getValue(requestMap.getString("subj"));
		
		
		
		// 과정코드 가져오기
		if(pmode.equals("grCode")){
			dataMap = commonService.selectGrCode(pYear, 
							Util.getValue(memberInfo.getSessGubun()),
							Util.getValue(memberInfo.getSessNo()),
							Util.getValue(memberInfo.getSessCurrentAuth()) );
		}
		
		// 기수 가져오기
		if(pmode.equals("grSeq")){
			dataMap = commonService.selectGrSeq(pYear, 
							pGrCode, 
							Util.getValue(memberInfo.getSessNo()),
							Util.getValue(memberInfo.getSessCurrentAuth()) );
		}
		
		// 과목 가져오기
		if(pmode.equals("subj")){
			dataMap = commonService.selectSubj(pGrCode, pGrSeq);
		}
		
		request.setAttribute("LIST_MAP", dataMap);
		
		
		//리퀘스트 정보를 담고있는 DataMap을 Attribute 에 추가
		request.setAttribute("REQUEST_DATA", requestMap);
		
		return cm;
	}
	
	@RequestMapping(value="/commonInc/ajax/leftCommonCourseCode.do")
	public String defaultProcess() throws Exception{
		return commonCode();
	}
	
	@RequestMapping(value="/commonInc/ajax/leftCommonCourseCode.do",params="mode=commonCode")
	public String commonCode() throws Exception{
		return "/commonInc/ajax/leftCommonCourseCode";
	}
	
	
	@RequestMapping(value="/commonInc/ajax/currentCourseGubun.do", params="mode=courseGubun")
	public String courseGubun(
				HttpSession session
				, @RequestParam(value="sessGubun", required=false) String sessGubun
			){
		
		session.setAttribute("sess_gubun", sessGubun);
		
		session.setAttribute("sess_year", "" );
		session.setAttribute("sess_grcode", "" );
		session.setAttribute("sess_grseq", "" );
		session.setAttribute("sess_subj", "" );
		
		return "/commonInc/ajax/currentCourseGubun";
	}
	
	
	
//	@RequestMapping("/commonInc/ajax/leftCommonCourseCode.do")
//	public String commonCode(CommonMap commonMap) throws Exception {
//
//		// 리퀘스트 받기
//		DataMap requestMap = commonMap.getDataMap();
//		requestMap.setNullToInitialize(true);
//
//		// default mode
//		String mode = Util.getValue(requestMap.getString("mode"), "commonCode");
//
//		// left 권한 변경시 세션저장
//		if (mode.equals("auth")) {
//			commonMap.getSession().setAttribute("sess_currentauth", commonMap.getRequest().getParameter("cauth"));
//			// 2008-08-04 권한 변경시 로그인된 권한도 함께 변경해줌. - 이용문
//			commonMap.getSession().setAttribute("sess_class", commonMap.getRequest().getParameter("cauth"));
//		}
//
//		// left 진행과정, 전체과정 선택시
//		if (mode.equals("courseGubun")) {
//			commonMap.getSession().setAttribute("sess_gubun", commonMap.getRequest().getParameter("sessGubun"));
//			commonMap.getSession().setAttribute("sess_year", "");
//			commonMap.getSession().setAttribute("sess_grcode", "");
//			commonMap.getSession().setAttribute("sess_grseq", "");
//			commonMap.getSession().setAttribute("sess_subj", "");
//
//		}
//
//		DataMap dataMap = null;
//
//		/**
//		 * 구분 grcode = 과정, grseq = 기수, subj = 과목
//		 */
//		String pmode = Util.getValue(requestMap.getString("pmode"));
//
//		// 년도
//		String pYear = Util.getValue(requestMap.getString("year"));
//
//		// 과정 코드
//		String pGrCode = Util.getValue(requestMap.getString("grCode"));
//
//		// 기수
//		String pGrSeq = Util.getValue(requestMap.getString("grSeq"));
//
//		// 과목
//		String pSubj = Util.getValue(requestMap.getString("subj"));
//
//		// 과정코드 가져오기
//		if (pmode.equals("grCode")) {
//			dataMap = commonService.selectGrCode(
//								pYear
//								, Util.getValue(commonMap.getLoginInfo().getSessGubun())
//								, Util.getValue(commonMap.getLoginInfo().getSessNo())
//								, Util.getValue(commonMap.getLoginInfo().getSessCurrentAuth())
//								);
//		}
//
//		// 기수 가져오기
//		if (pmode.equals("grSeq")) {
//			dataMap = commonService.selectGrSeq(pYear, pGrCode,
//					Util.getValue(commonMap.getLoginInfo().getSessNo()),
//					Util.getValue(commonMap.getLoginInfo().getSessCurrentAuth()));
//		}
//
//		// 과목 가져오기
//		if (pmode.equals("subj")) {
//			dataMap = commonService.selectSubj(pGrCode, pGrSeq);
//		}
//
//		commonMap.getRequest().setAttribute("LIST_MAP", dataMap);
//
//		// 리퀘스트 정보를 담고있는 DataMap을 Attribute 에 추가
//		commonMap.getRequest().setAttribute("REQUEST_DATA", requestMap);
//
//		return "/commonInc/ajax/leftCommonCourseCode";
//	}
	
	@RequestMapping(value="/commonInc/ajax/currentAuthSet.do", params="mode=auth")
	public String auth(
				HttpSession session
				, @RequestParam(value="cauth", required=false) String cauth
			) throws Exception{

		session.setAttribute("sess_currentauth", cauth );
		session.setAttribute("sess_class", cauth ); //2008-08-04 권한 변경시 로그인된 권한도 함께 변경해줌. - 이용문
		
		
		return "/commonInc/ajax/currentAuthSet";
	}

}
