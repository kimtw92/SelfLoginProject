package loti.subjMgr.service;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;
import java.util.StringTokenizer;

import loti.subjMgr.mapper.LangSubjMapper;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import ut.lib.exception.BizException;
import ut.lib.page.PageNavigation;
import ut.lib.support.DataMap;
import ut.lib.util.Message;
import ut.lib.util.Util;
import common.service.BaseService;

@Service
public class LangSubjService extends BaseService {

	@Autowired
	private LangSubjMapper langSubjMapper;
	
	/**
	 * 어학점수관리 리스트
	 * @param requestMap
	 * @param sqlWhere
	 * @return
	 * @throws Exception
	 */
	public DataMap selectLangSubjList(DataMap requestMap, String sqlWhere) throws Exception{
		
        DataMap resultMap = null;
        
        try {
        	
            resultMap = langSubjMapper.selectLangSubjList( sqlWhere );
                                    
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return resultMap;        
	}
	
	/**
	 * 반 리스트
	 * @param grCode
	 * @param grSeq
	 * @param subj
	 * @return
	 * @throws Exception
	 */
	public DataMap selectClassList(String grCode, String grSeq, String subj) throws Exception{
		
        DataMap resultMap = null;
        
        try {

        	Map<String, Object> params = new HashMap<String, Object>();
        	
        	params.put("grCode", grCode);
        	params.put("grSeq", grSeq);
        	params.put("subj", subj);
        	
            resultMap = langSubjMapper.selectClassList(params);
                                    
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return resultMap;        
	}
	
	/**
	 * 어학점수입력  리스트
	 * @param grCode
	 * @param grSeq
	 * @param subj
	 * @param sqlWhere
	 * @return
	 * @throws Exception
	 */
	public DataMap selectLangSubjFormList(DataMap requestMap, String grCode, String grSeq, String subj, String sqlWhere) throws Exception{
		
        DataMap resultMap = null;
        
        try {
        	
        	Map<String, Object> params = new HashMap<String, Object>();
        	
        	params.put("grCode", grCode);
        	params.put("grSeq", grSeq);
        	params.put("subj", subj);
        	params.put("sqlWhere", sqlWhere);
            
        	
	    	int totalCnt = langSubjMapper.selectLangSubjFormListCount(params);
        	
        	Map<String, Object> pageInfo = Util.getPageInfo(totalCnt, requestMap);
        	
        	params.put("page", pageInfo);
        	
            resultMap = langSubjMapper.selectLangSubjFormList(params);
            
            PageNavigation pageNavi = Util.getPageNavigation(pageInfo);
		    resultMap.set("PAGE_INFO", pageNavi);
                                    
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return resultMap;        
	}
	
	/**
	 * 어학점수입력 업데이트
	 * @param requestMap
	 * @return
	 * @throws Exception
	 */
	public int updateLangSubj(DataMap requestMap) throws Exception{
		
        int returnValue = 0;
        
        String grCode = requestMap.getString("grCode");
        String grSeq = requestMap.getString("grSeq");
        String subj = requestMap.getString("subj");
                
        
        String point1 = "";
        String point2 = "";
        String point3 = "";
        String point4 = "";
        String userNo = "";
            
        int rowCount = 0;        
        
        
        try {
        	
            // data 가  aaa|aaa|aaa 이렇게 들어있음.
            StringTokenizer stPoint1 = new StringTokenizer(requestMap.getString("dataByLangPoint1") , "|");
            StringTokenizer stPoint2 = new StringTokenizer(requestMap.getString("dataByLangPoint2") , "|");
            StringTokenizer stPoint3 = new StringTokenizer(requestMap.getString("dataByLangPoint3") , "|");
            StringTokenizer stPoint4 = new StringTokenizer(requestMap.getString("dataByLangPoint4") , "|");                                   
            StringTokenizer stUserNo = new StringTokenizer(requestMap.getString("dataByUserNo") , "|");
            
            rowCount = stUserNo.countTokens();                       
            
            Map<String, Object> params = new HashMap<String, Object>();
            
            for(int i=0; i < rowCount; i++){
            	
            	point1 = "";
                point2 = "";
                point3 = "";
                point4 = "";
                            	            	
            	point1 = stPoint1.nextToken();
            	point2 = stPoint2.nextToken();
            	point3 = stPoint3.nextToken();
            	point4 = stPoint4.nextToken();
            	
            	if(point1.equals("empty")){
            		point1 = "";
            	}
            	if(point2.equals("empty")){
            		point2 = "";
            	}
            	if(point3.equals("empty")){
            		point3 = "";
            	}
            	if(point4.equals("empty")){
            		point4 = "";
            	}
            	       	
            	userNo = stUserNo.nextToken();
            	
            	params.put("grCode", grCode);
            	params.put("grSeq", grSeq);
            	params.put("subj", subj);
            	params.put("userNo", userNo);
            	params.put("point1", point1);
            	params.put("point2", point2);
            	params.put("point3", point3);
            	params.put("point4", point4);
            	
            	langSubjMapper.updateLangSubj(params);
            	returnValue++;
            }
            
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return returnValue;        
	}
}
