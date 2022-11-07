package ut.lib.mail;

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.util.Date;
import java.util.Properties;

import javax.activation.DataHandler;
import javax.activation.DataSource;
import javax.mail.Address;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Multipart;
import javax.mail.SendFailedException;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;

import ut.lib.support.DataMap;



/**
 * @author Administrator
 *
 * To change the template for this generated type comment go to
 * Window&gt;Preferences&gt;Java&gt;Code Generation&gt;Code and Comments
 */
public class MailSender {

	/**
	 *
	 * @uml.property name="mbp1"
	 * @uml.associationEnd
	 * @uml.property name="mbp1" multiplicity="(0 1)"
	 */
	private MimeBodyPart mbp1 = null;


	public MailSender() {
		mbp1 = new MimeBodyPart();
	}



	public void send(String to[ ],String from, String fromName, String subject, String msgText, String newsType) {

		boolean debug = false;

		Properties props = new Properties();

		//props.put("mail.smtp.host", Constants.SMTP);
		//props.remove("mail.smtp.host");
		props.put("mail.smtp.host", "10.129.30.121");

		// 메일을 보낼때 디버깅코드를 화면에 보여줄지를 세팅한다.
		if (debug)
			props.put("mail.debug", "true");

		//System.out.println(">>>>>>>>>>>>>" + Constants.SMTP + "//" + props.get("mail.smtp.host"));

		//Session session = Session.getDefaultInstance(props, null);
		Session session = Session.getInstance(props);

		session.setDebug(debug); // 해당 세션클래스의 디버깅 옵션을 argument값으로 설정한다.

		Properties props1 = session.getProperties();
		System.out.println("Mail Session Properties >>>>>>>>>>>>>" + props1);
		try {
			// create a message
			/**
			* MimeMessage는 Message를 extends받고 있으며 메일을 보낼때 필요한 핵심 메소드들을
			* abstract method 또는
			* general method형태로 가지고 있다.
			// MimeMessage객체를 생성하여 javax.mail.Message타입에 넣는다 */
			Message msg = new MimeMessage(session);

			try {
				msg.setFrom(new InternetAddress(from, fromName, "EUC-KR"));
			} catch (UnsupportedEncodingException e) {
				e.printStackTrace();
			}

			// 보낼 사람의 주소를 InternetAddress형태의 배열로 변환한다.
			//(수신자가 여러명될수 있으므로..);
			InternetAddress[] address = new InternetAddress[to.length];

			for(int i=0; i<to.length; i++)
				address[i] = new InternetAddress(to[i]);

			// 수신인을 Message에 세팅한다.
			msg.setRecipients(Message.RecipientType.TO, address);
			msg.setSubject(subject);
			msg.setSentDate(new Date());


			if(newsType != null) {
				Multipart mp = new MimeMultipart();

				if(newsType.equals("1")) 	setHtml(msgText);
				else	setText(msgText);

				mp.addBodyPart(mbp1);
				msg.setContent(mp);
			}

			// 메일발송
			Transport.send(msg);

		} catch (MessagingException mex) {

			System.out.println("\n--Exception ------------------------------");
			System.out.println(">>trace>>");
			mex.printStackTrace();
			System.out.println();
			System.out.println(mex);
			System.out.println();
			Exception ex = mex;

			do {
				if (ex instanceof SendFailedException) {
					SendFailedException sfex = (SendFailedException)ex;
					Address[] invalid = sfex.getInvalidAddresses();

					if (invalid != null) {
						System.out.println(" ** Invalid Addresses");

						if (invalid != null) {
							for (int i = 0; i < invalid.length; i++)
								System.out.println(" " + invalid[i]);
						}
					}

					Address[] validUnsent = sfex.getValidUnsentAddresses();

					if (validUnsent != null) {
						System.out.println(" ** ValidUnsent Addresses");

						if (validUnsent != null) {
							for (int i = 0; i < validUnsent.length; i++)
								System.out.println(" "+validUnsent[i]);
						}
					}

					Address[] validSent = sfex.getValidSentAddresses();

					if (validSent != null) {
						System.out.println(" ** ValidSent Addresses");

						if (validSent != null) {
							for (int i = 0; i < validSent.length; i++)
								System.out.println(" "+validSent[i]);
						}
					}
				}

				System.out.println();

				if (ex instanceof MessagingException)
					ex = ((MessagingException)ex).getNextException();
				else
					ex = null;

			} while (ex != null);
		}
	}

	/*
	 * 받는 사람이 여러명일경우 HTML 모드로 메일 보내기.
	 */
	public void send(String to[ ],String from, String fromName, String subject, String msgText) {
		send(to, from, fromName, subject, msgText, "1");
	}

	/*
	 * 받는 사람이 한명일 경우 HTML 모드로 메일 보내기.
	 */
	public void send(String to, String from, String fromName, String subject, String msgText) {
		String []to_ = new String[1];
		to_[0] = to;
		send(to_, from, fromName, subject, msgText);
	}

	public void send(DataMap sendMailData) {

		String fromEmail = sendMailData.getString("from");
		String fromName = sendMailData.getString("fromName");

		String[] toEmail = new String[sendMailData.keySize("to")];
		for (int i = 0; i < sendMailData.keySize("to"); i++) {
		    toEmail[i] = sendMailData.getString("to");
		}

		String subject = sendMailData.getString("subject");
		send(toEmail, fromName, fromEmail, subject, "");
	}


	protected void setText(String text) throws MessagingException{
		mbp1.setText(text,"euc-kr");
	}

	protected void setHtml(String html) throws MessagingException{
		try {
			mbp1.setDataHandler(new DataHandler(new ByteArrayDataSource(html, "text/html; charset=euc-kr")));
			mbp1.setHeader("Content-Transfer-Encoding", "7bit");
		} catch(MessagingException e) {
			throw e;
		}
	}

	class ByteArrayDataSource implements DataSource {
		private byte[] data;
		private String type;

		ByteArrayDataSource(InputStream is, String type) {
			this.type = type;
			try {
				ByteArrayOutputStream os = new ByteArrayOutputStream();
				int ch;

				while ((ch = is.read()) != -1)
					os.write(ch);

				data = os.toByteArray();
			} catch (IOException ioex) { }
		}

		ByteArrayDataSource(byte[] data, String type) {
			 this.data = data;
			 this.type = type;
		}

		ByteArrayDataSource(String data, String type) {
			try {
				this.data = data.getBytes("KSC5601");
			} catch (UnsupportedEncodingException uex) { }

			this.type = type;
		}

		public InputStream getInputStream() throws IOException {
			if (data == null)
				throw new IOException();
			return new ByteArrayInputStream(data);
		}

		public OutputStream getOutputStream() throws IOException {
			throw new IOException();
		}

		public String getContentType() {
			return type;
		}

		public String getName() {
			return "www.amorepacific.com";
		}
	}
}
