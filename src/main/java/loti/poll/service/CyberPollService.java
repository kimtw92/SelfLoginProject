package loti.poll.service;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

import loti.poll.mapper.CyberPollMapper;

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
public class CyberPollService extends BaseService {

	@Autowired
	private CyberPollMapper cyberPollMapper;
	
	/**
	 * CyberPoll관리 리스트
	 * 작성일 6월 23일
	 * 작성자 정윤철
	 * @param pagingInfoMap
	 * @return selectFaqList
	 * @throws Exception
	 */
	public DataMap selectCyberPollList(DataMap requestMap) throws Exception{
			
	    DataMap resultMap = null;
	    
	    //검색 조건이 있을시 where절을 만든다.
	    String where  = "";
	    try {
	    	
	    	int totalCnt = cyberPollMapper.selectCyberPollListCount(requestMap);
        	
        	Map<String, Object> pageInfo = Util.getPageInfo(totalCnt, requestMap);
        	
        	requestMap.set("page", pageInfo);
        	
            resultMap = cyberPollMapper.selectCyberPollList(requestMap);
            
            PageNavigation pageNavi = Util.getPageNavigation(pageInfo);
		    resultMap.set("PAGE_INFO", pageNavi);
	    	
	        
	    } catch (SQLException e) {
	        throw new BizException(Message.getKey(e), e);
	    } finally {
	    }
	    return resultMap;        
	}
	
	/**
	 * CyberPoll관리 설문 제목 데이터
	 * 작성일 6월 23일
	 * 작성자 정윤철
	 * @param pagingInfoMap
	 * @return selectFaqList
	 * @throws Exception
	 */
	public DataMap selectCyberPollTitleRow(int titleNo) throws Exception{
			
	    DataMap resultMap = null;
	    
	    try {
	    	
	        resultMap = cyberPollMapper.selectCyberPollTitleRow(titleNo);
	        
	    } catch (SQLException e) {
	        throw new BizException(Message.getKey(e), e);
	    } finally {
	    }
	    return resultMap;        
	}

	/**
	 * CyberPoll관리 상세데이터(미리보기)
	 * 작성일 6월 23일
	 * 작성자 정윤철
	 * @param pagingInfoMap
	 * @return selectFaqList
	 * @throws Exception
	 */
	public DataMap selectCyberPollInqSampRow(int titleNo, int questionNo) throws Exception{
			
	    DataMap resultMap = null;
	    
	    try {
	    	
	    	Map<String, Object> params = new HashMap<String, Object>();
	    	
	    	params.put("titleNo", titleNo);
	    	params.put("questionNo", questionNo);
	    	
	        resultMap = cyberPollMapper.selectCyberPollInqSampRow(params);
	        
	    } catch (SQLException e) {
	        throw new BizException(Message.getKey(e), e);
	    } finally {
	    }
	    return resultMap;        
	}	

	/**
	 * CyberPoll관리 상세데이터(미리보기)
	 * 작성일 6월 23일
	 * 작성자 정윤철
	 * @param pagingInfoMap
	 * @return selectFaqList
	 * @throws Exception
	 */
	public DataMap selectCyberPollQuestionNoRow(int titleNo) throws Exception{
			
	    DataMap resultMap = null;
	    
	    try {
	    	
	        resultMap = cyberPollMapper.selectCyberPollQuestionNoRow(titleNo);
	        
	    } catch (SQLException e) {
	        throw new BizException(Message.getKey(e), e);
	    } finally {
	    }
	    return resultMap;        
	}	
	
	/**
	 * CyberPoll관리 미리보기 응답률 데이터
	 * 작성일 6월 23일
	 * 작성자 정윤철
	 * @param pagingInfoMap
	 * @return selectFaqList
	 * @throws Exception
	 */
	public DataMap selectCyberPollCountRow(int titleNo, int questionNo) throws Exception{
			
	    DataMap resultMap = null;
	    
	    try {
	    	
	    	Map<String, Object> params = new HashMap<String, Object>();
	    	
	    	params.put("titleNo", titleNo);
	    	params.put("questionNo", questionNo);
	    	
	        resultMap = cyberPollMapper.selectCyberPollInqSampRow(params);
	        
	    } catch (SQLException e) {
	        throw new BizException(Message.getKey(e), e);
	    } finally {
	    }
	    return resultMap;        
	}		

