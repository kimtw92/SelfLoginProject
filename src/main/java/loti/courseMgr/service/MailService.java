package loti.courseMgr.service;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

import loti.common.mapper.CommonMapper;
import loti.courseMgr.mapper.LectureApplyMapper;
import loti.courseMgr.mapper.MailMapper;
import loti.courseMgr.mapper.MailSmsMapper;
import loti.courseMgr.mapper.ReservationMapper;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import ut.lib.exception.BizException;
import ut.lib.support.DataMap;
import ut.lib.util.Constants;
import ut.lib.util.Message;
import ut.lib.util.StringReplace;
import common.service.BaseService;

@Service
public class MailService extends BaseService{

	@Autowired
	private ReservationMapper reservationMapper;
	@Autowired
	@Qualifier("courseMgrMailMapper")
	private MailMapper mailMapper;
	@Autowired
	private MailSmsMapper mailSmsMapper;
	@Autowired
	private LectureApplyMapper lectureApplyMapper;
	@Autowired
	private CommonMapper commonMapper;
	
	/**
	 * 시설대여신청 완료시 관리자에게 신청되었음을 SMS 통보
	 */
	@Transactional
	public void insertSmsMsgReservationAction(DataMap requestMap) throws BizException {
		DataMap resultMap = new DataMap();
        
        try {
        	
            resultMap = reservationMapper.setResvAdmin();
                                    
            resultMap.setNullToInitialize(true);
            
            for(int i=0; i < resultMap.keySize("raHp"); i++){
            	String strRA_HP = StringReplace.change(resultMap.getString("raHp",i), "-", "");
            	
        		DataMap smsMap = new DataMap();
	        	smsMap.setNullToInitialize(true);
	        	
	        	//smsMap.setString("phone", adminList.getString("hp", i));
	        	smsMap.setString("phone", strRA_HP);
	        	
	        	smsMap.setString("callback", requestMap.getString("callback"));
	        	smsMap.setString("status", Constants.SMS_STATUS);
	        	smsMap.setString("msg", requestMap.getString("txtMessage"));
	        	smsMap.setString("compkey", Constants.SMS_COMPKEY);
	        	smsMap.setString("id", Constants.SMS_ID);
	        	
	        	System.out.println("chichi --- [" + this.getClass().getName() + "] - smsMap: " + smsMap);
	        	
	        	// test용 주석 mail 서버 연결이 되면 주석 해제
	        	mailSmsMapper.insertSmsMsg(smsMap); //SMS 테이블에 등록.
    		}
            
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
	}
	
	/**
	 * 과정 정보
	 * @param grcode
	 * @return
	 * @throws BizException
	 */
	public DataMap selectGrcodeRow(String grcode) throws BizException{
		DataMap resultMap = new DataMap();
        
        try {
            resultMap = mailMapper.selectGrcodeRow(grcode);
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return resultMap;
	}
	
	/**
	 * 미입교 수강생 리스트
	 */
	public DataMap selectAppInfoEnterList(String grcode, String grseq, String grchk) throws BizException{
		DataMap resultMap = new DataMap();
        
        try {
            Map<String, Object> params = new HashMap<String, Object>();
            params.put("grcode", grcode);
            params.put("grseq", grseq);
            params.put("grchk", grchk);
            
            resultMap = mailMapper.selectAppInfoEnterList(params);
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return resultMap;
	}
	
	/**
	 * 수료자 리스트 수료, 미수료자 리스트
	 */
	public DataMap selectGrResultUserList(String grcode, String grseq, String rgraYn) throws BizException{
		DataMap resultMap = new DataMap();
        
        try {
            Map<String, Object> params = new HashMap<String, Object>();
            params.put("grcode", grcode);
            params.put("grseq", grseq);
            params.put("rgraYn", rgraYn);
            
            resultMap = mailMapper.selectGrResultUserList(params);
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return resultMap;
	}
	
	/**
	 * 회원정보조회
	 */
	public DataMap selectUserInfo(String userid) throws BizException{
		DataMap resultMap = new DataMap();
        
        try {
            resultMap = mailMapper.selectUserInfo(userid);
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return resultMap;
	}
	
	/**
	 * 과정의 특정 관리자 리스트
	 */
	public DataMap selectDeptManagerList(String grcode, String grseq) throws BizException{
		DataMap resultMap = new DataMap();
        
        try {
        	Map<String, Object> params = new HashMap<String, Object>();
        	params.put("grcode", grcode);
        	params.put("grseq", grseq);
        	
            resultMap = mailMapper.selectDeptManagerList(params);                                    
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return resultMap;
	}
	
	/**
	 * 과정의 강사 리스트
	 */
	public DataMap selectClassTutorGrseqList(String grcode, String grseq) throws BizException{
		DataMap resultMap = new DataMap();
        
        try {
        	Map<String, Object> params = new HashMap<String, Object>();
        	params.put("grcode", grcode);
        	params.put("grseq", grseq);
        	
            resultMap = mailMapper.selectClassTutorGrseqList(params);
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return resultMap;
	}
	
	/**
	 * 입교자 미입교자 대상 및 교육안내 SMS 발송
	 */
	public DataMap insertSmsMsgEnter(DataMap requestMap) throws BizException{
		DataMap resultMap = new DataMap();

        try {       	
            String grcode = requestMap.getString("grcode");
            String grseq = requestMap.getString("grseq");
            
            //과정 정보
//            DataMap grcodeMap = dao.selectGrcodeRow(grcode);
            DataMap grcodeMap = mailMapper.selectGrcodeRow(grcode);
            if(grcodeMap == null) grcodeMap = new DataMap();
            grcodeMap.setNullToInitialize(true);
            
            String message = requestMap.getString("txtMessage");
            message = message.replaceAll("\\{grseq\\}", grseq);
            message = message.replaceAll("\\{grname\\}", grcodeMap.getString("grcodenm"));
            
            //request로 넘어온 유저
            String tmpUserNo = "";
            for(int i=0; i < requestMap.keySize("userno[]"); i++){
            	if(i > 0) tmpUserNo += ", ";
            	tmpUserNo += "'" + requestMap.getString("userno[]", i) + "'";
            }
            
            //유저 리스트
            Map<String, Object> params = new HashMap<String, Object>();
            params.put("tmpUserNo", tmpUserNo);
            params.put("grcode", grcode);
            params.put("grseq", grseq);
            params.put("qu", requestMap.getString("qu"));
            
            DataMap userList = mailMapper.selectAppInfoEnterUserList(params);
            
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
	 * 수료 및 미수료자 SMS 발송.
	 */
	public DataMap insertSmsMsgGrchk(DataMap requestMap) throws BizException{
		DataMap resultMap = new DataMap();
        
        try {
        	String grcode = requestMap.getString("grcode");
            String grseq = requestMap.getString("grseq");
            
            //과정 정보
//            DataMap grcodeMap = dao.selectGrcodeRow(grcode);
            DataMap grcodeMap = mailMapper.selectGrcodeRow(grcode);
            if(grcodeMap == null) grcodeMap = new DataMap();
            grcodeMap.setNullToInitialize(true);
            
            //SMS 발송할 메세지.
            String message = requestMap.getString("txtMessage");
            message = message.replaceAll("\\{grname\\}", grcodeMap.getString("grcodenm"));
            message = message.replaceAll("\\{grseq\\}", grseq);
            message = message.replaceAll("\\{yy\\}", StringReplace.subString(grseq, 0, 4));
            message = message.replaceAll("\\{seq\\}", StringReplace.subString(grseq, 4, 6));
            
            //request로 넘어온 유저
            String tmpUserNo = "";
            for(int i=0; i < requestMap.keySize("userno[]"); i++){
            	if(i > 0) tmpUserNo += ", ";
            	tmpUserNo += "'" + requestMap.getString("userno[]", i) + "'";
            }
            
            //유저 리스트
            Map<String, Object> params = new HashMap<String, Object>();
            params.put("grcode", grcode);
            params.put("grseq", grseq);
            params.put("qu", requestMap.getString("qu"));
            params.put("tmpUserNo", tmpUserNo);
            
            DataMap userList = mailMapper.selectGrResultUserList2(params);
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
	 * 기관 담당자 메일 발송
	 */
	public DataMap insertSmsMsgDept(DataMap requestMap) throws BizException{
		DataMap resultMap = new DataMap();
        
        try {
        	String grcode = requestMap.getString("grcode");
            String grseq = requestMap.getString("grseq");
            
            //과정 정보
//            DataMap grcodeMap = dao.selectGrcodeRow(grcode);
            DataMap grcodeMap = mailMapper.selectGrcodeRow(grcode);
            if(grcodeMap == null) grcodeMap = new DataMap();
            grcodeMap.setNullToInitialize(true);
            
            //SMS 발송할 메세지.
            String message = requestMap.getString("txtMessage");
            message = message.replaceAll("\\{grname\\}", grcodeMap.getString("grcodenm"));
            message = message.replaceAll("\\{grseq\\}", grseq);
            message = message.replaceAll("\\{yy\\}", StringReplace.subString(grseq, 0, 4));
            message = message.replaceAll("\\{seq\\}", StringReplace.subString(grseq, 4, 6));
            
            //request로 넘어온 유저
            String tmpUserNo = "";
            for(int i=0; i < requestMap.keySize("userno[]"); i++){
            	if(i > 0) tmpUserNo += ", ";
            	tmpUserNo += "'" + requestMap.getString("userno[]", i) + "'";
            }
            
            //유저 리스트
            Map<String, Object> params = new HashMap<String, Object>();
            params.put("grcode", grcode);
            params.put("grseq", grseq);
            params.put("tmpUserNo", tmpUserNo);
            
            DataMap userList = mailMapper.selectDeptManagerUserList(params);
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
	 * 강사대상 SMS 발송
	 */
	public DataMap insertSmsMsgTutor(DataMap requestMap) throws BizException{
		DataMap resultMap = new DataMap();
        
        try {
        	String grcode = requestMap.getString("grcode");
            String grseq = requestMap.getString("grseq");
            
            //과정 정보
//            DataMap grcodeMap = dao.selectGrcodeRow(grcode);
            DataMap grcodeMap = mailMapper.selectGrcodeRow(grcode);
            if(grcodeMap == null) grcodeMap = new DataMap();
            grcodeMap.setNullToInitialize(true);
            
            //SMS 발송할 메세지.
            String message = requestMap.getString("txtMessage");
            message = message.replaceAll("\\{grname\\}", grcodeMap.getString("grcodenm"));
            message = message.replaceAll("\\{grseq\\}", grseq);
            message = message.replaceAll("\\{yy\\}", StringReplace.subString(grseq, 0, 4));
            message = message.replaceAll("\\{seq\\}", StringReplace.subString(grseq, 4, 6));
            
            //request로 넘어온 유저
            String tmpUserNo = "";
            for(int i=0; i < requestMap.keySize("userno[]"); i++){
            	if(i > 0) tmpUserNo += ", ";
            	tmpUserNo += "'" + requestMap.getString("userno[]", i) + "'";
            }
            
            //유저 리스트
            Map<String, Object> params = new HashMap<String, Object>();            
            params.put("grcode", grcode);
            params.put("grseq", grseq);
            params.put("tmpUserNo", tmpUserNo);
            
            DataMap userList = mailMapper.selectClassTutorGrseqList2(params);
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
	 * 수강신청 조회 승인 화면에서 선택된 메일 발송
	 */
	public DataMap insertSmsMsgSpec(DataMap requestMap) throws BizException{
		DataMap resultMap = new DataMap();
        
        try {
        	String grcode = requestMap.getString("grcode");
            String grseq = requestMap.getString("grseq");
            
            //과정 정보
//            DataMap grcodeMap = dao.selectGrcodeRow(grcode);
            DataMap grcodeMap = mailMapper.selectGrcodeRow(grcode);
            if(grcodeMap == null) grcodeMap = new DataMap();
            grcodeMap.setNullToInitialize(true);
            
            String message = requestMap.getString("txtMessage");
            message = message.replaceAll("\\{grseq\\}", StringReplace.subString(grseq, 4, 6));
            message = message.replaceAll("\\{grname\\}", grcodeMap.getString("grcodenm"));
            
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
            if(!"".equals(userWhereStr)) {
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
                	
                	smsMap.setString("phone", userList.getString("hp", i));
                	smsMap.setString("callback", (requestMap.getString("sms_callback") == null || "".equals(requestMap.getString("sms_callback"))) ? Constants.SMS_CALLBACK : requestMap.getString("sms_callback"));
                	smsMap.setString("status", Constants.SMS_STATUS);
                	
                	String sendMsg = message.replaceAll("\\{name\\}", userList.getString("name", i));
                	smsMap.setString("msg", sendMsg);
                	smsMap.setString("compkey", Constants.SMS_COMPKEY);
                	smsMap.setString("id", Constants.SMS_ID);
                	
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
	
	public DataMap insertSmsMsgSpec2(DataMap requestMap) throws BizException{
		DataMap resultMap = new DataMap();
        
        try {
            String grcode = requestMap.getString("grcode");
            String grseq = requestMap.getString("grseq");
            
            //과정 정보
//            DataMap grcodeMap = dao.selectGrcodeRow(grcode);
            DataMap grcodeMap = mailMapper.selectGrcodeRow(grcode);
            if(grcodeMap == null) grcodeMap = new DataMap();
            grcodeMap.setNullToInitialize(true);
            
            String message = requestMap.getString("txtMessage");
            String message2 = "";
            message = message.replaceAll("\\{grseq\\}", StringReplace.subString(grseq, 4, 6));
            message2 = message;
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
            if(!"".equals(userWhereStr)) {
            	if("".equals(userWhereStr2)) {
            		userWhereStr = " AND a.USERNO IN (" + userWhereStr + ") ";
            	} else {
            		userWhereStr = " AND (a.USERNO IN (" + userWhereStr + ") OR a.USERNO IN (" + userWhereStr2 + ")) ";
            	}
            }
            
            Map<String, Object> params= new HashMap<String, Object>();
            params.put("where", userWhereStr + " AND HP IS NOT NULL AND SMS_YN = 'Y' ");
            params.put("grseq", grseq);
            
            //유저 리스트
            DataMap userList = lectureApplyMapper.selectMemberBySimpleDataList2(params);
            if(userList == null) userList = new DataMap();
            userList.setNullToInitialize(true);
            
            for(int i=0; i < userList.keySize("userno"); i++){
            	if(!userList.getString("hp", i).equals("--")){
                	DataMap smsMap = new DataMap();
                	smsMap.setNullToInitialize(true);
                	
                	smsMap.setString("phone", userList.getString("hp", i));
                	smsMap.setString("callback", (requestMap.getString("sms_callback") == null || "".equals(requestMap.getString("sms_callback"))) ? Constants.SMS_CALLBACK : requestMap.getString("sms_callback"));
                	smsMap.setString("status", Constants.SMS_STATUS);
                	
                    message = message.replaceAll("\\{grname\\}", userList.getString("grcodeniknm",i));
                    
                    String sendMsg = message.replaceAll("\\{name\\}", userList.getString("name", i));
                    
                    message = message2;
                	smsMap.setString("msg", sendMsg);
                	smsMap.setString("compkey", Constants.SMS_COMPKEY);
                	smsMap.setString("id", Constants.SMS_ID);

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
	 * 시설대여신청 승인시 신청자에게 승인되었음을 SMS 통보
	 */
	public void insertSmsMsgReservation(DataMap requestMap) throws BizException {
		
        try {
            String name = requestMap.getString("smsName");	// 이름
            String hp   = requestMap.getString("smsPhone");	// 휴대폰
            
            String message = requestMap.getString("txtMessage");
            		
        	DataMap smsMap = new DataMap();
        	smsMap.setNullToInitialize(true);
        	
        	smsMap.setString("phone", hp);
        	smsMap.setString("callback", (requestMap.getString("sms_callback") == null || "".equals(requestMap.getString("sms_callback"))) ? Constants.SMS_CALLBACK : requestMap.getString("sms_callback"));
        	smsMap.setString("status", Constants.SMS_STATUS);
        	
        	String sendMsg = message.replaceAll("\\{name\\}", name);
        	smsMap.setString("msg", sendMsg);
        	smsMap.setString("compkey", Constants.SMS_COMPKEY);
        	smsMap.setString("id", Constants.SMS_ID);
        	
        	//System.out.println("chichi 관리자 -----> 신청자 승인 메세지: " + smsMap.getString("msg"));
        	
        	mailSmsMapper.insertSmsMsg(smsMap); //sms테이블에 등록.
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
	} //End insertSmsMsgReservation()
	
	/**
	 * 관리자 패스어드 수정
	 */
	public DataMap insertSmsMsgPasswd(DataMap requestMap) throws BizException {
		DataMap resultMap = new DataMap();
		
        try {
            String hp   = requestMap.getString("smsPhone");	// 휴대폰
            String message = requestMap.getString("txtMessage");
            String name = requestMap.getString("name");
            String userno = requestMap.getString("userno");
            String passwd = requestMap.getString("passwd").replace("[", "").replace("]", "");
            		
        	DataMap smsMap = new DataMap();
        	smsMap.setNullToInitialize(true);
        	
        	smsMap.setString("phone", hp.replaceAll("-", ""));
        	smsMap.setString("callback", "0324407684");
        	smsMap.setString("status", Constants.SMS_STATUS);
        	smsMap.setString("msg", message);
        	smsMap.setString("compkey", Constants.SMS_COMPKEY);
        	smsMap.setString("id", Constants.SMS_ID);
        	
        	mailSmsMapper.insertSmsMsg(smsMap); //sms테이블에 등록.

        	// 전송 메세지 담기
        	resultMap.setString("userno", userno); 
        	resultMap.setString("name", name);
        	resultMap.setString("hp", hp);
        	resultMap.setString("msg", message); //전송 메세지 담기
        	
        	Map<String, Object> params = new HashMap<String, Object>();
        	
        	params.put("userno", userno);
        	params.put("passwd", passwd);
        	
        	commonMapper.updatePasswd(params);
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return resultMap;
	}
	
	/**
	 * 메세지 보내기
	 */
	public void insertSmsMsgAction(DataMap requestMap) throws BizException {
		
//        try {
          	String strRA_HP = StringReplace.change(requestMap.getString("hp"), "-", ""); 
    		DataMap smsMap = new DataMap();
        	smsMap.setNullToInitialize(true);
        	
        	//smsMap.setString("phone", adminList.getString("hp", i));
        	smsMap.setString("phone", strRA_HP);
        	
        	smsMap.setString("callback", requestMap.getString("callback"));
        	smsMap.setString("status", Constants.SMS_STATUS);
        	smsMap.setString("msg", requestMap.getString("txtMessage"));
        	smsMap.setString("compkey", Constants.SMS_COMPKEY);
        	smsMap.setString("id", Constants.SMS_ID);
        	
        	// test 
//        	mailSmsMapper.insertSmsMsg(smsMap); //SMS 테이블에 등록.
//        } catch (SQLException e) {
//            throw new BizException(Message.getKey(e), e);
//        } finally {
//        	
//        }
	}

}
