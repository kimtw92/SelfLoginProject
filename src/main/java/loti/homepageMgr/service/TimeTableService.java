package loti.homepageMgr.service;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

import loti.homepageMgr.mapper.TimeTableMapper;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import ut.lib.exception.BizException;
import ut.lib.login.LoginInfo;
import ut.lib.support.DataMap;
import ut.lib.util.DateUtil;
import ut.lib.util.Message;
import ut.lib.util.StringReplace;

@Service("homepageMgrTimeTableService")
public class TimeTableService {

	@Autowired
	@Qualifier("homepageMgrTimeTableMapper")
	private TimeTableMapper timeTableMapper;
	
	public DataMap selectTimeTableList(DataMap requestMap, DataMap grSeqRowMap, LoginInfo loginInfo) throws BizException {
		
		DataMap resultMap = new DataMap();
        
		requestMap.setNullToInitialize(true);
		
        try {
        	
    		String grcode = requestMap.getString("commGrcode");
    		String grseq = requestMap.getString("commGrseq");
    		
    		//과정 시작 및 종료일
    		String courseSdate = grSeqRowMap.get("started")+"";
    		String courseEdate = grSeqRowMap.get("enddate")+"";
    		
    		//현재 주차
            String studyWeek = requestMap.getString("studyWeek");
            
            //선택된 주차가 없을 경우 1주차 셋팅.
    		if(studyWeek.equals("")){
    			
    			// 오늘날짜와 과정의 시작일과 교육종료일을 비교한다.
    			if( !courseEdate.equals("") 
    					&& DateUtil.getDaysDiff(grSeqRowMap.get("enddate")+"", DateUtil.getDateTime()  ) > 0
    					&& !courseSdate.equals("") 
    					&& DateUtil.getDaysDiff(grSeqRowMap.get("started")+"", DateUtil.getDateTime()) < 0 ){
    				
    				Map<String, Object> params = new HashMap<String, Object>();
    				
    				params.put("startDate", courseSdate);
    				params.put("endDate", DateUtil.getDateTime());
    				
    				//오늘의 주차를 구한다.
    				studyWeek =  "" + timeTableMapper.selectWeekCnt(params);
    				
    			}else
    				studyWeek = "1";
    			
    		}
    		requestMap.setString("studyWeek", studyWeek);
    		
    		//System.out.println("\n ## 현재 주차는=" + studyWeek + "\n" );

    		int weekCnt = 0; //전체 주차
    		String weekSdate = ""; //현재주차의 시작일
    		String weekEdate = ""; //현재주차의 종료일
    		
    		int weekSdateNo = 0; //현재주차의 시작일 주(1~7)
    		int weekEdateNo = 0; //현재주차의 종료일 주(1~7)
    		
    		if(courseSdate.length() == 8 
    				&& courseEdate.length() > 0
    				&& courseEdate.length() >= courseSdate.length() ){ 
    			
    			
    			//총 주차수와 현재주차의 시작일, 현재주차의 종료일을 구한다.
    			Map<String, Object> params = new HashMap<String, Object>();
    			
    			params.put("week", Integer.parseInt(studyWeek));
    			params.put("startDate", courseSdate);
    			params.put("endDate", courseEdate);
    			
    			DataMap tmpDateMap = timeTableMapper.selectStartEndDateByNow(params);
    			if(tmpDateMap == null) tmpDateMap = new DataMap();
    			tmpDateMap.isNullToInitialize();
    			
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
        		if(requestMap.getString("searchKey").equals("MORNING")){
        			timeGosiMap = timeTableMapper.selectTimeGosiListBetween1And9();
        		}else
        			timeGosiMap = timeTableMapper.selectTimeGosiList();
        		
        		if(timeGosiMap == null) timeGosiMap = new DataMap();
        		timeGosiMap.isNullToInitialize();
        		resultMap.set("GOSI_MAP", timeGosiMap); //결과 맵에 교시 정보 담기.
        		//교시 정보. (세로) END
        		
        		
        		//요일 정보 (가로) START
    			DataMap timeStudyDate = new DataMap();
        		
        		String nWeekMon = ""; //현재 주차 월요일의 날짜
    			if(weekSdateNo == 2)
    				nWeekMon = weekSdate;
    			else{
    				nWeekMon = timeTableMapper.selectDualTableByOneCol(" TO_CHAR(TO_DATE('"+weekSdate+"', 'YYYYMMDD')-("+weekSdateNo+"-2),'YYYYMMDD')");
    			}
    			
    			for(int j = 2; j <= 6; j ++){
    				String tmpDate = timeTableMapper.selectDualTableByOneCol(" TO_CHAR(TO_DATE('"+nWeekMon+"', 'YYYYMMDD')+("+j+"-2),'YYYYMMDD') ");
    				timeStudyDate.addString("day", tmpDate);
    				timeStudyDate.addString("comaDay", StringReplace.subString(tmpDate, 4, 6) + "." + StringReplace.subString(tmpDate, 6, 8) );
    			}
    			resultMap.set("WEEK_MAP", timeStudyDate); //결과 맵에 교시 정보 담기.
    			//요일 정보 (가로) END
    			
        		//시간표 결과 정보 담기.
    			// 		월요일 부터 금요일 까지 한쿼리에서 가능하지 않아서 (sort key too long) 나누어 정보를 담아 사용
    			// 		 plan1 : 월~수
    			//		 plan2 : 목, 금
    			
    			params.put("grcode", grcode);
    			params.put("grseq", grseq);
    			params.put("weekSdate", weekSdate);
    			params.put("weekEdate", weekEdate);
    			params.put("searchKey", weekEdate);
    			
    			DataMap plan1 = timeTableMapper.selectTimeTableByPlan1(params);
        		resultMap.set("TIME1_LIST_DATA", plan1); //결과 맵에 교시 정보 담기.
        		DataMap plan2 = timeTableMapper.selectTimeTableByPlan2(params);
        		resultMap.set("TIME2_LIST_DATA", plan2); //결과 맵에 교시 정보 담기.
    			
    		}
    		
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return resultMap;
	}

	public DataMap selectClassRoomByGrseqRow(String grcode, String grseq) throws BizException {

		DataMap resultMap = null;
        
        try {
        	
        	Map<String, Object> params = new HashMap<String, Object>();
        	
        	params.put("grcode", grcode);
        	params.put("grseq", grseq);
        	
            resultMap = timeTableMapper.selectClassRoomByGrseqRow(params);
                                    
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return resultMap;  
	}

}
