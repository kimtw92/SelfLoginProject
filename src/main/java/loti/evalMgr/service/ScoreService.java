package loti.evalMgr.service;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;
import java.util.StringTokenizer;

import loti.evalMgr.mapper.ScoreMapper;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import ut.lib.exception.BizException;
import ut.lib.support.DataMap;
import ut.lib.util.Message;
import common.service.BaseService;

@Service
public class ScoreService extends BaseService {
	
	@Autowired
	private ScoreMapper scoreMapper;
	
	/**
	 * 과정및 기수에 따른 과목리스트를 뽑는다 
	 */
	public DataMap selectScoreOption(DataMap requestMap) throws BizException{		
		DataMap resultMap = new DataMap();
    	
        try {
        	resultMap = scoreMapper.selectScoreOption(requestMap);
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return resultMap;		
	}
	
	/**
	 * 특수과목인지 검사
	 */
	public DataMap selectScoreSubj(DataMap requestMap) throws BizException{		
		DataMap resultMap = new DataMap();
    	
        try {
        	resultMap = scoreMapper.selectScoreSubj(requestMap);
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return resultMap;		
	}
	
	/**
	 * 과목정보를 가져온다
	 */
	public DataMap selectScoreInfo(DataMap requestMap) throws BizException{		
		DataMap resultMap = new DataMap();
    	
        try {
        	resultMap = scoreMapper.selectScoreInfo(requestMap);
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return resultMap;		
	}
	
	/**
	 * 어학점수평가 메뉴가 있는 과목인지 검사
	 */
	public DataMap selectLangClass(String commSubj) throws BizException{		
		DataMap resultMap = new DataMap();
    	
        try {
        	resultMap = scoreMapper.selectLangClass(commSubj);
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return resultMap;		
	}
	
	/**
	 * 조건별 반 리스트를 뽑아온다
	 */
	public DataMap selectClassCnt(DataMap requestMap) throws BizException{		
		DataMap resultMap = new DataMap();
    	
        try {
        	resultMap = scoreMapper.selectClassCnt(requestMap);
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return resultMap;		
	}
	
	/**
	 * Bf_Pcnt
	 */
	public DataMap selectBf_Pcnt(DataMap requestMap) throws BizException{		
		DataMap resultMap = new DataMap();
    	
        try {
        	resultMap = scoreMapper.selectBf_Pcnt(requestMap);
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return resultMap;		
	}
	
	/**
	 * 개인별 학생 리스트
	 */
	public DataMap selectPersonList(DataMap requestMap) throws BizException{		
		DataMap resultMap = new DataMap();
    	
        try {
        	resultMap = scoreMapper.selectPersonList(requestMap);
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return resultMap;		
	}
	
	/**
	 *  클래스별 분류에서 클래스 리스트를 뽑아온다
	 */
	public DataMap selectClassCount(DataMap requestMap) throws BizException{		
		DataMap resultMap = new DataMap();
    	
        try {
        	resultMap = scoreMapper.selectClassCount(requestMap);
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return resultMap;		
	}
	
	/**
	 * 클래스별 분류에서 뽑아온 학생 리스트
	 */
	public DataMap selectClassList(Map<String, Object> paramMap) throws BizException{		
		DataMap resultMap = new DataMap();
    	
        try {
        	resultMap = scoreMapper.selectClassList(paramMap);
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return resultMap;		
	}
	
	/**
	 * 어학점수별 클래스 리스트를 뽑아온다
	 */
	public DataMap selectLangClassCount(DataMap requestMap) throws BizException{		
		DataMap resultMap = new DataMap();
    	
        try {
        	resultMap = scoreMapper.selectLangClassCount(requestMap);
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return resultMap;		
	}
	
	/**
	 * 어학 클래스 별 학생리스트를 뽑아온다
	 */
	public DataMap selectLangClassList(Map<String, Object> paramMap) throws BizException{		
		DataMap resultMap = new DataMap();
    	
        try {
        	resultMap = scoreMapper.selectLangClassList(paramMap);
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return resultMap;		
	}
	
	/**
	 * 학생별 점수 수정
	 */
	public int updatePerson(DataMap requestMap) throws BizException{
		int returnValue = 0;
		int rowCount=0;
		String point = "";
		String userno="";
		
		try {
			
			StringTokenizer pointStr = new StringTokenizer(requestMap.getString("pointStr") , "|");
            StringTokenizer usernoStr = new StringTokenizer(requestMap.getString("usernoStr") , "|");
            
            rowCount = pointStr.countTokens();
            
            Map<String, Object> paramMap = null;
            for(int i=0; i < rowCount; i++){
            	point = "";
            	userno = "";
            	point = pointStr.nextToken();            	
            	userno = usernoStr.nextToken();
            	
            	if(point.equals("empty")){
            		point = "";
            	}
            	if(userno.equals("empty")){
            		userno = "";
            	}
            	
            	paramMap = new HashMap<String, Object>();
            	paramMap.put("commGrcode", requestMap.getString("commGrcode"));
            	paramMap.put("commGrseq", requestMap.getString("commGrseq"));
            	paramMap.put("commSubj", requestMap.getString("commSubj"));
            	paramMap.put("userno", userno);
            	paramMap.put("point", point);
				if (requestMap.getString("commSubj").equals("GUN0000001")) {
					paramMap.put("column", "AVCOURSE");
				} else if (requestMap.getString("commSubj").equals("SUB1000025")) {
					paramMap.put("column", "AVREPORT");
				} else {
					paramMap.put("column", "AVLCOUNT");
				}
				scoreMapper.updatePerson(paramMap);	
			}
		} catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	returnValue=1;
        }
		return returnValue;        
	}
	
	/**
	 * 반별 학생 점수 수정
	 */
	public int updateClass(DataMap requestMap) throws BizException{
		int returnValue = 0;
		int rowCount=0;
		String point = "";		
		String classNo= "";
		
		try {
			StringTokenizer pointStr = new StringTokenizer(requestMap.getString("pointStr") , "|");            
            StringTokenizer classNoStr = new StringTokenizer(requestMap.getString("classStr") , "|");
            
            rowCount = pointStr.countTokens();
            Map<String, Object> paramMap = null;
            for(int i=0; i < rowCount; i++){
            	point = "";            	
            	point = pointStr.nextToken();     
            	classNo = "";            	
            	classNo = classNoStr.nextToken(); 
            	
            	if (point.equals("empty")) {
            		point = "";
            	}
            	if (classNo.equals("empty")) {
            		classNo = "";
            	}
            	
            	paramMap = new HashMap<String, Object>();
            	paramMap.put("commGrcode", requestMap.getString("commGrcode"));
            	paramMap.put("commGrseq", requestMap.getString("commGrseq"));
            	paramMap.put("commSubj", requestMap.getString("commSubj"));
            	paramMap.put("classNo", classNo);
            	paramMap.put("point", point);
				if (requestMap.getString("commSubj").equals("GUN0000001")) {
					paramMap.put("column", "AVCOURSE");					
				} else if (requestMap.getString("commSubj").equals("SUB1000025")) {
					paramMap.put("column", "AVREPORT");					
				} else {
					paramMap.put("column", "AVLCOUNT");					
				}
				scoreMapper.updateClass(paramMap);
			}
		} catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	returnValue = 1;
        }
		return returnValue;        
	}
	
	/**
	 * 어학점수별 학생 점수 수정
	 */
	public int updateLangClass(DataMap requestMap) throws BizException{
		int returnValue = 0;
		int rowCount=0;
		int rowCount2=0;
		String point = "";		
		String classNo= "";
		String hpoint="";
		String userno="";
		String langPoint="";
		
		try {
			StringTokenizer pointStr = new StringTokenizer(requestMap.getString("lang_spointObj") , "|");            
            StringTokenizer classNoStr = new StringTokenizer(requestMap.getString("lang_classnoObj") , "|");
            StringTokenizer hpointStr = new StringTokenizer(requestMap.getString("pointStr") , "|");            
            StringTokenizer usernoStr = new StringTokenizer(requestMap.getString("userStr") , "|");
            StringTokenizer langPointStr = new StringTokenizer(requestMap.getString("langPointStr") , "|");
            
            rowCount = pointStr.countTokens();
            
            Map<String, Object> paramMap = null;
            for(int i=0; i < rowCount; i++){
            	point = "";            	
            	point = pointStr.nextToken();     
            	classNo = "";            	
            	classNo = classNoStr.nextToken(); 
            	
            	if(point.equals("empty")){
            		point = "";
            	}
            	if(classNo.equals("empty")){
            		classNo = "";
            	}
            	
            	paramMap = new HashMap<String, Object>();
            	paramMap.put("commGrcode", requestMap.getString("commGrcode"));
            	paramMap.put("commGrseq", requestMap.getString("commGrseq"));
            	paramMap.put("commSubj", requestMap.getString("commSubj"));
            	paramMap.put("sessNo", requestMap.getString("sessNo"));
            	paramMap.put("classNo", classNo);
            	paramMap.put("point", point);
            	if(!requestMap.getString("commSubj").equals("SUB1000025") && !requestMap.getString("commSubj").equals("GUN0000001")){
            		scoreMapper.updateLangClass(paramMap);
            	}
			}                 
            
            rowCount2 = hpointStr.countTokens();
            
            for(int j=0; j < rowCount2; j++){
            	hpoint = "";            	
            	hpoint = hpointStr.nextToken();     
            	userno = "";            	
            	userno = usernoStr.nextToken(); 
            	langPoint ="";
            	langPoint = langPointStr.nextToken();
            	
            	if(hpoint.equals("empty")){
            		hpoint = "";
            	}
            	if(userno.equals("empty")){
            		userno = "";
            	}
            	if(langPoint.equals("empty")){
            		langPoint = "";
            	}
            	
            	paramMap = new HashMap<String, Object>();
            	paramMap.put("commGrcode", requestMap.getString("commGrcode"));
            	paramMap.put("commGrseq", requestMap.getString("commGrseq"));
            	paramMap.put("commSubj", requestMap.getString("commSubj"));
            	paramMap.put("userno", userno);
            	paramMap.put("hpoint", hpoint);
            	paramMap.put("langPoint", langPoint);
            	if(!requestMap.getString("commSubj").equals("SUB1000025") && !requestMap.getString("commSubj").equals("GUN0000001")){
            		scoreMapper.updateLangClassPoint(paramMap);
            		scoreMapper.updateLangClassPoint2(paramMap);
            	}
            }
			} catch (SQLException e) {
	            throw new BizException(Message.getKey(e), e);
	        } finally {
	        	returnValue = 1;
	        }
			return returnValue;        
	}
	
	/**
	 * 성적별>성적일람표 리스트 뽑아온다
	 */
	public DataMap selectScoreReport(DataMap requestMap) throws BizException{		
		DataMap resultMap = new DataMap();
    	
        try {
        	resultMap = scoreMapper.selectScoreParam3(requestMap);
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return resultMap;		
	}
	
	/**
	 * 가점입력 리스트
	 */
	public DataMap selectPointUpList(DataMap requestMap) throws BizException{
		DataMap resultMap = new DataMap();
    	
        try {
        	resultMap = scoreMapper.selectPointUpList(requestMap);
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return resultMap;		
	}
	
	/**
	 * 가점입력 과정 closing여부
	 */
	public DataMap selectPointUpClosing(DataMap requestMap) throws BizException{
		DataMap resultMap = new DataMap();
    	
        try {
        	resultMap = scoreMapper.selectPointUpClosing(requestMap);
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return resultMap;		
	}
	
	/**
	 * 가점입력 점수 update
	 */
	public int updatePoint(DataMap requestMap) throws BizException{
		int returnValue = 0;
		int rowCount=0;
		String point = "";
		String userno="";		

		try {
			StringTokenizer pointStr = new StringTokenizer(requestMap.getString("pointStr") , "|");
            StringTokenizer usernoStr = new StringTokenizer(requestMap.getString("usernoStr") , "|");
            
            rowCount = pointStr.countTokens();
            
            Map<String, Object> paramMap = null;
            for(int i=0; i < rowCount; i++) {
            	point = "";
            	userno = "";
            	point = pointStr.nextToken();            	
            	userno = usernoStr.nextToken();
            	
            	if (point.equals("empty")) {
            		point = "";
            	}
            	if (userno.equals("empty")) {
            		userno = "";
            	}
            	paramMap = new HashMap<String, Object>();
            	paramMap.put("commGrcode", requestMap.getString("commGrcode"));
            	paramMap.put("commGrseq", requestMap.getString("commGrseq"));
            	paramMap.put("userno", userno);
            	paramMap.put("point", point);
            	scoreMapper.updatePoint(paramMap);					
			}
		} catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	returnValue = 1;
        }
		return returnValue;        
	}
}
