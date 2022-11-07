package loti.courseMgr.service;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

import loti.courseMgr.mapper.LectureApplyMapper;
import loti.courseMgr.mapper.MailMapper;
import loti.courseMgr.mapper.MailSmsMapper;
import loti.courseMgr.mapper.StudyStaMapper;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import ut.lib.exception.BizException;
import ut.lib.login.LoginInfo;
import ut.lib.support.DataMap;
import ut.lib.util.Constants;
import ut.lib.util.Message;
import ut.lib.util.Util;
import common.service.BaseService;

@Service
public class StudyStaService extends BaseService {

	@Autowired
	private StudyStaMapper studyStaMapper;
	@Autowired
	private LectureApplyMapper lectureApplyMapper;
	@Autowired
	@Qualifier("courseMgrMailMapper")
	private MailMapper mailMapper;
	@Autowired
	private MailSmsMapper mailSmsMapper;
	
	/**
	 * 과목별 수강생 학습 현황 리스트
	 */
	public DataMap selectStuLecBySubjStudyStaList(DataMap requestMap, LoginInfo loginInfo, String ldapcode) throws BizException{
		DataMap resultMap = new DataMap();
        
        try {
        	String grcode = requestMap.getString("commGrcode");
            String grseq = requestMap.getString("commGrseq");
            String subj = requestMap.getString("commSubj");
            
            String whereStr = "";
            if(loginInfo.getSessClass().equals(Constants.ADMIN_SESS_CLASS_DEPT))
            	whereStr += "  AND A.DEPT = '" + loginInfo.getSessDept() + "' ";
            
            //기존 취득점수별 조회에서 검색시
            if(!requestMap.getString("searchValSdate").equals(""))
            	whereStr += "  AND ( NVL(A.AVCOURSE,0) + NVL(AVLCOUNT,0) + NVL(AVQUIZ,0) + NVL(AVREPORT,0) ) >= '" + requestMap.getString("searchValSdate") + "'";
            
            if(!requestMap.getString("searchValEdate").equals(""))
            	whereStr += "  AND ( NVL(A.AVCOURSE,0) + NVL(AVLCOUNT,0) + NVL(AVQUIZ,0) + NVL(AVREPORT,0) ) <= '" + requestMap.getString("searchValEdate") + "'";

		    if("6289999".equals(loginInfo.getSessDept())) {
		    	whereStr += "  AND MB.LDAPCODE = '" + ldapcode + "'  ";
            }
		    
		    Map<String, Object> paramMap = new HashMap<String, Object>();
		    paramMap.put("grcode", grcode);
		    paramMap.put("grseq", grseq);
		    paramMap.put("subj", subj);
		    paramMap.put("whereStr", whereStr);
		    
            resultMap = studyStaMapper.selectStuLecBySubjStudyStaList(paramMap);
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return resultMap;
	}
	
	/**
	 * 과정 기수의 전체 과목 리스트
	 */
	public DataMap selectSubjSeqByTotalSubjList(String grcode, String grseq) throws BizException{
		DataMap resultMap = new DataMap();
        
        try {
        	Map<String, Object> paramMap = new HashMap<String, Object>();
		    paramMap.put("grcode", grcode);
		    paramMap.put("grseq", grseq);
		    
        	resultMap = studyStaMapper.selectSubjSeqByTotalSubjList(paramMap);
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return resultMap;
	}
	
	/**
	 * 기수 전체 수강생의 과목별 점수
	 */
	public DataMap selectSubjSeqBySubjPointList(String grcode, String grseq) throws BizException{
		DataMap resultMap = new DataMap();
        
        try {
        	Map<String, Object> paramMap = new HashMap<String, Object>();
		    paramMap.put("grcode", grcode);
		    paramMap.put("grseq", grseq);
		    
        	resultMap = studyStaMapper.selectSubjSeqBySubjPointList(paramMap);
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return resultMap;
	}
	
	/**
	 * 기수의 수강생 리스트 (총점 포함)
	 */
	public DataMap selectAppInfoByStuTotPointList(String grcode, String grseq, LoginInfo loginInfo, String ldapcode) throws BizException{
		DataMap resultMap = new DataMap();
        
        try {
        	String whereStr = "";
            if(loginInfo.getSessClass().equals(Constants.ADMIN_SESS_CLASS_DEPT))
            	whereStr = " AND C.DEPT ='" + loginInfo.getSessDept() + "' ";
		   
            if("6289999".equals(loginInfo.getSessDept())) {
            	whereStr += "  AND MB.LDAPCODE = '" + ldapcode + "'  ";
            }
            
            Map<String, Object> paramMap = new HashMap<String, Object>();
		    paramMap.put("grcode", grcode);
		    paramMap.put("grseq", grseq);
		    paramMap.put("whereStr", whereStr);
		    
            resultMap = studyStaMapper.selectAppInfoByStuTotPointList(paramMap);
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return resultMap;
	}
	
	/**
	 * 사이버 과목의 선택 과목 제외한 과목 리스트
	 */
	public DataMap selectSubjSeqByCyberSubjList(String grcode, String grseq) throws BizException{
		DataMap resultMap = new DataMap();
        
        try {
        	Map<String, Object> paramMap = new HashMap<String, Object>();
		    paramMap.put("grcode", grcode);
		    paramMap.put("grseq", grseq);
		    
        	resultMap = studyStaMapper.selectSubjSeqByCyberSubjList(paramMap);
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return resultMap;
	}
	
	/**
	 * 사이버 과목별 수강자 점수
	 */
	public DataMap selectSubjSeqByCyberStuPointList(String grcode, String grseq) throws BizException{
		DataMap resultMap = new DataMap();
        
        try {
        	Map<String, Object> paramMap = new HashMap<String, Object>();
		    paramMap.put("grcode", grcode);
		    paramMap.put("grseq", grseq);
		    
        	resultMap = studyStaMapper.selectSubjSeqByCyberStuPointList(paramMap);
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return resultMap;
	}
	
	/**
	 * 사이버 학습 현황 수강자 리스트.
	 */
	public DataMap selectAppInfoByCyberStuTotPointList(DataMap requestMap, DataMap stuPointMap, LoginInfo loginInfo) throws BizException{
		DataMap resultMap = new DataMap();
        
        try {
        	String grcode = requestMap.getString("commGrcode");
    		String grseq = requestMap.getString("commGrseq");
    		String searchStartpt = requestMap.getString("searchStartpt");
    		String searchEndpt = requestMap.getString("searchEndpt");
    		
    		Map<String, Object> paramMap = new HashMap<String, Object>();
		    paramMap.put("grcode", grcode);
		    paramMap.put("grseq", grseq);
		    
            String userWhereStr = "";
            String userWhereStr2 = "";
            //기관담당자 일경우
            if(loginInfo.getSessClass().equals(Constants.ADMIN_SESS_CLASS_DEPT)){
            	userWhereStr = " AND C.DEPT ='" + loginInfo.getSessDept() + "' ";
            }else{
                //과목별 수강생 점수의 검색할 유저 정보 추출
                stuPointMap.setNullToInitialize(true);
                String tmpStr = "";
                double tmpDou = 0;
                for(int i=0;i < stuPointMap.keySize("userno"); i++){
                	tmpStr = Util.getValue(stuPointMap.getString("disStep", i), "0");
                	tmpDou = 0;
                	
                	try{
                		if(tmpStr.equals("완료")) 
                			tmpDou = 100;
                		else if(tmpStr.equals("진행중") || tmpStr.equals("미진행"))
                			tmpDou = 0;
                		else
                			tmpDou = Double.parseDouble(tmpStr);
                		
                	}catch(Exception ee){
                		tmpDou = 0;
                	}
                	
                	if(tmpDou > 100)
                		tmpDou = 100;
                	
                	try {
                		if(tmpDou >= Double.parseDouble(searchStartpt) && tmpDou <= Double.parseDouble(searchEndpt) ){
                			
                        	if(i <= 999) {
                        		if(!"".equals(userWhereStr)) {
                        			if(i > 0) userWhereStr += ", ";
                        		}
                    			userWhereStr += "'" + stuPointMap.getString("userno", i) + "'";
                        	} else {
                        		if(!"".equals(userWhereStr2)) {
                        			if(i > 0) userWhereStr2 += ", ";
                        		}
                        		userWhereStr2 += "'" + stuPointMap.getString("userno", i) + "'";            		
                        	}
                		}
                	}catch(Exception ee){ }
                }
                
                //사이버 과목을 하나도 선택하지 않은 사람은 진도율 0로 계산함
                DataMap noCyberUser = studyStaMapper.selectAppInfoByNoCyberUserList(paramMap);
                if(noCyberUser == null) noCyberUser = new DataMap();
                noCyberUser.setNullToInitialize(true);
                for(int i=0;i < noCyberUser.keySize("userno"); i++){
                	if(i <= 999) {
                		if(!"".equals(userWhereStr)) {
                			if(i > 0) userWhereStr += ", ";
                		}
            			userWhereStr += "'" + noCyberUser.getString("userno", i) + "'";
                	} else {
                		if(!"".equals(userWhereStr2)) {
                			if(i > 0) userWhereStr2 += ", ";
                		}
                		userWhereStr2 += "'" + noCyberUser.getString("userno", i) + "'";            		
                	}
                }
                
                if(userWhereStr.equals("")) {
                	userWhereStr = " AND C.USERNO IN ('') ";
                } else { 
                	if("".equals(userWhereStr2)) {
                		userWhereStr = " AND C.USERNO IN (" + userWhereStr + ") ";
                	} else {
                		userWhereStr = " AND (C.USERNO IN (" + userWhereStr + ") OR C.USERNO IN (" + userWhereStr2 + ")) ";
                	}
                }
            }
            
            //혼합교육에 엑셀 다운로드 일경우는 핸펀번호가 있는 유저만
            //if(requestMap.getString("mode").equals("mix_excel"))
            //	whereStr += "  AND HP IS NOT NULL ";
            paramMap.put("userWhereStr", userWhereStr);
            resultMap = studyStaMapper.selectAppInfoByWhereStrList(paramMap);
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return resultMap;
	}
	
	/**
	 * 사이버 과정 학습 현황 리스트
	 */
	public DataMap selectCyberStuStudyPointList(DataMap requestMap, LoginInfo loginInfo) throws BizException{
		DataMap resultMap = new DataMap();
        
        try {
        	String grcode = requestMap.getString("commGrcode");
    		String grseq = requestMap.getString("commGrseq");
    		String searchStartpt = requestMap.getString("searchStartpt");
    		String searchEndpt = requestMap.getString("searchEndpt");
    		
    		String grWhereStr = "";
            String whereStr = "";
            
            if(!grseq.equals(""))
            	grWhereStr += " AND C.GRSEQ = '" + grseq + "' ";
            if(!grcode.equals(""))
            	grWhereStr += " AND C.GRCODE = '" + grcode + "' ";
            
            //기관담당자 일경우
            if(loginInfo.getSessClass().equals(Constants.ADMIN_SESS_CLASS_DEPT))
            	whereStr = " AND XXB.DEPT = '" + loginInfo.getSessDept() + "' ";
            
            if(!searchStartpt.equals("") && !searchEndpt.equals(""))
            	whereStr = " AND DECODE(DIS_STEP, '완료', 100, '진행중', 0, '미진행', 0, DIS_STEP) BETWEEN " + searchStartpt + " AND " + searchEndpt + " ";
            
            Map<String, Object> paramMap = new HashMap<String, Object>();
		    paramMap.put("grWhereStr", grWhereStr);
		    paramMap.put("whereStr", whereStr);
		    
            resultMap = studyStaMapper.selectCyberStuStudyPointList(paramMap);
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return resultMap;
	}
	
	/**
	 * 사이버 과정 학습 현황 리스트 (SMS 선택발송자만)
	 */
	public DataMap selectCyberSMSStuStudyPointList(DataMap requestMap, LoginInfo loginInfo) throws BizException{
		DataMap resultMap = new DataMap();
        
        try {
        	String grcode = requestMap.getString("grcode");
    		String grseq = requestMap.getString("grseq");
    		String searchStartpt = requestMap.getString("searchStartpt");
    		String searchEndpt = requestMap.getString("searchEndpt");
    		
    		// String grWhereStr = " AND C.GRSEQ = '" + grseq + "' AND MB.SMS_YN = 'Y' ";
    		String grWhereStr = " AND C.GRSEQ = '" + grseq + "' ";
            String whereStr = "";
            
            if(!grcode.equals(""))
            	grWhereStr += " AND C.GRCODE = '" + grcode + "' ";
            
            //기관담당자 일경우
            if(loginInfo.getSessClass().equals(Constants.ADMIN_SESS_CLASS_DEPT))
            	whereStr = " AND XXB.DEPT = '" + loginInfo.getSessDept() + "' ";
            
            if(!searchStartpt.equals("") && !searchEndpt.equals(""))
            	whereStr = " AND DECODE(DIS_STEP, '완료', 100, '진행중', 0, '미진행', 0, DIS_STEP) BETWEEN " + searchStartpt + " AND " + searchEndpt + " ";
            
            //학습독려 선택한 유저만 검색
            String userWhereStr = "";
            String userWhereStr2 = "";
            for(int i = 0 ; i < requestMap.keySize("userno[]") ; i++){
            	if(i <= 999) {
            		if(!"".equals(userWhereStr)) {
            			if(i > 0) userWhereStr += ", ";
            		}
        			userWhereStr += "'" + requestMap.getString("userno[]", i) + "'";
            	} else {
            		if(!"".equals(userWhereStr2)) {
            			if(i > 0) userWhereStr2 += ", ";
            		}
            		userWhereStr2 += "'" + requestMap.getString("userno[]", i) + "'";            		
            	}
            }
            if(userWhereStr.equals("")) {
            	userWhereStr = " AND GRCODE_USERNO IN ('') ";
            } else { 
            	if("".equals(userWhereStr2)) {
            		userWhereStr = " AND GRCODE_USERNO IN (" + userWhereStr + ") ";
            	} else {
            		userWhereStr = " AND (GRCODE_USERNO IN (" + userWhereStr + ") OR GRCODE_USERNO IN (" + userWhereStr2 + ")) ";
            	}
            }
            
            Map<String, Object> paramMap = new HashMap<String, Object>();
		    paramMap.put("grWhereStr", grWhereStr);
		    paramMap.put("whereStr", whereStr);
		    paramMap.put("userWhereStr", userWhereStr);
		    
            resultMap = studyStaMapper.selectCyberSMSStuStudyPointList(paramMap);
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return resultMap;
	}
	
	/**
	 * 간단한 회원정보 리스트 추출
	 */
	public DataMap selectMemberBySimpleDataList(DataMap requestMap) throws BizException{
		DataMap resultMap = new DataMap();
        
        try {
        	String userWhereStr = "";
            String userWhereStr2 = "";

            for(int i = 0 ; i < requestMap.keySize("userno[]") ; i++){
            	if(i <= 999) {
            		if(!"".equals(userWhereStr)) {
            			if(i > 0) userWhereStr += ", ";
            		}
        			userWhereStr += "'" + requestMap.getString("userno[]", i) + "'";
            	} else {
            		if(!"".equals(userWhereStr2)) {
            			if(i > 0) userWhereStr2 += ", ";
            		}
            		userWhereStr2 += "'" + requestMap.getString("userno[]", i) + "'";            		
            	}
            }
            if(!userWhereStr.equals("")) {
            	if("".equals(userWhereStr2)) {
            		userWhereStr = " AND USERNO IN (" + userWhereStr + ") ";
            	} else {
            		userWhereStr = " AND (USERNO IN (" + userWhereStr + ") OR USERNO IN (" + userWhereStr2 + ")) ";
            	}
            }
            
            if(userWhereStr.equals(""))
            	resultMap = new DataMap();
            else
            	// resultMap = dao.selectMemberBySimpleDataList(" AND USERNO IN (" + whereStr + ") AND SMS_YN = 'Y' ");
            	resultMap = lectureApplyMapper.selectMemberBySimpleDataList(userWhereStr);
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return resultMap;
	}
	
	/**
	 * 사이버 학습 현황 학습 독려 SMS
	 */
	public DataMap insertSmsMsgStudyCyber(DataMap requestMap, LoginInfo loginInfo) throws BizException{
		DataMap resultMap = new DataMap();
        
        try {
            
            String message = requestMap.getString("txtMessage");
            String userMessage = "";
            
    		String grcode = requestMap.getString("grcode");
    		String grseq = requestMap.getString("grseq");
    		String searchStartpt = requestMap.getString("searchStartpt");
    		String searchEndpt = requestMap.getString("searchEndpt");
    		
    		String grWhereStr = " AND C.GRSEQ = '" + grseq + "' AND MB.SMS_YN = 'Y' ";
            String whereStr = "";
            
            if(!grcode.equals(""))
            	grWhereStr += " AND C.GRCODE = '" + grcode + "' ";
            
            //기관담당자 일경우
            if(loginInfo.getSessClass().equals(Constants.ADMIN_SESS_CLASS_DEPT))
            	whereStr = " AND XXB.DEPT = '" + loginInfo.getSessDept() + "' ";
            
            if(!searchStartpt.equals("") && !searchEndpt.equals(""))
            	whereStr = " AND DECODE(DIS_STEP, '완료', 100, '진행중', 0, '미진행', 0, DIS_STEP) BETWEEN " + searchStartpt + " AND " + searchEndpt + " ";
            
            //학습독려 선택한 유저만 검색
            String userWhereStr = "";
            String userWhereStr2 = "";

            for(int i = 0 ; i < requestMap.keySize("userno[]") ; i++){
            	if(i <= 999) {
            		if(!"".equals(userWhereStr)) {
            			if(i > 0) userWhereStr += ", ";
            		}
        			userWhereStr += "'" + requestMap.getString("userno[]", i) + "'";
            	} else {
            		if(!"".equals(userWhereStr2)) {
            			if(i > 0) userWhereStr2 += ", ";
            		}
            		userWhereStr2 += "'" + requestMap.getString("userno[]", i) + "'";            		
            	}
            }
            if(userWhereStr.equals("")) {
            	userWhereStr = " AND GRCODE_USERNO IN ('') ";
            } else { 
            	if("".equals(userWhereStr2)) {
            		userWhereStr = " AND GRCODE_USERNO IN (" + userWhereStr + ") ";
            	} else {
            		userWhereStr = " AND (GRCODE_USERNO IN (" + userWhereStr + ") OR GRCODE_USERNO IN (" + userWhereStr2 + ")) ";
            	}
            }

            //선택한 유저의 리스트.
            Map<String, Object> paramMap = new HashMap<String, Object>();
		    paramMap.put("grWhereStr", grWhereStr);
		    paramMap.put("whereStr", whereStr);
		    paramMap.put("userWhereStr", userWhereStr);
		    
            DataMap userListMap = studyStaMapper.selectCyberSMSStuStudyPointList(paramMap);
            if(userListMap == null) userListMap = new DataMap();
            userListMap.setNullToInitialize(true);
            
            //request로 넘어온 유저
            for(int i=0; i < userListMap.keySize("userno"); i++){
            	if(!userListMap.getString("hp", i).equals("--")){
            		userMessage = message.replaceAll("\\{grname\\}", userListMap.getString("grcodenm", i));
            		userMessage = userMessage.replaceAll("\\{progress\\}", userListMap.getString("disStep", i));
            		
                	DataMap smsMap = new DataMap();
                	smsMap.setNullToInitialize(true);
                	
                	smsMap.setString("phone", userListMap.getString("hp", i).replaceAll("" , ""));
                	smsMap.setString("callback", (requestMap.getString("sms_callback") == null || "".equals(requestMap.getString("sms_callback"))) ? Constants.SMS_CALLBACK : requestMap.getString("sms_callback"));
                	smsMap.setString("status", Constants.SMS_STATUS);
                	
                	String sendMsg = userMessage.replaceAll("\\{name\\}", userListMap.getString("name", i));
                	
                	smsMap.setString("msg", sendMsg);
                	smsMap.setString("compkey", Constants.SMS_COMPKEY);
                	smsMap.setString("id", Constants.SMS_ID);
                	
                	mailSmsMapper.insertSmsMsg(smsMap); //sms테이블에 등록.
                	
                	// 전송 메세지 담기
                	resultMap.addString("userno", userListMap.getString("userno", i)); 
                	resultMap.addString("name", userListMap.getString("name", i));
                	resultMap.addString("hp", userListMap.getString("hp", i));
                	resultMap.addString("msg", sendMsg); //전송 메세지 담기
            	}
            }
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return resultMap;
	}
	
	/**
	 * 혼합교육과정 학습 독려 SMS 발송
	 */
	public DataMap insertSmsMsgStudyMix(DataMap requestMap) throws BizException{
		DataMap resultMap = new DataMap();
        
        try {
            
            String grcode = requestMap.getString("grcode");
            
            //과정 정보
            //DataMap grcodeMap = dao.selectGrcodeRow(grcode);
            DataMap grcodeMap = mailMapper.selectGrcodeRow(grcode);
            if(grcodeMap == null) grcodeMap = new DataMap();
            grcodeMap.setNullToInitialize(true);
            
            String message = requestMap.getString("txtMessage");
            message = message.replaceAll("\\{grname\\}", grcodeMap.getString("grcodenm"));
            
            //request로 넘어온 유저
            String userWhereStr = "";
            String userWhereStr2 = "";

            for(int i = 0 ; i < requestMap.keySize("userno[]") ; i++){
            	if(i <= 999) {
            		if(!"".equals(userWhereStr)) {
            			if(i > 0) userWhereStr += ", ";
            		}
        			userWhereStr += "'" + requestMap.getString("userno[]", i) + "'";
            	} else {
            		if(!"".equals(userWhereStr2)) {
            			if(i > 0) userWhereStr2 += ", ";
            		}
            		userWhereStr2 += "'" + requestMap.getString("userno[]", i) + "'";            		
            	}
            }
            if(userWhereStr.equals("")) {
            	userWhereStr = " AND USERNO IN ('') ";
            } else { 
            	if("".equals(userWhereStr2)) {
            		userWhereStr = " AND USERNO IN (" + userWhereStr + ") ";
            	} else {
            		userWhereStr = " AND (USERNO IN (" + userWhereStr + ") OR USERNO IN (" + userWhereStr2 + ")) ";
            	}
            }
            
            //유저 리스트
            DataMap userList = lectureApplyMapper.selectMemberBySimpleDataList(userWhereStr + " AND HP IS NOT NULL AND SMS_YN = 'Y' ");
            if(userList == null) userList = new DataMap();
            userList.setNullToInitialize(true);
            
            for(int i=0; i < userList.keySize("userno"); i++){
            	if(!userList.getString("hp", i).equals("--")){
                	DataMap smsMap = new DataMap();
                	smsMap.setNullToInitialize(true);
                	
                	smsMap.setString("phone", userList.getString("hp", i).replaceAll(" ", ""));
                	smsMap.setString("callback", (requestMap.getString("sms_callback") == null || "".equals(requestMap.getString("sms_callback"))) ? Constants.SMS_CALLBACK : requestMap.getString("sms_callback"));
                	smsMap.setString("status", Constants.SMS_STATUS);
                	
                	String sendMsg = message.replaceAll("\\{name\\}", userList.getString("name", i));
                	smsMap.setString("msg", sendMsg);
                	smsMap.setString("compkey", Constants.SMS_COMPKEY);
                	smsMap.setString("id", Constants.SMS_ID);
                	
                	//smsDao.insertSmsMsg(smsMap); //sms테이블에 등록.
                	mailSmsMapper.insertSmsMsg(smsMap); //sms테이블에 등록.
                	
                	// 전송 메세지 담기
                	resultMap.addString("userno", userList.getString("userno", i)); 
                	resultMap.addString("name", userList.getString("name", i));
                	resultMap.addString("hp", userList.getString("hp", i));
                	resultMap.addString("msg", sendMsg); //전송 메세지 담기
            	}
            }
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return resultMap;
	}
	
	/**
	 * ETEST의 평가 정보 조회
	 */
	public DataMap selectEtestExamRow(String examId) throws BizException{
		DataMap resultMap = new DataMap();
        
        try {
        	resultMap = studyStaMapper.selectEtestExamRow(examId);
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return resultMap;
	}
	
	/**
	 * ETEST 평가 현황의 수강생 리스트
	 */
	public DataMap selectOnlineExamStuList(String grcode, String grseq, String examId, LoginInfo loginInfo) throws BizException{
		DataMap resultMap = new DataMap();
        
        try {
        	String whereStr = "";
            //기관담당자 일경우
            if(loginInfo.getSessClass().equals(Constants.ADMIN_SESS_CLASS_DEPT))
            	whereStr = " AND C.DEPT = '" + loginInfo.getSessDept() + "' ";
            
            Map<String, Object> paramMap = new HashMap<String, Object>();
		    paramMap.put("grcode", grcode);
		    paramMap.put("grseq", grseq);
		    paramMap.put("examId", examId);
		    paramMap.put("whereStr", whereStr);
		    
            resultMap = studyStaMapper.selectOnlineExamStuList(paramMap);
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return resultMap;
	}
	
	/**
	 * 
	 */
	public DataMap selectOnlineExamStuListBySms(DataMap requestMap) throws BizException{
		DataMap resultMap = new DataMap();
        
        try {
        	String grcode = requestMap.getString("commGrcode");
            String grseq = requestMap.getString("commGrseq");
            String examId = requestMap.getString("commExam");
            
            String whereStr = "";
            
            for(int i = 0 ; i < requestMap.keySize("userno[]") ; i++){
        		if(i > 0) whereStr += ", ";
        		whereStr += "'" + requestMap.getString("userno[]", i) + "'";
            }
            
            if(whereStr.equals(""))
            	resultMap = new DataMap();
            else{
            	whereStr = " AND C.USERNO IN (" + whereStr + ") AND MB.SMS_YN = 'Y' ";
            	
            	Map<String, Object> paramMap = new HashMap<String, Object>();
    		    paramMap.put("grcode", grcode);
    		    paramMap.put("grseq", grseq);
    		    paramMap.put("examId", examId);
    		    paramMap.put("whereStr", whereStr);
    		    
            	resultMap = studyStaMapper.selectOnlineExamStuList(paramMap);
            }
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return resultMap;
	}
	
	/**
	 * 
	 */
	public DataMap insertSmsMsgStudyOnline(DataMap requestMap) throws BizException{
		DataMap resultMap = new DataMap();
        
        try {
            
            String grcode = requestMap.getString("grcode");
            String grseq = requestMap.getString("grseq");
            String examId = requestMap.getString("examId");
            
            //과정 정보
            //DataMap grcodeMap = dao.selectGrcodeRow(grcode);
            DataMap grcodeMap = mailMapper.selectGrcodeRow(grcode);
            if(grcodeMap == null) grcodeMap = new DataMap();
            grcodeMap.setNullToInitialize(true);
            
            String message = requestMap.getString("txtMessage");
            message = message.replaceAll("\\{grname\\}", grcodeMap.getString("grcodenm"));
            
            //request로 넘어온 유저
            String tmpUserNo = "";
            for(int i=0; i < requestMap.keySize("userno[]"); i++){
            	if(i > 0) tmpUserNo += ", ";
            	
            	tmpUserNo += "'" + requestMap.getString("userno[]", i) + "'";
            }
            String whereStr = " AND C.USERNO IN (" + tmpUserNo + ") AND MB.HP IS NOT NULL AND MB.SMS_YN = 'Y' ";
            //유저 리스트
            Map<String, Object> paramMap = new HashMap<String, Object>();
            paramMap.put("grcode", grcode);
            paramMap.put("grseq", grseq);
            paramMap.put("examId", examId);
            paramMap.put("whereStr", whereStr);
            DataMap userList = studyStaMapper.selectOnlineExamStuList(paramMap);
            if(userList == null) userList = new DataMap();
            userList.setNullToInitialize(true);
            
            for(int i=0; i < userList.keySize("userno"); i++){
            	if(!userList.getString("hp", i).equals("--")){
                	DataMap smsMap = new DataMap();
                	smsMap.setNullToInitialize(true);
                	
                	smsMap.setString("phone", userList.getString("hp", i));
                	smsMap.setString("callback", (requestMap.getString("sms_callback") == null || "".equals(requestMap.getString("sms_callback"))) ? Constants.SMS_CALLBACK : requestMap.getString("sms_callback"));
                	smsMap.setString("status", Constants.SMS_STATUS);
                	
                	String sendMsg = message.replaceAll("\\{name\\}", userList.getString("name", i));
                	smsMap.setString("msg", sendMsg);
                	smsMap.setString("compkey", Constants.SMS_COMPKEY);
                	smsMap.setString("id", Constants.SMS_ID);
                	
                	//smsDao.insertSmsMsg(smsMap); //sms테이블에 등록.
                	mailSmsMapper.insertSmsMsg(smsMap); //sms테이블에 등록.
                	
                	// 전송 메세지 담기
                	resultMap.addString("userno", userList.getString("userno", i)); 
                	resultMap.addString("name", userList.getString("name", i));
                	resultMap.addString("hp", userList.getString("hp", i));
                	resultMap.addString("msg", sendMsg); //전송 메세지 담기
            	}
            }
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return resultMap;
	}
}
