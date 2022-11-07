package loti.mypage.web;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import loti.common.service.CommonService;
import loti.courseMgr.service.CertiResultService;
import loti.courseMgr.service.LectureApplyService;
import loti.courseMgr.service.ResultHtmlService;
import loti.homeFront.service.CourseService;
import loti.homeFront.service.HtmlService;
import loti.homeFront.service.IndexService;
import loti.homeFront.service.SupportService;
import loti.mypage.service.MyClassService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import ut.lib.exception.BizException;
import ut.lib.file.FileUtil;
import ut.lib.login.LoginInfo;
import ut.lib.support.CommonMap;
import ut.lib.support.DataMap;
import ut.lib.util.Constants;
import ut.lib.util.Functions;
import ut.lib.util.Util;
import common.controller.BaseController;

@Controller
public class MyClassController extends BaseController {

	@Autowired
	private HtmlService htmlService;
	
	@Autowired
	private MyClassService myClassService;
	
	@Autowired
	private IndexService indexService;
	
	@Autowired
	private SupportService supportService;
	
	@Autowired
	private CommonService commonService;
	
	@Autowired
	private CourseService courseService;
	
	@Autowired
	private LectureApplyService lectureApplyService;
	
	@Autowired
	private CertiResultService certiResultService;
	
	@Autowired
	private ResultHtmlService resultHtmlService;
	
	@ModelAttribute("cm")
	public CommonMap common(CommonMap cm, Model model, HttpServletRequest request
				, HttpServletResponse response
			) throws Exception{
		
		/**
		 * 필수 값 받아오기
		 */
		DataMap requestMap = cm.getDataMap();
		requestMap.setNullToInitialize(true);				
		String mode = Util.getValue(requestMap.getString("mode"));			
		
		
		/**
		 * 로그인 체크
		 */
		LoginInfo loginInfo = (LoginInfo)request.getAttribute("LOGIN_INFO");
		
		if(loginInfo.isLogin() == false){
			// 로그인 안되어 있음
			System.out.println("로그인 안되어 있음");
			request.getRequestDispatcher("/homepage/alertloginrequire.jsp");
		} else {
			requestMap.setString("userno", loginInfo.getSessNo());
			requestMap.setString("userName", loginInfo.getSessName());
			requestMap.setString("userId", loginInfo.getSessUserId());
		}
		// 세션 값 가져오기
		HttpSession session = request.getSession();
		if (mode.equals("ht")){
			// html 템플릿용
			HtmlTemplete( request, requestMap );	
		}
		
		// 리퀘스트 정보를 담고있는 DataMap을 Attribute 에 추가
		model.addAttribute("REQUEST_DATA", requestMap);
		model.addAttribute("LOGIN_INFO", loginInfo);
		model.addAttribute("type", requestMap.getString("type"));
		
		return cm;
	}
	
	public String findView(CommonMap cm, String mode, String view){
		
		if(cm.getLoginInfo().isLogin() == false){
			mode = "LoginForm";
		}
		
		if("LoginForm".equals(mode)){
			return "/homepage/alertloginrequire";
		}else{
			return view;
		}
	}
	
	/**
	 * html 관리자에서 생성한 html 보기
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @param requestMap
	 * @throws Exception
	 */
	public void HtmlTemplete(
	          HttpServletRequest request,
	          DataMap requestMap) throws Exception {
				
		String htmlId = requestMap.getString("htmlId");		
		DataMap listMap = null;		
		listMap = htmlService.htmlTemplete(htmlId);
		request.setAttribute("HTML_DATA", listMap);
		
	}
	
	public void selectCourseMain(
	          Model model
	          , DataMap requestMap
          ) throws Exception {
	
		//	초기화 옵션(true 일경우 데이터를 뽑을때 null 일경우 초기화 - 빈문자열, 0....)
		requestMap.setNullToInitialize(true);

		//	코스 관련된 데이터 가져오기
		DataMap CLMap = myClassService.courseList(requestMap);
		CLMap.setNullToInitialize(true);
		model.addAttribute("COURSE_LIST", CLMap);
		
		// 소양 취미  데이터 가져오기
		DataMap CBasicMap = myClassService.courseBasicList(requestMap);
		CBasicMap.setNullToInitialize(true);
		model.addAttribute("COURSE_BASIC_LIST", CBasicMap);
		
		/*	코스 상세 데이터 가져오기
		* grcode, grseq 값을 가져와야함
		*DataMap CDMap = service.courseDetailView(requestMap);
		*CDMap.setNullToInitialize(true);
		*model.addAttribute("COURSE_DETAIL", CDMap);
		*/
		
		//	복습가능한 과정
		DataMap RVMap = myClassService.courseReView(requestMap);
		RVMap.setNullToInitialize(true);
		model.addAttribute("REVIEW_LIST", RVMap);
		//	수강처리중인 과정
		DataMap AMap = myClassService.courseApplication(requestMap);
		AMap.setNullToInitialize(true);
		model.addAttribute("APP_LIST", AMap);
		
	}
	
	@RequestMapping(value="/homepage/attend.do", params="mode=LoginForm")
	public String LoginForm(){
		return "/homepage/alertloginrequire";
	}
	
	@RequestMapping(value="/homepage/attend.do", params="mode=eduinfo4-1")
	public String eduinfo41(){
		return "/homepage/eduInfo/eduinfo4-1";
	}
	
	@RequestMapping(value="/homepage/attend.do", params="mode=attendList")
	public String attendList(
				@ModelAttribute("cm") CommonMap cm
				, Model model
			) throws BizException{
		
		DataMap listMap = null;
		
		// 리스트 가져오기
		listMap = myClassService.attendList(cm.getDataMap());
		model.addAttribute("LIST_DATA", listMap);
		
		return findView(cm, cm.getDataMap().getString("mode"), "/homepage/attend/attendList");
	}
	
	@RequestMapping(value="/homepage/attend.do", params="mode=attendDetail")
	public String attendDetail(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			) throws BizException{
		
		DataMap listMap = null;
		
		// 리스트 가져오기
		listMap = myClassService.selectAttendDetail(cm.getDataMap());
		model.addAttribute("LIST_DATA", listMap);
		
		return findView(cm, cm.getDataMap().getString("mode"), "/homepage/attend/attendDetail");
	}
	
	// 회원정보 가져오기
	public void attendPopup(
			Model model,
	          DataMap requestMap) throws Exception {
				
		DataMap listMap = null;
		DataMap listPart = null;
		DataMap listDept = null;
		
		// 회원정보 리스트
		listMap = supportService.memberView(requestMap.getString("userId"));
		// 부서 리스트
		listDept = myClassService.deptList();
		// 파트 리스트
		listPart = myClassService.partList(listDept.getString("dept"));
		
		model.addAttribute("USER_INFO", myClassService.getModifyInfo(listMap.getString("userno")));
		
		model.addAttribute("MEM_DATA", listMap);
		model.addAttribute("DEPT_DATA", listDept);
		model.addAttribute("PART_DATA", listPart);
		model.addAttribute("grgubun", requestMap.getString("grgubun"));
	}
	
	@RequestMapping(value="/homepage/attend.do", params="mode=attendPopup")
	public String attendPopup(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			) throws Exception{
		
		attendPopup(model, cm.getDataMap());
		
		return findView(cm, cm.getDataMap().getString("mode"), "/homepage/attend/attendPopup");
	}

	@RequestMapping(value="/homepage/attend.do", params="mode=agreePopup")
	public String agreePopup(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			) throws Exception{
		
		attendPopup(model, cm.getDataMap());

		return findView(cm, cm.getDataMap().getString("mode"), "/homepage/attend/agreePopup");
	}

	@RequestMapping(value="/homepage/attend.do", params="mode=searchPart")
	public String searchPart(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			) throws Exception{
		
		DataMap requestMap = cm.getDataMap();
		
		DataMap listPart = null;
		
		// 파트 리스트
		if("6289999".equals(requestMap.getString("dept"))) {
			listPart = myClassService.ldapList(requestMap.getString("dept"));
		} else {
			listPart = myClassService.partList(requestMap.getString("dept"));
		}
		
		model.addAttribute("PART_DATA", listPart);
		model.addAttribute("dept", requestMap.getString("dept"));
		model.addAttribute("deptsub", requestMap.getString("deptsub"));
		
		return findView(cm, cm.getDataMap().getString("mode"), "/homepage/attend/partAjax");
	}
	
	// 수강신청 하기
	public void applyInfo(
			LoginInfo loginInfo,
	          DataMap requestMap) throws Exception {
				
		// 수강 신청
		String Msg = myClassService.applyInfo(requestMap, loginInfo);
		
		requestMap.setString("Msg",Msg);
	}
	
	@RequestMapping(value="/homepage/attend.do", params="mode=applyInfo")
	public String applyInfo(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			) throws Exception{
		
		applyInfo(cm.getLoginInfo(), cm.getDataMap());
		
		return findView(cm, cm.getDataMap().getString("mode"), "/homepage/attend/attendForm");
	}
	
	// 수강신청 하기 2
		public void applyInfo2(
				HttpServletRequest request
				, Model model
		        , DataMap requestMap) throws Exception {
			LoginInfo loginInfo = (LoginInfo)request.getAttribute("LOGIN_INFO");
			// 수강 신청
			String Msg = myClassService.applyInfo2(requestMap, request);
			
			if("ok".equals(Msg)) {
				requestMap.setString("name", loginInfo.getSessName());
				int result = 0;
				// 1차 승인
				result = lectureApplyService.execAppInfoAgreeByDept2(loginInfo.getSessNo(), requestMap, loginInfo.getSessDept());
				// 최종승인
				
				result = lectureApplyService.execAppInfoAgree2(loginInfo.getSessNo(), requestMap);
				
				if(result > 0){
					Msg = "신청 및 자동 승인 처리되었습니다.";
				}else{
					Msg = "승인이 실패 되었습니다. 관리자에게 문의해주세요.";
				}
			}
			
			requestMap.setString("Msg",Msg);
		}
	
	@RequestMapping(value="/mypage/myclass.do", params="mode=applyInfo2")
	public String applyInfo2(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			, HttpServletRequest request
			) throws Exception{
		
		applyInfo2(request, model, cm.getDataMap());
		
		return findView(cm, cm.getDataMap().getString("mode"), "/homepage/attend/attendForm");
	}
	
	@RequestMapping(value="/homepage/attend.do", params="mode=applyInfo2")
	public String applyInfo2attend(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			, HttpServletRequest request
			) throws Exception{
		
		applyInfo2(request, model, cm.getDataMap());
		
		return findView(cm, cm.getDataMap().getString("mode"), "/homepage/attend/attendForm");
	}
	
	// 자동 수강취소 하기
	public void autoCancelAttend(
	          DataMap requestMap) throws Exception {
				
		// 수강 신청
		String Msg = myClassService.autoCancelAttend(requestMap);
		requestMap.setString("Msg",Msg);
	}	
	
	@RequestMapping(value="/mypage/myclass.do", params="mode=autoCancelAttend")
	public String autoCancelAttend(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			, HttpServletRequest request
			) throws Exception{
		
		autoCancelAttend(cm.getDataMap());
		
		return findView(cm, cm.getDataMap().getString("mode"), "/homepage/mypage/myclass/attendCancel");
	}
	
	
	
	@RequestMapping(value="/mypage/myclass.do", params="mode=main")
	public String main(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			, HttpSession session
			) throws Exception{
		
		// myPage Main -- 코스 값 초기화
		session.setAttribute("sess_grcode", 		Util.getValue("", ""));
		session.setAttribute("sess_grseq", 		Util.getValue("", ""));
		selectCourseMain(model, cm.getDataMap());
		
		return findView(cm, cm.getDataMap().getString("mode"), "/homepage/mypage/main");
	}
	
	@RequestMapping(value="/mypage/myclass.do", params="mode=attendList")
	public String myClassAttendList(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			, HttpSession session
			) throws Exception{
		
		attendList(cm, model);
		
		return findView(cm, cm.getDataMap().getString("mode"), "/homepage/mypage/myclass/attendList");
	}
	
	@RequestMapping(value="/mypage/myclass.do", params="mode=attendDetail")
	public String myClassAttendDetail(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			, HttpSession session
			) throws Exception{
		
		attendDetail(cm, model);
		
		return findView(cm, cm.getDataMap().getString("mode"), "/homepage/mypage/myclass/attendDetail");
	}
	
	@RequestMapping(value="/mypage/myclass.do", params="mode=completionList")
	public String completionList(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			, HttpSession session
			) throws Exception{
		
		//	초기화 옵션(true 일경우 데이터를 뽑을때 null 일경우 초기화 - 빈문자열, 0....)
		cm.getDataMap().setNullToInitialize(true);
		
		DataMap listMap = myClassService.selectCompletionList(cm.getDataMap()); 
		model.addAttribute("LIST_DATA", listMap);
		
		return findView(cm, cm.getDataMap().getString("mode"), "/homepage/mypage/myclass/completionList");
	}
	
