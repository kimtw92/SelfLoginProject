package loti.courseMgr.web;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import loti.courseMgr.service.CourseSeqService;
import loti.courseMgr.service.MailService;

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
import common.controller.BaseController;

@Controller
public class MailController extends BaseController {

	@Autowired
	private MailService mailService;
	@Autowired
	private CourseSeqService courseSeqService;
	
	@ModelAttribute("cm")
	public CommonMap common(CommonMap cm
			              , Model model
			              , HttpServletRequest request
			              , HttpServletResponse response
			              , @RequestParam(value="mode", required=false, defaultValue="") String mode
			              , @RequestParam(value="menuId", required=false, defaultValue="") String menuId) throws BizException {
		
		try {
			DataMap requestMap = cm.getDataMap();
			requestMap.setNullToInitialize(true);
			
			if (mode.equals("")) {
				mode = "list";
				requestMap.setString("mode", mode);
			}
			
			//관리자 로그인 체크 (관리자 페이지에는 모두 있어야 함.)
			LoginInfo memberInfo = LoginCheck.adminCheck(request, response, menuId);
			if (memberInfo == null) {
				return null;
			}
			
			//공통 Comm Select Box 값 초기 셋팅.
			HttpSession session = request.getSession(); //세션
			if(requestMap.getString("commYear").equals(""))
				requestMap.setString("commYear", (String)session.getAttribute("sess_year"));
			if(requestMap.getString("commGrcode").equals(""))
				requestMap.setString("commGrcode", (String)session.getAttribute("sess_grcode"));
			if(requestMap.getString("commGrseq").equals(""))
				requestMap.setString("commGrseq", (String)session.getAttribute("sess_grseq"));
			
			model.addAttribute("REQUEST_DATA", requestMap);
			model.addAttribute("LOGIN_INFO", memberInfo);
		} catch (Exception e) {
			throw new BizException(e);
		} finally {
			
		}
		
		return cm;
	}
	
	/**
	 * 리스트
	 */
	@RequestMapping(value="/courseMgr/mail.do", params = "mode=list")
	public String list(@ModelAttribute("cm")CommonMap cm, Model model) throws BizException {
		DataMap requestMap = cm.getDataMap();
		requestMap.setNullToInitialize(true);
		
		//과정 정보
		DataMap rowMap = null;
		if(!requestMap.getString("commGrcode").equals(""))
			rowMap = mailService.selectGrcodeRow(requestMap.getString("commGrcode"));
		else
			rowMap = new DataMap();
		
		model.addAttribute("ROW_DATA", rowMap);
		
		return "/courseMgr/mail/courseMail";
	}
	
	/**
	 * SMS 발송
	 */
	@RequestMapping(value="/courseMgr/mail.do", params = "mode=sms_pop")
	public String sms_pop(@ModelAttribute("cm")CommonMap cm, Model model) throws BizException {
		DataMap requestMap = cm.getDataMap();
		requestMap.setNullToInitialize(true);
		
		String qu = requestMap.getString("qu");
		String grcode = requestMap.getString("grcode");
		String grseq = requestMap.getString("grseq");
		DataMap listMap = null;
		
		if(qu.equals("enter")) //입교대상자
			listMap = mailService.selectAppInfoEnterList(grcode, grseq, "Y");
		else if(qu.equals("noenter")) //미입교 대상자.
			listMap = mailService.selectAppInfoEnterList(grcode, grseq, "N");
		else if(qu.equals("success")) //수료자대상
			listMap = mailService.selectGrResultUserList(grcode, grseq, "Y");
		else if(qu.equals("fail")) //미수료자대상
			listMap = mailService.selectGrResultUserList(grcode, grseq, "N");
		else if(qu.equals("dept")) //기관담당자대상
			listMap = mailService.selectDeptManagerList(grcode, grseq);
		else if(qu.equals("tutor")) //강사대상
			listMap = mailService.selectClassTutorGrseqList(grcode, grseq);
		else if(qu.equals("notice")) //교육안내(입교자 대상)
			listMap = mailService.selectAppInfoEnterList(grcode, grseq, "Y");
		else if(qu.equals("rental"))
			listMap = null;
		else
			listMap = new DataMap();
		
		DataMap grseqMap = null;
		if(qu.equals("notice")) {
			Map<String, Object> paramMap = new HashMap<String, Object>();
			paramMap.put("grcode", grcode);
			paramMap.put("grseq", grseq);
			grseqMap = courseSeqService.selectGrseqSimpleRow(paramMap);
		} else
			grseqMap = new DataMap();
		
		model.addAttribute("LIST_DATA", listMap);
		model.addAttribute("GRSEQ_ROW_DATA", grseqMap);
		
		return "/courseMgr/mail/courseSMSPop";
	}
	
