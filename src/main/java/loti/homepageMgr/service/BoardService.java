package loti.homepageMgr.service;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

import loti.homepageMgr.mapper.BoardMapper;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import ut.lib.exception.BizException;
import ut.lib.page.PageNavigation;
import ut.lib.support.DataMap;
import ut.lib.util.DateUtil;
import ut.lib.util.Message;
import ut.lib.util.Util;
import common.service.BaseService;

@Service
public class BoardService extends BaseService {

	@Autowired
	private BoardMapper boardMapper;
	
	public DataMap selectBbsPopup() throws BizException {

		DataMap resultMap = null;
	    
	    try {
	        resultMap = boardMapper.selectBbsPopup();
	        
	    } catch (SQLException e) {
	        throw new BizException(Message.getKey(e), e);
	    } finally {
	    }
	    return resultMap;       
	}
	
	/**
	 * 게시판관리 리스트
	 * 작성일 6월 05일
	 * 작성자 정윤철
	 * @param pagingInfoMap
	 * @return boardList
	 * @throws Exception
	 */
	public DataMap selectBoardList(DataMap pagingInfoMap) throws Exception{
			
	    DataMap resultMap = null;
	    
	    try {
	    	
	    	int totalCnt = boardMapper.selectBoardListCount(pagingInfoMap);
        	
        	Map<String, Object> pageInfo = Util.getPageInfo(totalCnt, pagingInfoMap);
        	
        	pagingInfoMap.set("page", pageInfo);
        	
            resultMap = boardMapper.selectBoardList(pagingInfoMap);
            
            PageNavigation pageNavi = Util.getPageNavigation(pageInfo);
		    resultMap.set("PAGE_INFO", pageNavi);
	    	
	        
	    } catch (SQLException e) {
	        throw new BizException(Message.getKey(e), e);
	    } finally {
	    }
	    return resultMap;        
	}
	/**
	 * 게시판관리 기본정보 ROW
	 * 작성자 정윤철
	 * 작성일 6월 5일
	 * @param boardId
	 * @return selectBoardManagerRow
	 * @throws Exception
	 */
	public DataMap selectBoardManagerRow(String boardId) throws Exception{
		
	    DataMap resultMap = null;
	    
	    try {
	    	
	        resultMap = boardMapper.selectBoardManagerRow(boardId);
	        
	    } catch (SQLException e) {
	        throw new BizException(Message.getKey(e), e);
	    } finally {
	    }
	    return resultMap;        
	}
	
	/**
	 * 게시판관리 권한정보 ROw
	 * 작성자 정윤철
	 * 작성일 6월 5일
	 * @param boardId
	 * @return selectAuthBoardRow
	 * @throws Exception
	 */
	public DataMap selectAuthBoardRow(String boardId) throws Exception{
		
	    DataMap resultMap = null;
	    
	    try {
	    	
	        resultMap = boardMapper.selectAuthBoardRow(boardId);
	        
	    } catch (SQLException e) {
	        throw new BizException(Message.getKey(e), e);
	    } finally {
	    }
	    return resultMap;        
	}
	/**
	 * 사용자 게시판에서 사용자들의 권한을 체크하기위해서 가져간다.
	 * 작성자 정윤철
	 * 작성일 6월 11일
	 * @param boardId
	 * @return selectAuthBoardRow
	 * @throws Exception
	 */
	public DataMap selectUseBoardAuthRow(String boardId, String sessClass) throws Exception{
		
	    DataMap resultMap = null;
	    
	    try {
	    	
	    	DataMap params = new DataMap();
	    	
	    	params.setString("boardId", boardId);
	    	params.setString("sessClass", sessClass);
	    	
	        resultMap = boardMapper.selectUseBoardAuthRow(params);
	        
	    } catch (SQLException e) {
	        throw new BizException(Message.getKey(e), e);
	    } finally {
	    }
	    return resultMap;        
	}
	
	/**
	 * 게시판 권한선택명 ROW
	 * 작성자 정윤철
	 * 작성일 6월 5일
	 * @param 
	 * @return selectGadminBoardRow
	 * @throws Exception
	 */
	public DataMap selectGadminBoardRow() throws Exception{
		
	    DataMap resultMap = null;
	    
	    try {
	    	
	        resultMap = boardMapper.selectGadminBoardRow();
	        
	    } catch (SQLException e) {
	        throw new BizException(Message.getKey(e), e);
	    } finally {
	    }
	    return resultMap;        
	}
	
