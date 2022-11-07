package loti.member.web;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import loti.baseCodeMgr.service.DeptService;
import loti.member.service.MemberService;

import org.apache.bcel.generic.FNEG;
import org.hsqldb.lib.HashMap;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import ut.lib.exception.BizException;
import ut.lib.login.LoginCheck;
import ut.lib.login.LoginInfo;
import ut.lib.support.CommonMap;
import ut.lib.support.DataMap;
import ut.lib.support.RequestUtil;
import ut.lib.util.DateUtil;
import ut.lib.util.StringReplace;
import common.controller.BaseController;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Controller
public class MemberController extends BaseController{
	
	@Autowired
	private MemberService memberService;
	
	@Autowired
	private DeptService deptService;
	
	@ModelAttribute("cm")	
	public CommonMap common(CommonMap commonMap, HttpServletRequest request	, HttpServletResponse response) throws Exception{
		
		
		
		//요청처리 - get, post 방식의 파라미터를 DataMap 에 저장
		DataMap requestMap = commonMap.getDataMap();
		//초기화 옵션(true 일경우 데이터를 뽑을때 null 일경우 초기화 - 빈문자열, 0....)
		requestMap.setNullToInitialize(true);
		
		//default mode
		if(requestMap.getString("mode").equals(""))
			requestMap.setString("mode", "list");
		
		if(requestMap.getString("mode").equals("ajaxCreateId2")) {
	
			requestMap.setString("mode", "ajaxCreateId");		
		}else{
			//관리자 로그인 체크. (관리자 페이지에는 모두 있어야 함)
			LoginInfo memberInfo = LoginCheck.adminCheck(request, response, requestMap.getString("menuId"));
			
			if (memberInfo == null) return null;
		}
		
		//리퀘스트 정보를 담고있는 DataMap을 Attribute 에 추가
		request.setAttribute("REQUEST_DATA", requestMap);
	
		return commonMap;
	}
	
	public String findView(String mode, String defaultView){
		
		
		return defaultView;
	}
	

	@RequestMapping(value="/member/member.do")
	public String defaultProcess(@ModelAttribute("cm") CommonMap cm, Model model) throws Exception{
		return list(cm, model);
	}
		
	@RequestMapping(value="/member/member.do", params="mode=ajaxCreateId2", method=RequestMethod.GET)
	public String ajaxCreateId2Get( Model model) throws BizException{
		model.addAttribute("result", -2);
		return "/member/ajaxCreateId";
	}
	
	@RequestMapping(value="/member/member.do", params="mode=ajaxCreateId2", method=RequestMethod.POST)
	public String ajaxCreateId2Post( Model model, @ModelAttribute("cm") CommonMap commonMap) throws Exception{
		
		DataMap requestMap = commonMap.getDataMap();
		
		int error = -1;
		error = memberService.ajaxCreateId2(requestMap);
		model.addAttribute("result", error);
		return "/member/ajaxCreateId";
		
	    
		
	}
	
	/** 
	 * 계정관리 리스트
	 * 작성일 5월 21일
	 * 작성자 정윤철	
	 */
	@RequestMapping(value="/member/member.do", params="mode=list")	
	public String list(@ModelAttribute("cm") CommonMap commonMap , Model model) throws Exception {
		
		DataMap listMap = null;
		DataMap searchMenberMap = null;		
		DataMap requestMap = commonMap.getDataMap(); 
		
		
		requestMap.setString("memberSearch", "1");
		
		if (requestMap.getString("currPage").equals(""))	requestMap.setInt("currPage", 1); //페이지

		if (requestMap.getString("rowSize").equals(""))		requestMap.setInt("rowSize", 15); //페이지당 보여줄 갯수
		
		if (requestMap.getString("pageSize").equals("")) 	requestMap.setInt("pageSize", 10); //페이지 블럭 갯수
		
		String auth = requestMap.getString("auth");	
		if(auth.equals("5")){
			//계정관리 강사회원 기준
			listMap = memberService.selectMemberListAuth5(requestMap);
		}else if(auth.equals("") || auth.equals("10")){
			//계정관리 일반 학적부 기준
			listMap = memberService.selectMemberListAuth(requestMap);
			//검색회원수를 구하기 위해서 임시값을 저장한다.			
		}
		
		//기관선택명 가져오기
		DataMap selectBoxMap = memberService.selectDeptList();
		
		
		//전체 멤버수 가져오기
		DataMap selectTotalMemberRow = memberService.selectTotalMemberRow();
		
		
		//ID발급회원수 구해오기 
		DataMap selectIdRow = memberService.selectIdRow();
		
		
		
		
		model.addAttribute("REQUEST_DATA", requestMap);
		model.addAttribute("LIST_DATA", listMap);
		model.addAttribute("TOTALMEMBER_DATA", selectTotalMemberRow);
		model.addAttribute("IDCOUNT_DATA", selectIdRow);
		model.addAttribute("SELECTBOX_DATA", selectBoxMap);
		model.addAttribute("MEMBERCOUNT_DATA", searchMenberMap);
		
		return findView(requestMap.getString("mode"), "/member/memberList");
	}
	
