package loti.member.service;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.Map;

import loti.member.mapper.EmployeeMapper;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import ut.lib.exception.BizException;
import ut.lib.page.PageNavigation;
import ut.lib.support.DataMap;
import ut.lib.util.Message;
import ut.lib.util.Util;

import common.service.BaseService;

@Service
public class EmployeeService extends BaseService {

	@Autowired
	private EmployeeMapper employeeMapper;
	
	/**
	 * 직원관리 리스트
	 * 작성일 8월 19일
	 * 작성자 정윤철
	 * 
	 * @param requestMap
	 * @return
	 * @throws Exception
	 */
	public DataMap selectMemberStatsList(DataMap requestMap) throws Exception{
		
        DataMap resultMap = null;
        String search = "";
        
        try {
        	
	    	int totalCnt = employeeMapper.selectMemberStatsListCount(requestMap);
        	
        	Map<String, Object> pageInfo = Util.getPageInfo(totalCnt, requestMap);
        	
        	requestMap.set("page", pageInfo);
        	
            resultMap = employeeMapper.selectMemberStatsList(requestMap);
            
            PageNavigation pageNavi = Util.getPageNavigation(pageInfo);
		    resultMap.set("PAGE_INFO", pageNavi);
            
            
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return resultMap;        
	}
	
	
	/**
	 * 직원관리 로우데이터
	 * 작성일 8월 19일
	 * 작성자 정윤철
	 * 
	 * @param requestMap
	 * @return
	 * @throws Exception
	 */
	public DataMap selectMemberStatsRow(DataMap requestMap) throws Exception{
		
        DataMap resultMap = null;
        
        try {
            
            resultMap = employeeMapper.selectMemberStatsRow(requestMap);
      
            
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return resultMap;        
	}
		
		
	/**
	 * 직원관리 등록
	 * 작성일 8월 19일
	 * 작성자 정윤철
	 * 
	 * @param requestMap
	 * @return
	 * @throws Exception
	 */
		public int insertMemberStats(DataMap requestMap) throws Exception{
			
	        int returnValue = 0;
	        
	        try {
	            
	            returnValue = employeeMapper.insertMemberStats(requestMap);
	      
	            
	        } catch (SQLException e) {
	            throw new BizException(Message.getKey(e), e);
	        } finally {
	        }
	        return returnValue;        
		}	
		

	/**
	 * 직원관리 수정
	 * 작성일 8월 19일
	 * 작성자 정윤철
	 * 
	 * @param requestMap
	 * @return
	 * @throws Exception
	 */
	public int modifyMemberStats(DataMap requestMap) throws Exception{
		
	    int returnValue = 0;
	    
	    try {
	        
	        returnValue = employeeMapper.modifyMemberStats(requestMap);
	  
	        
	    } catch (SQLException e) {
	        throw new BizException(Message.getKey(e), e);
	    } finally {
	    }
	    return returnValue;        
	}
		
	/**
	 * 직원관리 삭제
	 * 작성일 8월 19일
	 * 작성자 정윤철
	 * 
	 * @param requestMap
	 * @return
	 * @throws Exception
	 */
	public int deleteMemberStats(DataMap requestMap) throws Exception{
		
	    int returnValue = 0;
	    
	    try {
	        
	        
	        returnValue = employeeMapper.deleteMemberStats(requestMap);
	  
	        
	    } catch (SQLException e) {
	        throw new BizException(Message.getKey(e), e);
	    } finally {
	    }
	    return returnValue;        
	}
}