	@RequestMapping(value="/mypage/myclass.do", params="mode=myquestion")
	public String myquestion(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			, HttpSession session
			) throws Exception{
		
		cm.getDataMap().setString("userno",(String)session.getAttribute("sess_no"));
		model.addAttribute("MY_QUESTION_LIST", myClassService.getMyQuestionList(cm.getDataMap()));	
		
		return findView(cm, cm.getDataMap().getString("mode"), "/homepage/mypage/myclass/myquestion");
	}
	
	//2011.01.11 - woni82
	//회원정보를 수정하기 위하여 기본정보를 가져온다.
	// 기존 - 주민등록번호 포함
	// 수정 - 주민등록번호 제외
	// sv, dao 수정
	@RequestMapping(value="/mypage/myclass.do", params="mode=personalinfomodify")
	public String personalinfomodify(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			, HttpSession session
			) throws Exception{
		
		model.addAttribute("DEPT_LIST",indexService.getDeptList()  );		
		
		model.addAttribute("USER_INFO", myClassService.getModifyInfo(Util.nvl(session.getAttribute("sess_no"))));
		model.addAttribute("USER_INFO_PIC", myClassService.getModifyInfoPic(Util.nvl(session.getAttribute("sess_no"))));
		
		return findView(cm, cm.getDataMap().getString("mode"), "/homepage/mypage/myclass/personalinfomodify");
	}
	
	@RequestMapping(value="/mypage/myclass.do", params="mode=searchPart_")
	public String searchPart_(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			, HttpSession session
			) throws Exception{
		
		searchPart(cm, model);
		
		return findView(cm, cm.getDataMap().getString("mode"), "/homepage/mypage/myclass/partAjax_");
	}
	
	@RequestMapping(value="/mypage/myclass.do", params="mode=searchPart")
	public String searchPart(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			, HttpSession session
			) throws Exception{
		
		searchPart(cm, model);
		
		return findView(cm, cm.getDataMap().getString("mode"), "/homepage/mypage/myclass/partAjax");
	}
	
	@RequestMapping(value="/mypage/myclass.do", params="mode=searchPart2")
	public String searchPart2(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			, HttpSession session
			) throws Exception{
		
		searchPart(cm, model);
		
		return findView(cm, cm.getDataMap().getString("mode"), "/homepage/mypage/myclass/partAjax2");
	}
	
	@RequestMapping(value="/mypage/myclass.do", params="mode=searchPart3")
	public String searchPart3(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			, HttpSession session
			) throws Exception{
		
		searchPart(cm, model);
		
		return findView(cm, cm.getDataMap().getString("mode"), "/homepage/mypage/myclass/partAjax3");
	}
	
	@RequestMapping(value="/mypage/myclass.do", params="mode=memberout")
	public String memberout(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			, HttpSession session
			) throws Exception{
		
		return findView(cm, cm.getDataMap().getString("mode"), "/homepage/mypage/myclass/memberout");
	}
	
	@RequestMapping(value="/mypage/myclass.do", params="mode=deleteuser")
	public String deleteuser(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			, HttpSession session
			) throws Exception{
		
		myClassService.deleteUser(Util.nvl(session.getAttribute("sess_no")));
		session.invalidate();
		
		return findView(cm, cm.getDataMap().getString("mode"), "redirect:/homepage/index.do?mode=homepage");
	}
	
	@RequestMapping(value="/mypage/myclass.do", params="mode=updateuser", method=RequestMethod.POST)
	@Transactional
	public String updateuser(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			, HttpSession session
			, HttpServletRequest request
			) throws Exception{
		
		String pwd_qus              = request.getParameter("PWD_QUS");	
		String pwd_ans              = request.getParameter("PWD_ANS");	
		String email                = request.getParameter("emailid")+"@"+request.getParameter("mailserv");	
		String home_tel             = request.getParameter("HOME_TEL1")+"-"+request.getParameter("HOME_TEL2")+"-"+request.getParameter("HOME_TEL3");	
		String office_tel           = request.getParameter("OFFICE_TEL1")+"-"+request.getParameter("OFFICE_TEL2")+"-"+request.getParameter("OFFICE_TEL3");
		String hp                   = request.getParameter("HP1")+"-"+request.getParameter("HP2")+"-"+request.getParameter("HP3");	
		String home_post1        	= request.getParameter("homePost1");	
		String home_post2        	= request.getParameter("homePost2");	
		String home_addr          	= request.getParameter("homeAddr");	
		String dept                 = request.getParameter("officename").substring(0,7);	//부서코드 (7자리)	
		String deptnm               = request.getParameter("officename").substring(7);		//부서이름
		String deptsub              = request.getParameter("deptname");	
		String jikwi                = request.getParameter("degree");				
		String jik                  = request.getParameter("hiddenjik");
		String mjiknm               = request.getParameter("degreename");	
		String school               = request.getParameter("school");				
		String mailyn               = request.getParameter("mailYN");	
		String sms_yn               = request.getParameter("smsYN");	
		String fidate               = request.getParameter("FIDATE");	
		String upsdate              = request.getParameter("UPSDATE");						
		String userno               = (String)session.getAttribute("sess_no");
		
		String newHomePost         = request.getParameter("newHomePost");
		String newAddr1             = request.getParameter("newAddr1");
		String newAddr2             = request.getParameter("newAddr2");

		Map<String, Object> requestMap = new HashMap<String, Object>();

		requestMap.put("pwd_qus",pwd_qus);		
		requestMap.put("pwd_ans",pwd_ans);		
		requestMap.put("email",email);		
		requestMap.put("home_tel",home_tel);		
		requestMap.put("office_tel",office_tel);		
		requestMap.put("hp",hp);		
		requestMap.put("home_post1",home_post1);		
		requestMap.put("home_post2",home_post2);		
		requestMap.put("home_addr",home_addr);		
		requestMap.put("dept",dept);		
		requestMap.put("deptnm",deptnm);	
		requestMap.put("ldapcode",cm.getDataMap().getString("PART_DATA"));	
		requestMap.put("deptsub",deptsub);
		requestMap.put("ldapname","".equals(Util.nvl(requestMap.get("ldapcode"))) ? null:deptsub);
		requestMap.put("jikwi",jikwi);		
		requestMap.put("jik",jik);		
		requestMap.put("mjiknm",mjiknm);		
		requestMap.put("school",school);		
		requestMap.put("mailyn",mailyn);		
		requestMap.put("sms_yn",sms_yn);
		requestMap.put("fidate",fidate);		
		requestMap.put("upsdate",upsdate);			
		requestMap.put("userno",userno);	
		requestMap.put("name",cm.getLoginInfo().getSessName());
		requestMap.put("newHomePost", newHomePost);
		requestMap.put("newAddr1", newAddr1);
		requestMap.put("newAddr2", newAddr2);
		
		
		if(!"".equals(request.getParameter("PWD"))){
			requestMap.put("pwd",request.getParameter("PWD"));
		} else {
			requestMap.put("pwd", null);
		}
		
		myClassService.updateUser(requestMap);
		myClassService.updateUserLog(requestMap);
		
		// 사진파일을 올릴때... 
		if(!request.getParameter("fileno").equals("notinit")){
			myClassService.updateUserPicture(request.getParameter("fileno"),userno);
		}
		
		// 패스워드를 변경할때...
		if(!request.getParameter("PWD").equals("")){
			myClassService.updateUserPassword(request.getParameter("PWD"),userno);
		}
		
		// 패스워드를 변경할때...2
		if(!request.getParameter("PWD").equals("")){
			myClassService.updateUserDamoPassword(userno); 
		}
		
		return findView(cm, cm.getDataMap().getString("mode"), "redirect:/mypage/myclass.do?mode=personalinfomodify");
	}
	//2
	/*@RequestMapping(value="/mypage/myclass.do", params="mode=memberUpdate")
	@Transactional
	public String memberUpdate(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			, HttpSession session
			, HttpServletRequest request
			) throws Exception{
		
		DataMap requestMap = cm.getDataMap();
		
		DataMap listMap = null;
		DataMap listPart = null;
		DataMap listDept = null;
		
		LoginInfo loginInfo = (LoginInfo)request.getAttribute("LOGIN_INFO");
		// 회원정보 리스트
		listMap = supportService.memberView(loginInfo.getSessUserId());
		// 부서 리스트
		listDept = myClassService.deptList();
		// 파트 리스트
		listPart = myClassService.partList(listDept.getString("dept"));
		
		model.addAttribute("USER_INFO", myClassService.getModifyInfo(listMap.getString("userno")));
		
		model.addAttribute("MEM_DATA", listMap);
		model.addAttribute("DEPT_DATA", listDept);
		model.addAttribute("PART_DATA", listPart);
		model.addAttribute("grgubun", requestMap.getString("grgubun"));
		model.addAttribute("code", requestMap.getString("code"));
		
		return findView(cm, cm.getDataMap().getString("mode"), "/homepage/mypage/memberUpdate");
	}*/
	
	
	@RequestMapping(value="/mypage/myclass.do", params="mode=memberUpdate")
	@Transactional
	public String memberUpdate(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			, HttpSession session
			, HttpServletRequest request
			) throws Exception{
		
		DataMap requestMap = cm.getDataMap();
		
		DataMap listMap = null;
		DataMap listPart = null;
		DataMap listDept = null;
		
		LoginInfo loginInfo = (LoginInfo)request.getAttribute("LOGIN_INFO");
		// 회원정보 리스트
		listMap = supportService.memberView(loginInfo.getSessUserId());
		// 부서 리스트
		listDept = myClassService.deptList();
		// 파트 리스트
		listPart = myClassService.partList(listDept.getString("dept"));
		
		model.addAttribute("USER_INFO", myClassService.getModifyInfo(listMap.getString("userno")));
		
		model.addAttribute("MEM_DATA", listMap);
		model.addAttribute("DEPT_DATA", listDept);
		model.addAttribute("PART_DATA", listPart);
		model.addAttribute("grgubun", requestMap.getString("grgubun"));
		model.addAttribute("code", requestMap.getString("code"));
		
		return findView(cm, cm.getDataMap().getString("mode"), "/homepage/mypage/memberUpdate");
	}
	
	@RequestMapping(value="/mypage/myclass.do", params="mode=ajaxGetGrseq")
	public String ajaxGetGrseq(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			) throws Exception{
		
		DataMap requestMap = cm.getDataMap();

		int countMap = myClassService.ajaxGetCount(requestMap.getString("grcode"),requestMap.getString("grseq"));
		int teatedMAp = myClassService.ajaxGetTseat(requestMap.getString("grcode"),requestMap.getString("grseq"));

	
		if (teatedMAp <= countMap) {
			//model.addAttribute("strResult", "-200");
			
			DataMap limitMap = myClassService.selectLimit(requestMap.getString("grcode"),
					requestMap.getString("grseq"), requestMap.getString("userno"));				
			model.addAttribute("strResult", limitMap.getString("limit", 0) + "," + limitMap.getString("limit", 1));
		} else {
			String listMap = myClassService.ajaxGetGrseq(requestMap.getString("grcode"), requestMap.getString("grseq"),
					requestMap.getString("userno"));

			if (listMap.equals("-1")) {
				model.addAttribute("strResult", "-300");
			} else {
				DataMap limitMap = myClassService.selectLimit(requestMap.getString("grcode"),
						requestMap.getString("grseq"), requestMap.getString("userno"));				
				model.addAttribute("strResult", limitMap.getString("limit", 0) + "," + limitMap.getString("limit", 1));
			}

		}

		return findView(cm, cm.getDataMap().getString("mode"), "/homepage/mypage/myclass/ajaxGetGrseq");
	}
	
	@RequestMapping(value="/mypage/myclass.do", params="mode=ajaxReadCnt")
	public String ajaxReadCnt(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			) throws Exception{

		DataMap requestMap = cm.getDataMap();
		
		DataMap listMap = myClassService.ajaxReadCnt(requestMap.getString("grcode"), requestMap.getString("grseq"),requestMap.getString("subj"),requestMap.getString("userno"));
		
		model.addAttribute("LIST_DATA", listMap);
		
		return findView(cm, cm.getDataMap().getString("mode"), "/homepage/mypage/myclass/ajaxReadCnt");
	}
	
	public void selectClassList(
			Model model
	        , DataMap requestMap) throws Exception {
	
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
		
		DataMap listMap = myClassService.selectClassList(requestMap); 
		
		model.addAttribute("LIST_DATA", listMap);

	}
	
	@RequestMapping(value="/mypage/myclass.do", params="mode=sameClassList")
	public String sameClassList(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			, HttpSession session
			) throws Exception{
		
		DataMap requestMap = cm.getDataMap();
		
		if (requestMap.getString("grcode").length() > 0){
			session.setAttribute("sess_grcode", 		Util.getValue(requestMap.getString("grcode"), ""));
			session.setAttribute("sess_grseq", 		Util.getValue(requestMap.getString("grseq"), ""));
		} else {
			requestMap.setString("grcode",(String)session.getAttribute("sess_grcode"));
			requestMap.setString("grseq",(String)session.getAttribute("sess_grseq"));
		}
		
		selectClassList(model, requestMap);
		
		return findView(cm, cm.getDataMap().getString("mode"), "/homepage/mypage/myclass/sameClassList");
	}
	