	/** 
	 * 멤버정보 가져오기
	 * 작성일 5월 21일
	 * 작성자 정윤철
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @param requestMap
	 * @throws Exception
	 */
	@RequestMapping(value="/member/member.do", params="mode=form")	
	public String form(@ModelAttribute("cm") CommonMap commonMap, Model model) throws Exception {
		
		DataMap requestMap = commonMap.getDataMap();		
		DataMap deptListMap = null;
		/*****************************[s]멤버 정보 ROW ***************************/
		DataMap rowMap = memberService.selectMemberInfoRow(requestMap.getString("userNo"));
		
		//가져온 사용자 데이터 중 사무실 전화번호, 집 전화번호, 핸드폰 번호를 3등분한다.
		try{
			//집전화번호 전화번호 
			String[] hp = rowMap.getString("homeTel").split("-");
			for(int i = 0; i < hp.length; i++){ 
				rowMap.setString("homeTel"+(i+1), hp[i]);
			}
		}catch (Exception e) {}
		
		try{
			//사무실 전화번호 
			String[] hp = rowMap.get("officeTel").toString().split("-");
			for(int i = 0; i < hp.length; i++){ 
				rowMap.setString("officeTel"+(i+1), hp[i]);
			}
		}catch (Exception e) {}
		
		try{
			//핸드폰 전화번호 
			String[] hp = rowMap.getString("hp").split("-");
			for(int i = 0; i < hp.length; i++){ 
				rowMap.setString("hp"+(i+1), hp[i]);
			}
			
		}catch (Exception e) {
			rowMap.setString("hp","");
		}
		
		/*****************************[e]멤버 정보 ROW ***************************/
		
		
		/*****************************[s]기관 코드 LIST ***************************/
		
		deptListMap = deptService.selectDeptCodeList(requestMap);
		if(deptListMap.size() <= 0){
			deptListMap = null;
		}
		//if(deptListMap.keySize("dept") <= 0){
		//	deptListMap = new DataMap();
		//}

		/*****************************[e]기관 코드 LIST ***************************/
		
		model.addAttribute("DEPTLIST_DATA", deptListMap);
		model.addAttribute("ROW_DATA", rowMap);
		
		return findView(requestMap.getString("mode"), "/member/memberForm");
	}
	
	//부서명, 부서코드 리스트 AJAX
	@RequestMapping(value="/member/member.do", params="mode=ajaxPartCode")	
	public String ajaxPartCode(@ModelAttribute("cm") CommonMap commonMap, Model mode	) throws Exception {
		
		DataMap requestMap = commonMap.getDataMap(); 
		DataMap listMap = new DataMap();
		
		if("6289999".equals(requestMap.getString("dept"))) {
			listMap = memberService.selectLdapCodeList(requestMap.getString("dept"));
		} else {
			listMap = memberService.selectPartCodeList(requestMap.getString("dept"));
		}
		
		mode.addAttribute("LIST_DATA", listMap);
		
		return findView(requestMap.getString("mode"), "/member/ajaxPartCode");
	}
	
	
	
	/**
	 * 사용자 정보 수정
	 * 작성일 : 5월 29일
	 * 작성자 : 정 윤철
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @param requestMap
	 * @throws Exception
	 */
	@RequestMapping(value="/member/member.do", params="mode=exec")	
	public String exec(@ModelAttribute("cm") CommonMap commonMap, Model model) throws Exception {
			
		DataMap requestMap = commonMap.getDataMap();	
		
		
		int returnvalue = 0;
		//3개로 분리되어있던 사무실 전화번호 합치기
		
		requestMap.setString("officeTel", 
				requestMap.getString("officeTel1") + "-" + 
				requestMap.getString("officeTel2") + "-" +
				requestMap.getString("officeTel3"));
		
		//3개로 분리되어있던 사무실 전화번호 합치기
		String homeTel1 = requestMap.getString("homeTel1");
		String homeTel2 = requestMap.getString("homeTel2");
		String homeTel3 = requestMap.getString("homeTel3");
		
		requestMap.setString("homeTel",homeTel1+"-"+homeTel2+"-"+homeTel3);
		
		//3개로 분리되어있던 사무실 전화번호 합치기
		String hp1 = requestMap.getString("hp1");
		String hp2 = requestMap.getString("hp2");
		String hp3 = requestMap.getString("hp3");
		
		String ldapcode = requestMap.getString("partcd");
		String ldapname = requestMap.getString("partnm");
		requestMap.setString("ldapcode", ldapcode);
		requestMap.setString("ldapname", ldapname);
		
		requestMap.setString("hp",hp1+"-"+hp2+"-"+hp3);
		requestMap.setString("newHomePost", requestMap.getString("newHomePost"));
		requestMap.setString("newAddr1", requestMap.getString("newAddr1"));
		requestMap.setString("newAddr2", requestMap.getString("newAddr2"));
		if (requestMap.getString("userId").length() > 4){
			
			if(!requestMap.getString("userId").equals(requestMap.getString("checkUserId"))) {
				int errorcode = memberService.memberCheckID(requestMap.getString("userId"));
				if(errorcode > 0){
					requestMap.setString("msg","ID가 중복됩니다.");
					
					return findView(requestMap.getString("mode"), "/member/memberMsg");
				}
			}
		}

		returnvalue = memberService.modifyMember(requestMap);
		
		if(returnvalue > 0){
			requestMap.setString("msg","수정하였습니다.");
		}else{
			requestMap.setString("msg","수정에 실패하였습니다.");
		}
		
		return findView(requestMap.getString("mode"), "/member/memberMsg");
	}
	
	
	
