package loti.homeFront.web;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletRequest;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import loti.homeFront.mapper.IndexMapper;
import loti.homeFront.service.IndexService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import egovframework.rte.psl.dataaccess.util.EgovMap;
import gov.mogaha.gpin.sp.util.StringUtil;
import ut.lib.exception.BizException;
import ut.lib.login.LoginInfo;
import ut.lib.support.CommonMap;
import ut.lib.support.DataMap;
import ut.lib.util.Util;

@Controller
public class RenewalController {
	
	@Autowired
	private IndexService indexService;
	
	@ModelAttribute("cm")
	public CommonMap common(CommonMap cm, Model model) throws BizException{
		/**
		 * 필수
		 */
		DataMap requestMap = cm.getDataMap();
		requestMap.setNullToInitialize(true);				
		String mode = Util.getValue(requestMap.getString("mode"));			
		
		
		/**
		 * 로그인 체크
		 */
		LoginInfo loginInfo = cm.getLoginInfo();
		if(loginInfo.isLogin() == false){
			// 로그인 안되어 있음
			System.out.println("로그인 안되어 있음");
		}
		if(mode.equals("courseTimetable")){
			// 이건 과정운영계획에 뿌리는 것..
			model.addAttribute("GRSEQ_PLAN_LIST",indexService.getGrseqPlanList()  ); 
		}

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
		
		
		// 리퀘스트 정보를 담고있는 DataMap을 Attribute 에 추가
		model.addAttribute("REQUEST_DATA", requestMap);
		model.addAttribute("LOGIN_INFO", loginInfo);
		
		return cm;
	}
	
	public String findView(String mode, String view){
		
		return view;
	}
	
	@RequestMapping(value="/homepage/renewal.do", params="mode=eduinfo8-1")
	public String eduinfo81(){
		return "/homepage/eduInfo/eduinfo8-1";
	}
	
	@RequestMapping(value="/homepage/renewal.do", params="mode=eduinfo8-2")
	public String eduinfo82(){
		return "/homepage/eduInfo/eduinfo8-2";
	}
	
	@RequestMapping(value="/homepage/renewal.do", params="mode=eduinfo8-3")
	public String eduinfo83(){
		return "/homepage/eduInfo/eduinfo8-3";
	}
	
	@RequestMapping(value="/homepage/renewal.do", params="mode=eduinfotel")
	public String eduinfotel(){
		return "/homepage/eduInfo/eduinfotel";
	}
	
	@RequestMapping(value="/homepage/renewal.do", params="mode=readingList")
	public String readingList(){
		return "/homepage/renewal/readingList";
	}
	
	@RequestMapping(value="/homepage/renewal.do", params="mode=courseTimetable")
	public String courseTimetable(Model model) throws BizException{
		// 이건 과정운영계획에 뿌리는 것..
		model.addAttribute("GRSEQ_PLAN_LIST", indexService.getGrseqPlanList()  ); 
		return "/homepage/renewal/courseTimetable";
	}
	
	@RequestMapping(value="/homepage/renewal.do", params="mode=introduction02")
	public String introduction02() throws BizException{
		return "/homepage/renewal/introduction02";
	}
	
	@RequestMapping(value="/homepage/renewal.do", params="mode=eduinfo3-8")
	public String eduinfo38() throws BizException{
		return "/homepage/eduInfo/eduinfo3-8";
	}
	
	@RequestMapping(value="/homepage/renewal.do", params="mode=eduinfo3-9")
	public String eduinfo39() throws BizException{
		return "/homepage/eduInfo/eduinfo3-9";
	}
	
	@RequestMapping(value="/homepage/renewal.do", params="mode=eduinfo3-10")
	public String eduinfo310() throws BizException{
		return "/homepage/eduInfo/eduinfo3-10";
	}
	
	@RequestMapping(value="/homepage/renewal.do", params="mode=eduinfo3-11")
	public String eduinfo311() throws BizException{
		return "/homepage/eduInfo/eduinfo3-11";
	}
	
	@RequestMapping(value="/homepage/renewal.do", params="mode=eduinfo3-12")
	public String eduinfo312() throws BizException{
		return "/homepage/eduInfo/eduinfo3-12";
	}
	
	@RequestMapping(value="/homepage/renewal.do", params="mode=member01")
	public String member01() throws BizException{
		return "/homepage_new/member/member01";
	}
	
