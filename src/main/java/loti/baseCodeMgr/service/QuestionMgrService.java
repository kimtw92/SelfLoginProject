package loti.baseCodeMgr.service;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import loti.baseCodeMgr.mapper.QuestionMgrMapper;
import loti.baseCodeMgr.mapper.SubjMapper;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import ut.lib.exception.BizException;
import ut.lib.page.PageNavigation;
import ut.lib.support.DataMap;
import ut.lib.util.Message;
import ut.lib.util.Util;

import common.service.BaseService;

@Service
public class QuestionMgrService extends BaseService {

	@Autowired
	private QuestionMgrMapper questionMgrMapper;
	@Autowired
	private SubjMapper subjMapper;
	
	/**
	 * 과목코드별 문항관리 목록 조회
	 */
	public DataMap selectSubjWithQuestionList(DataMap requestMap) throws BizException {
		DataMap resultMap = new DataMap();
		
		try {
			int subjWithQuestionListCount = questionMgrMapper.selectSubjWithQuestionListCount(requestMap);
			
			Map<String, Object> pageInfo = Util.getPageInfo(subjWithQuestionListCount, requestMap);
			pageInfo.put("s_useYn", requestMap.getString("s_useYn"));
        	pageInfo.put("s_subType", requestMap.getString("s_subType"));
        	pageInfo.put("s_searchTxt", requestMap.getString("s_searchTxt"));
			
			resultMap = questionMgrMapper.selectSubjWithQuestionList(pageInfo);
			
			PageNavigation pageNavi = Util.getPageNavigation(pageInfo);
			
			resultMap.set("PAGE_INFO", pageNavi);
		} catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
		
		return resultMap;
	}
	
	/**
	 * 과목코드별 문항관리 목록 인덱스 사용 조회
	 */
	public DataMap selectSubjWithQuestionByIndex(DataMap requestMap) throws BizException {
		DataMap resultMap = new DataMap();
		
		try {
			int subjWithQuestionByIndexCount = questionMgrMapper.selectSubjWithQuestionByIndexCount(requestMap);
			
			Map<String, Object> pageInfo = Util.getPageInfo(subjWithQuestionByIndexCount, requestMap);
			pageInfo.put("s_indexSeq", requestMap.getString("s_indexSeq"));
        	pageInfo.put("s_useYn", requestMap.getString("s_useYn"));
        	pageInfo.put("s_subType", requestMap.getString("s_subType"));
        	pageInfo.put("s_searchTxt", requestMap.getString("s_searchTxt"));
			
			resultMap = questionMgrMapper.selectSubjWithQuestionByIndex(pageInfo);
			
			PageNavigation pageNavi = Util.getPageNavigation(pageInfo);
			
			resultMap.set("PAGE_INFO", pageNavi);
		} catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
		
		return resultMap;
	}
	
	public DataMap selectQuestionListBySubj(DataMap requestMap) throws BizException {
		DataMap resultMap = new DataMap();
		
		try {
			int questionListBySubjCount = questionMgrMapper.selectQuestionListBySubjCount(requestMap);
			
			Map<String, Object> pageInfo = Util.getPageInfo(questionListBySubjCount, requestMap);
			pageInfo.put("subj", requestMap.getString("subj"));
			pageInfo.put("s_difficulty", requestMap.getString("s_difficulty"));
			pageInfo.put("s_useYn", requestMap.getString("s_useYn"));
			pageInfo.put("s_qType", requestMap.getString("s_qType"));
			pageInfo.put("s_searchType", requestMap.getString("s_searchType"));
			pageInfo.put("s_searchTxt", requestMap.getString("s_searchTxt"));
			
			resultMap = questionMgrMapper.selectQuestionListBySubj(pageInfo);
			
			PageNavigation pageNavi = Util.getPageNavigation(pageInfo);
			
			resultMap.set("PAGE_INFO", pageNavi);
		} catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
		
		return resultMap;
	}
	
	public DataMap selectQuestionExcelBySubj(DataMap requestMap) throws BizException {
		DataMap resultMap = new DataMap();
		
		try {
			resultMap = questionMgrMapper.selectQuestionExcelBySubj(requestMap);
		} catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
		
		return resultMap;
	}
	