	/**
	 * 학적부관리 기관별 리스트
	 * 작성일 5월 30일 
	 * 작성자 정윤철
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @param requestMap
	 * @throws Exception
	 */
	@RequestMapping(value="/member/member.do", params="mode=studyDocList")	
	public String selectStudyDocList(@ModelAttribute("cm") CommonMap commonMap, Model model, HttpServletRequest request	) throws Exception {
		
	
		DataMap requestMap = commonMap.getDataMap();		
		DataMap listMap = null;
		
		//사용자 정보 추출.
		LoginInfo loginInfo = (LoginInfo)request.getAttribute("LOGIN_INFO");
		
		//기관코드
		String dept = loginInfo.getSessDept();
		//부서코드
		String partcd = loginInfo.getSessPartcd();
		
		String sessClass = loginInfo.getSessClass();
		
		//사용자의 기관코드값
		requestMap.setString("dept",dept);
		
		//사용자의 부서코드값
		requestMap.setString("partcd",partcd);
		
		//사용자의 권한값
		requestMap.setString("sessClass",sessClass);
		
		//기관코드, 기관코드명 셀렉박스 선언
		DataMap selectBoxMap = null;
		
		if(sessClass.equals("3") || sessClass.equals("C")){
			//권한이 부서담당자, 기관담당자일 경우 기간코드 리스트 메소드를 사용안한다.
			 selectBoxMap =  new DataMap();
			
		}else{
			//기관선택명 가져오기
			selectBoxMap = memberService.selectDeptList();
			
		}
		
		if(requestMap.getString("nowDate").equals("")){
	        //구해진 날짜 값을 셋시킨다. 
			requestMap.setString("nowDate", DateUtil.getDateTime());
			
		}
		
		
		if(requestMap.getString("qu").equals("")){
			//처음 페이지 일때 null처리
			listMap = new DataMap();
			
			
		}else if(requestMap.getString("qu").equals("deptList")){
			HttpSession session = request.getSession(); //세션
			String sess_ldapcode = (String)session.getAttribute("sess_ldapcode");
			requestMap.setString("sess_ldapcode", sess_ldapcode);
			//날짜의 조회버튼을 클릭시 타는 메소드
			listMap = memberService.selectStdyDocDeptList(requestMap);
			
			if(listMap.keySize("rname")<= 0){
				listMap = new DataMap();
			}else if(listMap.keySize("rname") >  0){
				
				for(int i=0; i < listMap.keySize("rname");i++){
					
					String resno = "";
					try{
						resno = listMap.getString("rresno").substring(0,6)+"-XXXXXXX";
					}catch(Exception e){
						resno = "";
					}
					
					listMap.addString("rresno", resno);
					
				}
				
			}
			
		}
		model.addAttribute("LIST_DATA", listMap);
		model.addAttribute("DEPT_LIST_DATA", selectBoxMap);
		
		return findView(requestMap.getString("mode"), "/member/studyDocList");
	}
		
	/**
	 * 학적부관리 기관별 리스트 excel 출력하기
	 * 작성일 2010년 10월 15일 
	 * 작성자 woni82
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @param requestMap
	 * @throws Exception
	 */
	@RequestMapping(value="/member/member.do", params="mode=studyDocListExcel")	
	public String studyDocListExcel(HttpServletRequest request, 
			HttpServletResponse response, @ModelAttribute("cm") CommonMap commonMap, Model model) throws Exception {
		
		DataMap requestMap = commonMap.getDataMap();
				
		DataMap listMap = null;
		
		/*//사용자 정보 추출.
		LoginInfo loginInfo = (LoginInfo)request.getAttribute("LOGIN_INFO");
		//기관코드
		String dept = loginInfo.getSessDept();
		//부서코드
		String partcd = loginInfo.getSessPartcd();
		String sessClass = loginInfo.getSessClass();
		
		//사용자의 기관코드값
		requestMap.setString("dept",dept);
		//사용자의 부서코드값
		requestMap.setString("partcd",partcd);
		//사용자의 권한값
		requestMap.setString("sessClass",sessClass);
		
		//기관코드, 기관코드명 셀렉박스 선언
		DataMap selectBoxMap = null;
		if(sessClass.equals("3") || sessClass.equals("C")){
			//권한이 부서담당자, 기관담당자일 경우 기간코드 리스트 메소드를 사용안한다.
			selectBoxMap = new DataMap();	
		}else{
			//기관선택명 가져오기
			selectBoxMap = service.selectDeptList();
		}
		
		if(requestMap.getString("nowDate").equals("")){
	        //구해진 날짜 값을 셋시킨다. 
			requestMap.setString("nowDate", DateUtil.getDateTime());
		}*/
		
		/*if(requestMap.getString("qu").equals("")){*/
			//처음 페이지 일때 null처리
			listMap = new DataMap();
		/*}else if(requestMap.getString("qu").equals("deptList")){	*/
			
			//System.out.println("================== requestMap.getString(rname) :"+);
			HttpSession session = request.getSession(); //세션
			String sess_ldapcode = (String)session.getAttribute("sess_ldapcode");
			requestMap.setString("sess_ldapcode", sess_ldapcode);
			//사용자 정보 추출.
			LoginInfo loginInfo = (LoginInfo)request.getAttribute("LOGIN_INFO");
			
			
			//기관코드
			String dept = loginInfo.getSessDept();
			
			//날짜의 조회버튼을 클릭시 타는 메소드
			listMap = memberService.selectStdyDocDeptList(requestMap);
			if(listMap.keySize("rname")<= 0){
				listMap = new DataMap();
			}else if(listMap.keySize("rname") >  0){
				
				for(int i=0; i < listMap.keySize("rname");i++){
					
					String resno = "";
					try{
						resno = listMap.getString("rresno").substring(0,6)+"-XXXXXXX";
					}catch(Exception e){
						resno = "";
					}			
					listMap.addString("rresno", resno);	
				}
			}
		/*}*/
		model.addAttribute("LIST_DATA", listMap);
		//request.setAttribute("DEPT_LIST_DATA", selectBoxMap);
		
		return findView(requestMap.getString("mode"), "/member/studyDocListExcel");
	}