	public void selectClassView(
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
		
		DataMap listMap = myClassService.selectClassView(requestMap); 
		
		model.addAttribute("LIST_DATA", listMap);

	}
	
	@RequestMapping(value="/mypage/myclass.do", params="mode=sameClassView")
	public String sameClassView(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			, HttpSession session
			) throws Exception{
		
		DataMap requestMap = cm.getDataMap();
		
		if (requestMap.getString("grcode").length() > 0){
			session.setAttribute("sess_grcode", 		Util.getValue(requestMap.getString("grcode"), ""));
			session.setAttribute("sess_grseq", 		Util.getValue(requestMap.getString("grseq"), ""));
		} else {
			requestMap.setString("grcode",(String)session.getAttribute("sess_grcode"));
			requestMap.setString("grseq",(String)session.getAttribute("sess_grseq"));
		}
		// 동기 목록
		selectClassView(model, requestMap);
		
		return findView(cm, cm.getDataMap().getString("mode"), "/homepage/mypage/myclass/sameClassView");
	}
	
	@RequestMapping(value="/mypage/myclass.do", params="mode=sameClassPrint")
	public String sameClassPrint(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			, HttpSession session
			) throws Exception{
		
		DataMap requestMap = cm.getDataMap();
		
		if (requestMap.getString("grcode").length() > 0){
			session.setAttribute("sess_grcode", 		Util.getValue(requestMap.getString("grcode"), ""));
			session.setAttribute("sess_grseq", 		Util.getValue(requestMap.getString("grseq"), ""));
		} else {
			requestMap.setString("grcode",(String)session.getAttribute("sess_grcode"));
			requestMap.setString("grseq",(String)session.getAttribute("sess_grseq"));
		}
		// 동기 목록
		selectClassView(model, requestMap);
		
		return findView(cm, cm.getDataMap().getString("mode"), "/homepage/mypage/myclass/sameClassPrint");
	}
	
	// 결과 페이지 보여주기
		public void testView(
				Model model,
		         DataMap requestMap,
		         LoginInfo loginInfo) throws Exception {
			
			// 과정기수 수료여부 확인
			
			DataMap resultData = myClassService.findGrade2(requestMap);
			resultData = (DataMap) Functions.initMap().apply(resultData);
			if (resultData.get("closing").equals("Y")){
				requestMap.setString("display","E");
			} else {
				requestMap.setString("display","T");
			}

			requestMap.setString("subj", resultData.get("subj").toString());
			
			
			//과정기수 상세정보 가져오기
			DataMap grInfoMap = myClassService.selectGrInfo(requestMap); 
			
			Double progressscoAvg = myClassService.selectProgressscoAvg(requestMap); 	
			Double passSumNumber =  Double.valueOf("95.0"); //합격점수		
			
			if(progressscoAvg >= passSumNumber) {
				model.addAttribute("passYn", "Y");
			} else {
				model.addAttribute("passYn", "N");
			}
			
			// 시험 응시, 결과 가져오기
			String Msg = myClassService.selectTestValue(requestMap);
			
			requestMap.setString("Msg", Msg);
			model.addAttribute("GRINFO_DATA", grInfoMap);
			
		}
		
	/**
	 * 신청중인 수강목록
	 * 작성일 : 8월 29일
	 * 작성자 : 최종삼
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	
	public void selectCourseList(
			Model model
	        , DataMap requestMap) throws Exception {
	
		//	초기화 옵션(true 일경우 데이터를 뽑을때 null 일경우 초기화 - 빈문자열, 0....)
		requestMap.setNullToInitialize(true);
		
		DataMap listMap = myClassService.selectCourseList(requestMap); 
		
		model.addAttribute("LIST_DATA", listMap);

	}
	
	@RequestMapping(value="/mypage/myclass.do", params="mode=selectCourseList")
	public String selectCourseList(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			, HttpSession session
			, HttpServletResponse response
			) throws Exception{
		
		DataMap requestMap = cm.getDataMap();
		
		if (requestMap.getString("grcode").length() > 0){
			session.setAttribute("sess_grcode", 		Util.getValue(requestMap.getString("grcode"), ""));
			session.setAttribute("sess_grseq", 		Util.getValue(requestMap.getString("grseq"), ""));
		} else {
			requestMap.setString("grcode",(String)session.getAttribute("sess_grcode"));
			requestMap.setString("grseq",(String)session.getAttribute("sess_grseq"));
		}
		
		Util.setCookie(response, "cookieGrcode",  requestMap.getString("grcode"));
		Util.setCookie(response, "cookieGrseq",  requestMap.getString("grseq"));
		Util.setCookie(response, "UserId",  requestMap.getString("userno"));
		Util.setCookie(response, "UserName",  requestMap.getString("userName"));
		
		if (requestMap.getString("grcode").length() > 0){
			selectCourseList(model, requestMap);
			testView(model, requestMap, cm.getLoginInfo());
		}
		
		return findView(cm, cm.getDataMap().getString("mode"), "/homepage/mypage/myclass/selectCourseList");
	}
	
	/**
	 * 사이버과목 회차 리스트
	 * 작성일 : 8월 29일
	 * 작성자 : 최종삼
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	public void selectCourseDetail(
			Model model
	       , DataMap requestMap) throws Exception {
		
		requestMap.setNullToInitialize(true);
		
		// 새로 처리하는 부분
		int iNum = myClassService.setLcmsCmiClear(requestMap);
		System.out.println(iNum);
		
		DataMap listMap = myClassService.courseDetail(requestMap);
		
		model.addAttribute("LIST_DATA", listMap);
	}
	
	@RequestMapping(value="/mypage/myclass.do", params="mode=courseDetail")
	public String courseDetail(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			, HttpSession session
			, HttpServletResponse response
			) throws Exception{
		
		DataMap requestMap = cm.getDataMap();
		
		// 사이버과목 회차 리스트
		if (requestMap.getString("grcode").length() > 0){
			session.setAttribute("sess_grcode", 		Util.getValue(requestMap.getString("grcode"), ""));
			session.setAttribute("sess_grseq", 		Util.getValue(requestMap.getString("grseq"), ""));
		} else {
			requestMap.setString("grcode",(String)session.getAttribute("sess_grcode"));
			requestMap.setString("grseq",(String)session.getAttribute("sess_grseq"));
		}
		// 쿠키값 굽기
		// LCMS 를 연동하기위한 쿠키값 생성
		// cookieGrcode		-- 과정코드
		// cookieGrseq		-- 과정기수
		// UserId		-- 사용자번호
		// UserName		-- 사용자명
		//Util.setCookie(response, "cookieGrcode",  requestMap.getString("grcode"));
		//Util.setCookie(response, "cookieGrseq",  requestMap.getString("grseq"));
		//Util.setCookie(response, "UserId",  requestMap.getString("userno"));
		//Util.setCookie(response, "UserName",  requestMap.getString("userName"));
		
		
		requestMap.setString("Grcode", requestMap.getString("grcode"));
		requestMap.setString("Grseq", requestMap.getString("grseq"));
		requestMap.setString("UserId", requestMap.getString("userno"));
		requestMap.setString("UserName", requestMap.getString("userName"));
		
		if (requestMap.getString("grcode").length() > 0){
			selectCourseDetail(model, requestMap);
		}
		
		return findView(cm, cm.getDataMap().getString("mode"), "/homepage/mypage/myclass/courseDetail");
	}
	
	//학습개체 목록
	public void selectItemList(
			Model model
	        , DataMap requestMap) throws Exception {
	
		requestMap.setNullToInitialize(true);

		//DataMap CDMap = service.courseDetailView(requestMap);
		DataMap CDMap = myClassService.selectItemList(requestMap);
		CDMap.setNullToInitialize(true);
		//model.addAttribute("LIST_DETAIL", CDMap);
		model.addAttribute("ITEM_LIST", CDMap);
	}
	
	// itemList jsp 자체가 없음
	@RequestMapping(value="/mypage/myclass.do", params="mode=itemList")
	public String itemList(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			, HttpSession session
			, HttpServletResponse response
			) throws Exception{
		
		DataMap requestMap = cm.getDataMap();
		// 학습개체목록 보기
		selectItemList(model, requestMap);
		
		return findView(cm, cm.getDataMap().getString("mode"), "/homepage/mypage/myclass/itemList");
	}
	
	/**
	 * 사이버과목 회차별 SCO(ITEM) 진도율확인하기
	 * 작성일 : 8월 29일
	 * 작성자 : 최종삼
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	public void progressRate(
			Model model
	        , DataMap requestMap) throws Exception {
	
		requestMap.setNullToInitialize(true);

		DataMap listMap = myClassService.progressRate(requestMap);
		
		model.addAttribute("LIST_DATA", listMap);
	}
	
	@RequestMapping(value="/mypage/myclass.do", params="mode=progressRate")
	public String progressRate(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			, HttpSession session
			, HttpServletResponse response
			) throws Exception{
		
		DataMap requestMap = cm.getDataMap();
		//사이버과목 회차별 SCO(ITEM) 진도율확인하기
		if (requestMap.getString("grcode").length() > 0){
			session.setAttribute("sess_grcode", 		Util.getValue(requestMap.getString("grcode"), ""));
			session.setAttribute("sess_grseq", 		Util.getValue(requestMap.getString("grseq"), ""));
		} else {
			requestMap.setString("grcode",(String)session.getAttribute("sess_grcode"));
			requestMap.setString("grseq",(String)session.getAttribute("sess_grseq"));
		}
		
		if (requestMap.getString("grcode").length() > 0){
			progressRate(model, requestMap);
		}
		
		return findView(cm, cm.getDataMap().getString("mode"), "/homepage/mypage/myclass/processRating");
	}
	
	@RequestMapping(value="/mypage/myclass.do", params="mode=LoginForm")
	public String LoginForm(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			, HttpSession session
			, HttpServletResponse response
			) throws Exception{
		
		return findView(cm, cm.getDataMap().getString("mode"), "/homepage/alertloginrequire");
	}
	
	/**
	 * 과정공지 리스트
	 * 작성일 : 8월 29일
	 * 작성자 : 최종삼
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	public void selectGrnoticeList(
			Model model
	        , DataMap requestMap) throws Exception {
	
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
		
		DataMap listMap = myClassService.selectGrnoticeList(requestMap); 
		
		model.addAttribute("LIST_DATA", listMap);

	}
	
	@RequestMapping(value="/mypage/myclass.do", params="mode=selectGrnoticeList")
	public String selectGrnoticeList(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			, HttpSession session
			, HttpServletResponse response
			) throws Exception{
		
		DataMap requestMap = cm.getDataMap();
		
		if (requestMap.getString("grcode").length() > 0){
			session.setAttribute("sess_grcode", 		Util.getValue(requestMap.getString("grcode"), ""));
			session.setAttribute("sess_grseq", 		Util.getValue(requestMap.getString("grseq"), ""));
		} else {
			requestMap.setString("grcode",(String)session.getAttribute("sess_grcode"));
			requestMap.setString("grseq",(String)session.getAttribute("sess_grseq"));
		}
		
		if (requestMap.getString("grcode").length() > 0){
			
			// 과정 공지
			selectGrnoticeList(model, requestMap);
		}
		
		return findView(cm, cm.getDataMap().getString("mode"), "/homepage/mypage/myclass/selectGrnoticeList");
	}
	
	/**
	 * 과정공지 상세 페이지
	 * 작성일 : 8월 29일
	 * 작성자 : 최종삼
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	public void grnoticeListView(
			Model model
	        , DataMap requestMap) throws Exception {
	
		//	초기화 옵션(true 일경우 데이터를 뽑을때 null 일경우 초기화 - 빈문자열, 0....)
		requestMap.setNullToInitialize(true);
		//	초기화 옵션(true 일경우 데이터를 뽑을때 null 일경우 초기화 - 빈문자열, 0....)
		requestMap.setNullToInitialize(true);

		DataMap listMap = myClassService.grnoticeListView(requestMap);
		
		listMap.put("groupfileNo",Util.getIntValue(listMap.get("groupfileNo").toString(), 0));
		
		if(Util.getIntValue(listMap.get("groupfileNo").toString(), 0) > 0){
		 	commonService.selectUploadFileList(listMap);
		}

		// 파일 업로드 자료 가져오기
		// commonService.selectUploadFileList(listMap);
		
		model.addAttribute("LIST_DATA", listMap);
	}
	
	@RequestMapping(value="/mypage/myclass.do", params="mode=grnoticeListView")
	public String grnoticeListView(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			, HttpSession session
			, HttpServletResponse response
			) throws Exception{
		
		DataMap requestMap = cm.getDataMap();
		
		if (requestMap.getString("grcode").length() > 0){
			session.setAttribute("sess_grcode", 		Util.getValue(requestMap.getString("grcode"), ""));
			session.setAttribute("sess_grseq", 		Util.getValue(requestMap.getString("grseq"), ""));
		} else {
			requestMap.setString("grcode",(String)session.getAttribute("sess_grcode"));
			requestMap.setString("grseq",(String)session.getAttribute("sess_grseq"));
		}
		
		if (requestMap.getString("grcode").length() > 0){
			// 과정 공지 내용 보기
			grnoticeListView(model, requestMap);
		}
		
		return findView(cm, cm.getDataMap().getString("mode"), "/homepage/mypage/myclass/grnoticListView");
	}
	
	/**
	 * 토론방 리스트
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @param requestMap
	 * @param tableName
	 * @throws Exception
	 */
	public void discussList(
			Model model
	        , DataMap requestMap) throws Exception {
				
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
			requestMap.setInt("rowSize", 10); 
		}
		// 페이지 블럭 갯수
		if (requestMap.getString("pageSize").equals("")){
			requestMap.setInt("pageSize", 10);
		}
		
