package loti.homepageMgr.web;

import java.util.Calendar;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import loti.common.service.CommonService;
import loti.homepageMgr.service.BoardService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import ut.lib.exception.BizException;
import ut.lib.file.FileUtil;
import ut.lib.login.LoginCheck;
import ut.lib.login.LoginInfo;
import ut.lib.support.CommonMap;
import ut.lib.support.DataMap;
import ut.lib.support.RequestUtil;
import ut.lib.util.Constants;
import ut.lib.util.Util;
import common.controller.BaseController;

@Controller
public class BoardController extends BaseController {

	@Autowired
	private BoardService boardService;
	
	@Autowired
	private CommonService commonService;
	
	@ModelAttribute("cm")
	public CommonMap common(
				CommonMap cm
				, HttpServletRequest request
				, HttpServletResponse response
				, Model model
			) throws Exception{
		
		//요청처리 - get, post 방식의 파라미터를 DataMap 에 저장
		DataMap requestMap = cm.getDataMap();		
		//초기화 옵션(true 일경우 데이터를 뽑을때 null 일경우 초기화 - 빈문자열, 0....)
		requestMap.setNullToInitialize(true);
		
		
		//관리자 로그인 체크. (관리자 페이지에는 모두 있어야 함)
		LoginInfo memberInfo = LoginCheck.adminCheck(request, response, requestMap.getString("menuId"));
		
		if (memberInfo == null) return null;
		//default mode
		if(requestMap.getString("mode").equals(""))
			requestMap.setString("mode", "list");
		
		model.addAttribute("REQUEST_DATA", requestMap);
		
		return cm;
	}
	
	public String findView(String mode, String defaultView){
		return defaultView;
	}
	
	@RequestMapping(value="/homepageMgr/board.do")
	public String defaultProcess(
			@ModelAttribute("cm") CommonMap cm
			, Model model
		) throws Exception{
		return list(cm, model);
	}
	
