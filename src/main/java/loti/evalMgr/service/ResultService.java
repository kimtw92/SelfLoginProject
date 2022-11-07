package loti.evalMgr.service;

import java.sql.SQLException;

import loti.evalMgr.mapper.ResultMapper;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import ut.lib.exception.BizException;
import ut.lib.support.DataMap;
import ut.lib.util.Message;
import common.service.BaseService;

@Service
public class ResultService extends BaseService {

	@Autowired
	private ResultMapper resultMapper;
	
	/**
	 * 평가결과보고서 세부내역1
	 */
	public DataMap selectResultList(DataMap requestMap) throws Exception{
		DataMap resultMap = null;
        
        try {
        	resultMap = resultMapper.selectResultList(requestMap);
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return resultMap;      
	}
	
	/**
	 * 평가결과보고서 세부내역2
	 */
	public DataMap selectResultList2(DataMap requestMap) throws Exception{
		DataMap resultMap = null;
        
        try {
        	resultMap = resultMapper.selectResultList2(requestMap);
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return resultMap;      
	} 
	
	/**
	 * 자치회 유공자 리스트
	 */	
	public DataMap selectJachiList(DataMap requestMap) throws Exception{
		DataMap resultMap = null;
        
		try{
			resultMap = resultMapper.selectJachiList(requestMap);
		} catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return resultMap;
	}
	
	/**
	 * 성적 우수자 리스트
	 */
	public DataMap selectSungJukList(DataMap requestMap) throws Exception{
		DataMap resultMap = null;
        
		try{
			resultMap = resultMapper.selectSungJukList(requestMap);
		} catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return resultMap;
	}
}
