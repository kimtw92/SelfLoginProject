package loti.homepageMgr.service;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

import loti.homepageMgr.mapper.HtmlMapper;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import ut.lib.exception.BizException;
import ut.lib.page.PageNavigation;
import ut.lib.support.DataMap;
import ut.lib.util.Message;
import ut.lib.util.Util;
import common.service.BaseService;

@Service("homepageMgrHtmlService")
public class HtmlService extends BaseService {

	@Autowired
	@Qualifier("homepageMgrHtmlMapper")
	private HtmlMapper htmlMapper;
	
	/**
	 * Html관리 리스트
	 */
	public DataMap selectHtmlList(DataMap pagingInfoMap) throws BizException{
		DataMap resultMap = new DataMap();
	    
	    //검색 조건이 있을시 where절을 만든다.
	    String where  = "";
	    try {
	    	if(pagingInfoMap.getString("selectType").equals("all")){
	        	where  = "WHERE HTML_TITLE LIKE '%"+pagingInfoMap.getString("selectValue")+"%' OR HTML_CONTENT LIKE '%"+pagingInfoMap.getString("selectValue")+"%'";
	        }else if(pagingInfoMap.getString("selectType").equals("title") || pagingInfoMap.getString("selectType").equals("content")){
	        	//리퀘스트로 넘어갈때 언더바가 있어서 에러가나기에 따로 정의 
	        	if(pagingInfoMap.getString("selectType").equals("title")){
	        		where  = "WHERE HTML_TITLE LIKE '%"+pagingInfoMap.getString("selectValue")+"%'";
	        	}else{
	        		where  = "WHERE HTML_CONTENT LIKE '%"+pagingInfoMap.getString("selectValue")+"%'";
	        	}
	        }else{
	        	where  = "";
	        }
	        
	    	Map<String, Object> paramMap = new HashMap<String, Object>();
	    	paramMap.put("where", where);
	    	
	    	int htmlListCount = htmlMapper.selectHtmlListCount(paramMap);
	    	
	    	Map<String, Object> pageInfo = Util.getPageInfo(htmlListCount, pagingInfoMap);
	    	pageInfo.put("where", where);
	    	
	        resultMap = htmlMapper.selectHtmlList(pageInfo);
	        
	        PageNavigation pageNavi = Util.getPageNavigation(pageInfo);
			
			resultMap.set("PAGE_INFO", pageNavi);
	    } catch (SQLException e) {
	        throw new BizException(Message.getKey(e), e);
	    } finally {
	    	
	    }
	    return resultMap;        
	}
	
	/**
	 * Html관리 상세데이터(미리보기)
	 */
	public DataMap selectHtmlRow(String htmlId) throws BizException{
		DataMap resultMap = new DataMap();
	    
	    try {
	    	resultMap = htmlMapper.selectHtmlRow(htmlId);
	    } catch (SQLException e) {
	        throw new BizException(Message.getKey(e), e);
	    } finally {
	    	
	    }
	    return resultMap;        
	}
	
	/**
	 * Html관리 등록실행
	 */
	public int insertHtml(DataMap requestMap) throws BizException{
		int returnValue = 0;
	    int count = 0;
	    
	    try {
	    	count = htmlMapper.selectHtmlCountRow(requestMap.getString("htmlId"));
	        if(count <= 0){
	        	returnValue = htmlMapper.insertHtml(requestMap);
	        	requestMap.setString("msg","등록 하였습니다.");
	        	requestMap.setString("complate","ok");
	        }else{
	        	requestMap.setString("msg","중복된 Html Id가 있습니다.");
	        	requestMap.setString("complate","cancle");
	        }
	    } catch (SQLException e) {
	        throw new BizException(Message.getKey(e), e);
	    } finally {
	    	
	    }
	    return returnValue;        
	}
	
	/**
	 * Html관리 수정실행
	 */
	public int modifyHtml(DataMap requestMap) throws BizException{
		int returnValue = 0;
	    
	    try {
	    	returnValue = htmlMapper.modifyHtml(requestMap);
	    } catch (SQLException e) {
	        throw new BizException(Message.getKey(e), e);
	    } finally {
	    	
	    }
	    return returnValue;        
	}
	
	/**
	 * Html관리 삭제실행
	 */
	public int deleteHtml(String htmlId) throws BizException{
		int returnValue = 0;
	    
	    try {
	    	returnValue = htmlMapper.deleteHtml(htmlId);
	    } catch (SQLException e) {
	        throw new BizException(Message.getKey(e), e);
	    } finally {
	    	
	    }
	    return returnValue;        
	}
}
