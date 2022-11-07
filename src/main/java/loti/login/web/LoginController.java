package loti.login.web;

import java.sql.SQLException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import loti.homeFront.mapper.IndexMapper;
import loti.homeFront.service.IndexService;
import loti.login.service.LoginService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import ut.lib.exception.BizException;
import ut.lib.support.CommonMap;
import ut.lib.support.DataMap;
import ut.lib.util.Functions;
import ut.lib.util.ListUtil;
import ut.lib.util.Util;
import common.controller.BaseController;
import egovframework.rte.psl.dataaccess.util.EgovMap;

@Controller
public class LoginController extends BaseController {

	@Autowired
	private LoginService loginService;

	@Autowired
	private IndexMapper indexMapper;

	@ModelAttribute("cm")
	public CommonMap common(CommonMap cm, Model model, HttpServletRequest request) throws Exception {

		log.debug("[ENDER DEBUG] : ================LoginACT");

		// 리퀘스트 정보를 담고있는 DataMap을 Attribute 에 추가
		request.setAttribute("REQUEST_DATA", cm.getDataMap());

		return cm;
	}

	public String findView(String mode, String defaultView) {
		if ("sso1".equals(mode)) {
			return "/homepage/index";
		}
		return defaultView;
	}

	public boolean isCheckAdminId(String userId, HttpServletRequest request) {
		// boolean isCheckAdminId = false;
		// if("adpower1!".equals(userId)) {
		// String accIp[] =
		// "211.253.98.18,211.253.98.34,101.201.1.44,101.201.1.59,101.201.1.60,101.201.1.62,152.99.42.153,152.99.42.152,152.99.42.149,152.99.42.145,152.99.42.148".split(",");
		// for(int i= 0; i < accIp.length; i++) {
		// if(getClientIpAddr(request).equals(accIp[i])) {
		// isCheckAdminId = true;
		// break;
		// } else {
		// isCheckAdminId = false;
		// }
		// }
		// } else {
		// isCheckAdminId = true;
		// }
		//
		// return isCheckAdminId;
		return true;
	}