	/**
	 * 개인별 학적부 자료 수정폼
	 * 작성자 : 정 윤철
	 * 작성일 : 6월 02일
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @param requestMap
	 * @throws Exception
	 */
	@RequestMapping(value="/member/member.do", params="mode=schoolRegForm")	
	public String selectSchoolRegRow(		
			HttpServletRequest request, 
			HttpServletResponse response, 
			@ModelAttribute("cm") CommonMap commonMap,
			Model model
			) throws Exception {
		
		DataMap requestMap = commonMap.getDataMap();
		DataMap rowMap = null;		
		
        
		String userno = requestMap.getString("userno");
		String linkGrseq = requestMap.getString("grseq");
		String grcode = requestMap.getString("grcode");
		
		//학력조회
		DataMap selectEducational  = memberService.selectEducationalRow();
		
		//개인별 학적부 자료 ROW[s]
		rowMap = memberService.selectSchoolRegRow(userno, linkGrseq, grcode);
		if(rowMap == null)
			rowMap = new DataMap();
		rowMap.setNullToInitialize(true);
		
		//기관명 기관코드 데이터
		DataMap selectStdyDocDeptList = memberService.selectDeptList();
		
		if(!requestMap.getString("grseq").equals("")){
			//과정기수
			rowMap.setString("a_grseq", rowMap.getString("grseq").substring(0,4));
			//과정년도
			rowMap.setString("b_grseq", rowMap.getString("grseq").substring(4,6));
			
		}
		
		for (int i = 0; i < rowMap.keySize("rresno"); i++)
		
		model.addAttribute("LIST_DATA", rowMap);
		model.addAttribute("EDUCATIONLLIST_DATA", selectEducational);
		model.addAttribute("DEPTLIST_DATA", selectStdyDocDeptList);
		
	
		
		return findView(requestMap.getString("mode"), "/member/studyDocPop");
	}
	
	
	
	/**
	 * 개인별 학적부 자료 수정실행
	 * 작성자 : 정 윤철
	 * 작성일 : 6월 02일
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @param requestMap
	 * @throws Exception
	 */
	@RequestMapping(value="/member/member.do", params="mode=modifyStudyExec")	
	public String modifyStudyExec(			
			HttpServletRequest request, 
			HttpServletResponse response, 
			@ModelAttribute("cm") CommonMap commonMap ) throws Exception {
		
		DataMap requestMap = commonMap.getDataMap();
		
		//부서명에 특수 문자가 들어가지 못하게 한다. 
        if(!requestMap.getString("rdeptsub").equals("")){
        	String rdeptsub = StringReplace.convertHtmlEncode(requestMap.getString("rdeptsub"));
        	requestMap.setString("rdeptsub", rdeptsub);
        }
        //확인자에 특수 문자가 들어가지 못하게 한다. 
        if(!requestMap.getString("confirmman").equals("")){
        	String confirmman = StringReplace.convertHtmlEncode(requestMap.getString("confirmman"));
        	requestMap.setString("confirmman", confirmman);
        }
        //작성자에 특수 문자가 들어가지 못하게 한다. 
        if(!requestMap.getString("grman").equals("")){
        	String grman = StringReplace.convertHtmlEncode(requestMap.getString("grman"));
        	requestMap.setString("grman", grman);
        }
        
		//수정 실행
		memberService.modifyStudyExec(requestMap);
		
		requestMap.setString("msg","수정하였습니다.");
		
		return findView(requestMap.getString("mode"), "/member/studyDocMsg");
	}
	
	
	/** 
	 * 특수권한, 특수권한자 리스트 
	 * 작성일 6월 04일
	 * 작성자 정윤철
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @param requestMap
	 * @throws Exception
	 */
	 