	/**
	 * 게시판 기본설정 변경
	 * 작성자 정윤철
	 * 작성일 6월 5일
	 * @param requestMap
	 * @return updateDefaultInfo
	 * @throws Exception
	 */
	public int updateDefaultInfo(DataMap requestMap) throws Exception{
		
	    int returnValue = 0;
	    
	    try {
	    	
	        returnValue = boardMapper.updateDefaultInfo(requestMap);
	        
	    } catch (SQLException e) {
	        throw new BizException(Message.getKey(e), e);
	    } finally {
	    }
	    return returnValue;        
	}
	
	/**
	 * 게시판 권한정보 삭제
	 * 작성자 정윤철
	 * 작성일 6월 5일
	 * @param boardId
	 * @return deleteAuthBoardInfo
	 * @throws Exception
	 */
	public int deleteAuthBoardInfo(String boardId) throws Exception{
		
	    int returnValue = 0;
	    
	    try {
	    	
	        returnValue = boardMapper.deleteAuthBoardInfo(boardId);
	        
	    } catch (SQLException e) {
	        throw new BizException(Message.getKey(e), e);
	    } finally {
	    }
	    return returnValue;        
	}
	
	/**
	 * 게시판 권한정보 등록
	 * 작성자 정윤철
	 * 작성일 6월 11일
	 * @param read, write, delete, download, boardId, gadmin
	 * @return insertAuthBoardInfo
	 * @throws Exception
	 */
	public int insertAuthBoardInfo(String read, String write, String delete, String download, String boardId, String gadmin) throws Exception{
		
	    int returnValue = 0;
	    
	    try {
	    	
	    	Map<String, Object> params = new HashMap<String, Object>();
	    	
	    	params.put("read", read);
	    	params.put("write", write);
	    	params.put("delete", delete);
	    	params.put("download", download);
	    	params.put("boardId", boardId);
	    	params.put("gadmin", gadmin);
	    	
//	    	read, write, delete, download, boardId, gadmin
	        returnValue = boardMapper.insertAuthBoardInfo(params);
	        
	    } catch (SQLException e) {
	        throw new BizException(Message.getKey(e), e);
	    } finally {
	    }
	    return returnValue;        
	}
	
	/**
	 * 게시판 보더네임 중복 체크
	 * 작성자 정윤철
	 * 작성일 6월 11일
	 * @param boardId
	 * @return selectBoardIdChk
	 * @throws Exception
	 */
	public int selectBoardIdChk(String boardId) throws Exception{
		
	    int returnValue = 0;
	    
	    try {
	    	
	        returnValue = boardMapper.selectBoardIdChk(boardId);
	    } catch (SQLException e) {
	        throw new BizException(Message.getKey(e), e);
	    } finally {
	    }
	    return returnValue;        
	}
	
	
	/**
	 * 게시판 기본정보 등록
	 * 작성자 정윤철
	 * 작성일 6월 11일
	 * @param requestMap
	 * @return insertBoardMnger
	 * @throws Exception
	 */
	public int insertBoardMnger(DataMap requestMap) throws Exception{
		
	    int returnValue = 0;
	    
	    try {
	    	
	        returnValue = boardMapper.insertBoardMnger(requestMap);
	        
	    } catch (SQLException e) {
	        throw new BizException(Message.getKey(e), e);
	    } finally {
	    }
	    return returnValue;        
	}
	
	
	/**
	 * 게시판 기본정보 등록
	 * 작성자 정윤철
	 * 작성일 6월 11일
	 * @param boardId
	 * @return createBoardTable
	 * @throws Exception
	 */
	public int createBoardTable(String boardId) throws Exception{
		
	    int returnValue = 0;
	    
	    try {
	        
	        returnValue = boardMapper.createBoardTable(boardId);
	        
	    } catch (SQLException e) {
	        throw new BizException(Message.getKey(e), e);
	    } finally {
	    }
	    return returnValue;        
	}
	
	/**
	 * 게시판 테이블 PK셋
	 * 작성자 정윤철
	 * 작성일 6월 11일
	 * @param boardId
	 * @return setBoardTablePk
	 * @throws Exception
	 */
	public int setBoardTablePk(String boardId) throws Exception{
		
	    int returnValue = 0;
	    
	    try {
	    	
	        returnValue = boardMapper.setBoardTablePk(boardId);
	        
	    } catch (SQLException e) {
	        throw new BizException(Message.getKey(e), e);
	    } finally {
	    }
	    return returnValue;        
	}
	