	/**
	 * CyberPoll관리 질문 리스트
	 * 작성일 6월 23일
	 * 작성자 정윤철
	 * @param pagingInfoMap
	 * @return selectFaqList
	 * @throws Exception
	 */
	public DataMap selectCyberPollInqQustionList(int titleNo) throws Exception{
			
	    DataMap resultMap = null;
	    
	    try {
	    	
	        resultMap = cyberPollMapper.selectCyberPollInqQustionList(titleNo);
	         
	    } catch (SQLException e) {
	        throw new BizException(Message.getKey(e), e);
	    } finally {
	    }
	    return resultMap;        
	}
	
	/**
	 * CyberPoll관리 질문 리스트
	 * 작성일 6월 23일
	 * 작성자 정윤철
	 * @param pagingInfoMap
	 * @return selectFaqList
	 * @throws Exception
	 */
	public DataMap selectCyberPollInqQustionRow(int titleNo, int questionNo) throws Exception{
			
	    DataMap resultMap = null;
	    
	    try {
	    	
	    	Map<String, Object> params = new HashMap<String, Object>();
	    	
	    	params.put("titleNo", titleNo);
	    	params.put("questionNo", questionNo);
	    	
	        resultMap = cyberPollMapper.selectCyberPollInqQustionRow(params);
	         
	    } catch (SQLException e) {
	        throw new BizException(Message.getKey(e), e);
	    } finally {
	    }
	    return resultMap;        
	}	
	
	/**
	 * CyberPoll관리 제목등록실행
	 * 작성일 6월 23일
	 * 작성자 정윤철
	 * @param pagingInfoMap
	 * @return selectFaqList
	 * @throws Exception
	 */
	public int insertCyberPollTitleInfo(DataMap requestMap) throws Exception{
			
	    int returnValue = 0;
	    	
	    try {
	        /************************************설문 타이틀, 내용 등록[S]*********************************************/
	        //설문 타이틀 등록시 QUESTION테이블에 기본데이터를 입력한다 기본 TITLE_NO, QUESTINO_NO, QUESTION
	        //설문 타이틀 등록
	        //TABLE : TB_INQ_TTL
		    requestMap.setString("fullIstartDate", requestMap.getString("istartDate")+requestMap.getString("sdateHh")+requestMap.getString("sdateMm"));
		    requestMap.setString("fullIendDate", requestMap.getString("iendDate")+requestMap.getString("edateHh")+requestMap.getString("edateMm"));
	    	
	        returnValue = cyberPollMapper.insertCyberPollTitleInfo(requestMap);
	        
	        //설문 내용에 등록
	        //TABLE : TB_INQ_QUESTION
	        
	        //returnValue = cyberPollMapper.insertCyberPollQuestion(requestMap);
	        /************************************설문 타이틀, 내용 등록[E]*********************************************/
	        
	    } catch (SQLException e) {
	        throw new BizException(Message.getKey(e), e);
	    } finally {
        	returnValue = 1;
	    }
	    return returnValue;        
	}

	
	/**
	 * CyberPoll관리 질문, 항목 등록 실행
	 * 작성일 6월 23일
	 * 작성자 정윤철
	 * @param pagingInfoMap
	 * @return selectFaqList
	 * @throws Exception
	 */
	@Transactional
	public int modifyCyberPollQuestion(DataMap requestMap) throws Exception{
			
	    int returnValue = 0;
	    try {
//	    	requestMap.getInt("titleNo"), requestMap.getInt("questionNo")
	        returnValue = cyberPollMapper.selectAnswerNoCountRow(requestMap);
	        if(returnValue > 0){
	        	returnValue = 2;
	        	
	        }else{
		        //항목삭제
//	        	requestMap.getInt("titleNo"), requestMap.getInt("questionNo")
		        returnValue = cyberPollMapper.deleteSampRow(requestMap);
		        //질문삭제
//		        requestMap.getInt("titleNo"), requestMap.getInt("questionNo")
		        returnValue = cyberPollMapper.deleteQuestionRow(requestMap);
		        
		        //질문등록
		        returnValue = cyberPollMapper.insertCyberPollQuestion(requestMap);
		        //항목등록
		        if(!requestMap.getString("answerCnt").equals("")){
		        	Map<String, Object> params = new HashMap<String, Object>();
		        	params.put("titleNo", requestMap.getInt("titleNo"));
		        	params.put("questionNo", requestMap.getInt("questionNo"));
		        	for(int i=0; i < requestMap.getInt("answerCnt"); i++){
		        		params.put("answer", requestMap.getString("answer",i));
		        		params.put("answerKind", requestMap.getString("answerKind",i));
		        		params.put("answerNo", i+1);
		    	        //항목등록
		    	        returnValue = cyberPollMapper.insertSamp(params);	
		        	}
		        }
		        returnValue = 1;
	        }
	        
	    } catch (SQLException e) {
	        throw new BizException(Message.getKey(e), e);
	    } finally {
	    }
	    return returnValue;        
	}
	
