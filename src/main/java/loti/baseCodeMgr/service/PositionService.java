package loti.baseCodeMgr.service;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

import loti.baseCodeMgr.mapper.PositionMapper;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.transaction.interceptor.TransactionAspectSupport;

import ut.lib.exception.BizException;
import ut.lib.page.PageNavigation;
import ut.lib.support.DataMap;
import ut.lib.util.Message;
import ut.lib.util.Util;
import common.service.BaseService;

@Service
public class PositionService extends BaseService {
	
	@Autowired
	private PositionMapper positionMapper;
	
	/**
	 * 직급코드관리 리스트
	 */
	public DataMap selectPositionList(DataMap requestMap) throws BizException{
		DataMap resultMap = null;
        
        try {
        	int selectPositionListCount = positionMapper.selectPositionListCount(requestMap);
        	
        	Map<String, Object> pageInfo = Util.getPageInfo(selectPositionListCount, requestMap);
        	
        	pageInfo.put("search", requestMap.getString("search"));
        	
        	resultMap = positionMapper.selectPositionList(pageInfo);
        	PageNavigation pageNavi = Util.getPageNavigation(pageInfo);
        	
        	resultMap.set("PAGE_INFO", pageNavi);
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return resultMap;        
	}
	
	/**
	 * 직급코드관리 리스트
	 */
	public DataMap selectPositionPopList(DataMap requestMap) throws BizException{
		DataMap resultMap = null;
        DataMap rowMaxPosition = null;
       
        try {
        	//직급코드 최상위값
            rowMaxPosition = positionMapper.rowMaxPosition();
            int maxJik = rowMaxPosition.getInt("maxJik") + 1;
            
            
            if(requestMap.getString("qu").equals("insert")){
            	//등록모드일경우 멕스코드값을 넣는다.
            	requestMap.setString("maxJik", String.valueOf(maxJik));
            }else{
            	//수정 모드일때 기존코드를 넣는다.
            	requestMap.setString("maxJik", requestMap.getString("jik"));
            }
            //직급코드 셀렉박스 데이터 
            resultMap = positionMapper.selectPositionPopList();
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return resultMap;        
	}
	
	/**
	 * 직급코드관리 인서트
	 */
	public int insertPosition(Map<String, Object> paramMap) throws BizException{
		int returnValue = 0;
       
        try {
        	positionMapper.insertPosition(paramMap);
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return returnValue;        
	}
	
	/**
	 * 직급코드관리 수정
	 */
	public int modifyPosition(Map<String, Object> paramMap) throws BizException{
		int returnValue = 0;
       
        try {
        	//직급코드 수정 
            positionMapper.modifyPosition(paramMap);
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return returnValue;        
	}
	
	/**
	 * 직급구분코드관리 리스트
	 */
	public DataMap selectGuBunCodeList(String guBun,DataMap requestMap) throws BizException{
		DataMap resultMap = null;
        
        try {
        	int selectGuBunCodeListCount = positionMapper.selectGuBunCodeListCount(guBun);
        	
        	Map<String, Object> pageInfo = Util.getPageInfo(selectGuBunCodeListCount, requestMap);
        	
        	pageInfo.put("guBun", guBun);
        	
        	resultMap = positionMapper.selectGuBunCodeList(pageInfo);
        	PageNavigation pageNavi = Util.getPageNavigation(pageInfo);
        	
        	resultMap.set("PAGE_INFO", pageNavi);
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return resultMap;        
	}
	
	/**
	 * 직급구분코드관리 리스트
	 */
	public DataMap selectGuBunCodeSelectBoxList() throws BizException{
		DataMap resultMap = null;
        
        try {
            resultMap = positionMapper.selectGuBunCodeSelectBoxList();
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return resultMap;        
	}
	
	/**
	 * 직급구분코드관리 인서트
	 */
	@Transactional
	public int insertGubunCode(DataMap requestMap,String userNo) throws BizException{
		int returnValue = 0;
		Map<String, Object> paramMap = null;
		
        try {
        	//직급구분코드에 따른 직급구분명을 셋시킨다.
            //사용 이유 : 선택된 셀렉트 박스에서 값이 넘어올때 코드값만 넘어오기때문이며 코드는 4개밖에없다.
            if(requestMap.getString("guBun").equals("dogs")) {
            	requestMap.setString("jikgubunnm", "계급");
            } else if(requestMap.getString("guBun").equals("jikj")) {
            	requestMap.setString("jikgubunnm", "직종");
            } else if(requestMap.getString("guBun").equals("jikl")) {
            	requestMap.setString("jikgubunnm", "직류");
            } else if(requestMap.getString("guBun").equals("jikr")) {
            	requestMap.setString("jikgubunnm", "직렬");
            }
            
        	for(int i = 0; i < requestMap.keySize("guBun"); i++){
        		if(!requestMap.getString("guBun", i).equals("")){
	        		int count = positionMapper.selectGubunCodeCountRow(requestMap.getString("code", i));
	        		
	        		if(count > 0){
	        			//중복된 데이터가 있을경우
	        			returnValue = 2;
	        			TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
	        			break;
	        		} else {
	        			paramMap = new HashMap<String, Object>();
	        			paramMap.put("guBun", requestMap.getString("guBun"));
	        			paramMap.put("code", requestMap.getString("code", i));
	        			paramMap.put("jikgubunnm", requestMap.getString("jikgubunnm"));
	        			paramMap.put("codenm", requestMap.getString("codenm", i));
	        			paramMap.put("orders", requestMap.getString("orders", i));
	        			paramMap.put("useYn", requestMap.getString("useYn"));
	        			paramMap.put("userNo", requestMap.getString("userNo"));
		            	//직급코드 인서트
		                positionMapper.insertGubunCode(paramMap);
		                returnValue=1;
	        		 }
	        		 
	                requestMap.setInt("returnValue", i+1);
        		}
        	}
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return returnValue;        
	}
	
	/**
	 * 직급코드관리 일괄등록
	 */
	public int insertAllPosition(DataMap requestMap,String userNo) throws BizException{
		int returnValue = 0;
        Map<String, Object> paramMap = null;
        
        try {
        	if(requestMap.keySize() > 0){
            	for(int i=0; i < requestMap.keySize("jik"); i++){
            		if(!requestMap.getString("jik", i).equals("")){
	                	int count = positionMapper.selectCountJikRow(requestMap.getString("jik", i));
	                	
	                	if(count > 0){
	                		returnValue = 2;
	                		//중복된 데이터가 있을경우 앞에 등록된 데이터들을 롤백하고 loop를 멈춘다.
	                		TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
	                		break;
	                	} else {
	                		paramMap = new HashMap<String, Object>();
		        			paramMap.put("jik", requestMap.getString("jik", i));
		        			paramMap.put("jiknm", requestMap.getString("jiknm", i));
		        			paramMap.put("jikj", requestMap.getString("jikj", i));
		        			paramMap.put("jikr", requestMap.getString("jikr", i));
		        			paramMap.put("dogs", requestMap.getString("dogs", i));
		        			paramMap.put("useYn", "Y");
		        			paramMap.put("userNo", userNo);
		        			paramMap.put("jikGubun", requestMap.getString("jikGubun"));
	                        //직급코드 일괄등록 
	                        positionMapper.insertAllPosition(paramMap);
	                        returnValue  = 1;
	                	}
	                	
	                	requestMap.setInt("returnValue", i+1);
	                }
            	}
            }
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        //System.out.println("##returnValue======>  "+returnValue);
        return returnValue;        
	}
}
