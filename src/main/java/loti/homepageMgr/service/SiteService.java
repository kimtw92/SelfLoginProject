package loti.homepageMgr.service;

import java.sql.SQLException;
import java.util.Map;

import loti.homepageMgr.mapper.SiteMapper;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import ut.lib.exception.BizException;
import ut.lib.page.PageNavigation;
import ut.lib.support.DataMap;
import ut.lib.util.Message;
import ut.lib.util.Util;

import common.service.BaseService;

@Service
public class SiteService extends BaseService {
	
	@Autowired
	private SiteMapper siteMapper;
	
	/**
	 * 사이트관리 리스트
	 * 작성일 6월 22일
	 * 작성자 정윤철
	 * @param pagingInfoMap
	 * @return selectFaqList
	 * @throws Exception
	 */
	public DataMap selectSiteList(DataMap pagingInfoMap) throws Exception{
			
	    DataMap resultMap = null;
	    
	    try {
	    	
	    	int totalCnt = siteMapper.selectSiteListCount(pagingInfoMap);
        	
        	Map<String, Object> pageInfo = Util.getPageInfo(totalCnt, pagingInfoMap);
        	
        	pagingInfoMap.set("page", pageInfo);
        	
            resultMap = siteMapper.selectSiteList(pagingInfoMap);
            
            PageNavigation pageNavi = Util.getPageNavigation(pageInfo);
		    resultMap.set("PAGE_INFO", pageNavi);
	        
	        
	    } catch (SQLException e) {
	        throw new BizException(Message.getKey(e), e);
	    } finally {
	    }
	    return resultMap;        
	}

	/**
	 * 사이트관리 리스트
	 * 작성일 6월 22일
	 * 작성자 정윤철
	 * @param pagingInfoMap
	 * @return selectFaqList
	 * @throws Exception
	 */
	public DataMap selectSiteRow(int siteNo) throws Exception{
			
	    DataMap resultMap = null;
	    
	    try {
	    	
	        resultMap = siteMapper.selectSiteRow(siteNo);
	        
	    } catch (SQLException e) {
	        throw new BizException(Message.getKey(e), e);
	    } finally {
	    }
	    return resultMap;        
	}
	
	/**
	 * 사이트관리 등록
	 * 작성일 6월 22일
	 * 작성자 정윤철
	 * @param pagingInfoMap
	 * @return selectFaqList
	 * @throws Exception
	 */
	public int insertSite(DataMap requestMap) throws Exception{
			
	    int returnValue = 0 ;
	    try {
	    	
	        returnValue = siteMapper.insertSite(requestMap);
	        
	    } catch (SQLException e) {
	        throw new BizException(Message.getKey(e), e);
	    } finally {
	    }
	    return returnValue;        
	}
	
	/**
	 * 사이트관리 등록
	 * 작성일 6월 22일
	 * 작성자 정윤철
	 * @param pagingInfoMap
	 * @return selectFaqList
	 * @throws Exception
	 */
	public int modifySite(DataMap requestMap) throws Exception{
			
	    int returnValue = 0 ;
	    try {
	    	
	        returnValue = siteMapper.modifySite(requestMap);
	        
	    } catch (SQLException e) {
	        throw new BizException(Message.getKey(e), e);
	    } finally {
	    }
	    return returnValue;        
	}
	
	/**
	 * 사이트관리 등록
	 * 작성일 6월 22일
	 * 작성자 정윤철
	 * @param pagingInfoMap
	 * @return selectFaqList
	 * @throws Exception
	 */
	public int deleteSite(int siteNo) throws Exception{
			
	    int returnValue = 0 ;
	    try {
	    	
	        returnValue = siteMapper.deleteSite(siteNo);
	        
	    } catch (SQLException e) {
	        throw new BizException(Message.getKey(e), e);
	    } finally {
        	returnValue = 1;
	    }
	    return returnValue;        
	}
}