	/**
	 * CyberPoll관리 질문, 항목 수정 실행
	 * 작성일 6월 23일
	 * 작성자 정윤철
	 * @param pagingInfoMap
	 * @return selectFaqList
	 * @throws Exception
	 */
	@Transactional
	public int insertCyberPollQuestion(DataMap requestMap) throws Exception{
			
	    int returnValue = 0;
	    int questionNo = 0;	
	    try {
	        
	        //questionNo값 구해오기
	        questionNo = cyberPollMapper.selectMaxQuestionRow();
	        
	        //구해온값을 셋시킨다. 기존 등록 메소드를 사용하기위해서 셋을 시킨다.
	        requestMap.setInt("questionNo", questionNo);
	        
	        //질문 등록
	        returnValue = cyberPollMapper.insertCyberPollQuestion(requestMap);
	        
	        if(!requestMap.getString("answerCnt").equals("")){
	        	Map<String, Object> params = new HashMap<String, Object>();
	        	params.put("titleNo", requestMap.getInt("titleNo"));
	        	params.put("questionNo", requestMap.getInt("questionNo"));
	        	//보기갯수가 있을경우 갯수만큼 등록 시작
	        	for(int i=0; i < requestMap.getInt("answerCnt"); i++){
	    	        //항목등록
	        		params.put("answer", requestMap.getString("answer",i));
	        		params.put("answerKind", requestMap.getString("answerKind",i));
	        		params.put("answerNo", i+1);
	    	        returnValue = cyberPollMapper.insertSamp(params);	
	        	}
	        }

	    } catch (SQLException e) {
	    	returnValue = 0;
	        throw new BizException(Message.getKey(e), e);
	    } finally {
        	returnValue = 1;
	    }
	    return returnValue;        
	}
	
	/**
	 * CyberPoll관리 타이틀 멕스 넘버
	 * 작성일 6월 23일
	 * 작성자 정윤철
	 * @param pagingInfoMap
	 * @return selectFaqList
	 * @throws Exception
	 */
	public int selectCyberPollMaxTitleNo() throws Exception{
			
	    int returnValue = 0;
	    	
	    try {
	        
	        returnValue = cyberPollMapper.selectCyberPollMaxTitleNo();
	        
	    } catch (SQLException e) {
	        throw new BizException(Message.getKey(e), e);
	    } finally {
	    }
	    return returnValue;        
	}

	/**
	 * CyberPoll관리 타이틀 멕스 넘버
	 * 작성일 6월 23일
	 * 작성자 정윤철
	 * @param pagingInfoMap
	 * @return selectFaqList
	 * @throws Exception
	 */
	public int selectCyberPollMaxQuestionNo(int titleNo) throws Exception{
		
	    int returnValue = 0;
	    try {

	        returnValue = cyberPollMapper.selectCyberPollMaxQuestionNo(titleNo);
	        
	    } catch (SQLException e) {
	        throw new BizException(Message.getKey(e), e);
	    } finally {
	    }
	    return returnValue;        
	}
	