	/**
	 * 게시판관리 리스트
	 * 작성일 : 6월 5일
	 * 작성자 : 정 윤철
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	public void list(
			Model model
	        , DataMap requestMap) throws Exception {
	
		//	초기화 옵션(true 일경우 데이터를 뽑을때 null 일경우 초기화 - 빈문자열, 0....)
		requestMap.setNullToInitialize(true);
		
		if (requestMap.getString("currPage").equals("")) {
			requestMap.setInt("currPage", 1);
		}
		if (requestMap.getString("rowSize").equals("")) {
			requestMap.setInt("rowSize", 10);
		}
		if (requestMap.getString("pageSize").equals("")) {
			requestMap.setInt("pageSize", 10);
		}
		
		DataMap listMap = boardService.selectBoardList(requestMap);
		model.addAttribute("LIST_DATA", listMap);
	}
	
	@RequestMapping(value="/homepageMgr/board.do", params="mode=list")
	public String list(
				@ModelAttribute("cm") CommonMap cm
				, Model model
			) throws Exception{
		
		DataMap requestMap = cm.getDataMap();
		
		list(model, requestMap);
		
		return findView(requestMap.getString("mode"), "/homepageMgr/board/boardList");
	}

	/**
	 * 게시판관리 폼
	 * 작성일 : 6월 5일
	 * 작성자 : 정 윤철
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	public void form(
			Model model
	          ,DataMap requestMap) throws Exception {
	
		//	초기화 옵션(true 일경우 데이터를 뽑을때 null 일경우 초기화 - 빈문자열, 0....)
		requestMap.setNullToInitialize(true);
		
		//기본정보
		DataMap boardManagerMap = boardService.selectBoardManagerRow(requestMap.getString("boardId"));
		
		//권한정보
		DataMap authBoardRow = boardService.selectAuthBoardRow(requestMap.getString("boardId"));
		
		//권한선택명
		DataMap gadminBoardRow = boardService.selectGadminBoardRow();
		
		//권한 추가 (guest를 추가해준다)
		gadminBoardRow.addString("gadmin", "99");
		gadminBoardRow.addString("gadminnm", "GUEST");
		
		model.addAttribute("DEFAULTBOARD_DATA", boardManagerMap);
		model.addAttribute("AUTHBOARD_DATA", authBoardRow);
		model.addAttribute("GADMINBOARD_DATA", gadminBoardRow);
	}
	
	
	@RequestMapping(value="/homepageMgr/board.do", params="mode=form")
	public String form(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			) throws Exception{
		
		DataMap requestMap = cm.getDataMap();
		
		form(model, requestMap);
		
		return findView(requestMap.getString("mode"), "/homepageMgr/board/boardForm");
	}
	
	/**
	 * 게시판관리 등록 수정 ,삭제 실행
	 * 작성일 : 6월 5일
	 * 작성자 : 정 윤철
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	public void exec(
			Model model
	          ,DataMap requestMap
	          , LoginInfo loginInfo
	          ) throws Exception {
	
		//	초기화 옵션(true 일경우 데이터를 뽑을때 null 일경우 초기화 - 빈문자열, 0....)
		requestMap.setNullToInitialize(true);
		
		requestMap.setString("sessNo", loginInfo.getSessNo());
		
		//보더아이디 중복 체크
		int boardIdChk = 0;	
		
		boardIdChk = boardService.selectBoardIdChk(requestMap.getString("boardId"));
		
		
		
		if(requestMap.getString("qu").equals("modifyBoard")){
			//기본정보 수정
			boardService.updateDefaultInfo(requestMap);
			
			//게시판 설정정보 삭제
			boardService.deleteAuthBoardInfo(requestMap.getString("boardId"));
			
			//게시판 설정정보 등록
			for(int i=0;requestMap.keySize("gadmin") > i; i++){
			boardService.insertAuthBoardInfo(
					Util.getValue(requestMap.getString("boardWrite"+i), "N"),
				Util.getValue(requestMap.getString("boardRead"+i), "N"), 
				Util.getValue(requestMap.getString("boardDelete"+i), "N"), 
				Util.getValue(requestMap.getString("boardDownload"+i), "N"),
				requestMap.getString("boardId"),
				requestMap.getString("gadmin",i));
			}
			
			//게시판 수정일경우
			requestMap.setString("msg","수정하였습니다.");
			
		}else if(requestMap.getString("qu").equals("insertBoard")){
			if(boardIdChk <= 0){
				
				//게시판 기본정보 등록
				boardService.insertBoardMnger(requestMap);
				
				//게시판 설정정보 등록
				for(int i=0;requestMap.keySize("gadmin") > i; i++){
				boardService.insertAuthBoardInfo(
					Util.getValue(requestMap.getString("boardWrite"+i), "N"), 
					Util.getValue(requestMap.getString("boardRead"+i), "N"),
					Util.getValue(requestMap.getString("boardDelete"+i), "N"), 
					Util.getValue(requestMap.getString("boardDownload"+i), "N"),
					
					requestMap.getString("boardId"),
					requestMap.getString("gadmin",i));
				
				}
				
				//게시판 테이블 생성
				boardService.createBoardTable(requestMap.getString("boardId"));
				//테이블 PK셋
				boardService.setBoardTablePk(requestMap.getString("boardId"));
				//코멘트 달기 
				boardService.setBoardTableComment(requestMap.getString("boardId"));
				
				//등록일경우
				requestMap.setString("msg","등록하였습니다.");
				
			}else{
				//등록시 중복된 게시판 아이디 일경우 
				requestMap.setString("msg","동일한 게시판 아이디가 존재합니다.");
				
			}
		}else if(requestMap.getString("qu").equals("deleteBoard")){
			//게시판 드랍
			boardService.dropBoardTable(requestMap.getString("boardId"));
			
			//드랍시킨 게시판테이블 네임 변경
			boardService.renameBoardTable(requestMap.getString("boardId"));

			//게시판 기본정보 삭제
			boardService.deleteBoardManager(requestMap.getString("boardId"));
			
			//게시판 권한정보 삭제 
			boardService.deleteBoardAuth(requestMap.getString("boardId"));
			
			//등록일경우
			requestMap.setString("msg","삭제하였습니다.");
		}
		
	}
	
	@RequestMapping(value="/homepageMgr/board.do", params="mode=exec")
	@Transactional
	public String exec(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			) throws Exception{
		
		DataMap requestMap = cm.getDataMap();
		
		exec(model, requestMap, cm.getLoginInfo());
		
		return findView(requestMap.getString("mode"), "/homepageMgr/board/boardExec");
	}
	
	/**
	 * 사용자 게시판 리스트
	 * 작성일 : 6월 11일
	 * 작성자 : 정 윤철  
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @param requestMap
	 * @throws Exception
	 */
	public void selectBbsBoardList(
			Model model
	         , DataMap requestMap
	         ) throws Exception {
		
		if (requestMap.getString("currPage").equals("")) {
			requestMap.setInt("currPage", 1);
		}
		if (requestMap.getString("rowSize").equals("")) {
			requestMap.setInt("rowSize", 15);
		}
		if (requestMap.getString("pageSize").equals("")) {
			requestMap.setInt("pageSize", 10);
		}
		DataMap listMap = null;
		
		if(requestMap.getString("menuId").equals("6-3-1") || requestMap.getString("menuId").equals("1-1-1")){
			//시스템 관리자 bbs게시판 리스트
			listMap = boardService.selectBbsBoardList(requestMap);
		}else if(requestMap.getString("menuId").equals("5-1-2")){
			//과정운영자 관리자 bbs게시판 리스트
			listMap = boardService.selectCoursemngerBbsBoardlist(requestMap);
		}else if(requestMap.getString("menuId").equals("8-1-1")){
			//과정운영자 관리자 bbs게시판 리스트
			listMap = boardService.selectCoursemngerBbsBoardlist(requestMap);
		}

		//게시판 기본정보
		DataMap authBoardRow = boardService.selectAuthBoardRow(requestMap.getString("boardId"));
		
		model.addAttribute("LIST_DATA", listMap);
		model.addAttribute("MANAGER_BOARDROW_DATA", authBoardRow);
		
	}
	