	@RequestMapping(value="/homepage/renewal.do", params="mode=member02", method=RequestMethod.GET)
	public String member02(Model model) throws BizException{
		model.addAttribute("userid","");
		return "/homepage_new/member/member02";
	}
	
	
	@RequestMapping(value="/homepage/renewal.do", params="mode=member02", method=RequestMethod.POST)
	public String member02Post(
				@ModelAttribute("cm") CommonMap cm
				, Model model
				, @RequestParam("mode") String mode
				, @RequestParam("id_name") String username
				, @RequestParam("id_email") String email
			) throws Exception{

		//requestMap.setString("resno",resno);
		cm.getDataMap().setString("email",email);
		cm.getDataMap().setString("username",username);	
			
		DataMap mapUserInfo = indexService.findPassword(cm.getDataMap());
		String userno = "";
		String siteId = "H9I2J9YCU8SQ";
		//GPinProxy proxy = GPinProxy.getInstance(request.getSession().getServletContext());
		//String dupinfo = proxy.getUserDupValue(resno, siteId).trim();
		//requestMap.setString("dupinfo", dupinfo);
		
		String userid = "";
		String name = "";
		for(int i=0; i < mapUserInfo.keySize("userno"); i++){
			if("".equals(mapUserInfo.getString("userId", i))) {  // 중복 데이타중 id가 없는거는  제거
				continue;
			}
			userno = mapUserInfo.getString("userno", i);
			userid = StringUtil.nvl(mapUserInfo.getString("userId", i),"");
			name = mapUserInfo.getString("name", i);
		}
		if("".equals(userno)) {
			DataMap mapDupinfoUserInfo = indexService.finddupinfo(cm.getDataMap());
			for(int i=0; i < mapDupinfoUserInfo.keySize("userno"); i++){
				if("".equals(StringUtil.nvl(mapDupinfoUserInfo.getString("userId", i),""))) { // 중복 데이타중 id가 없는거는  제거
					continue;
				}
				userno = mapDupinfoUserInfo.getString("userno", i);
				userid = StringUtil.nvl(mapDupinfoUserInfo.getString("userId", i),"");
				name = mapDupinfoUserInfo.getString("name", i);
			}
		}
		model.addAttribute("userid",userid);
		model.addAttribute("userno",userno);
		model.addAttribute("name",name);
		
		return "/homepage_new/member/member02";
	}
	
	@RequestMapping(value="/homepage/renewal.do", params="mode=member03", method=RequestMethod.GET)
	public String member03(Model model) throws BizException{
		model.addAttribute("userid","");
		return "/homepage_new/member/member03";
	}
	
	@RequestMapping(value="/homepage/renewal.do", params="mode=member03", method=RequestMethod.POST)
	public String member03Post(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			, @RequestParam("mode") String mode
			, @RequestParam("pw_email") String email
			, @RequestParam("pw_name") String username
			, @RequestParam("pw_userid") String userid
		) throws Exception{
		
		DataMap requestMap = cm.getDataMap();

		requestMap.setString("email",email);		
		requestMap.setString("username",username);	

		String userno = "";
		String siteId = "H9I2J9YCU8SQ";
		//GPinProxy proxy = GPinProxy.getInstance(request.getSession().getServletContext());
		//String dupinfo = proxy.getUserDupValue(resno, siteId).trim();
		
	//	requestMap.setString("dupinfo", dupinfo);
		requestMap.setString("userid", userid);
		userid = "";
		String email2 = "";
		String hp = "";
		DataMap mapUserInfo = indexService.findUserPassword(requestMap);
		for(int i=0; i < mapUserInfo.keySize("userno"); i++){
			userid = StringUtil.nvl(mapUserInfo.getString("userId", i),"");
			userno = mapUserInfo.getString("userno", i);
			email2 = mapUserInfo.getString("email", i);
			hp = mapUserInfo.getString("hp", i);
		}
		model.addAttribute("userid",userid);
		model.addAttribute("userno",userno);
		model.addAttribute("email",email2);
		model.addAttribute("hp",hp);
		
		return "/homepage_new/member/member03";
	}
	
	@RequestMapping(value="/homepage/renewal.do", params="mode=member04", method=RequestMethod.GET)
	public String member04(Model model) throws BizException{
		model.addAttribute("userid","");
		return "/homepage_new/member/member04";
	}
	
	@RequestMapping(value="/homepage/renewal.do", params="mode=member04", method=RequestMethod.POST)
	public String member04Post(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			, @RequestParam("mode") String mode
			, @RequestParam("userid") String userid
			) throws Exception{
		
		
		
		DataMap requestMap = cm.getDataMap();
		
		DataMap mapFindQuestion = indexService.findQuestion(requestMap);
		String question = "";	
		for(int i=0; i < mapFindQuestion.keySize("userno"); i++){
			userid = StringUtil.nvl(mapFindQuestion.getString("userId", i),"");
			question = mapFindQuestion.getString("pwdQus", i);
		}
		model.addAttribute("userid",userid);
		model.addAttribute("question",question);
		
		return "/homepage_new/member/member04";
	}
	
	@RequestMapping(value="/homepage/renewal.do", params="mode=member05", method=RequestMethod.GET)
	public String member05(Model model) throws BizException{
		model.addAttribute("userid","");
		return "/homepage_new/member/member05";
	}
	
