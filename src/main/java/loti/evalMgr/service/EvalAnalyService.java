package loti.evalMgr.service;

import gov.mogaha.gpin.sp.util.StringUtil;

import java.sql.SQLException;

import loti.evalMgr.mapper.EvalAnalyMapper;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import ut.lib.exception.BizException;
import ut.lib.support.DataMap;
import ut.lib.util.Message;
import common.service.BaseService;

@Service
public class EvalAnalyService extends BaseService {
	
	@Autowired
	private EvalAnalyMapper evalAnalyMapper;
	
	/**
	 * 평가점수조회 총점
	 */
	public DataMap selectScoreTotData(DataMap requestMap) throws BizException{		
		DataMap resultMap = new DataMap();
    	
        try {
        	requestMap.setNullToInitialize(true);
        	resultMap = evalAnalyMapper.selectScoreTotData(requestMap);
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return resultMap;		
	}
	
	/**
	 * 평가점수조회 평균값
	 */
	public DataMap selectScoreAvgData(DataMap requestMap) throws BizException{		
		DataMap resultMap = new DataMap();
    	
        try {
        	resultMap = evalAnalyMapper.selectScoreAvgData(requestMap);
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return resultMap;		
	}
	
	/**
	 * 평가점수조회 리스트
	 */
	public DataMap selectScoreList(DataMap requestMap) throws BizException{		
		DataMap resultMap = new DataMap();
    	
        try {
        	resultMap = evalAnalyMapper.selectScoreList(requestMap);
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return resultMap;		
	}
	
	/**
	 * 평가결과분석
	 */
	public DataMap selectAnalyListParam(DataMap requestMap) throws BizException{		
		DataMap resultMap = new DataMap();
		DataMap tmpMap = null;

		StringBuffer a_title = new StringBuffer();
		
        try {
        	tmpMap = new DataMap();
        	tmpMap = evalAnalyMapper.selectAnalyListParam1(requestMap);
        	
        	a_title.append(tmpMap.getString("grtitle"));
        	
        	tmpMap = new DataMap();
        	tmpMap = evalAnalyMapper.selectAnalyListParam2(requestMap);
        	
        	a_title.append(tmpMap.getString("lecnm"));
			resultMap.setString("a_title",a_title.toString());
			
			tmpMap = new DataMap();
        	tmpMap = evalAnalyMapper.selectAnalyListParam3(requestMap);
        	
        	if (requestMap.getString("ptype").equals("M")) {
        		resultMap.setString("tot_point", tmpMap.getString("mpoint"));
        	} else if (requestMap.getString("ptype").equals("T")) {
        		resultMap.setString("tot_point", tmpMap.getString("lpoint"));
        	} else if (requestMap.getString("ptype").equals("1")) {
        		resultMap.setString("tot_point", tmpMap.getString("npoint1"));
        	} else if (requestMap.getString("ptype").equals("2")) {
        		resultMap.setString("tot_point", tmpMap.getString("npoint2"));
        	} else if (requestMap.getString("ptype").equals("3")) {
        		resultMap.setString("tot_point", tmpMap.getString("npoint3"));
        	} else if (requestMap.getString("ptype").equals("4")) {
        		resultMap.setString("tot_point", tmpMap.getString("npoint4"));
        	} else if (requestMap.getString("ptype").equals("5")) {
        		resultMap.setString("tot_point", tmpMap.getString("npoint5"));
        	}
        	
        	tmpMap = new DataMap();
        	tmpMap = evalAnalyMapper.selectAnalyListParam4(requestMap);
			
        	resultMap.setString("mscore", StringUtil.nvl(tmpMap.getString("mscore"),"0"));
			resultMap.setString("totaledu", StringUtil.nvl(tmpMap.getString("totaledu"),"0"));
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return resultMap;		
	}
	
	/**
	 * 과정평균추이도
	 */
	public DataMap selectCourseHistoryGrcode() throws BizException{		
		DataMap resultMap = new DataMap();
    	
        try {
        	resultMap = evalAnalyMapper.selectCourseHistoryGrcode();
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return resultMap;		
	}
}
