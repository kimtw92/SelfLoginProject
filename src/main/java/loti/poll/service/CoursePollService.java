package loti.poll.service;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

import loti.courseMgr.mapper.CourseSeqMapper;
import loti.courseMgr.mapper.MailMapper;
import loti.courseMgr.mapper.MailSmsMapper;
import loti.poll.mapper.CoursePollMapper;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import ut.lib.exception.BizException;
import ut.lib.page.PageNavigation;
import ut.lib.support.DataMap;
import ut.lib.util.Constants;
import ut.lib.util.Message;
import ut.lib.util.Util;
import common.service.BaseService;

@Service
public class CoursePollService extends BaseService {
	
	@Autowired
	private CoursePollMapper coursePollMapper;
	
	@Autowired
	private CourseSeqMapper courseSeqMapper;
	
	@Autowired
	@Qualifier("courseMgrMailMapper")
	private MailMapper mailMapper;
	@Autowired
	private MailSmsMapper mailSmsMapper;

	/**
	 * 과정별 설문지 목록
	 * @param requestMap
	 * @param loginInfo
	 * @return
	 * @throws Exception
	 */
	public DataMap selectGrinqTtlBySearchList(String grcode, String grseq, DataMap requestMap) throws Exception{
		
        DataMap resultMap = null;
        
        try {
        	
            requestMap.setString("grcode", grcode);
            requestMap.setString("grseq", grseq);
            
            resultMap = coursePollMapper.selectGrinqTtlBySearchList(requestMap);
                                    																																		
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return resultMap;  
		
	}

	
	
	
	/**
	 * 과정 설문 미 응시자 목록
	 * @param grcode
	 * @param grseq
	 * @param titleNo
	 * @return
	 * @throws Exception
	 */
	public DataMap selectGrinqByNotApplyList(String grcode, String grseq, int titleNo) throws Exception{
		
        DataMap resultMap = null;
        
        try {
        	
        	Map<String , Object> params = new HashMap<String, Object>();
        	
        	params.put("grcode", grcode);
        	params.put("grseq", grseq);
        	params.put("titleNo", titleNo);
        	
            resultMap = coursePollMapper.selectGrinqByNotApplyList(params);
                                    
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return resultMap;  
		
	}
	
	/**
	 * 과정 설문의 응답자 수
	 * @param titleNo
	 * @return
	 * @throws Exception
	 */
	public int selectGrinqAnswerChk(int titleNo) throws Exception{
		
        int resultValue = 0;
        
        try {
        	
            resultValue = coursePollMapper.selectGrinqAnswerChk(titleNo);
                                    
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return resultValue;  
		
	}
	
	/**
	 * 과정 설문의 응답자 확인.
	 * @param titleNo
	 * @param setNo
	 * @param userNo
	 * @return
	 * @throws Exception
	 */
	public int selectGrinqAnswerBySetUserChk(int titleNo, int setNo, String userNo) throws Exception{
		
        int resultValue = 0;
        
        try {
        	
        	Map<String, Object> params = new HashMap<String, Object>();
        	
        	params.put("titleNo", titleNo);
        	params.put("setNo", setNo);
        	params.put("userNo", userNo);
        	
            resultValue = coursePollMapper.selectGrinqAnswerBySetUserChk(params);
                                    
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return resultValue;  
		
	}
	
	/**
	 * 과정 설문 삭제
	 * @param titleNo
	 * @return
	 * @throws Exception
	 */
	@Transactional
	public int deleteGrinqTtl(int titleNo) throws Exception{
		
        int resultValue = 0;
        
        try {
        	
            coursePollMapper.deleteGrinqSampSet(titleNo); //보기 셋트
            coursePollMapper.deleteGrinqQuestionSet(titleNo); //항목 셋트
            coursePollMapper.deleteGrinqTtl(titleNo); //과정 설문
                   
            resultValue++;
            
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return resultValue;  
		
	}
	
	/**
	 * 과정별 설문지 상세정보
	 * @param titleNo
	 * @return
	 * @throws Exception
	 */
	public DataMap selectGrinqTtlRow(int titleNo) throws Exception{
		
        DataMap resultMap = null;
        
        try {
        	
            resultMap = coursePollMapper.selectGrinqTtlRow(titleNo);
                                    
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return resultMap;  
		
	}
	
	/**
	 * 작성된 설문 세트 리스트
	 * @param titleNo
	 * @return
	 * @throws Exception
	 */
	public DataMap selectGrinqQuestionSetByTtlList(int titleNo) throws Exception{
		
        DataMap resultMap = null;
        
        try {
        	
            resultMap = coursePollMapper.selectGrinqQuestionSetByTtlList(titleNo);
                                    
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return resultMap;  
		
	}
	
	
	/**
	 * 일반과목 가져 오기 - 시간표 순서 연동
	 * @param grcode
	 * @param grseq
	 * @param titleNo
	 * @param whereStr
	 * @return
	 * @throws Exception
	 */
	public DataMap selectGrinqTtlByTimeTableSubjList(String grcode, String grseq, int titleNo) throws Exception{
		
        DataMap resultMap = null;
        
        try {
        	
            DataMap params = new DataMap();
            
            params.setString("grcode", grcode);
            params.setString("grseq", grseq);
            
            DataMap grseqMap = courseSeqMapper.selectGrSeqRow(params); //과정 기수 정보
            if(grseqMap == null) grseqMap = new DataMap();
            grseqMap.setNullToInitialize(true);
            
            grseqMap.putAll(params);
            
            grseqMap.setInt("titleNo", titleNo);
            
            //과목 정보
            resultMap = coursePollMapper.selectGrinqTtlByTimeTableSubjList(grseqMap);
                                    
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return resultMap;  
		
	}
	
	
	/**
	 * 설문은행에 작성된 설문 항목 목록
	 * @param questionGubun  필수, 공통, 과목
	 * @param questionCommGubun  공통 설문 구분
	 * @return
	 * @throws Exception
	 */
	public DataMap selectGrinqBankQuestionByGubunSearchList(String questionGubun, String questionCommGubun) throws Exception{
		
        DataMap resultMap = null;
        
        try {
        	
            Map<String, Object> params = new HashMap<String, Object>();
            
            params.put("questionGubun", questionGubun);
            params.put("questionCommGubun", questionCommGubun);
            
            //과목 정보
            resultMap = coursePollMapper.selectGrinqBankQuestionBySearchList(params);
                                    
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return resultMap;  
		
	}
	
	/**
	 * 과정 안내문 목록
	 * @param titleNo
	 * @return
	 * @throws Exception
	 */
	public DataMap selectGrinqGuideList(String searchKey, String searchValue, DataMap requestMap) throws Exception{
		
        DataMap resultMap = null;
        
        try {
        	
            requestMap.setString("searchKey", searchKey);
            requestMap.setString("searchValue", searchValue);
            
	    	int totalCnt = coursePollMapper.selectGrinqGuideListCount(requestMap);
        	
        	Map<String, Object> pageInfo = Util.getPageInfo(totalCnt, requestMap);
        	
        	requestMap.set("page", pageInfo);
        	
            resultMap = coursePollMapper.selectGrinqGuideList(requestMap);
            
            PageNavigation pageNavi = Util.getPageNavigation(pageInfo);
		    resultMap.set("PAGE_INFO", pageNavi);
            
                                    
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return resultMap;  
		
	}
	
	/**
	 * 과정 안내문 상세정보
	 * @param guideNo
	 * @return
	 * @throws Exception
	 */
	public DataMap selectGrinqGuideRow(int guideNo) throws Exception{
		
        DataMap resultMap = null;
        
        try {
        	
            resultMap = coursePollMapper.selectGrinqGuideRow(guideNo);
                                    
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return resultMap;  
		
	}
	
	
	/**
	 * 과정 안내문 삭제
	 * @param guideNo
	 * @return
	 * @throws Exception
	 */
	public int deleteGrinqGuide(int guideNo) throws Exception{
		
        int resultValue = 0;
        
        try {
        	
            resultValue = coursePollMapper.deleteGrinqGuide(guideNo); //삭제
                   
            resultValue++;
            
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return resultValue;  
		
	}
	
	
	/**
	 * 과정 안내문 등록
	 * @param requestMap
	 * @return
	 * @throws Exception
	 */
	public int insertGrinqGuide(DataMap requestMap) throws Exception{
		
        int resultValue = 0;
        
        try {
        	
            resultValue = coursePollMapper.insertGrinqGuide(requestMap);
                                 
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        
        return resultValue;  
		
	}
	
	/**
	 * 과정 안내문 수정
	 * @param requestMap
	 * @return
	 * @throws Exception
	 */
	public int updateGrinqGuide(DataMap requestMap) throws Exception{
		
        int resultValue = 0;
        
        try {
        	
            resultValue = coursePollMapper.updateGrinqGuide(requestMap);
            
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        
        return resultValue;  
		
	}
	
	
	
	/**
	 * 과정 안내문 Max Key
	 * @return
	 * @throws Exception
	 */
	public int selectGrinqGuideMaxKey() throws Exception{
		
        int returnValue = 0;
        
        try {
        	
            returnValue = coursePollMapper.selectGrinqGuideMaxKey();
                                    
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return returnValue;  
		
	}
	
	/**
	 * 설문 셑에 포함된 설문 문제 리스트
	 * @param titleNo
	 * @param setNo
	 * @return
	 * @throws Exception
	 */
	public DataMap selectGrinqQuestionSetByTutorSubjList(int titleNo, int setNo) throws Exception{
		
        DataMap resultMap = null;
        
        try {
        	
        	Map<String, Object> params = new HashMap<String, Object>();
        	
        	params.put("titleNo", titleNo);
        	params.put("setNo", setNo);
        	
            resultMap = coursePollMapper.selectGrinqQuestionSetByTutorSubjList(params);
                                    
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return resultMap;  
		
	}
	
	
	/**
	 * 설문 셑에 포함된 설문 문제의 응답 리스트
	 * @param titleNo
	 * @param setNo
	 * @return
	 * @throws Exception
	 */
	public DataMap selectGrinqQuestionSetByRequstList(int titleNo, int setNo) throws Exception{
		
        DataMap resultMap = null;
        
        try {
        	
        	Map<String, Object> params = new HashMap<String, Object>();
        	
        	params.put("titleNo", titleNo);
        	params.put("setNo", setNo);
        	
            resultMap = coursePollMapper.selectGrinqQuestionSetByRequstList(params);
                                    
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return resultMap;  
		
	}
	
	
	/**
	 * 과정 설문의 해당 셋트 응답자 확인. 
	 * @param titleNo
	 * @param setNo
	 * @return
	 * @throws Exception
	 */
	public int selectGrinqAnswerBySetChk(int titleNo, int setNo) throws Exception{
		
        int resultValue = 0;
        
        try {
        	
        	Map<String, Object> params = new HashMap<String, Object>();
        	
        	params.put("titleNo", titleNo);
        	params.put("setNo", setNo);
        	
            resultValue = coursePollMapper.selectGrinqAnswerBySetChk(params);
                                    
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return resultValue;  
		
	}
	
	
	/**
	 * 설문의 셋트 삭제.
	 * @param titleNo
	 * @param setNo
	 * @return
	 * @throws Exception
	 */
	@Transactional
	public int deleteGrinqQuestionSet(int titleNo, int setNo) throws Exception{
		
        int resultValue = 0;
        
        try {
            
        	Map<String, Object> params = new HashMap<String, Object>();
        	
        	params.put("titleNo", titleNo);
        	params.put("setNo", setNo);
        	
            coursePollMapper.deleteGrinqSampSetBySet(params); //보기 셋트
            coursePollMapper.deleteGrinqQuestionSetBySet(params); //항목 셋트
            
            resultValue++;
            
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return resultValue;  
		
	}
	
	
	/**
	 * 과정 설문의 등록
	 * @param requestMap
	 * @return
	 * @throws Exception
	 */
	@Transactional
	public int insertGrinqTtl(DataMap requestMap) throws Exception{
		
        int resultValue = 0;
        
        try {
        	
            int maxTitleNo = coursePollMapper.selectGrinqTtlByMaxTitleNo();
            int maxTitleSeq = coursePollMapper.selectGrinqTtlByMaxTitleSeq(requestMap);
            
            requestMap.setInt("titleNo", maxTitleNo);
            requestMap.setInt("titleSeq", maxTitleSeq);
            
            requestMap.setString("pStartPeriod", requestMap.getString("startPeriod") + requestMap.getString("startPeriodHh") + requestMap.getString("startPeriodMm"));
            requestMap.setString("pEndPeriod", requestMap.getString("endPeriod") + requestMap.getString("endPeriodHh") + requestMap.getString("endPeriodMm"));
            requestMap.setString("pStartDate", requestMap.getString("startDate") + requestMap.getString("startHh") + requestMap.getString("startMm"));
            requestMap.setString("pEndDate", requestMap.getString("endDate") + requestMap.getString("endHh") + requestMap.getString("endMm"));
            
            resultValue = coursePollMapper.insertGrinqTtl(requestMap);
            
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return resultValue;  
		
	}
	
	/**
	 * 과정 설문 수정
	 * @param requestMap
	 * @return
	 * @throws Exception
	 */
	@Transactional
	public int updateGrinqTtl(DataMap requestMap) throws Exception{
		
        int resultValue = 0;
        
        try {
        	
            if(!requestMap.getString("setOn").equals("on")) { //수정 일경우.
            	
            	requestMap.setString("fullStartPeriod", requestMap.getString("startPeriod") + requestMap.getString("startPeriodHh") + requestMap.getString("startPeriodMm"));
	            requestMap.setString("fullEndPeriod", requestMap.getString("endPeriod") + requestMap.getString("endPeriodHh") + requestMap.getString("endPeriodMm"));
	            requestMap.setString("fullIstartDate", requestMap.getString("startDate") + requestMap.getString("startHh") + requestMap.getString("startMm"));
	            requestMap.setString("fullIendDate", requestMap.getString("endDate") + requestMap.getString("endHh") + requestMap.getString("endMm"));
	            	
            	resultValue = coursePollMapper.updateGrinqTtl(requestMap);
            } else { //설문 세트 구성일경우.
            	
            	int titleNo = requestMap.getInt("titleNo");
            	
            		
        		String grcode = requestMap.getString("grcode");
        		String grseq = requestMap.getString("grseq");
        		String startPeriod = requestMap.getString("startPeriod");
        		String endPeriod = requestMap.getString("endPeriod");
        		
            	int setNo = coursePollMapper.selectGrinqQuestionSetMaxSetNo(titleNo);
            	
            	//필수 설문 항목  등록
            	if(!requestMap.getString("needAddedList").equals(""))
            		insertQeustionSetSpec(requestMap.getString("needAddedList"), titleNo, setNo, requestMap.getString("luserno"));
            	
            	//System.out.println("##2 commAddedList = " + requestMap.getString("commAddedList"));
            	
            	//공통 설문 항목  등록
            	if(!requestMap.getString("commAddedList").equals(""))
            		insertQeustionSetSpec(requestMap.getString("commAddedList"), titleNo, setNo, requestMap.getString("luserno"));
            	
            	//System.out.println("##3 subjAddedList = " + requestMap.getString("subjAddedList"));
            	
            	//과목 설문 항목  등록
            	if(!requestMap.getString("subjAddedList").equals("")){
            		
        			//과정 기수 정보.
        			DataMap simpleGrseq = coursePollMapper.selectGrseqBySimpleCyberRow(requestMap);
        			if(simpleGrseq == null) simpleGrseq = new DataMap();
        			simpleGrseq.setNullToInitialize(true);
        			
        			
        			//System.out.println("##4 commsubjAddedList = " + requestMap.getString("commsubjAddedList"));
        			
            		//일반과목
            		String[] commSubjArr = requestMap.getString("commsubjAddedList").split(",");
                	for(int i=0; i < commSubjArr.length; i++){
                		
                		System.out.println("\n ##subj " + commSubjArr[i]);
                		
                		String tmpSubj = commSubjArr[i].trim();
                		if(!tmpSubj.equals("")){
                			
                			requestMap.setString("tmpSubj", tmpSubj);
                			
                    		DataMap tutorList = null;
                    		if(!simpleGrseq.getString("fCyber").equals("Y"))
                    			tutorList = coursePollMapper.selectGrseqByClassTutorList(requestMap);
                    		else
                    			tutorList = coursePollMapper.selectGrseqByClassTutorCyberList(requestMap);
                    		
                    		if(tutorList == null) tutorList = new DataMap();
                    		tutorList.setNullToInitialize(true);
                    		
                    		
                    		if(tutorList.keySize("subj") > 0 ) //강사수만큼
                        		insertQeustionSetSpecSubj(requestMap.getString("subjAddedList"), titleNo, setNo, tutorList, requestMap.getString("luserno"));
                    		
                		}
                		
                	}
                	
                	//System.out.println("##5 selectAddedList = " + requestMap.getString("selectAddedList"));
                	
            		//선택 과목
            		String[] selSubjArr = requestMap.getString("selectAddedList").split(",");
                	for(int i=0; i < selSubjArr.length; i++){
                		
                		String tmpSubj = selSubjArr[i].trim();
                		if(!tmpSubj.equals("")){
                			
                			requestMap.setString("tmpSubj", tmpSubj);
                			
                    		DataMap tutorList = null;
                    		if(!simpleGrseq.getString("fCyber").equals("Y"))
                    			tutorList = coursePollMapper.selectGrseqByClassTutorList(requestMap);
                    		else
                    			tutorList = coursePollMapper.selectGrseqByClassTutorCyberList(requestMap);
                    		
                    		if(tutorList == null) tutorList = new DataMap();
                    		tutorList.setNullToInitialize(true);
                    		
                    		if(tutorList.keySize("subj") > 0 ) //강사수만큼
                        		insertQeustionSetSpecSubj(requestMap.getString("subjAddedList"), titleNo, setNo, tutorList, requestMap.getString("luserno"));
                    		
                		}
                		
                	} // end for
                	
            	}
            	
            	resultValue++;
            	
            }
            
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return resultValue;  
		
	}
	
	/**
	 * 
	 * @param conn
	 * @return
	 * @throws Exception
	 */
	public int insertQeustionSetSpec(String inputValue, int titleNo, int setNo, String sessUserNo) throws Exception{
		
        int resultValue = 0;
        
        try {
        	
        	String[] value = inputValue.split(",");
        	for(int i=0; i < value.length; i++){
        		
        		int bankQuestionNo = 0;
        		try{
        			bankQuestionNo = Integer.parseInt(value[i]);
        		}catch(Exception e){}
        		
        		if(bankQuestionNo > 0){
        			
        			//설문은행의 설문 정보
            		DataMap tmpBankQuestionMap = coursePollMapper.selectGrinqBankQuestionRow(bankQuestionNo);
            		if(tmpBankQuestionMap == null) tmpBankQuestionMap = new DataMap();
            		tmpBankQuestionMap.setNullToInitialize(true);
            		
            		String tmpQuestion = tmpBankQuestionMap.getString("question");
            		
            		DataMap setMap = new DataMap();
            		setMap.setNullToInitialize(true);
            		
            		setMap.setInt("titleNo", titleNo);
            		setMap.setInt("setNo", setNo);
            		
            		int tmpQuestionNo = coursePollMapper.selectGrinqQuestionSetByMaxQuestionNo(setMap); //등록될 SET Question No
            		
            		setMap.setInt("questionNo", tmpQuestionNo);
            		setMap.setString("question", tmpQuestion);
            		setMap.setString("wuserno", sessUserNo);
            		setMap.setString("tuserno", "");
            		setMap.setString("tsubj", "");
            		setMap.setInt("bankQuestionNo", bankQuestionNo);
            		
            		coursePollMapper.insertGrinqQuestionSetBySpecBank(setMap);
            		
            		//보기 있는지 확인후 있으면 등록
            		int tmpSampCnt = coursePollMapper.selectGrinqBankSampCount(bankQuestionNo); 
            		if(tmpSampCnt > 0){
            			//보기 등록
//            			titleNo, setNo, tmpQuestionNo, bankQuestionNo
            			coursePollMapper.insertGrinqSampSetBySpecBank(setMap);
            		}
        		}

        	}
        	
        	resultValue++;
                                    
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return resultValue;  
		
	}
	
	/**
	 * 
	 * @param conn
	 * @param inputValue
	 * @param titleNo
	 * @param setNo
	 * @param replaceMap
	 * @return
	 * @throws Exception
	 */
	public int insertQeustionSetSpecSubj(String inputValue, int titleNo, int setNo, DataMap replaceMap, String sessUserNo) throws Exception{
		
        int resultValue = 0;
        
        try {
        	
            //강사 수만큼 반복 
            for(int k=0; k < replaceMap.keySize("subj") ; k++){
            	
            	//필수 설문 항목  등록
            	String[] value = inputValue.split(",");
            	for(int i=0; i < value.length; i++){
            		
            		int bankQuestionNo = 0;
            		try{
            			bankQuestionNo = Integer.parseInt(value[i]);
            		}catch(Exception e){}
            		
            		if(bankQuestionNo > 0){
            			
            			//설문은행의 설문 정보
                		DataMap tmpBankQuestionMap = coursePollMapper.selectGrinqBankQuestionRow(bankQuestionNo);
                		if(tmpBankQuestionMap == null) tmpBankQuestionMap = new DataMap();
                		tmpBankQuestionMap.setNullToInitialize(true);
                		
                		String tmpQuestion = tmpBankQuestionMap.getString("question").replaceAll("\\$1", replaceMap.getString("subjnm", k));
                		String tuserno = "";
                		
                		if(tmpQuestion.indexOf("$2") > 0) {	
                			tmpQuestion = tmpQuestion.replaceAll("\\$2", replaceMap.getString("name", k));
                		}
                		
                		tuserno = replaceMap.getString("userno", k);
                		
                		DataMap setMap = new DataMap();
                		setMap.setNullToInitialize(true);
                		
                		setMap.setInt("titleNo", titleNo);
                		setMap.setInt("setNo", setNo);
                		
                		int tmpQuestionNo = coursePollMapper.selectGrinqQuestionSetByMaxQuestionNo(setMap); //등록될 SET Question No
                		
                		setMap.setInt("questionNo", tmpQuestionNo);
                		setMap.setString("question", tmpQuestion);
                		setMap.setString("wuserno", sessUserNo);
                		setMap.setString("tuserno", tuserno);
                		setMap.setString("tsubj", replaceMap.getString("subj", k));
                		setMap.setInt("bankQuestionNo", bankQuestionNo);
                		
                		coursePollMapper.insertGrinqQuestionSetBySpecBank(setMap);
                		
                		//보기 있는지 확인후 있으면 등록
                		int tmpSampCnt = coursePollMapper.selectGrinqBankSampCount(bankQuestionNo); 
                		if(tmpSampCnt > 0){
                			//보기 등록
                			coursePollMapper.insertGrinqSampSetBySpecBank(setMap);
                		}
            		}

            	}
            	
            }
            
        	resultValue++;
                                    
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
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
	public DataMap selectGrinqBankQuestionRow(int questionNo) throws Exception{
		
        DataMap resultMap = null;
        
        try {
        	
            resultMap = coursePollMapper.selectGrinqBankQuestionRow(questionNo);
                                    
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return resultMap;  
		
	}
	
	
	
	
	/**
	 * 과정설문관리 -> 미응시자 관리 리스트
	 * @return
	 * @throws Exception
	 */
	public DataMap selectNoneChkPollList(DataMap requestMap) throws Exception{
		
       DataMap resultMap = null;
        
        try {
        	
            resultMap = coursePollMapper.selectNoneChkPollList(requestMap);
                                    
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return resultMap;  
		
	}
	
	
	/**
	 * 과정설문관리 -> 미응시자 SMS 처리
	 * @return
	 * @throws Exception
	 */
	@Transactional
	public DataMap noneChkPollSmsExec(DataMap requestMap) throws Exception{
		
        DataMap resultMap = new DataMap();
        
        try {
        	
            //메시지
            String message = requestMap.getString("txtMessage");
            
            //유저 정보
            DataMap userInfoMap = null;
            	
            message = message.replaceAll("\\{grname\\}", coursePollMapper.selectGrcodenameRow(requestMap.getString("grcode")));
            
            for(int i=0; i < requestMap.keySize("userno[]"); i++){
            	
            	DataMap smsMap = new DataMap();
            	smsMap.setNullToInitialize(true);
            	
            	//미응시자 리스트
            	userInfoMap = coursePollMapper.selectUserNameRow(requestMap.getString("userno[]", i));
            	
            	if(!requestMap.getString("hp", i).equals("--") && !requestMap.getString("hp", i).equals("")) {
                  	
                	smsMap.setString("phone", userInfoMap.getString("hp"));                	
                	smsMap.setString("callback", Constants.SMS_CALLBACK);
                	smsMap.setString("status", Constants.SMS_STATUS);
                	
                	String sendMsg = message.replaceAll("\\{name\\}", userInfoMap.getString("name"));
                	smsMap.setString("msg", sendMsg);
                	smsMap.setString("compkey", Constants.SMS_COMPKEY);
                	smsMap.setString("id", Constants.SMS_ID);
                	
                	mailSmsMapper.insertSmsMsg(smsMap); //sms테이블에 등록.
                	
                	// 전송 메세지 담기
                	resultMap.addString("userno", requestMap.getString("userno[]", i)); 
                	resultMap.addString("name", userInfoMap.getString("name"));
                	
                	resultMap.addString("hp", userInfoMap.getString("hp"));
                	resultMap.addString("msg", sendMsg); //전송 메세지 담기
            	
            	}
            }
            
        }  catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return resultMap;
		
	}
	
	/**
	 * 과정 설문 세트의 설문 리스트 
	 * @param titleNo
	 * @param setNo
	 * @return
	 * @throws Exception
	 */
	public DataMap selectGrinqQuestionSetList(int titleNo, int setNo) throws Exception{
		
        DataMap resultMap = null;
        
        try {
        	
        	Map<String, Object> params = new HashMap<String, Object>();
        	
        	params.put("titleNo", titleNo);
        	params.put("setNo", setNo);
        	
            resultMap = coursePollMapper.selectGrinqQuestionSetList(params);
                                    
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return resultMap;  
		
	}
	
	/**
	 * 과정 설문 세트의 설문 리스트  (보기 포함)
	 * @param titleNo
	 * @param setNo
	 * @return
	 * @throws Exception
	 */
	@Transactional
	public DataMap selectGrinqQuestionSetByAddSampList(int titleNo, int setNo) throws Exception{
		
        DataMap resultMap = null;
        
        try {
        	
        	Map<String, Object> params = new HashMap<String, Object>();
        	
        	params.put("titleNo", titleNo);
        	params.put("setNo", setNo);
        	
            resultMap = coursePollMapper.selectGrinqQuestionSetList(params);
            if(resultMap == null) resultMap = new DataMap();
            resultMap.setNullToInitialize(true);
            
            for(int i=0; i < resultMap.keySize("questionNo"); i++){
            	
            	params.put("titleNo", resultMap.getInt("titleNo", i));
            	params.put("setNo", resultMap.getInt("setNo", i));
            	params.put("questionNo", resultMap.getInt("questionNo", i));
            	
            	DataMap sampMap = coursePollMapper.selectGrinqSampSetList(params);
            	if(sampMap == null) sampMap = new DataMap();
            	
            	resultMap.add("SAMP_LIST_DATA", sampMap); //보기 리스트 넣기.
            	
            	//이전 보기 일련번호
            	String prevAnswerNo = "0";
            	DataMap prevPollMap = null;
            	
            	DataMap prevMap = coursePollMapper.selectGrinqQuestionSetByQuestionCheckNoList(params);
            	if(prevMap == null) prevMap = new DataMap();
            	
            	//관련 참고설문이 있다면
            	if(prevMap.keySize("questionCheckedNo") > 0){
            		
            		//이전 설문 상세 정보 prevMap.getInt("titleNo", 0), prevMap.getInt("setNo", 0), prevMap.getInt("questionNo", 0)
            		prevPollMap = coursePollMapper.selectGrinqQuestionSetRow(prevMap);            		
                    if(prevPollMap == null) prevPollMap = new DataMap();
                    prevPollMap.setNullToInitialize(true);
                    prevAnswerNo = ""+prevPollMap.getInt("sampCheckedNo");
                    //이전 설문 보기 리스트  prevPollMap.getInt("titleNo"), resultMap.getInt("setNo"), resultMap.getInt("questionNo")
                    params.put("titleNo", prevPollMap.getInt("titleNo"));
                    params.put("setNo", resultMap.getInt("setNo"));
                    params.put("questionNo", resultMap.getInt("questionNo"));
                	DataMap prevSampMap = coursePollMapper.selectGrinqSampSetList(params);
                	if(prevSampMap == null) prevSampMap = new DataMap();
                    
                	prevPollMap.add("PREV_SAMP_LIST_DATA", prevSampMap); //보기 리스트 넣기.
            		
            	}else
            		prevPollMap = new DataMap();
            	
            	
            	resultMap.addString("prevAnswerNo", prevAnswerNo);
            	resultMap.add("PREV_POLL_LIST_DATA", prevPollMap); //이전 설문 정보
            	
            	
            }
                                    
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return resultMap;  
		
	}
	

	/**
	 * 과정 설문 세트의 설문 상세 정보 
	 * @param titleNo
	 * @param setNo
	 * @param questionNo
	 * @return
	 * @throws Exception
	 */
	public DataMap selectGrinqQuestionSetRow(int titleNo, int setNo, int questionNo) throws Exception{
		
        DataMap resultMap = null;
        
        try {
        	
        	Map<String, Object> params = new HashMap<String, Object>();
        	
        	params.put("titleNo", titleNo);
        	params.put("setNo", setNo);
        	params.put("questionNo", questionNo);
        	
            resultMap = coursePollMapper.selectGrinqQuestionSetRow(params);
                                    
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return resultMap;  
		
	}
	
	
	/**
	 * 설문 응답 등록
	 * @param requestMap
	 * @return
	 * @throws Exception
	 */
	@Transactional
	public int insertGrinqAnser(DataMap requestMap, DataMap questionMap, String sessUserNo) throws Exception{
		
        int resultValue = 0;
        
        try {
        	
            int titleNo = requestMap.getInt("titleNo");
            int setNo = requestMap.getInt("setNo");
            if(questionMap == null) questionMap = new DataMap();
            questionMap.setNullToInitialize(true);
            
            
            for(int i=0; i < questionMap.keySize("questionNo"); i++){
            	
            	String anwserNo = "";
            	String anwserStr = "";
            	
        		DataMap sampList = (DataMap)questionMap.get("SAMP_LIST_DATA", i);
        		if(sampList == null) sampList = new DataMap();
        		sampList.setNullToInitialize(true); 
        		
        		int qtype = 0;
        		for(int k=0; k < sampList.keySize("questionNo"); k++){
        			qtype = sampList.getInt("answerKind", k);
        		}
        		
            	if(qtype == 1){
            		anwserNo = requestMap.getString("poll_"+i);
            		anwserStr = "";
            	}else if(qtype == 2){
            		anwserNo = requestMap.getString("poll_"+i);
            		anwserStr = requestMap.getString("poll_"+i+"_text");
            		
            	}else if(qtype == 3){
            		anwserNo = "";
            		for(int j=0; j < requestMap.keySize("poll_"+i); j++){
            			if(j > 0) anwserStr+= ","; 
            			anwserStr = requestMap.getString("poll_"+i, j);
            		}
            	}else{
            		anwserNo = "";
            		anwserStr = requestMap.getString("poll_"+i+"_text");
            	}
            	
            	int questionNo = questionMap.getInt("questionNo", i);
            	
            	DataMap answerMap = new DataMap();
            	answerMap.setNullToInitialize(true);
            	
            	answerMap.setInt("titleNo", titleNo);
            	answerMap.setInt("setNo", setNo);
            	answerMap.setInt("questionNo", questionNo);
            	answerMap.setString("userno", sessUserNo);
            	answerMap.setString("ansNo", anwserNo);
            	answerMap.setString("answerTxt", anwserStr);
            	
            	coursePollMapper.insertGrinqAnswer(answerMap); //응답 등록.
            	
            	resultValue++;
            	
            	
        		//관련 설문 START
        		DataMap checkPoll = (DataMap)questionMap.get("PREV_POLL_LIST_DATA", i);
        		if(checkPoll == null) checkPoll = new DataMap();
        		checkPoll.setNullToInitialize(true);
        		
        		if( checkPoll.keySize("questionNo") > 0 ){
        			
        			for(int j=0; j < checkPoll.keySize("questionNo"); j++){ //관련 설문 정보의 수만큼 (1개가 들어오지만 혹시...)
        				
        				String prevAnwserNo = "";
        				String prevAnwserStr = "";
                		int prevQtype = 0;
                		
            			DataMap prevSamp = (DataMap)checkPoll.get("PREV_SAMP_LIST_DATA", i);
            			if(prevSamp == null) prevSamp = new DataMap();
            			prevSamp.setNullToInitialize(true);
            			
                		for(int k=0; k < prevSamp.keySize("questionNo"); k++) //관련설문의 보기 정보들의 타입 가져오기. 기존 PHP도 마지막값 사용.
                			prevQtype = prevSamp.getInt("answerKind", k);
                		
                    	if(prevQtype == 1){
                    		prevAnwserNo = requestMap.getString("poll_"+i+"_1");
                    		prevAnwserStr = "";
                    	}else if(prevQtype == 2){
                    		prevAnwserNo = requestMap.getString("poll_"+i);
                    		prevAnwserStr = requestMap.getString("poll_"+i+"_text_1");
                    	}else if(prevQtype == 3){
                    		prevAnwserNo = "";
                    		for(int jj=0; jj < requestMap.keySize("poll_"+i+"_1"); jj++){
                    			if(jj > 0) prevAnwserStr+= ","; 
                    			prevAnwserStr = requestMap.getString("poll_"+i+"_1", jj);
                    		}
                    	}else{
                    		prevAnwserNo = "";
                    		prevAnwserStr = requestMap.getString("poll_"+i+"_text_1");
                    	}
                		
        				//관련 설문 등록할 Map.
                    	DataMap prevAnswerMap = new DataMap();
                    	prevAnswerMap.setNullToInitialize(true);
                    	
                    	prevAnswerMap.setInt("titleNo", titleNo);
                    	prevAnswerMap.setInt("setNo", setNo);
                    	prevAnswerMap.setInt("questionNo", checkPoll.getInt("questionNo", j));
                    	prevAnswerMap.setString("userno", sessUserNo);
                    	prevAnswerMap.setString("ansNo", prevAnwserNo);
                    	prevAnswerMap.setString("answerTxt", prevAnwserStr);
                    	
                    	coursePollMapper.insertGrinqAnswer(prevAnswerMap); //관련 설문 등록.
                    	
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
	 * 과정 설문 세트의 설문 리스트  (보기 및 결과 포함)
	 * @param titleNo
	 * @param setNo
	 * @return
	 * @throws Exception
	 */
	@Transactional
	public DataMap selectGrinqQuestionSetByAddSampResultList(int titleNo, int setNo) throws Exception{
		
        DataMap resultMap = null;
        
        try {
        	
        	Map<String, Object> params = new HashMap<String, Object>();
        	
        	params.put("titleNo", titleNo);
        	params.put("setNo", setNo);
        	
            //설문 리스트 
            resultMap = coursePollMapper.selectGrinqQuestionSetList(params);
            if(resultMap == null) resultMap = new DataMap();
            resultMap.setNullToInitialize(true);
            
            for(int i=0; i < resultMap.keySize("questionNo"); i++){
            	
            	int questionNo = resultMap.getInt("questionNo", i);
            	
            	params.put("questionNo", questionNo);
            	
            	DataMap sampMap = coursePollMapper.selectGrinqSampSetList(params);
            	if(sampMap == null) sampMap = new DataMap();
            	sampMap.setNullToInitialize(true);
            	
            	int totalAnswerCnt = 0;
            	DataMap answerMap = new DataMap();
            	DataMap tmpMap = new DataMap();
            	for(int j=0; j < sampMap.keySize("questionNo"); j++){ //보기 리스트.
            		
            		if(sampMap.getInt("answerKind", j) == 4){ //주관식
            			
            			answerMap = coursePollMapper.selectGrinqAnswerByTxtList(params);
            			if(answerMap == null) answerMap = new DataMap();
            			
            			
            		}else if(sampMap.getInt("answerKind", j) != 3){ //단일 및 단일 + 주관
            			
            			if(j == 0) //전체 설문한 갯수  가져 오기(보기의 처음 것만
            				totalAnswerCnt = coursePollMapper.selectGrinqAnswerBySampTotalCnt(params);
            			
            			params.put("answerNo", sampMap.getInt("answerNo", j));
            			
            			//설문 결과 문항의 객관식 해당보기 선택한 인원
            			answerMap.addInt("answerCnt", coursePollMapper.selectGrinqAnswerBySampChioceCnt(params));

            		}else{ //checkBox
            			if(j == 0){
                			tmpMap = coursePollMapper.selectGrinqAnswerByTxtList(params);
                			if(tmpMap == null) answerMap = new DataMap();
                			tmpMap.setNullToInitialize(true);
                			
                			totalAnswerCnt = coursePollMapper.selectGrinqAnswerBySampTotalCnt(params); //전체
            			}

            			int tmpCnt = 0;
            			for(int jj=0; jj < tmpMap.keySize("questionNo"); jj++)
            				if( tmpMap.getString("answerTxt", jj).indexOf(sampMap.getString("answerNo", j)) > -1 )
            					tmpCnt++;
            			
            			answerMap.addInt("answerCnt", tmpCnt);
            			
            		}
            		
            	}
            	answerMap.setInt("totalAnswerCnt", totalAnswerCnt);
            	resultMap.add("SAMP_ANSWER_MAP_DATA", answerMap); //보기의 결과 정보.
            	resultMap.add("SAMP_LIST_DATA", sampMap); //보기 리스트 넣기.
            	
            	
            	
            	//이전 보기 일련번호
            	DataMap prevPollMap = null;
            	
            	params.put("titleNo", resultMap.getInt("titleNo", i));
            	params.put("setNo", resultMap.getInt("setNo", i));
            	params.put("questionNo", resultMap.getInt("questionNo", i));
//            	resultMap.getInt("titleNo", i), resultMap.getInt("setNo", i), resultMap.getInt("questionNo", i)
            	DataMap prevMap = coursePollMapper.selectGrinqQuestionSetByQuestionCheckNoList(params);
            	if(prevMap == null) prevMap = new DataMap();
            	prevMap.setNullToInitialize(true);
            	
            	//관련 참고설문이 있다면
            	if(prevMap.keySize("questionCheckedNo") > 0){
            		
            		//이전 설문 상세 정보 prevMap.getInt("titleNo", 0), prevMap.getInt("setNo", 0), prevMap.getInt("questionNo", 0)
            		prevPollMap = coursePollMapper.selectGrinqQuestionSetRow(prevMap);            		
                    if(prevPollMap == null) prevPollMap = new DataMap();
                    prevPollMap.setNullToInitialize(true);
                    
                	int questionNoPrev = prevPollMap.getInt("questionNo");
                	int titleNoPrev = prevPollMap.getInt("titleNo");
                	int setNoPrev = prevPollMap.getInt("setNo");
                	
                    //이전 설문 보기 리스트 
                	DataMap prevSampMap = coursePollMapper.selectGrinqSampSetList(prevPollMap);
                	if(prevSampMap == null) prevSampMap = new DataMap();
                	prevSampMap.setNullToInitialize(true);
                	
                	int totalAnswerCntPrev = 0;
                	DataMap answerMapPrev = new DataMap();
                	DataMap tmpMapPrev = new DataMap();
                	
                	DataMap prevPollMapTemp = (DataMap) prevPollMap.clone();
                	
                	for(int j=0; j < prevSampMap.keySize("questionNo"); j++){ //보기 리스트.
                		
                		if(prevSampMap.getInt("answerKind", j) == 4){ //주관식
                			
                			//주관식 사람들이 입력한 답한 모두 가져 오기.
                			answerMapPrev = coursePollMapper.selectGrinqAnswerByTxtList(prevPollMapTemp);
                			if(answerMapPrev == null) answerMapPrev = new DataMap();
                			
                		}else if(prevSampMap.getInt("answerKind", j) != 3){ //단일 및 단일 + 주관
                			
                			if(j == 0) //전체 설문한 갯수  가져 오기(보기의 처음 것만)
                				totalAnswerCntPrev = coursePollMapper.selectGrinqAnswerBySampTotalCnt(prevPollMapTemp);
                			
                			prevPollMapTemp.setInt("answerNo", prevSampMap.getInt("answerNo", j));
                			
                			//설문 결과 문항의 객관식 해당보기 선택한 인원
                			answerMapPrev.addInt("answerCnt", coursePollMapper.selectGrinqAnswerBySampChioceCnt(prevPollMapTemp));

                		}else{ //checkBox
                			
                			if(j == 0){ //처음 실행할때만 실행.
                				tmpMapPrev = coursePollMapper.selectGrinqAnswerByTxtList(prevPollMapTemp);
                    			if(tmpMapPrev == null) answerMapPrev = new DataMap();
                    			tmpMapPrev.setNullToInitialize(true);
                    			
                    			totalAnswerCntPrev = coursePollMapper.selectGrinqAnswerBySampTotalCnt(prevPollMapTemp); //전체
                			}

                			int tmpCnt = 0;
                			for(int jj=0; jj < tmpMapPrev.keySize("questionNo"); jj++)
                				if( tmpMapPrev.getString("answerTxt", jj).indexOf(prevSampMap.getString("answerNo", j)) > -1 )
                					tmpCnt++;
                			
                			answerMapPrev.addInt("answerCnt", tmpCnt);
                			
                		}
                		
                	}
                	
                	answerMapPrev.setInt("totalAnswerCnt", totalAnswerCntPrev);
                	prevPollMap.add("PREV_SAMP_ANSWER_MAP_DATA", answerMapPrev); //보기의 결과 정보.
                	prevPollMap.add("PREV_SAMP_LIST_DATA", prevSampMap); //보기 리스트 넣기.
            		
            	}else
            		prevPollMap = new DataMap();
            	
            	
            	resultMap.add("PREV_POLL_LIST_DATA", prevPollMap); //이전 설문 정보
            	
            	
            }
                                    
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return resultMap;  
		
	}
	
	/**
	 * 설문 결과 문항의 주관식 답 리스트.
	 * @param titleNo
	 * @param questionNo
	 * @param setNo
	 * @return
	 * @throws Exception
	 */
	public DataMap selectGrinqAnswerByTxtList(int titleNo, int questionNo, int setNo) throws Exception{
		
        DataMap resultMap = null;
        
        try {
        	
        	Map<String, Object> params = new HashMap<String, Object>();
        	
        	params.put("titleNo", titleNo);
        	params.put("questionNo", questionNo);
        	params.put("setNo", setNo);
        	
            resultMap = coursePollMapper.selectGrinqAnswerByTxtList(params);
                                    
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return resultMap;  
		
	}
	
	/**
	 * 설문 통합 결과
	 * @param grcode
	 * @return
	 * @throws Exception
	 */
	public DataMap selectGrinqGrseqTotalResultList(String grcode) throws Exception{
		
        DataMap resultMap = null;
        
        try {
        	
            resultMap = coursePollMapper.selectGrinqGrseqTotalResultList(grcode);
                                    
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return resultMap;  
		
	}
	
	/**
	 * 설문 통합 결과 (강사)
	 * @param grcode
	 * @return
	 * @throws Exception
	 */
	public DataMap selectGrinqGrseqTotalResultByTutorList(String grcode) throws Exception{
		
        DataMap resultMap = null;
        
        try {
        	
            resultMap = coursePollMapper.selectGrinqGrseqTotalResultByTutorList(grcode);
            if(resultMap == null) resultMap = new DataMap();
            resultMap.setNullToInitialize(true);
            
            Map<String, Object> params = new HashMap<String, Object>();
            
            //보기 리스트 .
            for(int i=0; i < resultMap.keySize("questionNo"); i++){
            	
            	int questionNo = resultMap.getInt("questionNo", i);
            	
            	params.put("questionNo",  resultMap.getInt("questionNo", i));
            	params.put("titleNo",  resultMap.getInt("titleNo", i));
            	
            	DataMap sampMap = coursePollMapper.selectGrinqSampSetByQuestionNoList(params);
            	if(sampMap == null) sampMap = new DataMap();
            	
            	resultMap.add("SAMP_LIST_DATA", sampMap); //보기 리스트 넣기.
            	
            }
            
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return resultMap;  
		
	}
	
	
	/**
	 * 설문 목록 (사이버)
	 * @param grcode
	 * @param grseq
	 * @return
	 * @throws Exception
	 */
	public DataMap selectGrinqTtlByCyberList(String grcode, String grseq) throws Exception{
		
        DataMap resultMap = null;
        
        try {
        	
            Map<String, Object> params = new HashMap<String, Object>();
            
            params.put("grcode", grcode);
            params.put("grseq", grseq);
            
            resultMap = coursePollMapper.selectGrinqTtlByCyberList(params);
                                    
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return resultMap;  
		
	}
	
	/**
	 * 과정별 모바일용 설문지 상세정보
	 * @param titleNo
	 * @return
	 * @throws Exception
	 */
	public DataMap selectPollList(DataMap info) throws Exception{
		
        DataMap resultMap = null;
        
        try {
        	
            resultMap = coursePollMapper.selectPollList(info);
                                    
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return resultMap;		
	}

	public DataMap selectNewPollList(DataMap params) throws Exception {

		DataMap resultMap = null;

		try {

			resultMap = coursePollMapper.selectNewPollList(params);

		} catch (SQLException e) {
			throw new BizException(Message.getKey(e), e);
		} finally {
		}
		return resultMap;
	}
	
	public int selectNewPollYN(DataMap params) throws Exception {

		int resul= 0;

		try {

			resul = coursePollMapper.selectNewPollYN(params);

		} catch (SQLException e) {
			throw new BizException(Message.getKey(e), e);
		} finally {
		}
		return resul;
	}
	
	public int updatePollYN(DataMap params) throws Exception {

		int resul= 0;

		try {
			resul = coursePollMapper.updatePollYN(params);
			
		} catch (SQLException e) {
			throw new BizException(Message.getKey(e), e);
		} finally {
		}
		return resul;
	}
	public int insertIp(DataMap params) throws Exception {

		int resul= 0;

		try {
			resul = coursePollMapper.insertIp(params);			
			
		} catch (SQLException e) {
			throw new BizException(Message.getKey(e), e);
		} finally {
		}
		return resul;
	}
	public DataMap selectIpList(DataMap params) throws Exception {

		DataMap resul = null;

		try {
			resul = coursePollMapper.selectIpList(params);
			
		} catch (SQLException e) {
			throw new BizException(Message.getKey(e), e);
		} finally {
		}
		return resul;
	}
	
	
	public DataMap selectUsernoChk(String paramas)throws Exception {

		DataMap resul = null;

		try {
			resul = coursePollMapper.selectUsernoChk(paramas);
			
		} catch (SQLException e) {
			throw new BizException(Message.getKey(e), e);
		} finally {
		}
		return resul;
	}
	
	public int deleteAnsNo(DataMap paramas)throws Exception {
		
		int resul = 0;

		try {
			resul = coursePollMapper.deleteAnsNo(paramas);
			
		} catch (SQLException e) {
			throw new BizException(Message.getKey(e), e);
		}
		return resul;
		
	}
	
	public DataMap selectScore(DataMap paramas)throws Exception {

		DataMap resul = null;

		try {
			resul = coursePollMapper.selectScore(paramas);
			
		} catch (SQLException e) {
			throw new BizException(Message.getKey(e), e);
		}
		return resul;
	}
	
	
	public String selectPollYNChk(DataMap paramas)throws Exception {

		String resul = null;

		try {
			resul = coursePollMapper.selectPollYNChk(paramas);
			
		} catch (SQLException e) {
			throw new BizException(Message.getKey(e), e);
		} finally {
		}
		return resul;
	}
	
	
	
	
}
