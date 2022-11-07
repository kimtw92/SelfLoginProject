package loti.homeFront.web;

/**
 * prgNM : homepage index
 * auth  : kang
 * date  : 08.08.08
 * default Class
 */

import gov.mogaha.gpin.sp.util.StringUtil;

import java.sql.SQLException;
import java.util.Calendar;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import loti.homeFront.mapper.IndexMapper;
import loti.homeFront.service.IndexService;
import loti.homeFront.service.SupportService;
import loti.homepageMgr.service.PopupZoneService;
import loti.login.service.LoginService;
import loti.statisticsMgr.service.StatisticsMgrService;
import loti.webzine.service.WebzineService;

import org.bouncycastle.ocsp.Req;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import ut.lib.exception.BizException;
import ut.lib.login.LoginInfo;
import ut.lib.security.StringEncrypter2;
import ut.lib.support.CommonMap;
import ut.lib.support.DataMap;
import ut.lib.util.Message;
import ut.lib.util.Util;

import common.controller.BaseController;

@Controller
public class IndexController extends BaseController{
	
	@Autowired
	private WebzineService webzineService;
	
	@Autowired
	private LoginService loginService;
	
	@ModelAttribute("cm")
	public CommonMap common(CommonMap cm, HttpServletRequest request, HttpSession session, Model model, @RequestParam(value="mode", required=false) String mode) throws BizException{
		
		/**
		 * 로그인 체크
		 */
		LoginInfo loginInfo = (LoginInfo)cm.getRequest().getAttribute("LOGIN_INFO");
		if(loginInfo.isLogin() == false){
			System.out.println("=====로그인 안되어 있음"); 
		}
		
		if(mode.equals("homepage")){
			if(loginInfo.isLogin() == true){
				indexService.insertLoginStats("2", loginInfo.getSessNo());
			}else{
				indexService.insertLoginStats("1", "");
			}
		}
		
		// 이달의 교육과정 AJAX 파라미터를 설정하는 부분 시작	
		String monthajax = cm.getRequest().getParameter("month");	
		cm.getDataMap().setString("monthajax",monthajax);
		// 이달의 교육과정 AJAX 파라미터를 설정하는 부분 끝
		
		// 달을 판단해서 이달의 교육과정을 보여주는 부분 시작
		Calendar c = Calendar.getInstance();
		String month= Util.plusZero(c.get(Calendar.MONTH)+1);
		 
		cm.getDataMap().setString("month", month);
		//	달을 판단해서 이달의 교육과정을 보여주는 부분 끝
		
		// 리퀘스트 정보를 담고있는 DataMap을 Attribute 에 추가
		model.addAttribute("REQUEST_DATA", cm.getDataMap());
		model.addAttribute("LOGIN_INFO", loginInfo);
		
		System.out.println("mode="+mode);
		
		return cm;
	}
	
	@Autowired
	private IndexService indexService;
	@Autowired
	private PopupZoneService popupZoneService;
	@Autowired
	private SupportService supportService;
	
	@Autowired
	private StatisticsMgrService statisticsMgrService;
	
	@RequestMapping("/homepage/index.do")
	public String root(CommonMap cm, Model model) throws Exception{
		return homepage(cm, model);
	}
	
	
	@RequestMapping(value="/homepage/index.do", params = "mode=homepage")
	public String homepage(@ModelAttribute("cm") CommonMap cm, Model model) throws BizException{
		
		model.addAttribute("NOTICE_LIST",indexService.getNoticeList()  );
		model.addAttribute("CYBER_LIST",indexService.getCyberList()  );
		model.addAttribute("NONCYBER_LIST",indexService.getNonCyberList()  );		
		model.addAttribute("MONTH_LIST",indexService.getMonthList(cm.getDataMap()) );		
		model.addAttribute("WEEK_LIST",indexService.getWeekList()  );
		model.addAttribute("MONTH_AJAX_LIST",indexService.getMonthAJAXList(cm.getDataMap()) );	
		
		DataMap test = cm.getDataMap();

		
		model.addAttribute("THISMONTH",cm.getDataMap().get("month"));
		
		
		//request.setAttribute("GOOD_TEACHER_LIST",sv.getGoodLectureList()  );
		model.addAttribute("POPUP_LIST",indexService.getPopupList()  );
		model.addAttribute("PHOTO_LIST",indexService.getPhotoList()  );
		// 이건 과정운영계획에 뿌리는 것..
		model.addAttribute("GRSEQ_PLAN_LIST",indexService.getGrseqPlanList()  ); 
		
		//팝업존
		model.addAttribute("POPUPZON_LIST", popupZoneService.getMainPopupZoneList()  );
		
		String key = "2017";
		// 기관별 수료율
		//model.addAttribute("GRADURATE_LIST", statisticsMgrService.cyberCourseStats(key)  );
	
		
		HttpSession loginSession= cm.getSession();
		
		if(loginSession.getAttribute("sess_no") != null){
			
			DataMap pwdData = loginService.selectPwdChk(loginSession.getAttribute("sess_no").toString());							
			
			if (pwdData.size() > 0) {				
				model.addAttribute("OLDPWD","TRUE");											
			}		
		}else{			
			model.addAttribute("OLDPWD","FALSE");
		}

		
		return "/homepage_2019/index";
	}
	