	public static String getClientIpAddr(HttpServletRequest request) {
		String ip = request.getHeader("X-Forwarded-For");
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getHeader("Proxy-Client-IP");
		}
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getHeader("WL-Proxy-Client-IP");
		}
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getHeader("HTTP_CLIENT_IP");
		}
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getHeader("HTTP_X_FORWARDED_FOR");
		}
		if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
			ip = request.getRemoteAddr();
		}
		return ip;
	}

	/**
	 * 현재 권한의 Home 경로
	 * 
	 * @param currentAuth
	 * @return
	 */
	public String CurrentHomeUrl(HttpServletRequest request, String currentAuth) {
		String url = "/";
		int port = request.getServerPort();
		String serverName = request.getServerName();
		if (port == 443) {// 로그인 이후 https -> http
			port = 80;
		}
		/* serverName = serverName + ":"+port; */
		if (currentAuth.equals("8")) {

			url = "http://" + serverName + "/homepage/index.do?mode=homepage&ssl=Y";
			// url = "/homepage/index.do?mode=homepage";
			// url = "/index/sysAdminIndex.do?mode=sysAdmin";
		} else { // 시스템관리자
					// url = "/homepage/index.do?mode=homepage";
			url = "http://" + serverName + "/homepage/index.do?mode=homepage&cboAuth=8";
			//url = "http://" + serverName + "/index/sysAdminIndex.do?mode=sysAdmin";
					
			// url = "/index/sysAdminIndex.do?mode=sysAdmin";
		}
		/*
		 * if (currentAuth.equals("8")){ url =
		 * "/homepage/index.do?mode=homepage"; }else if
		 * (currentAuth.equals("0")){ //시스템관리자 url =
		 * "/index/sysAdminIndex.do?mode=sysAdmin"; }else if
		 * (currentAuth.equals("2")){ //과정운영자 url =
		 * "/index/sysAdminIndex.do?mode=sysAdmin"; }else if
		 * (currentAuth.equals("3")){ //기관담당자 url = "/index/deptAdminIndex.do";
		 * }else if (currentAuth.equals("5")){ //평가담당자 url =
		 * "/index/evalAdminIndex.do"; }else if (currentAuth.equals("A")){ //과정장
		 * url = "/index/tutorAdminIndex.do/"; }else if
		 * (currentAuth.equals("B")){ //홈페이지관리자 url =
		 * "/index/homepageAdminIndex.do"; }else if (currentAuth.equals("C")){
		 * //부서담당자 url = "/index/homepageAdminIndex.do"; }
		 * 
		 * else if (currentAuth.equals("7")){ //강사 url =
		 * "/index/tutorAdminIndex.do"; }
		 */
		return url;
	}

	@RequestMapping(value = "/homepage/login.do", params = "mode=login")
	public String login() {
		return "/homepage/index";

	}

	@RequestMapping(value = "/homepage/login.do", params = "mode=loginChk")
	public String loginChk(@ModelAttribute("cm") CommonMap cm, HttpServletRequest request)
			throws BizException, Exception {

		DataMap requestMap = cm.getDataMap();

		String msg = ""; // 결과 메세지
		String url = ""; // 결과 url
		String msgState = "";

		String userId = requestMap.getString("userId");
		String userno = "";

		boolean isCheckAdminId = isCheckAdminId(userId, request);

		if (isCheckAdminId) {

			String currentAuth = "";

			DataMap userMap = loginService.selectLoginChk(userId);
			userMap.setNullToInitialize(true);
			if (userMap.keySize("userno") > 0) {

				// 암호 체크
				int lgFailTotleCnt = 5;
				int lgfailcnt = (userMap.getInt("lgfailcnt") + 1);
				String inputPwd = requestMap.getString("pwd");
				String pwd = userMap.getString("pwd");

				// 2010.10.29 - woni82
				// 마스터 패스워드 변경
				// change master password
				/*
				 * if("qawsed23@#".equals(inputPwd) || inputPwd.equals(pwd)) {
				 */
				if ("plokijuh12!@".equals(inputPwd) || inputPwd.equals(pwd)) {
					// 인천교육원은 수퍼 암호
					// if("dlscjsrydbrdnjs".equals(inputPwd) ||
					// inputPwd.equals(pwd)) {
					if (!"Y".equals(userMap.get("deleteYn"))) {
						if (lgFailTotleCnt < lgfailcnt) {
							// msg = "패스워드를 " + lgFailTotleCnt + "회 잘못입력하셨습니다.
							// 계정 잠금 해제후 사용 가능합니다.";
							msg = "- 비밀번호 " + lgFailTotleCnt + "회 입력 오류 안내 - \\n\\n비밀번호를 " + lgFailTotleCnt
									+ "회 잘못 입력하셨습니다.\\n\\n 홈페이지 로그인을 원하실 경우 관리자에게 문의하시기 바랍니다.\\n\\n 연락처) 032-440-7684 (평일 09:00 ~ 18:00) ";
							url = "/";
							// msgState = "pwd";
							msgState = "pwdsms";

						} else {
							HttpSession session = request.getSession();
							session.setAttribute("sess_loginYn", "Y");
							String sess_no = Util.getValue(userMap.getString("userno"), "");
							session.setAttribute("sess_no", sess_no);
							session.setAttribute("sess_name", Util.getValue(userMap.getString("name"), ""));
							session.setAttribute("sess_userid", Util.getValue(userMap.getString("userId"), ""));
							session.setAttribute("sess_userhp", Util.getValue(userMap.getString("hp"), ""));
							session.setAttribute("sess_resno", Util.getValue(userMap.getString("resno"), ""));
							session.setAttribute("sess_ldapcode", Util.getValue(userMap.getString("ldapcode"), ""));
							session.setAttribute("sess_dapname", Util.getValue(userMap.getString("ldapname"), ""));
							session.setAttribute("sess_userdept", Util.getValue(userMap.getString("dept"), ""));
							session.setAttribute("sess_jik", Util.getValue(userMap.getString("jik"), ""));
							session.setAttribute("sess_email", Util.getValue(userMap.getString("email"), ""));

							String checkSSO = indexMapper.checkMemberSSOAgree(sess_no);
							session.setAttribute("sess_checkSSO", checkSSO);
							
							
							userno = userMap.getString("userno");

							currentAuth = "8";

							// 권한이 20 이면 8:교육생 아니면 7:강사
							String authority = Util.getValue(userMap.getString("authority"), "");
							if (authority == "20") {
								session.setAttribute("sess_class", "8");
							} else {
								session.setAttribute("sess_class", "7");
							}

							// 사용자에 등록된 모든 권한을 불러온다.
							// 관리자 권한이 있는지 체크한다. (가장 높은 권한을 디폴트로 한다.)
							DataMap authMap = loginService.selectAuthority(Util.getValue(Util.getValue(userMap.getString("userno", 0), "")));
							authMap.setNullToInitialize(true);

							String[][] strAuth = new String[authMap.keySize("gadmin") + 1][4];
							if (authMap.keySize("gadmin") > 0) {

								for (int i = 0; i < authMap.keySize("gadmin"); i++) {
									strAuth[i][0] = Util.getValue(authMap.getString("gadmin", i), "");
									strAuth[i][1] = Util.getValue(authMap.getString("gadminnm", i), "");
									strAuth[i][2] = Util.getValue(authMap.getString("dept", i), "");
									strAuth[i][3] = Util.getValue(authMap.getString("partcd", i), "");

									// 기관 관리자의 경우에는 Dept 코드를 세션에 저장한다.
									if (strAuth[i][0].equals("3") || strAuth[i][0].equals("C")
											|| strAuth[i][0].equals("D")) {
										session.setAttribute("sess_dept",
												Util.getValue(authMap.getString("dept", i), ""));
									}

								}

								if (authMap.size() > 0) {
									strAuth[strAuth.length - 1][0] = "8";
									strAuth[strAuth.length - 1][1] = "교육생";
									strAuth[strAuth.length - 1][2] = "";
									strAuth[strAuth.length - 1][3] = "";
								}

								session.setAttribute("sess_auth", strAuth);
								session.setAttribute("sess_class", Util.getValue(authMap.getString("gadmin", 0), ""));

								currentAuth = Util.getValue(authMap.getString("gadmin", 0), "8");
								session.setAttribute("sess_currentauth", currentAuth); // 현재
																						// 권한
								session.setAttribute("sess_adminyn", "Y"); // 관리자
																			// 여부
								session.setAttribute("sess_currentauthhome", CurrentHomeUrl(request, currentAuth)); // 현재권한의
																													// 홈경로.
								session.setAttribute("sess_gubun", "2"); // 진행과정
																			// 값=1,
																			// 전체과정=2
							}

							if (authMap.size() > 0) {
								strAuth[strAuth.length - 1][0] = "8";
								strAuth[strAuth.length - 1][1] = "교육생";
								strAuth[strAuth.length - 1][2] = "";
								strAuth[strAuth.length - 1][3] = "";
							}
							/***********************************************************************
							 * 카페를 위해 쿠키를 생성한다.
							 ***********************************************************************/
							// setcookie("CMLMS", $_SESSION['sess_no'], 0, "/",
							// $DOMAIN); /* expire in 1 hour */
							// Cookie cookie = new Cookie("CMLMS",
							// Util.getValue(userMap.getString("userno"), ""));
							// cookie.setDomain(Constants.URL);
							// cookie.setPath("/");
							// response.addCookie(cookie);

							/***********************************************************************
							 * ID저장 쿠키를 생성한다.
							 ***********************************************************************/
							// System.out.println("\n ###
							// System.currentTimeMillis() = " +
							// System.currentTimeMillis());
							// System.out.println("idsave = " +
							// requestMap.getString("idsave"));
							/*
							 * if (requestMap.getString("idsave").equals("on")){
							 * 
							 * //Util.setCookie(response, "cid",
							 * requestMap.getString("userId")); //Cookie
							 * cookieID = new Cookie("cid",
							 * requestMap.getString("userid"));
							 * //cookieID.setMaxAge(new
							 * Long(System.currentTimeMillis()).intValue() +
							 * 2592000); //cookieID.setPath("/");
							 * //response.addCookie(cookieID);
							 * //System.out.println("idsave = " +
							 * requestMap.getString("idsave"));
							 * 
							 * }else{ //Util.setCookie(response, "cid", "");
							 * 
							 * }
							 */

							loginService.updateLoginInfo(userMap.getString("userno"));
														
								msg = "정상";
								url = CurrentHomeUrl(request, currentAuth);
								msgState = "ok";
														
						}
					} else { // 탈퇴회원
						msg = userMap.get("deleteDate") + "에 회원탈퇴 하셨습니다. 문의사항이 있으시면 인재개발원(032-440-7684)으로 연락 바랍니다. ";
						url = "/";
						msgState = "id";
					}
				} else {
					if (lgFailTotleCnt >= lgfailcnt) {
						loginService.updateLoginFailInfo(userMap.getString("userno"), lgfailcnt);
						msg = "입력하신 정보를 다시 한번 확인 하시기 바랍니다. " + lgFailTotleCnt + "회 실패시 계정이 정지됩니다.";
						// msg = "패스워드를 " + lgfailcnt + "회 잘못입력하셨습니다.
						// "+lgFailTotleCnt+"회 실패시 계정이 정지됩니다.";
						url = "/";
						msgState = "pwd";

					} else {
						msg = "- 로그인 정보 " + lgFailTotleCnt + "회 입력 오류 안내 - \\n\\n 로그인 정보 " + lgFailTotleCnt
								+ "회 잘못 입력하셨습니다.\\n\\n 홈페이지 로그인을 원하실 경우 관리자에게 문의하시기 바랍니다.\\n\\n 연락처) 032-440-7684 (평일 09:00 ~ 18:00) ";
						url = "/";
						msgState = "pwdsms";
					}

				}
			} else {
				msg = "입력하신 정보를 다시 한번 확인 하시기 바랍니다.";
				url = "/";
				msgState = "id";
			}
		} else {
			msg = "권한이 허용된 IP가 아닙니다.";
			url = "/";
			msgState = "id";
		}

		request.setAttribute("RESULT_MSG", msg);
		request.setAttribute("RESULT_URL", url);
		request.setAttribute("RESULT_STATE", msgState);

		return "/login/loginProcess";
	}

	@RequestMapping(value = "/homepage/login.do", params = "mode=loginOut")
	public String loginOut(HttpServletRequest request, HttpServletResponse response) throws Exception {

		logout(request, response);

		request.setAttribute("RESULT_MSG", "로그아웃 되었습니다.");
		request.setAttribute("RESULT_URL", "/");
		request.setAttribute("RESULT_STATE", "logout");

		return "/login/loginProcess";
	}

	public void adminPageToUserPage(HttpSession session) {
		// 개인정보 변경, 쪽지선택, 기타 (관리자에서 사용자화면으로 이동)
		// 학생 권한으로 변경
		session.setAttribute("sess_currentauth", "8");
		session.setAttribute("sess_class", "8");
	}

	@RequestMapping(value = "/homepage/login.do", params = "mode=form")
	public String form(HttpSession session) {
		adminPageToUserPage(session);
		return "/homepage/index";
	}

	@RequestMapping(value = "/homepage/login.do", params = "mode=policy")
	public String policy(HttpSession session) {
		adminPageToUserPage(session);
		return "/commonInc/jsp/adminToUserRedirectPage";
	}

	@RequestMapping(value = "/homepage/login.do", params = "mode=eduinfo7-7")
	public String eduinfo77(HttpSession session) {
		adminPageToUserPage(session);
		return "/commonInc/jsp/adminToUserRedirectPage";
	}

	@RequestMapping(value = "/homepage/login.do", params = "mode=spam")
	public String spam(HttpSession session) {
		adminPageToUserPage(session);
		return "/commonInc/jsp/adminToUserRedirectPage";
	}

	@RequestMapping(value = "/homepage/login.do", params = "mode=worktel")
	public String worktel(HttpSession session) {
		adminPageToUserPage(session);
		return "/commonInc/jsp/adminToUserRedirectPage";
	}

	@RequestMapping(value = "/homepage/login.do", params = "mode=userInfoChange")
	public String userInfoChange(HttpSession session) {
		adminPageToUserPage(session);
		return "/commonInc/jsp/adminToUserRedirectPage";
	}

	@RequestMapping(value = "/homepage/login.do", params = "mode=userPaper")
	public String userPaper(HttpSession session) {
		adminPageToUserPage(session);
		return "/commonInc/jsp/adminToUserRedirectPage";
	}

	@RequestMapping(value = "/homepage/login.do", params = "mode=passwordNullCheckAjax")
	public String passwordNullCheckAjax(HttpServletRequest request) throws BizException {

		String result = loginService.checkPasswordIsNull(request.getParameter("id"));
		request.setAttribute("passwordisnull", result);

		// 2010.10.29 - woni82
		// 마스터 패스워드 변경
		// change master password
		if ("#tkdlqj#dlswo5*".equals(request.getParameter("pw"))) {
			// if("dlscjsrydbrdnjs".equals(request.getParameter("pw"))) {
			request.setAttribute("passwordisnull", "super");
		} else {
			request.setAttribute("passwordisnull", result);
		}

		return "/login/passwordNullCheckAjax";
	}

	@RequestMapping(value = "/homepage/login.do", params = "mode=setpasswordstep1")
	public String setpasswordstep1() throws BizException {
		return "/login/setpasswordstep1";
	}

	@RequestMapping(value = "/homepage/login.do", params = "mode=setpasswordstep2")
	public String setpasswordstep2() throws BizException {
		return "/login/setpasswordstep2";
	}

	@RequestMapping(value = "/homepage/login.do", params = "mode=setpasswordstep3")
	public String setpasswordstep3() throws BizException {
		return "/login/setpasswordstep3";
	}

	@RequestMapping(value = "/homepage/login.do", params = "mode=checkPersonalInfoAjax")
	public String checkPersonalInfoAjax(HttpServletRequest request) throws BizException {

		String result = loginService.checkPersonalInfo(request.getParameter("id"), request.getParameter("email"));

		if (result.equals("1")) {
			// 존재하는 경우...sms에 insert 로직과, 세션에...잡아놓는것도 해야하구...
			HttpSession session = request.getSession();
			session.setAttribute("id", request.getParameter("id"));

			int smsNumber = (int) (Math.random() * 1000000) + 1;

			String stringsmsNumber = String.valueOf(smsNumber);

			if (stringsmsNumber.length() == 4) {
				stringsmsNumber = "00" + stringsmsNumber;
			} else if (stringsmsNumber.length() == 5) {
				stringsmsNumber = "0" + stringsmsNumber;
			}

			session.setAttribute("smsNumber", stringsmsNumber);

			System.out.println("인증번호는 -> [" + stringsmsNumber + "]");

			String msg = "[" + stringsmsNumber + "] 인증번호를 화면에 입력하세요. -인천인재개발원";
			loginService.sendSmsSetPassword(request.getParameter("hp"), msg);

		}

		request.setAttribute("id", request.getParameter("id"));
		request.setAttribute("result", result);

		return "/login/checkPersonalInfoAjax";
	}

	@RequestMapping(value = "/homepage/login.do", params = "mode=updatePasswordAjax")
	public String updatePasswordAjax(HttpServletRequest request) throws BizException {

		String pw = request.getParameter("pw");
		String id = request.getParameter("id");
		int i = loginService.openUpdatePassword(pw, id);

		request.setAttribute("resultnum", String.valueOf(i));

		// 패스워드 변경정보를 저장하는 로직...임시

		loginService.setPasswordLog(id, request.getRemoteAddr());

		return "/login/updatePasswordAjax";
	}

	@RequestMapping(value = "/homepage/login.do", params = "mode=sso")
	public String sso(@ModelAttribute("cm") CommonMap cm, HttpServletRequest request) throws BizException {

		// 1. 세션객체 생성
		HttpSession session = request.getSession();
		// 2. sess_regno값이 있는지 체크한다. 값이 없으면 메인 화면으로 보내 버린다.

		if (session.getAttribute("sess_resno") == null) {

		} else {
			String ssocurrentAuth = "";
			String ssomsg = ""; // 결과 메세지
			String ssourl = ""; // 결과 url
			String ssomsgState = "";

			String resno = "";

			if (request.getServerName().equals("loti.incheon.go.kr")) {
				resno = (String) session.getAttribute("sess_resno");

			} else {
				// resno = "8102011036612";
				resno = (String) session.getAttribute("sess_resno");
			}

			DataMap userMap = loginService.selectSSOLoginChk(resno);

			HttpSession ssosession = request.getSession();

			if (!"".equals(Util.getValue(userMap.getString("userno"), ""))) {
				ssosession.setAttribute("sess_loginYn", "Y");
				ssosession.setAttribute("sess_no", Util.getValue(userMap.getString("userno"), ""));
				ssosession.setAttribute("sess_name", Util.getValue(userMap.getString("name"), ""));
				ssosession.setAttribute("sess_userid", Util.getValue(userMap.getString("userId"), ""));
				ssosession.setAttribute("sess_userhp", Util.getValue(userMap.getString("hp"), ""));
				ssosession.setAttribute("sess_resno", Util.getValue(userMap.getString("resno"), ""));
				ssosession.setAttribute("sess_ldapcode", Util.getValue(userMap.getString("ldapcode"), ""));
				ssosession.setAttribute("sess_dapname", Util.getValue(userMap.getString("ldapname"), ""));
				ssosession.setAttribute("sess_userdept", Util.getValue(userMap.getString("dept"), ""));
				ssosession.setAttribute("sess_jik", Util.getValue(userMap.getString("jik"), ""));
				ssosession.setAttribute("sess_email", Util.getValue(userMap.getString("email"), ""));

				ssocurrentAuth = "8";

				// 권한이 20 이면 8:교육생 아니면 7:강사
				String authority = Util.getValue(userMap.getString("authority"), "");

				if (authority == "20") {
					ssosession.setAttribute("sess_class", "8");
				} else {
					ssosession.setAttribute("sess_class", "7");
				}

				// 사용자에 등록된 모든 권한을 불러온다.
				// 관리자 권한이 있는지 체크한다. (가장 높은 권한을 디폴트로 한다.)
				DataMap authMap = loginService.selectAuthority(Util.getValue(userMap.getString("userno", 0), ""));
				authMap.setNullToInitialize(true);

				String[][] strAuth = new String[authMap.keySize("gadmin") + 1][4];

				if (authMap.keySize("gadmin") > 0) {

					for (int i = 0; i < authMap.keySize("gadmin"); i++) {
						strAuth[i][0] = Util.getValue(authMap.getString("gadmin", i), "");
						strAuth[i][1] = Util.getValue(authMap.getString("gadminnm", i), "");
						strAuth[i][2] = Util.getValue(authMap.getString("dept", i), "");
						strAuth[i][3] = Util.getValue(authMap.getString("partcd", i), "");

						// 기관 관리자의 경우에는 Dept 코드를 세션에 저장한다.
						if (strAuth[i][0].equals("3")) {
							session.setAttribute("sess_dept", Util.getValue(authMap.getString("dept", i), ""));
						} else if (strAuth[i][0].equals("C")) {
							session.setAttribute("sess_partcd", Util.getValue(authMap.getString("partcd", i), ""));
						}

						// System.out.println(Util.getValue(authMap.getString("gadmin",
						// i)));
					}

					if (authMap.keySize("gadmin") > 0) {
						strAuth[strAuth.length - 1][0] = "8";
						strAuth[strAuth.length - 1][1] = "교육생";
						strAuth[strAuth.length - 1][2] = "";
						strAuth[strAuth.length - 1][3] = "";
					}

					session.setAttribute("sess_auth", strAuth);
					session.setAttribute("sess_class", Util.getValue(authMap.getString("gadmin", 0), ""));

					ssocurrentAuth = Util.getValue(authMap.getString("gadmin", 0), "8");
					session.setAttribute("sess_currentauth", ssocurrentAuth); // 현재
																				// 권한
					session.setAttribute("sess_adminyn", "Y"); // 관리자 여부
					session.setAttribute("sess_currentauthhome", CurrentHomeUrl(request, ssocurrentAuth)); // 현재권한의
																											// 홈경로.
					session.setAttribute("sess_gubun", "2"); // 진행과정 값=1, 전체과정=2
				}
			} else {
				cm.getDataMap().setString("mode", "sso1");
			}

			ssomsg = "정상";
			ssourl = CurrentHomeUrl(request, ssocurrentAuth);
			ssomsgState = "ok";

			request.setAttribute("RESULT_MSG", ssomsg);
			request.setAttribute("RESULT_URL", ssourl);
			request.setAttribute("RESULT_STATE", ssomsgState);
		}

		// 3. sess_regno값이 있으면 이것을 기준으로 tb_member 테이블에서 userno, name, userId, hp
		// 정보를 가져온다.
		// 4. 가져온 값을 가지고 세션값을 만들어준다. 이후 프로세스는 loginchk와 동일

		return findView(cm.getDataMap().getString("mode"), "/login/loginProcess");
	}

	@RequestMapping(value = "/homepage/login.do", params = "mode=sso1")
	public String sso1(@ModelAttribute("cm") CommonMap cm) throws BizException {
		return "/homepage/index";
	}

}
