package loti.homepageMgr.service;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

import loti.homepageMgr.mapper.PopupZoneMapper;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import ut.lib.exception.BizException;
import ut.lib.page.PageNavigation;
import ut.lib.support.DataMap;
import ut.lib.util.Message;
import ut.lib.util.Util;
import common.service.BaseService;

@Service("homepageMgrPopupZoneService")
public class PopupZoneService extends BaseService {

	@Autowired
	@Qualifier("homepageMgrPopupZoneMapper")
	private PopupZoneMapper popupZoneMapper;
	
	/**
	 * 개인정보조회출력 리스트
	 */
	public DataMap selectPopupZoneList(DataMap pagingInfoMap) throws BizException{
	    DataMap resultMap = new DataMap();
	    String where = "";
	    
	    try {
		    if(!pagingInfoMap.getString("searchName").equals("")){
		    	where += " AND B.NAME LIKE '"+pagingInfoMap.getString("searchName")+"%'";
		    }
		    if(!pagingInfoMap.getString("searchName").equals("") && !pagingInfoMap.getString("searchContents").equals("")){
		    	where += " AND A.CONTENT LIKE '%" + pagingInfoMap.getString("searchContents")+"%'";
		    }
		    
		    Map<String, Object> paramMap = new HashMap<String, Object>();
		    paramMap.put("where", where);
		    
		    int popupZoneListCount = popupZoneMapper.selectPopupZoneListCount(paramMap);
		    
		    Map<String, Object> pageInfo = Util.getPageInfo(popupZoneListCount, pagingInfoMap);
	    	pageInfo.put("where", where);
	    	
		    resultMap = popupZoneMapper.selectPopupZoneList(pageInfo);
		    
		    PageNavigation pageNavi = Util.getPageNavigation(pageInfo);
			
			resultMap.set("PAGE_INFO", pageNavi);
	    } catch (SQLException e) {
	        throw new BizException(Message.getKey(e), e);
	    } finally {
	    	
	    }
	    return resultMap;        
	}
	
	public int insert(DataMap requestMap) throws BizException{
		int returnValue = 0;
	    
	    try {
	    	returnValue = popupZoneMapper.insertPopupZone(requestMap);
	    } catch (SQLException e) {
	        throw new BizException(Message.getKey(e), e);
	    } finally {
	    	
	    }
	    return returnValue;        
	}

	public DataMap selectPopupZone(String seq) throws BizException {
		DataMap resultMap = null;
	    
	    try {
		    resultMap = popupZoneMapper.selectPopupZone(seq);
	    } catch (SQLException e) {
	        throw new BizException(Message.getKey(e), e);
	    } finally {
	    	
	    }
	    return resultMap;
	}
	
	public int fileDelete(DataMap requestMap) throws BizException{
		int returnValue = 0;
	    
	    try {
	    	returnValue = popupZoneMapper.deletePopupZoneFile(requestMap);
	    } catch (SQLException e) {
	        throw new BizException(Message.getKey(e), e);
	    } finally {
	    	
	    }
	    return returnValue;        
	}

	public int delete(String seq) throws BizException {
		int returnValue = 0;
	    
	    try {
	    	returnValue = popupZoneMapper.deletePopupZone(seq);
	    } catch (SQLException e) {
	        throw new BizException(Message.getKey(e), e);
	    } finally {
	    	
	    }
	    return returnValue;  
	}

	public int update(DataMap requestMap) throws BizException {
		int returnValue = 0;
	    
	    try {
	    	StringBuffer sbReplaceSet = new StringBuffer();
	    	sbReplaceSet.append("");
	    	
	    	Map<String, Object> paramMap = new HashMap<String, Object>();
	    	paramMap.put("", requestMap.getString("title"));
			paramMap.put("", requestMap.getString("dtYn"));
			paramMap.put("", requestMap.getString("sDate"));
			paramMap.put("", requestMap.getString("sTime"));
			paramMap.put("", requestMap.getString("eDate"));
			paramMap.put("", requestMap.getString("eTime"));
			paramMap.put("", requestMap.getString("linkYn"));
			paramMap.put("", requestMap.getString("linkUrl"));
			paramMap.put("", requestMap.getString("linkTarget"));
			if(!requestMap.getString("fileName").equals("")) {
		    	sbReplaceSet.append("FILE_NAME = '").append(requestMap.getString("fileName")).append("', ");
			}
			paramMap.put("replaceSet", sbReplaceSet.toString());
			paramMap.put("", requestMap.getString("fileAlt"));
			paramMap.put("", requestMap.getString("usedYn"));
			paramMap.put("", requestMap.getString("modId"));
			paramMap.put("", requestMap.getString("seq"));
			
	    	returnValue = popupZoneMapper.updatePopupZone(requestMap);
	    } catch (SQLException e) {
	        throw new BizException(Message.getKey(e), e);
	    } finally {
	    	
	    }
	    return returnValue;
	}

	public DataMap getMainPopupZoneList() throws BizException {
		DataMap resultMap = new DataMap();
	    
	    try {
		    resultMap = popupZoneMapper.getMainPopupZoneList();
	    } catch (SQLException e) {
	        throw new BizException(Message.getKey(e), e);
	    } finally {
	    	
	    }
	    return resultMap;  
	}
}