		// 리스트 가져오기
		listMap = myClassService.discussList(requestMap);
		//과정기수 상세정보
		DataMap grInfoMap = myClassService.selectGrInfo(requestMap);
		
		model.addAttribute("LIST_DATA", listMap);
		model.addAttribute("GRINFO_DATA", grInfoMap);
		
	}
	
	@RequestMapping(value="/mypage/myclass.do", params="mode=discussList")
	public String discussList(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			, HttpSession session
			, HttpServletResponse response
			) throws Exception{
		
		DataMap requestMap = cm.getDataMap();
		
		if (requestMap.getString("grcode").length() > 0){
			session.setAttribute("sess_grcode", 		Util.getValue(requestMap.getString("grcode"), ""));
			session.setAttribute("sess_grseq", 		Util.getValue(requestMap.getString("grseq"), ""));
		} else {
			requestMap.setString("grcode",(String)session.getAttribute("sess_grcode"));
			requestMap.setString("grseq",(String)session.getAttribute("sess_grseq"));
		}
		
		if (requestMap.getString("grcode").length() > 0){
			discussList(model, requestMap);
		}
		
		return findView(cm, cm.getDataMap().getString("mode"), "/homepage/mypage/myclass/discussList");
	}
	
	/**
	 * 토론방 게시판 뷰
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @param requestMap
	 * @param strKind
	 * @throws Exception
	 */
	public void discussView(
			Model model
	        , DataMap requestMap) throws Exception {

		
		DataMap viewMap = null;
		DataMap memberMap = null;

		
		// 로그인후 회원정보에 관련된 내용을 가져오는 부분 
		if (!requestMap.getString("qu").equals("discussVew") && !requestMap.getString("qu").equals("insertDiscuss")){
			if (requestMap.getString("userId").length() > 0){
				memberMap = myClassService.discussView(requestMap);
			} else {
				memberMap = new DataMap();
			}
		} else {
			memberMap = new DataMap();
		}
		
		if(requestMap.getString("qu").equals("insertDiscuss")){
			//인서트폼일경우 모든데이터를 초기화 시킨다.
			viewMap = new DataMap();
		}else{//수정폼이거나 또는 뷰페이지, 답글일경우
			
			if(requestMap.getString("qu").equals("discussView")){
				//쿼리
				String query = "UPDATE tb_grdiscuss SET ";
						query += "visit = visit + 1 ";
						query += "WHERE grcode = '"+requestMap.getString("grcode")+"' ";
						query += "AND grseq = '"+requestMap.getString("grseq")+"' ";
						query += "AND seq = '"+requestMap.getString("seq")+"' ";
				//카운터값
				myClassService.discussCnt(query);
				//테이블네임 지정
			}
			//게시물 상세 정보
			viewMap = myClassService.discussView(requestMap);
			
			// 파일 정보 가져오기.fileGroupList
			if(requestMap.getString("qu").equals("insertReplyDiscuss")){
				// viewMap.setInt("groupfileNo", 0);
			}
			
			// 파일이 없는경우 조회하지 않도록 조치
			if (requestMap.getInt("groupfileNo") > 0){
				commonService.selectUploadFileList(viewMap);
			}
		}
		
		//과정기수 상세정보 가져오기
		DataMap grInfoMap = myClassService.selectGrInfo(requestMap); 
		
		model.addAttribute("GRINFO_DATA", grInfoMap);
		model.addAttribute("MEMBER_DATA",memberMap);
		model.addAttribute("BOARDVIEW_DATA", viewMap);
	}
	
	@RequestMapping(value="/mypage/myclass.do", params="mode=discussView")
	public String discussView(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			, HttpSession session
			, HttpServletResponse response
			) throws Exception{
		
		DataMap requestMap = cm.getDataMap();
		
		if (requestMap.getString("grcode").length() > 0){
			session.setAttribute("sess_grcode", 		Util.getValue(requestMap.getString("grcode"), ""));
			session.setAttribute("sess_grseq", 		Util.getValue(requestMap.getString("grseq"), ""));
		} else {
			requestMap.setString("grcode",(String)session.getAttribute("sess_grcode"));
			requestMap.setString("grseq",(String)session.getAttribute("sess_grseq"));
		}
		
		if (requestMap.getString("grcode").length() > 0){
			discussView(model, requestMap);
		}
		
		return findView(cm, cm.getDataMap().getString("mode"), "/homepage/mypage/myclass/discussView");
	}
	
	@RequestMapping(value="/mypage/myclass.do", params="mode=discussWrite")
	public String discussWrite(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			, HttpSession session
			, HttpServletResponse response
			) throws Exception{
		
		DataMap requestMap = cm.getDataMap();
		
		if (requestMap.getString("grcode").length() > 0){
			session.setAttribute("sess_grcode", 		Util.getValue(requestMap.getString("grcode"), ""));
			session.setAttribute("sess_grseq", 		Util.getValue(requestMap.getString("grseq"), ""));
		} else {
			requestMap.setString("grcode",(String)session.getAttribute("sess_grcode"));
			requestMap.setString("grseq",(String)session.getAttribute("sess_grseq"));
		}
		
		if (requestMap.getString("grcode").length() > 0){
			discussView(model, requestMap);
		}
		
		return findView(cm, cm.getDataMap().getString("mode"), "/homepage/mypage/myclass/discussForm");
	}
	
	@RequestMapping(value="/mypage/myclass.do", params="mode=discussReWrite")
	public String discussReWrite(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			, HttpSession session
			, HttpServletResponse response
			) throws Exception{
		
		DataMap requestMap = cm.getDataMap();
		
		if (requestMap.getString("grcode").length() > 0){
			session.setAttribute("sess_grcode", 		Util.getValue(requestMap.getString("grcode"), ""));
			session.setAttribute("sess_grseq", 		Util.getValue(requestMap.getString("grseq"), ""));
		} else {
			requestMap.setString("grcode",(String)session.getAttribute("sess_grcode"));
			requestMap.setString("grseq",(String)session.getAttribute("sess_grseq"));
		}
		
		if (requestMap.getString("grcode").length() > 0){
			discussView(model, requestMap);
		}
		
		return findView(cm, cm.getDataMap().getString("mode"), "/homepage/mypage/myclass/discussForm");
	}
	
	@RequestMapping(value="/mypage/myclass.do", params="mode=discussModify")
	public String discussModify(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			, HttpSession session
			, HttpServletResponse response
			) throws Exception{
		
		DataMap requestMap = cm.getDataMap();
		
		if (requestMap.getString("grcode").length() > 0){
			session.setAttribute("sess_grcode", 		Util.getValue(requestMap.getString("grcode"), ""));
			session.setAttribute("sess_grseq", 		Util.getValue(requestMap.getString("grseq"), ""));
		} else {
			requestMap.setString("grcode",(String)session.getAttribute("sess_grcode"));
			requestMap.setString("grseq",(String)session.getAttribute("sess_grseq"));
		}
		
		if (requestMap.getString("grcode").length() > 0){
			discussView(model, requestMap);
		}
		
		return findView(cm, cm.getDataMap().getString("mode"), "/homepage/mypage/myclass/discussForm");
	}
	
	@RequestMapping(value="/mypage/myclass.do", params="mode=discussDelete")
	public String discussDelete(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			, HttpSession session
			, HttpServletResponse response
			) throws Exception{
		
		DataMap requestMap = cm.getDataMap();
		
		if (requestMap.getString("grcode").length() > 0){
			session.setAttribute("sess_grcode", 		Util.getValue(requestMap.getString("grcode"), ""));
			session.setAttribute("sess_grseq", 		Util.getValue(requestMap.getString("grseq"), ""));
		} else {
			requestMap.setString("grcode",(String)session.getAttribute("sess_grcode"));
			requestMap.setString("grseq",(String)session.getAttribute("sess_grseq"));
		}
		
		if (requestMap.getString("grcode").length() > 0){
			discussView(model, requestMap);
		}
		
		return findView(cm, cm.getDataMap().getString("mode"), "/homepage/mypage/myclass/discussForm");
	}
	
	/**
	 * 토론방 등록, 수정 실행
	 * 작성일 : 8월 30일
	 * 작성자 : 최종삼  
	 * @param mapping
	 * @param form 
	 * @param request
	 * @param response
	 * @param requestMap
	 * @throws Exception
	 */
	public void discussExec(
			Model model
	        , DataMap requestMap,
	         LoginInfo loginInfo) throws Exception {
		
		String qu = requestMap.getString("qu");
		
		//등록 및 수정시만 파일 업로드 처리.
		int fileGroupNo = -1;
		if( qu.equals("insertDiscuss") || qu.equals("modifyDiscuss") || qu.equals("insertReplyDiscuss")){
			
			//파일 등록.
			DataMap fileMap = (DataMap)requestMap.get("UPLOAD_FILE");
			if(fileMap == null) fileMap = new DataMap();
			fileMap.setNullToInitialize(true);
			
			if(fileMap.keySize("fileSysName") > 0 || fileMap.keySize("existFile") > 0 || fileMap.keySize("deleteFile") > 0 || fileMap.keySize("fileUploadOk") > 0)
				fileGroupNo = commonService.insertInnoUploadFile(fileMap, requestMap.getString("INNO_SAVE_DIR"), loginInfo.getSessNo());
			
			Util.saveDaumContent(requestMap, "content", "namoContent", Constants.NAMOUPLOAD_NOTICE);
			//Util.saveNamoContent(requestMap, "content", "namoContent", Constants.NAMOUPLOAD_NOTICE); //나모로 넘어온값 처리.
		}
		
		if(requestMap.getString("qu").equals("insertDiscuss")){
			
			//사용자글 등록
			String query = "SELECT NVL(MAX(SEQ), 0) AS COUNT FROM tb_grdiscuss ";
			query += "WHERE grcode = '"+requestMap.getString("grcode")+"' ";
			query += "AND grseq = '"+requestMap.getString("grseq")+"' ";
			//seq 카운터
			int seqCoutn = myClassService.discussMaxCount(query);
			
			//시퀀스값을 셋킨다
			requestMap.setInt("seq", (seqCoutn+1));
			//setp값을 셋시킨다.
			requestMap.setInt("step", (seqCoutn+1));
			
			//depth값이 널일경우 초기값을 셋시킨다. 초기값은 0.0이다
			if(requestMap.getString("depth").equals("")){
				requestMap.setInt("depth",0);
			}

			//파일넘버값을 셋시킨다
			requestMap.setInt("fileGroupNo",fileGroupNo);
			
			if (loginInfo.isLogin() != false){
				requestMap.setString("wuserno",loginInfo.getSessNo());
				requestMap.setString("username",loginInfo.getSessName());
			} else {
				requestMap.setString("wuserno","9999999999999");
			}
			
			requestMap.setInt("groupfileNo",fileGroupNo);
			
			myClassService.insertDiscuss(requestMap);
			requestMap.setString("msg","등록하였습니다.");
			
		}else if(requestMap.getString("qu").equals("deleteDiscuss")){
			
			double step = requestMap.getDouble("step");
			double minSetp = 0.0;
			
    		if(step <= 0.0){
	    		//스텝값이 1보다 작을경우 0으로 만든다. 
	    		minSetp = 0;
	    		
    		}else if(step > 0.0 && step < 1){
    			minSetp = step;
    			
    		}else{
    			minSetp = step -1;
    			
    		}
    		
			//게시물 상세 정보
			DataMap rowMap = myClassService.discussView(requestMap);
			rowMap = (DataMap) Functions.initMap().apply(rowMap);
			
			boolean delOk = false;
			if (loginInfo.isLogin() == false){
				if (rowMap.get("passwd").toString().length() > 0 && rowMap.get("passwd").toString().equals(requestMap.getString("passwd"))){
					delOk = true;
				}
			} else {
				if (loginInfo.getSessNo().equals(rowMap.get("wuserno"))){
					delOk = true;
				}
			}
			// 로그인 세션 넘버가 동일하거나 삭제 패스워드가 동일한 경우 삭제
			if (delOk == true){	
				//물리 파일삭제
				if(Util.parseInt(rowMap.get("groupfileNo")) > 0){
					FileUtil.commonDeleteGroupfile(Util.parseInt(rowMap.get("groupfileNo")));
				}
				
				String query = "SELECT COUNT(*) AS TOTAL FROM tb_grdiscuss ";
					query += "WHERE grcode = '"+requestMap.getString("grcode")+"' ";
					query += "AND grseq = '"+requestMap.getString("grseq")+"' ";
					query += "AND STEP < " + step +" AND STEP >" + minSetp;
				
				int count  = myClassService.discussMaxCount(query);
				requestMap.setInt("count", count);
				requestMap.setString("sessNo",loginInfo.getSessNo());
				myClassService.discussDelete(requestMap);
				
				requestMap.setString("msg","삭제하였습니다.");
			} else {
				requestMap.setString("msg","삭제에 실패하였습니다. 권한이 없습니다.");
			}
			
		}else if(requestMap.getString("qu").equals("modifyDiscuss")){
			//게시물 상세 정보
			System.out.println("1");
			DataMap rowMap = myClassService.discussView(requestMap);
			rowMap = (DataMap) Functions.initMap().apply(rowMap);
			boolean delOk = false;
			System.out.println("2");
			
			if (loginInfo.isLogin() == false){
				if (rowMap.get("username").equals(requestMap.getString("username")) && rowMap.get("passwd").equals(requestMap.getString("passwd"))){
					delOk = true;
				}
				System.out.println("4");
			} else {
				if (loginInfo.getSessNo().equals(rowMap.get("wuserno"))){
					delOk = true;
				}
			}
			System.out.println("5");
			// 로그인 세션 넘버가 동일하거나 삭제 패스워드가 동일한 경우 수정
			if (delOk == true){	
				myClassService.modifyDiscuss(requestMap);
			
				requestMap.setString("msg","수정하였습니다.");
			} else {
				requestMap.setString("msg","권한이 없습니다.");
			}
			System.out.println("6");
				
		}else if(requestMap.getString("qu").equals("insertReplyDiscuss")){
	    	//serp 제일 낮은값
	    	double minSetpNo = 0.0;
	    	//최종 가공 setp값
	    	double rplayStep = 0.0;
	    	//뎁스
	    	int depth = 0;
	    	
			//사용자글 등록 수정 하여야함
	    	String query = "SELECT COUNT(*) AS TOTAL FROM tb_grdiscuss ";
			query += "WHERE grcode = '"+requestMap.getString("grcode")+"' ";
			query += "AND grseq = '"+requestMap.getString("grseq")+"' ";
			System.out.println("확인1");
			//seq 카운터
			int seqCoutn = myClassService.discussMaxCount(query);
			System.out.println("확인2");
			//시퀀스값을 셋킨다
			requestMap.setInt("seq", seqCoutn+1);
			//파일넘버값을 셋시킨다
			requestMap.setInt("fileGroupNo",fileGroupNo);
			
			if (loginInfo.isLogin() != false){
				//현재 유저넘버 셋
				requestMap.setString("wuserno",loginInfo.getSessNo());
				//현재 유저네임 셋
				requestMap.setString("username",loginInfo.getSessName());
			} else {
				requestMap.setString("wuserno","9999999999999");
			}
			
			//넘어온 파일넘버 셋
			requestMap.setInt("groupfileNo",fileGroupNo);
			System.out.println("확인3");
    		depth = requestMap.getInt("depth");
    		
    		double step  = requestMap.getDouble("step");
    		
    		double minSetp = 0.0;
    		
    		
    		System.out.println("확인4");
    		if(requestMap.getInt("depth") <= 0){
	    		//제일 낮은 setp값 구해오기 
	    		step  = requestMap.getDouble("step");// 1이들어간다.
	    		minSetp = 0.0;
	    		
	    		if(step <= 1){// 1보다 작을때에는 최하수에 1을넣는다.
	    		//스텝값이 0일경우
	    			minSetp = 0.0;
	    		}else{
	    			minSetp = step -1; //아닐때에는 1을뺀다 
	    		}
	    		
	    		minSetpNo	=  myClassService.selectDiscussMinNoRow(requestMap.getString("grcode"), requestMap.getString("grseq"), step, minSetp, requestMap.getInt("depth")+1);
	    		/*
	    		 * 
	    		 * 확인해봐야할부분
	    		if(minSetpNo == 0 && step <= 1){
	    			minSetpNo = minSetp;
	    			
	    		}else{
	    			minSetpNo = step;
	    		}
	    		*/
    		}else if(requestMap.getInt("depth") > 0){
    			
    			if(step >= 1){
    				minSetp	= step-1;
    			}else{
    				minSetp = 0.0;
    			}
    			
    			minSetpNo	=  myClassService.selectDiscussMinNoRow(requestMap.getString("grcode"), requestMap.getString("grseq"), step, minSetp, requestMap.getInt("depth")+1);
    			
    		}
    		System.out.println("확인5");
    		depth = requestMap.getInt("depth")+1;
    		String depthTwo =Integer.toString(depth);
    		
    		if(minSetpNo == 0){
    			minSetpNo = step;
    		}
    		
    		rplayStep = minSetpNo - Math.pow(0.01, Double.parseDouble(depthTwo));

    		requestMap.setDouble("step", rplayStep);
    		requestMap.setInt("depth", depth);
    		
    		System.out.println("확인6");
    		//답글등록
    		myClassService.insertDiscuss(requestMap);
    		
			requestMap.setString("msg","등록하였습니다.");
			System.out.println("확인7");
			//파일넘버값을 셋시킨다
			requestMap.setInt("fileGroupNo",fileGroupNo);
			System.out.println("확인8");
		}
	}
	
	@RequestMapping(value="/mypage/myclass.do", params="mode=discussExec")
	public String discussExec(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			, HttpSession session
			, HttpServletResponse response
			) throws Exception{
		
		DataMap requestMap = cm.getDataMap();
		
		if (requestMap.getString("grcode").length() > 0){
			session.setAttribute("sess_grcode", 		Util.getValue(requestMap.getString("grcode"), ""));
			session.setAttribute("sess_grseq", 		Util.getValue(requestMap.getString("grseq"), ""));
		} else {
			requestMap.setString("grcode",(String)session.getAttribute("sess_grcode"));
			requestMap.setString("grseq",(String)session.getAttribute("sess_grseq"));
		}
		
		if (requestMap.getString("grcode").length() > 0){
			discussExec(model, requestMap, cm.getLoginInfo());
		}
		
		return findView(cm, cm.getDataMap().getString("mode"), "/homepage/mypage/myclass/discussExec");
	}
	
	@RequestMapping(value="/mypage/myclass.do", params="mode=courseInfoDetail")
	public String courseInfoDetail(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			, HttpSession session
			, HttpServletResponse response
			) throws Exception{
		
		DataMap requestMap = cm.getDataMap();
		
		if (requestMap.getString("grcode").length() > 0){
			session.setAttribute("sess_grcode", 		Util.getValue(requestMap.getString("grcode"), ""));
			session.setAttribute("sess_grseq", 		Util.getValue(requestMap.getString("grseq"), ""));
		} else {
			requestMap.setString("grcode",(String)session.getAttribute("sess_grcode"));
			requestMap.setString("grseq",(String)session.getAttribute("sess_grseq"));
		}
		
		model.addAttribute("COURSE_INFO_POPUP1"    , courseService.getCourseInfoPopup1(requestMap.getString("grcode"), requestMap.getString("grseq")));
		model.addAttribute("COURSE_INFO_POPUP2"    , courseService.getCourseInfoPopup2(requestMap.getString("grcode"), requestMap.getString("grseq")));
		model.addAttribute("COURSE_INFO_SUM"       , courseService.getCourseInfoSum(requestMap.getString("grcode")));
		model.addAttribute("COURSE_INFO_SUB_SUM1"  , courseService.getCourseInfoSubSum(requestMap.getString("grcode"), "1"));
		model.addAttribute("COURSE_INFO_SUB_SUM2"  , courseService.getCourseInfoSubSum(requestMap.getString("grcode"), "2"));
		model.addAttribute("COURSE_INFO_SUB_SUM3"  , courseService.getCourseInfoSubSum(requestMap.getString("grcode"), "3"));
		model.addAttribute("COURSE_INFO_DETAIL"    , courseService.getCourseInfoDetail(requestMap.getString("grcode")));
		
		return findView(cm, cm.getDataMap().getString("mode"), "/homepage/mypage/myclass/courseInfoDetail");
	}
	
	// 선택과목 리스트
	public void selectSubLecture(
			Model model
	        , DataMap requestMap) throws Exception {
				
		DataMap resultMap = null;
		// 수강 신청
		resultMap = myClassService.selectSubLecture(requestMap);
		model.addAttribute("LIST_DATA",resultMap);
	}
	
	@RequestMapping(value="/mypage/myclass.do", params="mode=selectSubLecture")
	public String selectSubLecture(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			, HttpSession session
			, HttpServletResponse response
			) throws Exception{
		
		DataMap requestMap = cm.getDataMap();
		
		selectSubLecture(model, requestMap);
		
		return findView(cm, cm.getDataMap().getString("mode"), "/homepage/mypage/myclass/choiceLecPop");
	}
	
	public void choiceSubLecture(
			Model model
	        , DataMap requestMap) throws Exception {
				
		// 수강 신청
		String Msg = myClassService.choiceSubLecture(requestMap);
		requestMap.setString("Msg",Msg);
	}
	
	@RequestMapping(value="/mypage/myclass.do", params="mode=choiceSubLecture")
	public String choiceSubLecture(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			, HttpSession session
			, HttpServletResponse response
			) throws Exception{
		
		DataMap requestMap = cm.getDataMap();
		
		choiceSubLecture(model, requestMap);
		
		return findView(cm, cm.getDataMap().getString("mode"), "/homepage/mypage/myclass/choiceMsg");
	}
	
	@RequestMapping(value="/mypage/myclass.do", params="mode=requestExec")
	public String requestExec(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			, HttpSession session
			, HttpServletResponse response
			) throws Exception{
		
		DataMap requestMap = cm.getDataMap();
		
		return findView(cm, requestMap.getString("mode"), "/homepage/mypage/myclass/processRating");
	}
	
	// 선택과목 리스트
	public void selectReportList(
			Model model
	        , DataMap requestMap) throws Exception {
				
		DataMap resultMap = null;
		// 수강 신청
		resultMap = myClassService.selectReportList(requestMap);
		model.addAttribute("LIST_DATA",resultMap);
		
	}
	
	@RequestMapping(value="/mypage/myclass.do", params="mode=selectReportList")
	public String selectReportList(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			, HttpSession session
			, HttpServletResponse response
			) throws Exception{
		
		DataMap requestMap = cm.getDataMap();
		
		if (requestMap.getString("grcode").length() > 0){
			session.setAttribute("sess_grcode", 		Util.getValue(requestMap.getString("grcode"), ""));
			session.setAttribute("sess_grseq", 		Util.getValue(requestMap.getString("grseq"), ""));
		} else {
			requestMap.setString("grcode",(String)session.getAttribute("sess_grcode"));
			requestMap.setString("grseq",(String)session.getAttribute("sess_grseq"));
		}
	
		selectReportList(model, requestMap);
		
		return findView(cm, requestMap.getString("mode"), "/homepage/mypage/myclass/selectReportList");
	}
	
	// 선택과목 상세보기
	public void reportView(
			Model model
	        , DataMap requestMap) throws Exception {
				
		DataMap resultMap = null;
		// 수강 신청
		resultMap = myClassService.reportView(requestMap);
		model.addAttribute("LIST_DATA",resultMap);
		
	}
	
	@RequestMapping(value="/mypage/myclass.do", params="mode=reportView")
	public String reportView(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			, HttpSession session
			, HttpServletResponse response
			) throws Exception{
		
		DataMap requestMap = cm.getDataMap();
		
		if (requestMap.getString("grcode").length() > 0){
			session.setAttribute("sess_grcode", 		Util.getValue(requestMap.getString("grcode"), ""));
			session.setAttribute("sess_grseq", 		Util.getValue(requestMap.getString("grseq"), ""));
		} else {
			requestMap.setString("grcode",(String)session.getAttribute("sess_grcode"));
			requestMap.setString("grseq",(String)session.getAttribute("sess_grseq"));
		}
	
		reportView(model, requestMap);

		return findView(cm, requestMap.getString("mode"), "/homepage/mypage/myclass/reportView");
	}
	
	public void reportExec(
			Model model
	        , DataMap requestMap,
	         LoginInfo loginInfo) throws Exception {
		
		//등록 및 수정시만 파일 업로드 처리.
		int fileGroupNo = -1;
		
		//파일 등록.
		DataMap fileMap = (DataMap)requestMap.get("UPLOAD_FILE");
		if(fileMap == null) fileMap = new DataMap();
		fileMap.setNullToInitialize(true);
		
		
		if(fileMap.keySize("fileSysName") > 0 || fileMap.keySize("existFile") > 0 || fileMap.keySize("deleteFile") > 0 || fileMap.keySize("fileUploadOk") > 0)
			fileGroupNo = commonService.insertInnoUploadFile(fileMap, requestMap.getString("INNO_SAVE_DIR"), loginInfo.getSessNo());
		
		// Util.saveNamoContent(requestMap, "content", "namoContent", Constants.NAMOUPLOAD_NOTICE); //나모로 넘어온값 처리.
		
		requestMap.setInt("groupfileNo", fileGroupNo);
		String Msg = myClassService.reportSubmit(requestMap);
		
		requestMap.setString("Msg", Msg);
	
	}
	
	@RequestMapping(value="/mypage/myclass.do", params="mode=reportExec")
	public String reportExec(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			, HttpSession session
			, HttpServletResponse response
			) throws Exception{
		
		DataMap requestMap = cm.getDataMap();
		
		if (requestMap.getString("grcode").length() > 0){
			session.setAttribute("sess_grcode", 		Util.getValue(requestMap.getString("grcode"), ""));
			session.setAttribute("sess_grseq", 		Util.getValue(requestMap.getString("grseq"), ""));
		} else {
			requestMap.setString("grcode",(String)session.getAttribute("sess_grcode"));
			requestMap.setString("grseq",(String)session.getAttribute("sess_grseq"));
		}
		
		reportExec(model, requestMap, cm.getLoginInfo());
		
		return findView(cm, requestMap.getString("mode"), "/homepage/mypage/myclass/reportExec");
	}
	
	// 과제물 평가의견
	public void viewReport(
			Model model
	         , DataMap requestMap) throws Exception {
		
		String strEstmate = "";
		
		strEstmate = myClassService.viewReportSubmit(requestMap);
				
		model.addAttribute("strEstmate", strEstmate);
		
	}
	
	@RequestMapping(value="/mypage/myclass.do", params="mode=viewReport")
	public String viewReport(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			, HttpSession session
			, HttpServletResponse response
			) throws Exception{
		
		DataMap requestMap = cm.getDataMap();
		
		if (requestMap.getString("grcode").length() > 0){
			session.setAttribute("sess_grcode", 		Util.getValue(requestMap.getString("grcode"), ""));
			session.setAttribute("sess_grseq", 		Util.getValue(requestMap.getString("grseq"), ""));
		} else {
			requestMap.setString("grcode",(String)session.getAttribute("sess_grcode"));
			requestMap.setString("grseq",(String)session.getAttribute("sess_grseq"));
		}
		
		viewReport(model, requestMap);
		
		return findView(cm, requestMap.getString("mode"), "/homepage/mypage/myclass/viewReport");
	}
	
	/**
	 * 토론방 리스트
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @param requestMap
	 * @param tableName
	 * @throws Exception
	 */
	public void suggestionList(
			Model model
	        , DataMap requestMap) throws Exception {
				
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
			requestMap.setInt("rowSize", 10); 
		}
		// 페이지 블럭 갯수
		if (requestMap.getString("pageSize").equals("")){
			requestMap.setInt("pageSize", 10);
		}
		
		// 리스트 가져오기
		listMap = myClassService.suggestionList(requestMap);
		model.addAttribute("LIST_DATA", listMap);
		
	}
	
	@RequestMapping(value="/mypage/myclass.do", params="mode=suggestionList")
	public String suggestionList(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			, HttpSession session
			, HttpServletResponse response
			) throws Exception{
		
		DataMap requestMap = cm.getDataMap();
		
		if (requestMap.getString("grcode").length() > 0){
			session.setAttribute("sess_grcode", 		Util.getValue(requestMap.getString("grcode"), ""));
			session.setAttribute("sess_grseq", 		Util.getValue(requestMap.getString("grseq"), ""));
		} else {
			requestMap.setString("grcode",(String)session.getAttribute("sess_grcode"));
			requestMap.setString("grseq",(String)session.getAttribute("sess_grseq"));
		}
		
		if (requestMap.getString("grcode").length() > 0){
			suggestionList(model, requestMap);
		}
		
		return findView(cm, requestMap.getString("mode"), "/homepage/mypage/myclass/suggestionList");
	}
	
	/**
	 * 토론방 게시판 뷰
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @param requestMap
	 * @param strKind
	 * @throws Exception
	 */
	public void suggestionView(
			Model model
	        , DataMap requestMap) throws Exception {

		

		DataMap viewMap = null;
		DataMap memberMap = null;
		DataMap fileMap   = null;

		
		// 로그인후 회원정보에 관련된 내용을 가져오는 부분 
		if (!requestMap.getString("qu").equals("suggestionVew") && !requestMap.getString("qu").equals("insertSuggestion")){
			if (requestMap.getString("userId").length() > 0){
				memberMap = myClassService.suggestionView(requestMap);
			} else {
				memberMap = new DataMap();
			}
		} else {
			memberMap = new DataMap();
		}
		
		if(requestMap.getString("qu").equals("insertSuggestion")){
			//인서트폼일경우 모든데이터를 초기화 시킨다.
			viewMap = new DataMap();
		}else{//수정폼이거나 또는 뷰페이지, 답글일경우
			
			/*
			if(requestMap.getString("qu").equals("suggestionView")){
				//쿼리
				String query = "UPDATE tb_grsuggestion SET ";
						query += "visit = visit + 1 ";
						query += "WHERE grcode = '"+requestMap.getString("grcode")+"' ";
						query += "AND grseq = '"+requestMap.getString("grseq")+"' ";
						query += "AND no = '"+requestMap.getString("seq")+"' ";
				//카운터값
				service.suggestionCnt(query);
				//테이블네임 지정
			}
			*/
			//게시물 상세 정보
			viewMap = myClassService.suggestionView(requestMap);
			
			// 파일 정보 가져오기.fileGroupList
			if(requestMap.getString("qu").equals("insertReplySuggestion")){
				// viewMap.setInt("groupfileNo", 0);
			}
			
			// 파일이 없는경우 조회하지 않도록 조치
			if (Util.parseInt(viewMap.get("groupfileNo")) > 0){
			 	commonService.selectUploadFileList(viewMap);
			}
		}
		
		model.addAttribute("MEMBER_DATA",memberMap);
		model.addAttribute("BOARDVIEW_DATA", viewMap);
	}
	
	@RequestMapping(value="/mypage/myclass.do", params="mode=suggestionView")
	public String suggestionView(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			, HttpSession session
			, HttpServletResponse response
			) throws Exception{
		
		DataMap requestMap = cm.getDataMap();
		
		if (requestMap.getString("grcode").length() > 0){
			session.setAttribute("sess_grcode", 		Util.getValue(requestMap.getString("grcode"), ""));
			session.setAttribute("sess_grseq", 		Util.getValue(requestMap.getString("grseq"), ""));
		} else {
			requestMap.setString("grcode",(String)session.getAttribute("sess_grcode"));
			requestMap.setString("grseq",(String)session.getAttribute("sess_grseq"));
		}
		
		if (requestMap.getString("grcode").length() > 0){
			suggestionView(model, requestMap);
		}
		
		return findView(cm, requestMap.getString("mode"), "/homepage/mypage/myclass/suggestionView");
	}
	
	@RequestMapping(value="/mypage/myclass.do", params="mode=suggestionWrite")
	public String suggestionWrite(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			, HttpSession session
			, HttpServletResponse response
			) throws Exception{
		
		DataMap requestMap = cm.getDataMap();
		
		if (requestMap.getString("grcode").length() > 0){
			session.setAttribute("sess_grcode", 		Util.getValue(requestMap.getString("grcode"), ""));
			session.setAttribute("sess_grseq", 		Util.getValue(requestMap.getString("grseq"), ""));
		} else {
			requestMap.setString("grcode",(String)session.getAttribute("sess_grcode"));
			requestMap.setString("grseq",(String)session.getAttribute("sess_grseq"));
		}
		
		if (requestMap.getString("grcode").length() > 0){
			suggestionView(model, requestMap);
		}
		
		return findView(cm, requestMap.getString("mode"), "/homepage/mypage/myclass/suggestionForm");
	}
	
	@RequestMapping(value="/mypage/myclass.do", params="mode=suggestionModify")
	public String suggestionModify(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			, HttpSession session
			, HttpServletResponse response
			) throws Exception{
		
		DataMap requestMap = cm.getDataMap();
		
		if (requestMap.getString("grcode").length() > 0){
			session.setAttribute("sess_grcode", 		Util.getValue(requestMap.getString("grcode"), ""));
			session.setAttribute("sess_grseq", 		Util.getValue(requestMap.getString("grseq"), ""));
		} else {
			requestMap.setString("grcode",(String)session.getAttribute("sess_grcode"));
			requestMap.setString("grseq",(String)session.getAttribute("sess_grseq"));
		}
		
		if (requestMap.getString("grcode").length() > 0){
			suggestionView(model, requestMap);
		}
		
		return findView(cm, requestMap.getString("mode"), "/homepage/mypage/myclass/suggestionForm");
	}
	
	@RequestMapping(value="/mypage/myclass.do", params="mode=suggestionDelete")
	public String suggestionDelete(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			, HttpSession session
			, HttpServletResponse response
			) throws Exception{
		
		DataMap requestMap = cm.getDataMap();
		
		return findView(cm, requestMap.getString("mode"), "/homepage/mypage/myclass/suggestionForm");
	}
	
	/**
	 * 토론방 등록, 수정 실행
	 * 작성일 : 8월 30일
	 * 작성자 : 최종삼  
	 * @param mapping
	 * @param form 
	 * @param request
	 * @param response
	 * @param requestMap
	 * @throws Exception
	 */
	public void suggestionExec(
	         DataMap requestMap,
	         LoginInfo loginInfo) throws Exception {
		
		
		String qu = requestMap.getString("qu");
		
		//등록 및 수정시만 파일 업로드 처리.
		int fileGroupNo = -1;
		if( qu.equals("insertSuggestion") || qu.equals("modifySuggestion") || qu.equals("insertReplySuggestion")){
			
			//파일 등록.
			DataMap fileMap = (DataMap)requestMap.get("UPLOAD_FILE");
			if(fileMap == null) fileMap = new DataMap();
			fileMap.setNullToInitialize(true);
			
			if(fileMap.keySize("fileSysName") > 0 || fileMap.keySize("existFile") > 0 || fileMap.keySize("deleteFile") > 0 || fileMap.keySize("fileUploadOk") > 0)
				fileGroupNo = commonService.insertInnoUploadFile(fileMap, requestMap.getString("INNO_SAVE_DIR"), loginInfo.getSessNo());
			
			// Util.saveNamoContent(requestMap, "content", "namoContent", Constants.NAMOUPLOAD_NOTICE); //나모로 넘어온값 처리.
			Util.saveDaumContent(requestMap, "content", "namoContent", Constants.NAMOUPLOAD_NOTICE);
		}
		
		if(requestMap.getString("qu").equals("insertSuggestion")){
			
			//사용자글 등록
			String query = "SELECT DECODE(MAX(NO),'',0,MAX(NO)) AS COUNT FROM tb_grsuggestion ";
			query += "WHERE grcode = '"+requestMap.getString("grcode")+"' ";
			query += "AND grseq = '"+requestMap.getString("grseq")+"' ";
			//seq 카운터
			int seqCoutn = myClassService.discussMaxCount(query);
			
			//시퀀스값을 셋킨다
			requestMap.setInt("seq", (seqCoutn+1));
			//setp값을 셋시킨다.
			requestMap.setInt("step", (seqCoutn+1));
			
			//depth값이 널일경우 초기값을 셋시킨다. 초기값은 0.0이다
			if(requestMap.getString("depth").equals("")){
				requestMap.setInt("depth",0);
			}

			//파일넘버값을 셋시킨다
			requestMap.setInt("fileGroupNo",fileGroupNo);
			
			if (loginInfo.isLogin() != false){
				requestMap.setString("wuserno",loginInfo.getSessNo());
				requestMap.setString("username",loginInfo.getSessName());
			} else {
				requestMap.setString("wuserno","9999999999999");
			}
			
			requestMap.setInt("groupfileNo",fileGroupNo);
			
			myClassService.insertSuggestion(requestMap);
			requestMap.setString("msg","등록하였습니다.");
			
		}else if(requestMap.getString("qu").equals("deleteSuggestion")){
			
			// System.out.println("step value : "+requestMap.getDouble("step"));
			double step = requestMap.getDouble("step");
			
			double minSetp = 0.0;
			
    		if(step <= 0.0){
	    		//스텝값이 1보다 작을경우 0으로 만든다. 
	    		minSetp = 0;
	    		
    		}else if(step > 0.0 && step < 1){
    			minSetp = step;
    			
    		}else{
    			minSetp = step -1;
    			
    		}
    		
			//게시물 상세 정보
			DataMap rowMap = myClassService.suggestionView(requestMap);
			rowMap = (DataMap) Functions.initMap().apply(rowMap);
			
			boolean delOk = false;
			if (loginInfo.isLogin() == false){
				if (rowMap.get("passwd").toString().length() > 0 && rowMap.get("passwd").equals(requestMap.getString("passwd"))){
					delOk = true;
				}
			} else {
				if (loginInfo.getSessNo().equals(rowMap.get("userno"))){
					delOk = true;
				}
			}
			// 로그인 세션 넘버가 동일하거나 삭제 패스워드가 동일한 경우 삭제
			if (delOk == true){	
				//물리 파일삭제
				if(Util.parseInt(rowMap.get("groupfileNo")) > 0){
					FileUtil.commonDeleteGroupfile(Util.parseInt(rowMap.get("groupfileNo")));
				}
				
				String query = "SELECT COUNT(*) AS TOTAL FROM tb_grsuggestion ";
					query += "WHERE grcode = '"+requestMap.getString("grcode")+"' ";
					query += "AND grseq = '"+requestMap.getString("grseq")+"' ";
					query += "AND STEP < " + step +" AND STEP >" + minSetp;
				
				int count  = myClassService.discussMaxCount(query);
				System.out.print(query);
				requestMap.setInt("count", count);
				requestMap.setString("sessNo",loginInfo.getSessNo());
				myClassService.suggestionDelete(requestMap);
				
				requestMap.setString("msg","삭제하였습니다.");
			} else {
				requestMap.setString("msg","삭제에 실패하였습니다. 권한이 없습니다.");
			}
			
		}else if(requestMap.getString("qu").equals("modifySuggestion")){
			//게시물 상세 정보
			System.out.println("111111111111111111111111111111111111111111111111");
			DataMap rowMap = myClassService.suggestionView(requestMap);
			rowMap = (DataMap) Functions.initMap().apply(rowMap);
			boolean delOk = false;
			
			if (loginInfo.isLogin() == false){
				if (rowMap.get("username").equals(requestMap.get("username")) && rowMap.get("passwd").equals(requestMap.getString("passwd"))){
					delOk = true;
				}
			} else {
				if (loginInfo.getSessNo().equals(rowMap.get("userno"))){
					delOk = true;
				}
			}
			System.out.println("5");
			// 로그인 세션 넘버가 동일하거나 삭제 패스워드가 동일한 경우 수정
			if (delOk == true){	
				myClassService.modifySuggestion(requestMap);
			
				requestMap.setString("msg","수정하였습니다.");
			} else {
				requestMap.setString("msg","권한이 없습니다.");
			}
			System.out.println("6");
				
		}else if(requestMap.getString("qu").equals("insertReplySuggestion")){
	    	//serp 제일 낮은값
	    	double minSetpNo = 0.0;
	    	//최종 가공 setp값
	    	double rplayStep = 0.0;
	    	//뎁스
	    	int depth = 0;
	    	
			//사용자글 등록 수정 하여야함
	    	String query = "SELECT COUNT(*) AS TOTAL FROM tb_grsuggestion ";
			query += "WHERE grcode = '"+requestMap.getString("grcode")+"' ";
			query += "AND grseq = '"+requestMap.getString("grseq")+"' ";
			
			//seq 카운터
			int seqCoutn = myClassService.suggestionMaxCount(requestMap);
			
			//시퀀스값을 셋킨다
			requestMap.setInt("seq", seqCoutn+1);
			//파일넘버값을 셋시킨다
			requestMap.setInt("fileGroupNo",fileGroupNo);
			
			if (loginInfo.isLogin() != false){
				//현재 유저넘버 셋
				requestMap.setString("wuserno",loginInfo.getSessNo());
				//현재 유저네임 셋
				requestMap.setString("username",loginInfo.getSessName());
			} else {
				requestMap.setString("wuserno","9999999999999");
			}
			
			//넘어온 파일넘버 셋
			requestMap.setInt("groupfileNo",fileGroupNo);
			
    		depth = requestMap.getInt("depth");
    		
    		double step  = requestMap.getDouble("step");
    		
    		double minSetp = 0.0;
    		
    		
    		
    		if(requestMap.getInt("depth") <= 0){
	    		//제일 낮은 setp값 구해오기 
	    		step  = requestMap.getDouble("step");// 1이들어간다.
	    		minSetp = 0.0;
	    		
	    		if(step <= 1){// 1보다 작을때에는 최하수에 1을넣는다.
	    		//스텝값이 0일경우
	    			minSetp = 0.0;
	    		}else{
	    			minSetp = step -1; //아닐때에는 1을뺀다 
	    		}
	    		
	    		minSetpNo	=  myClassService.selectSuggestionMinNoRow(requestMap.getString("grcode"), requestMap.getString("grseq"), step, minSetp, requestMap.getInt("depth")+1);
	    		/*
	    		 * 
	    		 * 확인해봐야할부분
	    		if(minSetpNo == 0 && step <= 1){
	    			minSetpNo = minSetp;
	    			
	    		}else{
	    			minSetpNo = step;
	    		}
	    		*/
    		}else if(requestMap.getInt("depth") > 0){
    			
    			if(step >= 1){
    				minSetp	= step-1;
    			}else{
    				minSetp = 0.0;
    			}
    			
    			minSetpNo	=  myClassService.selectSuggestionMinNoRow(requestMap.getString("grcode"), requestMap.getString("grseq"), step, minSetp, requestMap.getInt("depth")+1);
    			
    		}
    		
    		depth = requestMap.getInt("depth")+1;
    		String depthTwo =Integer.toString(depth);
    		
    		if(minSetpNo == 0){
    			minSetpNo = step;
    		}
    		
    		rplayStep = minSetpNo - Math.pow(0.01, Double.parseDouble(depthTwo));

    		requestMap.setDouble("step", rplayStep);
    		requestMap.setInt("depth", depth);
    		
    		
    		//답글등록
    		myClassService.insertSuggestion(requestMap);
    		
			requestMap.setString("msg","등록하였습니다.");
			
			//파일넘버값을 셋시킨다
			requestMap.setInt("fileGroupNo",fileGroupNo);
			
		}
	}
	
	@RequestMapping(value="/mypage/myclass.do", params="mode=suggestionExec")
	public String suggestionExec(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			, HttpSession session
			, HttpServletResponse response
			) throws Exception{
		
		DataMap requestMap = cm.getDataMap();
		
		if (requestMap.getString("grcode").length() > 0){
			session.setAttribute("sess_grcode", 		Util.getValue(requestMap.getString("grcode"), ""));
			session.setAttribute("sess_grseq", 		Util.getValue(requestMap.getString("grseq"), ""));
		} else {
			requestMap.setString("grcode",(String)session.getAttribute("sess_grcode"));
			requestMap.setString("grseq",(String)session.getAttribute("sess_grseq"));
		}

		if (requestMap.getString("grcode").length() > 0){
			suggestionExec(requestMap, cm.getLoginInfo());
		}
		
		return findView(cm, requestMap.getString("mode"), "/homepage/mypage/myclass/suggestionExec");
	}
	
	@RequestMapping(value="/mypage/myclass.do", params="mode=attendPopup")
	public String attendPopup(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			, HttpSession session
			, HttpServletResponse response
			) throws Exception{
		
		DataMap requestMap = cm.getDataMap();
		
		attendPopup(model, requestMap);
		
		return findView(cm, requestMap.getString("mode"), "/homepage/mypage/myclass/attendPopup");
	}
	
	@RequestMapping(value="/mypage/myclass.do", params="mode=applyInfo")
	public String applyInfo(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			, HttpSession session
			, HttpServletResponse response
			) throws Exception{
		
		DataMap requestMap = cm.getDataMap();
		
		applyInfo(cm.getLoginInfo(), requestMap);
		
		return findView(cm, requestMap.getString("mode"), "/homepage/mypage/myclass/attendForm");
	}
	
	@RequestMapping(value="/mypage/myclass.do", params="mode=cancelAttend")
	public String cancelAttend(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			, HttpSession session
			, HttpServletResponse response
			) throws Exception{
		
		DataMap requestMap = cm.getDataMap();
		
		String Msg = myClassService.applyCancel(requestMap);
		requestMap.setString("Msg",Msg);
		
		return findView(cm, requestMap.getString("mode"), "/homepage/mypage/myclass/attendCancel");
	}
	
	@RequestMapping(value="/homepage/attend.do", params="mode=cancelAttend")
	public String cancelAttend2(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			, HttpSession session
			, HttpServletResponse response
			) throws Exception{
		
		cancelAttend(cm, model, session, response);
		
		return findView(cm, cm.getDataMap().getString("mode"), "/homepage/attend/attendCancel");
	}
	
	@RequestMapping(value="/mypage/myclass.do", params="mode=personalnotice")
	public String personalnotice(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			, HttpSession session
			) throws Exception{
		
		DataMap requestMap = cm.getDataMap();
		
		requestMap.setString("userno",(String)session.getAttribute("sess_no"));		
		requestMap.setString("class",(String)session.getAttribute("sess_class"));		
		
		model.addAttribute("USER_NOTICE_LIST", myClassService.getUserNoticeList(requestMap));
		
		return findView(cm, requestMap.getString("mode"), "/homepage/mypage/myclass/personalnotice");
	}
	
	@RequestMapping(value="/mypage/myclass.do", params="mode=personalnoticeview")
	public String personalnoticeview(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			, HttpSession session
			, @RequestParam(value="seq", required=false, defaultValue="") String seq
			, @RequestParam(value="gubun", required=false, defaultValue="") String gubun
			) throws Exception{
		
		DataMap requestMap = cm.getDataMap();
		
		requestMap.setString("seq",seq);
		
		if(gubun.equals("P")){				
			requestMap.setString("gubun",(String)session.getAttribute("sess_no"));
		}else {
			requestMap.setString("gubun",(String)session.getAttribute("sess_class"));
		}
				
		model.addAttribute("USER_NOTICE_VIEW", myClassService.getUserNoticeView(requestMap));			
		
		return findView(cm, requestMap.getString("mode"), "/homepage/mypage/myclass/personalnoticeview");
	}
	
	@RequestMapping(value="/mypage/myclass.do", params="mode=myquestionview")
	public String myquestionview(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			, HttpSession session
			, @RequestParam(value="grcode", required=false, defaultValue="") String grcode
			, @RequestParam(value="grseq", required=false, defaultValue="") String grseq
			, @RequestParam(value="subj", required=false, defaultValue="") String subj
			, @RequestParam(value="classno", required=false, defaultValue="") String classno
			, @RequestParam(value="no", required=false, defaultValue="") String no
			) throws Exception{
		
		DataMap requestMap = cm.getDataMap();
		
		requestMap.setString("grcode",grcode);
		requestMap.setString("grseq",grseq);
		requestMap.setString("subj",subj);
		requestMap.setString("classno",classno);
		requestMap.setString("no",no);
		model.addAttribute("MY_QUESTION_VIEW", myClassService.getMyQuestionView(requestMap));			
		
		return findView(cm, requestMap.getString("mode"), "/homepage/mypage/myclass/myquestionview");
	}
	
	//1
	@RequestMapping(value="/mypage/myclass.do", params="mode=ajaxMemberUpdate")
	public String ajaxMemberUpdate(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			) throws Exception{
		
		DataMap requestMap = cm.getDataMap();
		
		LoginInfo loginInfo = cm.getLoginInfo();	
		
		requestMap.setString("userno", loginInfo.getSessNo());
		int errorcode =  myClassService.ajaxMemberUpdate(requestMap);
		if(cm.getMap().get("ssocompany") != null && !cm.getMap().get("ssocompany").equals("")){
			Map<String, Object> map = cm.getMap();
			map.put("userno", loginInfo.getSessNo());
			indexService.insertSSOAgree(map);
		}
		String errormsg = "";
		if(errorcode > -1) {
			errormsg = "1";
		}

		model.addAttribute("result", errormsg);
		
		return findView(cm, requestMap.getString("mode"), "/homepage/ajaxSearchId");
	}
	
	@RequestMapping(value="/mypage/myclass.do", params="mode=userdeletecheckajax")
	public String userdeletecheckajax(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			, @RequestParam(value="name", required=false, defaultValue="") String name
			, @RequestParam(value="ssn", required=false, defaultValue="") String ssn
			, @RequestParam(value="password", required=false, defaultValue="") String password
			) throws Exception{
		
		DataMap requestMap = cm.getDataMap();
		
		requestMap.setString("deleteusername",name);
		requestMap.setString("deletessn",ssn);
		requestMap.setString("deletepassword",password);
		
		model.addAttribute("DELETE_USER", myClassService.searchDeleteUser(requestMap));
		
		return findView(cm, requestMap.getString("mode"), "/homepage/mypage/myclass/userdeletecheckajax");
	}
	
	@RequestMapping(value="/mypage/myclass.do", params="mode=userdeletecheckajaxEmail")
	public String userdeletecheckajaxEmail(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			, @RequestParam(value="name", required=false, defaultValue="") String name
			, @RequestParam(value="email", required=false, defaultValue="") String email
			, @RequestParam(value="password", required=false, defaultValue="") String password
			) throws Exception{
		
		DataMap requestMap = cm.getDataMap();
		
		requestMap.setString("deleteusername",name);
		requestMap.setString("deleteEmail",email);
		requestMap.setString("deletepassword",password);
		
		model.addAttribute("DELETE_USER", myClassService.searchDeleteUserEmail(requestMap));
		
		return findView(cm, requestMap.getString("mode"), "/homepage/mypage/myclass/userdeletecheckajax");
	}
	
	@RequestMapping(value="/mypage/myclass.do", params="mode=testView")
	public String testView(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			, HttpSession session
			) throws Exception{
		
		DataMap requestMap = cm.getDataMap();
		
		if (requestMap.getString("grcode").length() > 0){
			session.setAttribute("sess_grcode", 		Util.getValue(requestMap.getString("grcode"), ""));
			session.setAttribute("sess_grseq", 		Util.getValue(requestMap.getString("grseq"), ""));
		} else {
			requestMap.setString("grcode",(String)session.getAttribute("sess_grcode"));
			requestMap.setString("grseq",(String)session.getAttribute("sess_grseq"));
		}
		
		// 과정기수 수료여부 확인
		
		DataMap resultData = myClassService.findGrade2(requestMap);
		resultData.setNullToInitialize(true);
		if (resultData.getString("closing",0).equals("Y")){
			requestMap.setString("display","E");
		} else {
			requestMap.setString("display","T");
		}

		requestMap.setString("subj", resultData.getString("subj",0));
		
		
		//과정기수 상세정보 가져오기
		DataMap grInfoMap = myClassService.selectGrInfo(requestMap); 
		
		Double progressscoAvg = myClassService.selectProgressscoAvg(requestMap); 	
		Double passSumNumber =  Double.valueOf("95.0"); //합격점수		
		
		if(progressscoAvg >= passSumNumber) {
			model.addAttribute("passYn", "Y");
		} else {
			model.addAttribute("passYn", "N");
		}
		
		// 시험 응시, 결과 가져오기
		String Msg = myClassService.selectTestValue(requestMap);
		
		requestMap.setString("Msg", Msg);
		model.addAttribute("GRINFO_DATA", grInfoMap);
		
		return findView(cm, requestMap.getString("mode"), "/homepage/mypage/myclass/scoreDetail");
	}
	
	@RequestMapping(value="/mypage/myclass.do", params="mode=subList")
	public String subList(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			, HttpSession session
			) throws Exception{
		
		DataMap requestMap = cm.getDataMap();
		
		//	초기화 옵션(true 일경우 데이터를 뽑을때 null 일경우 초기화 - 빈문자열, 0....)
		requestMap.setNullToInitialize(true);

		/*	코스 상세 데이터 가져오기
		* grcode, grseq 값을 가져와야함
		*/
		DataMap CDMap = myClassService.courseDetailView(requestMap);
		CDMap.setNullToInitialize(true);
		model.addAttribute("LIST_DETAIL", CDMap);
		
		return findView(cm, requestMap.getString("mode"), "/homepage/mypage/myclass/subList");
	}
	
	@RequestMapping(value="/mypage/myclass.do", params="mode=mainSubstring")
	public String mainSubstring(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			, HttpSession session
			) throws Exception{
		
		DataMap requestMap = cm.getDataMap();
		
		if (requestMap.getString("kind").equals("notice")){
			
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
				requestMap.setInt("rowSize", 10); 
			}
			// 페이지 블럭 갯수
			if (requestMap.getString("pageSize").equals("")){
				requestMap.setInt("pageSize", 10);
			}
			
			// 리스트 가져오기
			listMap = supportService.boardList("TB_BOARD_NOTICE", requestMap);
			model.addAttribute("LIST_DATA", listMap);
			
		} else {
			
			requestMap.setString("userno",(String)session.getAttribute("sess_no"));
			model.addAttribute("LIST_DATA", myClassService.getMyQuestionList(requestMap));
			
		}
		
		return findView(cm, requestMap.getString("mode"), "/homepage/mypage/myclass/subPage");
	}
	
	@RequestMapping(value="/mypage/myclass.do", params="mode=pollList")
	public String pollList(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			, HttpSession session
			) throws Exception{
		
		DataMap requestMap = cm.getDataMap();
		
		if (requestMap.getString("grcode").length() > 0){
			session.setAttribute("sess_grcode", 		Util.getValue(requestMap.getString("grcode"), ""));
			session.setAttribute("sess_grseq", 		Util.getValue(requestMap.getString("grseq"), ""));
		} else {
			requestMap.setString("grcode",(String)session.getAttribute("sess_grcode"));
			requestMap.setString("grseq",(String)session.getAttribute("sess_grseq"));
		}
		// 상세과정 보기
		DataMap resultData = myClassService.pollList(requestMap);
		
		model.addAttribute("LIST_DATA", resultData);
		
		return findView(cm, requestMap.getString("mode"), "/homepage/mypage/myclass/pollList");
	}
	
	// 결과 페이지 보여주기
	public void pollView(
			Model model
	        , DataMap requestMap) throws Exception {
		
		DataMap resultData = myClassService.pollView(requestMap);
				
		model.addAttribute("LIST_DATA", resultData);
	}
	
	@RequestMapping(value="/mypage/myclass.do", params="mode=pollView")
	public String pollView(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			, HttpSession session
			) throws Exception{
		
		DataMap requestMap = cm.getDataMap();
		
		if (requestMap.getString("grcode").length() > 0){
			session.setAttribute("sess_grcode", 		Util.getValue(requestMap.getString("grcode"), ""));
			session.setAttribute("sess_grseq", 		Util.getValue(requestMap.getString("grseq"), ""));
		} else {
			requestMap.setString("grcode",(String)session.getAttribute("sess_grcode"));
			requestMap.setString("grseq",(String)session.getAttribute("sess_grseq"));
		}
		// 상세과정 보기
		pollView(model, requestMap);
		
		return findView(cm, requestMap.getString("mode"), "/homepage/mypage/myclass/pollView");
	}
	
	// 결과 페이지 보여주기
	public void pollExec(
			Model model
	        , DataMap requestMap) throws Exception {
		
		String Msg = "등록되었습니다.";
		int num = 0;
		
		num = myClassService.pollExec(requestMap);
				
		model.addAttribute("Msg", Msg);
	}
	
	@RequestMapping(value="/mypage/myclass.do", params="mode=pollExec")
	public String pollExec(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			, HttpSession session
			) throws Exception{
		
		DataMap requestMap = cm.getDataMap();
		
		if (requestMap.getString("grcode").length() > 0){
			session.setAttribute("sess_grcode", 		Util.getValue(requestMap.getString("grcode"), ""));
			session.setAttribute("sess_grseq", 		Util.getValue(requestMap.getString("grseq"), ""));
		} else {
			requestMap.setString("grcode",(String)session.getAttribute("sess_grcode"));
			requestMap.setString("grseq",(String)session.getAttribute("sess_grseq"));
		}
		// 상세과정 보기
		pollExec(model, requestMap);
		
		return findView(cm, requestMap.getString("mode"), "/homepage/mypage/myclass/pollExec");
	}
	
	@RequestMapping(value="/mypage/myclass.do", params="mode=pollDetail")
	public String pollDetail(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			, HttpSession session
			) throws Exception{
		
		DataMap requestMap = cm.getDataMap();
		
		if (requestMap.getString("grcode").length() > 0){
			session.setAttribute("sess_grcode", 		Util.getValue(requestMap.getString("grcode"), ""));
			session.setAttribute("sess_grseq", 		Util.getValue(requestMap.getString("grseq"), ""));
		} else {
			requestMap.setString("grcode",(String)session.getAttribute("sess_grcode"));
			requestMap.setString("grseq",(String)session.getAttribute("sess_grseq"));
		}
		// 상세과정 보기
		pollView(model, requestMap);
		
		return findView(cm, requestMap.getString("mode"), "/homepage/mypage/myclass/pollDetail");
	}
	
	/**
	 * 설문 주관식 답변 리스트
	 */
	public void getGriqAnswerList(
			Model model
	          , DataMap requestMap) throws Exception {
	
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
		
		DataMap listMap = myClassService.getGriqAnswerList(requestMap); 
		
		model.addAttribute("LIST_DATA", listMap);

	}
	
	@RequestMapping(value="/mypage/myclass.do", params="mode=juView")
	public String juView(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			, HttpSession session
			) throws Exception{
		
		DataMap requestMap = cm.getDataMap();
		
		if (requestMap.getString("grcode").length() > 0){
			session.setAttribute("sess_grcode", 		Util.getValue(requestMap.getString("grcode"), ""));
			session.setAttribute("sess_grseq", 		Util.getValue(requestMap.getString("grseq"), ""));
		} else {
			requestMap.setString("grcode",(String)session.getAttribute("sess_grcode"));
			requestMap.setString("grseq",(String)session.getAttribute("sess_grseq"));
		}
		getGriqAnswerList(model, requestMap);
		
		return findView(cm, requestMap.getString("mode"), "/homepage/mypage/myclass/pollJuView");
	}
	
	@RequestMapping(value="/mypage/myclass.do", params="mode=lcmsprocess")
	public String lcmsprocess(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			, HttpSession session
			) throws Exception{
		
		DataMap requestMap = cm.getDataMap();
		
		return findView(cm, requestMap.getString("mode"), "/homepage/mypage/myclass/lcmspopup/lcmsprocess");
	}

	@RequestMapping(value="/mypage/myclass.do", params="mode=lcmsnotice")
	public String lcmsnotice(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			, HttpSession session
			, @RequestParam(value="grcode", required=false) String grcode
			, @RequestParam(value="grseq", required=false) String grseq
			) throws Exception{
		
		DataMap requestMap = cm.getDataMap();
		
		session.setAttribute("sess_grcode", grcode);
		session.setAttribute("sess_grseq", 	grseq);
		selectGrnoticeList(model, requestMap);		
		
		return findView(cm, requestMap.getString("mode"), "/homepage/mypage/myclass/lcmspopup/lcmsnotice");
	}
	
	@RequestMapping(value="/mypage/myclass.do", params="mode=lcmsdic")
	public String lcmsdic(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			, HttpSession session
			) throws Exception{
		
		DataMap requestMap = cm.getDataMap();
		
		return findView(cm, requestMap.getString("mode"), "redirect:/baseCodeMgr/dic.do?mode=dicView");
	}
	
	@RequestMapping(value="/mypage/myclass.do", params="mode=lcmsqna")
	public String lcmsqna(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			, HttpSession session
			) throws Exception{
		
		DataMap requestMap = cm.getDataMap();
		
		return findView(cm, requestMap.getString("mode"), "/homepage/mypage/myclass/lcmspopup/lcmsqna");
	}
	
	public void reExamTest(
			Model model
	        , DataMap requestMap) throws Exception {
		
		int iNum = 0;
		
		iNum = myClassService.reExamTest(requestMap.getString("idExam"), requestMap.getString("userno"));
				
		model.addAttribute("proc", iNum);
		
	}
	
	@RequestMapping(value="/mypage/myclass.do", params="mode=reExamTest")
	public String reExamTest(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			, HttpSession session
			) throws Exception{
		
		DataMap requestMap = cm.getDataMap();
		
		if (requestMap.getString("grcode").length() > 0){
			session.setAttribute("sess_grcode", 		Util.getValue(requestMap.getString("grcode"), ""));
			session.setAttribute("sess_grseq", 		Util.getValue(requestMap.getString("grseq"), ""));
		} else {
			requestMap.setString("grcode",(String)session.getAttribute("sess_grcode"));
			requestMap.setString("grseq",(String)session.getAttribute("sess_grseq"));
		}
		
		reExamTest(model, requestMap);
		
		return findView(cm, requestMap.getString("mode"), "/homepage/mypage/myclass/reExamTest");
	}
	
	/**
	 * 수료증 출력
	 */
	@RequestMapping(value="/mypage/certiResult.do", params = "mode=certi_html")
	public String certi_html(@ModelAttribute("cm") CommonMap cm, Model model) throws BizException {
		DataMap requestMap = cm.getDataMap();
		requestMap.setNullToInitialize(true);
		
		//리스트
		DataMap listMap = certiResultService.selectGrResultByResultDocList(requestMap);

		DataMap resultDocMap = resultHtmlService.selectResultDocRow(0);
		
		model.addAttribute("LIST_DATA", listMap);
		model.addAttribute("RESULTDOC_ROW_DATA", resultDocMap);
		
		return "/courseMgr/certiResult/certificateHtml";
	}
	
	
	@RequestMapping(value="/mypage/myclass.do", params="mode=ajaxGetLimit")
	public String ajaxGetLimit(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			) throws Exception{
		
		DataMap requestMap = cm.getDataMap();	
		
		return findView(cm, cm.getDataMap().getString("mode"), "/homepage/mypage/myclass/ajaxGetGrseq");
	}
	
	
}
