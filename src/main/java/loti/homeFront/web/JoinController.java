package loti.homeFront.web;

import java.io.IOException;
import java.net.URLEncoder;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.Statement;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import loti.homeFront.service.IndexService;
import loti.homeFront.vo.PersonVO;
import loti.mypage.service.MyClassService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import ut.lib.exception.BizException;
import ut.lib.login.LoginInfo;
import ut.lib.support.CommonMap;
import ut.lib.support.DataMap;
import ut.lib.support.RequestUtil;
import ut.lib.util.Util;
import common.controller.BaseController;

@Controller
public class JoinController extends BaseController {

	@Autowired
	private IndexService indexService;
	
	@Autowired
	private MyClassService myClassService;
	
	@ModelAttribute("cm")
	public CommonMap common(
				CommonMap cm
				, HttpServletRequest request
			) throws IOException{
		/**
		 * 필수
		 */
		DataMap requestMap = RequestUtil.getRequest(request);
		requestMap.setNullToInitialize(true);				
		String mode = Util.getValue(requestMap.getString("mode"));		
		
		/**
		 * 로그인 체크
		 */
		LoginInfo loginInfo = (LoginInfo)request.getAttribute("LOGIN_INFO");
		if(loginInfo.isLogin() == false){
			// 로그인 안되어 있음
			System.out.println("로그인 안되어 있음"); 
		}
		
		// 리퀘스트 정보를 담고있는 DataMap을 Attribute 에 추가
		request.setAttribute("REQUEST_DATA", requestMap);
		request.setAttribute("LOGIN_INFO", loginInfo);
		
		return cm;
	}
	
	@RequestMapping(value="/homepage/join.do", params="mode=joinstep1")
	public String joinstep1(@ModelAttribute("cm") CommonMap cm){
		return "/homepage/joinStep1";
	}
	
	@RequestMapping(value="/homepage/join.do", params="mode=joinstep2")
	public String joinstep2(@ModelAttribute("cm") CommonMap cm){
		
		return "/homepage/joinStep2";
	}
	
	@RequestMapping(value="/homepage/join.do", params="mode=joinstep3")
	public String joinstep3(@ModelAttribute("cm") CommonMap cm, Model model) throws BizException{
		
		model.addAttribute("DEPT_LIST", indexService.getDeptList()  );			
		
		return "/homepage/joinStep3";
	}
	
	@RequestMapping(value="/homepage/join.do", params="mode=addpictures")
	public String addpictures(@ModelAttribute("cm") CommonMap cm, Model model) throws BizException{
		
		return "/homepage/addpicture";
	}
	
	@RequestMapping(value="/homepage/join.do", params="mode=idcheckajax")
	public String idcheckajax(@ModelAttribute("cm") CommonMap cm, Model model) throws BizException{
		// id 파라미터를 설정하는 부분
		String userid = cm.getRequest().getParameter("userid");	
		cm.getDataMap().setString("userid",userid);		
		
		model.addAttribute("JOIN_YN",indexService.getJoinYn(cm.getDataMap())  );
		
		return "/homepage/idcheckajax";
	}
	
	@RequestMapping(value="/homepage/join.do", params="mode=emailcheckajax")
	public String emailcheckajax(
				@ModelAttribute("cm") CommonMap cm
				, Model model
				, HttpServletRequest request
			) throws BizException{
		String email = request.getParameter("email");	
		cm.getDataMap().setString("email",email);		
		
		model.addAttribute("EMAIL_YN",indexService.getEmailYn(cm.getDataMap())  );
		return "/homepage/emailcheckajax";		
	}
	
	@RequestMapping(value="/homepage/join.do", params="mode=searchPart_")
	public String searchPart_(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			, HttpServletRequest request
			) throws BizException{
		
		DataMap requestMap = cm.getDataMap();
		
		DataMap listPart = null;
		
		// 파트 리스트
		if("6289999".equals(requestMap.getString("dept"))) {
			listPart = myClassService.ldapList(requestMap.getString("dept"));
		} else {
			listPart = myClassService.partList(requestMap.getString("dept"));
		}
		request.setAttribute("dept", requestMap.getString("dept"));
		request.setAttribute("PART_DATA", listPart);
		
		return "/homepage/partAjax_join";		
	}
	
	@RequestMapping(value="/homepage/join.do", params="mode=findjik")
	public String findjik(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			, HttpServletRequest request
			) throws BizException{
		
		return "/homepage/findJik";		
	}
	
