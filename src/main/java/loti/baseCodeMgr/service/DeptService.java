package loti.baseCodeMgr.service;

import java.sql.SQLException;
import java.util.Map;

import loti.baseCodeMgr.mapper.DeptMapper;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import ut.lib.exception.BizException;
import ut.lib.page.PageNavigation;
import ut.lib.support.DataMap;
import ut.lib.util.Message;
import ut.lib.util.Util;

import common.service.BaseService;

@Service
public class DeptService extends BaseService {

	@Autowired
	private DeptMapper deptMapper;
	
	/**
	 * 기관코드 리스트
	 */
	public DataMap selectDeptCodeList(DataMap requestMap) throws BizException{
		DataMap resultMap = null;
		
        try {
        	
			if(!requestMap.getString("qu").equals("member")){
		    	int totalCnt = deptMapper.selectDeptCodeListCount(requestMap);
	        	
	        	Map<String, Object> pageInfo = Util.getPageInfo(totalCnt, requestMap);
	        	
	        	requestMap.set("page", pageInfo);
	        	
	            resultMap = deptMapper.selectDeptCodeList(requestMap);
	            
	            PageNavigation pageNavi = Util.getPageNavigation(pageInfo);
			    resultMap.set("PAGE_INFO", pageNavi);
			}else{
				resultMap = deptMapper.selectDeptCodeListNotPaging(requestMap);
			}
        	
        	//기관코드관리 리스트
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return resultMap;        
	}
	
	/**
	 * 기관코드 전체리스트
	 */
	public DataMap allDeptCodeList(DataMap requestMap) throws BizException{
		DataMap resultMap = null;
        
        try {
	    	int totalCnt = deptMapper.selectAllDeptCodeListCount(requestMap);
        	
        	Map<String, Object> pageInfo = Util.getPageInfo(totalCnt, requestMap);
        	
        	requestMap.set("page", pageInfo);
        	
            resultMap = deptMapper.selectAllDeptCodeList(requestMap);
            
            PageNavigation pageNavi = Util.getPageNavigation(pageInfo);
		    resultMap.set("PAGE_INFO", pageNavi);
		    
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return resultMap;        
	}
	
	/**
	 * 부서코드 리스트
	 */
	public DataMap partCodeList(String dept) throws BizException{
		DataMap resultMap = null;
        
        try {
            resultMap = deptMapper.selectPartCodeList(dept);
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return resultMap;        
	}
	
	/**
	 * 기관코드 ROW데이터

	 */
	public DataMap selectDeptCodeRow(String dept) throws BizException{
		DataMap resultMap = null;
        
        try {
            resultMap = deptMapper.selectDeptCodeForm(dept);
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return resultMap;        
	}
	
	
	/**
	 * 전체기관코드 리스트
	 */
	public DataMap selectAllDeptCodeRow(String dept) throws BizException{
		DataMap resultMap = null;
        
        try {
           resultMap = deptMapper.selectAllDeptCodeForm(dept);
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return resultMap;        
	}
	
	/**
	 * 기관코드관리 등록
	 */
	public int insertDept(DataMap requestMap) throws BizException{
		int returnValue = 0;
       
        try {
        	DataMap deptCode = deptMapper.selectDeptCodeCountRow(requestMap.getString("dept"));
            
            int checkValue = deptCode.getInt("count");
            
            //기관코드 중복카운터[e]
            if (checkValue <= 0) {
            	//기관코드 인서트 
            	deptMapper.insertDept(requestMap);
                requestMap.setString("msg", "등록하였습니다.");
                requestMap.setString("temp", "0");
            } else {
            	 requestMap.setString("msg", "중복된 기관코드가 있습니다.");
            	 requestMap.setString("temp", "1");
            }
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return returnValue;        
	}
	
	/**
	 * 전체기관코드 등록
	 */
	public int insertAllDept(DataMap requestMap) throws BizException{
		int returnValue = 0;
       
        try {
        	//기관코드 중복카운터[s]
            DataMap deptCode = deptMapper.selectAllDeptCodeRow(requestMap);
            
            int checkValue = deptCode.getInt("count");
            
            //기관코드 중복카운터[e]
            if(checkValue <= 0){
            	//기관코드 인서트 
            	deptMapper.insertAllDept(requestMap);
                requestMap.setString("msg", "등록하였습니다.");
            } else {
            	 requestMap.setString("msg", "중복된 기관코드가 있습니다.");
            }
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return returnValue;        
	}
	
	/**
	 * 기관코드관리 수정
	 */
	public int modifyDeptCode(DataMap requestMap) throws BizException{
		int returnValue = 0;
       
        try {
        	//직급코드 수정 
        	deptMapper.modifyDeptCode(requestMap);
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return returnValue;        
	}
	
	/**
	 * 전체 기관코드관리 수정
	 */
	public int modifyAllDeptCode(DataMap requestMap) throws BizException{
        int returnValue = 0;
        
        try {
        	//직급코드 수정 
        	deptMapper.modifyAllDeptCode(requestMap);
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return returnValue;        
	}
	
	/**
	 * 부서코드관리 수정폼 데이터
	 */
	public DataMap selectPartCodeRow(String dept) throws BizException{
		DataMap resultMap = null;
       
        try {
            resultMap = deptMapper.selectPartCodeRow(dept);
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return resultMap;        
	}
	
	/**
	 * 부서관리 등록
	 */
	public int partInsert(DataMap requestMap) throws BizException{
		int returnValue = 0;
       
        try {
        	//부서코드  중복카운터[s]
            DataMap selectPartCodeRow = deptMapper.selectPartCodeCountRow(requestMap.getString("partcd"));
            
            int checkValue = selectPartCodeRow.getInt("count");
            
            //기관코드 중복카운터[e]
            if (checkValue <= 0) {
            	//기관코드 인서트 
            	deptMapper.insertPart(requestMap);
                requestMap.setString("msg", "등록하였습니다.");
            } else {
            	 requestMap.setString("msg", "중복된 부서코드가 있습니다.");
            }
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return returnValue;        
	}
	
	/**
	 * 부서 정보 수정
	 */
	public int partUpdate(DataMap requestMap) throws BizException{
        int returnValue = 0;
        
        try {
        	//직급코드 수정 
        	deptMapper.partUpdate(requestMap);
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return returnValue;        
	}
	
	/**
	 * 부서 수정폼 데이터 
	 */	
	public DataMap selectPartRow(DataMap requestMap) throws BizException{
		DataMap resultMap = null;
        
        try {
            resultMap = deptMapper.selectPartRow(requestMap);
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return resultMap;        
	}
	
	/**
	 * 전체 기관리스트에서의 기관코드 삭제
	 */
	public int deptDelete(DataMap requestMap) throws BizException{
        int returnValue = 0;
        
        try {
        	//부서코드  중복카운터[s]
            int selectPartCodeRow = deptMapper.selectPartCodeCheckRow(requestMap.getString("dept"));
            
            if(selectPartCodeRow <= 0){
            	//삭제 시작
            	deptMapper.deptDelete(requestMap.getString("dept"));
            	requestMap.setString("msg", "삭제하였습니다.");
            }else{
            	requestMap.setString("msg", "등록된 부서가 있어서 삭제가 불가능합니다.");
            }
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return returnValue;        
	}
	
	/**
	 * 기관코드 삭제
	 */
	public int allDeptDelete(DataMap requestMap) throws BizException{
        int returnValue = 0;
        
        try {
        	deptMapper.allDeptDelete(requestMap.getString("dept"));
        	requestMap.setString("msg", "삭제하였습니다.");
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return returnValue;        
	}
	
	
	/**
	 * 부서 정보 삭제
	 */
	public int partDelete(DataMap requestMap) throws BizException{
        int returnValue = 0;
        
        try {
        	deptMapper.partDelete(requestMap);
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return returnValue;        
	}
}
