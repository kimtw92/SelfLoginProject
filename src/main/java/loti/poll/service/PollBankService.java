package loti.poll.service;

import java.sql.SQLException;
import java.util.Map;

import loti.poll.mapper.CoursePollMapper;
import loti.poll.mapper.PollBankMapper;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import ut.lib.exception.BizException;
import ut.lib.page.PageNavigation;
import ut.lib.support.DataMap;
import ut.lib.util.Message;
import ut.lib.util.Util;

import common.service.BaseService;

@Service
public class PollBankService extends BaseService {
	
	@Autowired
	private PollBankMapper pollBankMapper;

	@Autowired
	private CoursePollMapper coursePollMapper;
	
	/**
	 * 설문 문항 리스트 (검색 )
	 * @param searchKey
	 * @param searchValue
	 * @param requestMap
	 * @return
	 * @throws Exception
	 */
	public DataMap selectGrinqBankQuestionBySearchDescList(String searchKey, String searchValue, DataMap requestMap) throws Exception{
		
        DataMap resultMap = null;
        
        try {
        	
            requestMap.setString("searchKey", searchKey);
            requestMap.setString("searchValue", searchValue);
            
	    	int totalCnt = pollBankMapper.selectGrinqBankQuestionBySearchDescListCount(requestMap);
        	
        	Map<String, Object> pageInfo = Util.getPageInfo(totalCnt, requestMap);
        	
        	requestMap.set("page", pageInfo);
        	
            resultMap = pollBankMapper.selectGrinqBankQuestionBySearchDescList(requestMap);
            
            PageNavigation pageNavi = Util.getPageNavigation(pageInfo);
		    resultMap.set("PAGE_INFO", pageNavi);
            
                                    
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return resultMap;  
		
	}
	
	
	/**
	 * 설문 문항 삭제.
	 * @param requestMap
	 * @return
	 * @throws Exception
	 */
	@Transactional
	public int deleteBankQuestion(DataMap requestMap) throws Exception{
		
        int resultValue = 0;
        
        try {
        	
            if( requestMap.keySize("chkQuestionNo[]") > 0 ){
            	
            	String whereStr = " AND QUESTION_NO IN (";
            	
            	for(int i=0; i < requestMap.keySize("chkQuestionNo[]"); i++){
            		if(i > 0) whereStr += ",";
            		whereStr += requestMap.getString("chkQuestionNo[]", i);
            	}
            	
            	whereStr += ") ";
            	DataMap qList = pollBankMapper.selectGrinqBankQuestionBySimpleList(whereStr); //삭제 할 문항 리스트
            	
            	for(int i=0; i < qList.keySize("questionNo"); i++){
            		
            		
            		if(qList.getInt("questionCheckedNo", i) > 0){ //관련 질문 참고 문항이 있다면 해당 문항 삭제.
            			
            			deleteBankQuestion(qList.getInt("questionCheckedNo", i));
            		}
            		
            		deleteBankQuestion(qList.getInt("questionNo", i));
            		
            		resultValue++;
            	}
            } //end if
            
            
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } catch (Exception e) {
            throw new BizException(e);
        } finally {
        }
        return resultValue;  
		
	}
	
	/**
	 * 설문 삭제.
	 * @param conn
	 * @return
	 * @throws Exception
	 */
	public int deleteBankQuestion(int questionNo) throws Exception{
		
        int resultValue = 0;
        
        try {

        	pollBankMapper.deleteGrinqBankSampByQuestionNo(questionNo); //보기 삭제
    		pollBankMapper.deleteGrinqBankQuestion(questionNo); //설문 삭제.
            
            
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } catch (Exception e) {
            throw new BizException(e);
        } finally {
        }
        
        return resultValue;  
		
	}
	
	/**
	 * 설문은행에 작성된 설문 항목 상세 정보 
	 * @param questionNo
	 * @return
	 * @throws Exception
	 */
	public DataMap selectGrinqBankQuestionByInSampRow(int questionNo) throws Exception{
		
        DataMap resultMap = null;
        
        try {
        	
            resultMap = coursePollMapper.selectGrinqBankQuestionRow(questionNo);
            if(resultMap == null) resultMap = new DataMap();
            
            //보기 리스트
            DataMap sampMap = pollBankMapper.selectGrinqBankSampList(questionNo);
            if(sampMap == null) sampMap = new DataMap();
            
            resultMap.add("BANK_SAMP_LIST", sampMap);
            
            DataMap prevQuestion = null;
            if(resultMap.getInt("questionCheckedNo") > 0){
            	
            	//관련 설문 정보
            	prevQuestion = coursePollMapper.selectGrinqBankQuestionRow(resultMap.getInt("questionCheckedNo"));
                if(prevQuestion == null) prevQuestion = new DataMap();
                prevQuestion.setNullToInitialize(true);
                
                DataMap prevQuestionSamp = new DataMap();
                if(prevQuestion.keySize("questionNo") > 0){
                	
                	//관련 설문의 보기 정보
                	prevQuestionSamp = pollBankMapper.selectGrinqBankSampList(prevQuestion.getInt("questionNo"));
                    if(prevQuestionSamp == null) prevQuestionSamp = new DataMap();
                    
                    prevQuestion.add("PREV_QUESTION_SAMP_LIST", prevQuestionSamp);
                }
                
            }else{
            	prevQuestion = new DataMap();
            }
            
            //관련 설문 담기.
            resultMap.add("PREV_QUESTION_ROW", prevQuestion);
                                    
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return resultMap;  
		
	}
	
	
	/**
	 * 설문 리스트( 현재QuestionNo 제외 , 보기 포함)
	 * @param questionNo
	 * @return
	 * @throws Exception
	 */
	@Transactional
	public DataMap selectGrinqBankQuestionByNoEqualsSampList(int questionNo) throws Exception{
		
        DataMap resultMap = null;
        
        try {
        	
            resultMap = pollBankMapper.selectNotPagingGrinqBankQuestionBySearchDescList(questionNo);
            if(resultMap == null) resultMap = new DataMap();
            
            for(int i=0; i < resultMap.keySize("questionNo"); i++){
            	
                //보기 리스트
                DataMap sampMap = pollBankMapper.selectGrinqBankSampList(resultMap.getInt("questionNo", i));
                if(sampMap == null) sampMap = new DataMap();
                
                resultMap.add("BANK_SAMP_LIST", sampMap);
                
            }
            
            
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return resultMap;  
		
	}
	
	/**
	 * 설문은행의 설문 등록
	 * @param requestMap
	 * @param sessUserNo
	 * @return
	 * @throws Exception
	 */
	@Transactional
	public int insertGrinqBankQuestion(DataMap requestMap, String sessUserNo) throws Exception{
		
        int resultValue = 0;
        
        try {
        	
            //등록할 questionNo
            int questionNo = pollBankMapper.selectGrinqBankQuestionMaxNo();	
            
            requestMap.setInt("questionNo", questionNo);
            requestMap.setString("luserno", sessUserNo);
            
            if(requestMap.getString("checkedNoDel").equals("Y")){ //관련 설문 삭제 체크시
            	requestMap.setString("questionCheckedNo", "0");
            	requestMap.setString("sampCheckedNo", "0");
            }
            if( !requestMap.getString("thisAnswerKind").equals("3") ){ //다중설문이 아닐경우 필수 정답갯수는  0 
            	requestMap.setString("checkboxCheckedNo", "0");
            }
            StringBuffer sbTmp = new StringBuffer();
            sbTmp.append("'").append(requestMap.getString("question")).append("'");
            requestMap.setString("question", sbTmp.toString());
            resultValue = pollBankMapper.insertGrinqBankQuestion(requestMap);
            
            //보기 등록.
            if(resultValue > 0){
            	
            	DataMap bankSamp = new DataMap();
            	bankSamp.setNullToInitialize(true);
            	
            	int sampCnt = requestMap.getInt("answerCnt");
            	
            	for(int i=0; i < sampCnt; i++){
            		
            		bankSamp.setInt("questionNo", questionNo);
            		bankSamp.setString("answer", requestMap.getString("lym"+(i+1)+"_answer"));
            		bankSamp.setString("answerKind", requestMap.getString("lym"+(i+1)+"_answerKind"));
            		bankSamp.setString("luserno", sessUserNo);
            		
            		pollBankMapper.insertGrqinqBankSamp(bankSamp); //설문은행의 보기 등록.
            	}
            }
            
            
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } catch (Exception e) {
            throw new BizException(e);
        } finally {
        }
        return resultValue;  
		
	}

	/**
	 * 설문 수정.
	 * @param requestMap
	 * @param sessUserNo
	 * @return
	 * @throws Exception
	 */
	public int updateGrinqBankQuestion(DataMap requestMap, String sessUserNo) throws Exception{
		
        int resultValue = 0;
        
        try {
        	
            //requestMap.setInt("questionNo", questionNo);
            requestMap.setString("luserno", sessUserNo);
            
            if(requestMap.getString("checkedNoDel").equals("Y")){ //관련 설문 삭제 체크시
            	requestMap.setInt("questionCheckedNo", 0);
            	requestMap.setInt("sampCheckedNo", 0);
            }
            StringBuffer sbTmp = new StringBuffer();
            sbTmp.append("'").append(requestMap.getString("question")).append("'");
            requestMap.setString("question", sbTmp.toString());
            resultValue = pollBankMapper.updateGrinqBankQuestion(requestMap);
            
            //보기 등록.
            if(resultValue > 0){
            	
            	int sampCnt = requestMap.getInt("answerCnt");
            	int questionNo = requestMap.getInt("questionNo");
            	
            	pollBankMapper.deleteGrinqBankSampByQuestionNo(questionNo); //보기 삭제
            	
            	DataMap bankSamp = new DataMap();
            	bankSamp.setNullToInitialize(true);

            	for(int i=0; i < sampCnt; i++){
            		
            		bankSamp.setInt("questionNo", questionNo);
            		bankSamp.setString("answer", requestMap.getString("lym"+(i+1)+"_answer"));
            		bankSamp.setString("answerKind", requestMap.getString("lym"+(i+1)+"_answerKind"));
            		bankSamp.setString("luserno", sessUserNo);
            		
            		pollBankMapper.insertGrqinqBankSamp(bankSamp); //설문은행의 보기 등록.
            	}
            }
            
            
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } catch (Exception e) {
            throw new BizException(e);
        } finally {
        }
        return resultValue;  
		
	}
	
}
