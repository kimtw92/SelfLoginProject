package loti.tutorMgr.service;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import loti.tutorMgr.mapper.StatisticsMapper;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import ut.lib.exception.BizException;
import ut.lib.support.DataMap;
import ut.lib.util.Message;

import common.service.BaseService;


@Service
public class StatisticsService extends BaseService {

	@Autowired
	private StatisticsMapper statisticsMapper;
	
	/**
	 * 강사활용실적
	 * @param sType
	 * @param yearMonthFrom
	 * @param yearMonthTo
	 * @return
	 * @throws Exception
	 */
	public DataMap salaryStatsList(String sType, String yearMonthFrom, String yearMonthTo) throws Exception{
		
        DataMap resultMap = null;
        
        try {
        	
        	Map<String, Object> params = new HashMap<String, Object>();
        	
        	params.put("yearMonthFrom", yearMonthFrom);
        	params.put("yearMonthTo", yearMonthTo);
        	
    		if(sType.equals("1")){
    			resultMap = statisticsMapper.salaryStatsListType1(params);
    		}else{
    			resultMap = statisticsMapper.salaryStatsListType2(params);
    		}
        	
                                    
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return resultMap;        
	}

	/**
	 * 강사등급별실적
	 * @param sDate
	 * @param eDate
	 * @return
	 * @throws Exception
	 */
	public DataMap tutorGradeStats(DataMap requsetMap) throws Exception{
		
		DataMap resultMap = null;
        
        try {
        	
    		String dateTo2 = requsetMap.getString("eDate") + "235959";
    		
    		requsetMap.setString("dateTo2", dateTo2);
        	
            resultMap = statisticsMapper.tutorGradeStats(requsetMap);
                                    
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return resultMap;        
	}
	
	public DataMap tutorMemberList(String year) throws Exception{
		
		DataMap resultMap = null;
        
        try {
        	
            resultMap = statisticsMapper.tutorMemberList(year);
                                    
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return resultMap;        
	}
	
}
