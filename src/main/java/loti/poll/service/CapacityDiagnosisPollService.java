package loti.poll.service;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

import loti.poll.mapper.CapacityDiagnosisPollMapper;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import ut.lib.exception.BizException;
import ut.lib.page.PageNavigation;
import ut.lib.support.DataMap;
import ut.lib.util.Constants;
import ut.lib.util.Message;
import ut.lib.util.Util;
import common.service.BaseService;

@Service
public class CapacityDiagnosisPollService extends BaseService {
	
	@Autowired
	private CapacityDiagnosisPollMapper CapacityDiagnosisPollMapper;
	
	/**
	 * 역량강화과정 역량진단 설문지 체크
	 * @param requestMap
	 * @param loginInfo
	 * @return
	 * @throws Exception
	 */
	public DataMap selectCapacityDiagnosisByCheck(DataMap requestMap) throws Exception{
		
        DataMap resultMap = null;
        
        try {
        	
            resultMap = CapacityDiagnosisPollMapper.selectCapacityDiagnosisByCheck(requestMap);
                                    
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return resultMap;  
		
	}
	
	/**
	 * 역량강화과정 역량진단 설문지 결과
	 * @param requestMap
	 * @param loginInfo
	 * @return
	 * @throws Exception
	 */
	public DataMap selectCapacityDiagnosisBySearchList(DataMap requestMap) throws Exception{
		
        DataMap resultMap = null;
        
        try {
        	
            resultMap = CapacityDiagnosisPollMapper.selectCapacityDiagnosisBySearchList(requestMap);
                                    
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return resultMap;  
		
	}
	
	/**
	 * 역량강화과정 역량진단 설문지 등록
	 * @param titleNo
	 * @return
	 * @throws Exception
	 */
	@Transactional
	public int insertCapacityDiagnosis(DataMap requestMap) throws Exception{
		
        int resultValue = 0;
        
        try {
        	
        	resultValue = CapacityDiagnosisPollMapper.insertCapacityDiagnosis(requestMap); //보기 셋트
            
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return resultValue;
		
	}

}