	@RequestMapping(value="/homepage/index.do", params = "mode=homepage1")
	public String homepage1(@ModelAttribute("cm") CommonMap cm, Model model) throws BizException{
		
		model.addAttribute("NOTICE_LIST",indexService.getNoticeList()  );
		model.addAttribute("CYBER_LIST",indexService.getCyberList()  );
		model.addAttribute("NONCYBER_LIST",indexService.getNonCyberList()  );
		model.addAttribute("MONTH_LIST",indexService.getMonthList(cm.getDataMap())  );
		model.addAttribute("WEEK_LIST",indexService.getWeekList()  );
		model.addAttribute("MONTH_AJAX_LIST",indexService.getMonthAJAXList(cm.getDataMap())  );
		//request.setAttribute("GOOD_TEACHER_LIST",sv.getGoodLectureList()  );
		model.addAttribute("POPUP_LIST",indexService.getPopupList()  );
		model.addAttribute("PHOTO_LIST",indexService.getPhotoList()  );
		// 이건 과정운영계획에 뿌리는 것..
		model.addAttribute("GRSEQ_PLAN_LIST",indexService.getGrseqPlanList()  ); 
		
		//팝업존
		model.addAttribute("POPUPZON_LIST", popupZoneService.getMainPopupZoneList()  );
		
		String key = "2017";
		// 기관별 수료율
		model.addAttribute("GRADURATE_LIST", statisticsMgrService.cyberCourseStats(key)  );
		
		return "/homepage/index_2018";
	}
	
	@RequestMapping(value="/homepage/index.do", params = "mode=eduInfo")
	public String eduInfo(@ModelAttribute("cm") CommonMap cm, Model model, HttpServletRequest request) throws Exception{
		
		cm.getRequest().setCharacterEncoding("euc-kr");
		DataMap listMap = supportService.memberView((String)cm.getSession().getAttribute("sess_userid"));
		
		HttpSession session = request.getSession();
		String checkSSO = (String)session.getAttribute("sess_checkSSO");
		request.setAttribute("checkSSO", checkSSO);
		
		
		
		LoginInfo loginInfo = (LoginInfo) cm.getLoginInfo();
		
		StringEncrypter2 StringEncrypter2 = new StringEncrypter2("incheon", "cyber");
		
		String mjiknm = StringEncrypter2.encrypt(listMap.getString("mjiknm", 0));
		String deptnm = StringEncrypter2.encrypt(listMap.getString("deptnm", 0));
		String deptsub = StringEncrypter2.encrypt(listMap.getString("deptsub", 0));
		String sex = StringEncrypter2.encrypt(listMap.getString("sex", 0));
		String userId = StringEncrypter2.encrypt(loginInfo.getSessUserId());
		String userName = StringEncrypter2.encrypt(loginInfo.getSessName());
		String userEmail = StringEncrypter2.encrypt(loginInfo.getSessUserEmail());
		String userDept = StringEncrypter2.encrypt(loginInfo.getSessUserDept());
		String userJik = StringEncrypter2.encrypt(loginInfo.getSessUserJik());
		String userHp = StringEncrypter2.encrypt(loginInfo.getSessUserHp());
	
		
		String hp1 = "";
		String hp2 = "";
		String hp3 = "";
		
		String tempHp[] = userHp.split("-");
		
		if(!"".equals(StringUtil.nvl(userHp))) {
			try {
				hp1 = StringEncrypter2.encrypt(tempHp[0]);
				hp2 = StringEncrypter2.encrypt(tempHp[1]);
				hp3 = StringEncrypter2.encrypt(tempHp[2]);
			} catch (Exception e) {
				hp1 = "";
				hp2 = "";
				hp3 = "";
			}
		}
		
		listMap.setString("ecnmjiknm", mjiknm);
		listMap.setString("ecndeptnm", deptnm);
		listMap.setString("ecndeptsub", deptsub);
		listMap.setString("ecnsex", sex);
		listMap.setString("ecnuserId", userId);
		listMap.setString("ecnuserName", userName);
		listMap.setString("ecnuserEmail", userEmail);
		listMap.setString("ecnuserDept", userDept);
		listMap.setString("ecnuserJik", userJik);
		listMap.setString("ecnuserHp", userHp);
		listMap.setString("ecnhp1", hp1);
		listMap.setString("ecnhp2", hp2);
		listMap.setString("ecnhp3", hp3);
		
		model.addAttribute("USER_INFO", listMap);
		
		return "/homepage/eduInfo";
	}
	