	@RequestMapping(value="/member/member.do", params="mode=adminList")	
	public String adminList(			
			HttpServletRequest request, 
			HttpServletResponse response, 
			@ModelAttribute("cm") CommonMap commonMap, 
			Model model) throws Exception {
		
		DataMap requestMap = commonMap.getDataMap();
		
		DataMap listMap = null;	
		
		if (requestMap.getString("currPage").equals(""))	requestMap.setInt("currPage", 1); //페이지

		if (requestMap.getString("rowSize").equals(""))		requestMap.setInt("rowSize", 15); //페이지당 보여줄 갯수
		
		if (requestMap.getString("pageSize").equals("")) 	requestMap.setInt("pageSize", 10); //페이지 블럭 갯수
		
		
		//특수권한 셀렉박스 데이터 가져오기
		DataMap selectBoxMap = memberService.selectGadminList();
		DataMap selectDeptCodeList = memberService.selectDeptList();
		
			
		
		//특수권한자 리스트 데이터 가져오기
		listMap = memberService.selectManagerList(requestMap);
		
		model.addAttribute("LIST_DATA", listMap);
		model.addAttribute("SELECTBOX_DATA", selectBoxMap);
		model.addAttribute("SELECTDEPT_DATA", selectDeptCodeList);
		model.addAttribute("SELDEPT", requestMap.getString("selDept"));
		
		return findView(requestMap.getString("mode"), "/member/memberAdminList");
	}
	
	
	/** 
	 * 특수권한자 인서트폼
	 * 작성일 6월 04일
	 * 작성자 정윤철
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @param requestMap
	 * @throws Exception
	 */
	@RequestMapping(value="/member/member.do", params="mode=adminForm")	 
	public String adminForm(		
			HttpServletRequest request, 
			HttpServletResponse response, 
			@ModelAttribute("cm") CommonMap commonMap) throws Exception {
		
		DataMap requestMap= commonMap.getDataMap();
		
		DataMap rowMap = null;
		DataMap gadminMap = null;
		//기관데이터 가져오기
		rowMap = memberService.selectDeptList();
		
		gadminMap = memberService.selectGadminRow();
		request.setAttribute("GADMIN_DATA", gadminMap);
		request.setAttribute("DEPT_DATA", rowMap);
		
		return findView(requestMap.getString("mode"), "/member/memberAdminForm");
	}

	
	/** 
	 * 특수권한자 이력조회
	 * 작성일 6월 04일
	 * 작성자 정윤철
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @param requestMap
	 * @throws Exception
	 */
	@RequestMapping(value="/member/member.do", params="mode=adminFormPop")	
	public String selectAdminHistoryList(			
			HttpServletRequest request, 
			HttpServletResponse response, 
			@ModelAttribute("cm") CommonMap commonMap,
			Model model) throws Exception {
		
		DataMap requestMap = commonMap.getDataMap();
		
		DataMap listMap = null;
		
		if (requestMap.getString("currPage").equals(""))	requestMap.setInt("currPage", 1); //페이지
		
		
		if (requestMap.getString("rowSize").equals(""))		requestMap.setInt("rowSize", 15); //페이지당 보여줄 갯수
		
		if (requestMap.getString("pageSize").equals("")) 	requestMap.setInt("pageSize", 10); //페이지 블럭 갯수
		
		
		
		
		
		//특수권한자 리스트 데이터 가져오기
		listMap = memberService.selectAdminHistoryList(requestMap);
		
		model.addAttribute("LIST_DATA", listMap);
		
		return findView(requestMap.getString("mode"), "/member/memberAdminHistoryPop");
	}
	
	
	/**
	 * 특수권한 인서트 시작
	 * 작성자 : 정 윤철
	 * 작성일 : 6월 04일
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @param requestMap
	 * @throws Exception
	 */	
	@RequestMapping(value="/member/member.do",params="mode=adminExec")
	public String adminExec(HttpServletRequest request, 
			HttpServletResponse response, 
			@ModelAttribute("cm") CommonMap commonMap,
			Model model) throws Exception{
			
			DataMap requestMap = commonMap.getDataMap();
		
			
			if(requestMap.getString("qu").equals("insertAdmin")){
				//등록  실행
				requestMap.setString("mode", "insertAdmin");
				insertAdminExec(request, response, requestMap, model);
				
				
			}else if(requestMap.getString("qu").equals("deleteAdmin")){
				//삭제 실행
				requestMap.setString("mode", "deleteAdmin");
				deleteAdmin(request, response, requestMap, model);
			}
			
			return findView(requestMap.getString("mode"), "/member/memberAdminMsg");
	}
	///////////////////////////////////////////////////////////////////////// 확인필요
	/**
	 * 특수권한 인서트 시작
	 * 작성자 : 정 윤철
	 * 작성일 : 6월 04일
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @param requestMap
	 * @throws Exception
	 */
	public String insertAdminExec(			
			HttpServletRequest request, 
			HttpServletResponse response, 
			DataMap requestMap,
			Model model) throws Exception {
				
		int returnValue = 0;
				
		//사용자 정보 추출.
		LoginInfo loginInfo = (LoginInfo)request.getAttribute("LOGIN_INFO");
		
		
		/*********************[s]인서트할 값들을 정의 한다.************************************/
		//세션넘버
		String sessNo = loginInfo.getSessNo();
		requestMap.setString("sessNo",sessNo);
		//유저넘버
		String userNo = requestMap.getString("userno");
		//부서코드
		String partcd = requestMap.getString("partcd");
		//기관코드
		String dept = requestMap.getString("dept");
		/*********************[e]인서트할 값들을 정의 한다.************************************/
		
		//권한중복체크 쿼리 현재는 유저 넘버만을 잡고 밑의 for문에서 체크한 권한들을 전부 and
		
		if(requestMap.keySize("gadmin") > 0){
			DataMap map = new DataMap();
			
			for(int i=0;requestMap.keySize("gadmin")>i;i++){
				map.put("userno",requestMap.getString("userno"));
				map.put("gadmin",requestMap.getString("gadmin",i));
						
				
				//권한중복체크 카운트 시작
				returnValue += memberService.selectGadminCount(map);
			}
		}
		
		//권한중복체크 카운트 시작
		//returnValue = service.selectGadminCount(where);

		if(returnValue > 0){
			requestMap.setString("msg","중복되는 권한이 있습니다. 확인 후 다시 입력해 주십시요.");
				
		}else{
			
			//등록 실행
			for(int i=0; requestMap.keySize("gadmin") > i; i++){
				String gadmin = requestMap.getString("gadmin",i);
				returnValue = memberService.insertAdminExec(requestMap);
				//returnValue = memberService.insertAdminExec(gadmin,sessNo,userNo,partcd,dept);
				
			}
			requestMap.setString("msg","등록하였습니다.");
		}
		
		return findView(requestMap.getString("mode"), "/member/memberAdminMsg");
	}
	
	
	
