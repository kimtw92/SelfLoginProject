package loti.tutorMgr.service;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;
import java.util.StringTokenizer;

import loti.tutorMgr.mapper.TutorMgrMapper;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import ut.lib.exception.BizException;
import ut.lib.page.PageNavigation;
import ut.lib.support.DataMap;
import ut.lib.util.DateUtil;
import ut.lib.util.Message;
import ut.lib.util.Util;

import common.service.BaseService;

@Service
public class TutorMgrService extends BaseService {

	@Autowired
	private TutorMgrMapper tutorMgrMapper;

	public DataMap selectTutorField() throws BizException {

		DataMap resultMap = null;
        
        try {
        	
            resultMap = tutorMgrMapper.selectTutorField();
                                    
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return resultMap;        
	}

	public DataMap selectTutorLevelTotal() throws BizException {

		DataMap resultMap = null;
        
        try {
        	
            resultMap = tutorMgrMapper.selectTutorLevelTotal();
                                    
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return resultMap;   
	}

	public DataMap selectTutorJobList() throws BizException {

		DataMap resultMap = null;
        
        try {
        	
            resultMap = tutorMgrMapper.selectTutorJobList();
                                    
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return resultMap; 
	}

	public DataMap selectCategotyTutorList(DataMap requestMap) throws BizException {

		DataMap resultMap = null;
        
        try {
    		
        	int totalCnt = tutorMgrMapper.selectCategotyTutorListCount(requestMap);
        	
        	Map<String, Object> pageInfo = Util.getPageInfo(totalCnt, requestMap);
        	
        	requestMap.set("page", pageInfo);
        	
            resultMap = tutorMgrMapper.selectCategotyTutorList(requestMap);
            
            /**
        	 * 페이징 필수
        	 */

           	PageNavigation pageNavi = Util.getPageNavigation(pageInfo);
           	resultMap.set("PAGE_INFO", pageNavi);
    		
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return resultMap;        
	}

	@Transactional
	public int updateChangeTutorAuth(String disabled, String userNo, String sessNo) throws BizException {

        int returnValue = 0;

        DataMap dmAuth = null;
        
        String authority = "";
        String gadmin = "";                   
        
        try {
        	
        	Map<String, Object> params = new HashMap<String, Object>();
        	
        	params.put("disabled", disabled);
        	params.put("userNo", userNo);
        	params.put("sessNo", sessNo);
        	
            if(disabled.equals("Y")){
            	
            	authority = "20";
            	gadmin = "7";
            	
            	params.put("authority", authority);
            	params.put("gadmin", gadmin);
            	
            	// 특수권한 잔여여부 체크
            	dmAuth = tutorMgrMapper.selectTutorManagerCount(params);
            	if("0".equals(dmAuth.get("dupcnt"))){
            		// 업데이트
            		returnValue = tutorMgrMapper.changeTutorAuthStep1ByUpdate(params);
            	}
            	
            	returnValue = tutorMgrMapper.changeTutorAuthStep2ByUpdate(params);
            	returnValue = tutorMgrMapper.changeTutorAuthStep3ByDelete(params);
            	returnValue = tutorMgrMapper.changeTutorAuthStep4ByInsert(params);
            	
            	
            }else{
            	
            	authority = "5";
            	gadmin = "7";
            	
            	params.put("authority", authority);
            	params.put("gadmin", gadmin);
            	
            	returnValue = tutorMgrMapper.changeTutorAuthStep1ByUpdate(params);
            	returnValue = tutorMgrMapper.changeTutorAuthStep2ByUpdate(params);
            	returnValue = tutorMgrMapper.changeTutorAuthStep5ByInsert(params);
            }                        
            
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return returnValue;    
	}

	public DataMap selectCategotyTutorExcelList(DataMap requestMap) throws BizException {

		DataMap resultMap = null;
        
        try {

        	int totalCnt = tutorMgrMapper.selectCategotyTutorListCount(requestMap);
        	
        	Map<String, Object> pageInfo = Util.getPageInfo(totalCnt, requestMap);
        	
        	requestMap.set("page", pageInfo);
        	
            resultMap = tutorMgrMapper.selectCategotyTutorList(requestMap);
            
            /**
        	 * 페이징 필수
        	 */

           	PageNavigation pageNavi = Util.getPageNavigation(pageInfo);
           	resultMap.set("PAGE_INFO", pageNavi);
        	
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return resultMap;  
	}

	public DataMap selectSessnoBy7(String userno) throws BizException {
        
        DataMap resultMap = null;
        
        try {
        	
            resultMap = tutorMgrMapper.selectSessnoBy7(userno);
                                    
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return resultMap;     
	}

	public DataMap selectMemberDamo(String userno) throws BizException {

		DataMap resultMap = null;
        
        try {
        	
            resultMap = tutorMgrMapper.selectMemberDamo(userno);
                                    
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return resultMap;
	}

	public DataMap selectTutorHistory(String userno, String ocgubun) throws BizException {
		
		DataMap resultMap = null;
        
        try {
        	
        	Map<String, Object> params = new HashMap<String, Object>();
        	
        	params.put("userno", userno);
        	params.put("ocgubun", ocgubun);
        	
            resultMap = tutorMgrMapper.selectTutorHistory(params);
                                    
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return resultMap;        
	}

	public DataMap selectTutorDamo(String userno) throws BizException {
		
		DataMap resultMap = null;
        
        try {
        	
            resultMap = tutorMgrMapper.selectTutorDamo(userno);
                                    
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return resultMap;    
	}

	public DataMap selectTutorGubun() throws BizException {
		
		DataMap resultMap = null;
        
        try {
        	
            resultMap = tutorMgrMapper.selectTutorGubun();
                                    
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return resultMap;  
	}

	public DataMap selectTutorLevel() throws BizException {
		
		DataMap resultMap = null;
        
        try {
        	
            resultMap = tutorMgrMapper.selectTutorLevel();
                                    
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return resultMap;   
	}

	public DataMap selectClassInfo(String userno) throws BizException {
		
		DataMap resultMap = null;
        
        try {
            
            resultMap = tutorMgrMapper.selectClassInfo(userno);
                                    
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return resultMap;   
	}

	/**
	 * 우수강사 리스트
	 * 작성일 7월 11일
	 * 작성자 정윤철
	 * @param requestMap
	 * @return selectGoodTutor
	 * @throws SQLException e
	 */
	public DataMap selectGoodTutorlList(DataMap requestMap) throws Exception{
			
	    DataMap resultMap = null;
	    try {
	    	
	        resultMap = tutorMgrMapper.selectGoodTutorlList(requestMap);
	        
	    } catch (SQLException e) {
	        throw new BizException(Message.getKey(e), e);
	    } finally {
	    }
	    return resultMap;        
	}

	/**
	 * 강사이력관리 리스트
	 * 작성일 7월 11일
	 * 작성자 정윤철
	 * @param requestMap
	 * @return selectGoodTutor
	 * @throws SQLException e
	 */
	public DataMap selectHistoryList(DataMap requestMap) throws Exception{
			
		DataMap resultMap = null;
	    String where = "";
	    String orderby = "";
	    try {
	    	//현재년도의 1월 1일
	    	int sYear = DateUtil.getYear();
	    	String sDate = sYear+"0101";
	    	//현재년도의 12월 끝날일수
	    	int eDay = DateUtil.getMonthDate(String.valueOf(sYear), "12");
	    	String eDate = sYear+"12"+eDay;
	    	
	        if(!requestMap.getString("sDate").equals("") && !requestMap.getString("eDate").equals("")){
	        	
	        }else{
	        	//기본 출력 리스트 조건은 현재년도이다.
	        	requestMap.setString("sDate", sDate);
	        	requestMap.setString("eDate", eDate);
	        	
	        }
	        
	        //엑셀 출력일때에는 페이징을 쓰지 안는다. 그래서 따로 메소드를 쓴다.
	        if(requestMap.getString("mode").equals("historyTutorexcel")){
	        	//엑셀모드
	        	resultMap = tutorMgrMapper.selectExcelHistoryList(requestMap);
	        	
	        }else if(requestMap.getString("mode").equals("historyTutorList")){
	        	//이력관리 리스트
	        	
		    	int totalCnt = tutorMgrMapper.selectHistoryListCount(requestMap);
	        	
	        	Map<String, Object> pageInfo = Util.getPageInfo(totalCnt, requestMap);
	        	
	        	requestMap.set("page", pageInfo);
	        	
	            resultMap = tutorMgrMapper.selectHistoryList(requestMap);
	            
	            PageNavigation pageNavi = Util.getPageNavigation(pageInfo);
	            resultMap.set("PAGE_INFO", pageNavi);
	        	
	        }
	        
	    } catch (SQLException e) {
	        throw new BizException(Message.getKey(e), e);
	    } finally {
	    }
	    return resultMap;        
	}

	/**
	 * 강사이력관리 강사등급명
	 * 작성일 7월 11일
	 * 작성자 정윤철
	 * @param requestMap
	 * @return selectGoodTutor
	 * @throws SQLException e
	 */
	public DataMap selectTutorLevelName() throws Exception{
			
		DataMap resultMap = null;
	    try {
	    	
	        resultMap = tutorMgrMapper.selectTutorLevelName();
	        
	    } catch (SQLException e) {
	        throw new BizException(Message.getKey(e), e);
	    } finally {
	    }
	    return resultMap;        
	}

	/**
	 * 강사이력관리 강사등급명
	 * 작성일 7월 11일
	 * 작성자 정윤철
	 * @param requestMap
	 * @return selectGoodTutor
	 * @throws SQLException e
	 */
	public DataMap selectTutorLevelCount(DataMap requestMap) throws Exception{
			
	    DataMap resultMap = null;
	    String where  = "";
	    try {
	    	
	        resultMap = tutorMgrMapper.selectTutorLevelCount(requestMap);
	        
	    } catch (SQLException e) {
	        throw new BizException(Message.getKey(e), e);
	    } finally {
	    }
	    return resultMap;        
	}

	/**
	 * 외래강사관리 수당관리 -> 사이버 강사 리스트
	 * 작성일 7월 14일
	 * 작성자 정윤철
	 * @param requestMap
	 * @return selectYsalaryList
	 * @throws SQLException e
	 */
	public DataMap selectSalaryCyberList(DataMap requestMap) throws Exception{
			
		DataMap resultMap = null;
	    String where  = "";
	    String endDate = "";
	    
	    //기간내에 확정된 수당내역이 있는지 체크한다.
	    int count = 0;
	    
	    
	    
	    /****************************요일관련[s]**************************/
	    int year = 0;
	    int month = 0;
	    int day = 0;
	    int eDate =0;
	    
	    if(!requestMap.getString("sDate").equals("")){
		    //월요일을 선택하였을때 해당 달의 마지막 월요일이 30일일경우를 대비하여 만들어놓는다.
		    //30일이 될경우 월에 +1 그리고 만약 또다시 월에서 12개월이 지나갈경우 년도에 +1을 해준다.
		    year = Integer.parseInt(requestMap.getString("sDate").substring(0, 4));
		    month = Integer.parseInt(requestMap.getString("sDate").substring(4, 6));
		    eDate = Integer.parseInt(requestMap.getString("sDate").substring(6, 8))+4;
		    day = DateUtil.monthEndDay(year, month);
	
		    if(eDate > day){
		    	eDate = (eDate-day);
		    	month += 1;
		    	
		    	if(month > 12){
		    		month = month - 12;
		    		year += 1; 
		    	}
		    }
	    }
	    if(month < 10){
	    	if(eDate >= 10){
	    		//검색 일자가 10일 이상일 경우
	    		endDate = String.valueOf(year)+"0"+String.valueOf(month)+String.valueOf(eDate);
	    	}else{
	    		//검색일자가 10일 이하일 경우
	    		endDate = String.valueOf(year)+"0"+String.valueOf(month)+"0"+String.valueOf(eDate);
	    	}
	    	
	    }else if(month < 10 && eDate < 10){
	    	endDate = String.valueOf(year)+"0"+String.valueOf(month)+"0"+String.valueOf(eDate);
	    	
	    }else if(month > 10 && eDate < 10){
	    	endDate = String.valueOf(year)+String.valueOf(month)+"0"+String.valueOf(eDate);
	    	
	    }else{
	    	if(eDate > 10){
	    		//검색 일자가 10일 이상일 경우
	    		endDate = String.valueOf(year)+String.valueOf(month)+String.valueOf(eDate);
	    	}else{
	    		//검색일자가 10일 이하일 경우
	    		endDate = String.valueOf(year)+String.valueOf(month)+"0"+String.valueOf(eDate);
	    	}
	    }
	    /****************************요일관련[e]**************************/
	    
	    try {
	    	
	    	requestMap.setString("endDate", endDate);
	    	
	        count = tutorMgrMapper.selectNsalaryCountRow(requestMap);
	        	

	        if(requestMap.getString("gubun").equals("Y")){
	        	resultMap = tutorMgrMapper.selectYsalaryList(requestMap);
	        }else{
	        	if(count <= 0){
	        		//수당확정내역이 없을경우
	        		String temp = eDate+"235959";
	        		requestMap.addString("temp", temp);
	        		resultMap = tutorMgrMapper.selectNsalaryList(requestMap);
	        	}else{
	        		//수당확정내역이 있을경우
	        		resultMap = new DataMap();
	        		resultMap.setString("userno", "1");
	        		resultMap.setString("count", "1");
	        		resultMap.setString("content", "수당확정이 된 기간이므로 미확정데이터를 표시 할 수 없습니다. 확정된 수당내역을 취소한 뒤 확인해 볼 수 있습니다");
		        }
	        	
	        }
	        
	    } catch (SQLException e) {
	        throw new BizException(Message.getKey(e), e);
	    } finally {
	    }
	    return resultMap;        
	}

	/**
	 * 외래강사수당내역 집합강사료
	 * 작성일 7월 14일
	 * 작성자 정윤철
	 * @param requestMap
	 * @return selectCollecList
	 * @throws SQLException e
	 */
	public DataMap selectSalaryCollecList(DataMap requestMap) throws Exception{
			
		DataMap resultMap = null;
	    
	    //서브쿼리에 들어갈 where
	    String where  = "";
	    //where절에 들어갈 쿼리
	    String andWhere = "";

	    int year = 0;
	    int month = 0;
	    int day = 0;
	    int eDate =0;
	    String endDate = "";
	    
	    if(!requestMap.getString("sDate").equals("")){
		    //월요일을 선택하였을때 해당 달의 마지막 월요일이 30일일경우를 대비하여 만들어놓는다.
		    //30일이 될경우 월에 +1 그리고 만약 또다시 월에서 12개월이 지나갈경우 년도에 +1을 해준다.
		    year = Integer.parseInt(requestMap.getString("sDate").substring(0, 4));
		    month = Integer.parseInt(requestMap.getString("sDate").substring(4, 6));
		    eDate = Integer.parseInt(requestMap.getString("sDate").substring(6, 8))+4;
		    day = DateUtil.monthEndDay(year, month);
	
		    if(eDate > day){
		    	eDate = (eDate-day);
		    	month += 1;
		    	
		    	if(month > 12){
		    		month = month - 12;
		    		year += 1; 
		    	}
		    }
	    }
	    if(month < 10){
	    	if(eDate >= 10){
	    		//검색 일자가 10일 이상일 경우
	    		endDate = String.valueOf(year)+"0"+String.valueOf(month)+String.valueOf(eDate);
	    	}else{
	    		//검색일자가 10일 이하일 경우
	    		endDate = String.valueOf(year)+"0"+String.valueOf(month)+"0"+String.valueOf(eDate);
	    	}
	    	
	    }else if(month < 10 && eDate < 10){
	    	endDate = String.valueOf(year)+"0"+String.valueOf(month)+"0"+String.valueOf(eDate);
	    	
	    }else if(month > 10 && eDate < 10){
	    	endDate = String.valueOf(year)+String.valueOf(month)+"0"+String.valueOf(eDate);
	    	
	    }else{
	    	if(eDate > 10){
	    		//검색 일자가 10일 이상일 경우
	    		endDate = String.valueOf(year)+String.valueOf(month)+String.valueOf(eDate);
	    	}else{
	    		//검색일자가 10일 이하일 경우
	    		endDate = String.valueOf(year)+String.valueOf(month)+"0"+String.valueOf(eDate);
	    	}
	    }
	    
	    
	    try {
	    	
	        if(!requestMap.getString("grcode").equals("")){
	        	where += " WHERE GRCODE = '"+requestMap.getString("grcode")+"'";
	        	andWhere += " AND A.GRCODE = '"+requestMap.getString("grcode")+"'";
	        	
	        }

	        Map<String, Object> params = new HashMap<String, Object>();
	        
	        params.put("sDate", requestMap.getString("sDate"));
	        params.put("endDate", endDate);
	        
	        if(requestMap.getString("gubun").equals("N")){
	        	resultMap = tutorMgrMapper.selectNcollecList(params);
	        	
	        }else{
	        	resultMap = tutorMgrMapper.selectYcollecList(params);
	        	
	        }
	        
	    } catch (SQLException e) {
	        throw new BizException(Message.getKey(e), e);
	    } finally {
	    }
	    
	    return resultMap;        
	}

	/**
	 * 외래강사수당내역 원고료
	 * 작성일 7월 14일
	 * 작성자 정윤철
	 * @param requestMap
	 * @return selectGoodTutor
	 * @throws SQLException e
	 */
	public DataMap selectSalaryCopyPayList(DataMap requestMap) throws Exception{
			
	    DataMap resultMap = null;
	    
	    //서브쿼리에 들어갈 where
	    String where  = "";

	    int year = 0;
	    int month = 0;
	    int day = 0;
	    int eDate =0;
	    String endDate = "";
	    
	    if(!requestMap.getString("sDate").equals("")){
		    //월요일을 선택하였을때 해당 달의 마지막 월요일이 30일일경우를 대비하여 만들어놓는다.
		    //30일이 될경우 월에 +1 그리고 만약 또다시 월에서 12개월이 지나갈경우 년도에 +1을 해준다.
		    year = Integer.parseInt(requestMap.getString("sDate").substring(0, 4));
		    month = Integer.parseInt(requestMap.getString("sDate").substring(4, 6));
		    eDate = Integer.parseInt(requestMap.getString("sDate").substring(6, 8))+4;
		    day = DateUtil.monthEndDay(year, month);
	
		    if(eDate > day){
		    	eDate = (eDate-day);
		    	month += 1;
		    	
		    	if(month > 12){
		    		month = month - 12;
		    		year += 1; 
		    	}
		    }
	    }
	    if(month < 10){
	    	if(eDate >= 10){
	    		//검색 일자가 10일 이상일 경우
	    		endDate = String.valueOf(year)+"0"+String.valueOf(month)+String.valueOf(eDate);
	    	}else{
	    		//검색일자가 10일 이하일 경우
	    		endDate = String.valueOf(year)+"0"+String.valueOf(month)+"0"+String.valueOf(eDate);
	    	}
	    	
	    }else if(month < 10 && eDate < 10){
	    	endDate = String.valueOf(year)+"0"+String.valueOf(month)+"0"+String.valueOf(eDate);
	    	
	    }else if(month > 10 && eDate < 10){
	    	endDate = String.valueOf(year)+String.valueOf(month)+"0"+String.valueOf(eDate);
	    	
	    }else{
	    	if(eDate > 10){
	    		//검색 일자가 10일 이상일 경우
	    		endDate = String.valueOf(year)+String.valueOf(month)+String.valueOf(eDate);
	    	}else{
	    		//검색일자가 10일 이하일 경우
	    		endDate = String.valueOf(year)+String.valueOf(month)+"0"+String.valueOf(eDate);
	    	}
	    }
	    try {
	    	
	        Map<String, Object> params = new HashMap<String, Object>();
	        
	        params.put("sDate", requestMap.getString("sDate"));
	        params.put("endDate", endDate);
	        
	        if(requestMap.getString("gubun").equals("N")){
	        	resultMap = tutorMgrMapper.selectNcopyPayList(params);
	        }else{
	        	resultMap = tutorMgrMapper.selectYcopyPayList(params);
	        }
	        
	    } catch (SQLException e) {
	        throw new BizException(Message.getKey(e), e);
	    } finally {
	    }
	    return resultMap;        
	}

	/**
	 * 외래강사수당내역 출제료
	 * 작성일 7월 14일
	 * 작성자 정윤철
	 * @param requestMap
	 * @return selectGoodTutor
	 * @throws SQLException e
	 */
	public DataMap selectSalaryExamList(DataMap requestMap) throws Exception{
			
		DataMap resultMap = null;
	    
	    //서브쿼리에 들어갈 where
	    String where  = "";
	   
	    int year = 0;
	    int month = 0;
	    int day = 0;
	    int eDate =0;
	    String endDate = "";
	    String eendDate = "";
	    
	    if(!requestMap.getString("sDate").equals("")){
		    //월요일을 선택하였을때 해당 달의 마지막 월요일이 30일일경우를 대비하여 만들어놓는다.
		    //30일이 될경우 월에 +1 그리고 만약 또다시 월에서 12개월이 지나갈경우 년도에 +1을 해준다.
		    year = Integer.parseInt(requestMap.getString("sDate").substring(0, 4));
		    month = Integer.parseInt(requestMap.getString("sDate").substring(4, 6));
		    eDate = Integer.parseInt(requestMap.getString("sDate").substring(6, 8))+4;
		    day = DateUtil.monthEndDay(year, month);
	
		    if(eDate > day){
		    	eDate = (eDate-day);
		    	month += 1;
		    	
		    	if(month > 12){
		    		month = month - 12;
		    		year += 1; 
		    	}
		    }
	    }
	    if(month < 10){
	    	if(eDate >= 10){
	    		//검색 일자가 10일 이상일 경우
	    		endDate = String.valueOf(year)+"0"+String.valueOf(month)+String.valueOf(eDate);
	    	}else{
	    		//검색일자가 10일 이하일 경우
	    		endDate = String.valueOf(year)+"0"+String.valueOf(month)+"0"+String.valueOf(eDate);
	    	}
	    	
	    }else if(month < 10 && eDate < 10){
	    	endDate = String.valueOf(year)+"0"+String.valueOf(month)+"0"+String.valueOf(eDate);
	    	
	    }else if(month > 10 && eDate < 10){
	    	endDate = String.valueOf(year)+String.valueOf(month)+"0"+String.valueOf(eDate);
	    	
	    }else{
	    	if(eDate > 10){
	    		//검색 일자가 10일 이상일 경우
	    		endDate = String.valueOf(year)+String.valueOf(month)+String.valueOf(eDate);
	    	}else{
	    		//검색일자가 10일 이하일 경우
	    		endDate = String.valueOf(year)+String.valueOf(month)+"0"+String.valueOf(eDate);
	    	}
	    }
	    
	     
	    eendDate = endDate+"235959";
	    
	    
	    try {
	    	
	        if(!requestMap.getString("grcode").equals("")){
	        	where += " WHERE A.GRCODE = '"+requestMap.getString("grcode")+"'";
	        	
	        }
	        
	        Map<String, Object> params = new HashMap<String, Object>();
	        
	        params.put("sDate", requestMap.getString("sDate"));
	        params.put("endDate", endDate);
	        params.put("fullEndDate", eendDate);
	        
	        if(requestMap.getString("gubun").equals("N")){
	        	resultMap = tutorMgrMapper.selectNexamList(params);
	        }else{
	        	resultMap = tutorMgrMapper.selectYexamList(params);
	        	
	        }
	        
	    } catch (SQLException e) {
	        throw new BizException(Message.getKey(e), e);
	    } finally {
	    }
	    return resultMap;        
	}

	/**
	 * 사이버 강사, 집합강사 기본팝업 리스트
	 * 작성일 7월 14일
	 * 작성자 정윤철
	 * @param requestMap
	 * @return selectGoodTutor
	 * @throws SQLException e
	 */
	public DataMap selectCoursorList() throws Exception{
			
		DataMap resultMap = null;
	    try {
	    	
	        resultMap = tutorMgrMapper.selectCoursorList();
	        
	    } catch (SQLException e) {
	        throw new BizException(Message.getKey(e), e);
	    } finally {
	    }
	    return resultMap;        
	}

	/**
	 * 사이버 강사, 집합강사 기본팝업 리스트
	 * 작성일 7월 14일
	 * 작성자 정윤철
	 * @param requestMap
	 * @return selectGoodTutor
	 * @throws SQLException e
	 */
	public DataMap selectTutorCyberAndCollecPop() throws Exception{
			
		DataMap resultMap = null;
	    
	    try {
	    	
	        resultMap = tutorMgrMapper.selectTutorCyberAndCollecPop();	
	        
	    } catch (SQLException e) {
	        throw new BizException(Message.getKey(e), e);
	    } finally {
	    }
	    return resultMap;        
	}

	/**
	 * 사이버강사 수강료 과제물출제 수당, 질의 응답 수당 Row
	 * 작성일 7월 14일
	 * 작성자 정윤철
	 * @param requestMap
	 * @return selectGoodTutor
	 * @throws SQLException e
	 */
	public DataMap selectTutorSalaryQustionRow() throws Exception{
			
		DataMap resultMap = null;
	    
	    try {
	    	
        	//사이버강사 모드일때 사이버강사 수강료 과제물출제 수당과 질의 응답수당의 값을 가져온다.
	        resultMap = tutorMgrMapper.selectTutorSalaryQustionRow();
	        
	    } catch (SQLException e) {
	        throw new BizException(Message.getKey(e), e);
	    } finally {
	    }
	    return resultMap;        
	}

	/**
	 * 외래강사 수강료관리 사이버강사료 등록 삭제 메소드
	 * 작성일 7월 14일
	 * 작성자 정윤철
	 * @param requestMap
	 * @return selectGoodTutor
	 * @throws SQLException e
	 */
	@Transactional
	public int insertTutorSalaryNcyberPay(DataMap requestMap) throws Exception{
			
	    int returnValue = 0;
	    String where  = "";
	    //날짜형식  YYYYMMDDHH24SS
	    String eeDate = "";
	    String endDate = "";

	    int year = 0;
	    int month = 0;
	    int day = 0;
	    int eDate =0;
	    
	    if(!requestMap.getString("sDate").equals("")){
		    //월요일을 선택하였을때 해당 달의 마지막 월요일이 30일일경우를 대비하여 만들어놓는다.
		    //30일이 될경우 월에 +1 그리고 만약 또다시 월에서 12개월이 지나갈경우 년도에 +1을 해준다.
		    year = Integer.parseInt(requestMap.getString("sDate").substring(0, 4));
		    month = Integer.parseInt(requestMap.getString("sDate").substring(4, 6));
		    eDate = Integer.parseInt(requestMap.getString("sDate").substring(6, 8))+4;
		    day = DateUtil.monthEndDay(year, month);
	
		    if(eDate > day){
		    	eDate = (eDate-day);
		    	month += 1;
		    	
		    	if(month > 12){
		    		month = month - 12;
		    		year += 1; 
		    	}
		    }
	    }
	    if(month < 10){
	    	if(eDate > 10){
	    		//검색 일자가 10일 이상일 경우
	    		endDate = String.valueOf(year)+"0"+String.valueOf(month)+String.valueOf(eDate);
	    	}else{
	    		//검색일자가 10일 이하일 경우
	    		endDate = String.valueOf(year)+"0"+String.valueOf(month)+"0"+String.valueOf(eDate);
	    	}
	    	
	    }else if(month < 10 && eDate < 10){
	    	endDate = String.valueOf(year)+"0"+String.valueOf(month)+"0"+String.valueOf(eDate);
	    	
	    }else if(month > 10 && eDate < 10){
	    	endDate = String.valueOf(year)+String.valueOf(month)+"0"+String.valueOf(eDate);
	    	
	    }else{
	    	if(eDate > 10){
	    		//검색 일자가 10일 이상일 경우
	    		endDate = String.valueOf(year)+String.valueOf(month)+String.valueOf(eDate);
	    	}else{
	    		//검색일자가 10일 이하일 경우
	    		endDate = String.valueOf(year)+String.valueOf(month)+"0"+String.valueOf(eDate);
	    	}
	    }
	    
	    eeDate = endDate + "235959";
	    //현재 수당확정인지 또는 확정취소인지를 쿼리에서 구분해주는 변수
	    String gubunYn = "";
	    try {
	    	
	        if(!requestMap.getString("grcode").equals("")){	
	        	where  = "AND A.GRCODE = " + requestMap.getString("grcode");
	        }
	        if(requestMap.getString("gubun").equals("N")){
	        	
	        	gubunYn = "Y";
	        	
	        	Map<String, Object> params = new HashMap<String, Object>();
	        	
	        	for(int i = 0; requestMap.keySize("sel") > i; i++){
	        		
	        		params.put("sDate", requestMap.getString("sDate"));
	        		params.put("sel", requestMap.getString("sel",i));
	        		params.put("userNo", requestMap.getString("userNo",i));
	        		params.put("eeDate", eeDate);
	        		params.put("endDate", endDate);
	        		params.put("gubunYn", gubunYn);
	        		
	        		//수당내역 확정 메소드
		        	tutorMgrMapper.insertTutorSalaryNcyberPay(params);
		        	//과제물 내역 Y 업데이트 메소드
		        	tutorMgrMapper.updateSalaryCyberNReport(params);
		        	//질의 응답부분 Y 업데이트 메소드
		        	tutorMgrMapper.updateSalaryCyberNSubjQna(params);
	        	}
	        }else{
	        	gubunYn = "N";
	        	
	        	Map<String, Object> params = new HashMap<String, Object>();
	        	
	        	for(int i = 0; requestMap.keySize("sel") > i; i++){
	        		params.put("sDate", requestMap.getString("sDate"));
	        		params.put("sel", requestMap.getString("sel",i));
	        		params.put("gubunYn", gubunYn);
	        		params.put("endDate", endDate);
	        		params.put("eeDate", eeDate);
	        		//수당내역 확정 취소 메소드
		        	tutorMgrMapper.deleteSalaryCyber(params);
		        	
		        	//과제물 내역 N 업데이트 메소드
		        	tutorMgrMapper.updateSalaryCyberNReport(params);
		        	
		        	//질의 응답부분 N 업데이트 메소드
		        	tutorMgrMapper.updateSalaryCyberNSubjQna(params);
	        	}
	        }
	    } catch (SQLException e) {
	        throw new BizException(Message.getKey(e), e);
	    } finally {
	    	returnValue = 1;
	    }
	    return returnValue;        
	}

	/**
	 * 외래강사 수강료관리 원고료 등록 삭제 메소드
	 * 작성일 7월 14일
	 * 작성자 정윤철
	 * @param requestMap
	 * @return selectGoodTutor
	 * @throws SQLException e
	 */
	@Transactional
	public int insertTutorSalaryNcollecPay(DataMap requestMap) throws Exception{

		int returnValue = 0;
	    //날짜관련 데이터	   
	    String eeDate = "";
	    String endDate = "";
 
	    int year = 0;
	    int month = 0;
	    int day = 0;
	    int eDate =0;
	    
	    String where ="";
	    String andWhere  = "";
	    String andStr  = "";
	    if(!requestMap.getString("sDate").equals("")){
		    //월요일을 선택하였을때 해당 달의 마지막 월요일이 30일일경우를 대비하여 만들어놓는다.
		    //30일이 될경우 월에 +1 그리고 만약 또다시 월에서 12개월이 지나갈경우 년도에 +1을 해준다.
		    year = Integer.parseInt(requestMap.getString("sDate").substring(0, 4));
		    month = Integer.parseInt(requestMap.getString("sDate").substring(4, 6));
		    eDate = Integer.parseInt(requestMap.getString("sDate").substring(6, 8))+4;
		    day = DateUtil.monthEndDay(year, month);
	
		    if(eDate > day){
		    	eDate = (eDate-day);
		    	month += 1;
		    	
		    	if(month > 12){
		    		month = month - 12;
		    		year += 1; 
		    	}
		    }
	    }
	    if(month < 10){
	    	if(eDate > 10){
	    		//검색 일자가 10일 이상일 경우
	    		endDate = String.valueOf(year)+"0"+String.valueOf(month)+String.valueOf(eDate);
	    	}else{
	    		//검색일자가 10일 이하일 경우
	    		endDate = String.valueOf(year)+"0"+String.valueOf(month)+"0"+String.valueOf(eDate);
	    	}
	    	
	    }else if(month < 10 && eDate < 10){
	    	endDate = String.valueOf(year)+"0"+String.valueOf(month)+"0"+String.valueOf(eDate);
	    	
	    }else if(month > 10 && eDate < 10){
	    	endDate = String.valueOf(year)+String.valueOf(month)+"0"+String.valueOf(eDate);
	    	
	    }else{
	    	if(eDate > 10){
	    		//검색 일자가 10일 이상일 경우
	    		endDate = String.valueOf(year)+String.valueOf(month)+String.valueOf(eDate);
	    	}else{
	    		//검색일자가 10일 이하일 경우
	    		endDate = String.valueOf(year)+String.valueOf(month)+"0"+String.valueOf(eDate);
	    	}
	    }
	    
	    eeDate = endDate + "235959";
	    
	    
	    //같은날 bigo1이 두개이상일경우 관련 변수들
	    int money = 0;
	    String tempBigo = "";
	    String tempBigo3 = "";
	    int tempBigo2 = 0;
	    String resno = "";
	    String studyDate = "";
	    // 구분이 Y ---> N, N --> Y로 변경
	    String gubun = "";
	    
	    if(requestMap.getString("gubun").equals("Y")){
	    	gubun = "N";
	    }else{
	    	gubun = "Y";
	    }
	    
	    DataMap listMap = null;
	    
	    try {
	    	
	        for(int i=0; i < requestMap.keySize("sel"); i++){//전체 포문
	        	
	        	Map<String, Object> params = new HashMap<String, Object>();
	        	
	        	params.put("gubun", gubun);
	        	params.put("sDate", requestMap.getString("sDate"));
	        	params.put("endDate", endDate);
	        	params.put("sel", requestMap.getString("sel", i));
	        	params.put("grcode", requestMap.getString("grcode"));
	        	
	    	    listMap = tutorMgrMapper.insertSalaryNcollecPayList(params);
	    	    if(listMap == null) listMap = new DataMap();
	    	    listMap.setNullToInitialize(true);
	    	    money = requestMap.getInt("price", i);
	        	if(!resno.equals(listMap.getString("resno")) && !studyDate.equals(listMap.getString("studyDate")) ){
	        		resno = listMap.getString("resno");
	        		studyDate = listMap.getString("studyDate");
		        	for(int j=0; j < listMap.keySize("grcode"); j++){//같은날의 비고가 겹쳐있을경우
			        		//들어오는 데이타는 1 * 1000 의 형식으로 되어있다. 하여 스피릿함수를 사용하여 첫번째 값과 두번째값을 분리한 후 각각에 맞는 값을 넣어준다.
			        		tempBigo = listMap.getString("bifo2").split("[*]")[0];
			        		//0번째 데이터에 +1을 해준다.
			        		tempBigo2 = Integer.parseInt(tempBigo)+1;
			        		//1번째값을 임시 가지고 있는다.
			        		tempBigo3 = listMap.getString("bifo2").split("[*]")[1];
			        		//앞서구해놓은 0번째 1번째 인트형값들을 가져다가 곱셈으로 연산한후 담는다.
			        		money = tempBigo2 * Integer.parseInt(tempBigo3);
				     }
		       	}
	        	
	        	listMap.setString("sel", requestMap.getString("sel", i));
	        	listMap.setString("endDate", endDate);
	        	listMap.setInt("money", money);
	        	listMap.setString("sDate", requestMap.getString("sDate"));
	        	listMap.setString("userNo", requestMap.getString("userNo"));
	        	
		        //등록시작
		        returnValue = tutorMgrMapper.insertTutorSalaryNcollecPay(listMap);
		        
		        returnValue = tutorMgrMapper.updateTutorSalaryTime(params);
		        returnValue = tutorMgrMapper.updateTutorSalaryLecHistory(params);
	        }
	        
	        
	        for(int i=0; i < requestMap.keySize("chk2"); i++){//강제지정 있을경우 포문
	        	
	        	Map<String, Object> params = new HashMap<String, Object>();
	        	
	        	params.put("sDate", requestMap.getString("sDate"));
	        	params.put("endDate", endDate);
	        	params.put("chk2", requestMap.getString("chk2",i));
	        	
	    	    listMap = tutorMgrMapper.insertSalaryNcollecPayList(params);
	    	    
	    	    if(listMap == null) listMap = new DataMap();
	    	    listMap.setNullToInitialize(true);
	    	    
	    	    
	        	if(!resno.equals(listMap.get("resno")) && !studyDate.equals(listMap.get("studyDate")) ){
	        		resno = listMap.getString("resno");
	        		studyDate = listMap.getString("studyDate");
		        	for(int j=0; j < listMap.keySize("grcode"); j++){//같은날의 비고가 겹쳐있을경우
			        		//들어오는 데이타는 1 * 1000 의 형식으로 되어있다. 하여 스피릿함수를 사용하여 첫번째 값과 두번째값을 분리한 후 각각에 맞는 값을 넣어준다.
			        		tempBigo = listMap.getString("bifo2").split("[*]")[0];
			        		//0번째 데이터에 +1을 해준다.
			        		tempBigo2 = Integer.parseInt(tempBigo)+1;
			        		//1번째값을 임시 가지고 있는다.
			        		tempBigo3 = listMap.getString("bifo2").split("[*]")[1];
			        		//앞서구해놓은 0번째 1번째 인트형값들을 가져다가 곱셈으로 연산한후 담는다.
			        		money = tempBigo2 * Integer.parseInt(tempBigo3);
				     }
		       	}
		        
		        //강제지정 값을 찾는 로직
		        for(int j= 0; j < requestMap.keySize("chk2"); j++){
		        	//같은 번호가 있으면서 값이 다를 경우 변경된 값을 넣는다.
		        	if(listMap.getString("userno").equals(requestMap.getString("chk2", j))){
		        		if(listMap.getString("totalmoney").equals(requestMap.getString("price", j))){
		        			money = requestMap.getInt("price", j);
		        		}
		        	}
	        	}
		        
		        listMap.setString("gubun", gubun);
		        listMap.setString("sDate", requestMap.getString("sDate"));
		        listMap.setString("endDate", endDate);
		        listMap.setString("sel", requestMap.getString("chk2", i));
		        listMap.setInt("money", money);
		        listMap.setString("userNo", requestMap.getString("userNo"));
		        
		        //등록시작
		        returnValue = tutorMgrMapper.insertTutorSalaryNcollecPay(listMap);
		        
		        returnValue = tutorMgrMapper.updateTutorSalaryTime(listMap);
		        returnValue = tutorMgrMapper.updateTutorSalaryLecHistory(listMap);
	        }
	        
	    } catch (SQLException e) {
	        throw new BizException(Message.getKey(e), e);
	    } finally {
	    	returnValue = 1;
	    }
	    return returnValue;        
	}

	/**
	 * 외래강사 원고료관리 확정
	 * 작성일 7월 14일
	 * 작성자 정윤철
	 * @param requestMap
	 * @return selectGoodTutor
	 * @throws SQLException e
	 */
	@Transactional
	public int insertCopyPay(DataMap requestMap) throws Exception{
			
	    int returnValue = 0;
	    String where  = "";
	    String andWhere = "";
	    //날짜형식  YYYYMMDDHH24SS
	    String eeDate = "";
	    String endDate = "";

	    int year = 0;
	    int month = 0;
	    int day = 0;
	    int eDate =0;
	    
	    if(!requestMap.getString("sDate").equals("")){
		    //월요일을 선택하였을때 해당 달의 마지막 월요일이 30일일경우를 대비하여 만들어놓는다.
		    //30일이 될경우 월에 +1 그리고 만약 또다시 월에서 12개월이 지나갈경우 년도에 +1을 해준다.
		    year = Integer.parseInt(requestMap.getString("sDate").substring(0, 4));
		    month = Integer.parseInt(requestMap.getString("sDate").substring(4, 6));
		    eDate = Integer.parseInt(requestMap.getString("sDate").substring(6, 8))+4;
		    day = DateUtil.monthEndDay(year, month);
	
		    if(eDate > day){
		    	eDate = (eDate-day);
		    	month += 1;
		    	
		    	if(month > 12){
		    		month = month - 12;
		    		year += 1; 
		    	}
		    }
	    }
	    if(month < 10){
	    	if(eDate > 10){
	    		//검색 일자가 10일 이상일 경우
	    		endDate = String.valueOf(year)+"0"+String.valueOf(month)+String.valueOf(eDate);
	    	}else{
	    		//검색일자가 10일 이하일 경우
	    		endDate = String.valueOf(year)+"0"+String.valueOf(month)+"0"+String.valueOf(eDate);
	    	}
	    	
	    }else if(month < 10 && eDate < 10){
	    	endDate = String.valueOf(year)+"0"+String.valueOf(month)+"0"+String.valueOf(eDate);
	    	
	    }else if(month > 10 && eDate < 10){
	    	endDate = String.valueOf(year)+String.valueOf(month)+"0"+String.valueOf(eDate);
	    	
	    }else{
	    	if(eDate > 10){
	    		//검색 일자가 10일 이상일 경우
	    		endDate = String.valueOf(year)+String.valueOf(month)+String.valueOf(eDate);
	    	}else{
	    		//검색일자가 10일 이하일 경우
	    		endDate = String.valueOf(year)+String.valueOf(month)+"0"+String.valueOf(eDate);
	    	}
	    }
	    //현재 수당확정인지 또는 확정취소인지를 쿼리에서 구분해주는 변수
	    String gubunYn = "";
	    
	    try {
	    	
	        if(!requestMap.getString("grcode").equals("")){	
	        	where  = "AND A.GRCODE = " + requestMap.getString("grcode"); 
	        }
	        if(requestMap.getString("gubun").equals("N")){
	        	
	        	gubunYn = "Y";
	        	for(int i = 0; requestMap.keySize("sel") > i; i++){
	        		
	        		Map<String, Object> params = new HashMap<String, Object>();
	        		
	        		params.put("sDate", requestMap.getString("sDate"));
	        		params.put("endDate", endDate);
	        		params.put("gubun", gubunYn);
	        		params.put("money", requestMap.getString("money", i));
	        		params.put("userNo", requestMap.getString("userNo", i));
	        		params.put("sel", requestMap.getString("sel", i));
	        		
	        		//수당내역 확정 메소드
		        	returnValue = tutorMgrMapper.insertCopyPay(params);

		        	//원고 제출 부분 SALARY_YN 을 Y로 수정
		        	tutorMgrMapper.updateSalaryCopyYn(params);

	        	}
	        	
	        }else{
	        	gubunYn = "N";
	        	for(int i = 0; requestMap.keySize("sel") > i; i++){
	        		
	        		Map<String, Object> params = new HashMap<String, Object>();
	        		
	        		params.put("sDate", requestMap.getString("sDate"));
	        		params.put("sel", requestMap.getString("sel",i));
	        		params.put("gubunYn", gubunYn);
	        		params.put("endDate", endDate);
	        		params.put("eeDate", eeDate);
	        		
	        		//수당내역 확정 취소 메소드
		        	tutorMgrMapper.deleteSalaryCyber(params);
		        	
		        	//원고 제출 부분 SALARY_YN 을 N로 수정
		        	tutorMgrMapper.updateSalaryCopyYn(params);
	        	}
	        }
	        
	    } catch (SQLException e) {
	        throw new BizException(Message.getKey(e), e);
	    } finally {
	    	returnValue = 1;
	    }
	    return returnValue;        
	}
	
	/**
	 * 외래강사 원고료관리 확정
	 * 작성일 7월 14일
	 * 작성자 정윤철
	 * @param requestMap
	 * @return selectGoodTutor
	 * @throws SQLException e
	 */
	@Transactional
	public int insertExam(DataMap requestMap) throws Exception{
			
	    int returnValue = 0;
	    String where  = "";
	    String andWhere = "";
	    //날짜형식  YYYYMMDDHH24SS
	    String eeDate = "";
	    String endDate = "";

	    int year = 0;
	    int month = 0;
	    int day = 0;
	    int eDate =0;
	    
	    if(!requestMap.getString("sDate").equals("")){
		    //월요일을 선택하였을때 해당 달의 마지막 월요일이 30일일경우를 대비하여 만들어놓는다.
		    //30일이 될경우 월에 +1 그리고 만약 또다시 월에서 12개월이 지나갈경우 년도에 +1을 해준다.
		    year = Integer.parseInt(requestMap.getString("sDate").substring(0, 4));
		    month = Integer.parseInt(requestMap.getString("sDate").substring(4, 6));
		    eDate = Integer.parseInt(requestMap.getString("sDate").substring(6, 8))+4;
		    day = DateUtil.monthEndDay(year, month);
	
		    if(eDate > day){
		    	eDate = (eDate-day);
		    	month += 1;
		    	
		    	if(month > 12){
		    		month = month - 12;
		    		year += 1; 
		    	}
		    }
	    }
	    if(month < 10){
	    	if(eDate > 10){
	    		//검색 일자가 10일 이상일 경우
	    		endDate = String.valueOf(year)+"0"+String.valueOf(month)+String.valueOf(eDate);
	    	}else{
	    		//검색일자가 10일 이하일 경우
	    		endDate = String.valueOf(year)+"0"+String.valueOf(month)+"0"+String.valueOf(eDate);
	    	}
	    	
	    }else if(month < 10 && eDate < 10){
	    	endDate = String.valueOf(year)+"0"+String.valueOf(month)+"0"+String.valueOf(eDate);
	    	
	    }else if(month > 10 && eDate < 10){
	    	endDate = String.valueOf(year)+String.valueOf(month)+"0"+String.valueOf(eDate);
	    	
	    }else{
	    	if(eDate > 10){
	    		//검색 일자가 10일 이상일 경우
	    		endDate = String.valueOf(year)+String.valueOf(month)+String.valueOf(eDate);
	    	}else{
	    		//검색일자가 10일 이하일 경우
	    		endDate = String.valueOf(year)+String.valueOf(month)+"0"+String.valueOf(eDate);
	    	}
	    }
	    eeDate =endDate+"235959"; 
	    //현재 수당확정인지 또는 확정취소인지를 쿼리에서 구분해주는 변수
	    String gubunYn = "";
	    
	    try {
	    	
	        
	        if(!requestMap.getString("grcode").equals("")){	
	        	where  = "AND A.GRCODE = " + requestMap.getString("grcode"); 
	        }
	        if(requestMap.getString("gubun").equals("N")){
	        	
	        	gubunYn = "Y";
	        	for(int i = 0; requestMap.keySize("sel") > i; i++){
	        		
	        		Map<String, Object> params = new HashMap<String, Object>();
	        		
	        		params.put("sDate", requestMap.getString("sDate"));
	        		params.put("endDate", endDate);
	        		params.put("eeDate", eeDate);
	        		params.put("sel", requestMap.getString("sel",i));
	        		params.put("userNo", requestMap.getString("userNo"));
	        		params.put("gubun", gubunYn);
	        		
	        		//수당내역 확정 메소드
		        	returnValue = tutorMgrMapper.insertExam(params);
		        	
		        	//원고 제출 부분 SALARY_YN 을 Y로 수정
		        	tutorMgrMapper.updateSalaryYnExam(params);
	        	}
	        	
	        }else{
	        	gubunYn = "N";
	        	for(int i = 0; requestMap.keySize("sel") > i; i++){
	        		
	        		Map<String, Object> params = new HashMap<String, Object>();
	        		
	        		params.put("sDate", requestMap.getString("sDate"));
	        		params.put("endDate", endDate);
	        		params.put("eeDate", eeDate);
	        		params.put("gubun",gubunYn);
	        		params.put("sel", requestMap.getString("sel",i));
	        		
	        		//수당내역 확정 취소 메소드
		        	tutorMgrMapper.deleteExam(params);
		        	
		        	//원고 제출 부분 SALARY_YN 을 Y로 수정
		        	tutorMgrMapper.updateSalaryYnExam(params);
	        	}
	        }
	    } catch (SQLException e) {
	        throw new BizException(Message.getKey(e), e);
	    } finally {
        	returnValue = 1;
	    }
	    return returnValue;        
	}
	
	/**
	 * 사이버강사수당관리 과제물 출제수당 등록, 수정
	 * 작성일 7월 19일
	 * 작성자 정윤철
	 * @param requestMap
	 * @return selectGoodTutor
	 * @throws SQLException e
	 */
	@Transactional
	public int tutorSubjectExec(DataMap requestMap) throws Exception{
			
	    int returnValue = 0;
	    try {
	    	
	        returnValue = tutorMgrMapper.selectTutorSubjectCountRow();
	        
	        if(returnValue == 0){
	        	tutorMgrMapper.insertTutorSubject(requestMap);
	        
	        }else{
	        	tutorMgrMapper.updateTutorSubject(requestMap);

	        }
	        returnValue = tutorMgrMapper.selectTutorQuestionCountRow();
	        
	        if(returnValue == 0){
	        	tutorMgrMapper.insertTutorQuestion(requestMap);
	        
	        }else{
	        	tutorMgrMapper.updateTutorQuestion(requestMap);

	        }	        
	        
	    } catch (SQLException e) {
	        throw new BizException(Message.getKey(e), e);
	    } finally {
	    }
	    return returnValue;        
	}
	
	/**
	 * 사이버강사수당관리 과제물 기본수당 , 초과수당 등록, 수정
	 * 작성일 7월 19일
	 * 작성자 정윤철
	 * @param requestMap
	 * @return selectGoodTutor
	 * @throws SQLException e
	 */
	@Transactional
	public int insertAllowance(DataMap requestMap) throws Exception{
			
	    int returnValue = 0;
	    try {
	    	
	        if(requestMap.keySize("tlevel") > 0){
	        	
	        	Map<String, Object> params = new HashMap<String, Object>();
	        	
		        for(int i=0; requestMap.keySize("tlevel")> i; i++){
		        	
		        	params.put("cDefaultAmt", requestMap.getString("cDefaultAmt", i));
		        	params.put("cOverAmt", requestMap.getString("cOverAmt", i));
		        	params.put("tlevel", requestMap.getString("tlevel", i));
		        	
		        	tutorMgrMapper.updateTutorAllowance(params);
		        }
	        }
	        
	    } catch (SQLException e) {
	        throw new BizException(Message.getKey(e), e);
	    } finally {
	    }
	    return returnValue;        
	}
	
	/**
	 * 사이버강사수당관리 원고료 등록, 삭제
	 * 작성일 7월 19일
	 * 작성자 정윤철
	 * @param requestMap
	 * @return selectGoodTutor
	 * @throws SQLException e
	 */
	public int execCopyPay(DataMap requestMap) throws Exception{
			
	    int returnValue = 0;
	    try {
	    	
	        if(requestMap.getString("subMode").equals("insert")){
	        	tutorMgrMapper.insertCopyPayPOP(requestMap);
	        	
	        }else if(requestMap.getString("subMode").equals("delete")){
	        	tutorMgrMapper.deleteCopyPayPOP(requestMap.getString("no"));
	        	
	        }
	        
	        
	    } catch (SQLException e) {
	        throw new BizException(Message.getKey(e), e);
	    } finally {
	    }
	    return returnValue;        
	}
	
	/**
	 * 사이버강사수당관리 출제료 등록, 삭제
	 * 작성일 7월 19일
	 * 작성자 정윤철
	 * @param requestMap
	 * @return selectGoodTutor
	 * @throws SQLException e
	 */
	@Transactional
	public int execSalaryExamPop(DataMap requestMap) throws Exception{
			
	    int returnValue = 0;
	    try {
	    	
	        returnValue = tutorMgrMapper.selectSalaryExamPopCountPopRow();
	        
	        if(returnValue <= 0){
	        	tutorMgrMapper.insertSalaryExamPop(requestMap);
	        	
	        }else if(returnValue > 0){
	        	tutorMgrMapper.updateSalaryExamPop(requestMap);
	        	
	        }
	        
	    } catch (SQLException e) {
	        throw new BizException(Message.getKey(e), e);
	    } finally {
	    }
	    return returnValue;        
	}

	/**
	 * 사이버 강사, 집합강사 기본팝업 리스트
	 * 작성일 7월 14일
	 * 작성자 정윤철
	 * @param requestMap
	 * @return selectGoodTutor
	 * @throws SQLException e
	 */
	public DataMap selectTutorSalaryCopyPayRow(DataMap requestMap) throws Exception{
			
		DataMap resultMap = null;
	    String part = "";
	    try {
	    	
	    	requestMap.setNullToInitialize(true);
	    	
	        if(requestMap.getString("mode").equals("salaryCopyPayPop")){
	        	part = "W";
	        	
	        }else{
	        	part = "E";
	        	
	        }
	        	
	        resultMap = tutorMgrMapper.selectTutorSalaryCopyPayRow(part);
	        
	        resultMap.setNullToInitialize(true);
	        
	        if(requestMap.getString("mode").equals("salaryExamPop") && resultMap.getString("amt").equals("")){	
	        	resultMap.setString("amt", "1");
	        }
	        
	        
	    } catch (SQLException e) {
	        throw new BizException(Message.getKey(e), e);
	    } finally {
	    }
	    return resultMap;        
	}
	
	// ---------------------------------------------------------------------------------------------------------
	
	
	
	
	/**
	 * 강사검색 팝업 (이름, 주민번호로 검색)
	 * @param sqlWhere
	 * @return
	 * @throws Exception
	 */
	public DataMap selectSearchTutorPop(DataMap requestMap) throws Exception{
		
		DataMap resultMap = null;
        
        try {
        	
            resultMap = tutorMgrMapper.selectSearchTutorPop( requestMap );
                                    
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return resultMap;        
	}
	
	/**
	 * 주민등록번호 중복 체크
	 * @param resno
	 * @return
	 * @throws Exception
	 */
	public DataMap checkMemberDamoByResno(String resno) throws Exception{
		
		DataMap resultMap = null;
        
        try {
            
            resultMap = tutorMgrMapper.checkMemberDamoByResno( resno );
                                    
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return resultMap;        
	}
	
	/**
	 * 유저ID 중복 체크
	 * @param userId
	 * @return
	 * @throws Exception
	 */
	public DataMap checkMemberDamoByUserId(String userId) throws Exception{
		
        DataMap resultMap = null;
        
        try {
        	
            resultMap = tutorMgrMapper.checkMemberDamoByUserId( userId );
                                    
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return resultMap;        
	}
	
	
	/**
	 * 과목 검색 (강사등록 시 사용함)
	 * @param subjNm
	 * @return
	 * @throws Exception
	 */
	public DataMap selectSubjCode(String subjNm) throws Exception{
		
		DataMap resultMap = null;
        
        try {
        	
            resultMap = tutorMgrMapper.selectSubjCode(subjNm);
                                    
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return resultMap;        
	}
	
	/**
	 * 강사 등록, 수정
	 * @param type
	 * @param userno
	 * @param resno
	 * @param name
	 * @param pwd
	 * @param sex
	 * @param authority
	 * @param homePost1
	 * @param homePost2
	 * @param homeAddr
	 * @param homeTel
	 * @param hp
	 * @param officePost1
	 * @param officePost2
	 * @param officeAddr
	 * @param officeTel
	 * @param email
	 * @param jikwi
	 * @param userId
	 * @param tposition
	 * @param cname
	 * @param birth
	 * @param bankname
	 * @param bankno
	 * @param tlevel
	 * @param gubun
	 * @param fax
	 * @param subj1
	 * @param subj2
	 * @param subj3
	 * @param subj4
	 * @param subj5
	 * @param subj6
	 * @param subj7
	 * @param luserno
	 * @param job
	 * @param gruCode
	 * @param d_ocinfo1
	 * @param d_ocinfo2
	 * @param d_ocinfo3
	 * @param d_ocinfo4
	 * @return
	 * @throws Exception
	 */
	public int saveTutorForm(DataMap requestMap) throws Exception{
		
        int returnValue = 0;
        
        try {
        	
            String type = requestMap.getString("type");
            if(type.equals("1")){
            	
            	DataMap maxMap = tutorMgrMapper.selectMaxByUserNo();
            	requestMap.setString("userno", maxMap.get("userno").toString());
                        
	            tutorMgrMapper.insertMemberDamo(requestMap);
	            
	            tutorMgrMapper.insertTutorDamo(requestMap);	            
            }
            
            if(type.equals("2")){
            	
            	tutorMgrMapper.updateMemberDamo(requestMap);
            	
            	tutorMgrMapper.insertTutorDamo(requestMap);            	
            }
            
         
            if(type.equals("3")){
            	
            	tutorMgrMapper.updateMemberDamo(requestMap);
            	
            	tutorMgrMapper.updateTutorDamo(requestMap);
            }
            
            
            if(!type.equals("3")){            	
            	// 강사 권한 입력            	
            	DataMap dupMap = tutorMgrMapper.selectMangerDupCnt(requestMap.getString("userno"));
            	if( "0".equals(dupMap.get("dupcnt").toString()) ){
            		tutorMgrMapper.insertManger(requestMap);
            	}            	       
            }
            
            
            // 학력, 전공분야, 경력사항, 저서 및 주요논문
            StringTokenizer stOcinfo1 = new StringTokenizer( requestMap.getString("d_ocinfo1"), "|#|" );
            StringTokenizer stOcinfo2 = new StringTokenizer( requestMap.getString("d_ocinfo2"), "|#|" );
            StringTokenizer stOcinfo3 = new StringTokenizer( requestMap.getString("d_ocinfo3"), "|#|" );
            StringTokenizer stOcinfo4 = new StringTokenizer( requestMap.getString("d_ocinfo4"), "|#|" );
            
            int ocinfoCount1 = stOcinfo1.countTokens();
            int ocinfoCount2 = stOcinfo2.countTokens();
            int ocinfoCount3 = stOcinfo3.countTokens();
            int ocinfoCount4 = stOcinfo4.countTokens();
            String tmpOcinfo = "";

            tutorMgrMapper.deleteTutorHistory(requestMap.getString("userno"));
            
            Map<String, Object> params = new HashMap<String, Object>();
            
            params.put("userno", requestMap.getString("userno"));
            params.put("luserno", requestMap.getString("luserno"));
            
            for(int i=0; i < ocinfoCount1; i++){
            	tmpOcinfo = stOcinfo1.nextToken();
            	params.put("ocinfo", tmpOcinfo);
            	params.put("ocgubun", "1");
            	tutorMgrMapper.insertTutorHistory(params);
            }       
            for(int i=0; i < ocinfoCount2; i++){
            	tmpOcinfo = stOcinfo2.nextToken();
            	params.put("ocinfo", tmpOcinfo);
            	params.put("ocgubun", "2");
            	tutorMgrMapper.insertTutorHistory(params);
            }
            for(int i=0; i < ocinfoCount3; i++){
            	tmpOcinfo = stOcinfo3.nextToken();
            	params.put("ocinfo", tmpOcinfo);
            	params.put("ocgubun", "3");
            	tutorMgrMapper.insertTutorHistory(params);
            }
            for(int i=0; i < ocinfoCount4; i++){
            	tmpOcinfo = stOcinfo4.nextToken();
            	params.put("ocinfo", tmpOcinfo);
            	params.put("ocgubun", "4");
            	tutorMgrMapper.insertTutorHistory(params);
            }
            
            returnValue = 1;
                                    
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return returnValue;        
	}
	
	/**
	 * 강사별수당내역
	 * @param requestMap
	 * @return selectTutorSalaryList
	 * @throws Exception
	 */
	public DataMap selectTutorSalaryList(DataMap requestMap) throws Exception{
		
		DataMap resultMap = null;
        try {
        	
            resultMap = tutorMgrMapper.selectTutorSalaryList(requestMap);
                                    
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return resultMap;        
	}
	
	/**
	 * 강사별 레벨 리스트 
	 * @param requestMap
	 * @return selectTutorSalaryList
	 * @throws Exception
	 */
	public DataMap selectTutorLevelList(DataMap requestMap) throws Exception{
		
		DataMap resultMap = null;
        
        try {
        	
            resultMap = tutorMgrMapper.selectTutorLevelList();
                                    
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return resultMap;        
	}

	
	/**
	 * 외래강사관리 등급별수당지급내역   
	 * 작성일 7월 21일
	 * 작성자 정윤철
	 * @param requestMap
	 * @return selectTutorSalaryList
	 * @throws Exception
	 */
	public DataMap selectGreadeResultList(DataMap requestMap) throws Exception{
		
		DataMap resultMap = null;
        
        try {
        	
            resultMap = tutorMgrMapper.selectGreadeResultList(requestMap);
                                    
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return resultMap;        
	}
	
	/**
	 * 외래강사수당 교육인원카운터 
	 * 작성일 7월 21일
	 * 작성자 정윤철
	 * @param requestMap
	 * @return selectTutorSalaryList
	 * @throws Exception
	 */
	public DataMap selectTseat(DataMap requestMap) throws Exception{

		DataMap resultMap = new DataMap();
        
        int temp = 0;

        requestMap.addString("tlevel", "A");
        requestMap.addString("tlevel", "A1");
        requestMap.addString("tlevel", "B");
        requestMap.addString("tlevel", "C1");
        requestMap.addString("tlevel", "C2");
        requestMap.addString("tlevel", "D");
        requestMap.addString("tlevel", "Z");
        requestMap.addString("tlevel", "Z2");
        
        try {
        	
            if(!requestMap.getString("sDate").equals("") || !requestMap.getString("eDate").equals("")){
            	Map<String, Object> params = new HashMap<String, Object>();
            	params.put("sDate", requestMap.getString("sDate"));
            	params.put("eDate", requestMap.getString("eDate"));
	            
	            for(int i=0; requestMap.keySize("tlevel") > i ; i++){
	            	params.put("tlevel", requestMap.getString("tlevel", i));
	            	temp = tutorMgrMapper.selectTseat(params);
	            	resultMap.addInt("tseat", temp);
	            }
            }
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return resultMap;        
	}
	
	
	/**
	 * 강사원고관리 리스트
	 * 작성일 7월 21일
	 * 작성자 정윤철
	 * @param requestMap
	 * @return selectTutorSalaryList
	 * @throws Exception
	 */
	public DataMap selectTutorPaperList(DataMap requestMap) throws Exception{

		DataMap resultMap = null;
	    String where  = "";
        try {
            
	    	int totalCnt = tutorMgrMapper.selectTutorPaperListCount(requestMap);
        	
        	Map<String, Object> pageInfo = Util.getPageInfo(totalCnt, requestMap);
        	
        	requestMap.set("page", pageInfo);
        	
            resultMap = tutorMgrMapper.selectTutorPaperList(requestMap);
            
            PageNavigation pageNavi = Util.getPageNavigation(pageInfo);
            resultMap.set("PAGE_INFO", pageNavi);
        	
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return resultMap;        
	}
	
	
	
	/** 
	 * 강사원고관리 등록
	 * 작성일 7월 21일
	 * 작성자 정윤철
	 * @param requestMap
	 * @return selectTutorSalaryList
	 * @throws Exception
	 */
	@Transactional
	public int insertTutorPaper(DataMap requestMap) throws Exception{

        int returnValue = 0;
        int count = 0;
        try {
        	
    	    int year = 0;
    	    int month = 0;
    	    int day = 0;
    	    int eDate =0;
    	    
    	    if(!requestMap.getString("pDate").equals("")){
    		    //월요일을 선택하였을때 해당 달의 마지막 월요일이 30일일경우를 대비하여 만들어놓는다.
    		    //30일이 될경우 월에 +1 그리고 만약 또다시 월에서 12개월이 지나갈경우 년도에 +1을 해준다.
    		    year = Integer.parseInt(requestMap.getString("pDate").substring(0, 4));
    		    month = Integer.parseInt(requestMap.getString("pDate").substring(4, 6));
    		    eDate = Integer.parseInt(requestMap.getString("pDate").substring(6, 8))+4;
    		    day = DateUtil.monthEndDay(year, month);
    		    
    		    if(eDate > day){
    		    	eDate = (eDate-day);
    		    	month += 1;
    		    	
    		    	if(month > 12){
    		    		month = month - 12;
    		    		year += 1; 
    		    	}
    		    }
    	    }
    	    
    	    //일수가 10이하일때를 대비하여 만든변수
    	    String tDate = "";
    	    //월수가 10이하일때를 대비하여 만든 변수
    	    String tMonth = "";
    	    
            if(eDate < 10){
            	tDate = "0" + eDate;
            	
            }else{
            	tDate = String.valueOf(eDate);
            	
            }
            
            if(month < 10){
            	tMonth = "0" + month;
            	
            }else{
            	tMonth = String.valueOf(month);
            	
            }
            
    	    requestMap.setString("sDate", requestMap.getString("pDate"));
    	    requestMap.setString("eDate", String.valueOf(year)+ tMonth + tDate);
    	    
            //강사원고관리 교육기관 중복여부 체크
            count = tutorMgrMapper.selectTutorPaperCountRow(requestMap);

            //등록
            if(count ==	0){
            	tutorMgrMapper.insertTutorPaper(requestMap);
            	//등록 가능
            	returnValue = 1;
            	
            }else if(count >= 1){
            	//등록 불가능
            	returnValue = 0;
            }

        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return returnValue;
        
	}
	
	
	/**
	 * 강사원고관리 삭제
	 * 작성일 7월 21일
	 * 작성자 정윤철
	 * @param requestMap
	 * @return selectTutorSalaryList
	 * @throws Exception
	 */
	public int deleteTutorPaper(DataMap requestMap) throws Exception{

        int returnValue = 0;
        try {
        	
            returnValue = tutorMgrMapper.deleteTutorPaper(requestMap);
            
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return returnValue;
        
	}
	
	
	/**
	 * 평가담당자 --> 강사관리 --> 강사원고관리폼 과정명 셀렉박스 리스트 데이터
	 * 작성일 7월 21일
	 * 작성자 정윤철
	 * @param requestMap
	 * @return selectTutorSalaryList
	 * @throws Exception
	 */
	public DataMap seleteTutorPaperGrcodeList() throws Exception{

		DataMap resultMap = null;
        try {
        	
            resultMap = tutorMgrMapper.seleteTutorPaperGrcodeList();

        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return resultMap;        
	}
	
	/**
	 * 평가담당자 --> 강사관리 --> 강사원고관리폼 과정기수 셀렉박스 리스트 데이터
	 * 작성일 7월 21일
	 * 작성자 정윤철
	 * @param requestMap
	 * @return selectTutorSalaryList
	 * @throws Exception
	 */
	public DataMap seleteTutorPaperGrseqList(DataMap requestMap) throws Exception{

		DataMap resultMap = null;
        try {
        	
            resultMap = tutorMgrMapper.seleteTutorPaperGrseqList(requestMap);

        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return resultMap;        
	}
	
	/**
	 * 평가담당자 --> 강사관리 --> 강사원고관리폼 과목코드  셀렉박스 리스트 데이터
	 * 작성일 7월 21일
	 * 작성자 정윤철
	 * @param requestMap
	 * @return selectTutorSalaryList
	 * @throws Exception
	 */
	public DataMap seleteTutorPaperSubjList(DataMap requestMap) throws Exception{

		DataMap resultMap = null;
        try {
        	
            resultMap = tutorMgrMapper.seleteTutorPaperSubjList(requestMap);

        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return resultMap;        
	}
	
	/**
	 * 평가담당자 --> 강사관리 --> 강사원고관리폼 지정강사  셀렉박스 리스트 데이터
	 * 작성일 7월 21일
	 * 작성자 정윤철
	 * @param requestMap
	 * @return selectTutorSalaryList
	 * @throws Exception
	 */
	public DataMap seleteTutorPaperTutorNameList(DataMap requestMap) throws Exception{

		DataMap resultMap = null;
        try {
        	
            resultMap = tutorMgrMapper.seleteTutorPaperTutorNameList(requestMap);

        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return resultMap;        
	}
	
}
