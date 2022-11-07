package loti.tutorMgr.service;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import loti.tutorMgr.mapper.AllowanceMapper;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import ut.lib.exception.BizException;
import ut.lib.support.DataMap;
import ut.lib.util.Message;

import common.service.BaseService;

@Service
public class AllowanceService extends BaseService {

	@Autowired
	private AllowanceMapper allowanceMapper;
	
	/**
	 * 강사레벨 리스트
	 * 작성일 7월 9일
	 * 작성자 정윤철
	 * @param 
	 * @return selectAllowanceList
	 * @throws SQLException e
	 */
	public DataMap selectAllowanceList() throws Exception{
			
		DataMap resultMap = null;

	    try {
	    	
	        resultMap = allowanceMapper.selectAllowanceList();
	        
	    } catch (SQLException e) {
	        throw new BizException(Message.getKey(e), e);
	    } finally {
	    }
	    return resultMap;        
	}

	/**
	 * 강사레벨 Row데이터
	 * 작성일 7월 9일
	 * 작성자 정윤철
	 * @param tlevel
	 * @return selectAllowanceRow
	 * @throws SQLException e
	 */
	public DataMap selectAllowanceRow(String tlevel) throws Exception{
			
		DataMap resultMap = null;

	    try {
	    	
	        resultMap = allowanceMapper.selectAllowanceRow(tlevel);
	        
	    } catch (SQLException e) {
	        throw new BizException(Message.getKey(e), e);
	    } finally {
	    }
	    return resultMap;        
	}

	/**
	 * 강사지정 리스트
	 * 작성일 7월 9일
	 * 작성자 정윤철
	 * @param tlevel
	 * @return selectLevelgruList
	 * @throws SQLException e
	 */
	public DataMap selectLevelgruList(String tlevel) throws Exception{
			
		DataMap resultMap = null;

	    try {
	    	
	        resultMap = allowanceMapper.selectLevelgruList(tlevel);
	        
	    } catch (SQLException e) {
	        throw new BizException(Message.getKey(e), e);
	    } finally {
	    }
	    return resultMap;        
	}

	/**
	 * 강사레벨관리 코드 중복 체크 카운터
	 * 작성일 7월 9일
	 * 작성자 정윤철
	 * @param tlevel
	 * @return selectAllowanceRow
	 * @throws SQLException e
	 */
	public String selectLevelName(String tlevel) throws Exception{
			
	    String returnValue = "";

	    try {
	    	
	        returnValue = allowanceMapper.selectLevelName(tlevel);
	        
	    } catch (SQLException e) {
	        throw new BizException(Message.getKey(e), e);
	    } finally {
	    }
	    return returnValue;        
	}

	/**
	 * 강사지정 Row데이터
	 * 작성일 7월 9일
	 * 작성자 정윤철
	 * @param tlevel, gruCode
	 * @return selectAllowanceList
	 * @throws SQLException e
	 */
	public DataMap selectLevelgruRow(String tlevel, String gruCode) throws Exception{
			
		DataMap resultMap = null;

	    try {
	    	
	    	Map<String, Object> params = new HashMap<String, Object>();
	    	
	    	params.put("tlevel", tlevel);
	    	params.put("gruCode", gruCode);
	    	
	        resultMap = allowanceMapper.selectLevelgruRow(params);
	        
	    } catch (SQLException e) {
	        throw new BizException(Message.getKey(e), e);
	    } finally {
	    }
	    return resultMap;        
	}

	 /**
     * 강사지정 등록
     * 작성자 정윤철
     * 작성일 7월 9일
     * @param tlevel, gruName
     * @return insertLevelgru
     * @throws SQLException e
     */
	public int insertLevelgru(DataMap requestMap) throws Exception{
		
	    int returnValue = 0;

	    try {
	    	
	        returnValue = allowanceMapper.insertLevelgru(requestMap);
	        
	    } catch (SQLException e) {
	        throw new BizException(Message.getKey(e), e);
	    } finally {
	    }
	    return returnValue;        
	}
	