	@RequestMapping(value="/homepage/join.do", params="mode=findjikajax")
	public String findjikajax(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			, HttpServletRequest request
			) throws BizException{
		
		DataMap requestMap = cm.getDataMap();
		
		String jik = request.getParameter("jik");
		requestMap.setString("jik",jik);		
		
		request.setAttribute("ZIK_LIST",indexService.getZikList(requestMap));		
		
		
		return "/homepage/findJikajax";		
	}
	
	@RequestMapping(value="/homepage/join.do", params="mode=joinmember")
	public String joinmember(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			, HttpServletRequest request
			, @RequestParam Map<String,Object> requestMap
			) throws BizException{
		DataMap requestMap_d = cm.getDataMap();
		requestMap_d.put("userno",indexService.getUserNo());
		requestMap.put("userno",indexService.getUserNo());		
		
		//2011.01.09 - woni82
		//기존의 주민등록 번호 입력 파라미터 값은 우선 그대로 살려둡니다.
		
	
		requestMap.put("user_id",request.getParameter("USER_ID"));		
		requestMap.put("pwd",request.getParameter("PWD"));		
		requestMap.put("pwd_qus",request.getParameter("PWD_QUS"));		
		requestMap.put("pwd_ans",request.getParameter("PWD_ANS"));		
		requestMap.put("name",request.getParameter("username"));		
		requestMap.put("email",request.getParameter("emailid")+"@"+request.getParameter("mailserv"));		
		requestMap.put("home_tel",request.getParameter("HOME_TEL1")+"-"+request.getParameter("HOME_TEL2")+"-"+request.getParameter("HOME_TEL3"));		
		requestMap.put("office_tel",request.getParameter("OFFICE_TEL1")+"-"+request.getParameter("OFFICE_TEL2")+"-"+request.getParameter("OFFICE_TEL3"));		
		requestMap.put("hp",request.getParameter("HP1")+"-"+request.getParameter("HP2")+"-"+request.getParameter("HP3"));		
		requestMap.put("newhomepost",cm.getDataMap().getString("newHomePost"));	
		requestMap.put("home_addr",request.getParameter("homeAddr"));		
		requestMap.put("dept",request.getParameter("officename").substring(0,7));		
		requestMap.put("deptnm",request.getParameter("officename").substring(7));		
		requestMap.put("jikwi",request.getParameter("degree"));		
		requestMap.put("jik",request.getParameter("hiddenjik"));		
		requestMap.put("mjiknm",request.getParameter("degreename"));		
		requestMap.put("school",request.getParameter("school"));		
		requestMap.put("mailyn",request.getParameter("mailYN"));		
		requestMap.put("sms_yn",request.getParameter("smsYN"));
		requestMap.put("fidate",request.getParameter("FIDATE"));		
		requestMap.put("upsdate",request.getParameter("UPSDATE"));	
		requestMap.put("fileno",request.getParameter("fileno"));	
		requestMap.put("deptsub",request.getParameter("deptname"));
		requestMap.put("ldapcode",requestMap.get("PART_DATA"));	
		requestMap.put("newhomepost1",requestMap.get("newHomePost1"));
		requestMap.put("newhomepost2",requestMap.get("newHomePost2"));
		requestMap.put("newaddr1",requestMap.get("newAddr1"));
		requestMap.put("newaddr2",requestMap.get("newAddr2"));
		
		//2011.01.09 - woni82
		//등록 타입 설정
		//기존 등록자 : 0, 주민등록번호 인증 : 1, i-Pin 인증 : 2
		requestMap.put("regtype",request.getParameter("regtype"));
		
		//i-Pin 모듈 적용 이후 주민등록번호 인증 / i-Pin 인증 회원을 가입 시키기 위한 설정.
		//생년월일, 성별을 저장한다.
		requestMap.put("birthdate",request.getParameter("bYear")+request.getParameter("bMonth")+request.getParameter("bDay"));
		requestMap.put("sex",request.getParameter("sex"));
		
		//회원의 중복코드는 항상 저장이 되어야 된다.
		requestMap.put("dupinfo",request.getParameter("dupinfo"));
		
		
		//회원 가입 형식으로 데이터 저장값을 변경하여 준다.
		String regType = request.getParameter("regtype");
		if(regType.equals("1")){
			//등록타입이 주민등록번호 인증일 경우에는 i-Pin 인증 관련된 값이 존재 안하므로 값을 "null"이 아닌 ""(null)로 하여 등록 시켜 주어야 된다.
			//age char(1), nationalInfo char(1), authinfo varchar2(2)라서 값이 크다는 오류가 발생한다.
			requestMap.put("virtualno","");
			requestMap.put("age","");
			requestMap.put("nationalinfo","");
			requestMap.put("authinfo","");
			requestMap.put("resno",request.getParameter("ssn1")+request.getParameter("ssn2"));
		}
		else{
			//i-Pin 인증 받은 사람의 가입 파라미터 값을 저장
			requestMap.put("virtualno",request.getParameter("virtualno"));
			requestMap.put("age",request.getParameter("age"));
			requestMap.put("nationalinfo",request.getParameter("nationalinfo"));
			requestMap.put("authinfo",request.getParameter("authinfo"));
			requestMap.put("resno","nullnull");	
		}
		
		String user_id = request.getParameter("USER_ID");
		
		indexService.joinMember(requestMap);	
		indexService.updateDamoMember(user_id);
		/*
		// 시민사이트 동시가입
		if(request.getParameter("cmYN").equals("Y")){ // 만약 시민사이트 동시가입을 원한다면...
			if(sv.checkCmlmsJoin(request.getParameter("emailid")+"@"+request.getParameter("mailserv"), request.getParameter("username"))) { // 이 메소드는 true, false를 리턴, 일단 이메일과 이름으로 아이디 존재유무 파악
				//FINAL. 이때는 아이디값을 가지고 와서 공무원 테이블에 update해야함.
				
				sv.updateCmlmsId(request.getParameter("USER_ID"),request.getParameter("USER_ID"));
			
			}else{
				//젠장 성별은 따로 설정해야 함.
				if((request.getParameter("ssn1")+request.getParameter("ssn2")).substring(6,7).equals("1")){
					requestMap.setString("sex", "M");
				}else {
					requestMap.setString("sex", "F");
				}
				
				// 시민 일련번호 가지고 오기
				String cmlmsUserno = "";
				cmlmsUserno = sv.getCmlmsUserNo();
			
				if(sv.checkCmlmsIdExist(request.getParameter("USER_ID"))) { // 이메일과 이름으로 아이디가 없을때...공무원에 가입하는 아이디로 시민사이트에 아이디가 있는지 체크
					//FINAL. 이때는 공무원 아이디에 _loti를 붙여서 시민사이트에 insert해야하고, 그아이디를 공무원 테이블에 update
					sv.joinCmlmsMember(requestMap, request.getParameter("USER_ID")+"_loti", cmlmsUserno);
					sv.updateCmlmsId(request.getParameter("USER_ID")+"_loti",request.getParameter("USER_ID"));
				}else {
					//FINAL. 이때는 공무원 아이디를 그대로 시민테이블에 insert해야하고, 그 아이디를 공무원 테이블에 update
					sv.joinCmlmsMember(requestMap, request.getParameter("USER_ID"), cmlmsUserno);
					sv.updateCmlmsId(request.getParameter("USER_ID"),request.getParameter("USER_ID"));
				}
			}
		}
		*/
		
		return "/homepage/joinsuccess";		
	}
	