	@RequestMapping(value="/homepageMgr/board/bbs.do", params="mode=bbsBoardList")
	public String bbsBoardList(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			) throws Exception{
		
		DataMap requestMap = cm.getDataMap();
		
		//사용자 게시판 리스트
		selectBbsBoardList(model, requestMap);
		
		return findView(requestMap.getString("mode"), "/homepageMgr/board/bbs/list");
	}
	
	/**
	 * 사용자 게시판 뷰
	 * 작성일 : 6월 12일
	 * 작성자 : 정 윤철  
	 * @param mapping
	 * @param form 
	 * @param request
	 * @param response
	 * @param requestMap
	 * @throws Exception
	 */
	public void selectbbsBoardView(
			Model model
	         , DataMap requestMap) throws Exception {
		
		DataMap rowMap = null;
		DataMap boardManagerMap = null;
		DataMap authBoardRow = null;
		
		if(requestMap.getString("qu").equals("insertBbsBoardForm")){
			//인서트폼일경우 모든데이터를 초기화 시킨다.
			rowMap = new DataMap();
			boardManagerMap = new DataMap();
			authBoardRow = new DataMap();
			
		}else{//수정폼이거나 또는 뷰페이지, 답글일경우
			//뷰일경우 조회수 증감
			if(requestMap.getString("qu").equals("selectBbsBoardview")){
				//쿼리
				String query = "SELECT VISIT FROM TB_BOARD_"+requestMap.getString("boardId")+" WHERE SEQ ="+requestMap.getString("seq");
				//카운터값
				int visit = boardService.selectBbsBoardCount(query);
				//테이블네임 지정
				String tableName = "TB_BOARD_"+requestMap.getString("boardId");
				//업데이트시작
				boardService.updateBbsBoardVisit(visit, tableName, requestMap.getString("seq"));
				
			}
			
			//게시물 상세 정보
			rowMap = boardService.selectbbsBoardView(requestMap.getString("boardId"),requestMap.getString("seq"));
			
			//기본정보
			boardManagerMap = boardService.selectBoardManagerRow(requestMap.getString("boardId"));
			
			//권한정보
			authBoardRow = boardService.selectUseBoardAuthRow(requestMap.getString("boardId"),requestMap.getString("sessClass"));
			
			if(requestMap.getString("qu").equals("insertReplyBbsBoard")){
				rowMap.setInt("groupfileNo", 0);
			}
			
		}
		
		//파일 정보 가져오기.
		commonService.selectUploadFileList(rowMap);
		
		model.addAttribute("BOARDROW_DATA", rowMap);
		model.addAttribute("BOARD_AUTHROW_DATA", authBoardRow);
		model.addAttribute("BOARD_MANAGERROW_DATA", boardManagerMap);
	}
	
	@RequestMapping(value="/homepageMgr/board/bbs.do", params="mode=bbsBoardView")
	public String bbsBoardView(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			) throws Exception{
		
		DataMap requestMap = cm.getDataMap();
		
		//사용자 게시판 리스트
		selectbbsBoardView(model, requestMap);
		
		return findView(requestMap.getString("mode"), "/homepageMgr/board/bbs/view");
	}
	