	/**
     * 강사지정 수정
     * 작성자 정윤철
     * 작성일 7월 9일
     * @param tlevel, gruName, gruCode
     * @return modifyLevelgru
     * @throws SQLException e
     */
	public int modifyLevelgru(DataMap requestMap) throws Exception{
		
	    int returnValue = 0;

	    try {
	    	
	        returnValue = allowanceMapper.modifyLevelgru(requestMap);
	        
	    } catch (SQLException e) {
	        throw new BizException(Message.getKey(e), e);
	    } finally {
	    }
	    return returnValue;        
	}
	
	/**
     * 강사지정 삭제
     * 작성자 정윤철
     * 작성일 7월 9일
     * @param tlevel, gruCode
     * @return deleteLevelgru
     * @throws SQLException e
     */
	public int deleteLevelgru(DataMap requestMap) throws Exception{
		
	    int returnValue = 0;

	    try {
	    	
	        returnValue = allowanceMapper.deleteLevelgru(requestMap);
	        
	    } catch (SQLException e) {
	        throw new BizException(Message.getKey(e), e);
	    } finally {
//        	returnValue = 1; // ??
	    }
	    return returnValue;        
	}

	/**
	 * 강사레벨관리 코드 중복 체크 카운터
	 * 작성일 7월 9일
	 * 작성자 정윤철
	 * @param tlevel
	 * @return selectAllowanceRow
	 * @throws SQLException e
	 */
	public int selectAllowanceCount(String tlevel) throws Exception{
			
	    int returnValue = 0;

	    try {
	    	
	        returnValue = allowanceMapper.selectAllowanceCount(tlevel);
	        
	    } catch (SQLException e) {
	        throw new BizException(Message.getKey(e), e);
	    } finally {
	    }
	    return returnValue;        
	}
	
	// --------------------------------------------------------------------------------------------------------------
	
	
	
	/**
	 * 강사레벨관리 등록 실행
	 * 작성일 7월 9일
	 * 작성자 정윤철
	 * @param requestMap
	 * @return insertAllowance
	 * @throws SQLException e
	 */
	@Transactional
	public int insertAllowance(DataMap requestMap) throws Exception{
			
	    int returnValue = 0;

	    try {
	    	
	        //중복된 강사코드가있는지 체크
	        returnValue = allowanceMapper.selectAllowanceCount(requestMap.getString("tlevel"));
	        
	        //중복된 코드가 없을경우
	        if(returnValue <= 0){
		        //강사 등급및 수당 상세내역 등록
		        returnValue = allowanceMapper.insertAllowance(requestMap);
		        //강사 레벨,레벨명등록
		        returnValue = allowanceMapper.insertLevel(requestMap);
	        }else{
	        	//있을경우 메시지 레벨을 3으로 셋
	        	returnValue = 3;
	        	
	        }
	        
	    } catch (SQLException e) {
	        throw new BizException(Message.getKey(e), e);
	    } finally {
	    }
	    return returnValue;        
	}
	
	/**
	 * 강사레벨관리 수정 실행
	 * 작성일 7월 9일
	 * 작성자 정윤철
	 * @param requestMap
	 * @return insertAllowance
	 * @throws SQLException e
	 */
	@Transactional
	public int modifyAllowance(DataMap requestMap) throws Exception{
			
	    int returnValue = 0;

	    try {
	    	
	        //강사 등급및 수당 상세내역 수정
	        returnValue = allowanceMapper.modifyAllowance(requestMap);
	        
	        //강사 레벨,레벨명 수정
	        returnValue = allowanceMapper.modifyLevel(requestMap);
	        
	    } catch (SQLException e) {
	        throw new BizException(Message.getKey(e), e);
	    } finally {
	    }
	    return returnValue;        
	}
	
	
	
	
}
