package loti.homeFront.service;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import loti.homeFront.mapper.SupportMapper;
import loti.homepageMgr.mapper.BoardMapper;
import loti.mypage.mapper.MyClassMapper;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import ut.lib.exception.BizException;
import ut.lib.page.PageFactory;
import ut.lib.page.PageInfo;
import ut.lib.page.PageNavigation;
import ut.lib.support.DataMap;
import ut.lib.util.Constants;
import ut.lib.util.Message;
import ut.lib.util.Util;

import common.RegExpUtil;
import common.service.BaseService;

@Service
public class SupportService extends BaseService {

	@Autowired
	private SupportMapper supportMapper;
	
	@Autowired
	private BoardMapper boardMapper;

	@Autowired
	private MyClassMapper myclassmapper;
	
	public DataMap memberView(String sessUserId) throws BizException {
		
		DataMap resultMap = null;
        
        try {
        	
            /**
             * 공지사항 검색조건 설정
             */
            resultMap = supportMapper.memberView(sessUserId);
                                    
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return resultMap;  
	}

	public DataMap boardList(String tableName, DataMap requestMap) throws BizException {

		DataMap resultMap = null;
        
        try {
        	
            /**
             * 공지사항 검색조건 설정
             */
            String stringWhere = "";
            String key = requestMap.getString("key");
            String search = requestMap.getString("search");
            
            if (!key.equals("")){
            	if (key.equals("title")){
            		stringWhere = "AND " + key + " like '%"+search+"%' ";
            	} else if (key.equals("username")){
            		stringWhere = "AND " + key + " = '"+search+"' ";
            	} else if (key.equals("content")){
            		stringWhere = "AND DBMS_LOB.INSTR( " + key + ", '" +search+ "%' )>0 ";
            	}
            }
            
            Map<String,Object> params = new HashMap<String, Object>();
            
            params.put("TABLE_NAME", tableName);
            params.put("SEARCH_STRING", stringWhere);
            
            int totalCnt = supportMapper.boardListCount(params);
        	
            params.putAll(Util.getPageInfo(totalCnt, requestMap));
            
            resultMap = supportMapper.boardList(params);
            
        	/**
        	 * 페이징 필수
        	 */
        	PageInfo pi = new PageInfo(totalCnt, Util.parseInt(params.get("rowSize")+"",0), 0, Util.parseInt(params.get("currPage")+"", 0));

           	PageNavigation pageNavi = PageFactory.getInstance(Constants.DEFAULT_PAGE_CLASS, pi);
        				
           	resultMap.set("PAGE_INFO", pageNavi);
                                    
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return resultMap; 
	}

	public int selectBbsBoardCount(String query) throws BizException {

	    int returnValue = 0;
	    
	    try {
	        returnValue = boardMapper.selectBbsBoardCount(query);
	    } catch (SQLException e) {
	        throw new BizException(Message.getKey(e), e);
	    } finally {
	    }
	    return returnValue;   
	}

	public void updateBbsBoardVisit(int visit, String tableName, String seq) throws BizException {

	    try {

	    	Map<String, Object> params = new HashMap<String, Object>();
	    	
	    	params.put("visit", visit+1);
	    	params.put("tableName", tableName);
	    	params.put("seq", seq);
	    	
	    	boardMapper.updateBbsBoardVisit(params);
	    } catch (SQLException e) {
	        throw new BizException(Message.getKey(e), e);
	    } finally {
	    }
	}

	public DataMap selectbbsBoardView(String boardId, String seq) throws BizException {

		DataMap resultMap = null;
	    
	    try {

	    	Map<String,Object> params = new HashMap<String, Object>();
	    	
	    	params.put("boardId", boardId);
	    	params.put("seq", seq);
	    	
	        //게시판아이디가 카풀, 법률/조례, 게시판관리, 게시판권한관리중 하나이면 전화번호, 주소 조회하지 않는다.
	        if("CARPOOL".equals(boardId) || "LAWS".equals(boardId) || "MNGER".equals(boardId) || "MNGER_AUTH".equals(boardId)) {
	        	resultMap = boardMapper.selectbbsBoardViewWithoutPhoneAndAddr(params);
	        //전화번호, 주소 조회하는 경우
	        }else if("QNA".equals(boardId)) {
	        	resultMap = boardMapper.selectbbsBoardViewQna(params);
//	        	stringQuery = "SELECT decode(depth,0,to_char(wuserno),(select max(wuserno) from TB_BOARD_QNA a where a.seq = round(b.step,1))) topuserno, SEQ, TOP_RANK, (SELECT USER_ID FROM TB_MEMBER WHERE USERNO = WUSERNO) " +
//				  "USER_ID, WUSERNO, USERNAME, PASSWD, EMAIL, REGDATE, TITLE, STEP, DEPTH, VISIT, " +
//				  "GROUPFILE_NO, REMOTE_IP, CONTENT, PHONE, POST1, POST2, ADDR FROM TB_BOARD_"+boardId +" b WHERE SEQ ='"+seq+"'";	        	
	        } else if("EPILOGUE".equals(boardId)){
	        	resultMap = boardMapper.selectbbsBoardViewWithEpilogue(params);
	        }else {
	        	resultMap = boardMapper.selectbbsBoardViewWithPhoneAndAddr(params);
	        }
	        
	        
	    } catch (SQLException e) {
	        throw new BizException(Message.getKey(e), e);
	    } finally {
	    }
	    return resultMap;  
	}

	public int selectBbsBoardCountBetweenStep(String boardId, double step, double minSetp) throws SQLException {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("boardId", boardId);
		params.put("step", step);
		params.put("minSetp", minSetp);
		return boardMapper.selectBbsBoardCountBetweenStep(params);
	}

	@Transactional
	public int deleteBbsBoard(DataMap requestMap) throws BizException {

    	int returnvalue = 0;
    	//테이블 네임
    	String talbeName = "";
    	
    	int count = Integer.parseInt(requestMap.getString("count"));
    	
	    try {
	    	
	    	if(count == 0){
	    		//하위글이 없을경우
	    		talbeName = "DELETE FROM TB_BOARD_"+ requestMap.getString("boardId") + " WHERE SEQ= " + requestMap.getString("seq");
	    	}else{
	    		//하위글이 있을경우
	    		talbeName = "UPDATE TB_BOARD_"+ requestMap.getString("boardId") + " SET TITLE='삭제된 글입니다', CONTENT= '삭제된 글입니다', GROUPFILE_NO='-2' WHERE SEQ=" + requestMap.getString("seq");
	    		//talbeName +="AND WUSERNO =" + requestMap.getString("sessNo");
	    	}
	    	
	    	boardMapper.deleteBbsBoard(talbeName);
	    	
	    } catch (SQLException e) {
	        throw new BizException(Message.getKey(e), e);
	    } finally {
	    }
	    return returnvalue; 
	}

	public int insertBbsBoard(DataMap requestMap) throws BizException {

	    int returnValue = 0;
	    
	    try {
	    	Map<String,Object> params = Util.getMapOfDataMapIdxZero(requestMap);
	    	params.put("seq", Integer.valueOf(params.get("seq")+""));
	    	params.put("title", RegExpUtil.replacePattern(requestMap.getString("title"), RegExpUtil.HTML_PATTERN));
			
			params.put("visit", 0);
			String namoContent = (params.get("namoContent")+"").replaceAll("script", "스크립트").replaceAll("/script", "/스크립트").replaceAll("css", "씨에스에스").replaceAll("/css", "/씨에스에스");
			params.put("namoContent", namoContent);
			
			if(params.get("boardId").equals("EPILOGUE")){
				String selectGrcode = (String)params.get("selectGrcode");
				String [] gr_arr = selectGrcode.split("[|]");
				params.put("pGrcode", gr_arr[0]);
				params.put("pGrseq", gr_arr[1]);
				params.put("pGrcodeNiknm", gr_arr[2]);
			}
			
	        returnValue = supportMapper.insertBbsBoard(params);
	    } catch (SQLException e) {
	        throw new BizException(Message.getKey(e), e);
	    } finally {
	    }
	    return returnValue; 
	}

	public int modifyBbsBoard(String boardId, String title, String namoContent, int seq, int fileGroupNo) throws BizException {

	    int returnValue = 0;
	    
	    try {
	    	
  		    Map<String,Object> params = new HashMap<String, Object>();
  		    
  		    params.put("tableName", "TB_BOARD_"+boardId);
  		    params.put("title", title);
  		    params.put("namoContent", namoContent);
  		    params.put("seq", seq);
  		    params.put("fileGroupNo", fileGroupNo);
  		    
	        returnValue = boardMapper.modifyBbsBoard(params);
	    } catch (SQLException e) {
	        throw new BizException(Message.getKey(e), e);
	    } finally {
	    }
	    return returnValue;  
	}

	public double selectBbsBoardMinNoRow(String tableName, double step, double minSetp, int depth) throws BizException {
    	
		double resultValue = 0;
    	try {
    		
    		Map<String, Object> params = new HashMap<String, Object>();
    		
    		params.put("tableName", tableName);
    		params.put("step", step);
    		params.put("minSetp", minSetp);
    		params.put("depth", depth);
    		
    		resultValue = boardMapper.selectBbsBoardMinNoRow(params);
    		
    	}catch(SQLException e){ 
    		throw new BizException(Message.getKey(e),e);
    	}finally {
        }
    	  return resultValue;
	}
	
	// ---------------------------------------------------------------------------------------------------------------------------------
	

	public int selectResNoCnt(String resno) throws Exception{
		
	    int resultMap = 0;
	    
	    try {
	    	
	        resultMap = supportMapper.selectResNoCnt(resno);
	        
	    } catch (SQLException e) {
	        throw new BizException(Message.getKey(e), e);
	    } finally {
	    }
	    return resultMap;        
	}
	
	public DataMap selectFaqList(DataMap pagingInfoMap) throws Exception{
		
	    DataMap resultMap = null;
	    
	    //검색 조건이 있을시 where절을 만든다.
	    String where  = "";
	    try {
	    	
	        if(!pagingInfoMap.getString("question").equals("") || !pagingInfoMap.getString("selectType").equals("") || !pagingInfoMap.getString("minVisit").equals("")  || !pagingInfoMap.getString("maxVisit").equals("")){
	        	//검색조건이 하나라도 충족이 된다면은 WHERE절을 만들어 준다.
	        	where += "WHERE ";
	        }
	        
	        if(!pagingInfoMap.getString("selectType").equals("")){
	        	if(!pagingInfoMap.getString("selectType").equals("")){
		        	//질문유형
		        	where += "CODE_ID='"+pagingInfoMap.getString("selectType")+"'";
	        	}
	        }
	        
	        if(!pagingInfoMap.getString("question").equals("")){
	        	if(!pagingInfoMap.getString("selectType").equals("")){
		        	//질문제목
		        	where += " AND QUESTION LIKE '%"+pagingInfoMap.getString("question")+"%'";
		        	
	        	}else{
	        		where += "QUESTION LIKE '%"+pagingInfoMap.getString("question")+"%'";
	        		
	        	}
	        }
	        
	        if (where.length() > 0){
	        	where += " AND use_yn = 'Y'";
	        } else {
	        	where = "WHERE use_yn = 'Y'";
	        }
	        
	        int totalCnt = supportMapper.selectFaqListCount(where);
        	
        	Map<String, Object> pageInfo = Util.getPageInfo(totalCnt, pagingInfoMap);
        	
        	pageInfo.put("where", where);
        	
        	resultMap = supportMapper.selectFaqList(pageInfo);
            
           	PageNavigation pageNavi = Util.getPageNavigation(pageInfo);
           	resultMap.set("PAGE_INFO", pageNavi);
	        
	    } catch (SQLException e) {
	        throw new BizException(Message.getKey(e), e);
	    } finally {
	    }
	    return resultMap;        
	}
	
	/**
	 * 교육관련 FAQ유형
	 * 작성일 6월 13일
	 * 작성자 정윤철
	 * @return selectSubCodeFaqList
	 * @throws Exception
	 */
	public DataMap selectSubCodeFaqList() throws Exception{
			
		DataMap resultMap = null;
	    
	    try {
	    	
	        resultMap = supportMapper.selectSubCodeFaqList();
	        
	    } catch (SQLException e) {
	        throw new BizException(Message.getKey(e), e);
	    } finally {
	    }
	    return resultMap;        
	}
	
	/**
	 * 교육관련 FAQ 상세페이지
	 * 작성일 6월 13일
	 * 작성자 정윤철
	 * @return selectSubCodeFaqList
	 * @throws Exception
	 */
	public DataMap selectFaqViewRow(String fno) throws Exception{
			
		DataMap resultMap = null;
	    
	    try {
	    	
	        resultMap = supportMapper.selectFaqViewRow(fno);
	        
	    } catch (SQLException e) {
	        throw new BizException(Message.getKey(e), e);
	    } finally {
	    }
	    return resultMap;        
	}
	
	/**
	 * 교육관련 FAQ 글넘버 최대값 로우 데이터
	 * 작성일 6월 13일
	 * 작성자 정윤철
	 * @return selectSubCodeFaqList
	 * @throws Exception
	 */
	public int selectFaqFnoRow() throws Exception{
			
	    int returnValue = 0;
	    try {
	    	
	        returnValue = supportMapper.selectFaqFnoRow();
	        
	    } catch (SQLException e) {
	        throw new BizException(Message.getKey(e), e);
	    } finally {
	    }
	    return returnValue;        
	}
	/**
	 * 교육관련 FAQ 카운터수 수정
	 * 작성일 6월 13일
	 * 작성자 정윤철
	 * @return selectSubCodeFaqList
	 * @throws Exception
	 */
	public int modifyFaqFno(int fno) throws Exception{
			
	    int returnValue = 0;
	    
	    try {
	    	
	        returnValue = supportMapper.modifyFaqFno(fno);
	        
	    } catch (SQLException e) {
	        throw new BizException(Message.getKey(e), e);
	    } finally {
	    	returnValue += 1;
	    }
	    return returnValue;        
	}
	
	
	
	
	public DataMap getOpenCourseList(DataMap requestMap) throws Exception{
		
		DataMap resultMap = null;
	    
	    try {
	    	
	        String Where = "";
	        if (requestMap.getString("search").length() > 0){
	        	Where = "AND subjnm like '%"+requestMap.getString("search")+"%' ";
	        }
	        
	        Map<String, Object> params = new HashMap<String, Object>();
	        
	        params.put("where", Where);
	        
	        int totalCnt = supportMapper.getOpenCourseListCount(params);
        	
        	params.putAll(Util.getPageInfo(totalCnt, requestMap));
        	
        	resultMap = supportMapper.getOpenCourseList(params);
            
            /**
        	 * 페이징 필수
        	 */

           	PageNavigation pageNavi = Util.getPageNavigation(params);
           	resultMap.set("PAGE_INFO", pageNavi);
	        
	    } catch (SQLException e) {
	        throw new BizException(Message.getKey(e), e);
	    } finally {
	    }
	    return resultMap;
	}
	
	public DataMap getOpenCourseView(String subj) throws Exception{
		
		DataMap resultMap = null;
	    
	    try {
	    	
	        resultMap = supportMapper.getOpenCourseView(subj);
	    } catch (SQLException e) {
	        throw new BizException(Message.getKey(e), e);
	    } finally {
	    }
	    return resultMap;
	}
	
	// 주민등록번호로 회원을 카운트 하는 프로세스.
    // 주민등록번호 인증에서만 사용.
	public int countExistResno(String resno) throws Exception{
		
	    int returnValue = 0;
	    
	    try {
	    	
	        returnValue = supportMapper.countExistResno(resno);
	    } catch (SQLException e) {
	        throw new BizException(Message.getKey(e), e);
	    } finally {
	    }
	    return returnValue;        
	}
	
	// 2011.01.13 - woni82
    // 아이핀에서 제공하는 중복코드로 회원을 카운트 하는 프로세스.
    // 아이핀 인증, 주민등록번호 인증 둘다 사용.
	public int countExistDupinfo(String dupinfo) throws Exception{
		
	    int returnValue = 0;
	    
	    try {
	    	
	        returnValue = supportMapper.countExistDupinfo(dupinfo);
	    } catch (SQLException e) {
	        throw new BizException(Message.getKey(e), e);
	    } finally {
	    }
	    return returnValue;        
	}
	
	// 2011.01.14 - woni82
    // 아이핀에서 제공하는 개인식별번호로 회원을 카운트 하는 프로세스.
    // 아이핀 인증에서만 사용.
	public int countExistVirtualno(String virtualno) throws Exception{
		
	    int returnValue = 0;
	    
	    try {
	    	
	        returnValue = supportMapper.countExistVirtualno(virtualno);
	    } catch (SQLException e) {
	        throw new BizException(Message.getKey(e), e);
	    } finally {
	    }
	    return returnValue;        
	}

	public DataMap selectMyGrCodeNmList(DataMap requestMap) throws Exception {
		
		DataMap resultMap = null;
	    try {
	    	
	    	resultMap = supportMapper.selectMyGrCodeNmList(requestMap);
	        
	    } catch (SQLException e) {
	        throw new BizException(Message.getKey(e), e);
	    } finally {
	    }
	    return resultMap;
	}

	public int modifyBbsBoardEpilogue(DataMap requestMap, int fileGroupNo) throws BizException {
		
		int returnValue = 0;
	    
	    try {
	    	
	    	Map<String,Object> params = Util.getMapOfDataMapIdxZero(requestMap);
  		    
  		    params.put("tableName", "TB_BOARD_"+params.get("boardId"));
  		    params.put("title", params.get("title"));
  		    params.put("namoContent", params.get("namoContent"));
  		    params.put("seq", params.get("seq"));
  		    params.put("fileGroupNo", fileGroupNo);
  		    
  		  if(params.get("boardId").equals("EPILOGUE")){
				String selectGrcode = (String)params.get("selectGrcode");
				
				String [] gr_arr = selectGrcode.split("[|]");
				params.put("pGrcode", gr_arr[0]);
				params.put("pGrseq", gr_arr[1]);
				params.put("pGrcodeNiknm", gr_arr[2]);
			}
  		    
	        returnValue = boardMapper.modifyBbsBoard(params);
	    } catch (SQLException e) {
	        throw new BizException(Message.getKey(e), e);
	    } finally {
	    }
	    
	    return returnValue;  
		
	}

	public void popupEctInsert(DataMap requestMap) throws BizException {
		
	    try {
	    	
	    	Map<String,Object> params = Util.getMapOfDataMapIdxZero(requestMap);
  		    
	        supportMapper.popupEctInsert(params);
	    } catch (SQLException e) {
	        throw new BizException(Message.getKey(e), e);
	    } finally {
	    }
	    
	}
	

}