	/** 
	 * 특수권한자 -> 추가 -> 회원검색
	 * 작성일 6월 04일
	 * 작성자 정윤철
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @param requestMap
	 * @throws Exception
	 */
	@RequestMapping(value="/member/member.do", params="mode=memberSearchList")	
	public String memberSearchList(			
			HttpServletRequest request, 
			HttpServletResponse response, 
			@ModelAttribute("cm") CommonMap commonMap,
			Model model) throws Exception {
				
		DataMap requestMap = commonMap.getDataMap();
		DataMap listMap = null;	
		
		if(requestMap.getString("qu").equals("search")){
			//회원 리스트 [s]
			listMap = memberService.selectMemberSearchList(requestMap);
			//회원 리스트 [e]
		}else{
			listMap = new DataMap();
		}
		request.setAttribute("LIST_DATA", listMap);
		
		return findView(requestMap.getString("mode"), "/member/memberListFormPop");
	}
	
	/**
	 * 특수권환 삭제 
	 * 작성자 : 정 윤철
	 * 작성일 : 6월 04일
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @param requestMap
	 * @throws Exception
	 */
	@RequestMapping(value="/member/member.do", params="mode=deleteAdmin")	
	public void deleteAdmin(		
			HttpServletRequest request, 
			HttpServletResponse response, 
			DataMap requestMap,
			Model model) throws Exception {
		
		
		//사용자 정보 추출.
		LoginInfo loginInfo = (LoginInfo)request.getAttribute("LOGIN_INFO");
		
		int returnValue = 0;
		
		
		/*********************[s]딜리트 조건 값들을 정의 한다.************************************/
		//세션넘버
		String sessNo = loginInfo.getSessNo();
		requestMap.setString("sessNo", sessNo);
		//유저넘버
		String userNo = requestMap.getString("userno");
		//부서코드
		String partcd = requestMap.getString("partcd");
		//기관코드
		String dept = requestMap.getString("dept");
		//특수권환
		String gadmin = requestMap.getString("gadmin");
		/*********************[e]딜리트 조건 값들을 정의 한다.************************************/
		
		//특수권한 잔여여부 체크루틴 
		returnValue = memberService.selectGadminSaveCount(requestMap);
		//삭제
		memberService.deleteManager(requestMap);
		if(returnValue == 0 ){
			
			memberService.updateGadmin(userNo);
			
		}else{
			memberService.updateDisabledGadmin(requestMap);
		}
		
		memberService.insertGadminHistroy(requestMap);
		requestMap.setString("msg","삭제 하였습니다.");
	}
	
	
	
	/** 
	 * 학적부관리 수료현황 조회
	 * 작성일 6월 02일
	 * 작성자 정윤철
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @param requestMap
	 * @throws Exception
	 */
	@RequestMapping(value="/member/member.do", params="mode=studyCompletList")
	public String CompleteList(		
			HttpServletRequest request, 
			HttpServletResponse response, 
			@ModelAttribute("cm") CommonMap commonMap,
			Model model) throws Exception {
		
	   DataMap requestMap = commonMap.getDataMap();
		
		DataMap listMap = null;
		
		//studyDocList파일에 개인별 리스트와 기관별 리스트의 기능을 가지고있다. 그중 selectBoxMap의 맵을 기관별에서 사용을 하고있고 이 맵으로 인해 널포인트 익셉션이 발생하므로
		//널처리를 해준다.
		DataMap selectBoxMap = null;
		selectBoxMap = new DataMap();
		
		//사용자 정보 추출.
		LoginInfo loginInfo = (LoginInfo)request.getAttribute("LOGIN_INFO");
		
		
		String dept = loginInfo.getSessDept();
		String sessClass = loginInfo.getSessClass();
		requestMap.setString("dept", dept);
		requestMap.setString("sessClass", sessClass);
		
		
		
		String userno = requestMap.getString("userno");
		
		
		listMap = memberService.selectCompleteList(requestMap);
		
		requestMap.setString("resno",requestMap.getString("resno").substring(0,6)+"-XXXXXXX");
		model.addAttribute("LIST_DATA", listMap);
		model.addAttribute("SELECTBOX_DATA", selectBoxMap);
		
		return findView(requestMap.getString("mode"), "/member/studyCompletList");
	}
	