	@RequestMapping(value="/homepageMgr/board/bbs.do", params="mode=bbsBoardForm")
	public String bbsBoardForm(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			) throws Exception{
		
		DataMap requestMap = cm.getDataMap();
		
		//사용자 게시판 상세 페이지
		selectbbsBoardView(model, requestMap);
		
		return findView(requestMap.getString("mode"), "/homepageMgr/board/bbs/form");
	}
	
	/**
	 * 사용자 게시판 등록, 수정 실행
	 * 작성일 : 6월 13일
	 * 작성자 : 정 윤철  
	 * @param mapping
	 * @param form 
	 * @param request
	 * @param response
	 * @param requestMap
	 * @throws Exception
	 */
	public void bbsBoardExec(
			Model model
	         , DataMap requestMap
	         , LoginInfo loginInfo
	         ) throws Exception {
		
		String qu = requestMap.getString("qu");
		
		//등록 및 수정시만 파일 업로드 처리.
		int fileGroupNo = -1;
		if( qu.equals("insertBbsBoardForm") || qu.equals("modifyBbsBoard") || qu.equals("insertReplyBbsBoard")){
			
			//파일 등록.
			DataMap fileMap = (DataMap)requestMap.get("UPLOAD_FILE");
			if(fileMap == null) fileMap = new DataMap();
			fileMap.setNullToInitialize(true);
			
			if(fileMap.keySize("fileSysName") > 0 || fileMap.keySize("existFile") > 0 || fileMap.keySize("deleteFile") > 0 || fileMap.keySize("fileUploadOk") > 0)
				fileGroupNo = commonService.insertInnoUploadFile(fileMap, requestMap.getString("INNO_SAVE_DIR"), loginInfo.getSessNo());
			
//			Util.saveNamoContent(requestMap, "content", "namoContent", Constants.NAMOUPLOAD_NOTICE); //나모로 넘어온값 처리.
			Util.saveDaumContent(requestMap, "content", "namoContent", Constants.NAMOUPLOAD_NOTICE); //나모로 넘어온값 처리.
		}
		
		
		
		if(requestMap.getString("qu").equals("insertBbsBoardForm")){
			
			//사용자글 등록
			String query = "SELECT NVL(MAX(SEQ),0)+1 AS COUNT FROM TB_BOARD_"+requestMap.getString("boardId");
			
			//seq 카운터
			int seqCoutn = boardService.selectBbsBoardCount(query);
			
			//시퀀스값을 셋킨다
			requestMap.setInt("seq", (seqCoutn+1));
			//setp값을 셋시킨다.
			requestMap.setInt("step", (seqCoutn+1));
			
			//depth값이 널일경우 초기값을 셋시킨다. 초기값은 0.0이다
			if(requestMap.getString("depth").equals("")){
				requestMap.setInt("depth",0);
			}
			
			//파일넘버값을 셋시킨다
			requestMap.setInt("fileGroupNo",fileGroupNo);
			
			requestMap.setString("wuserno",loginInfo.getSessNo());
			requestMap.setString("username",loginInfo.getSessName());
			requestMap.setInt("groupfileNo",fileGroupNo);
			
			boardService.insertBbsBoard(requestMap);
			requestMap.setString("msg","등록하였습니다.");
			
		}else if(requestMap.getString("qu").equals("deleteBbsBoard")){
			double step = requestMap.getDouble("step");
			double minSetp = 0.0;
			
    		if(step <= 0.0){
	    		//스텝값이 1보다 작을경우 0으로 만든다. 
	    		minSetp = 0;
	    		
    		}else if(step > 0.0 && step < 1){
    			minSetp = step;
    			
    		}else{
    			minSetp = step -1;
    			
    		}
    		
			//게시물 상세 정보
			DataMap rowMap = boardService.selectbbsBoardView(requestMap.getString("boardId"),requestMap.getString("seq"));
			//물리 파일삭제
			if(rowMap.getInt("groupfileNo") > 0){
				FileUtil.commonDeleteGroupfile(rowMap.getInt("groupfileNo"));
			}
			String query = "";
			
			if(step == minSetp){
				query = "SELECT COUNT(*) AS TOTAL FROM TB_BOARD_" +requestMap.getString("boardId") + " WHERE STEP < " + step;
			}else{
				query = "SELECT COUNT(*) AS TOTAL FROM TB_BOARD_" +requestMap.getString("boardId") + " WHERE STEP < " + step +" AND STEP >" + minSetp;	
			}
			
			int count  = boardService.selectBbsBoardCount(query);

			requestMap.setInt("count", count);
			requestMap.setString("sessNo",loginInfo.getSessNo());
			boardService.deleteBbsBoard(requestMap);
			
			requestMap.setString("msg","삭제하였습니다.");
			
		}else if(requestMap.getString("qu").equals("modifyBbsBoard")){
			
			boardService.modifyBbsBoard(requestMap.getString("boardId"), 
													 requestMap.getString("title"),
													 requestMap.getString("namoContent"),
													 requestMap.getInt("seq"),
													 fileGroupNo);
			
			requestMap.setString("msg","수정하였습니다.");
				
		}else if(requestMap.getString("qu").equals("insertReplyBbsBoard")){
	    	//serp 제일 낮은값
	    	double minSetpNo = 0.0;
	    	//최종 가공 setp값
	    	double rplayStep = 0.0;
	    	//뎁스
	    	int depth = 0;
	    	
			//사용자글 등록
			String query = "SELECT MAX(SEQ) AS COUNT FROM TB_BOARD_"+requestMap.getString("boardId");
			
			//seq 카운터
			int seqCoutn = boardService.selectBbsBoardCount(query);
			
			//시퀀스값을 셋킨다
			requestMap.setInt("seq", seqCoutn+1);
			//파일넘버값을 셋시킨다
			requestMap.setInt("fileGroupNo",fileGroupNo);
			//현재 유저넘버 셋
			requestMap.setString("wuserno",loginInfo.getSessNo());
			//현재 유저네임 셋
			requestMap.setString("username",loginInfo.getSessName());
			//넘어온 파일넘버 셋
			requestMap.setInt("groupfileNo",fileGroupNo);
			//테이블네임 
    		String tableName = "FROM TB_BOARD_"+ requestMap.getString("boardId");
    		
    		depth = requestMap.getInt("depth");
    		
    		double step  = requestMap.getDouble("step");
    		
    		double minSetp = 0.0;
    		
    		
    		
    		if(requestMap.getInt("depth") <= 0){
	    		//제일 낮은 setp값 구해오기 
	    		step  = requestMap.getDouble("step");// 1이들어간다.
	    		minSetp = 0.0;
	    		
	    		if(step <= 1){// 1보다 작을때에는 최하수에 1을넣는다.
	    		//스텝값이 0일경우
	    			minSetp = 0.0;
	    		}else{
	    			minSetp = step -1; //아닐때에는 1을뺀다 
	    		}
	    		
	    		minSetpNo	=  boardService.selectBbsBoardMinNoRow(tableName, step, minSetp, requestMap.getInt("depth")+1);

	    		if(minSetpNo == 0 && step <= 1){
	    			minSetpNo = minSetp;
	    			
	    		}else{
	    			minSetpNo = step;
	    		}
	    		
    		}else if(requestMap.getInt("depth") > 0){
    			
    			if(step >= 1){
    				minSetp	= step-1;
    			}else{
    				minSetp = 0.0;
    			}
    			
    			minSetpNo	=  boardService.selectBbsBoardMinNoRow(tableName, step, minSetp, requestMap.getInt("depth")+1);
    			
    		}
    		
    		depth = requestMap.getInt("depth")+1;
    		String depthTwo =Integer.toString(depth);
    		
    		if(minSetpNo == 0){
    			minSetpNo = step;
    		}
    		
    		rplayStep = minSetpNo - Math.pow(0.01, Double.parseDouble(depthTwo));

    		requestMap.setDouble("step", rplayStep);
    		requestMap.setInt("depth", depth);
    		
    		//답글등록
    		boardService.insertBbsBoard(requestMap);
    		
			requestMap.setString("msg","등록하였습니다.");
			
			//파일넘버값을 셋시킨다
			requestMap.setInt("fileGroupNo",fileGroupNo);
		}
	}
	
	@RequestMapping(value="/homepageMgr/board/bbs.do", params="mode=bbsBoardExec")
	public String bbsBoardExec(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			) throws Exception{
		
		DataMap requestMap = cm.getDataMap();
		
		//사용자 게시판 상세 페이지
		bbsBoardExec(model, requestMap, cm.getLoginInfo());
		
		return findView(requestMap.getString("mode"), "/homepageMgr/board/bbs/exec");
	}

}
