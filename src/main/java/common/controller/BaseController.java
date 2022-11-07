package common.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;


public class BaseController {
	
	protected final Logger log = Logger.getLogger(getClass());

	/**
	 * 
	 * @param from
	 * @param to
	 * @param cc
	 * @param subject
	 * @param content
	 * @return
	 */
	public boolean sendEmail(String from, String[] to, String cc, String subject, String []content){
		boolean returnValue = false;
		int result = 0;
		for(int i=0;i<to.length;i++){
			result = sendEmailProc(from, to[i], cc, subject, content[i]);
		}
		if(result==1){
			returnValue=true;
		}
		return returnValue;
	}
	public boolean sendEmail(String from, String to, String cc, String subject, String content){
		boolean returnValue = false;
		int result = sendEmailProc(from, to, cc, subject, content);
		if(result==1){
			returnValue=true;
		}
		return returnValue;
	}
	public boolean sendEmail(String from, String[] to, String cc, String subject, String content){
		boolean returnValue = false;
		int result = 0;
		for(int i=0;i<to.length;i++){
			result = sendEmailProc(from, to[i], cc, subject, content);
		}
		if(result==1){
			returnValue=true;
		}
		return returnValue;
	}
	
	/**
	 * 메일 보내기 공통
	 * @param from
	 * @param to
	 * @param cc
	 * @param subject
	 * @param content
	 * @return
	 */
	public int sendEmailProc(String from, String to, String cc, String subject, String content){		

		/**
		try{
			Properties props = System.getProperties();

			props.put("mail.smtp.host", Constants.GLOBAL_SMTP); //메일서버
			Session mailSession = Session.getDefaultInstance(props, null);

			MimeMessage msg = new MimeMessage(mailSession);
			msg.setFrom(new InternetAddress(from));
			msg.setRecipients(MimeMessage.RecipientType.TO, InternetAddress.parse(to, false));
			if(!cc.trim().equals("")) {
				msg.setRecipients(MimeMessage.RecipientType.CC, InternetAddress.parse(cc, false));
			}
			
			msg.setSubject(subject);
			msg.setText(content);
			msg.setHeader("X-Mailer", "PSERANG");
			msg.setHeader("Content-type", "text/html; charset=euc-kr");
			msg.setSentDate(new Date());
			
			System.out.println("\n ************************** MAIL START ********************************");
			System.out.println("\n Mail Host =["+ Constants.GLOBAL_SMTP + "]");
			System.out.println("\n Mail from =["+ from + "]");
			System.out.println("\n Mail to =["+ to + "]");
			System.out.println("\n Mail cc =["+ cc + "]");
			System.out.println("\n Mail Subject =["+ subject + "]");
			System.out.println("\n Mail Content =["+ content + "]");
			System.out.println("\n ************************** MAIL END ******************************** \n");
			
			Transport.send(msg);

			return 1;
				 
		}catch(Exception e){
			e.printStackTrace();
			return 0;
		}
		
		*/
		return 0;
	}
	
	
	/**
	 * 공통으로 사용하는 로그아웃 처리 한다.
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	public boolean logout(HttpServletRequest request, HttpServletResponse response) throws Exception{
		
		boolean returnValue = false;
		try{
			
			//로그아웃 처리.
			HttpSession session = request.getSession();
			
			session.invalidate();
			
			/**
			session.removeAttribute("SES_USER_NO");
			session.removeAttribute("SES_USER_ID");
			session.removeAttribute("SES_USER_NAME");
			session.removeAttribute("SES_USER_NICK");
			session.removeAttribute("SES_USER_EMAIL");
			session.removeAttribute("SES_USER_MOBILE");
			session.removeAttribute("SES_USER_TEL");
			session.removeAttribute("SES_USER_AUTH");
			*/
			
			returnValue = true;
			 
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		return returnValue;
	}
}