	/** 
	 * 학적부관리 수료현황 조회
	 * 작성일 6월 02일
	 * 작성자 정윤철
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @param requestMap
	 * @throws Exception
	 */
	@RequestMapping(value="/member/member.do", params="mode=studySchoolRegList")
	public String SchoolRegList(			
			HttpServletRequest request, 
			HttpServletResponse response, 
			@ModelAttribute("cm") CommonMap commonMap) throws Exception {
		
		DataMap requestMap = commonMap.getDataMap();
		DataMap listMap = null;
		
		//studyDocList파일에 개인별 리스트와 기관별 리스트의 기능을 가지고있다. 그중 selectBoxMap의 맵을 기관별에서 사용을 하고있고 이 맵으로 인해 널포인트 익셉션이 발생하므로
		//널처리를 해준다.
		DataMap selectBoxMap = null;
		selectBoxMap = new DataMap();
		
		//사용자 정보 추출.
		LoginInfo loginInfo = (LoginInfo)request.getAttribute("LOGIN_INFO");
		
		
		String dept = loginInfo.getSessDept();
		String sessClass = loginInfo.getSessClass();
		requestMap.setString("dept", dept);
		requestMap.setString("sessClass", sessClass);
		String where  = "";
	
		
		String userno = requestMap.getString("userno");
		//학력조회
		DataMap selectEducational  = memberService.selectEducationalRow();
		
		//학적조회리스트 시작
		listMap = memberService.selectSchoolRegList(requestMap);
		
		//해당 학력정보를 넣는다.
		if(listMap.keySize("rschool") > 0){
			for(int i=0;listMap.keySize("rschool")> i;i++ ){
				
				for(int j = 0; selectEducational.keySize("gubun") > j ; j++){
					if(listMap.getString("rschool",i).equals(selectEducational.getString("gubun",j))){
						listMap.addString("gubunnm",selectEducational.getString("gubunnm",j));
					}
				}
				
			}
		}
		//현재 권한을 리퀘스트멥에 저장한다. 사용이유는 jsp페이지에서 권한에 따라서 보여주는 항목이 있기때문이다.
		requestMap.setString("sessClass",sessClass); 
		
		for(int i = 0; listMap.keySize("grseq") > i ; i++){
			//기별정보 기존의 자료 가지고 있어야한다. 밑의 기별정보 정의는 리스트를 위해서 만든 것이고 현재 만드는것은 사용자 정보를 수정하기위한
			//매게 변수로 쓰기위해서 정의한다.
			listMap.addString("linkGrseq",listMap.getString("grseq",i));
		}
		
		for(int i = 0; listMap.keySize("grseq") > i ; i++){
			//기별 정보 재정의
			//예 1999년 1기
			listMap.addString("rgrseq", listMap.getString("grseq",i).substring(0,4)+"년 " +listMap.getString("grseq",i).substring(4,6)+"기");
		}

		//주민등록번호 끝에 7자리 x로 표시
		requestMap.setString("resno",requestMap.getString("resno").substring(0,6)+"-XXXXXXX");

		request.setAttribute("LIST_DATA", listMap);
		request.setAttribute("SELECTBOX_DATA", selectBoxMap);
		
		return findView(requestMap.getString("mode"), "/member/studySchoolRegList");
	
	}
		
		
		
		/** 
		 * 학적부관리 개인별 리스트
		 * 작성일 5월 30일
		 * 작성자 정윤철
		 * @param mapping
		 * @param form
		 * @param request
		 * @param response
		 * @param requestMap
		 * @throws Exception
		 */
	   @RequestMapping(value="/member/member.do", params="mode=studyPersonList")
		public String studyPersonList(				
				HttpServletRequest request, 
				HttpServletResponse response, 
				@ModelAttribute("cm") CommonMap commonMap) throws Exception {
			
			DataMap requestMap = commonMap.getDataMap();
			
			DataMap listMap = null;
			
			//studyDocList파일에 개인별 리스트와 기관별 리스트의 기능을 가지고있다. 그중 selectBoxMap의 맵을 기관별에서 사용을 하고있고 이 맵으로 인해 널포인트 익셉션이 발생하므로
			//널처리를 해준다.
			DataMap selectBoxMap = null;
			selectBoxMap = new DataMap();
			
			//사용자 정보 추출.
			LoginInfo loginInfo = (LoginInfo)request.getAttribute("LOGIN_INFO");
			
			
			String dept = loginInfo.getSessDept();
			String sessClass = loginInfo.getSessClass();
			
			HttpSession session = request.getSession(); //세션
			String sess_ldapcode = (String)session.getAttribute("sess_ldapcode");
			//사용자명 검색값 정의
			requestMap.setString("dept", dept);
			requestMap.setString("sessClass", sessClass);
			requestMap.setString("sess_ldapcode", sess_ldapcode);
			requestMap.setString("sess_dept", loginInfo.getSessDept());
			
			if(!requestMap.getString("name").equals("")){
							    
				listMap = memberService.selectstudyPersonList(requestMap);
				requestMap.setString("process","1");
			}else{
				listMap = new DataMap();
			}
			
			
			
			request.setAttribute("LIST_DATA", listMap);
			request.setAttribute("SELECTBOX_DATA", selectBoxMap);
			
			return findView(requestMap.getString("mode"), "/member/studyPersonList");
		}	
	
