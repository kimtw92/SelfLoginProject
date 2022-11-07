package loti.courseMgr.service;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

import loti.courseMgr.mapper.NoticeMapper;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import ut.lib.exception.BizException;
import ut.lib.page.PageNavigation;
import ut.lib.support.DataMap;
import ut.lib.util.Message;
import ut.lib.util.Util;
import common.service.BaseService;

@Service("courseMgrNoticeService")
public class NoticeService extends BaseService {

	@Autowired
	@Qualifier("courseMgrNoticeMapper")
	private NoticeMapper noticeMapper;
	
	/**
	 * 과정 공지사항 리스트.
	 */
	public DataMap selectGrNoticeList(
						String grCode,			//과정코드
						String grSeq,			//과정 기수
						String searchKey,		//검색 조건
						String searchValue,		//검색어
						DataMap pagingInfoMap //페이지Map
				) throws BizException{
        DataMap resultMap = new DataMap();
        
        try {
        	String whereStr = "";
            
            //검색
            if(!searchValue.equals("")){
            	if(searchKey.equals(""))
            		whereStr += " AND (A.TITLE LIKE '%" + searchValue + "%' OR DBMS_LOB.INSTR(A.CONTENT , '" + searchValue + "') > 0 ) ";
            	else if(searchKey.equals("TITLE"))
            		whereStr += " AND A.TITLE LIKE '%" + searchValue + "%' ";
            	else if(searchKey.equals("CONTENT"))
                	whereStr += " AND DBMS_LOB.INSTR(A.CONTENT , '" + searchValue + "') > 0 ";
            }
            
            Map<String, Object> paramMap = new HashMap<String, Object>();
            paramMap.put("grcode", grCode);
            paramMap.put("grseq", grSeq);
            paramMap.put("whereStr", whereStr);
            
            int grNoticeListCount = noticeMapper.selectGrNoticeListCount(paramMap);
            
            Map<String, Object> pageInfo = Util.getPageInfo(grNoticeListCount, pagingInfoMap);
        	pageInfo.put("grcode", grCode);
			pageInfo.put("grseq", grSeq);
			pageInfo.put("whereStr", whereStr);
			
            resultMap = noticeMapper.selectGrNoticeList(pageInfo);
            
            PageNavigation pageNavi = Util.getPageNavigation(pageInfo);
			
			resultMap.set("PAGE_INFO", pageNavi);
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return resultMap;        
	}
	
	/**
	 * 과정 공지 상세 정보
	 */
	public DataMap selectGrNoticeRow(String grCode, String grSeq, int no) throws BizException{
		DataMap resultMap = new DataMap();
        
        try {
        	Map<String, Object> paramMap = new HashMap<String, Object>();
            paramMap.put("grcode", grCode);
            paramMap.put("grseq", grSeq);
            paramMap.put("no", no);
            
        	resultMap = noticeMapper.selectGrNoticeRow(paramMap);
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return resultMap;
	}
	
	/**
	 * 과정 공지 등록
	 */
	public int insertGrNotice(DataMap requestMap, int groupFileNo, String userNo) throws BizException{
		int resultValue = 0;
        
        try {
        	Map<String, Object> paramMap = new HashMap<String, Object>();
            paramMap.put("grcode", requestMap.getString("commGrcode"));
            paramMap.put("grseq", requestMap.getString("commGrseq"));
            
            int no = noticeMapper.selectGrNoticeMaxNo(paramMap);
            
            paramMap.put("no", no);
            paramMap.put("userno", userNo);
            paramMap.put("title", requestMap.getString("title"));
            paramMap.put("groupfileNo", groupFileNo);
            paramMap.put("namoContent", requestMap.getString("namoContent"));
            
        	resultValue = noticeMapper.insertGrNotice(paramMap);
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return resultValue;
	}
	
	/**
	 * 과정 공지 수정.
	 */
	public int updateGrNotice(DataMap requestMap, int groupFileNo, String userNo) throws BizException{
		int resultValue = 0;
        
        try {
        	Map<String, Object> paramMap = new HashMap<String, Object>();
            paramMap.put("grcode", requestMap.getString("commGrcode"));
            paramMap.put("grseq", requestMap.getString("commGrseq"));
            paramMap.put("no", requestMap.getString("no"));
            paramMap.put("userno", userNo);
            paramMap.put("title", requestMap.getString("title"));
            paramMap.put("groupfileNo", groupFileNo);
            paramMap.put("namoContent", requestMap.getString("namoContent"));
            
        	resultValue = noticeMapper.updateGrNotice(paramMap);
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return resultValue;
	}
	
	/**
	 * 과정 공지 삭제.
	 */
	public int deleteGrNotice(String grCode, String grSeq, int no) throws BizException{
		int resultValue = 0;
        
        try {
        	Map<String, Object> paramMap = new HashMap<String, Object>();
            paramMap.put("grcode", grCode);
            paramMap.put("grseq", grSeq);
            paramMap.put("no", no);
            
        	resultValue = noticeMapper.deleteGrNotice(paramMap);
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        	
        }
        return resultValue;
	}
}
