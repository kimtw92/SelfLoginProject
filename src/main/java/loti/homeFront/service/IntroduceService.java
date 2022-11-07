package loti.homeFront.service;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

import loti.homeFront.mapper.IndexMapper;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import ut.lib.exception.BizException;
import ut.lib.page.PageFactory;
import ut.lib.page.PageInfo;
import ut.lib.page.PageNavigation;
import ut.lib.support.DataMap;
import ut.lib.util.Constants;
import ut.lib.util.Message;
import ut.lib.util.Util;
import common.service.BaseService;

@Service
public class IntroduceService extends BaseService {

	@Autowired
	private IndexMapper indexMapper;
	
	public DataMap getEducationMonthAJAXList(DataMap dataMap) throws BizException {

		DataMap resultMap = null;
	    
	    try {
				
				String monthajax = dataMap.getString("monthajax");
				
				int totalCnt = indexMapper.getEducationMonthAJAXListCount(monthajax);
				int currPage = 1;
				int rowSize = 0;
				
				try{
					currPage = Integer.parseInt(dataMap.getString("currPage"));
				}catch(NumberFormatException nfe){
					currPage = 1;
				}
				try{
					rowSize = Integer.parseInt(dataMap.getString("rowSize"));
				}catch(NumberFormatException nfe){
					rowSize = 0;
				}
				
				Map<String, Object> pageInfo = Util.getPageInfo(totalCnt, currPage, rowSize);

				pageInfo.put("monthajax", monthajax);

				resultMap = indexMapper.getEducationMonthAJAXList(pageInfo);
				
				/**
				 * 페이징 필수
				 */
		    	PageInfo pi = new PageInfo(totalCnt, rowSize, 0, currPage);

		    	PageNavigation pageNavi = PageFactory.getInstance(Constants.DEFAULT_PAGE_CLASS, pi);
				
		    	resultMap.set("PAGE_INFO", pageNavi);
				
	                                
	    } catch (SQLException e) {
	        throw new BizException(Message.getKey(e), e);
	    } finally {
	    }
	    return resultMap;     
	}

	public DataMap getTeamList() throws BizException {

	    DataMap resultMap = null;
	    
	    try {
	    	
	        resultMap = indexMapper.getTeamList();
	                                
	    } catch (SQLException e) {
	        throw new BizException(Message.getKey(e), e);
	    } finally {
	    }
	    return resultMap;   
	}

	public DataMap getTeamListByName(String name) throws BizException {

		DataMap resultMap = null;
	    
	    try {
	        resultMap = indexMapper.getTeamListByName(name);
	    } catch (SQLException e) {
	        throw new BizException(Message.getKey(e), e);
	    } finally {
	    }
	    return resultMap;
	}

	public DataMap getTeamListByWork(String work) throws BizException {

		DataMap resultMap = null;
	    
	    try {
	    	
	        resultMap = indexMapper.getTeamListByWork(work);
	                                
	    } catch (SQLException e) {
	        throw new BizException(Message.getKey(e), e);
	    } finally {
	    }
	    return resultMap;   
	}

	public int existAlreadyReservation(String resv_day, String place, String gubun) throws BizException {

	    int result     = 0;
	    
	    try {
	    	
	    	Map<String, Object> params = new HashMap<String, Object>();
	    	
	    	params.put("resv_day", resv_day);
	    	params.put("place", place);
	    	params.put("gubun", gubun);
	    	
	        result = indexMapper.existAlreadyReservation(params);
	                                
	    } catch (SQLException e) {
	        throw new BizException(Message.getKey(e), e);
	    } finally {
	    }
	    return result;   
	}

	public DataMap getReservationList(String date, String place) throws BizException {

		DataMap resultMap = null;
	    
	    try {
	    	
	    	Map<String, Object> params = new HashMap<String, Object>();
	    	
	    	params.put("date", date);
	    	params.put("place", place);
	    	
	        resultMap = indexMapper.getReservationList(params);
	                                
	    } catch (SQLException e) {
	        throw new BizException(Message.getKey(e), e);
	    } finally {
	    }
	    return resultMap;   
	}

	public int getDuplicateReservationCount(String jumin, String resv_day) throws BizException {

	    int result 		= 0;
	    
	    try {
	        
	    	Map<String, Object> params = new HashMap<String, Object>();
	    	
	    	params.put("jumin", jumin);
	    	params.put("day", resv_day);
	    	
	        result = indexMapper.getDuplicateReservationCount(params);
	                                
	    } catch (SQLException e) {
	        throw new BizException(Message.getKey(e), e);
	    } finally {
	    }
	    return result;        
	}