	/**
	 * CyberPoll관리 수정실행
	 * 작성일 6월 23일
	 * 작성자 정윤철
	 * @param pagingInfoMap
	 * @return selectFaqList
	 * @throws Exception
	 */
	public int modifyCyberPollTitleInfo(DataMap requestMap) throws Exception{
			
	    int returnValue = 0;
	    
	    try {
	    	
		    requestMap.setString("fullIstartDate", requestMap.getString("istartDate")+requestMap.getString("sdateHh")+requestMap.getString("sdateMm"));
		    requestMap.setString("fullIendDate", requestMap.getString("iendDate")+requestMap.getString("edateHh")+requestMap.getString("edateMm"));
		    
	        returnValue = cyberPollMapper.modifyCyberPollTitleInfo(requestMap);
	        
	    } catch (SQLException e) {
	        throw new BizException(Message.getKey(e), e);
	    } finally {
        	returnValue = 1;
	    }
	    return returnValue;        
	}
	/**
	 * CyberPoll관리 보기항목삭제
	 * 작성일 6월 23일
	 * 작성자 정윤철
	 * @param pagingInfoMap
	 * @return selectFaqList
	 * @throws Exception
	 */
	@Transactional
	public int deleteSampRow(DataMap requestMap) throws Exception{
			
	    int returnValue = 0;
	    
	    try {
	    	
	        returnValue = cyberPollMapper.selectAnswerNoCountRow(requestMap);
	        if(returnValue > 0){
	        	returnValue = 2;
	        }else{
		        //항목삭제
		        returnValue = cyberPollMapper.deleteSampRow(requestMap);
		        //질문삭제
		        returnValue = cyberPollMapper.deleteQuestionRow(requestMap);
	        }
	        
	    } catch (SQLException e) {
	        throw new BizException(Message.getKey(e), e);
	    } finally {
	    	returnValue = 1;
	    }
	    return returnValue;        
	}	

	/**
	 * CyberPoll관리제목 삭제
	 * 작성일 6월 23일
	 * 작성자 정윤철
	 * @param pagingInfoMap
	 * @return selectFaqList
	 * @throws Exception
	 */
	@Transactional
	public int deleteTtl(DataMap requestMap) throws Exception{
			
	    int returnValue = 0;
	    
	    try {
	    	
	        DataMap questionNo = cyberPollMapper.selectQuestionNo(requestMap.getInt("titleNo"));
	        
	        Map<String, Object> params = new HashMap<String, Object>();
	        params.put("titleNo", requestMap.getInt("titleNo"));
	        
	        for(int i=0; questionNo.keySize("questionNo") > i; i++){
	        	params.put("questionNo", questionNo.getInt("questionNo",i));
	        	returnValue += cyberPollMapper.selectAnswerNoCountRow(params);
	        	
	        }
	        	
	        if(returnValue > 0){
	        	returnValue = 2;	
	        	
	        }else{
	        	for(int i=0; questionNo.keySize("questionNo") > i; i++){
	        		params.put("questionNo", questionNo.getInt("questionNo",i));
	        		//항목삭제
			        returnValue = cyberPollMapper.deleteSampRow(params);
			        //질문삭제
			        returnValue = cyberPollMapper.deleteQuestionRow(params);
	        	}
	        	
		        //타이틀글 삭제
		        returnValue = cyberPollMapper.deleteTtl(requestMap.getInt("titleNo"));		        
	        }
	        
	    } catch (SQLException e) {
	        throw new BizException(Message.getKey(e), e);
	    } finally {
	    }
	    return returnValue;        
	}
	
	/**
	 * CyberPoll관리 미리보기, 프린트 형태
	 * 작성일 6월 23일
	 * 작성자 정윤철
	 * @param pagingInfoMap
	 * @return selectFaqList
	 * @throws Exception
	 */
	public DataMap selectPreviewPop(int titleNo) throws Exception{
			
	    DataMap resultMap = null;
	    try {
	    	
	        resultMap = cyberPollMapper.selectPreviewPop(titleNo);
	        
	    } catch (SQLException e) {
	        throw new BizException(Message.getKey(e), e);
	    } finally {
	    }
	    return resultMap;        
	}
	
	/**
	 * CyberPoll관리 팝업 타이틀 가져오기
	 * 작성일 6월 23일
	 * 작성자 정윤철
	 * @param pagingInfoMap
	 * @return selectFaqList
	 * @throws Exception
	 */
	public String selectSubTitleCyberRow(int titleNo) throws Exception{
			
	    String returnValue = "";
	    
	    try {
	    	
	        returnValue = cyberPollMapper.selectSubTitleCyberRow(titleNo);
	        
	    } catch (SQLException e) {
	        throw new BizException(Message.getKey(e), e);
	    } finally {
	    }
	    return returnValue;        
	}
	
	
	/**
	 * CyberPoll관리 미리보기, 프린트 형태
	 * 작성일 6월 23일
	 * 작성자 정윤철
	 * @param pagingInfoMap
	 * @return selectFaqList
	 * @throws Exception
	 */
	public DataMap selectHtmlPreviewPop(int titleNo) throws Exception{
			
	    DataMap resultMap = null;
	    try {
	    	
	        resultMap = cyberPollMapper.selectHtmlPreviewPop(titleNo);
	        
	    } catch (SQLException e) {
	        throw new BizException(Message.getKey(e), e);
	    } finally {
	    }
	    return resultMap;        
	}
	