	   /**
		 * 가점입력 인원 검색 함수
		 * @author CHJ - 080814
		 * @param mapping
		 * @param form
		 * @param request
		 * @param response
		 * @param requestMap
		 * @throws Exception
		 */
	   @RequestMapping(value="/member/member.do", params="mode=findPerson")
		public String findPerson(			
				HttpServletRequest request,
				HttpServletResponse response,
				@ModelAttribute("cm") CommonMap commonMap) throws Exception{
			
		    DataMap requestMap = commonMap.getDataMap();
			DataMap resultMap=new DataMap();			

	        String smode=requestMap.getString("smode");
	        String grcode=requestMap.getString("commGrcode");
	        String grseq=requestMap.getString("commGrseq");
	        String search=requestMap.getString("search");
	        
	        if(!grcode.equals("") && !grseq.equals("")){        	
	        	resultMap=memberService.selectPointSearchPerson(smode,grcode,grseq,search);
	        }
	        request.setAttribute("personList", resultMap);
	        
	        return findView(requestMap.getString("mode"), "/member/searchStuRepPop");
		}
	   
		/**
		 * 가점입력 학생장/부학생장 변경(선택)
		 * @param mapping
		 * @param form
		 * @param request
		 * @param response
		 * @param requestMap
		 * @throws Exception
		 */
		public void insertPointPerson(
				Model model
				, DataMap requestMap) throws Exception{

			int result=0;
			String msg="";
			String resultType = "";
			
			result=memberService.updatePointPerson(requestMap);
						
			if(result > 0){			
				msg = "변경되었습니다.";						
				resultType = "ok";
			}else{			
				msg = "변경시 오류가 발생했습니다.";
				resultType = "saveError";
			}						
			model.addAttribute("RESULT_MSG", msg);
			model.addAttribute("RESULT_TYPE", resultType);				
			
		}	
	   
		/**
		 * 가점입력 학생장/부학생장 변경(취소)
		 * @param mapping
		 * @param form
		 * @param request
		 * @param response
		 * @param requestMap
		 * @throws Exception
		 */
		public void deletePointPerson(
				Model model
				, DataMap requestMap) throws Exception{
			
			int result=0;
			String msg="";
			String resultType = "";
			
			result=memberService.deletePointPerson(requestMap);
						
			if(result > 0){			
				msg = "변경되었습니다.";						
				resultType = "ok";
			}else{			
				msg = "변경시 오류가 발생했습니다.";
				resultType = "saveError";
			}						
			model.addAttribute("RESULT_MSG", msg);
			model.addAttribute("RESULT_TYPE", resultType);				
			
		}
		
	   @RequestMapping(value="/member/member.do", params="mode=findPersonExec")
	   public String findPersonExec(			
			   @ModelAttribute("cm") CommonMap commonMap
			   , Model model
			   ) throws Exception{
		   
		   DataMap requestMap = commonMap.getDataMap();
		   
		   if(requestMap.getString("qu").equals("insertPerson")){
			//학생장/부학생장 입력
				insertPointPerson(model, requestMap);				
			}else if(requestMap.getString("qu").equals("deletePerson")){
			//학생장/부학생장 삭제
				deletePointPerson(model, requestMap);
			}				
		   
		   return findView(requestMap.getString("mode"), "/member/memberScoreMsg");
	   }
	   
	   @RequestMapping(value="/member/member.do", params="mode=breakdownPop")
	   public String breakdownPop(			
			   @ModelAttribute("cm") CommonMap commonMap
			   , Model model
			   ) throws Exception{
		   
		   DataMap requestMap = commonMap.getDataMap();
			
			DataMap listMap = new DataMap();

			model.addAttribute("LIST_DATA", listMap);		
		   
		   return findView(requestMap.getString("mode"), "/member/printBreakdownPop");
	   }
	   
	   @RequestMapping(value="/member/member.do", params="mode=breakeDownExec")
	   public String breakeDownExec(			
			   @ModelAttribute("cm") CommonMap commonMap
			   , Model model
			   ) throws Exception{
		   
		   DataMap requestMap = commonMap.getDataMap();
		   
			int returnValue = 0;
			
			returnValue = memberService.insertBreakDownExec(requestMap);
			
			if(returnValue == 0){
				requestMap.setString("msg", "저장에 실패하였습니다.");
				
			}else if(returnValue == 1){
				requestMap.setString("msg", "저장하였습니다.");
				
			}
		   
		   return findView(requestMap.getString("mode"), "/member/memberMsg");
	   }
	   
	   @RequestMapping(value="/member/member.do", params="mode=ajaxCreateId", method=RequestMethod.GET)
	   public String ajaxCreateId(			
			   @ModelAttribute("cm") CommonMap commonMap
			   , Model model
			   ) throws Exception{
		   
		   DataMap requestMap = commonMap.getDataMap();
		   
			model.addAttribute("result", -2);
		   
		   return findView(requestMap.getString("mode"), "/member/ajaxCreateId");
	   }
	   @RequestMapping(value="/member/member.do", params="mode=ajaxCreateId", method=RequestMethod.POST)
	   public String ajaxCreateIdPost(			
			   @ModelAttribute("cm") CommonMap commonMap
			   , Model model
			   ) throws Exception{
		   
		   DataMap requestMap = commonMap.getDataMap();
		   
		   int error = -1;
			
        	error = memberService.ajaxCreateId(requestMap);
        	
			model.addAttribute("result", error);
		   
		   return findView(requestMap.getString("mode"), "/member/ajaxCreateId");
	   }
	   
	   
	  
	   
	  
}
