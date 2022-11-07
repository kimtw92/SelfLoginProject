package loti.baseCodeMgr.service;

import java.sql.SQLException;

import loti.baseCodeMgr.mapper.MenuMapper;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import ut.lib.exception.BizException;
import ut.lib.support.DataMap;
import ut.lib.util.Message;
import common.service.BaseService;

@Service
public class MenuService extends BaseService {

	@Autowired
	private MenuMapper menuMapper;
	
	/**
	 * 메뉴 관리의 관리자 목록
	 * @return
	 * @throws Exception
	 */
	public DataMap selectMenuAdminList() throws BizException{
		DataMap resultMap = null;
        
        try {
        	resultMap = menuMapper.selectMenuAdminList();                        
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return resultMap;        
	}
	
	/**
	 * 메뉴 리스트
	 */
	public DataMap selectMenuList(String menuGrade) throws BizException {
		DataMap resultMap = null;
        
        try {
            resultMap = menuMapper.selectMenuList(menuGrade);
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return resultMap;   
	}

	/**
	 * 메뉴 등록
	 */
	public int insertMenu(DataMap requestMap) throws BizException{
		int returnValue = 0;
        
        try {
        	int chkCnt = menuMapper.insertMenuCheck(requestMap);
            
        	if (chkCnt <= 0) {
            	returnValue = menuMapper.insertMenu(requestMap);
            }
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return returnValue;        
	}	
	
	/**
	 * 메뉴 수정.
	 */
	public int modifyMenu(DataMap requestMap) throws BizException{
		int returnValue = 0;
        
        try {
        	returnValue = menuMapper.updateMenu(requestMap);                        
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return returnValue;        
	}	
	
	
	/**
	 * 메뉴 삭제.
	 */
	public int deleteMenu(DataMap requestMap) throws BizException{
		int returnValue = 0;
        
        try {
        	returnValue = menuMapper.deleteMenu(requestMap);                        
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return returnValue;        
	}
	
	/**
	 * 시스템관리자 우측 상단의 미응답된 과정 질문목록 레이어 리스트를 가지고 오기
	 */
	public DataMap getLayerList() throws BizException {
		DataMap resultMap = null;
        
        try {
            resultMap = menuMapper.getLayerList();
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return resultMap;  
	}
}
