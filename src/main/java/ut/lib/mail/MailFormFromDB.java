package ut.lib.mail;



public class MailFormFromDB implements MailForm {

//	@Autowired
//	private MailMapper mailMapper;
	
	public String getMailForm(String mailFormGbn) throws Exception {
        String html = null;

//        try {

        	// Mail.xml 존재하지 않아서 변환하지 않음.
//            html = mailMapper.selectMailForm(mailFormGbn);

//        } catch (SQLException e) {
//            throw new BizException(Message.getKey(e), e);
//        } finally {
//        }
        return html;
	}

}