	@RequestMapping(value="/homepage/join.do", params="mode=ajaxSearchId")
	public String ajaxSearchId(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			, HttpServletRequest request
			) throws BizException{
		
		return "/homepage/ajaxSearchIdNpw";		
	}
	
	@RequestMapping(value="/homepage/join.do", params="mode=ajaxSearchPw")
	public String ajaxSearchPw(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			, HttpServletRequest request
			) throws BizException{
		
		return "/homepage/ajaxSearchIdNpw";		
	}
	
	@RequestMapping(value="/homepage/join.do", params="mode=zipcode")
	public String zipcode(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			, HttpServletRequest request
			) throws BizException{
		
		return "/homepage/zipcode";		
	}
	
	@RequestMapping(value="/homepage/join.do", params="mode=zipcodecheckajax")
	public String zipcodecheckajax(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			, @RequestParam(value="address", required=false, defaultValue="") String address
			) throws Exception{
		
		cm.getDataMap().setString("address",address);	
		
		model.addAttribute("ZIPCODE_LIST",indexService.getZipcodeList(cm.getDataMap())  );		
		
		return "/homepage/zipcodeajax";		
	}
	
	@RequestMapping(value="/homepage/join.do", params="mode=detailaddr")
	public String detailaddr(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			, @RequestParam(value="selAddr", required=false, defaultValue="") String selAddr
			) throws Exception{
		
		cm.getDataMap().setString("selAddr",selAddr);
		
		return "/homepage/finalzipcodeform";		
	}
	
