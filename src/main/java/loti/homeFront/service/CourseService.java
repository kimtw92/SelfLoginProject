package loti.homeFront.service;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

import loti.homeFront.mapper.CourseMapper;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

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
public class CourseService extends BaseService {

	private static Map<String, Map<String, Object>> EDUINFO = new HashMap<String, Map<String,Object>>();
	
	@Autowired
	private CourseMapper courseMapper;
	
	public CourseService() {
	
		// EDUINFO 초기화 : 서비스단 메소드 호출시마다 고정된 값의 객체를 계속 생성하는것보다는 미리 Map에 담아두고 꺼내서 쓰는것이 낫다고 생각하여 아래와같이 구현함.
		
		Map<String,Object> eduinfo31 = new HashMap<String, Object>();
		
		eduinfo31.put("grtype", "1");
		eduinfo31.put("grgubun", "G");
		eduinfo31.put("grsubcd", "01");
		
		Map<String,Object> eduinfo32 = new HashMap<String, Object>();
		
		eduinfo32.put("grtype", "7");
		eduinfo32.put("grgubun", "G");
		eduinfo32.put("grsubcd", "");
		
		Map<String,Object> eduinfo33 = new HashMap<String, Object>();
		
		eduinfo33.put("grtype", "2");
		eduinfo33.put("grgubun", "G");
		eduinfo33.put("grsubcd", "02");
		
		Map<String,Object> eduinfo34 = new HashMap<String, Object>();
		
		eduinfo34.put("grtype", "2");
		eduinfo34.put("grgubun", "C");
		eduinfo34.put("grsubcd", "03");
		
		Map<String,Object> eduinfo35 = new HashMap<String, Object>();
		
		eduinfo35.put("grtype", "8");
		eduinfo35.put("grgubun", "G");
		eduinfo35.put("grsubcd", "01");
		
		Map<String,Object> eduinfo37 = new HashMap<String, Object>();
		
		eduinfo37.put("grtype", "4");
		eduinfo37.put("grgubun", "G");
		eduinfo37.put("grsubcd", "");
		
		EDUINFO.put("eduinfo3-1", eduinfo31);
		EDUINFO.put("eduinfo3-2", eduinfo32);
		EDUINFO.put("eduinfo3-3", eduinfo33);
		EDUINFO.put("eduinfo3-4", eduinfo34);
		EDUINFO.put("eduinfo3-5", eduinfo35);
		EDUINFO.put("eduinfo3-7", eduinfo37);
	}
	
	
	// 공통
	public DataMap getCourseData(String eduinfoKey, DataMap dataMap) throws BizException{
		
		DataMap resultMap = null;
        
        try {
        	
        	Map<String, Object> params = EDUINFO.get(eduinfoKey);
        	
           	int totalCnt = courseMapper.getCourseDataCnt(params);
			int currPage = Util.parseInt(dataMap.getString("currPage"),1);
			int rowSize = Util.parseInt(dataMap.getString("rowSize"), 10);
			
			Map<String, Object> pageInfo = Util.getPageInfo(totalCnt, currPage, rowSize);
			
			params.putAll(pageInfo);
			
            resultMap = courseMapper.getCourseData(params);
            
            PageInfo pi = new PageInfo(totalCnt, rowSize, 0, currPage);
            PageNavigation pageNavi = PageFactory.getInstance(Constants.DEFAULT_PAGE_CLASS, pi);
			
            resultMap.set("PAGE_INFO", pageNavi);
                                    
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return resultMap; 
	}
	
	public DataMap getBasicCourseData(DataMap dataMap) throws BizException {
    	return getCourseData("eduinfo3-1", dataMap);
	}

	public DataMap getLongCourseData(DataMap dataMap) throws BizException {
    	return getCourseData("eduinfo3-2", dataMap);		
	}

	public DataMap getProfCourseData(DataMap dataMap) throws BizException {
    	return getCourseData("eduinfo3-3", dataMap);
	}

	public DataMap getCyberCourseData(DataMap dataMap) throws BizException {
    	return getCourseData("eduinfo3-4", dataMap);        	
	}

	public DataMap getEtcCourseData(DataMap dataMap) throws BizException {
    	return getCourseData("eduinfo3-5", dataMap);
	}

	public DataMap getSpecialCourseData(DataMap dataMap) throws BizException {
		return getCourseData("eduinfo3-7", dataMap);
	}


	public DataMap getCourseInfoPopup1(String grcode) throws BizException {
		
		DataMap resultMap = null;
        
        try {
        	
            resultMap = courseMapper.getCourseInfoPopup1(grcode);
                                    
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return resultMap;        
	}


	public DataMap getCourseInfoPopup2(String grcode) throws BizException {
		
		DataMap resultMap = null;
        
        try {
        	
            resultMap = courseMapper.getCourseInfoPopup2(grcode);
                                    
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return resultMap; 
	}


	public Map<String,Object> getCourseInfoSum(String grcode) throws BizException {

		Map<String,Object> resultMap = null;
        
        try {
        	
            resultMap = courseMapper.getCourseInfoSum(grcode);
                                    
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return resultMap; 
	}


	public Map<String,Object> getCourseInfoSubSum(String grcode, String order) throws BizException {

		Map<String,Object> resultMap = null;
        
        try {
        	
        	Map<String, Object> params = new HashMap<String, Object>();
        	
        	params.put("grcode", grcode);
        	params.put("order", order);
        	
            resultMap = courseMapper.getCourseInfoSubSum(params);
                                    
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return resultMap;        
	}


	public DataMap getCourseInfoDetail(String grcode) throws BizException {

		DataMap resultMap = null;
        
        try {
        	
            resultMap = courseMapper.getCourseInfoDetail(grcode);
                                    
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return resultMap;  
	}


	public DataMap searchCourseData(DataMap dataMap, String courseName) throws BizException {

		DataMap resultMap = null;
        
        try {

        	Map<String, Object> params = new HashMap<String, Object>();
        	
        	params.put("courseName", courseName);

           	int totalCnt = courseMapper.searchCourseDataCnt(params);
			int currPage = Util.parseInt(dataMap.getString("currPage"),1);
			int rowSize = Util.parseInt(dataMap.getString("rowSize"), 10);
			
			Map<String, Object> pageInfo = Util.getPageInfo(totalCnt, currPage, rowSize);
			
			params.putAll(pageInfo);
			
			resultMap = courseMapper.searchCourseData(params);
            
            PageInfo pi = new PageInfo(totalCnt, rowSize, 0, currPage);
            PageNavigation pageNavi = PageFactory.getInstance(Constants.DEFAULT_PAGE_CLASS, pi);
			
            resultMap.set("PAGE_INFO", pageNavi);
                                    
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return resultMap;    
	}
	
	

	public DataMap getBasicCourseData(DataMap requestMap, String grtype, String grgubun, String grsubcd) throws Exception{
		
		DataMap resultMap = null;
        
        try {
        	
        	Map<String, Object> params = new HashMap<String, Object>();
        	
        	params.put("grtype", grtype);
        	params.put("grgubun", grgubun);
        	params.put("grsubcd", grsubcd);
        	
        	int totalCnt = courseMapper.selecteducationcourseCount(params);
        	
        	Map<String, Object> pageInfo = Util.getPageInfo(totalCnt, requestMap);
        	
        	params.putAll(pageInfo);
        	
            resultMap = courseMapper.selecteducationcourse(pageInfo);
            
           	PageNavigation pageNavi = Util.getPageNavigation(pageInfo);
           	requestMap.set("PAGE_INFO", pageNavi);
        	
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return resultMap;        
	}

	public DataMap getLongCourseData(DataMap requestMap, String grtype, String grgubun, String grsubcd) throws Exception{
		
		DataMap resultMap = null;
        
        try {
        	
        	Map<String, Object> params = new HashMap<String, Object>();
        	
        	params.put("grtype", grtype);
        	params.put("grgubun", grgubun);
        	params.put("grsubcd", grsubcd);
        	
        	int totalCnt = courseMapper.selecteducationcourseCount(params);
        	
        	Map<String, Object> pageInfo = Util.getPageInfo(totalCnt, requestMap);
        	
        	params.putAll(pageInfo);
        	
            resultMap = courseMapper.selecteducationcourse(pageInfo);
            
           	PageNavigation pageNavi = Util.getPageNavigation(pageInfo);
           	requestMap.set("PAGE_INFO", pageNavi);
        	
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return resultMap;        
	}
	
	public DataMap getProfCourseData(DataMap requestMap, String grtype, String grgubun, String grsubcd) throws Exception{
		
		DataMap resultMap = null;
        
        try {
        	
        	Map<String, Object> params = new HashMap<String, Object>();
        	
        	params.put("grtype", grtype);
        	params.put("grgubun", grgubun);
        	params.put("grsubcd", grsubcd);
        	
        	int totalCnt = courseMapper.selecteducationcourseCount(params);
        	
        	Map<String, Object> pageInfo = Util.getPageInfo(totalCnt, requestMap);
        	
        	params.putAll(pageInfo);
        	
            resultMap = courseMapper.selecteducationcourse(pageInfo);
            
           	PageNavigation pageNavi = Util.getPageNavigation(pageInfo);
           	requestMap.set("PAGE_INFO", pageNavi);
                                    
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return resultMap;        
	}
	
	public DataMap getCyberCourseData(DataMap requestMap, String grtype, String grgubun, String grsubcd) throws Exception{
		
        DataMap resultMap = null;
        
        try {
        	
        	Map<String, Object> params = new HashMap<String, Object>();
        	
        	params.put("grtype", grtype);
        	params.put("grgubun", grgubun);
        	params.put("grsubcd", grsubcd);
        	
        	int totalCnt = courseMapper.selecteducationcourseCount(params);
        	
        	Map<String, Object> pageInfo = Util.getPageInfo(totalCnt, requestMap);
        	
        	params.putAll(pageInfo);
        	
            resultMap = courseMapper.selecteducationcourse(pageInfo);
            
           	PageNavigation pageNavi = Util.getPageNavigation(pageInfo);
           	requestMap.set("PAGE_INFO", pageNavi);
                                    
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return resultMap;        
	}
	
	public DataMap getEtcCourseData(DataMap requestMap, String grtype, String grgubun, String grsubcd) throws Exception{
		
		DataMap resultMap = null;
        
        try {
        	
        	Map<String, Object> params = new HashMap<String, Object>();
        	
        	params.put("grtype", grtype);
        	params.put("grgubun", grgubun);
        	params.put("grsubcd", grsubcd);
        	
        	int totalCnt = courseMapper.selecteducationcourseCount(params);
        	
        	Map<String, Object> pageInfo = Util.getPageInfo(totalCnt, requestMap);
        	
        	params.putAll(pageInfo);
        	
            resultMap = courseMapper.selecteducationcourse(pageInfo);
            
           	PageNavigation pageNavi = Util.getPageNavigation(pageInfo);
           	requestMap.set("PAGE_INFO", pageNavi);
                                    
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return resultMap;        
	}
	
	public DataMap getSpecialCourseData(DataMap requestMap, String grtype, String grgubun, String grsubcd) throws Exception{
		
		DataMap resultMap = null;
        
        try {
        	
        	Map<String, Object> params = new HashMap<String, Object>();
        	
        	params.put("grtype", grtype);
        	params.put("grgubun", grgubun);
        	params.put("grsubcd", grsubcd);
        	
        	int totalCnt = courseMapper.selecteducationcourseCount(params);
        	
        	Map<String, Object> pageInfo = Util.getPageInfo(totalCnt, requestMap);
        	
        	params.putAll(pageInfo);
        	
            resultMap = courseMapper.selecteducationcourse(pageInfo);
            
           	PageNavigation pageNavi = Util.getPageNavigation(pageInfo);
           	requestMap.set("PAGE_INFO", pageNavi);
                                    
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return resultMap;        
	}	
	
	public DataMap getCourseInfoPopup1(String grcode, String grseq) throws Exception{
		
		DataMap resultMap = null;
        
        try {
            
            resultMap = courseMapper.getCourseInfoPopup1(grcode);
                                    
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return resultMap;        
	}	
	
	public DataMap getCourseInfoPopup2(String grcode, String grseq) throws Exception{
		
		DataMap resultMap = null;
        
        try {
            
            resultMap = courseMapper.getCourseInfoPopup2(grcode);
                                    
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return resultMap;        
	}
	
}
