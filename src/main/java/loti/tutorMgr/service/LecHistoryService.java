package loti.tutorMgr.service;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import loti.tutorMgr.mapper.LecHistoryMapper;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import ut.lib.exception.BizException;
import ut.lib.page.PageNavigation;
import ut.lib.support.DataMap;
import ut.lib.util.Message;
import ut.lib.util.Util;

import common.service.BaseService;


@Service
public class LecHistoryService extends BaseService {

	@Autowired
	private LecHistoryMapper lecHistoryMapper;
	
	public DataMap tutorLecHistoryList(DataMap requestMap) throws BizException {
		
		DataMap resultMap = null;
		
		try {
				
        	int totalCnt = lecHistoryMapper.tutorLecHistoryListCount(requestMap);
        	
        	Map<String, Object> pageInfo = Util.getPageInfo(totalCnt, requestMap);
        	
        	pageInfo.put("requestMap", requestMap);
        	
            resultMap = lecHistoryMapper.tutorLecHistoryList(pageInfo);
            
           	PageNavigation pageNavi = Util.getPageNavigation(pageInfo);
           	resultMap.set("PAGE_INFO", pageNavi);
			
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return resultMap;      
	}

	public DataMap tutorLecHistoryInfo(String no) throws BizException {
		
		DataMap resultMap = null;
        
        try {
        	
            resultMap = lecHistoryMapper.tutorLecHistoryInfo(no);
                                    
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return resultMap;        
	}

	public DataMap checkMonday(String strDate) throws BizException {

		DataMap resultMap = null;
        
        try {
        	
            resultMap = lecHistoryMapper.checkMonday(strDate);
                                    
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return resultMap;   
	}

	public DataMap checkLecHistoryDupcnt(DataMap requestMap) throws BizException {
		
		DataMap resultMap = null;
        
        try {
        	
            resultMap = lecHistoryMapper.checkLecHistoryDupcnt(requestMap);
                                    
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return resultMap;  
	}

	public int insertTutorLecHistory(DataMap requestMap, String sessNo) throws BizException {
		
        int returnValue = 0;                       
        
        try {
    		
            returnValue = lecHistoryMapper.insertTutorLecHistory(requestMap);
            
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return returnValue; 
	}

	public int updateTutorLecHistory(DataMap requestMap, String sessNo) throws BizException {
		String grCode = requestMap.getString("grCode");
		String grSeq = requestMap.getString("grSeq");
		String subj = requestMap.getString("subj");
		String strDate = requestMap.getString("strDate");
		String tDate = requestMap.getString("tDate");
		String tTime = requestMap.getString("tTime");
		String eduinwon = requestMap.getString("eduinwon");
		String userno = requestMap.getString("userno");
		
		String no = requestMap.getString("no");
		
		String sqlWhere = "AND NO <> " + no;
		
        int returnValue = 0;                       
        
        try {
        
        	requestMap.setString("sessNo", sessNo);
        	
            returnValue = lecHistoryMapper.updateTutorLecHistory(requestMap);
            
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return returnValue;       
	}

	public DataMap selectLecHistoryDetail(String userno) throws BizException {

		DataMap resultMap = null;
        
        try {
        	
            resultMap = lecHistoryMapper.selectLecHistoryDetail( userno );
                                    
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return resultMap;        
	}
	
	
	
	/**
	 * 강의기록 삭제
	 * @param no
	 * @return
	 * @throws Exception
	 */
	public int deleteTutorLecHistory(String no) throws Exception{
		
        int returnValue = 0;                       
        
        try {
        	
            returnValue = lecHistoryMapper.deleteTutorLecHistory(no);

        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return returnValue;        
	}


}
