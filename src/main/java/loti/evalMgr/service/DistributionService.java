package loti.evalMgr.service;

import java.sql.SQLException;
import java.util.Map;

import loti.evalMgr.mapper.DistributionMapper;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import ut.lib.exception.BizException;
import ut.lib.support.DataMap;
import ut.lib.util.Message;
import common.service.BaseService;

@Service
public class DistributionService extends BaseService {
	
	@Autowired
	private DistributionMapper distributionMapper;
	
	/**
	 * 평가통계관리 > 기간별 > 총계
	 */
	public DataMap selectDateList(Map<String, Object> paramMap)  throws BizException{
		DataMap resultMap = new DataMap();
    	
		try {
			if (paramMap.get("started").toString().equals("") || paramMap.get("enddate").toString().equals("")) {
				return resultMap;
			} else {
				resultMap = distributionMapper.selectTotList(paramMap);	            	
            }	                                    
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return resultMap;		
	}
	
	/**
	 * 평가통계관리 > 기간별 > 직급별
	 */
	public DataMap selectJikList(Map<String, Object> paramMap)  throws BizException{		
		DataMap resultMap = new DataMap();
    	
        try {
        	if (paramMap.get("started").toString().equals("") || paramMap.get("enddate").toString().equals("")) {
            	return resultMap;
            } else {
            	resultMap = distributionMapper.selectJikList(paramMap);	            	
            }	                                    
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return resultMap;		
	}
	
	/**
	 * 평가통계관리 > 기간별 > 기관별
	 */
	public DataMap selectDeptList(Map<String, Object> paramMap) throws BizException{
		DataMap resultMap = new DataMap();
		
		try{
			if (paramMap.get("started").toString().equals("") || paramMap.get("enddate").toString().equals("")) {
            	return resultMap;
            } else {
            	resultMap = distributionMapper.selectDeptList(paramMap);	            	
            }	                                    
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return resultMap;		
	}
	/**
	 * 평가통계관리 > 기간별 > 연령별
	 */
	public DataMap selectAgeList(Map<String, Object> paramMap) throws BizException{
		DataMap resultMap = new DataMap();
		
		try{
			if (paramMap.get("started").toString().equals("") || paramMap.get("enddate").toString().equals("")) {
            	return resultMap;
            } else {
            	resultMap = distributionMapper.selectAgeList(paramMap);	            	
            }	                                    
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return resultMap;	
	}
	
	/**
	 * 평가통계관리 > 기간별 > 성별
	 */
	public DataMap selectSexList(Map<String, Object> paramMap) throws BizException{
		DataMap resultMap = new DataMap();
		
		try{
			if (paramMap.get("started").toString().equals("") || paramMap.get("enddate").toString().equals("")) {
            	return resultMap;
            } else {
            	resultMap = distributionMapper.selectSexList(paramMap);	            	
            }	                                    
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return resultMap;	
	}
	
	/**
	 * 평가통계관리 점수별 optionList
	 */
	public DataMap selectSubjOption(DataMap requestMap) throws BizException{
		DataMap resultMap = null;
		
		try{
			resultMap = distributionMapper.selectSubjOption(requestMap);
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return resultMap;	
	}
	
	/**
	 * 평가통계관리 점수별 param
	 */
	public DataMap selectScoreParam(DataMap requestMap) throws BizException{
		DataMap resultMap = null;
		
		try{
			resultMap = distributionMapper.selectScoreParam1(requestMap);
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return resultMap;	
	}
}
