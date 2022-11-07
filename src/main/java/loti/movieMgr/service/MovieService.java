package loti.movieMgr.service;

import java.sql.SQLException;
import java.util.Map;

import loti.movieMgr.mapper.MovieMapper;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import ut.lib.exception.BizException;
import ut.lib.page.PageNavigation;
import ut.lib.support.DataMap;
import ut.lib.util.Message;
import ut.lib.util.Util;
import common.service.BaseService;

@Service
public class MovieService extends BaseService {
	
	@Autowired
	private MovieMapper movieMapper;
	
	/**
	 * 동영상강의 분류 리스트
	 */
	public DataMap selectDivList(DataMap requestMap) throws BizException {
		DataMap resultMap = null;
        
        try {
        	resultMap = movieMapper.selectDivList();
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return resultMap;  
	}
	
	/**
	 * 동영상강의 학습 리스트/검색
	 */
	public DataMap selectContList(DataMap requestMap) throws BizException {
		DataMap resultMap = null;
        
        try {
        	
	    	int totalCnt = movieMapper.selectContListCount(requestMap);
        	
        	Map<String, Object> pageInfo = Util.getPageInfo(totalCnt, requestMap);
        	
        	requestMap.set("page", pageInfo);
        	
        	resultMap = movieMapper.selectContList(requestMap);
            
            PageNavigation pageNavi = Util.getPageNavigation(pageInfo);
		    resultMap.set("PAGE_INFO", pageNavi);
        	
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return resultMap;  
	}
	
	/**
	 * 동영상강의 학습 리스트/검색
	 */
	public DataMap selectContList_(DataMap requestMap) throws BizException {
		DataMap resultMap = null;
        
        try {
        	
	    	int totalCnt = movieMapper.selectContList_count(requestMap);
        	
        	Map<String, Object> pageInfo = Util.getPageInfo(totalCnt, requestMap);
        	
        	requestMap.set("page", pageInfo);
        	
        	resultMap = movieMapper.selectContList_(requestMap);
            
            PageNavigation pageNavi = Util.getPageNavigation(pageInfo);
		    resultMap.set("PAGE_INFO", pageNavi);
        	
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return resultMap;  
	}
	
	/**
	 * 동영상강의 학습 리스트(과목코드별)
	 */
	public DataMap selectContListBySubj(DataMap requestMap) throws BizException {
		DataMap resultMap = null;
        
        try {
        
            resultMap = movieMapper.selectContListBySubj(requestMap.getString("subj"));
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return resultMap;  
	}
	
	/**
	 * 동영상강의 학습 리스트(과목코드별)
	 */
	public DataMap selectContListBySubj_(DataMap requestMap) throws BizException {
		DataMap resultMap = null;
        
        try {
            
            resultMap = movieMapper.selectContListBySubj_(requestMap.getString("subj"));
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return resultMap;  
	}
	
	/**
	 * 동영상강의 분류 상세정보 (입력/수정화면)
	 */
	public DataMap selectDivRow(String divCode) throws BizException {
		DataMap resultMap = null;
        
        try {
        	resultMap = movieMapper.selectDivRow(divCode);
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return resultMap;  
	}
	
	
	/**
	 * 동영상강의 학습 상세정보 (입력/수정화면)
	 */
	public DataMap selectContRow(String contCode) throws BizException {
		DataMap resultMap = null;
        
        try {
        	resultMap = movieMapper.selectContRow(contCode);
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return resultMap;  
	}

	//selectContRowLec
	/**
	 * 동영상강의 학습 상세정보 (입력/수정화면)
	 */
	public DataMap selectContRowLec(DataMap requestMap) throws BizException {
		DataMap resultMap = null;
        
        try {
            resultMap = movieMapper.selectContRowLec(requestMap);
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return resultMap;  
	}
	
	/**
	 * 동영상강의 분류 입력
	 */
	public int insertDivInfo(DataMap requestMap) throws BizException {
		int resultValue = 0;
        
        try {
        	resultValue = movieMapper.insertDivInfo(requestMap);
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return resultValue;  
	}
	
	/**
	 * 동영상강의 학습 입력
	 */
	public int insertContInfo(DataMap requestMap) throws BizException {
		int resultValue = 0;
        int resultItem  = 0;
        
        try {
        	//시퀀스 생성
            String contCode = selectSequence();
            requestMap.setString("contCode", contCode);
            
            //LCMS에 Item 입력(과목등록시)
            if("movExec".equals(requestMap.getString("mode")))	{
            	resultItem = movieMapper.insertItem(requestMap);
            }
            
            //동영상강의 입력
            resultValue = movieMapper.insertContInfo(requestMap);
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return resultValue;  
	}
	
	/**
	 * 동영상강의 분류 수정
	 */
	public int updateDivInfo(DataMap requestMap) throws BizException {
		int resultValue = 0;
        
        try {
        	resultValue = movieMapper.updateDivInfo(requestMap);
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return resultValue;  
	}
	
	/**
	 * 동영상강의 학습 수정
	 */
	public int updateContInfo(DataMap requestMap) throws BizException {
		int resultValue = 0;
        
        try {
			resultValue = movieMapper.updateContInfo(requestMap);
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return resultValue;  
	}
	
	/**
	 * 동영상강의 조회수 갱신
	 */
	public int updateVisitCountMov(DataMap requestMap) throws BizException {
		int resultValue = 0;
        
        try {
        	resultValue = movieMapper.updateVisitCountMov(requestMap);
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return resultValue;  
	}
	
	/**
	 * 동영상강의 학습시간 갱신 
	 */
	public int updateCmiTime(DataMap requestMap) throws BizException {
		int resultValue = 0;
        
        try {
        	resultValue = movieMapper.updateCmiTime(requestMap);
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return resultValue;  
	}
	
	/**
	 * 동영상강의 분류 삭제
	 */
	public int deleteDivInfo(DataMap requestMap) throws BizException {
		int resultValue = 0;
        
        try {
        	resultValue = movieMapper.deleteDivInfo(requestMap);
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return resultValue;  
	}
	
	/**
	 * 동영상강의 학습 삭제
	 */
	public int deleteContInfo(DataMap requestMap) throws BizException {
		int resultValue = 0;
        int resultItem  = 0;
        
        try {
        	//LCMS에서 ITEM 삭제
            //if("deleteMov".equals(requestMap.getString("mode")))	resultItem = dao.deleteItem(requestMap);
			resultValue = movieMapper.deleteContInfo(requestMap);
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return resultValue;  
	}

	/**
	 * 동영상강의 학습 삭제
	 */
	public int deleteContInfoBySubj(DataMap requestMap) throws BizException {
		int resultValue = 0;
        
        try {
        	//동영상 삭제
			resultValue = movieMapper.deleteContInfoBySubj(requestMap);
			int resultItem = movieMapper.deleteItem(requestMap);
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return resultValue;  
	}
	
	/**
	 * 과목코드 생성
	 **/
	public String selectSequence() throws BizException {
		String subjCode = "";
        
        try {
        	subjCode = movieMapper.selectSequence();
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return subjCode;  
	}
	
	/**
	 * 시퀀스 생성
	 **/
	public String selectSubjCode() throws BizException {
		String subjCode = "";
        
        try {
        	subjCode = movieMapper.selectSubjCode();
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return subjCode;  
	}
}