	@RequestMapping(value="/homepage/join.do", params="mode=findstep1")
	public String findstep1(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			) throws Exception{
		
		return "/homepage/findStep1";		
	}
	
	@RequestMapping(value="/homepage/join.do", params="mode=findpwajax")
	public String findpwajax(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			, @RequestParam(value="ssn", required=false, defaultValue="") String resno
			, @RequestParam(value="name", required=false, defaultValue="") String username
			) throws Exception{
		
		// 회원의 아이디/ 비밀번호를 찾는 로직
		// 주민등록번호를 사용

		cm.getDataMap().setString("resno",resno);		
		cm.getDataMap().setString("username",username);	
		
		model.addAttribute("resno",resno);
		model.addAttribute("FIND_PW",indexService.findPassword(cm.getDataMap())  );		
		
		return "/homepage/findpwajax";		
	}
	
	@RequestMapping(value="/homepage/join.do", params="mode=findpwajaxEmail")
	public String findpwajaxEmail(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			, @RequestParam(value="email", required=false, defaultValue="") String email
			, @RequestParam(value="name", required=false, defaultValue="") String username
			) throws Exception{
		
		//2011.01.11 - woni82
		// 회원의 아이디/ 비밀번호를 찾는 로직
		// 주민등록번호를 사용안하고 이메일 주소를 사용한다.

		cm.getDataMap().setString("email",email);		
		cm.getDataMap().setString("username",username);	
		
		//request.setAttribute("email",email);
		model.addAttribute("FIND_PW",indexService.findPasswordByEmail(cm.getDataMap())  );		
		
		return "/homepage/findpwajaxEmail";		
	}
	
	@RequestMapping(value="/homepage/join.do", params="mode=sendemail")
	public String sendemail(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			, @RequestParam(value="userno", required=false, defaultValue="") String userno
			) throws Exception{
		
		PersonVO vo = indexService.getPersonInfo(userno);
		
		// 여섯자리의 숫자로 이루어진 패스워드를 만드는 부분
		String passwd = "";
		int temporaryPassword = 0;
		for(int i=0; i<6; i++) {
			temporaryPassword += (int)(Math.random()*10) * (int)(Math.pow(10, i));
		}
		passwd = "hrd" + temporaryPassword;
		String mailSeq = "";
		mailSeq = indexService.getMailSeq();
		StringBuilder mqEtc = new StringBuilder();
		mqEtc
			.append("PASSWORD=")
			.append(URLEncoder.encode(passwd))
//			.append("&NAME=")
//			.append(URLEncoder.encode(vo.getName()))
		;
		
		vo.setKey("M2");
		vo.setParam1(passwd);
		vo.setSeq(mailSeq);
		vo.setMqEtc(mqEtc.toString());
		
		int errorCode = indexService.sendMail(vo);
		if(errorCode > 0) {
			indexService.setPassword(passwd, userno);
			model.addAttribute("result","Y");
		} else {
			model.addAttribute("result","N");
		}
		
		return "/homepage/sendemail";		
	}
	
