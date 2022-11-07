package ut.lib.mail;

import java.io.*;
import java.util.*;
import javax.mail.*;
import javax.servlet.*;
import javax.activation.*;
import javax.servlet.http.*;
import javax.mail.internet.*;


public class WebSendMail {

	public void sendMail(HashMap mailData) throws MessagingException {

		System.setProperty("mail.smtp.host", "127.0.0.1");

		Message msg = new MimeMessage(
		                  Session.getDefaultInstance(
		                  System.getProperties(),null));
		msg.setFrom(new InternetAddress(ut.lib.util.Constants.EMAIL_SENDER));
		InternetAddress[] tos = InternetAddress.parse((String)mailData.get("to"));
		msg.setRecipients(Message.RecipientType.TO,tos);

		if(mailData.get("cc") != null) {
			InternetAddress[] ccs = InternetAddress.parse((String)mailData.get("cc"));
			msg.setRecipients(Message.RecipientType.CC,ccs);
		}

		msg.setSubject((String)mailData.get("subject"));
		msg.setSentDate(new Date());

		if(null == mailData.get("attachment"))
			msg.setText((String)mailData.get("body"));
		else {
			BodyPart body = new MimeBodyPart();
			BodyPart attachment = (BodyPart)mailData.get("attachment");
			body.setText((String)mailData.get("body"));
			MimeMultipart multipart = new MimeMultipart();
			multipart.addBodyPart(body);
			multipart.addBodyPart(attachment);
			msg.setContent(multipart);
		}

		System.out.println("Mail Host =["+ "127.0.0.1" + "]");
		System.out.println("Mail Sender =["+ ut.lib.util.Constants.EMAIL_SENDER + "]");
		System.out.println("Mail Receiver =["+ (String)mailData.get("to") + "]");
		System.out.println("Mail Subject =["+ (String)mailData.get("subject") + "]");
		System.out.println("Mail Content =["+ (String)mailData.get("body") + "]");

		Transport.send(msg);
	}

	public HashMap getMailData(HttpServletRequest request,
	                            HttpServletResponse response)
            throws IOException, ServletException, MessagingException {
		String boundary = request.getHeader("Content-Type");
		int pos = boundary.indexOf('=');
		boundary = boundary.substring(pos + 1);
		boundary = "--" + boundary;
		ServletInputStream in = request.getInputStream();
		byte[] bytes = new byte[512];
		int state = 0;
		ByteArrayOutputStream buffer = new ByteArrayOutputStream();
		String name = null, value = null,
		       filename = null, contentType = null;
		HashMap mailData = new HashMap();

		int i = in.readLine(bytes,0,512);
		while(-1 != i) {
			String st = new String(bytes, 0, i);
			if(st.startsWith(boundary)) {
				state = 0;
				if(null != name) {
					if(value != null)
						// -2 to remove CR/LF
						mailData.put(name, value.substring(0, value.length() - 2));
					else if(buffer.size() > 2) {
						MimeBodyPart bodyPart = new MimeBodyPart();
						DataSource ds = new ByteArrayDataSource(
							buffer.toByteArray(),
							contentType, filename);
						bodyPart.setDataHandler( new DataHandler(ds));
						bodyPart.setDisposition("attachment; filename=\"" + filename + "\"");
						bodyPart.setFileName(filename);
						mailData.put(name, bodyPart);
					}
					name = null;
					value = null;
					filename = null;
					contentType = null;
					buffer = new ByteArrayOutputStream();
				}
			} else if(st.startsWith("Content-Disposition: form-data") && state == 0) {
				StringTokenizer tokenizer = new StringTokenizer(st,";=\"");
				while(tokenizer.hasMoreTokens()) {
					String token = tokenizer.nextToken();
					if(token.startsWith(" name")) {
						name = tokenizer.nextToken();
						state = 2;
					} else if(token.startsWith(" filename")) {
						filename = tokenizer.nextToken();
						StringTokenizer ftokenizer = new StringTokenizer(filename,"\\/:");
						filename = ftokenizer.nextToken();
						while(ftokenizer.hasMoreTokens())
							filename = ftokenizer.nextToken();
						state = 1;
						break;
					}
				}
			} else if(st.startsWith("Content-Type") && state == 1) {
				pos = st.indexOf(":");
				// + 2 to remove the space
				// - 2 to remove CR/LF
				contentType = st.substring(pos + 2,st.length() - 2);
			} else if(st.equals("\r\n") && state == 1)
				state = 3;
			else if(st.equals("\r\n") && state == 2)
				state = 4;
			else if(state == 4)
				value = value == null ? st : value + st;
			else if(state == 3)
				buffer.write(bytes,0,i);
			i = in.readLine(bytes,0,512);
		}
		return mailData;
	}

}
