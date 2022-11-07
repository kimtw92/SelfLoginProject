package loti.statisticsMgr.service;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

import loti.statisticsMgr.mapper.StatisticsMgrMapper;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import ut.lib.db.query.XmlQueryParser;
import ut.lib.exception.BizException;
import ut.lib.page.PageNavigation;
import ut.lib.support.DataMap;
import ut.lib.util.Message;
import ut.lib.util.Util;
import common.service.BaseService;

@Service
public class StatisticsMgrService extends BaseService {

	@Autowired
	private StatisticsMgrMapper statisticsMgrMapper;
	
	/**
	 * 상단 tab 메뉴 리스트
	 * @param sessAuth
	 * @return
	 * @throws Exception
	 */
	public DataMap tabMenu(String sessAuth) throws Exception{
		
        
        DataMap resultMap = null;
        
        try {
        	
    		String menuDepth1 = "";
        	
			if(sessAuth.equals("0")){
				menuDepth1 = "5";
			}else if( sessAuth.equals("2") || sessAuth.equals("3") ){
				menuDepth1 = "4";
			}
            
			Map<String, Object> params = new HashMap<String, Object>();
			
			params.put("sessAuth", sessAuth);
			params.put("menuDepth1", menuDepth1);
			
            resultMap = statisticsMgrMapper.tabMenu(params);
                                    
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return resultMap;        
	}

	
	/**
	 * 분야별 통계
	 * @param dept
	 * @param yearMonthFrom
	 * @param yearMonthTo
	 * @return
	 * @throws Exception
	 */
	public DataMap majorList(String dept, String yearMonthFrom, String yearMonthTo) throws Exception{
		
        DataMap resultMap = null;
        
        try {
            
        	Map<String, Object> params = new HashMap<String, Object>();
        	
        	params.put("dept", dept);
        	params.put("yearMonthFrom", yearMonthFrom);
        	params.put("yearMonthTo", yearMonthTo);
        	
            resultMap = statisticsMgrMapper.majorList(params);
                                    
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return resultMap;        
	}
	
	
	/**
	 * 과정별 통계
	 * @param dept
	 * @param yearMonthFrom
	 * @param yearMonthTo
	 * @return
	 * @throws Exception
	 */
	public DataMap courseStats(String dept, String yearMonthFrom, String yearMonthTo) throws Exception{
		
        
        DataMap resultMap = null;
        
        try {
        	
        	Map<String, Object> params = new HashMap<String, Object>();
        	
        	params.put("dept", dept);
        	params.put("yearMonthFrom", yearMonthFrom);
        	params.put("yearMonthTo", yearMonthTo);
            
			if("".equals(dept)) {
				resultMap = statisticsMgrMapper.courseStats(params);
			} else {
				resultMap = statisticsMgrMapper.courseStats2(params);
			}
                                    
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return resultMap;        
	}
	
	/**
	 * 미등록 미수료자 현황
	 * @param searchYear
	 * @return
	 * @throws Exception
	 */
	public DataMap accidentStats(String searchYear) throws Exception{
		
        
        DataMap resultMap = null;
        
        try {

        	resultMap = statisticsMgrMapper.accidentStats(searchYear);
                                    
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return resultMap;        
	}
	
	
	/**
	 * 대상별 교육훈려실적 - 직렬별 col 리스트
	 * @param searchYear
	 * @return
	 * @throws Exception
	 */
	public DataMap selectJikr(String searchYear) throws Exception{
		
        DataMap resultMap = null;
        
        try {
            
            resultMap = statisticsMgrMapper.selectJikr(searchYear);
                                    
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return resultMap;        
	}
	
	/**
	 * 대상별 교육훈려실적 - 직렬별
	 * @param searchYear
	 * @param totalSql
	 * @param sumSql
	 * @param decodeSql
	 * @return
	 * @throws Exception
	 */
	public DataMap targetEduStatsByJikr(String searchYear, StringBuffer totalSql, StringBuffer sumSql, StringBuffer decodeSql, String month) throws Exception{
		
        
        DataMap resultMap = null;
        
        try {
            
        	Map<String, Object> params = new HashMap<String, Object>();
        	
        	params.put("searchYear", searchYear);
        	params.put("totalSql", totalSql.toString());
        	params.put("sumSql", sumSql.toString());
        	params.put("decodeSql", decodeSql.toString());
        	params.put("month", month);
        	
			String searchDay = searchYear;
			if(!"".equals(month)) {
				searchDay = searchDay+month;
			}
			params.put("searchDay", searchDay);
        	
            resultMap = statisticsMgrMapper.targetEduStatsByJikr(params);
                                    
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return resultMap;        
	}
	
	/**
	 * 대상별 교육훈련실적 - 남여별
	 * @param searchYear
	 * @return
	 * @throws Exception
	 */
	public DataMap targetEduStatsByHuman(String searchYear) throws Exception{
		
        
        DataMap resultMap = null;
        
        try {
            
            resultMap = statisticsMgrMapper.targetEduStatsByHuman(searchYear);
                                    
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return resultMap;        
	}

	/**
	 * 교육훈련성적 (평균성적 )
	 * @param searchYear
	 * @param oldYear
	 * @return
	 * @throws Exception
	 */
	public DataMap eduPlanAvgScore(String searchYear, String oldYear) throws Exception{
		
        
        DataMap resultMap = null;
        
        try {
        	
        	Map<String, Object> params = new HashMap<String, Object>();
        	
        	params.put("searchYear", searchYear);
        	params.put("oldYear", oldYear);
            
            resultMap = statisticsMgrMapper.eduPlanAvgScore(params);
                                    
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return resultMap;        
	}
	
	/**
	 * 교육훈련성적 (성적분포 )
	 * @param searchYear
	 * @param oldYear
	 * @return
	 * @throws Exception
	 */
	public DataMap eduPlanRange(String searchYear, String oldYear) throws Exception{
		
        
        DataMap resultMap = null;
        
        try {
            
        	Map<String, Object> params = new HashMap<String, Object>();
        	
        	params.put("searchYear", searchYear);
        	params.put("oldYear", oldYear);
        	
            resultMap = statisticsMgrMapper.eduPlanRange(params);
                                    
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return resultMap;        
	}
	
	/**
	 * 사이버교육 통계
	 * @param yearMonthFrom
	 * @param yearMonthTo
	 * @param subjType
	 * @return
	 * @throws Exception
	 */
	public DataMap cyberCourseStats(String key) throws BizException{
		
        DataMap resultMap = null;
        
        try {
            
        	Map<String, Object> params = new HashMap<String, Object>();
        	System.out.println("###############################################    key   : " + key);
        	params.put("grseq", key);
            resultMap = statisticsMgrMapper.cyberCourseStats(params);
                                    
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return resultMap;        
	}
	
	
	/**
	 * 기관별 베스트 과정
	 * @param yearMonthFrom
	 * @param yearMonthTo
	 * @param subjType
	 * @return
	 * @throws Exception
	 */
	public DataMap departBestStats(String key) throws Exception{
		
        
        DataMap resultMap = null;
        
        try {
        	
            resultMap = statisticsMgrMapper.departBestStats(key);
                                    
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return resultMap;        
	}
	
	
	/**
	 * 연령별 베스트 과정
	 * @param yearMonthFrom
	 * @param yearMonthTo
	 * @param subjType
	 * @return
	 * @throws Exception
	 */
	public DataMap ageBestStats(String key) throws Exception{
		
        DataMap resultMap = null;
        try {
            
            resultMap = statisticsMgrMapper.ageBestStats(key);
                                    
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return resultMap;        
	}
	
	
	/**
	 * 연령별 베스트남성 베스트
	 * @param yearMonthFrom
	 * @param yearMonthTo
	 * @param subjType
	 * @return
	 * @throws Exception
	 */
	public DataMap genderManBestStats(String grseq) throws Exception{
		
        
        DataMap resultMap = null;
        
        try {
            
        	Map<String, Object> params = new HashMap<String, Object>();
            resultMap = statisticsMgrMapper.genderManBestStats(grseq);
                                    
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return resultMap;        
	}
	
	/**
	 * 연령별 베스트남성 베스트
	 * @param yearMonthFrom
	 * @param yearMonthTo
	 * @param subjType
	 * @return
	 * @throws Exception
	 */
	public DataMap genderWomanBestStats(String grseq) throws Exception{
		
        
        DataMap resultMap = null;
        
        try {
            
        	Map<String, Object> params = new HashMap<String, Object>();
        	
            resultMap = statisticsMgrMapper.genderWomanBestStats(grseq);
                                    
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return resultMap;        
	}
	
	
	
	
	public DataMap courseRgister(String rgrayn, String grseq) throws Exception{
		
        
        DataMap resultMap = null;
        
        try {
            
        	Map<String, Object> params = new HashMap<String, Object>();
        	
        	params.put("rgrayn", rgrayn);
        	params.put("grseq", grseq);
        	
            resultMap = statisticsMgrMapper.courseRgister(params);
                                    
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return resultMap;        
	}
	
	public DataMap cyberGrseqInfo(String grseq) throws Exception{
		
        
        DataMap resultMap = null;
        
        try {

        	resultMap = statisticsMgrMapper.cyberGrseqInfo(grseq);
                                    
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return resultMap;        
	}
		
	public DataMap cyberDeptInfo(String grseq) throws Exception{
		
        
        DataMap resultMap = null;
        
        try {
            
            resultMap = statisticsMgrMapper.cyberDeptInfo(grseq);
                                    
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return resultMap;        
	}
	
	public DataMap cyberDeptRgister(String rgrayn, String grseq) throws Exception{
		
        
        DataMap resultMap = null;
        
        try {
            
        	Map<String, Object> params = new HashMap<String, Object>();
        	
        	params.put("rgrayn", rgrayn);
        	params.put("grseq", grseq);
        	
            resultMap = statisticsMgrMapper.cyberDeptRgister(params);
                                    
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return resultMap;        
	}
	
	public DataMap cyberDetailDeptRgister(String rgrayn, String grseq) throws Exception{
		
        
        DataMap resultMap = null;
        
        try {
            
        	Map<String, Object> params = new HashMap<String, Object>();
        	
        	params.put("rgrayn", rgrayn);
        	params.put("grseq", grseq);
        	
            resultMap = statisticsMgrMapper.cyberDetailDeptRgister(params);
                                    
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return resultMap;        
	}
	
	public DataMap courseRgisterTotal(String rgrayn, String grseq) throws Exception{
		
        
        DataMap resultMap = null;
        
        try {
            
        	Map<String, Object> params = new HashMap<String, Object>();
        	
        	params.put("rgrayn", rgrayn);
        	params.put("grseq", grseq);
        	
            resultMap = statisticsMgrMapper.courseRgisterTotal(params);
                                    
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return resultMap;        
	}
	
	public DataMap cyberGrseqInfoTotal(String grseq) throws Exception{
        
        DataMap resultMap = null;
        
        try {
            
            resultMap = statisticsMgrMapper.cyberGrseqInfoTotal(grseq);
                                    
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return resultMap;        
	}
	
	public DataMap cyberDeptInfoTotal(String grseq) throws Exception{
		
        
        DataMap resultMap = null;
        
        try {
            
            resultMap = statisticsMgrMapper.cyberDeptInfoTotal(grseq);
                                    
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return resultMap;        
	}
	
	public DataMap cyberDeptRgisterTotal(String rgrayn, String grseq) throws Exception{
		
        DataMap resultMap = null;
        
        try {
            
        	Map<String, Object> params = new HashMap<String, Object>();
        	
        	params.put("rgrayn", rgrayn);
        	params.put("grseq", grseq);
        	
            resultMap = statisticsMgrMapper.cyberDeptRgisterTotal(params);
                                    
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return resultMap;        
	}
	
	public DataMap cyberDetailDeptRgisterTotal(String rgrayn, String grseq) throws Exception{
		
        
        DataMap resultMap = null;
        
        try {

        	Map<String, Object> params = new HashMap<String, Object>();
        	
        	params.put("rgrayn", rgrayn);
        	params.put("grseq", grseq);
        	
        	resultMap = statisticsMgrMapper.cyberDetailDeptRgisterTotal(params);
                                    
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return resultMap;        
	}
	
	/**
	 * 관련 설문 배제한 문항 리스트
	 * @return
	 * @throws Exception
	 */
	public DataMap pollStatsQuestion() throws Exception{
		
        
        DataMap resultMap = null;
        
        try {
            
            resultMap = statisticsMgrMapper.pollStatsQuestion();
                                    
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return resultMap;        
	}

	/**
	 * 과정별 설문통계
	 * @param sqlWhere
	 * @param searchType
	 * @return
	 * @throws Exception
	 */
	public DataMap pollStats(String sqlWhere, String searchType) throws Exception{
		
        DataMap resultMap = null;
        
        try {
            
			if(searchType.equals("1")){
				resultMap = statisticsMgrMapper.pollStatsByGrseq(sqlWhere);
			}else{
				resultMap = statisticsMgrMapper.pollStatsByGrcode(sqlWhere);
			}
                                    
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return resultMap;        
	}
		/**
	 * 접속통계
	 * @param ptype
	 * @param sDate
	 * @param eDate
	 * @return
	 * @throws Exception
	 */
	public DataMap logStats(String ptype, String sDate, String eDate) throws Exception{
		
        
        DataMap resultMap = null;
        
        try {
            
        	Map<String, Object> params = new HashMap<String, Object>();
        	
        	params.put("ptype", ptype);
        	params.put("sDate", sDate);
        	params.put("eDate", eDate);
        	
			if(ptype.equals("day")){
				resultMap = statisticsMgrMapper.logStatsByDay(params);
			}else{
				resultMap = statisticsMgrMapper.logStatsByMonth(params);
			}
        	
                                    
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return resultMap;        
	}
	
	/**
	 * 가입회원 통계 기간,학력 리스트 
	 * 작성자 : 정윤철
	 * 작성일 : 8월 12일
	 * @param requestMap
	 * 
	 * @return
	 * @throws Exception
	 */
	public DataMap selectMemberStatsList(DataMap requestMap) throws Exception{
		
        
        DataMap resultMap = null;
        int sDate = 0;
        int sYear = 0;
        int eDate = 0;
        int eYear = 0;
        //연산된 루프사이즈
        int tempCount = 0;
        //셀렉트안의 필드
        String field = "";
        //폼안의 셀렉트 필드
        String subField = "";
        //검색 타입
        String searchType = requestMap.getString("searchType");
        //시군에서 만 따로 사용 하는 필드
         String sigunField = "";
         //시군에서 만 따로 사용 하는 필드
         String sigunField2 = "";         
        //필드명에 붙을 카운터
        int fieldCount = 0;
        //루프 사이즈 정의
        int dateSize = 0;
        int tempYearCount = 0;
        //쿼리 알리아스네임 지정
        String aliseName = "";

        try {
            
            if(!requestMap.getString("sDate").equals("")){
            	//검색 하고자 하는 날자의 값들을 각기 맞게 자른다.
            	sDate = Integer.parseInt(requestMap.getString("sDate").substring(4, 6));
            	eDate = Integer.parseInt(requestMap.getString("eDate").substring(4, 6));
            	sYear = Integer.parseInt(requestMap.getString("sDate").substring(0, 4));
            	eYear = Integer.parseInt(requestMap.getString("eDate").substring(0, 4));
            	
            	tempYearCount = eYear - sYear+1;
            	dateSize = 13-sDate;
            	
            	//검색조건에 따른 필드명 선언
            	if(searchType.equals("school")){
            		field = "W.SCHOOL,";
            		sigunField = "P.SCHOOL,";
            		
            	}else if(searchType.equals("dept")){
            		field = "W.DEPT, W.DEPTNM,";
            		subField = "P.DEPT, P.DEPTNM,";
            		
            	}else if(searchType.equals("jik")){
            		field = "W.JIK, W.JIKNM,";
            		subField = "P.JIK, P.JIKNM,";
            		
            	}
            	
            	if(requestMap.getString("searchType").equals("sigun")){
            		aliseName = "Q";
            	}else{
            		aliseName = "P";
            	}
            	
            	//년도가 넘어갈때사용
            	if(tempYearCount > 0){
                	for(int i=0; i < tempYearCount; i++){
               			for(int j =1; j <= dateSize; j++){
                    		fieldCount++;
                    		
                			if(sDate < 10){
                				if(sYear == eYear && sDate == eDate){
                					//쿼리마지막줄 처리
                            		field += "SUM(W.MONTH"+fieldCount+") AS MONTH"+fieldCount;
                            		subField += "DECODE("+aliseName+".INDATE,'"+sYear+"0"+sDate+"', 1,0) AS MONTH"+fieldCount;
                				}else{
                					field += "SUM(W.MONTH"+fieldCount+") AS MONTH"+fieldCount+",";
                					subField += "DECODE("+aliseName+".INDATE,'"+sYear+"0"+sDate+"', 1,0) AS MONTH"+fieldCount+",";
                					
                				}
                				
                				
                			}else{
                				if(sYear == eYear && sDate == eDate){
                					//쿼리마지막줄 처리
                            		field += "SUM(W.MONTH"+fieldCount+") AS MONTH"+fieldCount;
                            		subField += "DECODE("+aliseName+".INDATE,'"+sYear+sDate+"', 1,0) AS MONTH"+fieldCount;
                            		
                				}else{
                					field += "SUM(W.MONTH"+fieldCount+") AS MONTH"+fieldCount+",";
                					subField += "DECODE("+aliseName+".INDATE,'"+sYear+sDate+"', 1,0) AS MONTH"+fieldCount+",";
                				}
                			}
                			
                			//12월이 되었을경우 다음 년도는 1월달로 재조정
                			// 처음 년도의 남은월수만큼 돌구난 후 다음 해부터는 12월 전체를 돌림.
                			if(sDate >=12){
                				sDate = 0;
                			}
                			
                			//모든 조건에 맞게 루프가 돌아왔을경우 멈춤
                			if(sYear == eYear && sDate == eDate){
                				break;
                			}
                			sDate++;
                		}
               			dateSize = 12;
                		sYear++;
                	}            		
            	}
    			
            }else{
            	if(searchType.equals("school")){
            		field = "W.SCHOOL";
            		subField = "P.SCHOOL";
            		
            	}else if(searchType.equals("sigun")){
            		field = "W.SIGUGUN";
            		subField = "P.SIGUGUN";
            		
            		sigunField2 = "W.SIGUGUN";
            		sigunField2 = "'기타' AS SIGUGUN";
            		
            	}else if(searchType.equals("dept")){
            		field = "W.DEPT, W.DEPTNM";
            		subField = "P.DEPT, P.DEPTNM";
            		
            	}else if(searchType.equals("jik")){
            		field = "W.JIK, W.JIKNM";
            		subField = "P.JIK, P.JIKNM";
            		
            	}
            }
            
            requestMap.setInt("fieldCount", (fieldCount+1));
            requestMap.setString("field", field);
            requestMap.setString("subField", subField);
            requestMap.setString("sigunField", sigunField);
            requestMap.setString("sigunField2", sigunField2);
            
            if(searchType.equals("month")){
				resultMap = statisticsMgrMapper.selectPeriodMemberStatsList(requestMap);
			}else if(searchType.equals("dept")){
				resultMap = statisticsMgrMapper.selectDeptMemberStatsList(requestMap);
			}else if(searchType.equals("jik")){
				resultMap = statisticsMgrMapper.selectJiktMemberStatsList(requestMap);
			}else if(searchType.equals("sigun")){
				resultMap = statisticsMgrMapper.selectSigunMemberStatsList(requestMap);
			}else if(searchType.equals("school")){
				resultMap = statisticsMgrMapper.selectScholarshipMemberStatsList(requestMap);
			}else if(searchType.equals("resno")){
				resultMap = statisticsMgrMapper.selectAgeMemberStatsList(requestMap);
			}
                                    
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return resultMap;        
	}
	/**
	 * 가입회원 연령 리스트 
	 * 작성자 : 정윤철
	 * 작성일 : 8월 14일
	 * @param requestMap
	 * 
	 * @return
	 * @throws Exception
	 */
	public DataMap selectMemberAgeStatsList(DataMap requestMap) throws Exception{
		
        DataMap resultMap = null;
        
        int sDate = 0;
        int sYear = 0;
        int eDate = 0;
        int eYear = 0;
        //연산된 루프사이즈
        int tempYearCount = 0;
        //셀렉트안의 필드
        String field = "";
        //폼안의 셀렉트 필드
        String subField = "";
        //필드명에 붙을 카운터
        int fieldCount = 0;
        //루프 사이즈 정의
        int dateSize = 0;
        try {
            
            if(!requestMap.getString("sDate").equals("")){
            	//검색 하고자 하는 날자의 값들을 각기 맞게 자른다.
            	sDate = Integer.parseInt(requestMap.getString("sDate").substring(4, 6));
            	eDate = Integer.parseInt(requestMap.getString("eDate").substring(4, 6));
            	sYear = Integer.parseInt(requestMap.getString("sDate").substring(0, 4));
            	eYear = Integer.parseInt(requestMap.getString("eDate").substring(0, 4));
            	
            	tempYearCount = eYear - sYear+1;
            	dateSize = 13-sDate;
            	
            	//년도가 넘어갈때사용
            	if(tempYearCount > 0){
                	for(int i=0; i < tempYearCount; i++){

                		for(int j =1; j <= dateSize; j++){
                    		System.out.println("i---->    " +i   +"   sYear------------------------->"+sYear+"   dateSize--------->>        "+dateSize);
                    		fieldCount++;
                			if(sDate < 10){
                				if(sYear == eYear && sDate == eDate){
                            		field += "NVL(SUM(D.T"+fieldCount+"), 0) AS T"+fieldCount;
                            		
                				}else{
                					field += "NVL(SUM(D.T"+fieldCount+"), 0) AS T"+fieldCount+",";
                					
                				}
                				
                				subField += "DECODE(C.INDATE,'"+sYear+"0"+sDate+"', 1,0) AS T"+fieldCount+",";
                				
                			}else{
                				if(sYear == eYear && sDate == eDate){
                            		field += "NVL(SUM(D.T"+fieldCount+"), 0) AS T"+fieldCount;
                            		
                				}else{
                					field += "NVL(SUM(D.T"+fieldCount+"), 0) AS T"+fieldCount+",";
                					
                				}
                				
                				subField += "DECODE(C.INDATE,'"+sYear+sDate+"', 1,0) AS T"+fieldCount+",";
                				
                			}
                			
                			//12월이 되었을경우 다음 년도는 1월달로 재조정
                			// 처음 년도의 남은월수만큼 돌구난 후 다음 해부터는 12월 전체를 돌림.
                			if(sDate >=12){
                				sDate = 0;
                			}
                			
                			//모든 조건에 맞게 루프가 돌아왔을경우 멈춤
                			if(sYear == eYear && sDate == eDate){
                				break;
                			}
                			sDate++;
                		}
                		dateSize = 12;
                		sYear++;
                	}            		
            	}
            }			
        			
            requestMap.setInt("fieldCount", (fieldCount+1));
            requestMap.setString("field", field);
            requestMap.setString("subField", subField);
            
            resultMap = statisticsMgrMapper.selectMemberAgeStatsList(requestMap);
        
		} catch (SQLException e) {
	        throw new BizException(Message.getKey(e), e);
	    } finally {
	    }
	    return resultMap;        
	}

	
	/**
	* 강사개인별 활동현황 조회 리스트
	* 작성자 : 정윤철
	* 작성일 : 8월 18일
	 * @param requestMap
	 * 
	 * @return
	 * @throws Exception
	 */
	public DataMap selectTutorWorkStatsList(DataMap requestMap) throws Exception{
		
        
        DataMap resultMap = null;
        String andStr = "";
        String where  = "";
        String where2  = "";
        String whereTitle = "";
        String whereReply = "";
        String whereMail = "";
        //구분에 따라서 써야할 sql불러 오는값을 다르게 했기때문에 아래 제어문에서 해당되는 쿼리의 이름을 넣어준다.
        String sqlFileName = "";
        try {
            
            if(requestMap.getString("gubun").equals("date")){
            	
    	    	int totalCnt = statisticsMgrMapper.selectTutorWorkStatsDateListCount(requestMap);
            	
            	Map<String, Object> pageInfo = Util.getPageInfo(totalCnt, requestMap);
            	
            	requestMap.set("page", pageInfo);
            	
            	resultMap  = statisticsMgrMapper.selectTutorWorkStatsDateList(requestMap);
                
                PageNavigation pageNavi = Util.getPageNavigation(pageInfo);
    		    resultMap.set("PAGE_INFO", pageNavi);
            	
            }else{
	            
    	    	int totalCnt = statisticsMgrMapper.selectTutorWorkStatsMonthListCount(requestMap);
            	
            	Map<String, Object> pageInfo = Util.getPageInfo(totalCnt, requestMap);
            	
            	requestMap.set("page", pageInfo);
            	
            	resultMap  = statisticsMgrMapper.selectTutorWorkStatsMonthList(requestMap);
                
                PageNavigation pageNavi = Util.getPageNavigation(pageInfo);
    		    resultMap.set("PAGE_INFO", pageNavi);
            	
            }
            
		} catch (SQLException e) {
	        throw new BizException(Message.getKey(e), e);
	    } finally {
	    }
	    return resultMap;        
	}
	
	public DataMap selectMobileMonthList(DataMap requestMap) throws Exception{
		
        
        DataMap resultMap = null;
        try {
        	
	    	int totalCnt = statisticsMgrMapper.selectMobileMonthListCount(requestMap);
        	
        	Map<String, Object> pageInfo = Util.getPageInfo(totalCnt, requestMap);
        	
        	requestMap.set("page", pageInfo);
        	
        	resultMap  = statisticsMgrMapper.selectMobileMonthList(requestMap);
            
            PageNavigation pageNavi = Util.getPageNavigation(pageInfo);
		    resultMap.set("PAGE_INFO", pageNavi);
        	
            
		} catch (SQLException e) {
	        throw new BizException(Message.getKey(e), e);
	    } finally {
	    }
	    return resultMap;        
	}
	
	public DataMap selectMobileDayList(DataMap requestMap) throws Exception{
		
        
        DataMap resultMap = null;
        try {

	    	int totalCnt = statisticsMgrMapper.selectMobileDayListCount(requestMap);
        	
        	Map<String, Object> pageInfo = Util.getPageInfo(totalCnt, requestMap);
        	
        	requestMap.set("page", pageInfo);
        	
        	resultMap  = statisticsMgrMapper.selectMobileDayList(requestMap);
            
            PageNavigation pageNavi = Util.getPageNavigation(pageInfo);
		    resultMap.set("PAGE_INFO", pageNavi);
        	
            
		} catch (SQLException e) {
	        throw new BizException(Message.getKey(e), e);
	    } finally {
	    }
	    return resultMap;        
	}	
	
	public Integer mobileMemberCnt() throws Exception{
        
        int count = -1;
        try {
            
            count  = statisticsMgrMapper.mobileMemberCnt();
            
		} catch (SQLException e) {
	        throw new BizException(Message.getKey(e), e);
	    } finally {
	    }
	    return count;        
	}
	
	/**
	 * 최근 수료 처리 차수
	 * @param yearMonthFrom
	 * @param yearMonthTo
	 * @param subjType
	 * @return
	 * @throws Exception
	 */
	public String getMaxGrSeq() throws Exception{		
        
        String result = null;        
        try {
            
        	result = statisticsMgrMapper.getMaxGrSeq();
                                    
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return result;        
	}
	
	/**
	 * 직급  베스트 과정
	 * @param yearMonthFrom
	 * @param yearMonthTo
	 * @param subjType
	 * @return
	 * @throws Exception
	 */
	public DataMap tierBestStats(String key) throws Exception{
        
        DataMap resultMap = null;
        try {
            resultMap = statisticsMgrMapper.tierBestStats(key);
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return resultMap;        
	}
	
	
}