	public int updateUseYn(DataMap requestMap) throws BizException {
		int result = 0;
		
		try {
			ArrayList<String> collectionList = new ArrayList<String>();
			for(int i=0; i<requestMap.keySize("qtId[]"); i++) {
				collectionList.add(requestMap.getString("qtId[]", i));
			}
			
			if (collectionList.size() > 0) {
				Map<String, Object>paramMap = new HashMap<String, Object>();
				paramMap.put("list", collectionList);
				paramMap.put("useYn", requestMap.getString("qu"));
				result = questionMgrMapper.updateUseYn(paramMap);
			}
		} catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
		
		return result;
	}
	
	public int deleteQuestion(DataMap requestMap) throws BizException {
		int result = 0;
		
		try {
			ArrayList<String> collectionList = new ArrayList<String>();
			for(int i=0; i<requestMap.keySize("qtId[]"); i++) {
				collectionList.add(requestMap.getString("qtId[]", i));
			}
			
			if (collectionList.size() > 0) {
				Map<String, Object>paramMap = new HashMap<String, Object>();
				paramMap.put("list", collectionList);
				paramMap.put("useYn", requestMap.getString("qu"));
				result = questionMgrMapper.deleteQuestion(paramMap);
			}
		} catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
		
		return result;
	}
	
	public DataMap selectChapter(String subj) throws BizException {
		DataMap resultMap = new DataMap();
		
		try {
			resultMap = questionMgrMapper.selectChapter(subj);
		} catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
		
		return resultMap;
	}
	
	public int insertChapter(Map<String, Object> paramMap) throws BizException {
		int result = 0;
		
		try {
			result = questionMgrMapper.insertChapter(paramMap);
		} catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
		
		return result;
	}

	public int insertQuestion(Map<String, Object> paramMap) throws BizException {
		int result = 0;
		
		try {
			result = questionMgrMapper.insertQuestion(paramMap);
		} catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
		
		return result;
	}

	public DataMap selectQuestion(String idQ) throws BizException {
		DataMap resultMap = new DataMap();
		
		try {
			resultMap = questionMgrMapper.selectQuestion(idQ);
		} catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
		
		return resultMap;
	}

	public int updateQuestion(Map<String, Object> paramMap) throws BizException {
		int result = 0;
		
		try {
			result = questionMgrMapper.updateQuestion(paramMap);
		} catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
		
		return result;
	}

	public int insertQForOff(Map<String, Object> paramMap) throws BizException {
		int result = 0;
		
		try {
			result = questionMgrMapper.insertQForOff(paramMap);
		} catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
		
		return result;
	}

	public String selectIdChapterFromDual(String idCompany) throws BizException {
		String result = "";
		
		try {
			result = questionMgrMapper.selectIdChapterFromDual(idCompany);
		} catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
		
		return result;
	}

	public int insertChapter2(Map<String, Object> paramMap) throws BizException {
		int result = 0;
		
		try {
			result = questionMgrMapper.insertChapter2(paramMap);
		} catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
		
		return result;
	}

	public DataMap selectChapter2(String idChapter) throws BizException {
		DataMap resultMap = new DataMap();
		
		try {
			resultMap = questionMgrMapper.selectChapter2(idChapter);
		} catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
		
		return resultMap;
	}

	public int deleteQuestion2(Map<String, Object> paramMap) throws BizException {
		int result = 0;
		
		try {
			result = questionMgrMapper.deleteQuestion2(paramMap);
		} catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
		
		return result;
	}

	public String serializeAns(List<String> anses, String separator){
		
		StringBuilder sb = new StringBuilder();
		
		boolean isFirst = true;
		
		for(String ans : anses){
			if(!isFirst){
				sb.append(separator);
			}
			sb.append(ans);
			if(isFirst) isFirst = false;
		}
		
		return sb.toString();
	}
	
	public int updateErrorQuestion(DataMap requestMap) throws BizException {
		
		List<String> anses = new ArrayList<String>();
		
		for(int i=0; i<requestMap.keySize("ca"); i++){
			anses.add(requestMap.getString("ca", i));
		}
		
		requestMap.setString("ca", serializeAns(anses, "{^}"));
		
		try {
			return questionMgrMapper.updateErrorQuestion(requestMap);
		} catch (SQLException e) {
			 throw new BizException(Message.getKey(e), e);
        }
	}
}
