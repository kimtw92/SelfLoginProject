package loti.evalMgr.service;

import java.sql.SQLException;
import java.util.Map;

import loti.evalMgr.mapper.EvalMasterMapper;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import ut.lib.exception.BizException;
import ut.lib.support.DataMap;
import ut.lib.util.Message;
import common.service.BaseService;

@Service
public class EvalMasterService extends BaseService {
	
	@Autowired
	private EvalMasterMapper evalMasterMapper;
	
	/**
	 * 평가 마스터 리스트
	 */
	public DataMap selectEvalMasterList(DataMap requestMap) throws BizException{
		DataMap resultMap = new DataMap();
        DataMap temp1=null;
        DataMap temp2=null;
        DataMap temp3=null;
        String commGrcode=requestMap.getString("commGrcode");
        String commGrseq=requestMap.getString("commGrseq");
        //String commSubj=requestMap.getString("commSubj");
        String menuId=requestMap.getString("menuId");
        
        try {
        	String evlReg="";
            String mevalYn="";
            String levalYn="N";
            int nevalCnt=0;
            String bfRefSubj="";
            
            temp1 = evalMasterMapper.selectEvalMasterParam1(requestMap);
            if (!temp1.isEmpty()) {
            	mevalYn = temp1.getString("mevalYn");//중간평가여부
            	levalYn = temp1.getString("levalYn");//최종평가여부
            	nevalCnt = Integer.parseInt(temp1.getString("nevalCnt"));//상시평가여부
            	
            	if (mevalYn.equals("Y") || levalYn.equals("Y") || nevalCnt > 0) {            	
            		evlReg="Y";
            	}
            }
            
            temp2 = evalMasterMapper.selectEvalMasterParam2(requestMap);
            DataMap childCnt = new DataMap();
            DataMap parentNm = new DataMap();            
            
            for(int i=0;i<temp2.keySize("lecnm");i++) {            
            	childCnt.addString(temp2.getString("refSubj",i),temp2.getString("cCnt",i));
            	parentNm.addString(temp2.getString("refSubj",i),temp2.getString("lecnm",i));            
            }
            
            temp3 = evalMasterMapper.selectEvalMasterList1(requestMap);

            for(int i=0;i<temp3.keySize("subj");i++) {
            	resultMap.addString("subj"		, temp3.getString("subj",i));
            	resultMap.addString("lecnm"		, temp3.getString("lecnm",i));
            	resultMap.addString("lecType"	, temp3.getString("lecType",i));
            	resultMap.addString("refSubj"	, temp3.getString("refSubj",i));
            	resultMap.addString("evlYn"		, Integer.parseInt(temp3.getString("evlYn",i))>0? "Y":"N");
            	resultMap.addString("ptypeT"	, temp3.getString("ptypeT",i));
            	resultMap.addString("ptypeM"	, temp3.getString("ptypeM",i));
            	resultMap.addString("ptype1"	, temp3.getString("ptype1",i));
            	resultMap.addString("ptype2"	, temp3.getString("ptype2",i));
            	resultMap.addString("ptype3"	, temp3.getString("ptype3",i));
            	resultMap.addString("ptype4"	, temp3.getString("ptype4",i));
            	resultMap.addString("ptype5"	, temp3.getString("ptype5",i));            	           	
            	
	            if (temp3.getString("lecType",i).equals("S")) {
	        		resultMap.addString("rowspan", "1");
	        		resultMap.addString("subjGnm", "단일");
	        	} else if (temp3.getString("lecType",i).equals("C")) {
	        		if (temp3.getString("refSubj",i).equals(bfRefSubj)) {//이전의 과목과 같을 경우 rowspan을 0
	        			resultMap.addString("rowspan", "0");	        				
	        		}else{
	        			resultMap.addString("rowspan", childCnt.getString(temp3.getString("refSubj",i)));
	        		}
	        		resultMap.addString("subjGnm", "선택<br>("+parentNm.getString(temp3.getString("refSubj",i))+")");
	        	}	      
	            
	            if (!evlReg.equals("Y")) {
	        		resultMap.addString("function","<a href='#' onClick=\"javascript:alert('과정평가수를 먼저 설정하세요.')\">등록</a>");
	        	} else {
	        		if (resultMap.getString("evlYn",i).equals("N")) {
	        			resultMap.addString("function","<a href='#' onClick=\"javascript:OpenEval(400, 500,'/evalMgr/evalMaster.do?mode=insertSubjSeq&menuId="+menuId+"&commGrcode="+commGrcode+"&commGrseq="+commGrseq+"&commSubj="+temp3.getString("subj",i)+"')\">등록</a>");
	        		} else {
	        			resultMap.addString("function","<a href='#' onClick=\"javascript:OpenEval(400, 500, '/evalMgr/evalMaster.do?mode=subjevl&menuId="+menuId+"&commGrcode="+commGrcode+"&commGrseq="+commGrseq+"&commSubj="+temp3.getString("subj",i)+"')\">수정</a> / <a href='#' onClick=\"javascript:OpenEval(400, 500,'/evalMgr/evalMaster.do?mode=insertSubjSeq&menuId="+menuId+"&commGrcode="+commGrcode+"&commGrseq="+commGrseq+"&commSubj="+temp3.getString("subj",i)+"')\">평가수변경</a>");
	        		}
	        	}
	            bfRefSubj = temp3.getString("refSubj",i);  	            
            }            
            resultMap.setString("mevalYn", mevalYn.equals("Y")?"O":"X");
            resultMap.setString("levalYn", levalYn.equals("Y")?"O":"X");
            resultMap.setInt("nevalCnt",nevalCnt);
            
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return resultMap;        
	}
	
	/**
	 * 평가마스터 과정명
	 */
	public DataMap selectEvalMasterEvlGrcodeNm(String commGrcode) throws BizException{
		DataMap resultMap = new DataMap();
		
		try {
			resultMap = evalMasterMapper.selectEvalMasterGrcodeNm(commGrcode);
		} catch (SQLException e) {
			throw new BizException(Message.getKey(e), e);
		} finally {
			
		}
		return resultMap;
	}
	
	public DataMap selectEvalMasterEvlinfoGrseq(DataMap requestMap) throws BizException{
		DataMap resultMap = new DataMap();
		
		try {
			resultMap = evalMasterMapper.selectEvalMasterInfoGrseq(requestMap);
		} catch (SQLException e) {
			throw new BizException(Message.getKey(e), e);
		} finally {
			
		}
		return resultMap;  
	}
	
	public DataMap selectEvalMasterEvlinfoGrseqPtype(DataMap requestMap) throws BizException{
		DataMap resultMap = new DataMap();
		
		try {
			resultMap = evalMasterMapper.selectEvalMasterInfoPtype(requestMap);
		} catch (SQLException e) {
			throw new BizException(Message.getKey(e), e);
		} finally {
			
		}
		return resultMap;  
	}
	
	public DataMap selectEvalMasterEvlinfoGrseqMtype(DataMap requestMap) throws BizException{
		DataMap resultMap = new DataMap();
		
		try {
			resultMap = evalMasterMapper.selectEvalMasterInfoMptype(requestMap);
		} catch (SQLException e) {
			throw new BizException(Message.getKey(e), e);
		} finally {
			
		}
		return resultMap;  
	}
	
	public DataMap selectEvalMasterEvlinfoClosing(DataMap requestMap) throws BizException{
		DataMap resultMap = new DataMap();
		
		try {
			resultMap = evalMasterMapper.selectEvalMasterClosing(requestMap);
		} catch (SQLException e) {
			throw new BizException(Message.getKey(e), e);
		} finally {
			
		}
		return resultMap;  
	}
	
	public int updateEvInfoGrseq(DataMap requestMap) throws BizException{
		int returnValue = 0;
		
		try {
			returnValue = evalMasterMapper.updateEvInfoGrseq(requestMap);
		} catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
		return returnValue;        
	}
	
	public int insertEvInfoGrseq(DataMap requestMap) throws BizException{
		int returnValue = 0;
		
		try {
			returnValue = evalMasterMapper.insertEvInfoGrseq(requestMap);
		} catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
		return returnValue;        
	}
	
	/**
	 * 평가마스터 기능 등록 과목명, 과정명 선택
	 */
	public DataMap selectGrcodeLecNm(DataMap requestMap) throws BizException{
		DataMap resultMap = new DataMap();
		
		try {
			resultMap = evalMasterMapper.selectGrcodeLecNm(requestMap);
		} catch (SQLException e) {
			throw new BizException(Message.getKey(e), e);
		} finally {
			
		}
		return resultMap;  
	}
	
	public DataMap selectEvalMasterSubjPtype(DataMap requestMap) throws BizException{
		DataMap resultMap = new DataMap();
		
		try {
			resultMap = evalMasterMapper.selectEvalMasterSubjPtype(requestMap);
		} catch (SQLException e) {
			throw new BizException(Message.getKey(e), e);
		} finally {
			
		}
		return resultMap;  
	}
	
	/**
	 * 평가마스터 subjType
	 */
	public DataMap selectEvalSubjType(String commSubj) throws BizException{
		DataMap resultMap = new DataMap();
		
		try {
			resultMap = evalMasterMapper.selectEvalSubjType(commSubj);
		} catch (SQLException e) {
			throw new BizException(Message.getKey(e), e);
		} finally {
			
		}
		return resultMap;  
	}
	
	public DataMap selectEvalMasterDates(String commSubj) throws BizException{
		DataMap resultMap = new DataMap();
		
		try {
			resultMap = evalMasterMapper.selectEvalMasterDates(commSubj);
		} catch (SQLException e) {
			throw new BizException(Message.getKey(e), e);
		} finally {
			
		}
		return resultMap;  
	}
	
	/**
	 * 출제된 문제여부 검색
	 */
	public DataMap selectEvalMasterExchange(Map<String, Object> paramMap) throws BizException{
		DataMap resultMap = new DataMap();
		
		try {
			resultMap = evalMasterMapper.selectEvalMasterExchange(paramMap);
		} catch (SQLException e) {
			throw new BizException(Message.getKey(e), e);
		} finally {
			
		}
		return resultMap;  
	}
	
	/**
	 * 평가정보 삭제
	 */
	public int deleteEvalInfoSubj(Map<String, Object> paramMap) throws BizException{
		int returnValue = 1;
		
		try {
			evalMasterMapper.deleteEvalInfoSubj(paramMap);
		} catch (SQLException e) {
			returnValue = 0;
			throw new BizException(Message.getKey(e), e);
		} finally {
			
		}
		return returnValue;        
	}
	
	/**
	 * 평가정보 수정
	 */
	public int updateEvalInfoSubj(Map<String, Object> paramMap) throws BizException{
		int returnValue = 0;

		try {
			returnValue = evalMasterMapper.updateEvalInfoSubj(paramMap);
		} catch (SQLException e) {
			throw new BizException(Message.getKey(e), e);
		} finally {
			
		}
		return returnValue;        
	}
	
	/**
	 * 차시 중복여부 검색
	 */
	public DataMap selectTotalSubj(Map<String, Object> paramMap) throws BizException{
		DataMap resultMap = new DataMap();
		
		try {
			resultMap = evalMasterMapper.selectTotalSubj(paramMap);
		} catch (SQLException e) {
			throw new BizException(Message.getKey(e), e);
		} finally {
			
		}
		return resultMap;  
	}
	
	/**
	 * 평가설정 정보 입력
	 */
	public int insertEvalInfoSubj(Map<String, Object> paramMap) throws BizException{
		int returnValue = 0;
		
		try {
			returnValue = evalMasterMapper.insertEvalInfoSubj(paramMap);
		} catch (SQLException e) {
			throw new BizException(Message.getKey(e), e);
		} finally {
			
		}
		return returnValue;        
	}
}
