package loti.baseCodeMgr.service;

import java.sql.SQLException;
import java.util.Map;

import loti.baseCodeMgr.mapper.MainCodeMapper;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import ut.lib.exception.BizException;
import ut.lib.support.DataMap;
import ut.lib.util.Message;
import common.service.BaseService;

@Service
public class MainCodeService extends BaseService {

	@Autowired
	private MainCodeMapper mainCodeMapper;
	
	/**
	 * 과정분류코드 리스트
	 */
	public DataMap selectMainCodeList() throws BizException{
		DataMap resultMap = null;
        
		try {
            resultMap = (DataMap)mainCodeMapper.selectMainCodeList();
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return resultMap;        
	}
	
	/**
	 * 과정분류코드 상세 리스트
	 */	
	public DataMap selectSubCodeList(Map<String, Object> paramMap) throws BizException{
		DataMap resultMap = null;
		
		try {
			resultMap = (DataMap)mainCodeMapper.selectSubCodeList(paramMap);
	    } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
	    return resultMap;        
	}
	
	/**
	 * 과정분류코드 상세페이지 팝업 리스트
	 */
	public DataMap selectMinorPopFormList(Map<String, Object> paramMap) throws BizException{
		DataMap resultMap = null;
	   
	    try {
	    	resultMap = (DataMap)mainCodeMapper.selectMinorPopFormList(paramMap);
	    } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
	    return resultMap;        
	}
	
	/**
	 * 과정분류코드 상세페이지 팝업 수정
	 * 작성일 5월 15일 
	 * 작성자 정윤철
	 */
	public void updateSubCode(Map<String, Object> paramMap) throws BizException{
		try {
			mainCodeMapper.updateSubCode(paramMap);
	    } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
	}
	
	
	/**
	 * 과정 분류코드관리 팝업 리스트
	 */
	public DataMap selectMajorPopFormList(Map<String, Object> paramMap) throws BizException{
		DataMap resultMap = null;
	   
	    try {
	    	resultMap = mainCodeMapper.selectMajorPopFormList(paramMap);
	    } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
	    return resultMap;        
	}
	
	/**
	 * 과정분류 코드 관리 팝업 수정페이지
	 * 작성일 5월 15일 
	 * 작성자 정윤철
	 */
	public void updateMainCode(Map<String, Object> paramMap) throws BizException{
		try {
			mainCodeMapper.updateMainCode(paramMap);
	    } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
	}
	
	/**
	 * 과정분류코드 상세페이지 팝업 인서트
	 * 작성일 08.05.15
	 */
	public int insertSubCode(Map<String, Object> paramMap) throws BizException{
		int returnvalue = 0;
	    
		try {
	    	// 과정 코드등록시 최고값을 가져온다.
			DataMap maxMinorCode = mainCodeMapper.selectSubMaxCode(paramMap);
			String maxField = maxMinorCode.get("maxField").toString();
			
	        if( Integer.parseInt(maxField) <= 9 ){
				maxField = "0"+maxField;
			}
			
	        paramMap.put("maxField", maxField);
	        
	        returnvalue = mainCodeMapper.insertSubCode(paramMap);
	    } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
	    return returnvalue;        
	}
	
	/**
	 * 과정분류코드 팝업 인서트
	 * 작성일 08.05.15
	 */
	public int insertMainCode(DataMap requestMap) throws BizException{
		int returnvalue = 0;
	    int i = 0;
	    //받아온 문자열을 아스키코드로 변환한 후 담기위해서 쓴 변수
	    int maxMajorCodeCh= 0;
	    //변환한 아스키 코드를 캐릭터로 변환
	    
	    char maxMajorCodeCl=0;
	    try {
	    	//과정 코드 등록시 맥스 MAJOR_CODE값을 가져온다.
			DataMap mainMajorCode =  mainCodeMapper.selectMainMaxCode(requestMap);
			
			//구해온 맥스 majorCode값을 변수에 담는다
			String maxMajorCode = mainMajorCode.get("maxField").toString();
			
	        if (maxMajorCode == "9" ){
	        	//코드값이 9일경우 코드값은  A로 변환
	        	maxMajorCodeCl = 65;
	        }else{
	        	//넘겨진 중분류 최대 코드값의 아스키 코드값을 추출 후 +1
		        maxMajorCodeCh  =   maxMajorCode.charAt(i)+1;
		        //추출한 아스키 넘버값을 캐릭터로 변환
		        maxMajorCodeCl = (char)(maxMajorCodeCh);
	        }
	        //받아온 맥스 중분류 코드값을 스트링형으로 변환한다.
	        maxMajorCode = String.valueOf(maxMajorCodeCl);
	        
	        requestMap.add("maxMajorCode", maxMajorCode);
	        returnvalue = mainCodeMapper.insertMainCode(requestMap);
	    } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
	    return returnvalue;        
	}
	/**
	 * 상세분류코드 소분류 최대값을 구해온다.
	 */
	public DataMap selectSubMaxCode(Map<String, Object> paramMap) throws BizException{
		DataMap resultMap = null;
		
		try{
			resultMap = mainCodeMapper.selectSubMaxCode(paramMap);
		} catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
	    return resultMap;        
	}
	
	/**
	 * 과정분류 중분류 최대 값을 구해온다.
	 */	
	public DataMap selectMainMaxCode(DataMap requestMap) throws BizException{
		DataMap resultMap = null;
		
		try{
			resultMap = mainCodeMapper.selectMainMaxCode(requestMap);
		} catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
	    return resultMap;        
	}	
	
	/**
	 * 메인코드 CD_GUBUN, USEYN 별 리스트 검색.
	 */
	public DataMap selectMainCodeGubunUseYnList(Map<String, Object> paramMap) throws BizException{
		DataMap resultMap = null;
		
		try {
			resultMap = (DataMap)mainCodeMapper.selectMainCodeGubunUseYnList(paramMap);
		} catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
		return resultMap;
	}
	
	public DataMap selectMainSubCodeList(DataMap requestMap) throws BizException{
		DataMap resultMap = null;
		
		try {
			resultMap = (DataMap)mainCodeMapper.selectMainSubCodeList(requestMap);
		} catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
		return resultMap;
	}
}
