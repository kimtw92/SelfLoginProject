package loti.homepageMgr.service;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

import loti.homepageMgr.mapper.FoodMapper;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import ut.lib.exception.BizException;
import ut.lib.page.PageNavigation;
import ut.lib.support.DataMap;
import ut.lib.util.DateUtil;
import ut.lib.util.Message;
import ut.lib.util.Util;
import common.service.BaseService;

@Service
public class FoodService extends BaseService {
	
	@Autowired
	private FoodMapper foodMapper;
	
	/**
	 * 식단관리 리스트
	 */
	public DataMap selectFoodList(DataMap requestMap) throws BizException{
		DataMap resultMap = new DataMap();
	    String where = "";
	    
	    try {
	    	Map<String, Object> paramMap = new HashMap<String, Object>();
	    	paramMap.put("where", where);
	    	
	    	int foodListCount = foodMapper.selectFoodListCount(paramMap);
	    	
	    	Map<String, Object> pageInfo = Util.getPageInfo(foodListCount, requestMap);
	    	pageInfo.put("where", where);
	    	
	    	resultMap = foodMapper.selectFoodList(pageInfo);
	        
	        PageNavigation pageNavi = Util.getPageNavigation(pageInfo);
			
			resultMap.set("PAGE_INFO", pageNavi);
	    } catch (SQLException e) {
	        throw new BizException(Message.getKey(e), e);
	    } finally {
	    	
	    }
	    return resultMap;        
	}

	/**
	 * 식단관리 폼 데이터
	 */
	public DataMap selectFoodRow(DataMap requestMap) throws BizException{
		DataMap resultMap = new DataMap();
	    String where = "";
	    
	    try {
	    	if(!requestMap.getString("sDate").equals("")){
	        	where = "WHERE TO_CHAR(TOTAL_DATE) BETWEEN '"+requestMap.getString("sDate")+"' AND '" +requestMap.getString("eDate")+"' AND GUBUN ='"+requestMap.getString("gubun")+"'";
	        }

	    	Map<String, Object> paramMap = new HashMap<String, Object>();
	    	paramMap.put("where", where);
	    	
	        resultMap = foodMapper.selectFoodRow(paramMap);
	    } catch (SQLException e) {
	        throw new BizException(Message.getKey(e), e);
	    } finally {
	    	
	    }
	    return resultMap;        
	}
	