	@RequestMapping(value="/homepage/renewal.do", params="mode=member05", method=RequestMethod.POST)
	public String member05Post(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			, @RequestParam("mode") String mode
			, @RequestParam("userid") String userid
			, @RequestParam("answer") String answer
			) throws Exception{
		
		DataMap requestMap = cm.getDataMap();
		
		DataMap mapFindQuestion = indexService.findQuestion(requestMap);
		
		String checkAnswer = "";	
		for(int i=0; i < mapFindQuestion.keySize("userno"); i++){
			userid = StringUtil.nvl(mapFindQuestion.getString("userId", i),"");
			checkAnswer = mapFindQuestion.getString("pwdAns", i);
		}
		String checkYn = "N";
		if(!"".equals(checkAnswer)) {
			if(answer.equals(checkAnswer)) {
				checkYn = "Y";
			}
		}
		model.addAttribute("checkYN",checkYn);
		model.addAttribute("userid",userid);
		
		return "/homepage_new/member/member05";
	}
	
	@RequestMapping(value="/homepage/renewal.do", params="mode=member09", method=RequestMethod.GET)
	public String member09() throws BizException{
		return "/homepage_new/member/member09";
	}
	
	@RequestMapping(value="/homepage/renewal.do", params="mode=member12", method=RequestMethod.GET)
	public String member12() throws BizException{
		return "/homepage_new/member/member12";
	}
	
	@RequestMapping(value="/homepage/renewal.do", params="mode=ajaxChangePasswd", method=RequestMethod.GET)
	public String ajaxChangePasswd(Model model) throws BizException{
		model.addAttribute("userid","");
		return "/homepage/ajaxSearchIdNpw2";
	}
	
	@RequestMapping(value="/homepage/renewal.do", params="mode=ajaxChangePasswd", method=RequestMethod.POST)
	public String ajaxChangePasswdPost(
				@ModelAttribute("cm") CommonMap cm
				, Model model
				, @RequestParam("mode") String mode
				, @RequestParam(value="checkYN", required=false) String checkYN
			) throws Exception{
		
		DataMap requestMap = cm.getDataMap();
		
		String result = "";
		if(!"Y".equals(checkYN)) {
			result = "-10";
		}
		int errcode = indexService.updatePasswd(requestMap);
		if(errcode == 1) {
			result = "100";
		} else {
			result = "-20";
		}
		model.addAttribute("mode", mode);
		model.addAttribute("result", result);
		
		return "/homepage/ajaxSearchIdNpw2";
	}
	
	
	@RequestMapping(value="/homepage/renewal.do", params="mode=memberpassword", method=RequestMethod.GET)
	public String memberpassword(Model model) throws BizException{
		model.addAttribute("userid","");
		return "/homepage_new/member/memberpassword";
	}
	
	@RequestMapping(value="/homepage/renewal.do", params="mode=newPwd", method=RequestMethod.GET)
	public String oldPwd(Model model) throws BizException{
		
		
		model.addAttribute("userid","");
		model.addAttribute("userno","");
		return "/homepage_new/member/newPwd";
	}
	
	
	@RequestMapping(value="/homepage/renewal.do", params="mode=newPwd", method=RequestMethod.POST)
	public String newPwd(Model model
					  ,@RequestParam("userid") String userid
					  ,@RequestParam("userno") String userno
					  ,@RequestParam("pwd") String pwd
					  ,HttpServletRequest request
					  ,HttpServletResponse response) throws Exception{				
		
		Map<String, Object> params = new HashMap<String, Object>();
		
		params.put("userid",userid);
		params.put("userno",userno);
		params.put("pwd",pwd);
		
		indexService.changeNewPwd(params);		

		//로그아웃 처리.
		HttpSession session = request.getSession();		
		session.invalidate();		
		
		return "redirect:http://hrd.incheon.go.kr";	
	}
	
	/*@RequestMapping(value="/homepage/renewal.do", params="mode=member03", method=RequestMethod.POST)
	public String member03Post(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			, @RequestParam("mode") String mode
			, @RequestParam("pw_email") String email
			, @RequestParam("pw_name") String username
			, @RequestParam("pw_userid") String userid
		) throws Exception{
		
		DataMap requestMap = cm.getDataMap();

		requestMap.setString("email",email);		
		requestMap.setString("username",username);	

		String userno = "";
		String siteId = "H9I2J9YCU8SQ";
		//GPinProxy proxy = GPinProxy.getInstance(request.getSession().getServletContext());
		//String dupinfo = proxy.getUserDupValue(resno, siteId).trim();
		
	//	requestMap.setString("dupinfo", dupinfo);
		requestMap.setString("userid", userid);
		userid = "";
		String email2 = "";
		String hp = "";
		DataMap mapUserInfo = indexService.findUserPassword(requestMap);
		for(int i=0; i < mapUserInfo.keySize("userno"); i++){
			userid = StringUtil.nvl(mapUserInfo.getString("userId", i),"");
			userno = mapUserInfo.getString("userno", i);
			email2 = mapUserInfo.getString("email", i);
			hp = mapUserInfo.getString("hp", i);
		}
		model.addAttribute("userid",userid);
		model.addAttribute("userno",userno);
		model.addAttribute("email",email2);
		model.addAttribute("hp",hp);
		
		return "/homepage_new/member/member03";
	}
	*/
	
}
