package loti.courseMgr.service;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

import loti.courseMgr.mapper.LectureApplyMapper;
import loti.courseMgr.mapper.StuOutMapper;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import ut.lib.exception.BizException;
import ut.lib.support.DataMap;
import ut.lib.util.Message;
import common.service.BaseService;

@Service("courseMgrStuOutService")
public class StuOutService extends BaseService {

	@Autowired
	@Qualifier("courseMgrStuOutMapper")
	private StuOutMapper stuOutMapper;
	@Autowired
	private LectureApplyMapper lectureApplyMapper;
	
	/**
	 * 퇴교자 리스트.
	 */
	public DataMap selectAppRejectList(String grcode, String grseq) throws BizException{
		DataMap resultMap = new DataMap();
        
        try {
        	Map<String, Object> paramMap = new HashMap<String, Object>();
        	paramMap.put("grcode", grcode);
        	paramMap.put("grseq", grseq);
        	
        	resultMap = stuOutMapper.selectAppRejectList(paramMap);
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return resultMap;
	}
	
	/**
	 * 퇴교자 취소 상세정보
	 */
	public DataMap selectAppRejectRow(String grcode, String grseq, String userno) throws BizException{
		DataMap resultMap = new DataMap();
        
        try {
        	Map<String, Object> paramMap = new HashMap<String, Object>();
        	paramMap.put("grcode", grcode);
        	paramMap.put("grseq", grseq);
        	paramMap.put("userno", userno);
        	
        	resultMap = stuOutMapper.selectAppRejectRow(paramMap);
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return resultMap;
	}
	
	/**
	 * 수강신청자 정보 이름 검색 리스트
	 */
	public DataMap selectAppInfoByNameSearchList(String grcode, String grseq, String searchName) throws BizException{
		DataMap resultMap = new DataMap();
        
        try {
        	Map<String, Object> paramMap = new HashMap<String, Object>();
        	paramMap.put("grcode", grcode);
        	paramMap.put("grseq", grseq);
        	paramMap.put("searchName", searchName);
        	
        	resultMap = stuOutMapper.selectAppInfoByNameSearchList(paramMap);
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return resultMap;
	}
	
	/**
	 * 과정 수료 인원 count (개인)
	 */
	public int selectGrResultChk(String grcode, String grseq, String userno) throws BizException{
		int resultValue = 0;
        
        try {
        	Map<String, Object> paramMap = new HashMap<String, Object>();
        	paramMap.put("grcode", grcode);
        	paramMap.put("grseq", grseq);
        	paramMap.put("userno", userno);
        	
        	resultValue = stuOutMapper.selectGrResultChk(paramMap);
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return resultValue;
	}
	
	/**
	 * 퇴교 조치.
	 */
	public int execInsertAppReject(DataMap requestMap) throws BizException{
		int resultValue = 0;
        
        try {
        	//퇴교자 등록
            stuOutMapper.insertAppRejectSpec(requestMap);
                                
            //퇴교자 수강 정보 백업
            stuOutMapper.insertRejStuLecSpec(requestMap);
            
            //퇴교자 과제 제출 백업
            stuOutMapper.insertRejReportSubmitSpec(requestMap);
            
            //퇴교자 - 과목별 시험채점결과정보 백업
            stuOutMapper.insertRejExresultSpec(requestMap);   
            
            //과목별 시험채점결과정보 삭제
            stuOutMapper.deleteExResultSpec(requestMap); 
    
            //리포트 제출 정보 삭제
            stuOutMapper.deleteReportSubmitSpec(requestMap);
            
            //과목수강정보 삭제
            stuOutMapper.deleteStuLecSpec(requestMap);
            
            //수강신청 정보 변경. (grchk = 'C')
            DataMap lecMap = new DataMap();
			lecMap.setString("grchk", "C");
			lecMap.setString("luserno", requestMap.getString("luserno"));
            lecMap.setString("grcode", requestMap.getString("grcode"));
            lecMap.setString("grseq", requestMap.getString("grseq"));
            lecMap.setString("userno", requestMap.getString("userno"));
            lectureApplyMapper.updateAppInfoGrChk(lecMap);
            
            resultValue++;
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return resultValue;
	}
	
	
	/**
	 * 퇴교자 정보 완전 삭제.
	 */
	public int execDeleteAppReject(DataMap requestMap) throws BizException{
		int resultValue = 0;
        
        try {
        	//퇴교처리 저장된 로그파일 삭제
            stuOutMapper.deleteAppReject(requestMap);
            
            //퇴교자 - 과목별 시험채점결과정보 삭제
            stuOutMapper.deleteRejExResultSpec(requestMap);
         
            //퇴교자 - 리포트 제출 정보 삭제
            stuOutMapper.deleteRejReportSubmitSpec(requestMap);
            
            //퇴교자 - 과목수강정보 삭제
            stuOutMapper.deleteRejStuLecSpec(requestMap);
           
            //수강신청 정보 삭제
            stuOutMapper.deleteAppInfo(requestMap);
            
            resultValue++;
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return resultValue;
	}
	
	
	/**
	 * 퇴소자 복원처리
	 */
	public int execReturnAppReject(DataMap requestMap) throws BizException{
		int resultValue = 0;
        
        try {
        	//퇴교처리 저장된 로그파일 삭제
            stuOutMapper.deleteAppReject(requestMap);
            
            //수강신청 정보 등록 (퇴소 테이블에서)
            stuOutMapper.insertStuLecByRejSpec(requestMap); 
            
            //수강생의 과제 등록 (퇴소 테이블에서)
            stuOutMapper.insertReportSubmitByRejSpec(requestMap); 
            
            //수강생의 과제 등록 (퇴소 테이블에서)
            stuOutMapper.insertExResultByRejSpec(requestMap); 
            
            //퇴교자 - 과목별 시험채점결과정보 삭제
            stuOutMapper.deleteRejExResultSpec(requestMap);
         
            //퇴교자 - 리포트 제출 정보 삭제
            stuOutMapper.deleteRejReportSubmitSpec(requestMap);
            
            //퇴교자 - 과목수강정보 삭제
            stuOutMapper.deleteRejStuLecSpec(requestMap);
           
            //수강신청 정보 변경. (grchk = 'Y')
            DataMap lecMap = new DataMap();
			lecMap.setString("grchk", "Y");
			lecMap.setString("luserno", requestMap.getString("luserno"));
            lecMap.setString("grcode", requestMap.getString("grcode"));
            lecMap.setString("grseq", requestMap.getString("grseq"));
            lecMap.setString("userno", requestMap.getString("userno"));
            lectureApplyMapper.updateAppInfoGrChk(lecMap);
            
            resultValue++;
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return resultValue;
	}
}
