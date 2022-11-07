package loti.tutorMgr.service;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import loti.tutorMgr.mapper.TutorClassMapper;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import ut.lib.exception.BizException;
import ut.lib.page.PageNavigation;
import ut.lib.support.DataMap;
import ut.lib.util.Message;
import ut.lib.util.Util;

import common.service.BaseService;


@Service
public class TutorClassService extends BaseService {

	@Autowired
	private TutorClassMapper tutorClassMapper;
	
	public DataMap selectTutorClassList(DataMap requestMap, String grCode,
			String grSeq, String sqlWhere) throws BizException {

		DataMap resultMap = null;
        
        try {
        	
        	Map<String, Object> params = new HashMap<String, Object>();
        	
        	params.put("grcode", grCode);
        	params.put("grseq", grSeq);
        	params.put("subj", requestMap.getString("searchSubj"));
        	
        	int totalCnt = tutorClassMapper.selectTutorClassListCount(params);
        	
        	params.putAll(Util.getPageInfo(totalCnt, requestMap));
        	
            resultMap = tutorClassMapper.selectTutorClassList(params);
            
           	PageNavigation pageNavi = Util.getPageNavigation(params);
           	resultMap.set("PAGE_INFO", pageNavi);
        	
                                    
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return resultMap; 
		
	}

	public DataMap selectSubjSeq(String grCode, String grSeq) throws BizException {

		DataMap resultMap = null;
        
        try {
        	
        	Map<String, Object> params = new HashMap<String, Object>();
        	
        	params.put("grcode", grCode);
        	params.put("grseq", grSeq);
        	
            resultMap = tutorClassMapper.selectSubjSeq(params);
                                    
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return resultMap;  
	}

	public DataMap selectTutorSubjInputList(DataMap requestMap) throws BizException {
		
		DataMap resultMap = null;
        
        try {
        	
        	int totalCnt = tutorClassMapper.selectTutorSubjInputListCount(requestMap);
        	
        	Map<String, Object> pageInfo = Util.getPageInfo(totalCnt, requestMap);
        	
        	pageInfo.put("requestMap", requestMap);
        	
            resultMap = tutorClassMapper.selectTutorSubjInputList(pageInfo);
            
            PageNavigation pageNavi = Util.getPageNavigation(pageInfo);
            resultMap.set("PAGE_INFO", pageNavi);
        	
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return resultMap;        
	}

	public DataMap selectClassTutorInfo(DataMap requestMap) throws BizException {

		DataMap resultMap = null;
        
        try {
        	
        	int totalCnt = tutorClassMapper.selectClassTutorInfoCount(requestMap);
        	
        	Map<String, Object> pageInfo = Util.getPageInfo(totalCnt, requestMap);
        	
        	pageInfo.put("requestMap", requestMap);
        	
            resultMap = tutorClassMapper.selectClassTutorInfo(pageInfo);
            
            PageNavigation pageNavi = Util.getPageNavigation(pageInfo);
            resultMap.set("PAGE_INFO", pageNavi);
        	
//            resultMap = tutorClassMapper.selectClassTutorInfo( requestMap, grcode, grseq, subj, classno );
                                    
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return resultMap;        
	}

	public DataMap selectClassRoom() throws BizException {

		DataMap resultMap = null;
        
        try {
        	
            resultMap = tutorClassMapper.selectClassRoom();
                                    
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return resultMap;        
	}

	public int updateClassTutor(DataMap requestMap) throws BizException {
		
        int returnValue = 0;                       
        
        try {
        	
            returnValue = tutorClassMapper.updateClassTutor(requestMap);
            
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return returnValue;  
	}
	
	// --------------------------------------------------------------------------------------------------
	

	
	/**
	 * 강사지정 중복 체크
	 * @param grcode
	 * @param grseq
	 * @param subj
	 * @param tuserno
	 * @param classno
	 * @return
	 * @throws Exception
	 */
	public DataMap checkClassTutor(DataMap requestMap) throws Exception{
		
//		String grcode, String grseq, String subj, String tuserno, String classno
		
		DataMap resultMap = null;
        
        try {
        	
            resultMap = tutorClassMapper.checkClassTutor(requestMap);
                                    
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return resultMap;        
	}
	
	
	/**
	 * 강사지정 insert
	 * @param subj
	 * @param grcode
	 * @param grseq
	 * @param classno
	 * @param tuserno
	 * @param tgubun
	 * @param groupfileNo
	 * @param resourceNo
	 * @param carReserveYn
	 * @param classroomNo
	 * @param lecevalpoint
	 * @return
	 * @throws Exception
	 */
	public int insertClassTutor(DataMap requestMap) throws Exception{
		
//		String subj, String grcode, String grseq, String classno, String tuserno,
//		String tgubun, String groupfileNo, String resourceNo, String carReserveYn, String classroomNo,
//		String lecevalpoint
		
        int returnValue = 0;                       
        
        try {
        	
            returnValue = tutorClassMapper.insertClassTutor(requestMap);
                                    
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return returnValue;        
	}
	
	/**
	 * 강사지정 delete
	 * @param subj
	 * @param grcode
	 * @param grseq
	 * @param classno
	 * @param tuserno
	 * @return
	 * @throws Exception
	 */
	public int deleteClassTutor(DataMap requestMap) throws Exception{
		
//		String subj, String grcode, String grseq, String classno, String tuserno
		
        int returnValue = 0;                       
        
        try {
            returnValue = tutorClassMapper.deleteClassTutor(requestMap);
            
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return returnValue;        
	}
	

	
	/**
	 * 강사소개 팝업 : 강사기본정보
	 * @param userno
	 * @return
	 * @throws Exception
	 */
	public DataMap tutorInfoPopByBaseInfo(String userno) throws Exception{
		
		DataMap resultMap = null;
        
        try {
        	
            resultMap = tutorClassMapper.tutorInfoPopByBaseInfo(userno);
                                    
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return resultMap;        
	}
	
	/**
	 * 강사소개 팝업 : 경력사항
	 * @param userno
	 * @return
	 * @throws Exception
	 */
	public DataMap tutorInfoPopByHistory(String userno) throws Exception{
		
		DataMap resultMap = null;
        
        try {
        	
            resultMap = tutorClassMapper.tutorInfoPopByHistory(userno);
                                    
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return resultMap;        
	}
	
	/**
	 * 강사소개 팝업 : 출강현황
	 * @param userno
	 * @return
	 * @throws Exception
	 */
	public DataMap tutorInfoPopByClassTutor(String userno) throws Exception{
		
		DataMap resultMap = null;
        
        try {
        	
            resultMap = tutorClassMapper.tutorInfoPopByClassTutor(userno);
                                    
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return resultMap;        
	}
	
	public DataMap tutorInfoPopByClassTutorNew(String userno) throws Exception{
		
		DataMap resultMap = null;
        
        try {
        	
            resultMap = tutorClassMapper.tutorInfoPopByClassTutorNew(userno);
                                    
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return resultMap;        
	}

}
