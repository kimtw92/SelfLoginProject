package loti.courseMgr.service;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

import loti.courseMgr.mapper.TimeTableMapper;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.transaction.interceptor.TransactionAspectSupport;

import ut.lib.exception.BizException;
import ut.lib.login.LoginInfo;
import ut.lib.support.DataMap;
import ut.lib.util.DateUtil;
import ut.lib.util.Message;
import ut.lib.util.StringReplace;
import common.service.BaseService;

@Service("courseMgrTimeTableService")
public class TimeTableService extends BaseService {

	@Autowired
	@Qualifier("courseMgrTimeTableMapper")
	private TimeTableMapper timeTableMapper;
	
	/**
	 * 학습 주차 갯수를 가져오기
	 */
	public int selectWeekCnt(String startDate, String endDate) throws BizException{
		int resultValue = 0;
        
        try {
        	Map<String, Object> paramMap = new HashMap<String, Object>();
        	paramMap.put("startDate", startDate);
        	paramMap.put("endDate", endDate);
        	
        	resultValue = timeTableMapper.selectWeekCnt(paramMap);
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return resultValue;
	}
	
	/**
	 * 총 주차수와 현재주차의 시작일, 현재주차의 종료일을 구하기
	 */
	public DataMap selectStartEndDateByNow(int week, String startDate, String endDate) throws BizException{
		DataMap resultMap = new DataMap();
        
        try {
        	Map<String, Object> paramMap = new HashMap<String, Object>();
        	paramMap.put("week", week);
        	paramMap.put("startDate", startDate);
        	paramMap.put("endDate", endDate);
        	
        	resultMap = timeTableMapper.selectStartEndDateByNow(paramMap);
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return resultMap;
	}
	
	/**
	 * 시간표 관리 갯수.
	 */
	public int selectTimeTableGrseqCnt(String grcode, String grseq) throws BizException{
		int resultValue = 0;
        
        try {
        	Map<String, Object> paramMap = new HashMap<String, Object>();
        	paramMap.put("grcode", grcode);
        	paramMap.put("grseq", grseq);
        	
        	resultValue = timeTableMapper.selectTimeTableGrseqCnt(paramMap);
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return resultValue;  
		
	}
	
	/**
	 * 개설과정 과목 갯수.
	 */
	public int selectSubjSeqCnt(String grcode, String grseq, String subj) throws BizException{
		int resultValue = 0;
        
        try {
        	Map<String, Object> paramMap = new HashMap<String, Object>();
        	paramMap.put("grcode", grcode);
        	paramMap.put("grseq", grseq);
        	paramMap.put("subj", subj);
        	
        	resultValue = timeTableMapper.selectSubjSeqCnt(paramMap);
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return resultValue;  
		
	}
	
	/**
	 * 시간표 리스트
	 */
	public DataMap selectTimeTableList(DataMap requestMap, DataMap grSeqRowMap, LoginInfo loginInfo) throws BizException{
		DataMap resultMap = new DataMap();
		Map<String, Object> paramMap = null;
        
        try {
        	String grcode = requestMap.getString("commGrcode");
    		String grseq = requestMap.getString("commGrseq");
    		
    		//과정 시작 및 종료일
    		String courseSdate = grSeqRowMap.getString("started");
    		String courseEdate = grSeqRowMap.getString("enddate");
    		
    		//현재 주차
            String studyWeek = requestMap.getString("studyWeek");
            
            //선택된 주차가 없을 경우 1주차 셋팅.
    		if (studyWeek.equals("")) {
    			// 오늘날짜와 과정의 시작일과 교육종료일을 비교한다.
    			if (!courseEdate.equals("") 
    					&& DateUtil.getDaysDiff(grSeqRowMap.getString("enddate"), DateUtil.getDateTime()  ) > 0
    					&& !courseSdate.equals("") 
    					&& DateUtil.getDaysDiff(grSeqRowMap.getString("started"), DateUtil.getDateTime()) < 0
    			   ) {
    				//오늘의 주차를 구한다.
    				paramMap = new HashMap<String, Object>();
    	        	paramMap.put("startDate", courseSdate);
    	        	paramMap.put("endDate", DateUtil.getDateTime());
    				studyWeek =  String.valueOf(timeTableMapper.selectWeekCnt(paramMap));
    			} else {
    				studyWeek = "1";
    			}
    		}
    		requestMap.setString("studyWeek", studyWeek);
    		int weekCnt = 0; //전체 주차
    		String weekSdate = ""; //현재주차의 시작일
    		String weekEdate = ""; //현재주차의 종료일
    		
    		int weekSdateNo = 0; //현재주차의 시작일 주(1~7)
    		int weekEdateNo = 0; //현재주차의 종료일 주(1~7)
    		
    		if (courseSdate.length() == 8 
    				&& courseEdate.length() > 0
    				&& courseEdate.length() >= courseSdate.length()
    		   ) { 
    			//총 주차수와 현재주차의 시작일, 현재주차의 종료일을 구한다.
    			paramMap = new HashMap<String, Object>();
	        	paramMap.put("week", Integer.parseInt(studyWeek));
	        	paramMap.put("startDate", courseSdate);
	        	paramMap.put("endDate", courseEdate);
	        	
    			DataMap tmpDateMap = timeTableMapper.selectStartEndDateByNow(paramMap);
    			if (tmpDateMap == null) {
    				tmpDateMap = new DataMap();
    			}
    			tmpDateMap.setNullToInitialize(true);
    			
    			weekCnt = tmpDateMap.getInt("weekCnt"); //주차수
    			weekSdate = tmpDateMap.getString("weekSdate"); //현재주차의 시작일
    			weekEdate = tmpDateMap.getString("weekEdate"); //현재주차의 종료일
    			weekSdateNo = tmpDateMap.getInt("weekSdateNo"); //현재 주차 시작일의 요일 정보 (2,3,4,5,6)
    			weekEdateNo = tmpDateMap.getInt("weekEdateNo"); //현재 주차 종료일의 요일 정보 (2,3,4,5,6)
				
        		//결과 맵에 정보 담기.
        		resultMap.setString("studyWeek", studyWeek); //현재주차.
        		resultMap.setInt("weekCnt", weekCnt);
        		resultMap.setString("weekSdate", weekSdate);
        		resultMap.setString("weekEdate", weekEdate);
        		resultMap.setInt("weekSdateNo", weekSdateNo);
        		resultMap.setInt("weekEdateNo", weekEdateNo);
        		
        		//교시 정보. (세로) START
        		DataMap timeGosiMap = null;
        		String gosiStr = "";
        		
        		if (requestMap.getString("searchKey").equals("MORNING")) {
        			gosiStr = " AND GOSINUM BETWEEN 1 AND 9 ";
        			paramMap = new HashMap<String, Object>();
        			paramMap.put("gosiStr", gosiStr);
        			timeGosiMap = timeTableMapper.selectTimeGosiList(paramMap);
        		} else {
        			paramMap = new HashMap<String, Object>();
        			paramMap.put("gosiStr", "");
        			timeGosiMap = timeTableMapper.selectTimeGosiList(paramMap);
        		}
        		
        		if (timeGosiMap == null) {
        			timeGosiMap = new DataMap();
        		}
        		timeGosiMap.setNullToInitialize(true);
        		resultMap.add("GOSI_MAP", timeGosiMap); //결과 맵에 교시 정보 담기.
        		//교시 정보. (세로) END
        		
        		//요일 정보 (가로) START
    			DataMap timeStudyDate = new DataMap();
        		
        		String nWeekMon = ""; //현재 주차 월요일의 날짜
    			if (weekSdateNo == 2) {
    				nWeekMon = weekSdate;
    			} else {
    				paramMap = new HashMap<String, Object>();
    				paramMap.put("weekSdate", weekSdate);
    				paramMap.put("weekSdateNo", weekSdateNo);
    				nWeekMon = timeTableMapper.selectDualTableByOneCol1(paramMap);
    			}
    			
    			for(int j = 2; j <= 6; j ++) {
    				paramMap = new HashMap<String, Object>();
    				paramMap.put("weekSdate", nWeekMon);
    				paramMap.put("weekSdateNo", j);
    				String tmpDate = timeTableMapper.selectDualTableByOneCol2(paramMap);
    				timeStudyDate.addString("day", tmpDate);
    				timeStudyDate.addString("comaDay", StringReplace.subString(tmpDate, 4, 6) + "." + StringReplace.subString(tmpDate, 6, 8) );
    			}
    			resultMap.add("WEEK_MAP", timeStudyDate); //결과 맵에 교시 정보 담기.
    			//요일 정보 (가로) END
    			
        		//시간표 결과 정보 담기.
    			// 		월요일 부터 금요일 까지 한쿼리에서 가능하지 않아서 (sort key too long) 나누어 정보를 담아 사용
    			// 		 plan1 : 월~수
    			//		 plan2 : 목, 금 
    			paramMap = new HashMap<String, Object>();
				paramMap.put("grcode", grcode);
				paramMap.put("grseq", grseq);
				paramMap.put("weekSdate", weekSdate);
				paramMap.put("weekEdate", weekEdate);
				paramMap.put("gosiStr", gosiStr);
        		DataMap plan1 = timeTableMapper.selectTimeTableByPlan1(paramMap);
        		resultMap.add("TIME1_LIST_DATA", plan1); //결과 맵에 교시 정보 담기.
        		DataMap plan2 = timeTableMapper.selectTimeTableByPlan2(paramMap);
        		resultMap.add("TIME2_LIST_DATA", plan2); //결과 맵에 교시 정보 담기.
    		}
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return resultMap;
	}
	
	/**
	 * 시간표 상세 정보 조회.
	 */
	public DataMap selectTimeTableRow(DataMap requestMap) throws BizException{
		DataMap resultMap = new DataMap();
        
        try {
        	resultMap = timeTableMapper.selectTimeTableRow(requestMap);
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return resultMap;
	}
	
	/**
	 * 시간표의 강사 리스트
	 */
	public DataMap selectTimeTableTuListBySubj(DataMap requestMap) throws BizException{
		DataMap resultMap = new DataMap();
        
        try {
        	resultMap = timeTableMapper.selectTimeTableTuListBySubj(requestMap);
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return resultMap;  
		
	}
	
	/**
	 * 
	 */
	public DataMap selectClassRoomByGrseqRow(String grcode, String grseq) throws BizException{
		DataMap resultMap = new DataMap();
        
        try {
        	Map<String, Object> paramMap = new HashMap<String, Object>();
        	paramMap.put("grcode", grcode);
        	paramMap.put("grseq", grseq);
        	
        	resultMap = timeTableMapper.selectClassRoomByGrseqRow(paramMap);
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return resultMap;
	}
	
	/**
	 * 강사 리스트.
	 */
	public DataMap selectClassTutorListByClassRoom(String grcode, String grseq) throws BizException{
		DataMap resultMap = new DataMap();
        
        try {
        	Map<String, Object> paramMap = new HashMap<String, Object>();
        	paramMap.put("grcode", grcode);
        	paramMap.put("grseq", grseq);
        	
        	resultMap = timeTableMapper.selectClassTutorListByClassRoom(paramMap);
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return resultMap;  
		
	}
	
	/**
	 * 과목검색 리스트.
	 */
	public DataMap selectSubjSeqBySubjSearchList(String grcode, String grseq) throws BizException{
		DataMap resultMap = new DataMap();
        
        try {
        	Map<String, Object> paramMap = new HashMap<String, Object>();
        	paramMap.put("grcode", grcode);
        	paramMap.put("grseq", grseq);
        	
        	resultMap = timeTableMapper.selectSubjSeqBySubjSearchList(paramMap);
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return resultMap;  
		
	}
	
	/**
	 * 시간표 등록
	 */
	public int insertTimeTable(DataMap requestMap, String sessUserno) throws BizException{
		int resultValue = 0;
        
        try {
        	DataMap paramMap = new DataMap();
        	paramMap.setString("grcode", requestMap.getString("grcode"));
        	paramMap.setString("grseq", requestMap.getString("grseq"));
        	paramMap.setString("subj", requestMap.getString("subj"));
        	paramMap.setString("studydate", requestMap.getString("studydate"));
        	paramMap.setInt("studytime", requestMap.getInt("studytime"));
        	paramMap.setString("usegubun", "Y");
        	paramMap.setString("userno", sessUserno);
        	paramMap.setString("classroomNo", requestMap.getString("classroomNo"));
        	
        	resultValue = timeTableMapper.insertTimeTable(paramMap);
                   
            if(resultValue > 0){
            	//강사 등록
            	DataMap tutorMap = new DataMap();
            	tutorMap.setNullToInitialize(true);
            	
            	String[] tutorUserno = requestMap.getString("tuserno").split("[|]");
            	int tutorCnt = tutorUserno.length;
            	for(int i=0; i < tutorCnt; i++) {
            		if (!tutorUserno[i].trim().equals("")) {
                    	tutorMap.setString("grcode", requestMap.getString("grcode"));
                    	tutorMap.setString("grseq", requestMap.getString("grseq"));
                    	tutorMap.setString("subj", requestMap.getString("subj"));
                    	tutorMap.setString("studydate", requestMap.getString("studydate"));
                    	tutorMap.setInt("studytime", requestMap.getInt("studytime"));
                    	tutorMap.setString("salaryYn", "N");
                    	
                    	tutorMap.setString("userno", tutorUserno[i].trim());
                    	
                    	timeTableMapper.insertTimeTableTu(tutorMap);
                    	
                    	tutorMap.clear();
            		}
            	}
            }
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return resultValue;
	}
	
	/**
	 * 시간표 등록여부 체크
	 */
	public int selectTimeTableBySubjChk(String grcode, String grseq, String studyDate, int studyTime, String subj) throws BizException{
		int resultValue = 0;
        
        try {
        	Map<String, Object> paramMap = new HashMap<String, Object>();
        	paramMap.put("grcode", grcode);
        	paramMap.put("grseq", grseq);
        	paramMap.put("studydate", studyDate);
        	paramMap.put("studytime", studyTime);
        	paramMap.put("subj", subj);
        	
        	resultValue = timeTableMapper.selectTimeTableBySubjChk(paramMap);
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return resultValue;
	}
	
	/**
	 * 외부 강사 시간표 등록여부 체크.
	 */
	public int selectOutTimeTableChk(String classroomNo, String studyDate, int studyTime) throws BizException{
		int resultValue = 0;
        
        try {
        	Map<String, Object> paramMap = new HashMap<String, Object>();
        	paramMap.put("classroomNo", classroomNo);
        	paramMap.put("studydate", studyDate);
        	paramMap.put("studytime", studyTime);
        	
        	resultValue = timeTableMapper.selectOutTimeTableChk(paramMap);
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return resultValue;
	}
	
	/**
	 * 시간표 강사 삭제
	 */
	public int deleteTimeTableTuBySubj(String grcode, String grseq, String studyDate, int studyTime, String subj) throws BizException{
		int resultValue = 0;
        
        try {
        	Map<String, Object> paramMap = new HashMap<String, Object>();
        	paramMap.put("grcode", grcode);
        	paramMap.put("grseq", grseq);
        	paramMap.put("studydate", studyDate);
        	paramMap.put("studytime", studyTime);
        	paramMap.put("subj", subj);
        	
        	resultValue = timeTableMapper.deleteTimeTableTuBySubj(paramMap);
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return resultValue;  
	}
	
	/**
	 * 
	 */
	public int updateTimeTable(DataMap requestMap, String sessUserno) throws BizException{
		int resultValue = 0;
		Map<String, Object> paramMap = null;
		
        try {
        	String grcode = requestMap.getString("grcode");
            String grseq = requestMap.getString("grseq");
            String studyDate = requestMap.getString("studydate");
            int studyTime = requestMap.getInt("studytime");
            String subj = requestMap.getString("keySubj");
            
            int tmpInt = 0;
            //수정할 과목이 이미 있는지 확인.
            if(!requestMap.getString("subj").equals(subj)) //같은 과목 수정이면 체크하지 않아도 됨.
            	tmpInt = selectTimeTableBySubjChk(grcode, grseq, studyDate, studyTime, requestMap.getString("subj"));
            
            if(tmpInt > 0)
            	resultValue = -1;
            else{
            	
            	//수정시 강사항목 삭제.
            	paramMap = new HashMap<String, Object>();
            	paramMap.put("grcode", grcode);
            	paramMap.put("grseq", grseq);
            	paramMap.put("studydate", studyDate);
            	paramMap.put("studytime", studyTime);
            	paramMap.put("subj", subj);
            	timeTableMapper.deleteTimeTableTuBySubj(paramMap);
            	
            	//시간표 수정 실행.
            	paramMap = new HashMap<String, Object>();
            	paramMap.put("subj", requestMap.getString("subj"));
            	paramMap.put("classroomNo", requestMap.getString("classroomNo"));
            	paramMap.put("userno", requestMap.getString("sessUserno"));
            	paramMap.put("grcode", requestMap.getString("grcode"));
            	paramMap.put("grseq", requestMap.getString("grseq"));
            	paramMap.put("studydate", requestMap.getString("studydate"));
            	paramMap.put("studytime", requestMap.getString("studytime"));
            	paramMap.put("keySubj", requestMap.getString("keySubj"));
            	timeTableMapper.updateTimeTable(paramMap);
            	
            	//강사 등록
            	DataMap tutorMap = new DataMap();
            	tutorMap.setNullToInitialize(true);
            	
            	String[] tutorUserno = requestMap.getString("tuserno").split("[|]");
            	int tutorCnt = tutorUserno.length;
            	for(int i=0; i < tutorCnt; i++){
            		
            		if(!tutorUserno[i].trim().equals("")){
            			
                    	tutorMap.setString("grcode", grcode);
                    	tutorMap.setString("grseq", grseq);
                    	tutorMap.setString("subj", requestMap.getString("subj"));
                    	tutorMap.setString("studydate", studyDate);
                    	tutorMap.setInt("studytime", studyTime);
                    	tutorMap.setString("salaryYn", "");
                    	
                    	tutorMap.setString("userno", tutorUserno[i]);
                    	
                    	timeTableMapper.insertTimeTableTu(tutorMap);
                    	
                    	tutorMap.clear();
            		}
            	}
            	
            	resultValue ++;
            }
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return resultValue;  
	}
	
	/**
	 * 강사 검색
	 */
	public DataMap selectClassTutorByTimeTableSubjList(String grcode, String grseq, String studyDate, int studyTime, String subj) throws BizException{
		DataMap resultMap = new DataMap();
        
        try {
        	Map<String, Object> paramMap = new HashMap<String, Object>();
        	paramMap.put("grcode", grcode);
        	paramMap.put("grseq", grseq);
        	paramMap.put("studydate", studyDate);
        	paramMap.put("studytime", studyTime);
        	paramMap.put("subj", subj);
        	
        	resultMap = timeTableMapper.selectClassTutorByTimeTableSubjList(paramMap);
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return resultMap;
	}
	
	/**
	 * 
	 */
	public int addTimeTable(DataMap requestMap, String sessUserno) throws BizException{
		int resultValue = 0;
		Map<String, Object> paramMap = null;
        
        try {
        	String grcode = requestMap.getString("grcode");
            String grseq = requestMap.getString("grseq");
            String studyDate = requestMap.getString("studydate");
            int studyTime = -3;
            String subj = requestMap.getString("subj");

            int tmpInt = 0;
            String[] studyTimeArr = requestMap.getString("studytime").split("[|]");
            
            //시간표
        	DataMap timeMap = new DataMap();
        	timeMap.setNullToInitialize(true);
        	
            for(int i=0; i < studyTimeArr.length; i++){
            	
            	//시간표 등록여부 체크
            	studyTime = Integer.parseInt(studyTimeArr[i]);
            	tmpInt = selectTimeTableBySubjChk(grcode, grseq, studyDate, studyTime, subj);
            	
                if(tmpInt > 0){
                	resultValue = -1;
                	TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
                	break;
                }
                
                //외부 강사 시간표의 강의실 사용여부 체크.
                if(!requestMap.getString("classroomNo").equals("")){
                	paramMap = new HashMap<String, Object>();
                	paramMap.put("classroomNo", requestMap.getString("classroomNo"));
                	paramMap.put("studydate", studyDate);
                	paramMap.put("studytime", studyTime);
                    tmpInt = timeTableMapper.selectOutTimeTableChk(paramMap);
                    
                    if(tmpInt > 0){
                    	resultValue = -2;
                    	TransactionAspectSupport.currentTransactionStatus().setRollbackOnly();
                    	break;
                    }
                }

                timeMap.setString("grcode", grcode);
                timeMap.setString("grseq", grseq);
                timeMap.setString("subj", subj);
                timeMap.setString("studydate", studyDate);
                timeMap.setInt("studytime", studyTime);
                timeMap.setString("classroomNo", requestMap.getString("classroomNo"));
                timeMap.setString("userno", sessUserno);
                //등록
                timeTableMapper.insertTimeTable(timeMap);
            	
            	//강사 등록 [s]
            	DataMap tutorMap = new DataMap();
            	tutorMap.setNullToInitialize(true);
            	
            	String[] tutorUserno = requestMap.getString("tuserno").split("[|]");
            	int tutorCnt = tutorUserno.length;
            	for(int k=0; k < tutorCnt; k++){
            		
            		if(!tutorUserno[k].trim().equals("")){
            			
                    	tutorMap.setString("grcode", grcode);
                    	tutorMap.setString("grseq", grseq);
                    	tutorMap.setString("subj", requestMap.getString("subj"));
                    	tutorMap.setString("studydate", studyDate);
                    	tutorMap.setInt("studytime", studyTime);
                    	tutorMap.setString("salaryYn", "");
                    	
                    	tutorMap.setString("userno", tutorUserno[k]);
                    	
                    	timeTableMapper.insertTimeTableTu(tutorMap);
                    	
                    	tutorMap.clear();
            		}
            	}
            	//강사 등록 [e]
            	resultValue++;
            }
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return resultValue;  
	}
	
	/**
	 * 시간표 일자 초기화.
	 */
	public int deleteTimeTableDay(String grcode, String grseq, String studyDate) throws BizException{
		int resultValue = 0;
        
        try {
        	Map<String, Object> paramMap = new HashMap<String, Object>();
        	paramMap.put("grcode", grcode);
        	paramMap.put("grseq", grseq);
        	paramMap.put("studydate", studyDate);
        	//해당일 시간표 강사지정정보 삭제 
        	timeTableMapper.deleteTimeTableTuByDay(paramMap);
            
            //해당일 시간표정보 삭제 
        	timeTableMapper.deleteTimeTableByDay(paramMap);
                       
            resultValue++;
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return resultValue;  
	}
	
	/**
	 * 기수의 시간표 초기화.
	 */
	public int deleteTimeTableGrseq(String grcode, String grseq) throws BizException{
		int resultValue = 0;
        
        try {
        	Map<String, Object> paramMap = new HashMap<String, Object>();
        	paramMap.put("grcode", grcode);
        	paramMap.put("grseq", grseq);
        	
        	//시간표 강사지정정보 삭제 
        	timeTableMapper.deleteTimeTableTuByGrseq(paramMap);
            
            //시간표정보 삭제 
        	timeTableMapper.deleteTimeTableByGrseq(paramMap);
                       
            resultValue++;
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return resultValue;  
	}
	
	/**
	 * 시간표 내용으로 개설과정의 강의시간 수정
	 */
	public int updateSubjSeqByLessonTime(String grcode, String grseq) throws BizException{
		int resultValue = 0;
        
        try {
        	Map<String, Object> paramMap = new HashMap<String, Object>();
        	paramMap.put("grcode", grcode);
        	paramMap.put("grseq", grseq);
        	
        	resultValue = timeTableMapper.updateSubjSeqByLessonTime(paramMap);
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return resultValue;  
	}
	
	/**
	 * 과목분류별 건수를 미리 조회한다. (중식제외)
	 */
	public DataMap selectTimeTableBySubjGubunCount(String grcode, String grseq) throws BizException{
		DataMap resultMap = new DataMap();
        
        try {
        	Map<String, Object> paramMap = new HashMap<String, Object>();
        	paramMap.put("grcode", grcode);
        	paramMap.put("grseq", grseq);
        	
        	resultMap = timeTableMapper.selectTimeTableBySubjGubunCount(paramMap);
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return resultMap;
	}
	
	/**
	 * 과목 구분의 정보 조회
	 */
	public DataMap selecttimeTableBySubjGubunList(String grcode, String grseq) throws BizException{
		DataMap resultMap = new DataMap();
        
        try {
        	resultMap = timeTableMapper.selectGubunBySubjGubun();
            if(resultMap == null) resultMap = new DataMap();
            resultMap.setNullToInitialize(true);
            
            Map<String, Object> paramMap = null;
            for(int i=0;i < resultMap.keySize("gubun"); i++){
            	paramMap = new HashMap<String, Object>();
            	paramMap.put("grcode", grcode);
            	paramMap.put("grseq", grseq);
            	paramMap.put("gubun", resultMap.getString("gubun", i));
            	
            	DataMap subjListMap = timeTableMapper.selecttimeTableBySubjGubunList(paramMap);
            	if(subjListMap == null) subjListMap = new DataMap();
            	
            	resultMap.add("SUBJGUBUN_LIST_DATA", subjListMap);
            }
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return resultMap;  
		
	}
	
	/**
	 * 시간표의 과정 시간표 출력(일자에 선택된 모든 과정)
	 */
	public DataMap selectTimeTableByPrint(DataMap requestMap) throws BizException{
		DataMap resultMap = new DataMap();
		Map<String, Object> paramMap = null;
        
        try {
        	String searchStarted = requestMap.getString("searchStarted");
            
            paramMap = new HashMap<String, Object>();
            paramMap.put("searchStarted", searchStarted);
            int inputDayNo = Integer.parseInt(timeTableMapper.selectDualTableByOneCol3(paramMap)); //학습자가 입력한 날짜의 요일 정보
            
            //입력한 일의 월요일, 금요일의 날짜를 구하기 위해
            boolean isPass = false;
            int startDayNo = 0;
            int endDayNo = 0;
            if( inputDayNo >= 2 && inputDayNo <= 6){
            	startDayNo = -1 * (inputDayNo - 2);
            	endDayNo = 6 - inputDayNo;
            	isPass = true;
            }else if( inputDayNo == 7){
            	startDayNo = 1;
            	endDayNo = 5;
            	isPass = true;
            }
            
            if(isPass){
            	
            	//해당일의 월요일 및 금요일 정보 조회.
            	paramMap.put("startDayNo", startDayNo);
            	paramMap.put("endDayNo", endDayNo);
            	DataMap tmpMap = timeTableMapper.selectDualCalDateRow(paramMap);
            	if(tmpMap == null) tmpMap = new DataMap();
            	tmpMap.setNullToInitialize(true);
            	
            	paramMap.put("weekSdate", tmpMap.getString("tmpStarted"));
            	paramMap.put("weekEdate", tmpMap.getString("tmpEnddate"));
            	resultMap = timeTableMapper.selectTimeTableByPrint(paramMap);
            	
            }else
            	resultMap = new DataMap();

        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return resultMap;  
		
	}
	
	/**
	 * 시간표 교시 정보. (외부강사에서 끌어다 씀)
	 */
	public DataMap selectTimeGosiList(String whereStr) throws BizException{
		DataMap resultMap = new DataMap();
        
        try {
        	Map<String, Object> paramMap = new HashMap<String, Object>();
			paramMap.put("gosiStr", whereStr);
        	resultMap = timeTableMapper.selectTimeGosiList(paramMap);
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return resultMap;
	}
	
	/**
	 * 과정 안내문에서 사용하기위한 시간표.
	 * 기수의 모든 주차의 내용을 리턴한다.
	 */
	public DataMap selectTimeTableList(String grcode, String grseq, DataMap grSeqRowMap) throws BizException{
		DataMap resultMap = new DataMap();
        Map<String, Object> paramMap = null;
        
        try {
        	//과정 시작 및 종료일
    		String courseSdate = grSeqRowMap.getString("started");
    		String courseEdate = grSeqRowMap.getString("enddate");
    		
			
    		if(grSeqRowMap.getInt("weekCnt") > 0 
    				&& courseSdate.length() == 8 
    				&& courseEdate.length() > 0
    				&& courseEdate.length() >= courseSdate.length() ){
    			
    			String studyWeek = "";
    			
        		//교시 정보. (세로) START
        		String gosiStr = "";
        		paramMap = new HashMap<String, Object>();
            	paramMap.put("gosiStr", gosiStr);
        		DataMap timeGosiMap = timeTableMapper.selectTimeGosiList(paramMap);
        		
        		if(timeGosiMap == null) timeGosiMap = new DataMap();
        		timeGosiMap.setNullToInitialize(true);
        		resultMap.add("GOSI_MAP", timeGosiMap); //결과 맵에 교시 정보 담기.
        		//교시 정보. (세로) END
        		
    			for(int k = 1; k <= grSeqRowMap.getInt("weekCnt") ; k++){
    				
    				studyWeek = k+""; //현재 주차
    				int weekCnt = 0; //전체 주차
            		String weekSdate = ""; //현재주차의 시작일
            		String weekEdate = ""; //현재주차의 종료일
            		
            		int weekSdateNo = 0; //현재주차의 시작일 주(1~7)
            		int weekEdateNo = 0; //현재주차의 종료일 주(1~7)

        			//총 주차수와 현재주차의 시작일, 현재주차의 종료일을 구한다.
            		paramMap = new HashMap<String, Object>();
                	paramMap.put("week", Integer.parseInt(studyWeek));
                	paramMap.put("startDate", courseSdate);
                	paramMap.put("endDate", courseEdate);
                	
        			DataMap tmpDateMap = timeTableMapper.selectStartEndDateByNow(paramMap);
        			if(tmpDateMap == null) tmpDateMap = new DataMap();
        			tmpDateMap.setNullToInitialize(true);
        			
        			weekCnt = tmpDateMap.getInt("weekCnt"); //주차수
        			weekSdate = tmpDateMap.getString("weekSdate"); //현재주차의 시작일
        			weekEdate = tmpDateMap.getString("weekEdate"); //현재주차의 종료일
        			
        			weekSdateNo = tmpDateMap.getInt("weekSdateNo"); //현재 주차 시작일의 요일 정보 (2,3,4,5,6)
        			weekEdateNo = tmpDateMap.getInt("weekEdateNo"); //현재 주차 종료일의 요일 정보 (2,3,4,5,6)
    				
            		//결과 맵에 정보 담기.
        			resultMap.addInt("weekCnt", weekCnt);
            		resultMap.addString("studyWeek", studyWeek); //현재주차.
            		resultMap.addString("weekSdate", weekSdate);
            		resultMap.addString("weekEdate", weekEdate);
            		resultMap.addInt("weekSdateNo", weekSdateNo);
            		resultMap.addInt("weekEdateNo", weekEdateNo);
            		
            		
            		//요일 정보 (가로) START
        			DataMap timeStudyDate = new DataMap();
            		
            		String nWeekMon = ""; //현재 주차 월요일의 날짜
        			if (weekSdateNo == 2) {
        				nWeekMon = weekSdate;
        			} else {
        				paramMap = new HashMap<String, Object>();
        				paramMap.put("weekSdate", weekSdate);
        				paramMap.put("weekSdateNo", weekSdateNo);
        				nWeekMon = timeTableMapper.selectDualTableByOneCol1(paramMap);
        			}
        			
        			for(int j = 2; j <= 6; j ++){
        				paramMap = new HashMap<String, Object>();
        				paramMap.put("weekSdate", nWeekMon);
        				paramMap.put("weekSdateNo", j);
        				String tmpDate = timeTableMapper.selectDualTableByOneCol2(paramMap);
        				timeStudyDate.addString("day", tmpDate);
        				timeStudyDate.addString("comaDay", StringReplace.subString(tmpDate, 4, 6) + "." + StringReplace.subString(tmpDate, 6, 8) );
        			}
        			resultMap.add("WEEK_MAP", timeStudyDate); //결과 맵에 교시 정보 담기.
        			//요일 정보 (가로) END
        			
            		//시간표 결과 정보 담기.
        			// 		월요일 부터 금요일 까지 한쿼리에서 가능하지 않아서 (sort key too long) 나누어 정보를 담아 사용
        			// 		 plan1 : 월~수
        			//		 plan2 : 목, 금 
        			paramMap = new HashMap<String, Object>();
    				paramMap.put("grcode", grcode);
    				paramMap.put("grseq", grseq);
    				paramMap.put("weekSdate", weekSdate);
    				paramMap.put("weekEdate", weekEdate);
    				paramMap.put("gosiStr", gosiStr);
    				
            		DataMap plan1 = timeTableMapper.selectTimeTableByPlan1(paramMap);
            		resultMap.add("TIME1_LIST_DATA", plan1); //결과 맵에 교시 정보 담기.
            		DataMap plan2 = timeTableMapper.selectTimeTableByPlan2(paramMap);
            		resultMap.add("TIME2_LIST_DATA", plan2); //결과 맵에 교시 정보 담기.
    			}
    		}
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return resultMap;
	}
}
