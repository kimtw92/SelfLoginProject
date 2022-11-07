package loti.homeFront.service;

import java.sql.SQLException;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import common.service.BaseService;
import loti.homeFront.mapper.PersonBoardMapper;
import ut.lib.exception.BizException;
import ut.lib.page.PageNavigation;
import ut.lib.support.DataMap;
import ut.lib.util.Message;
import ut.lib.util.Util;

@Service
public class PersonBoardService extends BaseService {

	@Autowired
	private PersonBoardMapper pearsonBoardMapper;

	/**
	 * 감사반장에 바란다. 리스트
	 * 작성일 6월 02일
	 * @param pagingInfoMap
	 * @return boardList
	 * @throws Exception
	 */
	public DataMap selectBoardPersonList(DataMap pagingInfoMap) throws Exception{
			
	    DataMap resultMap = null;
	    
	    try {
	    	
	    	int totalCnt = pearsonBoardMapper.selectBoardPersonListCount(pagingInfoMap);
        	
        	Map<String, Object> pageInfo = Util.getPageInfo(totalCnt, pagingInfoMap);
        	
        	pagingInfoMap.set("page", pageInfo);
        	
            resultMap = pearsonBoardMapper.selectBoardPersonList(pagingInfoMap);
            
            PageNavigation pageNavi = Util.getPageNavigation(pageInfo);
            
		    resultMap.set("PAGE_INFO", pageNavi);
	    	
	        
	    } catch (SQLException e) {
	        throw new BizException(Message.getKey(e), e);
	    } finally {
	    }
	    return resultMap;        
	}

	/**
	 * 감사반장에 바란다.  조회
	 * 작성일 6월 02일
	 * @param pagingInfoMap
	 * @return boardList
	 * @throws Exception
	 */
	public DataMap selectBoardPersonView(DataMap resultMap) throws Exception{
		DataMap dataMap = new DataMap();
	    try {
	    	dataMap = pearsonBoardMapper.selectBoardPersonView(resultMap);
	    } catch (SQLException e) {
	        throw new BizException(Message.getKey(e), e);
	    } finally {
	    }
	    return dataMap;        
	}

	/**
	 * 사용자 게시판 글 등록
	 * 작성자 정윤철
	 * 작성일 6월 5일
	 * @param String boardId
	 * @return  deleteBoardManager
	 * @throws Exception
	 */
	public int insertBoardPerson(DataMap requestMap) throws Exception{
		
	    int returnValue = 0;
	    
	    try {
	        returnValue = pearsonBoardMapper.insertBoardPerson(requestMap);
	    } catch (SQLException e) {
	        throw new BizException(Message.getKey(e), e);
	    } finally {
	    }
	    return returnValue;        
	}

	/**
	 * 사용자 게시판 글 수정
	 * 작성자 정윤철
	 * 작성일 6월 5일
	 * @param String boardId
	 * @return  deleteBoardManager
	 * @throws Exception
	 */
	public int updateBoardPerson(DataMap requestMap) throws Exception{
		
	    int returnValue = 0;
	    
	    try {
	        returnValue = pearsonBoardMapper.modifyBoardPerson(requestMap);
	    } catch (SQLException e) {
	        throw new BizException(Message.getKey(e), e);
	    } finally {
	    }
	    return returnValue;        
	}


}
