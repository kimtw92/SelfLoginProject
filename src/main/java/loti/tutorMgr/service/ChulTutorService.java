package loti.tutorMgr.service;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import loti.tutorMgr.mapper.ChulTutorMapper;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import ut.lib.exception.BizException;
import ut.lib.page.PageNavigation;
import ut.lib.support.DataMap;
import ut.lib.util.Message;
import ut.lib.util.Util;

import common.service.BaseService;

@Service
public class ChulTutorService extends BaseService {

	@Autowired
	private ChulTutorMapper chulTutorMapper;
	
	/**
	 * 출강강사 리스트
	 * 작성일 7월 10일
	 * 작성자 정윤철
	 * @param requestMap
	 * @return selectChulTutorList
	 * @throws SQLException e
	 */
	public DataMap selectChulTutorList(DataMap requestMap) throws Exception{
			
		DataMap resultMap = null;
	    String where  = "";
	    try {
	        
	    	int totalCnt = chulTutorMapper.selectChulTutorListCount(requestMap);
        	
        	Map<String, Object> pageInfo = Util.getPageInfo(totalCnt, requestMap);
        	
        	requestMap.set("page", pageInfo);
        	
            resultMap = chulTutorMapper.selectChulTutorList(requestMap);
            
            PageNavigation pageNavi = Util.getPageNavigation(pageInfo);
            resultMap.set("PAGE_INFO", pageNavi);
	    	
	    } catch (SQLException e) {
	        throw new BizException(Message.getKey(e), e);
	    } finally {
	    }
	    return resultMap;        
	}

	/**
	 * 출강강사 총카운트
	 * 작성일 7월 10일
	 * 작성자 정윤철
	 * @param 
	 * @return selectChulTutorAllCountRow
	 * @throws SQLException e
	 */
	public DataMap selectChulTutorAllCountRow() throws Exception{
			
		DataMap resultMap = null;
	    try {
	    	
	        resultMap = chulTutorMapper.selectChulTutorAllCountRow();
	        
	    } catch (SQLException e) {
	        throw new BizException(Message.getKey(e), e);
	    } finally {
	    }
	    return resultMap;        
	}

	/**
	 * 출강강사 과정별 총카운트
	 * 작성일 7월 10일
	 * 작성자 정윤철
	 * @param grcode
	 * @return selectChulTutorCourseAllCountRow
	 * @throws SQLException e
	 */
	public DataMap selectChulTutorCourseAllCountRow(String grcode) throws Exception{
			
		DataMap resultMap = null;
	    try {
	    	
	        resultMap = chulTutorMapper.selectChulTutorCourseAllCountRow(grcode);
	        
	    } catch (SQLException e) {
	        throw new BizException(Message.getKey(e), e);
	    } finally {
	    }
	    return resultMap;        
	}

	/**
	 * 출강강사 과정별 카운트
	 * 작성일 7월 10일
	 * 작성자 정윤철
	 * @param grcode
	 * @return selectChulTutorCourseAllCountRow
	 * @throws SQLException e
	 */
	public DataMap selectChulTutorCourseCountRow(String grcode) throws Exception{
			
		DataMap resultMap = null;
	    try {
	    	
	        resultMap = chulTutorMapper.selectChulTutorCourseCountRow(grcode);
	        
	    } catch (SQLException e) {
	        throw new BizException(Message.getKey(e), e);
	    } finally {
	    }
	    return resultMap;        
	}
	
	/**
	 * 출강강사 과정별 카운트
	 * 작성일 7월 10일
	 * 작성자 정윤철
	 * @param grcode
	 * @return selectChulTutorCourseAllCountRow
	 * @throws SQLException e
	 */
	public DataMap selectCoursorList() throws Exception{
			
		DataMap resultMap = null;
	    try {
	    	
	        resultMap = chulTutorMapper.selectCoursorList();
	        
	    } catch (SQLException e) {
	        throw new BizException(Message.getKey(e), e);
	    } finally {
	    }
	    return resultMap;        
	}

	public DataMap selectChulTutorListExcel(DataMap requestMap) throws BizException {
		DataMap resultMap = null;
	    String where  = "";
	    try {
	        
            resultMap = chulTutorMapper.selectChulTutorListExcel(requestMap);
            
	    } catch (SQLException e) {
	        throw new BizException(Message.getKey(e), e);
	    } finally {
	    }
	    return resultMap;        
	}

	/**
	 * 출강강사관리 리스트
	 * 작성일 7월 11일
	 * 작성자 정윤철
	 * @param pagingInfoMap
	 * @return selectTotalList
	 * @throws SQLException e
	 */
	public DataMap selectTotalList(DataMap requestMap) throws Exception{
			
		DataMap resultMap = null;
	    try {
	    	
	    	int totalCnt = chulTutorMapper.selectTotalListCount(requestMap);
        	
        	Map<String, Object> pageInfo = Util.getPageInfo(totalCnt, requestMap);
        	
        	requestMap.set("page", pageInfo);
        	
            resultMap = chulTutorMapper.selectTotalList(requestMap);
            
            PageNavigation pageNavi = Util.getPageNavigation(pageInfo);
            resultMap.set("PAGE_INFO", pageNavi);
	    	
	    } catch (SQLException e) {
	        throw new BizException(Message.getKey(e), e);
	    } finally {
	    }
	    return resultMap;        
	}

}
