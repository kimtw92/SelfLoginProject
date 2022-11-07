package loti.courseMgr.service;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

import loti.courseMgr.mapper.DiscussMapper;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import ut.lib.exception.BizException;
import ut.lib.file.FileUtil;
import ut.lib.page.PageNavigation;
import ut.lib.support.DataMap;
import ut.lib.util.Message;
import ut.lib.util.StringReplace;
import ut.lib.util.Util;
import common.service.BaseService;

@Service
public class DiscussService extends BaseService {

	@Autowired
	private DiscussMapper discussMapper;
	
	/**
	 * 과정 공지사항 상위글 리스트
	 */
	public DataMap selectGrDiscussTopList(String grcode, String grseq) throws BizException{
		DataMap resultMap = new DataMap();
        
        try {
        	Map<String, Object> paramMap = new HashMap<String, Object>();
        	paramMap.put("grcode", grcode);
        	paramMap.put("grseq", grseq);
        	
        	resultMap = discussMapper.selectGrDiscussTopList(paramMap);
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return resultMap;
	}
	
	/**
	 * 과정 공지사항 리스트.
	 */
	public DataMap selectGrDiscussBySearchList(String grcode, String grseq, String searchKey, String searchValue,	DataMap requestMap) throws BizException{
		DataMap resultMap = new DataMap();
        
        try {
        	String whereStr = "";
            
            //검색
            if(!searchValue.equals("")){
            	if(searchKey.equals(""))
            		whereStr += " AND (T.TITLE LIKE '%" + searchValue + "%' OR DBMS_LOB.INSTR(T.CONTENT , '" + searchValue + "') > 0 ) ";
            	else if(searchKey.equals("TITLE"))
            		whereStr += " AND T.TITLE LIKE '%" + searchValue + "%' ";
            	else if(searchKey.equals("CONTENT"))
                	whereStr += " AND DBMS_LOB.INSTR(T.CONTENT , '" + searchValue + "') > 0 ";
            }
            
            Map<String, Object> paramMap = new HashMap<String, Object>();
        	paramMap.put("grcode", grcode);
        	paramMap.put("grseq", grseq);
        	paramMap.put("whereStr", whereStr);
        	
        	int grDiscussBySearchListCount = discussMapper.selectGrDiscussBySearchListCount(paramMap);
        	
        	Map<String, Object> pageInfo = Util.getPageInfo(grDiscussBySearchListCount, requestMap);
        	pageInfo.put("grcode", grcode);
			pageInfo.put("grseq", grseq);
			pageInfo.put("whereStr", whereStr);
        	
            resultMap = discussMapper.selectGrDiscussBySearchList(pageInfo);
            
            PageNavigation pageNavi = Util.getPageNavigation(pageInfo);
			
			resultMap.set("PAGE_INFO", pageNavi);
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return resultMap;
	}
	
	/**
	 * 과정 토론방 상세 정보.
	 */
	public DataMap selectGrDiscussRow(String grcode, String grseq, int seq) throws BizException{
		DataMap resultMap = new DataMap();
        
        try {
        	Map<String, Object> paramMap = new HashMap<String, Object>();
        	paramMap.put("grcode", grcode);
        	paramMap.put("grseq", grseq);
        	paramMap.put("seq", seq);
        	
        	resultMap = discussMapper.selectGrDiscussRow(paramMap);
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return resultMap;
	}
	
	/**
	 * 토론글 삭제.
	 */
	public int deleteGrDiscuss(String grcode, String grseq, int seq) throws BizException{
		int resultValue = 0;
		Map<String, Object> paramMap = null;
        
        try {
        	//글정보 추출
        	paramMap = new HashMap<String, Object>();
        	paramMap.put("grcode", grcode);
        	paramMap.put("grseq", grseq);
        	paramMap.put("seq", seq);
        	
            DataMap rowMap = discussMapper.selectGrDiscussRow(paramMap);
            if(rowMap == null) rowMap = new DataMap();
            rowMap.setNullToInitialize(true);
            
            //하위글 여부 확인.     
            float step = Float.parseFloat(rowMap.getString("step"));
            float lowStep = 0;
            if(rowMap.getInt("depth") == 0 )
            	lowStep = step - 1;
            else
            	lowStep = (float)Math.floor(step);
            
            paramMap.put("lowStep", lowStep);
        	paramMap.put("highStep", step);
            int tmpResult = discussMapper.selectGrDiscussReplyCheck(paramMap);
            
            	
            //하위글이 있으면 삭제하지 않고 '삭제된 글'이라고 표기한다.
            if(tmpResult > 0)
            	resultValue = discussMapper.updateGrDiscussByDelete(paramMap);
            else
            	resultValue = discussMapper.deleteGrDiscuss(paramMap);
            
            //파일 삭제.
            if(rowMap.getInt("groupfileNo") > 0) {
            	try {
            		FileUtil.commonDeleteGroupfile(rowMap.getInt("groupfileNo"));
            	} catch(Exception e) {
            		throw new BizException(e);
            	} finally {
            		
            	}
            }
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return resultValue;
	}
	
	/**
	 * 과정 토론 등록
	 */
	public int insertGrDiscuss(DataMap requestMap, int groupFileNo) throws BizException{
		int resultValue = 0;
        
        try {
        	int seq = discussMapper.selectGrDiscussMaxSeq();
        	
        	Map<String, Object> paramMap = new HashMap<String, Object>();
        	paramMap.put("grcode", requestMap.getString("grcode"));
        	paramMap.put("grseq", requestMap.getString("grseq"));
        	paramMap.put("seq", seq);
			if(requestMap.getString("topRank").equals("Y"))
				paramMap.put("topRank", seq);
			else
				paramMap.put("topRank", java.sql.Types.NUMERIC);
			paramMap.put("wuserno", requestMap.getString("wuserno"));
			paramMap.put("title", requestMap.getString("title"));
			paramMap.put("groupFileNo", groupFileNo);
			paramMap.put("ip", requestMap.getString("ip"));
			paramMap.put("namoContent", requestMap.getString("namoContent"));
			paramMap.put("username", requestMap.getString("username"));
        	
        	resultValue = discussMapper.insertGrDiscuss(paramMap);
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return resultValue;
	}
	
	/**
	 * 과정 토론방 수정
	 */
	public int updateGrDiscuss(DataMap requestMap, int groupFileNo) throws BizException{
		int resultValue = 0;
        
        try {
        	Map<String, Object> paramMap = new HashMap<String, Object>();
        	paramMap.put("title", requestMap.getString("title"));
        	paramMap.put("namoContent", requestMap.getString("namoContent"));
        	paramMap.put("groupFileNo", groupFileNo);
        	paramMap.put("ip", requestMap.getString("ip"));
        	paramMap.put("username", requestMap.getString("username"));
        	if(requestMap.getString("topRank").equals("Y"))
				paramMap.put("topRank", requestMap.getInt("seq"));
			else
				paramMap.put("topRank", java.sql.Types.NUMERIC);
        	
        	paramMap.put("grcode", requestMap.getString("grcode"));
        	paramMap.put("grseq", requestMap.getString("grseq"));
        	paramMap.put("seq", requestMap.getInt("seq"));
			
        	resultValue = discussMapper.updateGrDiscuss(paramMap);
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return resultValue;
	}
	
	/**
	 * 답변 등록
	 */
	public int insertGrDiscussByReply(DataMap requestMap, int groupFileNo) throws BizException{
		int resultValue = 0;
        
        try {
        	//글정보 추출
        	Map<String, Object> paramMap = new HashMap<String, Object>();
        	paramMap.put("grcode", requestMap.getString("grcode"));
        	paramMap.put("grseq", requestMap.getString("grseq"));
        	paramMap.put("seq", requestMap.getInt("pseq"));
        	
            DataMap rowMap = discussMapper.selectGrDiscussRow(paramMap);
            if(rowMap == null) rowMap = new DataMap();
            rowMap.setNullToInitialize(true);
            
            int depth = rowMap.getInt("depth") + 1;
            double step = Double.parseDouble(rowMap.getString("step"));
            
            double from = step - Math.pow(0.01, depth);
            
            String fromStr = Double.toString(from);
            double to = Double.parseDouble(  StringReplace.subString(fromStr, 0, fromStr.length()-2) );
            
            paramMap.put("depth", depth);
            paramMap.put("step1", from);
            paramMap.put("step2", to);
            double result = discussMapper.selectGrDiscussReplyCheck2(paramMap);
            if(result == 0.0)
            	step = from;
            else
            	step = result - Math.pow(0.01, depth);
            requestMap.setString("depth", "" + depth);
            requestMap.setString("step", "" + step);
            
            int seq = discussMapper.selectGrDiscussMaxSeq();
            
            //등록.
            paramMap = new HashMap<String, Object>();
            paramMap.put("grcode", requestMap.getString("grcode"));
            paramMap.put("grseq", requestMap.getString("grseq"));
            paramMap.put("seq", seq);
            paramMap.put("wuserno", requestMap.getString("wuserno"));
            paramMap.put("title", requestMap.getString("title"));
            paramMap.put("step", Double.parseDouble(requestMap.getString("step")));
            paramMap.put("depth", requestMap.getInt("depth"));
            paramMap.put("groupFileNo", groupFileNo);
            paramMap.put("ip", requestMap.getString("ip"));
            paramMap.put("namoContent", requestMap.getString("namoContent"));
            paramMap.put("username", requestMap.getString("username"));
            
            resultValue = discussMapper.insertGrDiscussByReply(paramMap);
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return resultValue;
	}
}
