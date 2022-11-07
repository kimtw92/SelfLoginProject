package loti.courseMgr.service;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

import loti.courseMgr.mapper.GrseqCodeMapper;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import ut.lib.exception.BizException;
import ut.lib.support.DataMap;
import ut.lib.util.Message;
import ut.lib.util.Util;
import common.service.BaseService;

@Service
public class GrseqCodeService extends BaseService {

	@Autowired
	private GrseqCodeMapper grseqCodeMapper;
	
	/**
	 * 기수 코드 관리 리스트
	 */
	public DataMap selectGrseqMngList(String year, String dept) throws BizException{
		DataMap resultMap = new DataMap();
        
        try {
        	Map<String, Object> paramMap = new HashMap<String, Object>();
        	paramMap.put("year", year);
        	paramMap.put("dept", dept);
        	
            resultMap = grseqCodeMapper.selectGrseqMngList(paramMap);
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return resultMap;
	}
	
	/**
	 * 기수 코드 관리 상세 정보.
	 */
	public DataMap selectGrseqMngRow(String grseq, String dept) throws BizException{
		DataMap resultMap = new DataMap();
        
        try {
        	Map<String, Object> paramMap = new HashMap<String, Object>();
        	paramMap.put("grseq", grseq);
        	paramMap.put("dept", dept);
        	
        	resultMap = grseqCodeMapper.selectGrseqMngRow(paramMap);
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return resultMap;
	}
	
	/**
	 * 기수 코드 관리 Max+1 seq 가져 오기.
	 */
	public int selectGrseqMngMaxSeq(String year, String dept) throws BizException{
		int resultValue = 0;
        
        try {
        	Map<String, Object> paramMap = new HashMap<String, Object>();
        	paramMap.put("year", year);
        	paramMap.put("dept", dept);
        	
        	resultValue = grseqCodeMapper.selectGrseqMngMaxSeq(paramMap);
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return resultValue;
	}
	
	/**
	 * 기수 코드 관리 등록
	 */
	public int insertGrseqMng(String dept, DataMap requestMap) throws BizException{
		int resultValue = 0;
        
        try {
        	int seq = 0;
        	Map<String, Object> paramMap = new HashMap<String, Object>();
        	paramMap.put("dept", dept);
        	paramMap.put("grseq", requestMap.getString("year") + requestMap.getString("seq"));
        	
            if(grseqCodeMapper.selectGrseqMngGrseqChk(paramMap) > 0 ){ //기수코드가 존재 한다면.
            	//새로운 기수 코드 생성.
            	paramMap.put("year", requestMap.getString("year"));
            	seq = grseqCodeMapper.selectGrseqMngMaxSeq(paramMap);
            	requestMap.setString("seq", Util.plusZero(seq));
            }else{
            	seq = Integer.parseInt(requestMap.getString("seq"));
            }
            
            //등록
            paramMap = new HashMap<String, Object>();
            paramMap.put("dept", dept);
            paramMap.put("grseq", requestMap.getString("year") + requestMap.getString("seq"));
            paramMap.put("eapplyst", requestMap.getString("eapplyst")+requestMap.getString("eapplysth"));
            paramMap.put("eapplyed", requestMap.getString("eapplyed")+requestMap.getString("eapplyedh"));
            paramMap.put("started", requestMap.getString("started"));
            paramMap.put("enddate", requestMap.getString("enddate"));
            paramMap.put("tdate", requestMap.getString("tdate"));
            paramMap.put("person", requestMap.getString("person"));
            paramMap.put("endsent", requestMap.getString("endsent"));
            paramMap.put("endaent", requestMap.getString("endaent"));
            paramMap.put("rpgrad", requestMap.getString("rpgrad"));
            paramMap.put("grPoint", requestMap.getString("grPoint"));
            paramMap.put("completeTime", requestMap.getString("completeTime"));
            
            resultValue = grseqCodeMapper.insertGrseqMng(paramMap);
            
            if(resultValue > 0) //등록 되었다면 반환 값은 등록된 기수 값.
            	resultValue = seq;
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return resultValue;
	}
	
	/**
	 * 기수 코드 관리 수정
	 */
	public int updateGrseqMng(String dept, DataMap requestMap) throws BizException{
		int resultValue = 0;
        
        try {
        	Map<String, Object> paramMap = new HashMap<String, Object>();
        	paramMap.put("eapplyst", requestMap.getString("eapplyst")+requestMap.getString("eapplysth"));
        	paramMap.put("eapplyed", requestMap.getString("eapplyed")+requestMap.getString("eapplyedh"));
        	paramMap.put("endsent", requestMap.getString("endsent"));
        	paramMap.put("endaent", requestMap.getString("endaent"));
        	paramMap.put("started", requestMap.getString("started"));
        	paramMap.put("enddate", requestMap.getString("enddate"));
        	paramMap.put("tdate", requestMap.getString("tdate"));
			paramMap.put("person", requestMap.getString("person"));
			paramMap.put("rpgrad", requestMap.getString("rpgrad"));
			paramMap.put("grPoint", requestMap.getString("grPoint"));
			paramMap.put("completeTime", requestMap.getString("completeTime"));
			paramMap.put("dept", dept);
			paramMap.put("grseq", requestMap.getString("year") + requestMap.getString("seq"));
			
        	resultValue = grseqCodeMapper.updateGrseqMng(paramMap);
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return resultValue;  
		
	}
	
	/**
	 * 기수 코드 관리 삭제
	 */
	public int deleteGrseqMng(String dept, String grseq) throws BizException{
		int resultValue = 0;
        
        try {
        	Map<String, Object> paramMap = new HashMap<String, Object>();
        	paramMap.put("dept", dept);
        	paramMap.put("grseq", grseq);
        	
        	resultValue = grseqCodeMapper.deleteGrseqMng(paramMap);
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return resultValue;
	}
}