	@Transactional
	public int setReservation(
				String resvname
				, String homeaddr
				, String tel
				, String jumin
				, String resv_day
				, String content
				, String person
				, String groupname
				, String place
				, String gubun
				, String sum
				, String room50
				, String room100
				, String starttime
				, String endtime
				, String sexm
				, String sexf
				, String startdate
				, String enddate
			) throws BizException {

	    int result = 0;
	    
	    try {
	    	
	    	int maxnum = indexMapper.getMaxApplication();	// TA_PK 최대값 
	        
	        Map<String, Object> params = new HashMap<String, Object>();
	        
	        params.put("maxnum", maxnum);
	        params.put("resvname", resvname);
			params.put("homeaddr", homeaddr);
			params.put("tel", tel);
			params.put("jumin", jumin);
			params.put("resv_day", resv_day);
			params.put("content", content);
			params.put("person", person);
			params.put("groupname", groupname);
			params.put("place", place);
			params.put("gubun", gubun);
			params.put("sum", sum);
			params.put("room50", room50);
			params.put("room100", room100);
			params.put("starttime", starttime);
			params.put("endtime", endtime);
			params.put("sexm", sexm);
			params.put("sexf", sexf);
			params.put("startdate", startdate);
			params.put("enddate", enddate);
	        
	        result = indexMapper.setReservation(params);
	        
	    } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
	    } finally {
	    }
	    
	    return result;
	}

	public DataMap getReservationConfirm(String name, String jumin1, String jumin2) throws BizException {

		DataMap resultMap = null;
	    
	    try {
	    	
	    	Map<String, Object> params = new HashMap<String, Object>();
	    	
	    	params.put("name", name);
	    	params.put("jumin1", jumin1);
	    	params.put("jumin2", jumin2);
	    	
	        resultMap = indexMapper.getReservationConfirm(params);
	                                
	    } catch (SQLException e) {
	        throw new BizException(Message.getKey(e), e);
	    } finally {
	    }
	    return resultMap;        
	}

//	-----------------------------------------------------------------------------------------------------------------------------------
	
	
	
	public void modifyReservation(String taPk,String resvname,String   homeaddr,String  tel,String  resv_day,String  content ,String  person,String   groupname,String   place ,String  gubun, String agrno) throws BizException{
		
	    try {
	    	
	    	Map<String, Object> params = new HashMap<String, Object>();
	    	
	    	params.put("resvname", resvname);
	    	params.put("homeaddr", homeaddr);
	    	params.put("tel", tel);
	    	params.put("resv_day", resv_day);
	    	params.put("content", content);
	    	params.put("person", Integer.parseInt(person));
	    	params.put("groupname", groupname);
	    	params.put("place", Integer.parseInt(place));
	    	params.put("gubun", gubun);
	    	params.put("agrno", agrno);
	    	params.put("taPk", taPk);
	    	
	        indexMapper.modifyReservation(params);
	                                
	    } catch (SQLException e) {
	        throw new BizException(Message.getKey(e), e);
	    } finally {
	    }
	           
	}
	
	
	public DataMap getReservationModify(String taPk) throws BizException{
		DataMap resultMap=null;
		
		try{
	        
	        resultMap = indexMapper.getReservationModify(taPk);
	                                
	    } catch (SQLException e) {
			   throw new BizException(Message.getKey(e), e);
		} finally {
	    }
	    return resultMap;
	}
	
	
	public int updateAgreement(String tapk) throws BizException{
		
	    int error_code = -1;
	    try {
	    	
	        error_code = indexMapper.updateAgreement(tapk);
	                                
	    } catch (SQLException e) {
	        throw new BizException(Message.getKey(e), e);
	    } finally {
	    }
	    return error_code;        
	}
	
	
	public DataMap getReservationConfirm(String name, String jumin1, String jumin2,String revDate) throws BizException{
		
		DataMap resultMap = null;
	    
	    try {
	    	
	    	Map<String, Object> params = new HashMap<String, Object>();
	    	
	    	params.put("name", name);
	    	params.put("jumin1", jumin1);
	    	params.put("jumin2", jumin2);
	    	params.put("revDate", revDate);
	    	
	        resultMap = indexMapper.getReservationConfirmRev(params);
	                                
	    } catch (SQLException e) {
	        throw new BizException(Message.getKey(e), e);
	    } finally {
	    }
	    return resultMap;        
	}
	
	
	
	public DataMap getReservationSurvey() throws BizException{
		
		DataMap resultMap = null;
	    
	    try {
	    	
	        resultMap = indexMapper.getReservationSurvey();
	                                
	    } catch (SQLException e) {
	        throw new BizException(Message.getKey(e), e);
	    } finally {
	    }
	    return resultMap;        
	}
	
	public DataMap getReservationSurveyDetail() throws BizException{
		
		DataMap resultMap = null;
	    
	    try {
	    	
	        resultMap = indexMapper.getReservationSurveyDetail();
	                                
	    } catch (SQLException e) {
	        throw new BizException(Message.getKey(e), e);
	    } finally {
	    }
	    return resultMap;        
	}

}