	/**
	 * 설문답변등록
	 * 작성일 6월 23일
	 * 작성자 정윤철
	 * @param pagingInfoMap
	 * @return selectFaqList
	 * @throws Exception
	 */
	@Transactional
	public int resultInsert(DataMap requestMap) throws Exception{
			
	    int returnValue = 0;
	    	
	    try {
	        
	        int check = 0;
	        
	        /************************************설문 답변등록[s]*********************************************/
	        
	        Map<String,Object> params = new HashMap<String, Object>();
	        
	        params.put("titleNo", requestMap.getInt("titleNo"));
	        params.put("userNo", requestMap.getInt("userNo"));
	        
	        for(int i=0; requestMap.keySize("questionNo") > i; i++){
	        	
	        	params.put("questionNo", requestMap.getInt("questionNo",i));
//	        	requestMap.getInt("titleNo"), requestMap.getInt("questionNo",i), requestMap.getString("userNo")
	        	check = cyberPollMapper.selectResultCount(params);

	        	if(check <= 0){
	        		if(!requestMap.getString("answerNo_"+requestMap.getInt("questionNo"), 0).equals("") ){
	        			params.put("answerNo", requestMap.getInt("answerNo_"+requestMap.getInt("questionNo"), 0));
	        			params.put("answerText", requestMap.getString("answerTxt_"+i, 0));
		        		//엔서넘버의 값을 0번째로 한이유는 넘어온 값들을 같은 명의 배열로 담은게 아니라 엔서넘버명 그자체를 증감시켜서 가져오게 했기때문에 실제 데이터가 들어가 있는 값은 0번째가 된다.
//	        			requestMap.getInt("titleNo"), requestMap.getInt("questionNo",i), requestMap.getString("userNo"), requestMap.getInt("answerNo_"+requestMap.getInt("questionNo"), 0), requestMap.getString("answerTxt_"+i, 0)
			        	returnValue = cyberPollMapper.resultInsert(params);
	        		}
			        returnValue = 1;
		        }else{
		        	returnValue = 3;
		        }
	        }
	        /************************************설문 답변등록[e]*********************************************/

	    } catch (SQLException e) {
	        throw new BizException(Message.getKey(e), e);
	    } finally {
	    }
	    return returnValue;        
	}
	
	
	/**
	 * 답변카운터
	 * 작성일 6월 23일
	 * 작성자 정윤철
	 * @param pagingInfoMap
	 * @return selectFaqList
	 * @throws Exception
	 */
	public int selectAnswerNoCount(int titleNo, int questionNo, int ansNo) throws Exception{
			
	    int returnValue = 0;
	    try {
	    	
	    	Map<String, Object> params = new HashMap<String, Object>();
	    	
	    	params.put("titleNo", titleNo);
	    	params.put("questionNo", questionNo);
	    	params.put("ansNo", ansNo);
	    	
	        returnValue = cyberPollMapper.selectAnswerInNoCount(params);
	        
	    } catch (SQLException e) {
	        throw new BizException(Message.getKey(e), e);
	    } finally {
	    }
	    return returnValue;        
	}
	
	/**
	 * 문제 전체 답변 카운트
	 * 작성일 6월 23일
	 * 작성자 정윤철
	 * @param pagingInfoMap
	 * @return selectFaqList
	 * @throws Exception
	 */
	public int selectAnswerTotalNoCount(int titleNo, int questionNo) throws Exception{
			
	    int returnValue = 0;
	    try {
	    	
	    	Map<String, Object> params = new HashMap<String, Object>();
	    	
	    	params.put("titleNo", titleNo);
	    	params.put("questionNo", questionNo);
	    	
	        returnValue = cyberPollMapper.selectAnswerTotalNoCount(params);
	        
	    } catch (SQLException e) {
	        throw new BizException(Message.getKey(e), e);
	    } finally {
	    }
	    return returnValue;        
	}
}
