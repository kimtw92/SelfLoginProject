package ut.lib.mail;


import ut.lib.support.DataMap;

public abstract class Mail {
	public String mailType = null;;
	public String subject = null;
	public String from = null;
	public String fromName = null;
	public String[] name = null;
	public String[] to = null;

	private DataMap targetData = null;

	public MailSender sender = null;
	public MailForm mailForm = null;

	public Mail(DataMap targetData, String subject, String from, MailForm mailForm, String mailType) {
		this.targetData = targetData;
		this.subject = subject;
		this.from = from;
		this.mailForm = mailForm;
		this.mailType = mailType;
	}

	public Mail(DataMap targetData, String subject, String[] name, String mailType) {
		this.targetData = targetData;
		this.subject = subject;
		this.name = name;
		setFrom("recruit@amorepacific.com");
		setFromName("채용담당자");
		this.mailType = mailType;

		sender = new MailSender();
	}

	public Mail(DataMap targetData, String subject, String mailType) {
		this.targetData = targetData;
		this.subject = subject;
		setFrom("recruit@amorepacific.com");
		setFromName("채용담당자");
		this.mailType = mailType;

		sender = new MailSender();
	}

    /**
     * 메일폼 발송
     */
	public abstract void send() throws Exception;

	/** getter / setter **/
	public String getFrom() {
		return from;
	}

	public void setFrom(String from) {
		this.from = from;
	}

	public MailSender getSender() {
		return sender;
	}

	public void setSender(MailSender sender) {
		this.sender = sender;
	}

	public String getSubject() {
		return subject;
	}
	public void setSubject(String subject) {
		this.subject = subject;
	}

	public String[] getName() {
		return name;
	}


	public void setName(String[] name) {
		this.name = name;
	}

	public String getFromName() {
		return fromName;
	}

	public void setFromName(String fromName) {
		this.fromName = fromName;
	}

	public DataMap getTargetData() {
		return targetData;
	}

}
