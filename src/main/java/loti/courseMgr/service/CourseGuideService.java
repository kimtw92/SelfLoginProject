package loti.courseMgr.service;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

import loti.courseMgr.mapper.CourseGuideMapper;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import ut.lib.exception.BizException;
import ut.lib.page.PageNavigation;
import ut.lib.support.DataMap;
import ut.lib.util.Message;
import ut.lib.util.Util;
import common.service.BaseService;

@Service
public class CourseGuideService extends BaseService {

	@Autowired
	private CourseGuideMapper courseGuideMapper;
	
	/**
	 * 과정 안내문 리스트
	 */
	public DataMap selectGrGuideList(String year, String grcode, DataMap requestMap) throws BizException{
		DataMap resultMap = new DataMap();
        
        try {
        	StringBuffer sb = new StringBuffer();
        	sb.append(year).append("__");
        	
        	Map<String, Object> paramMap = new HashMap<String, Object>();
        	paramMap.put("year", sb.toString());
        	paramMap.put("grcode", grcode);
        	
        	int grGuideListCount = courseGuideMapper.selectGrGuideListCount(paramMap);
        	
        	Map<String, Object> pageInfo = Util.getPageInfo(grGuideListCount, requestMap);
        	pageInfo.put("year", sb.toString());
			pageInfo.put("grcode", grcode);
        	
        	resultMap = courseGuideMapper.selectGrGuideList(pageInfo);
        	
        	PageNavigation pageNavi = Util.getPageNavigation(pageInfo);
			
			resultMap.set("PAGE_INFO", pageNavi);
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return resultMap;
	}
	
	/**
	 * 반의 과목코드 가져오기.
	 */
	public DataMap selectSubjClassByMaxClassNoList(String grcode, String grseq) throws BizException{
		DataMap resultMap = new DataMap();
        
        try {
        	Map<String, Object> paramMap = new HashMap<String, Object>();
        	paramMap.put("grcode", grcode);
        	paramMap.put("grseq", grseq);
        	
        	resultMap = courseGuideMapper.selectSubjClassByMaxClassNoList(paramMap);
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return resultMap;
	}
	
	/**
	 * 과정 안내문 미리보기 정보
	 */
	public DataMap selectGrGuideRow(String grcode, String grseq, String guideTitle) throws BizException{
		DataMap resultMap = new DataMap();
        
        try {
        	Map<String, Object> paramMap = new HashMap<String, Object>();
        	paramMap.put("grcode", grcode);
        	paramMap.put("grseq", grseq);
        	paramMap.put("guideTitle", guideTitle);
        	
        	resultMap = courseGuideMapper.selectGrGuideRow(paramMap);
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return resultMap;
	}
	
	/**
	 * 과정 안내문 기수 있는지 확인.
	 */
	public int selectGrGuideChk(String grcode, String grseq, String guideTitle) throws BizException{
		int resultValue = 0;
        
        try {
        	Map<String, Object> paramMap = new HashMap<String, Object>();
        	paramMap.put("grcode", grcode);
        	paramMap.put("grseq", grseq);
        	paramMap.put("guideTitle", guideTitle);
        	
        	resultValue = courseGuideMapper.selectGrGuideChk(paramMap);
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return resultValue;
	}
	
	
	/**
	 * 과정 안내문의 Max grseq 값 구하기
	 */
	public String selectGrGuideMaxGrseq(String year, String grcode) throws BizException{
		String resultValue = "";
        
        try {
        	Map<String, Object> paramMap = new HashMap<String, Object>();
        	paramMap.put("year", year);
        	paramMap.put("grcode", grcode);
        	
        	resultValue = courseGuideMapper.selectGrGuideMaxGrseq(paramMap);
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return resultValue;
	}
	
	/**
	 * 과정 안내문 수정
	 */
	public int updateGrGuide(DataMap requestMap) throws BizException{
		int resultValue = 0;
        
        try {
        	//수정 
            resultValue = courseGuideMapper.updateGrGuide(requestMap);
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return resultValue;
	}
	
	/**
	 * 과정 안내문 등록
	 */
	public int insertGrGuide(DataMap requestMap) throws BizException{
		int resultValue = 0;
        
        try {
        	//이미 등록되어있는지 확인.
        	Map<String, Object> paramMap = new HashMap<String, Object>();
        	paramMap.put("grcode", requestMap.getString("commGrcode"));
        	paramMap.put("grseq", requestMap.getString("commGrseq"));
        	paramMap.put("guideTitle", requestMap.getString("guideTitle"));
        	
            int tmpResult =  courseGuideMapper.selectGrGuideChk(paramMap);
            if(tmpResult > 0)
            	resultValue = -1;
            else
            	resultValue = courseGuideMapper.insertGrGuide(requestMap); //등
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return resultValue;
	}
	
	/**
	 * 과정 안내문 삭제
	 */
	public int deleteGrGuide(String grcode, String grseq, String guideTitle) throws BizException{
		int resultValue = 0;
        
        try {
        	Map<String, Object> paramMap = new HashMap<String, Object>();
        	paramMap.put("grcode", grcode);
        	paramMap.put("grseq", grseq);
        	paramMap.put("guideTitle", guideTitle);
        	
        	//삭제
            resultValue = courseGuideMapper.deleteGrGuide(paramMap);
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return resultValue;
	}
	
	/**
	 * 과정안내문 관리 - 교과목 편성시간 및 강사
	 */
	public DataMap selectCourseGuideBySubjTutorList(String grcode, String grseq) throws BizException{
		DataMap resultMap = new DataMap();
        
        try {
        	Map<String, Object> paramMap = new HashMap<String, Object>();
        	paramMap.put("grcode", grcode);
        	paramMap.put("grseq", grseq);
        	
        	resultMap = courseGuideMapper.selectCourseGuideBySubjTutorList(paramMap);
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return resultMap;
	}
}