	/**
	 * 게시판 테이블 코멘트입력
	 * 작성자 정윤철
	 * 작성일 6월 11일
	 * @param String boardId
	 * @return setBoardTableComment
	 * @throws Exception
	 */
	public int setBoardTableComment(String boardId) throws Exception{
		
	    int returnValue = 0;
	    
	    try {
	    	
	        returnValue = boardMapper.setBoardTableComment(boardId);
	        
	    } catch (SQLException e) {
	        throw new BizException(Message.getKey(e), e);
	    } finally {
	    }
	    return returnValue;        
	}
	
	/**
	 * 게시판 테이블 삭제
	 * 작성자 정윤철
	 * 작성일 6월 11일
	 * @param String boardId
	 * @return dropBoardTable
	 * @throws Exception
	 */
	public int dropBoardTable(String boardId) throws Exception{
		
	    int returnValue = 0;
	    
	    try {
	    	
	        returnValue = boardMapper.dropBoardTable(boardId);
	        
	    } catch (SQLException e) {
	        throw new BizException(Message.getKey(e), e);
	    } finally {
	    }
	    return returnValue;        
	}
	
	/**
	 * 게시판 테이블 리네임
	 * 작성자 정윤철
	 * 작성일 6월 11일
	 * @param String boardId
	 * @return renameBoardTable
	 * @throws Exception
	 */
	public int renameBoardTable(String boardId) throws Exception{
		
	    int returnValue = 0;
	    
	    try {
	    	
	        Map<String, Object> params = new HashMap<String, Object>();
	        
	        params.put("boardId", boardId);
	        params.put("time", DateUtil.getDateTime());
	        returnValue = boardMapper.renameBoardTable(params);
	        
	    } catch (SQLException e) {
	        throw new BizException(Message.getKey(e), e);
	    } finally {
	    }
	    return returnValue;        
	}
	
	/**
	 * 게시판 기본정보 삭제
	 * 작성자 정윤철
	 * 작성일 6월 5일
	 * @param String boardId
	 * @return  deleteBoardManager
	 * @throws Exception
	 */
	public int deleteBoardManager(String boardId) throws Exception{
		
	    int returnValue = 0;
	    
	    try {
	    	
	        returnValue = boardMapper.deleteBoardManager(boardId);
	    } catch (SQLException e) {
	        throw new BizException(Message.getKey(e), e);
	    } finally {
	    }
	    return returnValue;        
	}
	
