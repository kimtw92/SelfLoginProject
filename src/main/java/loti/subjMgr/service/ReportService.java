package loti.subjMgr.service;

import java.sql.SQLException;

import loti.subjMgr.mapper.ReportMapper;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import ut.lib.exception.BizException;
import ut.lib.support.DataMap;
import ut.lib.util.Message;
import ut.lib.util.Util;
import common.service.BaseService;

@Service
public class ReportService extends BaseService {

	@Autowired
	private ReportMapper reportMapper;
	
	/**
	 * 과제물출제 관리
	 * 작성자 : 정윤철
	 * 작성일 : 7월 22일
	 * @param requestMap
	 * @param 
	 * @return selectReportList
	 * @throws Exception
	 */
	public DataMap selectReportList(DataMap requestMap) throws Exception{
		
        DataMap resultMap = null;
        
        try {
//        	requestMap.getString("subj"), requestMap.getString("grcode"), requestMap.getString("grseq"), requestMap.getString("classno")
            resultMap = reportMapper.selectReportList(requestMap);
                                    
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return resultMap;        
	}
	
	/**
	 * 과제물출제 관리 -> 반 리스트
	 * 작성자 : 정윤철
	 * 작성일 : 7월 22일 
	 * @param requestMap
	 * @param 
	 * @return selectReportClassNoList
	 * @throws Exception
	 */
	public DataMap selectReportClassNoList(DataMap requestMap) throws Exception{
		
        DataMap resultMap = null;
        
        try {
//        	requestMap.getString("subj"), requestMap.getString("grcode"), requestMap.getString("grseq")
            resultMap = reportMapper.selectReportClassNoList(requestMap);
                                    
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return resultMap;        
	}
	
	
	/**
	 * 과제물출제 관리 -> 과제물 출제 폼데이터
	 * 작성자 : 정윤철
	 * 작성일 : 7월 22일 
	 * @param requestMap
	 * @param 
	 * @return selectReportRow
	 * @throws Exception
	 */
	public DataMap selectReportRow(DataMap requestMap) throws Exception{
		
        DataMap resultMap = null;
        
        try {
//        	requestMap.getString("subj"), requestMap.getString("grcode"), requestMap.getString("grseq"), requestMap.getString("classno"), requestMap.getString("dates")
            resultMap = reportMapper.selectReportRow(requestMap);
                                    
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return resultMap;        
	}
	
	
	/**
	 * 과제물출제 관리 -> 과제물 출제 차시
	 * 작성자 : 정윤철
	 * 작성일 : 7월 22일 
	 * @param requestMap
	 * @param 
	 * @return selectReportDatesRow
	 * @throws Exception
	 */
	public DataMap selectReportDatesRow(DataMap requestMap) throws Exception{
		
        DataMap resultMap = null;
        
        try {
        	
            resultMap = reportMapper.selectReportDatesRow(requestMap.getString("subj"));
                                    
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return resultMap;        
	}
	
	
	/**
	 * 과제물출제 관리 -> 과제물 출제 강사명단
	 * 작성자 : 정윤철
	 * 작성일 : 7월 22일 
	 * @param requestMap
	 * @param 
	 * @return selectReportClassTutorRow
	 * @throws Exception
	 */
	public DataMap selectReportClassTutorRow(DataMap requestMap) throws Exception{
		
        DataMap resultMap = null;
        
        try {
//        	requestMap.getString("grcode"), requestMap.getString("grseq"), requestMap.getString("classno"), requestMap.getString("subj")
            resultMap = reportMapper.selectReportClassTutorRow(requestMap);
            
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return resultMap;        
	}
	
	
	/**
	 * 과제물출제 관리 -> 과제물 출제 수정
	 * 작성자 : 정윤철
	 * 작성일 : 7월 22일 
	 * @param requestMap
	 * @param 
	 * @return updateReport
	 * @throws Exception
	 */
	public int updateReport(DataMap requestMap) throws Exception{
		
        int returnValue = 0;

        try {

        	returnValue = reportMapper.updateReport(requestMap);
            
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	returnValue = 1;
        }
        return returnValue;        
	}
	
	
	/**
	 * 과제물출제 관리 -> 과제물 출제 등록
	 * 작성자 : 정윤철
	 * 작성일 : 7월 23일 
	 * @param requestMap
	 * @param 
	 * @return insertReport
	 * @throws Exception
	 */
	@Transactional
	public int insertReport(DataMap requestMap) throws Exception{
		
        int returnValue = 0;
        int dates = 0;
        String date = "";
        try {

            //차시정보를 셀렉트해온다.
            dates = reportMapper.selectReportMaxDates(requestMap);
            
            if(dates < 10){
            	date = "0" + dates;
            	
            }else{
            	date = String.valueOf(dates);
            	
            }
            
            requestMap.setString("dates", date);
            
            //출제자 선택이 없을경우 등록자의 명을 넣는다.
            if(requestMap.getString("tutorName").equals("")){
            	requestMap.setString("tutorName", requestMap.getString("luserno"));
            	
            }
            
            returnValue = reportMapper.insertReport(requestMap);
            
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
            
        } finally {
        }
        return returnValue;        
	}

	/**
	 * 과제물출제 관리 -> 과제물 출제 삭제
	 * 작성자 : 정윤철
	 * 작성일 : 7월 23일 
	 * @param requestMap
	 * @param 
	 * @return deleteReport
	 * @throws Exception
	 */
	@Transactional
	public int deleteReport(DataMap requestMap) throws Exception{
		
        int returnValue = 0;
        try {
        	DataMap params = (DataMap)requestMap.clone();
            for(int i=0; requestMap.keySize("chk") > i; i++){
//            	requestMap.getString("subj"), requestMap.getString("grcode"), requestMap.getString("grseq"), requestMap.getString("classno"), requestMap.getString("chk", i)
            	params.setString("chk", requestMap.getString("chk", i));
            	returnValue = reportMapper.deleteReportGrade(params);
            	returnValue = reportMapper.deleteReportSubmit(params);
            	returnValue = reportMapper.deleteReport(params);	
            }
            
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	returnValue = 1;
        }
        return returnValue;        
	}
	
	
	/**
	 * 과제물출제 관리 -> 과제물 출제 평가등급 점수
	 * 작성자 : 정윤철
	 * 작성일 :7월 24
	 * @param requestMap
	 * 
	 * @return selectReportGradeList
	 * @throws Exception
	 */
	public DataMap selectReportGradePointRow(DataMap requestMap) throws Exception{
		
        DataMap resultMap = null;
        try {
//        	requestMap.getString("grcode"), requestMap.getString("grseq"), requestMap.getString("subj"),  requestMap.getString("dates")
            resultMap = reportMapper.selectReportGradePointRow(requestMap);
            
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return resultMap;        
	}

	/**
	 * 과제물출제 관리 -> 과제물 출제 평가등급 최대 점수
	 * 작성자 : 정윤철
	 * 작성일 :7월 24
	 * @param requestMap
	 * 
	 * @return selectReportGradeList
	 * @throws Exception
	 */
	public DataMap selectReportGradeMaxPointRow(DataMap requestMap) throws Exception{
		
        DataMap resultMap = null;
        try {
//        	requestMap.getString("grcode"), requestMap.getString("grseq"), requestMap.getString("subj")
            resultMap = reportMapper.selectReportGradeMaxPointRow(requestMap);
            
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
            
        } finally {
        }
        return resultMap;        
	}

	/**
	 * 과제물출제 관리 -> 과제물  제출자 점수
	 * 작성자 : 정윤철
	 * 작성일 :7월 28
	 * @param requestMap
	 * 
	 * @return selectReportGradeList
	 * @throws Exception
	 */
	public DataMap reportAppGradePointRow(DataMap requestMap) throws Exception{
		
        DataMap resultMap = null;
        try {
//        	requestMap.getString("grcode"), requestMap.getString("grseq"), requestMap.getString("subj"), requestMap.getString("classno"), requestMap.getString("dates")
            resultMap = reportMapper.reportAppGradePointRow(requestMap);
            
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return resultMap;        
	}

	/**
	 * 과제물출제 관리 -> 과제물  반명,반번호
	 * 작성자 : 정윤철
	 * 작성일 :7월 28
	 * @param requestMap
	 * 
	 * @return selectReportGradeList
	 * @throws Exception
	 */
	public DataMap reportAppClassNameRow(DataMap requestMap) throws Exception{
		
        DataMap resultMap = null;
        try {
//        	requestMap.getString("grcode"), requestMap.getString("grseq"), requestMap.getString("subj")
            resultMap = reportMapper.reportAppClassNameRow(requestMap);
            
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return resultMap;        
	}

	/**
	 * 과제물출제 관리 -> 과제물 제출기간, 과정명
	 * 작성자 : 정윤철
	 * 작성일 :7월 28
	 * @param requestMap
	 * 
	 * @return selectReportGradeList
	 * @throws Exception
	 */
	public DataMap selectGradeGrcode(DataMap requestMap) throws Exception{
		
        DataMap resultMap = null;
        try {
//        	requestMap.getString("grcode"), requestMap.getString("grseq"), requestMap.getString("subj"), requestMap.getString("classno"), requestMap.getString("dates")
            resultMap = reportMapper.selectGradeGrcode(requestMap);
            
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return resultMap;        
	}
	
	/**
	 * 과제물출제 관리 -> 과제물 제출 자 수
	 * 작성자 : 정윤철
	 * 작성일 :7월 28
	 * @param requestMap
	 * 
	 * @return selectReportGradeList
	 * @throws Exception
	 */
	public DataMap selectGradeEvalCnt(DataMap requestMap) throws Exception{
		
        DataMap resultMap = null;
        try {
//        	requestMap.getString("grcode"), requestMap.getString("grseq"), requestMap.getString("subj"), requestMap.getString("classno"), requestMap.getString("dates")
            resultMap = reportMapper.selectGradeEvalCnt(requestMap);
            
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return resultMap;        
	}	
	
	/**
	 * 과제물출제 관리 -> 과제물 출제 평가등급 설정 리스트
	 * 작성자 : 정윤철
	 * 작성일 : 7월 23일 
	 * @param requestMap
	 * @param 
	 * @return selectReportGradeList
	 * @throws Exception
	 */
	public DataMap selectReportGradeList(DataMap requestMap) throws Exception{
		
        DataMap resultMap = null;
        try {
//        	requestMap.getString("grcode"), requestMap.getString("grseq"), requestMap.getString("subj"), requestMap.getString("classno"), requestMap.getString("dates")
            resultMap = reportMapper.selectReportGradeList(requestMap);
            
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return resultMap;        
	}
	
	
	/**
	 * 과제물출제 관리 -> 과제물 출제 평가등급 등록
	 * 작성자 : 정윤철
	 * 작성일 : 7월 23일 
	 * @param requestMap
	 * @param 
	 * @return selectReportGradeList
	 * @throws Exception
	 */
	@Transactional
	public int insertReportGrade(DataMap requestMap) throws Exception{
		
        int returnValue = 0;
        int count = 0;
        int twoCount = 0;
        try {
            
        	DataMap params = (DataMap) requestMap.clone();
        	
            for(int i=0; (requestMap.getInt("gradeNo")+2)> i; i++){
            	//입력한 등급들이 등록되어있는 값인지 아닌지 체크 값이 있을경우 수정 쿼리를 타고 아닐경우 등록, 수정
//            	requestMap.getString("subj"), requestMap.getString("grcode"), requestMap.getString("grseq"),requestMap.getString("classno"), requestMap.getString("dates"), (i+1)
            	count = reportMapper.selectReportGradeCountRow(requestMap);
            	params.setString("gradePoint", requestMap.getString("gradePoint", i));
            	params.setInt("gradeNo", i+1);
            	if(count <= 0){
            		//등록모드
//            		requestMap.getString("grcode"), requestMap.getString("grseq"), requestMap.getString("subj"), requestMap.getString("classno"), requestMap.getString("dates"), (i+1)
                	returnValue = reportMapper.insertReportGrade(params);
	            	returnValue = reportMapper.updateReprtGrade(params); 
            	}else{
					//수정모드
	            	returnValue = reportMapper.updateReprtGrade(params); 
	            	
            	}
            	twoCount++;
            	
            }
            /*
            //이전등록되어있는 카운터수
            int keySize = requestMap.getInt("totalCnt");
        	if(twoCount > 0 ){
	        		for(int j = twoCount; keySize > j; j++){
	            	//삭제 모드 :  등급을 변경했을때에 기존 5등급에서 3등급으로 변경되었을경우 3등급 이후를 삭제한다.
	            	//기존꺼는 삭제가 없어서 그대로 쓴다. 단 문제는 20개의 값들을 전부 다시 체크를하여서 20개가 입력이 되었을경우 전부다시 입력해야한다는 문제점이있다.
	        		//그래서 현재 선택된 등급외의 값들은 삭제를한다.
        			//j+1을 한이유는 로직상에서 j는 0부터 시작이지만 등록은 1부터 되어있기 때문이다.
	        			returnValue = dao.deleteReprtGrade(
							        					requestMap.getString("grcode"), 
							        					requestMap.getString("grseq"), 
							        					requestMap.getString("subj"), 
							        					requestMap.getString("classno"), 
							        					requestMap.getString("dates"), 
								            			(j+1)
							            			  );
	        			
        		}
        	}*/
        	
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
            
        } finally {
        	returnValue = 1;
        }
        return returnValue;        
	}
	
	
	
	/**
	 * 과제물출제 관리 -> 과제물 제출평가 리스트
	 * 작성자 : 정윤철
	 * 작성일 : 7월 25일 
	 * @param requestMap
	 * @param 
	 * @return selectReportGradeList
	 * @throws Exception
	 */
	public DataMap reportAppList(DataMap requestMap) throws Exception{
		
        DataMap resultMap = null;
        try {
//            requestMap.getString("grcode"), requestMap.getString("grseq"), requestMap.getString("subj"), requestMap.getString("dates"), order
            resultMap = reportMapper.reportAppList(requestMap);
        	
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return resultMap;        
	}
	
	
	/**
	 * 과제물출제 관리 -> 과제물 출제 평가등급 수정
	 * 작성자 : 정윤철
	 * 작성일 : 7월 23일 
	 * @param requestMap
	 * @param 
	 * @return selectReportGradeList
	 * @throws Exception
	 */
	public int updateGradeApp(DataMap requestMap, String userno, String submitPoint) throws Exception{
		
        int returnValue = 0;
        try {
        	
        	DataMap params = (DataMap) requestMap.clone();
        	
        	params.setString("userno", userno);
        	params.setString("point", submitPoint);
//        	requestMap, userno, submitPoint
        	reportMapper.updateGeportApp(params);
        	reportMapper.updateReportSubmit(params);
        	
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return returnValue;        
	}
	
	/**
	 * 과제물출제 관리 -> 과제물 출제 평가등급 수정
	 * 작성자 : 정윤철
	 * 작성일 : 7월 23일 
	 * @param requestMap
	 * @param 
	 * @return selectReportGradeList
	 * @throws Exception
	 */
	public int insertGradetApp(DataMap requestMap, String userno, String submitPoint) throws Exception{
		
        int returnValue = 0;
        try {
            
        	DataMap params = (DataMap) requestMap.clone();
        	
        	params.setString("userno", userno);
        	params.setString("point", submitPoint);
//        	requestMap, userno, submitPoint
        	reportMapper.insertGradetApp(params);
        	
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
            
        } finally {
        	returnValue = 1;
        }
        return returnValue;        
	}	
	
	/**
	 * 과제물출제 관리 -> 과제물 과목코드 등록여부 확인 
	 * 작성자 : 정윤철
	 * 작성일 : 7월 23일 
	 * @param requestMap
	 * @param 
	 * @return selectReportGradeList
	 * @throws Exception
	 */
	public int selectReportSubmitCountRow(DataMap requestMap, String userno) throws Exception{
		
        int returnValue = 0;
        try {
        	
        	DataMap params = (DataMap) requestMap.clone();
        	
        	params.setString("userno", userno);
//        	requestMap, userno
        	returnValue = reportMapper.selectReportSubmitCountRow(params);

        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return returnValue;        
	}
	
	/**
	 * 과제물출제 관리 -> 과제물평가관리 리스트
	 * 작성자 : 정윤철
	 * 작성일 : 7월 29일 
	 * @param requestMap
	 * @param 
	 * @return selectReportGradeList
	 * @throws Exception
	 */
	public DataMap selectGradeAppList(DataMap requestMap) throws Exception{
		
        DataMap resultMap = null;
        try {
        	DataMap params = (DataMap) requestMap.clone();
        	params.setString("subj", "SUB1000025");
//        	requestMap.getString("grcode"), requestMap.getString("grseq"), requestMap.getString("subj"), requestMap.getString("classno")
            resultMap = reportMapper.selectGradeAppList(params);
        	
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return resultMap;        
	}
	
	
	/**
	 * 과제물출제 관리 -> 과제물평가관리 반명
	 * 작성자 : 정윤철
	 * 작성일 : 7월 29일 
	 * @param requestMap
	 * @param 
	 * @return selectReportGradeList
	 * @throws Exception
	 */
	public DataMap selectReportClassNoRow(DataMap requestMap) throws Exception{
		
        DataMap resultMap = null;
        try {
        	DataMap params = (DataMap) requestMap.clone();
        	params.setString("subj", "SUB1000025");
//        	requestMap.getString("grcode"), requestMap.getString("grseq"), requestMap.getString("subj")
        	resultMap = reportMapper.selectReportClassNoRow(params);
        	
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return resultMap;        
	}
	
	/**
	 * 과제물출제 관리 -> 과제물평가관리 반명
	 * 작성자 : 정윤철
	 * 작성일 : 7월 29일 
	 * @param requestMap
	 * @param 
	 * @return selectReportGradeList
	 * @throws Exception
	 */
	public String selectReportAppGradeCntRow(DataMap requestMap) throws Exception{
		
        String returnValue = "";
        try {
//        	requestMap.getString("grcode"), requestMap.getString("grseq")
            returnValue = reportMapper.selectReportAppGradeCntRow(requestMap);
        	
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return returnValue;        
	}
	
	
	/**
	 * 과제물평가관리 제출 파일 업로드
	 * @param requestMap
	 * @return DataMap
	 * @throws Exception
	 */
	public String reportSubmit(DataMap requestMap) throws Exception{
		

        String Msg = "";
        
        try {
        	DataMap params = (DataMap)requestMap.clone();
        	params.setString("dates", Util.plusZero(requestMap.getString("dates")));
        	params.setInt("groupfileNo", Util.getIntValue(requestMap.getInt("groupfileNo"),0));
//        	requestMap.getString("grcode"), requestMap.getString("grseq"), requestMap.getString("subj"), requestMap.getString("classno"), Util.plusZero(requestMap.getString("dates")), requestMap.getString("luserno")
            int iNum = reportMapper.regChoice(params);
            if(iNum == 0) {
//            	requestMap.getString("grcode"), requestMap.getString("grseq"), requestMap.getString("subj"), requestMap.getString("classno"), Util.plusZero(requestMap.getString("dates")), requestMap.getString("luserno"), Util.getIntValue(requestMap.getInt("groupfileNo"),0)
            	iNum = reportMapper.reportInsert(params);
            	Msg = "등록되었습니다.";
            } else if(iNum == 1) {
//            	requestMap.getString("grcode"), requestMap.getString("grseq"), requestMap.getString("subj"), requestMap.getString("classno"), Util.plusZero(requestMap.getString("dates")), requestMap.getString("luserno"), Util.getIntValue(requestMap.getInt("groupfileNo"),0)
            	iNum = reportMapper.reportUpdate(params);
            	Msg = "수정되었습니다.";
            }

        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return Msg;        
	}
}
