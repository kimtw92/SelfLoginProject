package loti.baseCodeMgr.service;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

import loti.baseCodeMgr.mapper.GrannaeMapper;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import ut.lib.exception.BizException;
import ut.lib.support.DataMap;
import ut.lib.util.Message;
import common.service.BaseService;

@Service
public class GrannaeService extends BaseService{

	@Autowired
	private GrannaeMapper grannaeMapper;
	
	/**
	 * 과정코드 리스트.
	 */
	public DataMap selectGrAnnaeList(String year) throws BizException{
		DataMap resultMap = null;
        
        try {
        	resultMap = grannaeMapper.selectGrAnnaeList(year);                        
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        
        return resultMap;        
	}
	/**
	 * 교육계획 상세보기.
	 */
	public DataMap selectGrannaeRow(DataMap requestMap) throws BizException {
        DataMap resultMap = null;
        
        try {
        	resultMap = grannaeMapper.selectGrannaeRow(requestMap);
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return resultMap;        
	}
	
	/**
	 * 교육계획 상세정보 리스트. (소양/직무/행정)
	 */
	public DataMap selectGrannae2List(DataMap requestMap) throws BizException{
		DataMap resultMap = null;
        
        try {
        	resultMap = grannaeMapper.selectGrannae2List(requestMap);                        
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return resultMap;        
	}
	
	/**
	 * 과정 차수 정보
	 */
	public DataMap selectGrSeqList(DataMap requestMap) throws BizException{
		DataMap resultMap = null;
        
        try {
            resultMap = grannaeMapper.selectGrSeqList(requestMap);
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return resultMap;  
	}

	/**
	 * 교육계획 등록
	 */
	public int insertGrannae(DataMap requestMap) throws BizException{
		int returnValue = 0;
        
        try {
        	returnValue = grannaeMapper.insertGrannae(requestMap); //교육 계획 등록
            
            if(returnValue > 0) {
            	this.insertGrannae2(requestMap);
            }                        
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return returnValue;
	}
	
	/**
	 * 교육계획 소양/직무/행정 등록.
	 */
	public int insertGrannae2(DataMap requestMap) throws BizException{
		int returnValue = 0;
		
		try {
			//소양분야
	    	for(int i=0; i<requestMap.keySize("a[1][title][]"); i++) {
	    		if (!requestMap.getString("a[1][title][]", i).equals("")) {
	            	Map<String, Object> paramMap = new HashMap<String, Object>();
	            	
	            	paramMap.put("grcode", requestMap.getString("grcode"));
	            	paramMap.put("year", requestMap.getString("year"));
	            	paramMap.put("annaeGubun", "1");
	            	paramMap.put("annaeSeq", i+1);
	            	paramMap.put("annaeTitle", requestMap.getString("a[1][title][]", i));
	            	paramMap.put("title1Sub1", requestMap.getString("a[1][title1_sub1][]", i));
	            	paramMap.put("title1Sub2", requestMap.getString("a[1][title1_sub2][]", i));
	            	paramMap.put("title1Sub3", requestMap.getString("a[1][title1_sub3][]", i));
	            	paramMap.put("title1Sub4", requestMap.getString("a[1][title1_sub4][]", i));
	            	
	            	grannaeMapper.insertGrannae2(paramMap); //교육 계획 상세(소양/행정...)
	    		}
	    	}
	    	
	    	//직무분야
	    	for(int i=0; i<requestMap.keySize("a[2][title][]"); i++) {
	    		if (!requestMap.getString("a[2][title][]", i).equals("")) {
	            	Map<String, Object> paramMap = new HashMap<String, Object>();
	            	
	            	paramMap.put("grcode", requestMap.getString("grcode"));
	            	paramMap.put("year", requestMap.getString("year"));
	            	paramMap.put("annaeGubun", "2");
	            	paramMap.put("annaeSeq", i+1);
	            	paramMap.put("annaeTitle", requestMap.getString("a[2][title][]", i));
	            	paramMap.put("title1Sub1", requestMap.getString("a[2][title1_sub1][]", i));
	            	paramMap.put("title1Sub2", requestMap.getString("a[2][title1_sub2][]", i));
	            	paramMap.put("title1Sub3", requestMap.getString("a[2][title1_sub3][]", i));
	            	paramMap.put("title1Sub4", requestMap.getString("a[2][title1_sub4][]", i));
	            	
	            	grannaeMapper.insertGrannae2(paramMap); //교육 계획 상세(소양/행정...)
	    		}
	    	}
	    	
	    	//행정기타
	    	for(int i=0; i<requestMap.keySize("a[3][title][]"); i++) {
	    		if (!requestMap.getString("a[3][title][]", i).equals("")) {
	            	Map<String, Object> paramMap = new HashMap<String, Object>();
	            	
	            	paramMap.put("grcode", requestMap.getString("grcode"));
	            	paramMap.put("year", requestMap.getString("year"));
	            	paramMap.put("annaeGubun", "3");
	            	paramMap.put("annaeSeq", i+1);
	            	paramMap.put("annaeTitle", requestMap.getString("a[3][title][]", i));
	            	paramMap.put("title1Sub1", requestMap.getString("a[3][title1_sub1][]", i));
	            	paramMap.put("title1Sub2", requestMap.getString("a[3][title1_sub2][]", i));
	            	paramMap.put("title1Sub3", requestMap.getString("a[3][title1_sub3][]", i));
	            	paramMap.put("title1Sub4", requestMap.getString("a[3][title1_sub4][]", i));
	            	
	            	grannaeMapper.insertGrannae2(paramMap); //교육 계획 상세(소양/행정...)
	    		}
	    	}
		} catch (SQLException e) {
             throw new BizException(Message.getKey(e), e);
        } finally {
         	
        }
		return returnValue; 
	}
	
	/**
	 * 교육계획 수정.
	 */
	public int updateGrannae(DataMap requestMap) throws BizException{
		int returnValue = 0;
        
        try {
        	returnValue = grannaeMapper.updateGrannae(requestMap); //교육계획 수정.
        	
            if(returnValue > 0){
            	Map<String, Object> paramMap = new HashMap<String, Object>();
            	
            	paramMap.put("grcode", requestMap.getString("grcode"));
            	paramMap.put("year", requestMap.getString("year"));
            	
            	grannaeMapper.deleteGrannae2(paramMap); //기존 교육계획 상세 정보 삭제.
            	this.insertGrannae2(requestMap); //교육계획 등록(소양/행정....)
            }               
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return returnValue;        
	}
	
	/**
	 * 교육계획 복사전 이전 년도 리스트
	 */
	public DataMap selectGrannaeByPrevYearList(DataMap requestMap) throws BizException{
		DataMap resultMap = null;
        
        try {
        	resultMap = grannaeMapper.selectGrannaeByPrevYearList(requestMap);
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return resultMap;        
	}
	
	/**
	 * 교육계획 년도별 복사.
	 */
	public int insertGrannaeCopyAll(DataMap requestMap) throws BizException{
		int returnValue = 0;
        
        try {
        	//입력한 년도의 과정 가져오기.
            DataMap grannaeList = grannaeMapper.selectGrAnnaeList(requestMap.getString("year"));
            grannaeList.setNullToInitialize(true);
            
            Map<String, Object> paramMap = null;
            for(int i = 0; i < grannaeList.keySize("grcode"); i++){
            	paramMap = new HashMap<String, Object>();
            	paramMap.put("grcode", grannaeList.getString("grcode", i));
            	paramMap.put("year", requestMap.getString("year"));
            	paramMap.put("copyYear", requestMap.getString("copyYear"));
            	
            	//등록 하려는 과정의 해당년에 교육계획이 있으면
            	int tmpInt = grannaeMapper.selectGrannaeCount(paramMap);
            	if(tmpInt > 0){
            		
            		grannaeMapper.deleteGrannae2(paramMap);
            		grannaeMapper.deleteGrannae(paramMap); //교육계획 삭제.
                	
                	int result = grannaeMapper.insertGrannaeCopy(paramMap); //교육 계획 등록
                	
                    if(result > 0){ //교육계획 등록(소양/행정....)
                    	returnValue++; //몇건 복사 되었는지 확인.
                    	grannaeMapper.deleteGrannae2(paramMap); //기존 교육계획 상세 정보 삭제.
                    	grannaeMapper.insertGrannae2Copy(paramMap);
                    }
            	}
            }                 
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return returnValue;        
	}
	
	/**
	 * 교육계획 복사.
	 */
	public int insertGrannaeCopy(DataMap requestMap) throws BizException{
		int returnValue = 0;
        
        try {
        	Map<String, Object> paramMap = new HashMap<String, Object>();
        	
        	paramMap.put("grcode", requestMap.getString("grcode"));
        	paramMap.put("year", requestMap.getString("year"));
        	paramMap.put("copyYear", requestMap.getString("copyYear"));
        	
        	int tmpInt = grannaeMapper.selectGrannaeCount(paramMap); //복사할 등록이 있는지 확인.
            
            if (tmpInt > 0) {
            	//입력한 교육안내가 있다면 삭제후 입력.
            	grannaeMapper.deleteGrannae2(paramMap);
            	grannaeMapper.deleteGrannae(paramMap); //교육계획 삭제.
            	
            	
                returnValue = grannaeMapper.insertGrannaeCopy(paramMap); //교육 계획 등록
                
                if(returnValue > 0){ //교육계획 등록(소양/행정....)
                	grannaeMapper.deleteGrannae2(paramMap); //기존 교육계획 상세 정보 삭제.
                	grannaeMapper.insertGrannae2Copy(paramMap); 
                }
            } else {
            	returnValue = -1;
            }         
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return returnValue;        
	}
}