	/**
	 * SMS 발송
	 */
	@RequestMapping(value="/courseMgr/mail.do", params = "mode=sms_pop2")
	public String sms_pop2(@ModelAttribute("cm")CommonMap cm, Model model) throws BizException {
		DataMap requestMap = cm.getDataMap();
		requestMap.setNullToInitialize(true);
		
		String qu = requestMap.getString("qu");
		String userid = requestMap.getString("userid");
		DataMap listMap = null;
		
		if(qu.equals("updatePasswd")) {
			listMap = mailService.selectUserInfo(userid);
			String passwd = "";
			// 여섯자리의 숫자로 이루어진 패스워드를 만드는 부분
			int temporaryPassword = 0;
			for(int i=0; i<6; i++) {
				temporaryPassword += (int)(Math.random()*10) * (int)(Math.pow(10, i));
			}
			passwd = "hrd" + temporaryPassword;
			String txtMessage =  passwd ;	// SMS 내용 
			requestMap.setString("txtMessage", txtMessage);
			requestMap.setString("smsPhone", listMap.getString("hp", 0)); 
			requestMap.setString("name", listMap.getString("name", 0));
			requestMap.setString("userno", listMap.getString("userno", 0));
		} else {
			listMap = new DataMap();
		}
		
		DataMap grseqMap = null;
		grseqMap = new DataMap();
		model.addAttribute("LIST_DATA", listMap);
		model.addAttribute("GRSEQ_ROW_DATA", grseqMap);
		
		return "/courseMgr/mail/courseSMSPop2";
	}
	
	/**
	 * SMS 발송 실행.
	 */
	@RequestMapping(value="/courseMgr/mail.do", params = "mode=sms_exec")
	public String sms_exec(@ModelAttribute("cm")CommonMap cm, Model model) throws BizException {
		sms_exec_com(cm, model);
		
		return "/courseMgr/mail/courseSMSExecPop";
	}
	
	/**
	 * SMS 발송 실행.
	 */
	@RequestMapping(value="/courseMgr/mail.do", params = "mode=sms_exec3")
	public String sms_exec3(@ModelAttribute("cm")CommonMap cm, Model model) throws BizException {
		sms_exec_com(cm, model);
		
		return "/courseMgr/mail/courseSMSExecPop3";
	}
	
	/**
	 * 시설대여신청 승인시 신청자에게 SMS 발송
	 */
	@RequestMapping(value="/courseMgr/mail.do", params = "mode=sms_rsv_agreement")
	public String sms_rsv_agreement(@ModelAttribute("cm")CommonMap cm, Model model) throws BizException {
		sms_exec_com(cm, model);
		
		return "redirect:/courseMgr/reservation.do?mode=list&amp;menuId=1-5-2";
	}
	
	/**
	 * SMS 발송 실행.
	 */
	public void sms_exec_com(@ModelAttribute("cm")CommonMap cm, Model model) throws BizException {
		DataMap requestMap = cm.getDataMap();
		requestMap.setNullToInitialize(true);
		
		String qu = requestMap.getString("qu");
		
		if(qu.equals("enter") || qu.equals("noenter")){  //입교 및 미입교 대상자
			DataMap listMap = mailService.insertSmsMsgEnter(requestMap);
			if(listMap == null) listMap = new DataMap();
			
			model.addAttribute("LIST_DATA", listMap);
		}else if(qu.equals("success") || qu.equals("fail")){  //수료자 및 미수료 대상
			DataMap listMap = mailService.insertSmsMsgGrchk(requestMap);
			if(listMap == null) listMap = new DataMap();
			
			model.addAttribute("LIST_DATA", listMap);
		}else if(qu.equals("dept")){  //기관담당자대상
			DataMap listMap = mailService.insertSmsMsgDept(requestMap);
			if(listMap == null) listMap = new DataMap();
			
			model.addAttribute("LIST_DATA", listMap);
		}else if(qu.equals("tutor")){  //강사대상
			DataMap listMap = mailService.insertSmsMsgTutor(requestMap);
			if(listMap == null) listMap = new DataMap();
			
			model.addAttribute("LIST_DATA", listMap);
		}else if(qu.equals("notice")){  //교육안내(입교자 대상)
			DataMap listMap = mailService.insertSmsMsgEnter(requestMap);
			if(listMap == null) listMap = new DataMap();
			
			model.addAttribute("LIST_DATA", listMap);
		}else if(qu.equals("app_spec")){  		//수강신청 조회 승인 화면에서 선택된 메일 발송
			DataMap listMap = mailService.insertSmsMsgSpec(requestMap);
			if(listMap == null) listMap = new DataMap();
			
			model.addAttribute("LIST_DATA", listMap);
		} else if(qu.equals("app_spec3")){  		//수강신청 조회 승인 화면에서 선택된 메일 발송
			DataMap listMap = mailService.insertSmsMsgSpec2(requestMap);
			if(listMap == null) listMap = new DataMap();
			
			model.addAttribute("LIST_DATA", listMap);
		} else if(qu.equals("rsv_agreement")) {	// 시설대여신청 승인시 신청자에게 승인됨을 알림
			String txtMessage = "{name}님.시설대여 승인처리 되었으니 승인서 내용을 확인 하세요.[인천인재개발원] ";	// SMS 내용 
			requestMap.setString("txtMessage", txtMessage); 

			mailService.insertSmsMsgReservation(requestMap);
		} else if(qu.equals("updatePasswd")) {
			String passwd = requestMap.getString("txtMessage");
			requestMap.setString("passwd", passwd);
			//requestMap.setString("txtMessage", passwd + " 임시패스워드입니다. [인천인재개발원]");
			
			requestMap.setString("txtMessage", "[인천인재개발원]  임시패스워드는 " + passwd + "입니다. ");			
			
			requestMap.setString("smsPhone", requestMap.getString("smsPhone"));
			
			DataMap listMap = mailService.insertSmsMsgPasswd(requestMap);			
			if(listMap == null) listMap = new DataMap();
			
			model.addAttribute("LIST_DATA", listMap);
		} 
		
		//model.addAttribute("RESULT_MSG", msg);
	}
}