	@RequestMapping(value="/homepage/index.do", params = "mode=ajax")
	public String ajax(@ModelAttribute("cm")  CommonMap cm, Model model) throws Exception{		

	
		
		model.addAttribute("MONTH_AJAX_LIST",indexService.getMonthAJAXList(cm.getDataMap()) );	
		
		
		
		return "/homepage/getMonthAJAX";
	}
	
	@RequestMapping(value="/homepage/index.do", params = "mode=sitemap")
	public String sitemap() throws Exception{
		return "/homepage/sitemap";
	}
	
	@RequestMapping(value="/homepage/index.do", params = "mode=newPollPreviewPop2")
	public String newPollPreviewPop2() throws Exception{
		return "/homepage/newPollPreviewPop2";
	}
	
	
	
	@RequestMapping(value="/homepage/index.do", params = "mode=policy")
	public String policy() throws Exception{
		return "/homepage/policy";
	}
	
	@RequestMapping(value="/homepage/index.do", params = "mode=videopolicy")
	public String videopolicy() throws Exception{
		return "/homepage/videopolicy";
	}
	
	@RequestMapping(value="/homepage/index.do", params = "mode=spam")
	public String spam() throws Exception{
		return "/homepage/spam";
	}
	
	@RequestMapping(value="/homepage/index.do", params = "mode=worktel")
	public String worktel() throws Exception{
		return "/homepage/worktel";
	}
	
	@RequestMapping(value="/homepage/index.do", params = "mode=showpicture")
	public String showpicture(Model model, @RequestParam(value="path", defaultValue="") String imgPath) throws Exception{
		model.addAttribute("imgPath", imgPath);
		return "/homepage/showpicture";
	}
	
	@RequestMapping(value="/homepage/index.do", params = "mode=showpicture2")
	public String showpicture(HttpServletRequest request, Model model, @RequestParam(value="path", defaultValue="") String imgPath) throws Exception{
		String photoNo = request.getParameter("photoNo");
		DataMap rowMap = webzineService.selectComplateRow(Integer.parseInt(photoNo));
		request.setAttribute("wcomments", rowMap.get("wcomments"));
		request.setAttribute("imgPath", rowMap.get("imgPath"));
		return "/homepage/showpicture";
	}
	
	@RequestMapping(value="/homepage/index.do", params = "mode=gowinglish")
	public String gowinglish(@ModelAttribute("cm") CommonMap cm, Model model, HttpServletRequest request) throws Exception{
		
		request.setCharacterEncoding("euc-kr");
		
		HttpSession session = request.getSession();
		
		String resno        = (String)session.getAttribute("sess_resno");
		resno = resno.substring(0, 6);
		String userid       = (String)session.getAttribute("sess_userid");
		String username     = (String)session.getAttribute("sess_name");
		String uhandhone    = (String)session.getAttribute("sess_userhp");
		
		String url = "http://company.winglish.com/incheon/incheon_outer.asp?resno="+resno+"&userid="+userid+"&username="+username+"&uhandhone="+uhandhone;
		
		model.addAttribute("url", url);
		
		return "/homepage/gowinglish";
	}
	
	@RequestMapping(value="/homepage/index.do", params = "mode=existid")
	public String existid() throws Exception{
		return "/homepage/existidcheck";
	}
	
//	<!-- id 발급여부 확인 -->
	@RequestMapping(value="/homepage/index.do", params = "mode=existidyn")
	public String existidyn(@ModelAttribute("cm") CommonMap cm
				, Model model
				, @RequestParam(value="ssn1", defaultValue="") String ssn1
				, @RequestParam(value="ssn2", defaultValue="") String ssn2
				) throws Exception{
		
		cm.getDataMap().setString("ssn", ssn1+ssn2);
		model.addAttribute("EXIST_ID_VALUE",indexService.getExistIdValue(cm.getDataMap())  );
		
		return "/homepage/existidcheckresult";
	}
	
	@RequestMapping(value="/homepage/index.do", params = "mode=createid")
	public String createid() throws Exception{
		return "/homepage/createid";
	}
	
	@RequestMapping(value="/homepage/index.do", params = "mode=usercreateid")
	public String usercreateid() throws Exception{
		return "/homepage/pause";
	}
	
