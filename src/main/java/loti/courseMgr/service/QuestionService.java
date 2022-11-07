package loti.courseMgr.service;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

import loti.common.mapper.CommonMapper;
import loti.courseMgr.mapper.MailMapper;
import loti.courseMgr.mapper.MailSmsMapper;
import loti.courseMgr.mapper.QuestionMapper;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import ut.lib.exception.BizException;
import ut.lib.page.PageNavigation;
import ut.lib.support.DataMap;
import ut.lib.util.Constants;
import ut.lib.util.Message;
import ut.lib.util.StringReplace;
import ut.lib.util.Util;
import common.service.BaseService;

@Service
public class QuestionService extends BaseService {

	@Autowired
	private QuestionMapper questionMapper;
	@Autowired
	@Qualifier("courseMgrMailMapper")
	private MailMapper mailMapper;
	@Autowired
	private MailSmsMapper mailSmsMapper;
	@Autowired
	private CommonMapper commonMapper;
	
	/**
	 * 과정 질문 리스트.
	 */
	public DataMap selectGrSuggestionByHighList(String grcode, String grseq, DataMap pagingInfoMap) throws BizException{
		DataMap resultMap = new DataMap();
		Map<String, Object> paramMap = null;
        
        try {
        	//질문
        	String sqlWhere = "";
			if(grcode != "") {
				sqlWhere += "AND A.GRCODE = '" + grcode + "' ";
			}
			if(grseq != "" && grseq.length() == 4) {
				sqlWhere += "AND GRSEQ like '" + grseq + "%' ";
			} else if (grseq.length() > 4){
				sqlWhere += "AND GRSEQ = '" + grseq + "' ";
			}
			
			paramMap = new HashMap<String, Object>();
        	paramMap.put("sqlWhere", sqlWhere);
        	
        	int grSuggestionByHighListCount = questionMapper.selectGrSuggestionByHighListCount(paramMap);
        	
        	Map<String, Object> pageInfo = Util.getPageInfo(grSuggestionByHighListCount, pagingInfoMap);
        	pageInfo.put("sqlWhere", sqlWhere);
			
            resultMap = questionMapper.selectGrSuggestionByHighList(pageInfo);
            
            if(resultMap == null) resultMap = new DataMap();
            resultMap.setNullToInitialize(true);
            
            PageNavigation pageNavi = Util.getPageNavigation(pageInfo);
			
			resultMap.set("PAGE_INFO", pageNavi);
			
            //답변
            for(int i=0; i < resultMap.keySize("no"); i++){
            	paramMap = new HashMap<String, Object>();
            	paramMap.put("grcode", resultMap.getString("grcode", i));
            	paramMap.put("grseq", resultMap.getString("grseq", i));
            	paramMap.put("no", resultMap.getString("no", i));
            	
            	//답변 데이터.
            	resultMap.add("LOW_ROW_DATA", (DataMap)questionMapper.selectGrSuggestionByLowRow(paramMap));
            }               
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return resultMap;
	}
	
	/**
	 * 과정 질문 리스트 (시스템관리자홈 > 팝업)
	 */
	public DataMap selectQuestionPopup() throws BizException {
		DataMap resultMap = new DataMap();
        
        try {
            //질문
            resultMap = questionMapper.selectQuestionPopup();
            if(resultMap == null) resultMap = new DataMap();
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return resultMap;  
	}

	/**
	 * 과정 질문 내용 상세 보기.
	 */
	public DataMap selectGrSuggestionRow(String grcode, String grseq, int no, int depth) throws BizException{
		DataMap resultMap = new DataMap();
        
        try {
        	Map<String, Object> paramMap = new HashMap<String, Object>();
        	paramMap.put("grcode", grcode);
        	paramMap.put("grseq", grseq);
        	paramMap.put("no", no);
        	paramMap.put("depth", depth);
        			
        	resultMap = questionMapper.selectGrSuggestionRow(paramMap);
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return resultMap;  
		
	}
	
	/**
	 * 과정 질문 답변 내용 상세 정보.
	 */
	public DataMap selectGrSuggestionByLowRow(String grcode, String grseq, int no) throws BizException{
		DataMap resultMap = new DataMap();
        
        try {
        	Map<String, Object> paramMap = new HashMap<String, Object>();
        	paramMap.put("grcode", grcode);
        	paramMap.put("grseq", grseq);
        	paramMap.put("no", no);
        	
        	resultMap = questionMapper.selectGrSuggestionByLowRow(paramMap);
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return resultMap;  
		
	}
	
	/**
	 * 과정 질문  - 질문 내용 수정
	 */
	public int updateGrSuggestion(DataMap requestMap) throws BizException{
		int resultValue = 0;
        
        try {
        	resultValue = questionMapper.updateGrSuggestion(requestMap);
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return resultValue;
	}
	
	/**
	 * 과정 질문 답변등록.
	 */
	public int insertGrSuggestionByReply(DataMap requestMap) throws BizException{
		int resultValue = 0;
        Map<String, Object> paramMap = null;
        
        try {
            
            //답변 등록
            int no = questionMapper.selectGrSuggestionMaxNo(requestMap);
            paramMap = new HashMap<String, Object>();
            paramMap.put("grcode", requestMap.getString("grcode"));
			paramMap.put("grseq", requestMap.getString("grseq"));
			paramMap.put("no", no);
			paramMap.put("userno", requestMap.getString("userno"));
			paramMap.put("name", requestMap.getString("name"));
			paramMap.put("pno", requestMap.getInt("pno"));
			paramMap.put("title", requestMap.getString("title"));
			paramMap.put("groupFileNo", requestMap.getInt("groupFileNo"));
			paramMap.put("finishYn", requestMap.getString("finishYn"));
			paramMap.put("category", requestMap.getString("category"));
			paramMap.put("content", requestMap.getString("content"));
			
            resultValue = questionMapper.insertGrSuggestionByReply(paramMap);
            
            //답변여부 수정
            if(resultValue > 0 ){
            	questionMapper.updateGrSuggestionByReplySpec(requestMap);
            	
            	if(requestMap.getString("finishYn").equals("Y")){
                	//답변 등록시 메일 발송
                	
                    //String grcode = requestMap.getString("grcode");
                    String grseq = requestMap.getString("grseq");
                    
                    String message = "과정 " + StringReplace.subString(grseq, 4, 6) +"기 질문에 대한 답변이 등록되었습니다.";
                    
                    //질문자 정보
                    paramMap = new HashMap<String, Object>();
                    paramMap.put("grcode", requestMap.getString("grcode"));
        			paramMap.put("grseq", requestMap.getString("grseq"));
        			paramMap.put("no", requestMap.getInt("pno"));
                    DataMap userMap = questionMapper.selectMemberSimpleByQuestion(paramMap);
                    if(userMap == null) userMap = new DataMap();
                    userMap.setNullToInitialize(true);
                    	
                	if(!userMap.getString("userno").equals("") && !userMap.getString("hp").equals("--") && !userMap.getString("hp").equals("")){
                		
                    	DataMap smsMap = new DataMap();
                    	smsMap.setNullToInitialize(true);
                    	
                    	smsMap.setString("phone", userMap.getString("hp"));
                    	smsMap.setString("callback", Constants.SMS_CALLBACK);
                    	smsMap.setString("status", Constants.SMS_STATUS);
                    	
                    	String sendMsg = userMap.getString("grcodenm") + message.replaceAll("\\{name\\}", userMap.getString("name"));
                    	smsMap.setString("msg", sendMsg);
                    	smsMap.setString("compkey", Constants.SMS_COMPKEY);
                    	smsMap.setString("id", Constants.SMS_ID);
                    	
                    	mailSmsMapper.insertSmsMsg(smsMap); //sms테이블에 등록.
                	}
            	}
            }
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return resultValue;
	}
	
	/**
	 * 과정 질문 답변 수정.
	 */
	public int updateGrSuggestionByReply(DataMap requestMap) throws BizException{
		int resultValue = 0;
        
        try {
            
            //답변 등록
            resultValue = questionMapper.updateGrSuggestionByReply(requestMap);
            
            //답변여부 수정
            if(resultValue > 0 ){
            	questionMapper.updateGrSuggestionByReplySpec(requestMap);
            	
            	if(requestMap.getString("finishYn").equals("Y")){
                	//답변 등록시 메일 발송
                    String grcode = requestMap.getString("grcode");
                    String grseq = requestMap.getString("grseq");
                    
                    String message = "과정 " + StringReplace.subString(grseq, 4, 6) +"기 질문에 대한 답변이 등록되었습니다.";
                    
                    //질문자 정보
                    Map<String, Object> paramMap = new HashMap<String, Object>();
                    paramMap.put("grcode", grcode);
                    paramMap.put("grseq", grseq);
                    paramMap.put("no", requestMap.getInt("pno"));
                    
                    DataMap userMap = questionMapper.selectMemberSimpleByQuestion(paramMap);
                    if(userMap == null) userMap = new DataMap();
                    userMap.setNullToInitialize(true);
                    	
                	if(!userMap.getString("userno").equals("") && !userMap.getString("hp").equals("--") && !userMap.getString("hp").equals("")){
                    	DataMap smsMap = new DataMap();
                    	smsMap.setNullToInitialize(true);
                    	
                    	smsMap.setString("phone", userMap.getString("hp"));
                    	smsMap.setString("callback", Constants.SMS_CALLBACK);
                    	smsMap.setString("status", Constants.SMS_STATUS);
                    	
                    	String sendMsg = userMap.getString("grcodenm") + message.replaceAll("\\{name\\}", userMap.getString("name"));
                    	smsMap.setString("msg", sendMsg);
                    	smsMap.setString("compkey", Constants.SMS_COMPKEY);
                    	smsMap.setString("id", Constants.SMS_ID);
                    	
                    	mailSmsMapper.insertSmsMsg(smsMap); //sms테이블에 등록.
                	}
            	}
            }
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return resultValue;  
	}
	
	/**
	 * 과정질문방 질문/답변 삭제
	 */
	public int deleteGrSuggestion(DataMap requestMap) throws BizException{
		int resultValue = 0;
        
        try {
        	//첨부파일 삭제
            if(requestMap.getInt("groupfile_no") != -1) {
            	commonMapper.deleteUploadGroupFileNo(requestMap.getInt("groupfile_no"));
            }
            
            //질문 및 답변 삭제
            resultValue = questionMapper.deleteGrSuggestion(requestMap);
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return resultValue;  
	}
}