	/**
	 * 게시판 권한정보 삭제
	 * 작성자 정윤철
	 * 작성일 6월 5일
	 * @param String boardId
	 * @return  deleteBoardManager
	 * @throws Exception
	 */
	public int deleteBoardAuth(String boardId) throws Exception{
		
	    int returnValue = 0;
	    
	    try {
	    	
	        returnValue = boardMapper.deleteBoardAuth(boardId);
	    } catch (SQLException e) {
	        throw new BizException(Message.getKey(e), e);
	    } finally {
	    }
	    return returnValue;        
	}
	
	
	/**
	 * 사용자 게시판 리스트
	 * 작성자 정윤철
	 * 작성일 6월 11일
	 * @param requestMap
	 * @return selectBbsBoardList
	 * @throws Exception
	 */
	 public DataMap selectBbsBoardList(DataMap requestMap) throws Exception{
        DataMap listMap = null;
        String whereSearch = "";
        String query = "";
        try {
	        //타입에 대한정보가 없을경우 기준을 전체로 변환
	        if(requestMap.getString("selectType").equals("")){
	        	requestMap.setString("selectType","all");
	        }
	        
	        //검색조건  쿼리 정의
	        if(requestMap.getString("selectType").equals("all")){
	        	if(!requestMap.getString("selectText").equals("")){
	        		whereSearch  = "FROM TB_BOARD_"+ requestMap.getString("boardId")+" b WHERE TOP_RANK IS NULL AND TITLE LIKE '%" +requestMap.getString("selectText")+ "%' OR CONTENT LIKE '%" +requestMap.getString("selectText")+ "%' ";
	        	}else{
	        		query  = "FROM TB_BOARD_"+ requestMap.getString("boardId") +" b ";
	        	}
	        }else{
	        	if(!requestMap.getString("selectText").equals("")){
	        		whereSearch  = "FROM TB_BOARD_"+ requestMap.getString("boardId")+"  B WHERE TOP_RANK IS NULL AND "+requestMap.getString("selectType")+" LIKE '%" +requestMap.getString("selectText")+ "%' ";
	        	}else{
	        		query  = "FROM TB_BOARD_"+ requestMap.getString("boardId") + "  b ";
	        	}
	        }
        
       
            //삭제된글인지 체크
            if(whereSearch == ""){
            	query += "WHERE TITLE <> '삭제된 글입니다' AND (DEPTH =0 or (DEPTH >0 AND NOT EXISTS (SELECT 'X' FROM TB_BOARD_"+requestMap.getString("boardId") +" P WHERE B.STEP < P.STEP AND P.STEP<=CEIL(B.STEP) AND P.TITLE='삭제된 글입니다' ) ) ) ";
            }else{
            	whereSearch += " AND TITLE<> '삭제된 글입니다' AND (DEPTH =0 or (DEPTH >0 AND NOT EXISTS (SELECT 'X' FROM TB_BOARD_"+requestMap.getString("boardId") +" P WHERE B.STEP < P.STEP AND P.STEP<=CEIL(B.STEP) AND P.TITLE='삭제된 글입니다' ) ) ) ";
            	
            }
            
            Map<String, Object> params = new HashMap<String, Object>();
            
            params.put("whereSearch", whereSearch);
            params.put("query", query);
            
	    	int totalCnt = boardMapper.selectBbsBoardListCount(params);
        	
        	Map<String, Object> pageInfo = Util.getPageInfo(totalCnt, requestMap);
        	
        	params.put("page", pageInfo);
        	
            listMap = boardMapper.selectBbsBoardList(params);
            
            PageNavigation pageNavi = Util.getPageNavigation(pageInfo);
            listMap.set("PAGE_INFO", pageNavi);
            
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return listMap;
    }
	 
	 
	 /**
	 * 게시판 사용자 게시판 뷰페이지
	 * 작성자 정윤철
	 * 작성일 6월 12일
	 * @param String boardId
	 * @return  deleteBoardManager
	 * @throws Exception
	 */
	public DataMap selectbbsBoardView(String boardId,String seq) throws Exception{
	    DataMap resultMap = null;
	    
	    //테이블이 게시판마다 다르기 때문에 설정을 한다.
	    String stringQuery = "";
	    
	    try {
	        
	    	Map<String, Object> params = new HashMap<String, Object>();
	    	
	    	params.put("boardId", boardId);
	    	params.put("seq", seq);
	    	
	        //게시판아이디가 카풀, 법률/조례, 게시판관리, 게시판권한관리중 하나이면 전화번호, 주소 조회하지 않는다.
	    	if("CARPOOL".equals(boardId) || "LAWS".equals(boardId) || "CYBER".equals(boardId) || "MNGER".equals(boardId) || "MNGER_AUTH".equals(boardId)) {
	        	resultMap = boardMapper.selectbbsBoardViewIncludePostAndPhone(params);
	        //전화번호, 주소 조회하는 경우
	    	} else if("QNA".equals(boardId)) {
	        	resultMap = boardMapper.selectbbsBoardViewQna(params);
	        } else {
	        	resultMap = boardMapper.selectbbsBoardViewExceptPostAndPhone(params);
	        }
	        
	    } catch (SQLException e) {
	        throw new BizException(Message.getKey(e), e);
	    } finally {
	    }
	    return resultMap;        
	}
	
	/**
	 * 게시판 권한정보 삭제
	 * 작성자 정윤철
	 * 작성일 6월 12일
	 * @param String boardId
	 * @return  deleteBoardManager
	 * @throws Exception
	 */
	public int modifyBbsBoard(String boardId, String title, String namoContent, int seq, int fileGroupNo) throws Exception{
		
	    int returnValue = 0;
	    
	    try {
	    	
	    	Map<String, Object> params = new HashMap<String, Object>();
	    	
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
	
	/**
	 * 사용자 게시판 카운트 증가
	 * 작성자 정윤철
	 * 작성일 6월 12일
	 * @param String boardId
	 * @return  deleteBoardManager
	 * @throws Exception
	 */
	public int updateBbsBoardVisit(int visit, String tableName, String seq) throws Exception{
		
	    int returnValue = 0;
	    
	    try {
	    	
	    	Map<String, Object> params = new HashMap<String, Object>();
	    	
	    	params.put("tableName", tableName);
	    	params.put("visit", visit);
	    	params.put("seq", seq);
	    	
	        returnValue = boardMapper.updateBbsBoardVisit(params);
	    } catch (SQLException e) {
	        throw new BizException(Message.getKey(e), e);
	    } finally {
	    }
	    return returnValue;        
	}

	
	/**
	 * 사용자 게시판 글 등록
	 * 작성자 정윤철
	 * 작성일 6월 5일
	 * @param String boardId
	 * @return  deleteBoardManager
	 * @throws Exception
	 */
	public int insertBbsBoard(DataMap requestMap) throws Exception{
		
	    int returnValue = 0;
	    
	    try {
	    	requestMap.setInt("visit", 0);
	        returnValue = boardMapper.insertBbsBoard(requestMap);
	    } catch (SQLException e) {
	        throw new BizException(Message.getKey(e), e);
	    } finally {
	    }
	    return returnValue;        
	}

	/**
	 * 사용자 게시판 조회수 업데이트
	 * 작성자 정윤철
	 * 작성일 6월 12일
	 * @param String boardId
	 * @return  deleteBoardManager
	 * @throws Exception
	 */
	public int selectBbsBoardCount(String query) throws Exception{
		
	    int returnValue = 0;
	    
	    try {
	    	
	        returnValue = boardMapper.selectBbsBoardCount(query);
	    } catch (SQLException e) {
	        throw new BizException(Message.getKey(e), e);
	    } finally {
	    }
	    return returnValue;        
	}
	

	/**
	 * 사용자 게시판 조회수 업데이트
	 * 작성자 정윤철
	 * 작성일 6월 12일
	 * @param String boardId
	 * @return  deleteBoardManager
	 * @throws Exception
	 */
	public int deleteBbsBoard(DataMap requestMap) throws Exception{
		
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
	
	
	/**
	 * 사용자 게시판 답글시 step의 제일 낮은값을 구해온다
	 * @param tableName
	 * @param step
	 * @param minSetp
	 * @param depth
	 * @return
	 * @throws Exception
	 */
	public double selectBbsBoardMinNoRow(String tableName, double step, double minSetp, int depth) throws Exception{
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
	
	/**
	 * 과정운영자 게시판 리스트
	 * 작성자 정윤철
	 * 작성일 6월 11일
	 * @param requestMap
	 * @return selectBbsBoardList
	 * @throws Exception
	 */
	 public DataMap selectCoursemngerBbsBoardlist(DataMap requestMap) throws Exception{
        DataMap listMap = null;
        String whereSearch = "";
        String query = "";
        try {
	        //타입에 대한정보가 없을경우 기준을 전체로 변환
	        if(requestMap.getString("selectType").equals("")){
	        	requestMap.setString("selectType","all");
	        }
	        
	        //검색조건  쿼리 정의
	        if(requestMap.getString("selectType").equals("all")){
	        	if(!requestMap.getString("selectText").equals("")){
	        		whereSearch  = "FROM TB_BOARD_"+ requestMap.getString("boardId")+" b WHERE TOP_RANK IS NULL AND TITLE LIKE '%" +requestMap.getString("selectText")+ "%' OR CONTENT LIKE '%" +requestMap.getString("selectText")+ "%' ";
	        	}else{
	        		query  = "FROM TB_BOARD_"+ requestMap.getString("boardId") +" b ";
	        	}
	        }else{
	        	if(!requestMap.getString("selectText").equals("")){
	        		whereSearch  = "FROM TB_BOARD_"+ requestMap.getString("boardId")+"  B WHERE TOP_RANK IS NULL AND "+requestMap.getString("selectType")+" LIKE '%" +requestMap.getString("selectText")+ "%' ";
	        	}else{
	        		query  = "FROM TB_BOARD_"+ requestMap.getString("boardId") + "  b ";
	        	}
	        }
        
            Map<String, Object> params = new HashMap<String, Object>();
            
            params.put("whereSearch", whereSearch);
            params.put("query", query);
            
	    	int totalCnt = boardMapper.selectBbsBoardListCount(params);
        	
        	Map<String, Object> pageInfo = Util.getPageInfo(totalCnt, requestMap);
        	
        	params.put("page", pageInfo);
        	
            listMap = boardMapper.selectBbsBoardList(params);
            
            PageNavigation pageNavi = Util.getPageNavigation(pageInfo);
            listMap.set("PAGE_INFO", pageNavi);
       
        } catch (SQLException e) {
            throw new BizException(Message.getKey(e), e);
        } finally {
        }
        return listMap;
    }

}
