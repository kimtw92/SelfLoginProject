package loti.contentsMgr.service;

import java.sql.SQLException;
import java.util.Map;

import loti.contentsMgr.mapper.ContentsMapper;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import ut.lib.exception.BizException;
import ut.lib.page.PageNavigation;
import ut.lib.support.DataMap;
import ut.lib.util.Message;
import ut.lib.util.Util;
import common.service.BaseService;

@Service
public class ContentsService extends BaseService {
	
	@Autowired
	private ContentsMapper contentsMapper;
	
	/**
	 * 과목 리스트.
	 */
	public DataMap selectContentSubjList(DataMap requestMap) throws BizException{
		DataMap resultMap = null;
        
        try {
        	int selectContentSubjListCount = contentsMapper.selectContentSubjListCount(requestMap);

        	Map<String, Object> pageInfo = Util.getPageInfo(selectContentSubjListCount, requestMap);
        	pageInfo.put("searchValue", requestMap.getString("searchValue"));
        	
        	resultMap = contentsMapper.selectContentSubjList(pageInfo);
        	PageNavigation pageNavi = Util.getPageNavigation(pageInfo);
        	
        	resultMap.set("PAGE_INFO", pageNavi);
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return resultMap;        
	}
	
	/**
	 * 강사전용 과목보기 리스트
	 */
	public DataMap selectLecturerList(DataMap requestMap) throws BizException{
		DataMap resultMap = null;
        
        try {
        	int selectLecturerListCount = contentsMapper.selectLecturerListCount(requestMap);
        	
        	Map<String, Object> pageInfo = Util.getPageInfo(selectLecturerListCount, requestMap);
        	pageInfo.put("commGrcode", requestMap.getString("commGrcode"));
        	pageInfo.put("commGrseq", requestMap.getString("commGrseq"));
        	
        	resultMap = contentsMapper.selectLecturerList(pageInfo);
        	PageNavigation pageNavi = Util.getPageNavigation(pageInfo);
        	
        	resultMap.set("PAGE_INFO", pageNavi);
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return resultMap;        
	}
	
	/**
	 * 과목 상세 정보 Row
	 */
	public DataMap selectSubjBySimpleRow(String subj) throws BizException{
		DataMap resultMap = null;
        
        try {
        	resultMap = contentsMapper.selectSubjBySimpleRow(subj);
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return resultMap;        
	}
	
	/**
	 * 과목에 속한 콘텐츠 회차 리스트 (상세 내용)
	 */
	public DataMap selectScormMappingOrgList(Map<String, Object> paramMap) throws BizException{
		DataMap resultMap = null;
        
        try {
        	resultMap = contentsMapper.selectScormMappingOrgList(paramMap);
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return resultMap;        
	}
	
	/**
	 * 과목에 속한 콘텐츠 회차 리스트 (mapping_seq)
	 */
	public DataMap selectScormMappingOrgBySeqKeyList(Map<String, Object> paramMap) throws BizException{
		DataMap resultMap = null;
        
        try {
        	resultMap = contentsMapper.selectScormMappingOrgBySeqKeyList(paramMap);
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return resultMap;        
	}
	
	/**
	 * Lcms 테마 카테고리
	 */
	public DataMap selectLcmsImageCategoryList() throws BizException{
		DataMap resultMap = null;
        
        try {
        	resultMap = contentsMapper.selectLcmsImageCategoryList();
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return resultMap;        
	}
	
	/**
	 * Lcms 카테고리
	 */
	public DataMap selectLcmsCategoryList() throws BizException{
		DataMap resultMap = null;
        
        try {
        	resultMap = contentsMapper.selectLcmsCategoryList();
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return resultMap;        
	}
	
	/**
	 * 콘텐츠 맛보기 설정.
	 */
	public int updateScormMappingOrgByPreviewYn(DataMap requestMap) throws BizException{
		int resultValue = 0;
        
        try {
        	resultValue = contentsMapper.updateScormMappingOrgByPreviewYn(requestMap);
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return resultValue;        
	}
	
	/**
	 * 콘텐츠 회차 삭제
	 */
	public int deleteSubjSeq(Map<String, Object> paramMap) throws BizException{
		int resultValue = 0;
        
        try {
        	resultValue = contentsMapper.deleteSubjSeq(paramMap);
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        
        return resultValue;        
	}
}
