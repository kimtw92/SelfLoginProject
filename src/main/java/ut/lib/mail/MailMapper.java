package ut.lib.mail;



// Mail.xml 존재하지 않음
public interface MailMapper {

	/**
     * 게시물 목록을 리턴한다.
     * @param parameter data
     * @return 게시물 목록
     * @throws Exception
     */
//	public String selectMailForm(String mailGbn) throws Exception {
//		DataMap resultList = null;
//		PreparedStatement pstmt = null;
//		ResultSet rs = null;
//		String html = "";
//		try {
//
//		    String query = XmlQueryParser.getInstance().getSql("Mail.xml", "selectMailForm");
//
//			pstmt = createPreparedStatement(query);
//
//			pstmt.setString(1, mailGbn);
//
//			rs = pstmt.executeQuery();
//			resultList = RsConverter.toDataMap(rs);
//
//			html = resultList.getString("cnt");
//		} catch (SQLException e) {
//
//		    Log.error(this.getClass(), "[Exception in " + this.getClass().getName() + "]" + e.getMessage());
//			throw e;
//		} finally {
//			close(pstmt, rs);
//		}
//
//		return html;
//	}
}
