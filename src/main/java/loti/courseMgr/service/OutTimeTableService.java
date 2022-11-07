package loti.courseMgr.service;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

import loti.courseMgr.mapper.OutTimeTableMapper;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import ut.lib.exception.BizException;
import ut.lib.support.DataMap;
import ut.lib.util.Message;
import common.service.BaseService;

@Service
public class OutTimeTableService extends BaseService {

	@Autowired
	private OutTimeTableMapper outTimeTableMapper;
	
	/**
	 * 특정일의 시작일(일), 종료일(토), 특정날짜+-한 날짜 구하기 
	 */
	public DataMap selectOutTimeTableByEtcRow(String date) throws BizException{
		DataMap resultMap = new DataMap();
        
        try {
        	resultMap = outTimeTableMapper.selectOutTimeTableByEtcRow(date);
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return resultMap;
	}
	
	/**
	 * 외부 강사 시간표 한주의 내용
	 */
	public DataMap selectOutTimeTableList(String weekSdate, String weekEdate) throws BizException{
		DataMap resultMap = new DataMap();
        
        try {
        	Map<String, Object> paramMap = new HashMap<String, Object>();
        	paramMap.put("weekSdate", weekSdate);
        	paramMap.put("weekEdate", weekEdate);
        	
        	resultMap = outTimeTableMapper.selectOutTimeTableList(paramMap);
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return resultMap;
	}
	
	/**
	 * 특정 일요일의 한주 일자 구하기.
	 */
	public DataMap selectOutTimeTableByWeekDateRow(String date) throws BizException{
		DataMap resultMap = new DataMap();
        
        try {
        	resultMap = outTimeTableMapper.selectOutTimeTableByWeekDateRow(date);
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return resultMap;
	}
	
	/**
	 * 강의실 리스트
	 */
	public DataMap selectClassRoomList() throws BizException{
		DataMap resultMap = new DataMap();
        
        try {
        	resultMap = outTimeTableMapper.selectClassRoomList();
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return resultMap;
	}
	
	/**
	 * 강의실 상세정보
	 */
	public DataMap selectClassRoomRow(String classNo) throws BizException{
		DataMap resultMap = new DataMap();
        
        try {
        	resultMap = outTimeTableMapper.selectClassRoomRow(classNo);
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return resultMap;
	}
	
	/**
	 * 외부 강사 시간표 상세 정보
	 */
	public DataMap selectOutTimeTableRow(String classNo, String studydate, int seq) throws BizException{
		DataMap resultMap = new DataMap();
        
        try {
        	Map<String, Object> paramMap = new HashMap<String, Object>();
        	paramMap.put("classNo", classNo);
        	paramMap.put("studydate", studydate);
        	paramMap.put("seq", seq);
        	
        	resultMap = outTimeTableMapper.selectOutTimeTableRow(paramMap);
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return resultMap;
	}
	
	/**
	 * 외부 강사 시간표 해당 요일,강의실이 사용가능한지 여부 내용을 포함한 교시 정보
	 */
	public DataMap selectOutTimeTableByStudytimeChkList(String classNo, String studydate, int seq) throws BizException{
		DataMap resultMap = new DataMap();
        
        try {
        	Map<String, Object> paramMap = new HashMap<String, Object>();
        	paramMap.put("classNo", classNo);
        	paramMap.put("studydate", studydate);
        	paramMap.put("seq", seq);
        	
        	resultMap = outTimeTableMapper.selectOutTimeTableByStudytimeChkList(paramMap);
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return resultMap;
	}

	/**
	 * 외부 강사 시간표 삭제 (강의실, 요일)
	 */
	public int deleteOutTimeTable(String classNo, String studydate, int seq) throws BizException{
		int resultValue = 0;
        
        try {
        	Map<String, Object> paramMap = new HashMap<String, Object>();
        	paramMap.put("classNo", classNo);
        	paramMap.put("studydate", studydate);
        	paramMap.put("seq", seq);
        	
        	//시간표 상세 내용 삭제
        	outTimeTableMapper.deleteOutTimeTable(paramMap);
            
            //시간표 삭제
            resultValue = outTimeTableMapper.deleteOutTimeTableInfo(paramMap);
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return resultValue;
	}
	
	/**
	 * 외부 강사 시간표 등록
	 */
	public int insertOutTimeTable(DataMap requestMap, String userNo) throws BizException{
		int returnSeq = 0;
        
        try {
        	//시간표 상세 내용 등록
        	int seq = outTimeTableMapper.selectOutTimeTableInfoMaxSeq();
        	Map<String, Object> paramMap = new HashMap<String, Object>();
        	paramMap.put("classNo", requestMap.getString("classNo"));
        	paramMap.put("studydate", requestMap.getString("studydate"));
        	paramMap.put("seq", seq);
        	paramMap.put("contents", requestMap.getString("contents"));
        	paramMap.put("userno", userNo);
        	
            returnSeq = outTimeTableMapper.insertOutTimeTableInfo(paramMap);
            
            if(returnSeq > 0){ //상세 등록
            	//등록된 시간표 상세 삭제.
            	outTimeTableMapper.deleteOutTimeTable(paramMap);
            	
            	for(int i=0; i < requestMap.keySize("studytime"); i++){
            		//시간표 상세 등록
            		paramMap = new HashMap<String, Object>();
            		paramMap.put("classNo", requestMap.getString("classNo"));
                	paramMap.put("studydate", requestMap.getString("studydate"));
                	paramMap.put("studytime", requestMap.getInt("studytime", i));
                	paramMap.put("seq", seq);
                	
            		outTimeTableMapper.insertOutTimeTable(paramMap);
            	}
            }
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return returnSeq;
	}
	
	/**
	 * 외부 강사 시간표 수정
	 * @param requestMap
	 */
	public int updateOutTimeTable(DataMap requestMap, String userNo) throws BizException{
		int returnValue = 0;
        
        try {
        	//시간표 상세 내용 수정
        	Map<String, Object> paramMap = new HashMap<String, Object>();
        	paramMap.put("contents", requestMap.getString("contents"));
        	paramMap.put("userno", userNo);
        	paramMap.put("classNo", requestMap.getString("classNo"));
        	paramMap.put("studydate", requestMap.getString("studydate"));
        	paramMap.put("seq", requestMap.getInt("seq"));
        	
            returnValue = outTimeTableMapper.updateOutTimeTableInfo(paramMap);
            
            if(returnValue > 0){ //상세 등록
            	//등록된 시간표 상세 삭제.
            	outTimeTableMapper.deleteOutTimeTable(paramMap);
            	
            	for(int i=0; i < requestMap.keySize("studytime"); i++) {
            		//시간표 상세 등록
            		paramMap = new HashMap<String, Object>();
            		paramMap.put("classNo", requestMap.getString("classNo"));
            		paramMap.put("studydate", requestMap.getString("studydate"));
            		paramMap.put("studytime", requestMap.getInt("studytime", i));
            		paramMap.put("seq", requestMap.getInt("seq"));
            		
            		outTimeTableMapper.insertOutTimeTable(paramMap);
            	}
            }
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return returnValue;
	}
	
	/*
	 * 원본 소스에서 주석 처리되어 있는 부분을 그대로 복사함.
	public DataMap selectOutTimeTableList(DataMap requestMap) throws BizException{
		
        Connection con = null;
        DataMap resultMap = new DataMap();
        
        try {
        	
            con = DBManager.getConnection();
            OutTimeTableDAO dao = new OutTimeTableDAO(con);
            TimeTableDAO timeDao = new TimeTableDAO(con);

    		//리퀘스트로 넘어온 날짜가 없다면 오늘날짜로 셋팅.
            String reqDate = requestMap.getString("searchDate"); //기준되는 날짜.
            if( reqDate.equals("") ){
            	reqDate = DateUtil.getDateTime();
            	requestMap.setString("searchDate", reqDate);
            }
    		
    		System.out.println("\n ## 기준일 = " + reqDate + "\n" );

    		String weekSdate = ""; //기준일 주차의 시작일(일요일)
    		String weekEdate = ""; //현재주차의 종료일 (토요일)
    		
    		String prevWeekDate = ""; //지난주 일자 (기준일의 일주일전)
    		String nextWeekDate = ""; //다음주의 일자 (기준일의 일주일후)
    		
			//기준일의 시작일, 종료일, 지난주의 일자, 다음주의 일자 를  구한다.
			DataMap tmpDateMap = dao.selectOutTimeTableByEtcRow(reqDate);
			if(tmpDateMap == null) tmpDateMap = new DataMap();
			tmpDateMap.setNullToInitialize(true);
			
			weekSdate = tmpDateMap.getString("weekStartDate"); //기준일의 시작일
			weekEdate = tmpDateMap.getString("weekEndDate"); //기준일의 종료일
			
			prevWeekDate = tmpDateMap.getString("prevWeekDate"); //기준일의 일주일전
			nextWeekDate = tmpDateMap.getString("nextWeekDate"); //기준일의 일주일후
			requestMap.setString("prevWeekDate", prevWeekDate);
			requestMap.setString("nextWeekDate", nextWeekDate);
			
			
    		
    		//교시 정보. (세로) START
    		DataMap timeGosiMap = timeDao.selectTimeGosiList("");;
    		if(timeGosiMap == null) timeGosiMap = new DataMap();
    		timeGosiMap.setNullToInitialize(true);
    		
    		resultMap.add("GOSI_MAP", timeGosiMap); //결과 맵에 교시 정보 담기.
    		//교시 정보. (세로) END
    		
    		
    		//요일 정보 (가로)
			DataMap timeStudyDate = dao.selectOutTimeTableByWeekDateRow(weekSdate);
			if(timeStudyDate == null) timeStudyDate = new DataMap();
			resultMap.add("WEEK_MAP", timeStudyDate); //결과 맵에 교시 정보 담기.
			
    		//강의실 정보 (세로)
			DataMap classList = dao.selectClassRoomList();
			if(classList == null) classList = new DataMap();
			resultMap.add("CLASS_LIST_MAP", classList); //결과 맵에 교시 정보 담기.
			
    		// 외부 강사 시간표 결과 정보 담기.
    		DataMap listMap = dao.selectOutTimeTableByClassWeekList( weekSdate, weekEdate);
    		resultMap.add("CLASS_LIST_DATA", listMap); //결과 맵에 교시 정보 담기.
    		
    		
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return resultMap;
	}
	*/
}
