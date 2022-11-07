package loti.tutorMgr.service;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import loti.tutorMgr.mapper.LecturerMgrMapper;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import ut.lib.exception.BizException;
import ut.lib.page.PageNavigation;
import ut.lib.support.DataMap;
import ut.lib.util.Message;
import ut.lib.util.Util;

import common.service.BaseService;

import egovframework.rte.psl.dataaccess.util.EgovMap;

@Service
public class LecturerMgrService extends BaseService {

	@Autowired
	private LecturerMgrMapper lecturerMgrMapper;
	
	public DataMap selectLecturerInfoList(DataMap requestMap) throws Exception{
		
		DataMap resultMap = null;

	    try {
	    	
	    	int totalCnt = lecturerMgrMapper.selectLecturerInfoListCount(requestMap);
        	
        	Map<String, Object> pageInfo = Util.getPageInfo(totalCnt, requestMap);
        	
        	requestMap.set("page", pageInfo);
        	
            resultMap = lecturerMgrMapper.selectLecturerInfoList(requestMap);
            
            PageNavigation pageNavi = Util.getPageNavigation(pageInfo);
            resultMap.set("PAGE_INFO", pageNavi);
	    	
	    } catch (SQLException e) {
	        throw new BizException(Message.getKey(e), e);
	    } finally {
	    }
	    return resultMap;        
	}
	
	public String getAjaxCheckYN(DataMap requestMap) throws Exception{
		
	    DataMap resultMap = null;
	    String checkyn = "";

	    try {
	        resultMap = lecturerMgrMapper.getAjaxCheckYN(requestMap);
	        if(resultMap != null) {
	        	checkyn = resultMap.get("checkyn").toString();
	        }
	    } catch (SQLException e) {
	        throw new BizException(Message.getKey(e), e);
	    } finally {
	    }
	    return checkyn;        
	}
	
	public int getAjaxUpdakYN(DataMap requestMap) throws Exception{
		
	    int errorcode = -1;

	    try {
	        
	        errorcode = lecturerMgrMapper.getAjaxUpdakYN(requestMap);
	        
	    } catch (SQLException e) {
	        throw new BizException(Message.getKey(e), e);
	    } finally {
	    }
	    return errorcode;        
	}
}