	@RequestMapping(value="/homepage/index.do", params = "mode=ajaxCheckMember")
	public String ajaxCheckMember() throws Exception{
		return "/homepage/ajaxCheckMember";
	}
	
//	<!--  집합교육, 사이버교육 팝업 리스트 -->
	@RequestMapping(value="/homepage/index.do", params = "mode=allnoncyber")
	public String allnoncyber(Model model) throws Exception{
		model.addAttribute("ALL_NON_CYBER_LIST",indexService.getAllNonCyberList()  );
		return "/homepage/allnoncybereducation";
	}
	
	@RequestMapping(value="/homepage/index.do", params = "mode=allcyber")
	public String allcyber(Model model) throws Exception{
		model.addAttribute("ALL_CYBER_LIST",indexService.getAllCyberList()  );
		return "/homepage/allcybereducation";
	}
//	<!--  집합교육, 사이버교육 팝업 리스트 -->
	
//	<!-- 팝업관련 최대 5개 설정 -->
	@RequestMapping(value="/homepage/index.do", params = "mode=popup1")
	public String popup1(	Model model
			, @RequestParam(value="no", required=false) String no
			, @RequestParam("mode") String mode
			) throws Exception{
		model.addAttribute("POPUP_CONTENTS",indexService.getPopupView(no));			
		return "/popup/"+mode;
	}
	@RequestMapping(value="/homepage/index.do", params = "mode=popup2")
	public String popup2(	Model model
			, @RequestParam(value="no", required=false) String no
			, @RequestParam("mode") String mode
			) throws Exception{
		model.addAttribute("POPUP_CONTENTS",indexService.getPopupView(no));			
		return "/popup/"+mode;
	}
	@RequestMapping(value="/homepage/index.do", params = "mode=popup3")
	public String popup3(	Model model
			, @RequestParam(value="no", required=false) String no
			, @RequestParam("mode") String mode
			) throws Exception{
		model.addAttribute("POPUP_CONTENTS",indexService.getPopupView(no));			
		return "/popup/"+mode;
	}
	@RequestMapping(value="/homepage/index.do", params = "mode=popup4")
	public String popup4(	Model model
			, @RequestParam(value="no", required=false) String no
			, @RequestParam("mode") String mode
			) throws Exception{
		model.addAttribute("POPUP_CONTENTS",indexService.getPopupView(no));			
		return "/popup/"+mode;
	}
	@RequestMapping(value="/homepage/index.do", params = "mode=popup5")
	public String popup5(	Model model
			, @RequestParam(value="no", required=false) String no
			, @RequestParam("mode") String mode
			) throws Exception{
		model.addAttribute("POPUP_CONTENTS",indexService.getPopupView(no));			
		return "/popup/"+mode;
	}
//	<!-- 팝업관련 최대 5개 설정 -->
	
	/**
	 * 페이징 셈플
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @param requestMap
	 * @throws Exception
	 */
	public void pageingSample(
			Model model,
	          DataMap requestMap) throws Exception {
				
		DataMap listMap = null;
		
		/**
		 * 페이징 필수
		 */
		// 페이지
		if ("".equals(requestMap.getString("currPage"))){
			requestMap.setInt("currPage", 1);
		}
		// 페이지당 보여줄 갯수
		if ("".equals(requestMap.getString("rowSize"))){
			requestMap.setInt("rowSize", 10); 
		}
		// 페이지 블럭 갯수
		if ("".equals(requestMap.getString("pageSize"))){
			requestMap.setInt("pageSize", 10);
		}
		
		
		// 리스트 가져오기
		listMap = indexService.pageingSample(requestMap);
		model.addAttribute("LIST_DATA", listMap);
		
	}
	
	@RequestMapping(value="/homepage/index.do", params="mode=pageing")
	public String pageing(
				@ModelAttribute("cm") CommonMap cm
				, Model model
			) throws Exception{
		// 페이징 셈플
		pageingSample(model, cm.getDataMap());
		
		return "/homepage/pageingSample";
	}
	
	/*
	 * SSO 개인정보 동의 확인 */
	@RequestMapping(value="/homepage/memberUpdateAgree.do", params="mode=ajaxUpdate")
	public String memberUpdateAgree(@ModelAttribute("cm") CommonMap cm, Model model) throws Exception{
		String resultMsg = "NOT_AGREE";
		Map<String, Object> map = cm.getMap();
		LoginInfo loginInfo = (LoginInfo) cm.getLoginInfo();
		map.put("userno", loginInfo.getSessNo());
		int result = indexService.getMemberSSOAgree(map);
		if(result > 0){
			resultMsg = "AGREE";
		}
		model.addAttribute("result", resultMsg);
		return "/commonInc/include/ajaxMemberUpdateAgree";
	}
}
