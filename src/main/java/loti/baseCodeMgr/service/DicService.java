package loti.baseCodeMgr.service;

import java.sql.SQLException;
import java.util.Map;

import loti.baseCodeMgr.mapper.DicMapper;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import ut.lib.exception.BizException;
import ut.lib.page.PageNavigation;
import ut.lib.support.DataMap;
import ut.lib.util.Message;
import ut.lib.util.Util;
import common.service.BaseService;

@Service
public class DicService extends BaseService{

	@Autowired
	private DicMapper dicMapper;

	/**
	 * 용어분류 리스트
	 */
	public DataMap selectDicTypeList() throws BizException{
		DataMap resultMap = null;
        
        try {
            resultMap = dicMapper.selectDicTypeList();
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return resultMap;        
	}
	
	/**
	 * 용어분류 Row 조회
	 */
	public DataMap selectDicTypeRow(String types) throws BizException{
        DataMap resultMap = null;
        
        try {
            resultMap = dicMapper.selectDicTypeRow(types);
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return resultMap;        
	}
	
	/**
	 * 용어분류코드 중복 체크
	 */
	public DataMap selectDicTypesCheck(String types) throws BizException{
		DataMap resultMap = null;
        
        try {
            resultMap = dicMapper.selectDicTypesCheck(types);
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return resultMap;        
	}
	
	/**
	 * 용어분류코드 insert
	 */
	@Transactional
	public int insertDicType(DataMap requestMap) throws BizException{
        int returnValue = 0;
        
        try {
            DataMap dm = dicMapper.selectDicTypesCheck(requestMap.getString("types") );
                        
            if (dm.size() > 0) {
            	if (Util.parseInt(dm.get("countTypes")) == 0) {
            		returnValue = dicMapper.insertDicType(requestMap);
            	} else {
            		returnValue = -1;
            	}
            } else {
            	returnValue = -2;
            }
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return returnValue;        
	}	
	
	/**
	 * 용어분류코드 update
	 */
	public int updateDicType(DataMap requestMap) throws BizException{
        int returnValue = 0;
        
        try {
            returnValue = dicMapper.updateDicType(requestMap);
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return returnValue;        
	}
	
	
	
	
	/**
	 * 용어사전 리스트
	 */
	public DataMap selectDicList(DataMap requestMap) throws BizException{
        DataMap resultMap = null;
        
        try {
        	
	    	int totalCnt = dicMapper.selectDicListCount(requestMap);
        	
        	Map<String, Object> pageInfo = Util.getPageInfo(totalCnt, requestMap);
        	
        	requestMap.set("page", pageInfo);
        	
            resultMap = dicMapper.selectDicList(requestMap);
            
            PageNavigation pageNavi = Util.getPageNavigation(pageInfo);
            resultMap.set("PAGE_INFO", pageNavi);
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return resultMap;        
	}
	
	/**
	 * 용어사전 수정시 데이타 조회
	 */
	public DataMap selectDicRow(DataMap requestMap) throws BizException{
		DataMap resultMap = null;
        
        try {
            resultMap = dicMapper.selectDicRow(requestMap);
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return resultMap;        
	}
	
	/**
	 * 용어사전 등록
	 */
	public int insertDic(DataMap requestMap) throws BizException{
        int returnValue = 0;
        
        try {
            returnValue = dicMapper.insertDic(requestMap);
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return returnValue;        
	}
	
	/**
	 * 용어사전 수정
	 */
	public int updateDic(DataMap requestMap) throws BizException{
        int returnValue = 0;
        
        try {
            returnValue = dicMapper.updateDic(requestMap);
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return returnValue;        
	}
	
	/**
	 * 용어사전 삭제
	 */
	public int deleteDic(DataMap requestMap) throws BizException{
        int returnValue = 0;
        
        try {
            returnValue = dicMapper.deleteDic(requestMap);
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return returnValue;        
	}
	
	/**
	 * 용어사전 테스트화면 리스트
	 */
	public DataMap selectDicTestList() throws BizException{
		DataMap resultMap = null;
        
        try {
            resultMap = dicMapper.selectDicTestList();
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return resultMap;        
	}
	
	/**
	 * 용어사전용 과목명
	 */
	public DataMap selectDicViewBySubj(DataMap requestMap) throws BizException{
		DataMap resultMap = null;
        
        try {
            resultMap = dicMapper.selectDicViewBySubj(requestMap);
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return resultMap;        
	}
	
	/**
	 * 용어사전 검색 리스트
	 */
	public DataMap selectSearchDic(DataMap requestMap) throws BizException{
        DataMap resultMap = null;
        
        try {
            resultMap = dicMapper.selectSearchDic(requestMap);
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return resultMap;        
	}

}
