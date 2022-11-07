package loti.login.service;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

import loti.login.mapper.LoginMapper;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import ut.lib.exception.BizException;
import ut.lib.support.DataMap;
import ut.lib.util.Message;

@Service
public class LoginService {

	@Autowired
	private LoginMapper loginMapper;
	
	public DataMap selectLoginChk(String userId) throws BizException {
		
		DataMap resultMap = null;
        
        try {
        	
            resultMap = loginMapper.selectLoginChk(userId);
                                    
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return resultMap;        
	}
	
	public DataMap selectLoginPwdChk(String userId) throws BizException {
		
		DataMap resultMap = null;
        
        try {
        	
            resultMap = loginMapper.selectLoginPwdChk(userId);
                                    
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return resultMap;        
	}

	public DataMap selectAuthority(String userNo) throws BizException {

		DataMap resultMap = null;
        
        try {
        	
            resultMap = loginMapper.selectAuthority(userNo);
                                    
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return resultMap;        
	}

	public int updateLoginInfo(String userNo) throws SQLException, BizException {

        int returnValue = 0;
        
        try {
        	
            returnValue = loginMapper.updateLoginInfo(userNo);
            
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return returnValue;
	}

	public int updateLoginFailInfo(String userNo, int lgfailcnt) throws BizException {

        int returnValue = 0;
        
        try {
            
        	Map<String, Object> params = new HashMap<String, Object>();
        	
        	params.put("userNo", userNo);
        	params.put("lgfailcnt", lgfailcnt);
        	
            returnValue = loginMapper.updateLoginFailInfo(params);
            
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return returnValue;
	}

	public String checkPasswordIsNull(String id) throws BizException {

        String result = null;
        
        try {
        	
            result = loginMapper.checkPasswordIsNull(id);
                                    
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return result;   
	}

	public String checkPersonalInfo(String id, String email) throws BizException {

        String result = null;
        
        try {
        	
        	Map<String,Object> params = new HashMap<String, Object>();
        	
        	params.put("id", id);
        	params.put("email", email);
        	
            result = loginMapper.checkPersonalInfo(params);
                                    
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return result;        
	}

	public void sendSmsSetPassword(String hp, String msg) throws BizException {

        try {
        	
        	Map<String,Object> params = new HashMap<String, Object>();
        	
        	params.put("hp", hp);
        	params.put("msg", msg);
        	
            loginMapper.sendSmsSetPassword(params);
                                    
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
	}

	public int openUpdatePassword(String pw, String id) throws BizException {

        int result = 0;
        try {
        	
        	Map<String,Object> params = new HashMap<String, Object>();
        	
        	params.put("pw", pw);
        	params.put("id", id);
        	
            result = loginMapper.openUpdatePassword(params);
                                    
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return result;
	}
	
	public int openUpdateDamoPassword(String id) throws BizException {

        int result = 0;
        try {
        	
        	Map<String,Object> params = new HashMap<String, Object>();
        	
        	
        	params.put("id", id);
        	
            result = loginMapper.openUpdateDamoPassword(params);
                                    
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return result;
	}
	

	public void setPasswordLog(String id, String remoteAddr) throws BizException {

        try {
        	
        	Map<String,Object> params = new HashMap<String, Object>();
        	
        	params.put("ip", remoteAddr);
        	params.put("id", id);
        	
            loginMapper.setPasswordLog(params);
                                    
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
	}

	
	/**
	 * SSO로그인 체크 
	 * @param userId
	 * @return
	 * @throws Exception
	 */
	public DataMap selectSSOLoginChk(String resno) throws BizException{
		
        DataMap resultMap = null;
        
        try {
        	
            resultMap = loginMapper.selectSSOLoginChk(resno);
                                    
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return resultMap;        
	}
	
	public DataMap selectPwdChk(String userno) throws BizException{
		
		DataMap pwdDate = null;
        
        try {
        	
        	pwdDate = loginMapper.selectPwdChk(userno);
                                    
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return pwdDate;        
	}
	
	
	
	

}
