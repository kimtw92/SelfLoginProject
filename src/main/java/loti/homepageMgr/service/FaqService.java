package loti.homepageMgr.service;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

import loti.homepageMgr.mapper.FaqMapper;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import ut.lib.exception.BizException;
import ut.lib.page.PageNavigation;
import ut.lib.support.DataMap;
import ut.lib.util.Message;
import ut.lib.util.Util;
import common.service.BaseService;

@Service
public class FaqService extends BaseService {

	@Autowired
	private FaqMapper faqMapper;
	
	/**
	 * 교육관련 FAQ리스트
	 * 작성일 6월 13일
	 * 작성자 정윤철
	 * @param pagingInfoMap
	 * @return selectFaqList
	 * @throws Exception
	 */
	public DataMap selectFaqList(DataMap pagingInfoMap) throws Exception{
			
	    DataMap resultMap = null;
	    
	    //검색 조건이 있을시 where절을 만든다.
	    String where  = "";
	    try {
	    	
	    	int totalCnt = faqMapper.selectFaqListCount(pagingInfoMap);
        	
        	Map<String, Object> pageInfo = Util.getPageInfo(totalCnt, pagingInfoMap);
        	
        	pagingInfoMap.set("page", pageInfo);
        	
            resultMap = faqMapper.selectFaqList(pagingInfoMap);
            
            PageNavigation pageNavi = Util.getPageNavigation(pageInfo);
		    resultMap.set("PAGE_INFO", pageNavi);
	    	
	        
	    } catch (SQLException e) {
	        throw new BizException(Message.getKey(e), e);
	    } finally {
	    }
	    return resultMap;        
	}
	
	/**
	 * 교육관련 FAQ유형
	 * 작성일 6월 13일
	 * 작성자 정윤철
	 * @return selectSubCodeFaqList
	 * @throws Exception
	 */
	public DataMap selectSubCodeFaqList() throws Exception{
			
	    DataMap resultMap = null;
	    
	    try {
	    	
	        resultMap = faqMapper.selectSubCodeFaqList();
	        
	    } catch (SQLException e) {
	        throw new BizException(Message.getKey(e), e);
	    } finally {
	    }
	    return resultMap;        
	}
	
	/**
	 * 교육관련 FAQ 상세페이지
	 * 작성일 6월 13일
	 * 작성자 정윤철
	 * @return selectSubCodeFaqList
	 * @throws Exception
	 */
	public DataMap selectFaqViewRow(String fno) throws Exception{
			
	    DataMap resultMap = null;
	    
	    try {
	    	
	        resultMap = faqMapper.selectFaqViewRow(fno);
	        
	    } catch (SQLException e) {
	        throw new BizException(Message.getKey(e), e);
	    } finally {
	    }
	    return resultMap;        
	}
	
	/**
	 * 교육관련 FAQ 글넘버 최대값 로우 데이터
	 * 작성일 6월 13일
	 * 작성자 정윤철
	 * @return selectSubCodeFaqList
	 * @throws Exception
	 */
	public int selectFaqFnoRow() throws Exception{
			
	    int returnValue = 0;
	    try {
	    	
	        returnValue = faqMapper.selectFaqFnoRow();
	        
	    } catch (SQLException e) {
	        throw new BizException(Message.getKey(e), e);
	    } finally {
	    }
	    return returnValue;        
	}
	
	/**
	 * 교육관련 FAQ 등록
	 * 작성일 6월 13일
	 * 작성자 정윤철
	 * @return selectSubCodeFaqList
	 * @throws Exception
	 */
	public int insertFaq(DataMap requestMap, int fno) throws Exception{
			
	    int result= 0;
	    try {
	    	DataMap params = (DataMap) requestMap.clone();
	    	
	    	params.setInt("fno", fno);
	    	
	    	result = faqMapper.insertFaq(params);
	        
	    } catch (SQLException e) {
	        throw new BizException(Message.getKey(e), e);
	    } finally {
	    }
	    return result;        
	}
	
	/**
	 * 교육관련 FAQ 사용여부 수정
	 * 작성일 6월 13일
	 * 작성자 정윤철
	 * @return selectSubCodeFaqList
	 * @throws Exception
	 */
	public int modifyFaqUseYn(int fno, String useYn) throws Exception{
			
	    int returnValue = 0;
	    try {
	    	
	    	Map<String, Object> params = new HashMap<String, Object>();
	    	
	    	params.put("fno", fno);
	    	params.put("useYn", useYn);
	    	
	        returnValue = faqMapper.modifyFaqUseYn(params);
	        
	    } catch (SQLException e) {
	        throw new BizException(Message.getKey(e), e);
	    } finally {
	    }
	    return returnValue;        
	}
	
	
	/**
	 * 교육관련 FAQ 카운터수 수정
	 * 작성일 6월 13일
	 * 작성자 정윤철
	 * @return selectSubCodeFaqList
	 * @throws Exception
	 */
	public int modifyFaqFno(int fno) throws Exception{
			
	    int returnValue = 0;
	    
	    try {
	    	
	        returnValue = faqMapper.modifyFaqFno(fno);
	        
	    } catch (SQLException e) {
	        throw new BizException(Message.getKey(e), e);
	    } finally {
	    	returnValue += 1;
	    }
	    return returnValue;        
	}
	
	/**
	 * 교육관련 FAQ 수정
	 * 작성일 6월 13일
	 * 작성자 정윤철
	 * @return selectSubCodeFaqList
	 * @throws Exception
	 */
	public int modifyFaq(DataMap requestMap, int fno) throws Exception{
			
	    int returnValue = 0;
	    
	    try {
	    	
	    	DataMap params = (DataMap) requestMap.clone();
	    	
	    	params.setInt("fno", fno);
	    	
	        returnValue = faqMapper.modifyFaq(params);
	        
	    } catch (SQLException e) {
	        throw new BizException(Message.getKey(e), e);
	    } finally {
	    }
	    return returnValue;        
	}
	
	
	
	/**
	 * 교육관련 FAQ 글삭제
	 * 작성일 6월 13일
	 * 작성자 정윤철
	 * @return selectSubCodeFaqList
	 * @throws Exception
	 */
	public int deleteFaq(int fno) throws Exception{
			
	    int returnValue = 0;
	    
	    try {
	    	
	        returnValue = faqMapper.deleteFaq(fno);
	        
	    } catch (SQLException e) {
	        throw new BizException(Message.getKey(e), e);
	    } finally {
	    }
	    return returnValue;        
	}
}