	@RequestMapping(value="/homepage/join.do", params="mode=sendsms")
	public String sendsms(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			, @RequestParam(value="hp", required=false, defaultValue="") String hp
			, @RequestParam(value="userno", required=false, defaultValue="") String userno
			) throws Exception{
		
		hp = hp.replaceAll("-","");
		
		PersonVO vo = new PersonVO();
		vo = indexService.getPersonInfo(userno);	
		
		// 여섯자리의 숫자로 이루어진 패스워드를 만드는 부분
		String passwd = "";
		int temporaryPassword = 0;
		for(int i=0; i<6; i++) {
			temporaryPassword += (int)(Math.random()*10) * (int)(Math.pow(10, i));
		}
		passwd = "hrd" + temporaryPassword;
		//String msg = "[" + passwd + "]" + " 임시패스워드입니다. [인천인재개발원]";		
		//String msg = "[인천인재개발원] 임시패스워드 " + passwd + " 입니다.";
		String msg = "임시 패스워드는 " + passwd + "입니다.";
			   msg += "로그인 하신 후 반드시 패스워드를 변경하시기 바랍니다.";

		
		//int errorCode = indexService.sendSms(hp,msg);
		
		
		Class.forName("com.mysql.jdbc.Driver");	
		
		Connection conn = DriverManager.getConnection("jdbc:mysql://211.253.98.143:53306/mono_solutions", "mono_customer", "mono_customer1234qwer");
		
		Statement stmt = conn.createStatement();
		
		String phone2 = "0324407684";		

		/*String sql  ="INSERT INTO SMS_MSG(SUBJECT,PHONE,CALLBACK,STATUS,REQDATE,MSG,ID)";
				sql += "VALUES('(제목없음)','"+hp+"','"+phone2+"','0',concat(date_format(now(),'%Y%m%d%H%i%s')),'"+msg+"','INCHLMS1')";*/
		System.out.println("###############start"+" controller ::::: 패스워드변경###############");	
		String sql  ="INSERT INTO MONO_SOLUTIONS.CUSTOMER_SMS_SEND(USER_ID,SCHEDULE_TYPE,MSG_CONTENT,CALLING_NUM,PHONE_NUM,TEMPLATE_CD, RESERV_DTTM, REG_DTTM)";
		sql += "VALUES('INCHLMS1','0','"+msg+"','"+phone2+"','"+hp+"','UMS_2021090710482315796', NULL, date_format(now(),'%Y%m%d%H%i%s'))";
		 
		if(stmt.executeUpdate(sql) > 0) {
			indexService.setPassword(passwd, userno);
			model.addAttribute("result","Y");
		} else {
			model.addAttribute("result","N");
		}
		
		stmt.close();
		conn.close();
		
		return "/homepage/sendsms";		
	}
	
	@RequestMapping(value="/homepage/join.do", params="mode=rejoinupdateidpw")
	public String rejoinupdateidpw(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			, @RequestParam(value="id", required=false, defaultValue="") String id
			, @RequestParam(value="pw", required=false, defaultValue="") String pw
			, @RequestParam(value="resno", required=false, defaultValue="") String resno
			) throws Exception{
		
		indexService.setRejoin(id,pw,resno);
		
		return "/homepage/rejoinupdateidpw";		
	}
	
	
	@RequestMapping(value = "/homepage/join.do", params = "mode=sendpasswordsms")
	public String sendpassowrdsms(@ModelAttribute("cm") CommonMap cm, Model model,
			@RequestParam(value = "hp", required = false, defaultValue = "") String hp,
			@RequestParam(value = "username", required = false, defaultValue = "") String username) throws Exception {

		String userno = "";
		log.info("hp=   " + hp);
		log.info("username=   " + username);
		
		
		if (hp.indexOf("-") == 0) {
			userno = indexService.getPersonInfoByhp(username, hp);
		} else {
			hp = hp.replaceAll("-", "");
			userno = indexService.getPersonInfoByhp(username, hp);
		}		

		if (userno == null || userno.equals("null")) {
			model.addAttribute("result", "F");
			return "/homepage/sendsms";
		} else {
			
			// 여섯자리의 숫자로 이루어진 패스워드를 만드는 부분
			String passwd = "";
			int temporaryPassword = 0;
			for (int i = 0; i < 6; i++) {
				temporaryPassword += (int) (Math.random() * 10) * (int) (Math.pow(10, i));
			}
			passwd = "hrd" + temporaryPassword;

			String msg = "[인천인재개발원] 임시패스워드 " + passwd + " 입니다.";

			Class.forName("com.mysql.jdbc.Driver");

			Connection conn = DriverManager.getConnection("jdbc:mysql://211.253.98.142:53306/mono_customer",
					"mono_customer", "mono_customer1234qwer");

			Statement stmt = conn.createStatement();

			String phone2 = "0324407684";

			String sql = "INSERT INTO SMS_MSG(SUBJECT,PHONE,CALLBACK,STATUS,REQDATE,MSG,ID)";
			sql += "VALUES('(제목없음)','" + hp + "','" + phone2 + "','0',concat(date_format(now(),'%Y%m%d%H%i%s')),'" + msg
					+ "','INCHLMS1')";

			// int errorCode = indexService.sendSms(hp, msg);

			if (stmt.executeUpdate(sql) > 0) {
				indexService.setPassword(passwd, userno);
				model.addAttribute("result", "Y");
			} else {
				model.addAttribute("result", "N");
			}

			stmt.close();
			conn.close();

			return "/homepage/sendsms";
		}
	}
	
	
}