	/**
	 * 식단관리 등록, 수정
	 */
	public int insertFood(DataMap requestMap) throws BizException{
		int returnValue = 0;
		Map<String, Object> paramMap = null;
		
	    try {
	    	//날짜관련변수
	        int year = 0;
    	    int month = 0;
    	    int day = 0;
    	    int date = 0;
    	    //토탈데이터를 만들기위해서는 0번째의 월요일 데이터만 필요하기때문에 이렇게 변수를 따로 만든다.
    	    //int date2 = 0;
    	    
    	    String totalDate = "";
	        
    	    //수정시 사용하는 날짜데이츠 기존 사용하던 것을 기준으로 업데이트를 해야하기때문에 해놓은다.
	        //날짜관련변수
	        //int mYear = 0;
    	    //int mmonth = 0;
    	    //int mday = 0;
    	    //int mdate = 0;
    	    
	        for(int i = 0; requestMap.keySize("content") > i; i++){
	        	year 	= Integer.parseInt(requestMap.getString("sDate").substring(0,4));
	        	month 	= Integer.parseInt(requestMap.getString("sDate").substring(4,6));
	        	date	= Integer.parseInt(requestMap.getString("sDate").substring(6,8)) + i;
	        	//date2	= Integer.parseInt(requestMap.getString("sDate").substring(6,8));
    		    day = DateUtil.monthEndDay(year, month);
    		    
    		    if(date > day){
    		    	date = (date-day);
    		    	month += 1;
    		    	
    		    	if(month > 12){
    		    		month = month - 12;
    		    		year += 1; 
    		    	}
	    	    }
	    	    
	    	    //일수가 10이하일때를 대비하여 만든변수
	    	    String tDate = "";
	    	    //월수가 10이하일때를 대비하여 만든 변수
	    	    String tMonth = "";
	    	    //전체 년월일수에 들어갈 일수가 10보다 작을경우를 대비
	    	    //String aMonth = "";
	    	    
	            if(date < 10){
	            	tDate = "0" + date;
	            }else{
	            	tDate = String.valueOf(date);
	            }
	            
	            //현재 입력한 날자값
	            if(month < 10){
	            	tMonth = "0" + month;
	            }else{
	            	tMonth = String.valueOf(month);
	            }
	            
	            totalDate = String.valueOf(year) + tMonth + tDate;
	            
	        	if(requestMap.getString("qu").equals("insert")){
	        		//등록일때
	        		paramMap = new HashMap<String, Object>();
	        		paramMap.put("year", String.valueOf(year));
	    		    paramMap.put("month", tMonth);
	    		    paramMap.put("date", tDate);
	    		    paramMap.put("totalDate", totalDate);
	    		    paramMap.put("content", requestMap.getString("content", i));
	    		    paramMap.put("gubun", requestMap.getString("gubun"));
	    		    
	        		returnValue = foodMapper.insertFood(paramMap);
	        	}else{
	        		/*
	        		//수정일때
	        		mYear 	= Integer.parseInt(requestMap.getString("sDate").substring(0,4));
		        	mmonth 	= Integer.parseInt(requestMap.getString("sDate").substring(4,6));
		        	mdate	= Integer.parseInt(requestMap.getString("sDate").substring(6,8)) + i;
	    		    mday = DateUtil.monthEndDay(year, month);
	    		    
	    		    if(mdate > mday){
	    		    	mdate = (mdate-mday);
	    		    	mmonth += 1;
	    		    	
	    		    	if(mmonth > 12){
	    		    		mmonth = mmonth - 12;
	    		    		mYear += 1; 
	    		    	}
		    	    }
		    	    
		    	    //일수가 10이하일때를 대비하여 만든변수
		    	    //String mDate = "";
		    	    //월수가 10이하일때를 대비하여 만든 변수
		    	    //String mMonth = "";
		    	    
		            if(mdate < 10){
		            	mDate = "0" + mdate;
		            }else{
		            	mDate = String.valueOf(mdate);
		            }
		            
		            if(mmonth < 10){
		            	mMonth = "0" + mmonth;
		            }else{
		            	mMonth = String.valueOf(mmonth);
		            }
	        		*/
		            paramMap = new HashMap<String, Object>();
	        		paramMap.put("year", String.valueOf(year));
	    		    paramMap.put("month", tMonth);
	    		    paramMap.put("date", tDate);
	    		    paramMap.put("totalDate", totalDate);
	    		    paramMap.put("content", requestMap.getString("content", i));
	    		    paramMap.put("gubun", requestMap.getString("gubun"));
	    		    paramMap.put("seq", requestMap.getInt("seq")+i);
	    		    
	        		returnValue = foodMapper.updateFood(paramMap);
	        	}
	        }
	    } catch (SQLException e) {
	        throw new BizException(Message.getKey(e), e);
	    } finally {
	    	
	    }
	    return returnValue;        
	}
	
	/**
	 * 식단관리 중복체크
	 */
	public int ajaxCountChechk(DataMap requestMap) throws BizException{
		int returnValue = 0;
	    
	    try {
	    	Map<String, Object> paramMap = new HashMap<String, Object>();
	    	paramMap.put("sDate", requestMap.getString("sDate"));
	    	paramMap.put("gubun", requestMap.getString("gubun"));
	    	
	    	returnValue = foodMapper.ajaxCountChechk(paramMap);
	    } catch (SQLException e) {
	        throw new BizException(Message.getKey(e), e);
	    } finally {
	    	
	    }
	    return returnValue;        
	}
	
	/**
	 * 식단관리 삭제
	 */
	public int deleteFood(DataMap requestMap) throws BizException{
		int returnValue = 0;
	    
	    try {
	    	Map<String, Object> paramMap = new HashMap<String, Object>();
	    	paramMap.put("sDate", requestMap.getString("sDate"));
	    	paramMap.put("eDate", requestMap.getString("eDate"));
	    	paramMap.put("gubun", requestMap.getString("gubun"));
	    	
	    	returnValue = foodMapper.deleteFood(paramMap);
	    } catch (SQLException e) {
	        throw new BizException(Message.getKey(e), e);
	    } finally {
	    	
	    }
	    return returnValue;        
	}
}
