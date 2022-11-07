package loti.homepageMgr.service;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

import loti.homepageMgr.mapper.PersonInfoMapper;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import ut.lib.exception.BizException;
import ut.lib.page.PageNavigation;
import ut.lib.support.DataMap;
import ut.lib.util.Message;
import ut.lib.util.Util;
import common.service.BaseService;

@Service
public class PersonInfoService extends BaseService {

	@Autowired
	private PersonInfoMapper personInfoMapper;
	
	/**
	 * 개인정보조회출력 리스트
	 */
	public DataMap selectPersonInfoList(DataMap pagingInfoMap) throws BizException{
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
		    paramMap.put("date1", pagingInfoMap.getString("date1"));
		    paramMap.put("date2", pagingInfoMap.getString("date2"));
		    paramMap.put("where", where);
		    
		    int personInfoListCount = personInfoMapper.selectPersonInfoListCount(paramMap);
		    
		    Map<String, Object> pageInfo = Util.getPageInfo(personInfoListCount, pagingInfoMap);
        	pageInfo.put("date1", pagingInfoMap.getString("date1"));
			pageInfo.put("date2", pagingInfoMap.getString("date2"));
			pageInfo.put("where", where);
			
		    resultMap = personInfoMapper.selectPersonInfoList(pageInfo);
		    
		    PageNavigation pageNavi = Util.getPageNavigation(pageInfo);
			
			resultMap.set("PAGE_INFO", pageNavi);
	    } catch (SQLException e) {
	        throw new BizException(Message.getKey(e), e);
	    } finally {
	    	
	    }
	    return resultMap;        
	}
	
	/**
	 * 개인정보조회출력 엑셀
	 */
	public DataMap selectPersonInfoExcel(DataMap pagingInfoMap) throws BizException{
	    DataMap resultMap = null;
	    String where = "";
	    
	    try {
		    if(!pagingInfoMap.getString("searchName").equals("")){
		    	where += " AND B.NAME LIKE '"+pagingInfoMap.getString("searchName")+"%'";
		    }
		    
		    if(!pagingInfoMap.getString("searchName").equals("") && !pagingInfoMap.getString("searchContents").equals("")){
		    	where += " AND A.CONTENT LIKE '%" + pagingInfoMap.getString("searchContents")+"%'";
		    }
		    
		    Map<String, Object> paramMap = new HashMap<String, Object>();
		    paramMap.put("date1", pagingInfoMap.getString("date1"));
		    paramMap.put("date2", pagingInfoMap.getString("date2"));
		    paramMap.put("where", where);
		    
		    resultMap = personInfoMapper.selectPersonInfoExcel(paramMap);
	    } catch (SQLException e) {
	        throw new BizException(Message.getKey(e), e);
	    } finally {
	    	
	    }
	    return resultMap;        
	}
}
