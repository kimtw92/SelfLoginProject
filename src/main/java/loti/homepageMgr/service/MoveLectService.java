package loti.homepageMgr.service;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

import loti.homepageMgr.mapper.MoveLectMapper;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import ut.lib.exception.BizException;
import ut.lib.page.PageNavigation;
import ut.lib.support.DataMap;
import ut.lib.util.Message;
import ut.lib.util.Util;
import common.service.BaseService;

@Service
public class MoveLectService extends BaseService {

	@Autowired
	private MoveLectMapper moveLectMapper;
	
	/**
	 * 식단관리 리스트
	 */
	public DataMap selectMovelectList(DataMap requestMap) throws BizException{
		DataMap resultMap = null;
	    String where = "";
	    
	    try {
	    	if(!requestMap.getString("title").equals("")){
	        	where = "WHERE TITLE LIKE '%"+requestMap.getString("title")+"%'";
	        }
	        
	    	Map<String, Object> paramMap = new HashMap<String, Object>();
	    	paramMap.put("where", where);
	    	
	    	int moveLectListCount = moveLectMapper.selectMoveLectListCount(paramMap);
	    	
	    	Map<String, Object> pageInfo = Util.getPageInfo(moveLectListCount, requestMap);
	    	pageInfo.put("where", where);
	    	
	        resultMap = moveLectMapper.selectMoveLectList(pageInfo);
	        
	        PageNavigation pageNavi = Util.getPageNavigation(pageInfo);
			
			resultMap.set("PAGE_INFO", pageNavi);
	    } catch (SQLException e) {
	        throw new BizException(Message.getKey(e), e);
	    } finally {
	    }
	    return resultMap;        
	}
	
	/**
	 * 섬네일이미지 리스트 
	 */
	public DataMap selectFileUrl(String groupfileNo) throws BizException{
		DataMap resultMap = null;
		
	    try {
	    	resultMap = moveLectMapper.selectFileUrl(groupfileNo);
	    } catch (SQLException e) {
	        throw new BizException(Message.getKey(e), e);
	    } finally {
	    	
	    }
	    return resultMap;        
	}

	/**
	 * 식단관리 뷰, 폼데이터
	 */
	public DataMap selectMovelectRow(DataMap requestMap) throws BizException{
		DataMap resultMap = null;
	    
	    try {
	    	resultMap = moveLectMapper.selectMoveLectRow(requestMap.getString("seq"));
	    } catch (SQLException e) {
	        throw new BizException(Message.getKey(e), e);
	    } finally {
	    	
	    }
	    return resultMap;        
	}
	
	/**
	 * 식단관리 등록
	 */
	public int insertMovelect(DataMap requestMap) throws BizException{
		int returnValue = 0;
	    
	    try {
	    	returnValue = moveLectMapper.insertMovelect(requestMap);
	    } catch (SQLException e) {
	        throw new BizException(Message.getKey(e), e);
	    } finally {
	    	
	    }
	    return returnValue;        
	}
	
	/**
	 * 수정
	 */
	public int updateMovelect(DataMap requestMap) throws BizException{
		int returnValue = 0;
	    
	    try {
	    	returnValue = moveLectMapper.updateMovelect(requestMap);
	    } catch (SQLException e) {
	        throw new BizException(Message.getKey(e), e);
	    } finally {
	    	
	    }
	    return returnValue;        
	}
	
	/**
	 * 삭제
	 */
	public int deleteMovelect(DataMap requestMap) throws BizException{
		int returnValue = 0;
	    
	    try {
	    	returnValue = moveLectMapper.deleteMovelect(requestMap);
	    } catch (SQLException e) {
	        throw new BizException(Message.getKey(e), e);
	    } finally {
	    	
	    }
	    return returnValue;        
	}
}
