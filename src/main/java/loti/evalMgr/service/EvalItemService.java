package loti.evalMgr.service;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

import loti.evalMgr.mapper.EvalItemMapper;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import ut.lib.exception.BizException;
import ut.lib.support.DataMap;
import ut.lib.util.Message;
import common.service.BaseService;

@Service
public class EvalItemService extends BaseService {
	
	@Autowired
	private EvalItemMapper evalItemMapper;
	
	/**
	 * 과정 개설 여부
	 */
	public DataMap selectEvalItemClosing(DataMap requestMap)  throws BizException{		
		DataMap resultMap = new DataMap();
    	
        try {
           	resultMap = evalItemMapper.selectEvalItemClosing(requestMap);
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return resultMap;		
	}
	
	/**
	 * 평가 출제유무,상시평가횟수
	 */
	public DataMap selectEvalItemEvalCnt(DataMap requestMap)  throws BizException{		
		DataMap resultMap = new DataMap();
    	
        try {
           	resultMap = evalItemMapper.selectEvalItemEvalCnt(requestMap);
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return resultMap;		
	}
	
	/**
	 * 자식과목의 부모과목정보
	 */
	public DataMap selectEvalItemChildParent(DataMap requestMap)  throws BizException{		
		DataMap resultMap = new DataMap();
    	
        try {
           	resultMap = evalItemMapper.selectEvalItemChildParent(requestMap);
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return resultMap;		
	}
	
	/**
	 * 리스트
	 */
	public DataMap selectEvalItemRecordList(DataMap requestMap)  throws BizException{		
		DataMap resultMap = new DataMap();
    	
        try {
           	resultMap = evalItemMapper.selectEvalItemRecordList(requestMap);
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return resultMap;		
	}
	
	/**
	 * 특수과목 리스트
	 */
	public DataMap selectEvalItemSrecordList(DataMap requestMap)  throws BizException{		
		DataMap resultMap = new DataMap();
    	
        try {
           	resultMap = evalItemMapper.selectEvalItemSrecordList(requestMap);
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return resultMap;		
	}
	
	/**
	 * 과제물 리스트
	 */
	public DataMap selectEvalItemReportpoint(DataMap requestMap)  throws BizException{		
		DataMap resultMap = new DataMap();
    	
        try {
           	resultMap = evalItemMapper.selectEvalItemReportPoint(requestMap);
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return resultMap;		
	}
	
	/**
	 * 과제물 출제 횟수
	 */
	public DataMap selectEvalItemReportCnt(DataMap requestMap)  throws BizException{		
		DataMap resultMap = new DataMap();
    	
        try {
           	resultMap = evalItemMapper.selectEvalItemReportCnt(requestMap);
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return resultMap;		
	}
	
	/**
	 * 과제물 등급 정보
	 */
	public DataMap selectEvalItemGradeInfo(DataMap requestMap)  throws BizException{		
		DataMap resultMap = new DataMap();
    	
        try {
           	resultMap = evalItemMapper.selectEvalItemGradeInfo(requestMap);
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return resultMap;		
	}
	
	/**
	 * 과제물 반 정보
	 */
	public DataMap selectEvalItemClassInfo(DataMap requestMap)  throws BizException{		
		DataMap resultMap = new DataMap();
    	
        try {
           	resultMap = evalItemMapper.selectEvalItemClassInfo(requestMap);
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return resultMap;		
	}
	
	/**
	 * 과정이수여부
	 */
	public DataMap selectEvalItemSubjClosing(DataMap requestMap)  throws BizException{		
		DataMap resultMap = new DataMap();
    	
        try {
        	resultMap = evalItemMapper.selectEvalItemSubjClosing(requestMap);
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return resultMap;		
	}
	
	/**
	 * 평가항목관리 점수 저장
	 */
	public int updateEvalItemSubjList(
			DataMap parameter,
			int subjLength,
			String[] pSubj2,
			String[] totpoint2,
			String commGrcode,
			String commGrseq,
			String spReportpoint,
			String spreportCnt) throws BizException{
		
		int returnValue = 0;
		
		try {
			//과목 점수 업데이트
			Map<String, Object> paramMap = null;
			String si = "";
            for(int i=0; i<subjLength; i++) {
            	si = String.valueOf(i);
            	paramMap = new HashMap<String, Object>();
            	paramMap.put("mgakpoint", parameter.getString(si, 0));
            	paramMap.put("mjupoint", parameter.getString(si, 1));
            	paramMap.put("lgakpoint", parameter.getString(si, 2));
            	paramMap.put("ljupoint", parameter.getString(si, 3));
            	paramMap.put("mgakweight", parameter.getString(si, 4));
            	paramMap.put("mjuweight", parameter.getString(si, 5));
            	paramMap.put("lgakweight", parameter.getString(si, 6));
            	paramMap.put("ljuweight", parameter.getString(si, 7));
            	paramMap.put("reportpoint", parameter.getString(si, 8));
            	paramMap.put("steppoint", parameter.getString(si, 9));
            	paramMap.put("totpoint", parameter.getString(si, 10));
            	paramMap.put("grastep", parameter.getString(si, 11));
            	paramMap.put("ngakpoint1", parameter.getString(si, 12));
            	paramMap.put("njupoint1", parameter.getString(si, 13));
            	paramMap.put("ngakweight1", parameter.getString(si, 14));
            	paramMap.put("njuweight1", parameter.getString(si, 15));
            	paramMap.put("ngakpoint2", parameter.getString(si, 16));
            	paramMap.put("njupoint2", parameter.getString(si, 17));
            	paramMap.put("ngakweight2", parameter.getString(si, 18));
            	paramMap.put("njuweight2", parameter.getString(si, 19));
            	paramMap.put("ngakpoint3", parameter.getString(si, 20));
            	paramMap.put("njupoint3", parameter.getString(si, 21));
            	paramMap.put("ngakweight3", parameter.getString(si, 22));
            	paramMap.put("njuweight3", parameter.getString(si, 23));
            	paramMap.put("ngakpoint4", parameter.getString(si, 24));
            	paramMap.put("njupoint4", parameter.getString(si, 25));
            	paramMap.put("ngakweight4", parameter.getString(si, 26));
            	paramMap.put("njuweight4", parameter.getString(si, 27));
            	paramMap.put("ngakpoint5", parameter.getString(si, 28));
            	paramMap.put("njupoint5", parameter.getString(si, 29));
            	paramMap.put("ngakweight5", parameter.getString(si, 30));
            	paramMap.put("njuweight5", parameter.getString(si, 31));
            	paramMap.put("commGrcode", parameter.getString(si, 32));
            	paramMap.put("commGrseq", parameter.getString(si, 33));
            	paramMap.put("pSubj", parameter.getString(si, 34));
            	
            	evalItemMapper.updateEvalItemSubjList(paramMap);
            }
            
            //특수과목 점수 업데이트
            if (pSubj2 != null) {
	            for(int j=0; j<pSubj2.length; j++) {
	            	paramMap = new HashMap<String, Object>();
	            	paramMap.put("totpoint2", totpoint2[j]);
	            	paramMap.put("commGrcode", commGrcode);
	            	paramMap.put("commGrseq", commGrseq);
	            	paramMap.put("pSubj2", pSubj2[j]);
	            	
	            	evalItemMapper.updateEvalItemSubjSlist(paramMap);
	            }
            }
            //과제물점수 업데이트
            paramMap = new HashMap<String, Object>();
            paramMap.put("spReportpoint", spReportpoint);
        	paramMap.put("commGrcode", commGrcode);
        	paramMap.put("commGrseq", commGrseq);
            evalItemMapper.updateEvalItemReportpoint(paramMap);
            
            //과제물 횟수 업데이트
            paramMap = new HashMap<String, Object>();
            paramMap.put("spreportCnt", spreportCnt);
        	paramMap.put("commGrcode", commGrcode);
        	paramMap.put("commGrseq", commGrseq);
            evalItemMapper.updateEvalItemReportCnt(paramMap);
            
            returnValue++;
		} catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
		return returnValue;        
	}
	
	/**
	 * 평가항목관리 점수 저장 - 특수과목만 점수입력 할 경우
	 */
	public int updateEvalItemSubjListSubj2(
			String[] pSubj2,
			String[] totpoint2,
			String commGrcode,
			String commGrseq,
			String spReportpoint,
			String spreportCnt) throws BizException{
		
		int returnValue = 0;
		
		try {
			//특수과목 점수 업데이트
			Map<String, Object> paramMap = null;
            for(int j=0;j<pSubj2.length;j++) {
            	paramMap = new HashMap<String, Object>();
            	paramMap.put("totpoint2", totpoint2[j]);
            	paramMap.put("commGrcode", commGrcode);
            	paramMap.put("commGrseq", commGrseq);
            	paramMap.put("pSubj2", pSubj2[j]);
            	evalItemMapper.updateEvalItemSubjSlist(paramMap);
            }
            //과제물점수 업데이트
            paramMap = new HashMap<String, Object>();
            paramMap.put("spReportpoint", spReportpoint);
        	paramMap.put("commGrcode", commGrcode);
        	paramMap.put("commGrseq", commGrseq);
            evalItemMapper.updateEvalItemReportpoint(paramMap);
            
            //과제물 횟수 업데이트
            paramMap = new HashMap<String, Object>();
            paramMap.put("spreportCnt", spreportCnt);
        	paramMap.put("commGrcode", commGrcode);
        	paramMap.put("commGrseq", commGrseq);
            evalItemMapper.updateEvalItemReportCnt(paramMap);
            
            returnValue++;
		} catch (SQLException e) {
			throw new BizException(Message.getKey(e), e);
		} finally {
			
		}
		return returnValue;        
	}
	
	/**
	 * 과제물 출제 횟수 변경
	 */
	public int updateEvalItemReportCnt(String commGrcode,String commGrseq,String spreportCnt) throws BizException{
		int returnValue = 0;
		
		try {
			//과제물 횟수 업데이트
			Map<String, Object> paramMap = new HashMap<String, Object>();
            paramMap.put("spreportCnt", spreportCnt);
        	paramMap.put("commGrcode", commGrcode);
        	paramMap.put("commGrseq", commGrseq);
			evalItemMapper.updateEvalItemReportCnt(paramMap);
			returnValue++;
		} catch (SQLException e) {
			throw new BizException(Message.getKey(e), e);
		} finally {
			
		}
		return returnValue;        
	}
	
	/**
	 * 과정기수별 중간-기말평가 배점정보
	 */
	public DataMap selectEvalItemPointInfo(DataMap requestMap) throws BizException{
		DataMap resultMap = new DataMap();
    	
        try {
        	resultMap = evalItemMapper.selectEvalItemPointInfo(requestMap);
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return resultMap;		
	}
	
	/**
	 * 과제물과목 or 일반과목(온라인, 오프라인) 강의별 평가 배점정보
	 */
	public DataMap selectEvalItemSubjPointInfo(DataMap requestMap) throws BizException{
		DataMap resultMap = new DataMap();
    	
        try {
           	resultMap = evalItemMapper.selectEvalItemSubjPointInfo(requestMap);
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return resultMap;			
	}
	
	/**
	 * 근태과목 평가정보
	 */
	public DataMap selectEvalItemGunTaePoint(DataMap requestMap) throws BizException{
		DataMap resultMap = new DataMap();
    	
        try {
           	resultMap = evalItemMapper.selectEvalItemGunTaePoint(requestMap);
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return resultMap;			
	}
	
	/**
	 * 중간필답평가 정보
	 */
	public DataMap selectEvalItemMpoint(DataMap requestMap) throws BizException{
		DataMap resultMap = new DataMap();
    	
        try {
           	resultMap = evalItemMapper.selectEvalItemMpoint(requestMap);
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return resultMap;		
	}
	
	/**
	 * 최종필답평가 정보
	 */
	public DataMap selectEvalItemLpoint(DataMap requestMap) throws BizException{
		DataMap resultMap = new DataMap();
    	
        try {
           	resultMap = evalItemMapper.selectEvalItemLpoint(requestMap);
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return resultMap;		
	}
	
	/**
	 * 분임평가 (과제물과 근태)를 제외한 특수과목
	 */
	public DataMap selectEvalItemSsubjPoint(DataMap requestMap) throws BizException{
		DataMap resultMap = new DataMap();
    	
        try {
           	resultMap = evalItemMapper.selectEvalItemSsubjPoint(requestMap);
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return resultMap;		
	}
	
	/**
	 * 근태과목이 아닌 과목중 진도율점수가 0 을 초과하는 경우
	 */
	public DataMap selectEvalItemStepPoint(DataMap requestMap) throws BizException{
		DataMap resultMap = new DataMap();
    	
        try {
           	resultMap = evalItemMapper.selectEvalItemStepPoint(requestMap);
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return resultMap;		
	}
	
	/**
	 * 과제물 리스트
	 */
	public DataMap selectEvalItemReportPoint(DataMap requestMap) throws BizException{
		DataMap resultMap = new DataMap();
    	
        try {
        	resultMap = evalItemMapper.selectEvalItemReportPoint(requestMap);
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return resultMap;		
	}
	
	/**
	 * 차시평가 점수가 0 을 초과하는 경우
	 */
	public DataMap selectEvalItemQuizPoint(DataMap requestMap) throws BizException{
		DataMap resultMap = new DataMap();
    	
        try {
        	resultMap = evalItemMapper.selectEvalItemQuizPoint(requestMap);
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return resultMap;		
	}		
	
	/**
	 * 교육훈련평가 내역 업데이트
	 */
	public int updateEvalItemEduTrain(DataMap requestMap) throws BizException{
		int returnValue = 0;
		
		try {
			evalItemMapper.updateEvalItemEduTrain(requestMap);
			returnValue++;
		} catch (SQLException e) {
			throw new BizException(Message.getKey(e), e);
		} finally {
			
		}
		return returnValue;        
	}
}
