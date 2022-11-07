package loti.homeFront.web;

import java.io.IOException;
import java.io.InputStream;
import java.math.BigDecimal;

import javax.servlet.http.HttpServletRequest;

import loti.common.service.CommonService;
import loti.homeFront.service.SupportService;
import loti.webzine.service.WebzineService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import ut.lib.exception.BizException;
import ut.lib.file.FileUtil;
import ut.lib.login.LoginInfo;
import ut.lib.support.CommonMap;
import ut.lib.support.DataMap;
import ut.lib.util.Constants;
import ut.lib.util.Util;

import common.controller.BaseController;

@Controller
public class SupportController extends BaseController{

	@Autowired
	private SupportService supportService;
	
	@Autowired
	private CommonService commonService;
	
	@Autowired
	private WebzineService webzineService;
	
	@ModelAttribute("cm")
	public CommonMap common(
				CommonMap cm
				, HttpServletRequest request
			){
		/**
		 * 필수
		 */
		cm.getDataMap().setNullToInitialize(true);				
		String mode = Util.getValue(cm.getDataMap().getString("mode"));			

		
		/**
		 * 로그인 체크
		 */
		LoginInfo loginInfo = (LoginInfo)request.getAttribute("LOGIN_INFO");
		if(loginInfo.isLogin() == false){
			// 로그인 안되어 있음
			System.out.println("로그인 안되어 있음");
			
			cm.getDataMap().setString("userId","");
			cm.getDataMap().setString("isAdminYn", "N");
		} else {
			cm.getDataMap().setString("userId",loginInfo.getSessUserId());
			cm.getDataMap().setString("userno", loginInfo.getSessNo());
			cm.getDataMap().setString("userName", loginInfo.getSessName());
			cm.getDataMap().setString("isAdminYn", loginInfo.getSessAdminYN());
			
		}

		/**
		 * 페이징 필수
		 */
		// 페이지
		if (cm.getDataMap().getString("currPage").equals("")){
			cm.getDataMap().setInt("currPage", 1);
		}
		// 페이지당 보여줄 갯수
		if (cm.getDataMap().getString("rowSize").equals("")){
			cm.getDataMap().setInt("rowSize", 10); 
		}
		// 페이지 블럭 갯수
		if (cm.getDataMap().getString("pageSize").equals("")){
			cm.getDataMap().setInt("pageSize", 10);
		}		
		
		// 리퀘스트 정보를 담고있는 DataMap을 Attribute 에 추가
		request.setAttribute("REQUEST_DATA", cm.getDataMap());
		// 로그인 정보 넘기기
		request.setAttribute("LOGIN_INFO", loginInfo);
		
		log.info("mode="+mode);
		
		return cm;
	}
	
	public void boardList(Model model, DataMap requestMap, String tableName) throws Exception{
		
		DataMap listMap = null;
		
		/**
		 * 페이징 필수
		 */
		// 페이지
		if (requestMap.getString("currPage").equals("")){
			requestMap.setInt("currPage", 1);
		}
		// 페이지당 보여줄 갯수
		if (requestMap.getString("rowSize").equals("")){
			requestMap.setInt("rowSize", 10); 
		}
		// 페이지 블럭 갯수
		if (requestMap.getString("pageSize").equals("")){
			requestMap.setInt("pageSize", 10);
		}
		
		// 리스트 가져오기
		
		requestMap.setString("key",commonService.keywordFilter(requestMap.getString("key")));
		requestMap.setString("search",commonService.keywordFilter(requestMap.getString("search")));
		
		listMap = supportService.boardList(tableName, requestMap);
		model.addAttribute("LIST_DATA", listMap);
	}
	
	private void boardView(Model model, DataMap requestMap) throws Exception {

		DataMap viewMap = null;
		DataMap memberMap = null;

		// 로그인후 회원정보에 관련된 내용을 가져오는 부분 
		if (!requestMap.getString("qu").equals("selectBbsBoardview") && !requestMap.getString("qu").equals("insertBbsBoardForm")){
			if (requestMap.getString("userId").length() > 0){
				memberMap = supportService.memberView(requestMap.getString("userId"));
			} else {
				memberMap = new DataMap();
			}
		} else {
			memberMap = new DataMap();
		}
		
		if(requestMap.getString("qu").equals("insertBbsBoardForm")){
			//인서트폼일경우 모든데이터를 초기화 시킨다.
			viewMap = new DataMap();
		}else{//수정폼이거나 또는 뷰페이지, 답글일경우
			
			if(requestMap.getString("qu").equals("selectBbsBoardview")){
				requestMap.setString("seq", commonService.keywordFilter(requestMap.getString("seq")));
				
				//카운터값
				String query = "SELECT VISIT FROM TB_BOARD_" +requestMap.getString("boardId") + " WHERE SEQ =" + requestMap.getString("seq");
				int visit = supportService.selectBbsBoardCount(query);
				//테이블네임 지정
				String tableName = "TB_BOARD_"+requestMap.getString("boardId");
		
				//업데이트시작
				supportService.updateBbsBoardVisit(visit, tableName, requestMap.getString("seq"));
			}
			
			//게시물 상세 정보
			viewMap = supportService.selectbbsBoardView(requestMap.getString("boardId"),requestMap.getString("seq"));
			//log.info("확인 ==>" + viewMap.get("groupfileNo"));
			//log.info(" 게시물 wuserno = " + viewMap.get("topuserno"));
			//viewMap.getString("topuserno", 0)
			//log.info("============================= 로그인 memberMap= "+requestMap.getString("userno").replaceAll("\\s", ""));
			//log.info("============================= 작성자 정보= "+viewMap.getString("wuserno").replaceAll("\\s", ""));
			model.addAttribute("wuserno",viewMap.getString("wuserno"));
			model.addAttribute("suserno",requestMap.getString("userno"));
			if (!requestMap.getString("userno").replaceAll("\\s", "").equals(viewMap.getString("wuserno").replaceAll("\\s", ""))){
				model.addAttribute("USERIDSYNC", "N");
				//System.out.println("========================== 아이디 틀림 ================================");
			}else {
				if (requestMap.getString("boardId").equals("QNA")) {
					
					if (requestMap.getString("userno") == null  ||  requestMap.getString("userno") == "") {
						model.addAttribute("USERIDSYNC", "C");
					} else if (viewMap.get("topuserno").equals(requestMap.getString("userno")) || requestMap.getString("userno").equals("A000000000000")) {
						model.addAttribute("USERIDSYNC", "Y");
					} else {				
						model.addAttribute("USERIDSYNC", "N");
					}
				}else if(requestMap.getString("boardId").equals("EPILOGUE")){
					if (requestMap.getString("userno") == null  ||  requestMap.getString("userno") == "") {
						model.addAttribute("USERIDSYNC", "C");
					} else if (viewMap.get("topuserno").equals(requestMap.getString("userno"))) {
						model.addAttribute("USERIDSYNC", "Y");
					} else {	
						if(viewMap.get("topuserno").equals("A000000000000")){
							model.addAttribute("USERIDSYNC", "Y");
						}else{
							model.addAttribute("USERIDSYNC", "N");
						}
					}
				}
			}
			
			
			// 파일 정보 가져오기.fileGroupList
			
			if(requestMap.getString("qu").equals("insertReplyBbsBoard")){
				viewMap.put("groupfileNo", 0);
			} else {
				viewMap.put("groupfileNo",Util.parseInt(viewMap.get("groupfileNo")+"",0));
			}
			
			if((Integer)viewMap.getInt("groupfileNo") > 0){
			 	commonService.selectUploadFileList(viewMap);
			}
			
		}
		
		model.addAttribute("MEMBER_DATA",memberMap);
		model.addAttribute("BOARDVIEW_DATA", viewMap);
		model.addAttribute("boardId",requestMap.getString("boardId"));
	}
	
	public String findView(String mode, String view){
		if("loginForm".equals(mode)){
			return "/homepage/bbs/loginForm";
		}
		return view;
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
	public void boardExec(CommonMap cm) throws Exception {
		
		DataMap requestMap = cm.getDataMap();
		
		LoginInfo loginInfo = cm.getLoginInfo();
		
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
			
			Util.saveDaumContent(requestMap, "content", "namoContent", Constants.NAMOUPLOAD_NOTICE);
			
			// Util.saveNamoContent(requestMap, "content", "namoContent", Constants.NAMOUPLOAD_NOTICE); //나모로 넘어온값 처리.
		}
		
		if(requestMap.getString("qu").equals("insertBbsBoardForm")){
			
			//사용자글 등록
			String query = "SELECT NVL(MAX(SEQ), 0) AS COUNT FROM TB_BOARD_"+requestMap.getString("boardId");
			
			//seq 카운터
			int seqCoutn = supportService.selectBbsBoardCount(query);
			
			//시퀀스값을 셋킨다
			requestMap.setInt("seq", (seqCoutn+1));
			//setp값을 셋시킨다.
			requestMap.setInt("step", (seqCoutn+1));
			
			//depth값이 널일경우 초기값을 셋시킨다. 초기값은 0.0이다
			if(requestMap.getString("depth").equals("")){
				requestMap.setInt("depth",0);
			}

			// 전화번호 값을 고정 시킨다
			if (requestMap.getString("homeTel_1").length() > 0){
				requestMap.setString("homeTel",requestMap.getString("homeTel_1")+"-"+requestMap.getString("homeTel_2")+"-"+requestMap.getString("homeTel_3"));
			} else {
				requestMap.setString("homeTel","");
			}
						
			//파일넘버값을 셋시킨다
			requestMap.setInt("fileGroupNo",fileGroupNo);
			
			if (loginInfo.isLogin() != false){
				requestMap.setString("wuserno",loginInfo.getSessNo());
				requestMap.setString("username",loginInfo.getSessName());
			} else {
				requestMap.setString("wuserno","9999999999999");
			}
			
			requestMap.setInt("groupfileNo",fileGroupNo);
			
			supportService.insertBbsBoard(requestMap);
			requestMap.setString("msg","등록하였습니다.");
			
		}else if(requestMap.getString("qu").equals("deleteBbsBoard")){
			
			System.out.println("step value : "+requestMap.getDouble("step"));
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
			DataMap rowMap = supportService.selectbbsBoardView(requestMap.getString("boardId"),requestMap.getString("seq"));
			rowMap.setNullToInitialize(true);
			
			boolean delOk = true;
			/*if (loginInfo.isLogin() == false){
				if ((rowMap.getString("passwd")).length() > 0 && rowMap.getString("passwd").equals(requestMap.getString("passwd"))){
					delOk = true;
				}
			} else {
				if (loginInfo.getSessNo().equals(rowMap.get("wuserno"))){
					delOk = true;
				}
			}*/
			// 로그인 세션 넘버가 동일하거나 삭제 패스워드가 동일한 경우 삭제
			if (delOk == true){	
				//물리 파일삭제
				if(((BigDecimal)rowMap.get("groupfileNo")).intValue() > 0){
					FileUtil.commonDeleteGroupfile(Integer.valueOf(rowMap.getString("groupfileNo")));
				}
				
				
				int count  = supportService.selectBbsBoardCountBetweenStep(requestMap.getString("boardId"), step, minSetp);
				
				requestMap.setInt("count", count);
				requestMap.setString("sessNo",loginInfo.getSessNo());
				
				supportService.deleteBbsBoard(requestMap);
				
				requestMap.setString("msg","삭제하였습니다.");
			} else {
				requestMap.setString("msg","삭제에 실패하였습니다. 권한이 없습니다.");
			}
			
			
		}else if(requestMap.getString("qu").equals("modifyBbsBoard")){
			//게시물 상세 정보
			System.out.println("1");
			DataMap rowMap = supportService.selectbbsBoardView(requestMap.getString("boardId"),requestMap.getString("seq"));
			rowMap.setNullToInitialize(true);
			boolean delOk = false;
			System.out.println("2");
			
			if (loginInfo.isLogin() == false){
				System.out.println("3");
				System.out.println(rowMap.get("username"));
				System.out.println(requestMap.getString("username"));
				System.out.println(rowMap.get("passwd"));
				System.out.println(requestMap.getString("passwd"));
				if (rowMap.getString("username").equals(requestMap.getString("username")) && rowMap.getString("passwd").equals(requestMap.getString("passwd"))){
					delOk = true;
				}
				System.out.println("4");
			} else {
				if (loginInfo.getSessNo().equals(rowMap.get("wuserno"))){
					delOk = true;
				}
			}
			System.out.println("5");
			// 로그인 세션 넘버가 동일하거나 삭제 패스워드가 동일한 경우 수정
			if (delOk == true){	
				if(requestMap.getString("boardId").equals("EPILOGUE")){
					supportService.modifyBbsBoardEpilogue(requestMap, fileGroupNo);
				}else{
					supportService.modifyBbsBoard(requestMap.getString("boardId"), 
													 requestMap.getString("title"),
													 requestMap.getString("namoContent"),
													 requestMap.getInt("seq"),
													 fileGroupNo);
				}
			
				requestMap.setString("msg","수정하였습니다.");
			} else {
				requestMap.setString("msg","권한이 없습니다.");
			}
			System.out.println("6");
				
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
			int seqCoutn = supportService.selectBbsBoardCount(query);
			
			//시퀀스값을 셋킨다
			requestMap.setInt("seq", seqCoutn+1);
			//파일넘버값을 셋시킨다
			requestMap.setInt("fileGroupNo",fileGroupNo);
			
			if (loginInfo.isLogin() != false){
				//현재 유저넘버 셋
				requestMap.setString("wuserno",loginInfo.getSessNo());
				//현재 유저네임 셋
				requestMap.setString("username",loginInfo.getSessName());
			} else {
				requestMap.setString("wuserno","9999999999999");
			}
			
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
	    		
	    		minSetpNo	=  supportService.selectBbsBoardMinNoRow(tableName, step, minSetp, requestMap.getInt("depth")+1);
	    		/*
	    		 * 
	    		 * 확인해봐야할부분
	    		if(minSetpNo == 0 && step <= 1){
	    			minSetpNo = minSetp;
	    			
	    		}else{
	    			minSetpNo = step;
	    		}
	    		*/
    		}else if(requestMap.getInt("depth") > 0){
    			
    			if(step >= 1){
    				minSetp	= step-1;
    			}else{
    				minSetp = 0.0;
    			}
    			
    			minSetpNo	=  supportService.selectBbsBoardMinNoRow(tableName, step, minSetp, requestMap.getInt("depth")+1);
    			
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
    		supportService.insertBbsBoard(requestMap);
    		
			requestMap.setString("msg","등록하였습니다.");
			
			//파일넘버값을 셋시킨다
			requestMap.setInt("fileGroupNo",fileGroupNo);
		}
	}
	
	public void complateList(CommonMap cm, Model model) throws BizException {
		
		DataMap requestMap = cm.getDataMap();
		
		if (requestMap.getString("currPage").equals("")) {
			requestMap.setInt("currPage", 1);
		}
		if (requestMap.getString("rowSize").equals("") || requestMap.getString("rowSize").equals("10")) { // 10개일경우 9개로 변경
			requestMap.setInt("rowSize", 9);
		}
		if (requestMap.getString("pageSize").equals("")) {
			requestMap.setInt("pageSize", 10);
		}
		
		DataMap listMap = webzineService.selectComplateList(requestMap);
		model.addAttribute("LIST_DATA", listMap);
	}
	
	
	@RequestMapping(value="/homepage/support.do", params="mode=requestList")
	public String requestList(
				@ModelAttribute("cm") CommonMap cm
				, Model model
			) throws Exception{
		
		String tableName = "TB_BOARD_QNA";
		boardList(model, cm.getDataMap(), tableName);
		
		return "/homepage/bbs/requestList";
	}
	
	@RequestMapping(value="/homepage/support.do", params="mode=requestView")
	public String requestView(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			) throws Exception{
		
		boardView(model, cm.getDataMap());
		
		return "/homepage/bbs/requestView";
	}
	
	@RequestMapping(value="/homepage/support.do", params="mode=requestWrite")
	public String requestWrite(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			, @RequestParam("mode") String mode
			) throws Exception{
		
		if(cm.getLoginInfo().isLogin() != false || !cm.getDataMap().getString("guest").equals("")){
			boardView(model, cm.getDataMap());
		} else {
			cm.getDataMap().setString("url",mode);
			mode = "loginForm";
		}
		
		return findView(mode, "/homepage/bbs/requestForm");
	}
	
	@RequestMapping(value="/homepage/support.do", params="mode=requestModify")
	public String requestModify(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			, @RequestParam("mode") String mode
			, HttpServletRequest request
			) throws Exception{
		if(cm.getLoginInfo().isLogin() != false || !cm.getDataMap().getString("guest").equals("")){
			boardView(model, cm.getDataMap());
			System.out.println("====================================== suserno : " + request.getAttribute("suserno"));
			System.out.println("====================================== wuserno : " + request.getAttribute("wuserno"));
		} else {
			cm.getDataMap().setString("url",mode);
			mode = "loginForm";
		}
		
		
		return findView(mode, "/homepage/bbs/requestForm");
	}
	
	@RequestMapping(value="/homepage/support.do", params="mode=requestDelete")
	public String requestDelete(
			@RequestParam("mode") String mode
			) throws BizException{
		
		return findView(mode, "/homepage/bbs/requestForm");
	}
	
	@RequestMapping(value="/homepage/support.do", params="mode=requestExec", consumes={MediaType.MULTIPART_FORM_DATA_VALUE})
	public String requestDelete(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			, @RequestParam("mode") String mode
			) throws Exception{
		
		boardExec(cm);
		
		return findView(mode, "/homepage/bbs/requestExec");
	}
	
	@RequestMapping(value="/homepage/support.do", params="mode=readList")
	public String readList(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			, @RequestParam("mode") String mode
			) throws Exception{

		boardList(model, cm.getDataMap(), "TB_BOARD_READING");
		
		return findView(mode, "/homepage/bbs/readList");
	}
	
	@RequestMapping(value="/homepage/support.do", params="mode=webzine")
	public String webzine(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			, @RequestParam("mode") String mode
			) throws Exception{
		
		complateList(cm, model);
		
		return findView(mode, "/homepage/bbs/webzine");
	}
	
	@RequestMapping(value="/homepage/support.do", params="mode=programList")
	public String programList(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			, @RequestParam("mode") String mode
			) throws Exception{
		
		boardList(model, cm.getDataMap(), "TB_BOARD_DATA");
		
		return findView(mode, "/homepage/bbs/programList");
	}
	
	@RequestMapping(value="/homepage/support.do", params="mode=programView")
	public String programView(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			, @RequestParam("mode") String mode
			) throws Exception{
		
		boardView(model, cm.getDataMap());
		
		return findView(mode, "/homepage/bbs/programView");
	}
	
	void faqList(DataMap requestMap, Model model) throws Exception{
		
		//	초기화 옵션(true 일경우 데이터를 뽑을때 null 일경우 초기화 - 빈문자열, 0....)
		requestMap.setNullToInitialize(true);
		
		if (requestMap.getString("currPage").equals("")) {
			requestMap.setInt("currPage", 1);
		}
		if (requestMap.getString("rowSize").equals("")) {
			requestMap.setInt("rowSize", 15);
		}
		if (requestMap.getString("pageSize").equals("")) {
			requestMap.setInt("pageSize", 10);
		}
		

		requestMap.setString("question", commonService.keywordFilter(requestMap.getString("question")));
		requestMap.setString("selectType",commonService.keywordFilter(requestMap.getString("selectType")));
		
		DataMap listMap = supportService.selectFaqList(requestMap);
		DataMap faqListMap = supportService.selectSubCodeFaqList();
		
		model.addAttribute("LIST_DATA", listMap);
		model.addAttribute("FAQLIST_DATA", faqListMap);
	}
	
	@RequestMapping(value="/homepage/support.do", params="mode=faqList")
	public String faqList(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			, @RequestParam("mode") String mode
			) throws Exception{
		
		faqList(cm.getDataMap(), model);
		
		return findView(mode, "/homepage/bbs/faqList");
	}
	
	void selectFaqViewRow(DataMap requestMap, Model model) throws Exception{
		//	초기화 옵션(true 일경우 데이터를 뽑을때 null 일경우 초기화 - 빈문자열, 0....)
		requestMap.setNullToInitialize(true);
		
		DataMap faqRowMap = supportService.selectFaqViewRow(requestMap.getString("fno"));
		
		//카운터수 수정
		supportService.modifyFaqFno(requestMap.getInt("fno"));
		
		model.addAttribute("FAQROW_DATA", faqRowMap);
	}
	
	@RequestMapping(value="/homepage/support.do", params="mode=faqView")
	public String faqView(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			, @RequestParam("mode") String mode
			) throws Exception{
		
		selectFaqViewRow(cm.getDataMap(), model);
		
		return findView(mode, "/homepage/bbs/faqView");
	}
	
	@RequestMapping(value="/homepage/support.do", params="mode=readView")
	public String readView(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			, @RequestParam("mode") String mode
			) throws Exception{
		
		boardView(model, cm.getDataMap());
		
		return findView(mode, "/homepage/bbs/readView");
	}
	
	@RequestMapping(value="/homepage/support.do", params="mode=educationDataList")
	public String educationDataList(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			, @RequestParam("mode") String mode
			) throws Exception{
		
		boardList(model, cm.getDataMap(), "TB_BOARD_EDU_DATA");
		
		return findView(mode, "/homepage/bbs/educationDataList");
	}
	
	@RequestMapping(value="/homepage/support.do", params="mode=educationDataView")
	public String educationDataView(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			, @RequestParam("mode") String mode
			) throws Exception{
		
		boardView(model, cm.getDataMap());
		
		return findView(mode, "/homepage/bbs/educationDataView");
	}
	
	@RequestMapping(value="/homepage/support.do", params="mode=lectureList")
	public String lectureList(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			, @RequestParam("mode") String mode
			) throws Exception{
		
		boardList(model, cm.getDataMap(), "TB_BOARD_LEC_BOOK");
		
		return findView(mode, "/homepage/bbs/lectureList");
	}
	
	@RequestMapping(value="/homepage/support.do", params="mode=lectureView")
	public String lectureView(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			, @RequestParam("mode") String mode
			) throws Exception{
		
		boardView(model, cm.getDataMap());
		
		return findView(mode, "/homepage/bbs/lectureView");
	}
	
	@RequestMapping(value="/homepage/support.do", params="mode=noticeList")
	public String noticeList(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			, @RequestParam("mode") String mode
			) throws Exception{
		
		boardList(model, cm.getDataMap(), "TB_BOARD_NOTICE");
		
		return findView(mode, "/homepage/bbs/noticeList");
	}
	
	@RequestMapping(value="/homepage/support.do", params="mode=noticeView")
	public String noticeView(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			, @RequestParam("mode") String mode
			) throws Exception{
		
		boardView(model, cm.getDataMap());
		
		return findView(mode, "/homepage/bbs/noticeListView");
	}
	
	@RequestMapping(value="/homepage/support.do", params="mode=freeBoardList")
	public String freeBoardList(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			, @RequestParam("mode") String mode
			) throws Exception{
		
		boardList(model, cm.getDataMap(), "TB_BOARD_BBS");
		
		return findView(mode, "/homepage/bbs/freeBoardList");
	}
	
	@RequestMapping(value="/homepage/support.do", params="mode=freeBoardView")
	public String freeBoardView(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			, @RequestParam("mode") String mode
			) throws Exception{
		
		boardView(model, cm.getDataMap());
		
		return findView(mode, "/homepage/bbs/freeBoardView");
	}
	
	@RequestMapping(value="/homepage/support.do", params="mode=freeBoardWrite")
	public String freeBoardWrite(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			, @RequestParam("mode") String mode
			) throws Exception{
		
		if(cm.getLoginInfo().isLogin() != false || !cm.getDataMap().getString("guest").equals("")){
			boardView(model, cm.getDataMap());
		} else {
			cm.getDataMap().setString("url",mode);
			mode = "loginForm";
		}
		
		return findView(mode, "/homepage/bbs/freeBoardForm");
	}
	
	@RequestMapping(value="/homepage/support.do", params="mode=eduinfo5-1")
	public String eduinfo51(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			, @RequestParam("mode") String mode
			) throws Exception{
		
		return findView(mode, "/homepage/eduInfo/eduinfo5-1");
	}
	
	@RequestMapping(value="/homepage/support.do", params="mode=eduinfo5-2")
	public String eduinfo52(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			, @RequestParam("mode") String mode
			) throws Exception{
		
		return findView(mode, "/homepage/eduInfo/eduinfo5-2");
	}
	
	@RequestMapping(value="/homepage/support.do", params="mode=opencourse")
	public String opencourse(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			) throws Exception{
		
		DataMap requestMap = cm.getDataMap();
		
		requestMap.setString("search",commonService.keywordFilter(requestMap.getString("search")));
		
		model.addAttribute("OPEN_COURSE_LIST", supportService.getOpenCourseList(requestMap));
		
		return findView(requestMap.getString("mode"), "/homepage/bbs/opencourse");
	}
	
	/*@RequestMapping(value="/homepage/support.do", params="mode=opencourseview")
	public String opencourseview(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			, @RequestParam("mode") String mode
			, @RequestParam("subjnm") String subjnm
			, @RequestParam("subj") String subj
			) throws Exception{
		
		model.addAttribute("subjnm", subjnm);
		
		model.addAttribute("OPEN_COURSE_VIEW", supportService.getOpenCourseView(subj));
		
		return findView(mode, "/homepage/bbs/opencourseview");
	}*/
	
	// 실명 인증 프로세서를 실행하여 맞는지 틀린지 값을 가져오는 부분
	// 프로세서 경로를 확인 못하여 실서버 적용시 위치확인 필요함
	public String realName(String strName, String strJumin){
		
		String siteID = "D523";
		String sitePW = "12916201";
		
		// 경로를 확인해서 수정해주어야함 현재 상대경로
		String cmd = "/app1/apache/htdocs/Authority/cb_namecheck "+siteID+" "+sitePW+" "+strJumin+" "+strName;
		Process p = null;
		String returnData = "";

		try {

			p = Runtime.getRuntime().exec(cmd);
			InputStream in = p.getInputStream();

			int i;
			while ((i=in.read()) != -1) {
				returnData += (char)i;
			}
			
		} catch (IOException e) {
			System.out.println(e.toString());
		}
		
		return returnData;

	}
	
	@RequestMapping(value="/homepage/support.do", params="mode=authCheckAjax")
	public String authCheckAjax(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			, @RequestParam("mode") String mode
			, @RequestParam("resno") String resno
			, @RequestParam("name") String name
			, @RequestParam("dupinfo") String dupinfo
			) throws Exception{
		
		String result="5";
		result = realName(name, resno);
		
		log.debug("========= resno : "+resno);
		log.debug("========= name : "+name);
		log.debug("========= dupinfo : "+dupinfo);
		log.debug("========= result : "+result);
		/**
		 * 0 기본값
		 * 1 본인 맞음
		 * 2 본인 아님
		 * 3 자료없음
		 */
		if("2".equals(result)){
			result = "2";
		} else {
			
			int existResno = supportService.countExistResno(resno);
			int existDupinfo = supportService.countExistDupinfo(dupinfo);
			
			//조건을 걸어준다.
			if(existResno == 0){
				if(existDupinfo != 0){
					result = "1000";
				}
			}else if(existDupinfo != 0 ) {
				if(existDupinfo == 0){
					result = "1000";
				}
				result = "1000";
			}
		}
		
		model.addAttribute("result", result);
		
		return findView(mode, "/login/authCheckAjax");
	}
	
	@RequestMapping(value="/homepage/support.do", params="mode=authCheckAjax3")
	public String authCheckAjax3(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			, @RequestParam("resno") String resno
			, @RequestParam("name") String name
			) throws Exception{
		
		System.out.println("========== authCheckAjax Start ===========");
		
		String result="5";
		result = realName(name, resno);
		String mode = "authCheckAjax";
		model.addAttribute("result", result);
		
		return findView(mode, "/login/authCheckAjax");
	}
	
	@RequestMapping(value="/homepage/support.do", params="mode=freeBoardReWrite")
	public String freeBoardReWrite(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			) throws Exception{
		
		DataMap requestMap = cm.getDataMap();
		LoginInfo loginInfo = cm.getLoginInfo();
		String mode = requestMap.getString("mode");
		
		if(loginInfo.isLogin() != false || !requestMap.getString("guest").equals("")){
			boardView(model, requestMap);
		} else {
			requestMap.setString("url",mode);
			mode = "loginForm";
		}
		
		return findView(mode, "/homepage/bbs/freeBoardForm");
	}
	
	@RequestMapping(value="/homepage/support.do", params="mode=freeBoardModify")
	public String freeBoardModify(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			) throws Exception{
		
		DataMap requestMap = cm.getDataMap();
		LoginInfo loginInfo = cm.getLoginInfo();
		
		if(loginInfo.isLogin() != false || !requestMap.getString("guest").equals("")){
			boardView(model, requestMap);
		} else {
			requestMap.setString("url",requestMap.getString("mode"));
			requestMap.setString("mode", "loginForm");
		}
		
		return findView(requestMap.getString("mode"), "/homepage/bbs/freeBoardForm");
	}
	
	@RequestMapping(value="/homepage/support.do", params="mode=freeBoardDelete")
	public String freeBoardDelete(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			) throws Exception{
		
		DataMap requestMap = cm.getDataMap();
		
		return findView(requestMap.getString("mode"), "/homepage/bbs/freeBoardForm");
	}
	
	@RequestMapping(value="/homepage/support.do", params="mode=freeBoardExec")
	public String freeBoardExec(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			) throws Exception{
		
		DataMap requestMap = cm.getDataMap();
		
		boardExec(cm);
		
		return findView(requestMap.getString("mode"), "/homepage/bbs/freeBoardExec");
	}
	
	@RequestMapping(value="/homepage/support.do", params="mode=readWrite")
	public String readWrite(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			) throws Exception{
		
		DataMap requestMap = cm.getDataMap();
		LoginInfo loginInfo = cm.getLoginInfo();
		
		if(loginInfo.isLogin() != false || !requestMap.getString("guest").equals("")){
			boardView(model, requestMap);
		} else {
			requestMap.setString("url",requestMap.getString("mode"));
			requestMap.setString("mode", "loginForm");
		}
		
		return findView(requestMap.getString("mode"), "/homepage/bbs/readForm");
	}
	
	@RequestMapping(value="/homepage/support.do", params="mode=readModify")
	public String readModify(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			) throws Exception{
		
		DataMap requestMap = cm.getDataMap();
		LoginInfo loginInfo = cm.getLoginInfo();
		
		if(loginInfo.isLogin() != false || !requestMap.getString("guest").equals("")){
			boardView(model, requestMap);
		} else {
			requestMap.setString("url",requestMap.getString("mode"));
			requestMap.setString("mode", "loginForm");
		}
		
		return findView(requestMap.getString("mode"), "/homepage/bbs/readForm");
	}
	
	@RequestMapping(value="/homepage/support.do", params="mode=readDelete")
	public String readDelete(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			) throws Exception{
		
		DataMap requestMap = cm.getDataMap();
		
		return findView(requestMap.getString("mode"), "/homepage/bbs/readForm");
	}
	
	@RequestMapping(value="/homepage/support.do", params="mode=readExec")
	public String readExec(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			) throws Exception{
		
		DataMap requestMap = cm.getDataMap();
		
		boardExec(cm);
		
		return findView(requestMap.getString("mode"), "/homepage/bbs/readExec");
	}
	
	@RequestMapping(value="/homepage/support.do", params="mode=loginForm")
	public String loginForm(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			) throws Exception{
		
		DataMap requestMap = cm.getDataMap();
		
		return findView(requestMap.getString("mode"), "/homepage/bbs/loginForm");
	}
	
	/*
	 * 실명확인 프로세스를 통해 실명인지 아닌지 확인 하는 부분
	 * 
	 * 
	 */
	public void nameCheck(
	          DataMap requestMap) throws Exception {
		
		String msg = "";	//실명인증 성공여부
		String checkName = requestMap.getString("checkName");
		String checkJumin = requestMap.getString("juminNum1")+requestMap.getString("juminNum2");

		msg = realName(checkName, checkJumin);
		
		requestMap.setString("msg",msg);
	}
	
	@RequestMapping(value="/homepage/support.do", params="mode=realNameCheck")
	public String realNameCheck(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			) throws Exception{
		
		DataMap requestMap = cm.getDataMap();
		
		nameCheck(requestMap);
		
		return findView(requestMap.getString("mode"), "/homepage/bbs/loginExec");
	}
	
	/**
	 * 사진관리 Row데이터
	 * 작성일 : 7월 2일
	 * 작성자 : 정 윤철
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	public void complateForm(
			Model model
	        , DataMap requestMap) throws Exception {
	
		DataMap rowMap = null;
		
		if(requestMap.getString("qu").equals("modifyComplate") || requestMap.getString("qu").equals("preView")){
			rowMap = webzineService.selectComplateRow(requestMap.getInt("photoNo"));
		}else{
			rowMap = new DataMap();
		}
		model.addAttribute("PHOTOROW_DATA", rowMap);
	}
	
	@RequestMapping(value="/homepage/support.do", params="mode=preview")
	public String preview(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			) throws Exception{
		
		DataMap requestMap = cm.getDataMap();
		
		complateForm(model, requestMap);
		
		return findView(requestMap.getString("mode"), "/homepage/bbs/preView");
	}
	
	@RequestMapping(value="/homepage/support.do", params="mode=dupinfoCheckAjax")
	public String dupinfoCheckAjax(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			, @RequestParam(value="virtualno", required=false) String virtualno
			, @RequestParam(value="dupinfo", required=false) String dupinfo
			) throws Exception{
		
		DataMap requestMap = cm.getDataMap();
		
		System.out.println("========== dupinfoCheckAjax Start ===========");
		
		String result="5";
		
		System.out.println("========= dupinfo : "+dupinfo);
		System.out.println("========= result : "+result);
		
		int exsitVirtualno = supportService.countExistVirtualno(virtualno);
		int existDupinfo = supportService.countExistDupinfo(dupinfo);
		
		System.out.println("========= exsitVirtualno : "+exsitVirtualno);
		System.out.println("========= existDupinfo : "+existDupinfo);
		
		//조건을 걸어준다.
		if(exsitVirtualno == 0){
			if(existDupinfo != 0){
				result = "1000";
			}
			else{
				result = "5";
			}
		}else if(exsitVirtualno != 0 ) {
			if(existDupinfo == 0){
				result = "1000";
			}
			else{
				result = "1000";
			}
		}
		
		System.out.println("================ result : "+result);
		
		model.addAttribute("result", result);
		
		return findView(requestMap.getString("mode"), "/login/dupinfoCheckAjax");
	}
	
	@RequestMapping(value="/homepage/support.do", params="mode=dupinfoCheckAjax2")
	public String dupinfoCheckAjax2(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			, @RequestParam(value="virtualno", required=false) String virtualno
			, @RequestParam(value="dupinfo", required=false) String dupinfo
			) throws Exception{
		
		DataMap requestMap = cm.getDataMap();
		
		String result="5";
		
		int existDupinfo = supportService.countExistDupinfo(dupinfo);
		
		if(existDupinfo != 0){
			result = "1000";
		}
		else{
			result = "5";
		}
		
		requestMap.setString("mode", "dupinfoCheckAjax");
		
		model.addAttribute("result", result);
		
		return findView(requestMap.getString("mode"), "/login/dupinfoCheckAjax");
	}
	
	
	@RequestMapping(value="/homepage/support.do", params="mode=epilogueList")
	public String epilogueList(
				@ModelAttribute("cm") CommonMap cm
				, Model model
			) throws Exception{
		
		String tableName = "TB_BOARD_EPILOGUE";
		boardList(model, cm.getDataMap(), tableName);
		
		return "/homepage/bbs/epilogueList";
	}
	
	@RequestMapping(value="/homepage/support.do", params="mode=epilogueView")
	public String epilogueView(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			) throws Exception{
		
		boardView(model, cm.getDataMap());
		
		return "/homepage/bbs/epilogueView";
	}
	
	@RequestMapping(value="/homepage/support.do", params="mode=epilogueWrite")
	public String epilogueWrite(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			, @RequestParam("mode") String mode
			) throws Exception{
		
		if(cm.getLoginInfo().isLogin() != false || !cm.getDataMap().getString("guest").equals("")){
			DataMap requestMap = cm.getDataMap();
			DataMap sugangList = null;
			//수강 과정 리스트
			sugangList = supportService.selectMyGrCodeNmList(requestMap);
			model.addAttribute("sugangList", sugangList);
			
			boardView(model, cm.getDataMap());
		} else {
			cm.getDataMap().setString("url",mode);
			mode = "loginForm";
		}
		
		return findView(mode, "/homepage/bbs/epilogueForm");
	}
	
	@RequestMapping(value="/homepage/support.do", params="mode=epilogueModify")
	public String epilogueModify(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			, @RequestParam("mode") String mode
			) throws Exception{
		
		if(cm.getLoginInfo().isLogin() != false || !cm.getDataMap().getString("guest").equals("")){
			DataMap requestMap = cm.getDataMap();
			DataMap sugangList = null;
			//수강 과정 리스트
			sugangList = supportService.selectMyGrCodeNmList(requestMap);
			model.addAttribute("sugangList", sugangList);
			boardView(model, cm.getDataMap());
		} else {
			cm.getDataMap().setString("url",mode);
			mode = "loginForm";
		}
		
		return findView(mode, "/homepage/bbs/epilogueForm");
	}
	
	/**
	 * 감사반장에 바란다. 사용자 정보 등록 화면
	 * @param cm
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/homepage/support.do", params="mode=personForm")
	public String personForm(
				@ModelAttribute("cm") CommonMap cm
				, Model model
				, @RequestParam("mode") String mode
			) throws Exception{
		DataMap requestMap = cm.getDataMap();
		log.debug("####################    감사반장에 바란다   #####################");
		
		DataMap viewMap = null;

		viewMap = new DataMap();
		String qu = "insertBbs";
		
		requestMap.setString("qu", qu);
		model.addAttribute("BOARDVIEW_DATA", viewMap);
		
		return findView(mode, "/homepage/bbs/personForm");
	}
	
	/**
	 * 감사반장에게 바란다 글등록 처리
	 * @param cm
	 * @param model
	 * @param mode
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/homepage/support.do", params="mode=personExec")
	public String personExec(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			, @RequestParam("mode") String mode
			) throws Exception{
		
		DataMap requestMap = cm.getDataMap();
		
		String qu = requestMap.getString("qu");
		
		if( qu.equals("insertBbs") || qu.equals("modifyBbs")){
			
			Util.saveDaumContent(requestMap, "content", "namoContent", Constants.NAMOUPLOAD_NOTICE);
		}
		
		if(requestMap.getString("qu").equals("insertBbs")){
			
			//사용자글 등록
			String query = "SELECT NVL(MAX(SEQ), 0) AS COUNT FROM TB_BOARD_PERSON";
			
			//seq 카운터
			int seqCoutn = 0;//supportService.selectBbsBoardPersonCount(query);
			
			//시퀀스값을 셋킨다
			requestMap.setInt("seq", (seqCoutn+1));
			
			// 전화번호 값을 고정 시킨다
//			if (requestMap.getString("homeTel_1").length() > 0){
//				requestMap.setString("homeTel",requestMap.getString("homeTel_1")+"-"+requestMap.getString("homeTel_2")+"-"+requestMap.getString("homeTel_3"));
//			} else {
//				requestMap.setString("homeTel","");
//			}
			
//			supportService.insertBbsBoardPerson(requestMap);
			requestMap.setString("msg","등록하였습니다.");
			
		}else if(requestMap.getString("qu").equals("deleteBbs")){
			
			DataMap rowMap = null;//supportService.selectbbsBoardPersonView(requestMap.getString("seq"));
			rowMap.setNullToInitialize(true);
			
			boolean delOk = false;
			if (rowMap.getString("username").equals(requestMap.getString("username")) && rowMap.getString("phone").equals(requestMap.getString("phone"))){
				delOk = true;
			}
			
			// 로그인 세션 넘버가 동일하거나 삭제 패스워드가 동일한 경우 삭제
			if (delOk == true){	
				//supportService.deleteBbsBoardPerson(requestMap);
				requestMap.setString("msg","삭제하였습니다.");
			} else {
				requestMap.setString("msg","삭제에 실패하였습니다. 권한이 없습니다.");
			}
			
		}else if(requestMap.getString("qu").equals("modifyBbs")){
			
			DataMap rowMap = null;//supportService.selectbbsBoardPersonView(requestMap.getString("seq"));
			rowMap.setNullToInitialize(true);
			boolean delOk = false;
			System.out.println("2");
			
			if (rowMap.getString("username").equals(requestMap.getString("username")) && rowMap.getString("phone").equals(requestMap.getString("phone"))){
				delOk = true;
			}
			
			System.out.println("####################### delOk : " + delOk);
			
			// 로그인 세션 넘버가 동일하거나 삭제 패스워드가 동일한 경우 수정
			if (delOk == true){	
//				supportService.modifyBbsBoardPerson(requestMap);
				requestMap.setString("msg","수정하였습니다.");
			} else {
				requestMap.setString("msg","권한이 없습니다.");
			}
			System.out.println("6");
		}
		
		return findView(mode, "/homepage/bbs/personExec");
	}
	
	@RequestMapping(value="/homepage/support.do", params="mode=personList")
	public String personList(
				@ModelAttribute("cm") CommonMap cm
				, Model model
			) throws Exception{
		
		DataMap requestMap = cm.getDataMap();
		DataMap listMap = null;
		
		/**
		 * 페이징 필수
		 */
		// 페이지
		if (requestMap.getString("currPage").equals("")){
			requestMap.setInt("currPage", 1);
		}
		// 페이지당 보여줄 갯수
		if (requestMap.getString("rowSize").equals("")){
			requestMap.setInt("rowSize", 10); 
		}
		// 페이지 블럭 갯수
		if (requestMap.getString("pageSize").equals("")){
			requestMap.setInt("pageSize", 10);
		}
		
		// 리스트 가져오기
//		listMap = supportService.boardPersonList(requestMap);
		model.addAttribute("LIST_DATA", listMap);
		
		return "/homepage/bbs/personList";
	}
	
	@RequestMapping(value="/homepage/support.do", params="mode=personView")
	public String personView(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			) throws Exception{
		
		DataMap requestMap = cm.getDataMap();
		DataMap viewMap = null;

		
		if(requestMap.getString("qu").equals("insertBbs")){
			//인서트폼일경우 모든데이터를 초기화 시킨다.
			viewMap = new DataMap();
		}else{//수정폼이거나 또는 뷰페이지, 답글일경우
			
			if(requestMap.getString("qu").equals("selectBbsview")){
				requestMap.setString("seq", commonService.keywordFilter(requestMap.getString("seq")));
			}
			//게시물 상세 정보
//			viewMap = supportService.selectbbsBoardPersonView(requestMap.getString("seq"));
			log.info("확인 ==>" + viewMap.get("groupfileNo"));
			
			log.info(" 게시물 wuserno = " + viewMap.get("topuserno"));
		}
		
		model.addAttribute("BOARDVIEW_DATA", viewMap);
		
		return "/homepage/bbs/personView";
	}
	
	@RequestMapping(value="/homepage/support.do", params="mode=personModify")
	public String personModify(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			, @RequestParam("mode") String mode
			) throws Exception{
		
		DataMap requestMap = cm.getDataMap();
		DataMap viewMap = null;

		
		if(requestMap.getString("qu").equals("insertBbs")){
			//인서트폼일경우 모든데이터를 초기화 시킨다.
			viewMap = new DataMap();
		}else{//수정폼이거나 또는 뷰페이지, 답글일경우
			
			if(requestMap.getString("qu").equals("selectBbsview")){
				requestMap.setString("seq", commonService.keywordFilter(requestMap.getString("seq")));
			}
			//게시물 상세 정보
//			viewMap = supportService.selectbbsBoardPersonView(requestMap.getString("seq"));
			log.info("확인 ==>" + viewMap.get("groupfileNo"));
			
			log.info(" 게시물 wuserno = " + viewMap.get("topuserno"));
		}
		
		model.addAttribute("BOARDVIEW_DATA", viewMap);
		
		return findView(mode, "/homepage/bbs/personForm");
	}

	@RequestMapping(value="/homepage/support.do", params="mode=etc")
	public String etc() throws BizException{
		
		return "/homepageMgr/popup/popupEtc";
	}

	@RequestMapping(value="/homepage/support.do", params="mode=etcCancel")
	public String etcCancel() throws BizException{

		System.out.println("==========================  popupEtcCancel  ============================= ");
		return "/homepageMgr/popup/popupEtcCancel";
	}
	
	@RequestMapping(value="/homepage/support.do", params="mode=etcexce")
	public String popupEctInsert(
			@ModelAttribute("cm") CommonMap cm
			, HttpServletRequest request
			, Model model
			, @RequestParam("mode") String mode
			) throws BizException{
		System.out.println("======================================================= ");
		DataMap requestMap = cm.getDataMap();
		System.out.println("======== requestMap =========== " + requestMap.toString());
		supportService.popupEctInsert(requestMap);
		
		return "/homepageMgr/popup/popupEtcSubmit";
	}
	
	@RequestMapping(value="/homepage/support.do", params="mode=uploadbbsList")
	public String uploadbbsList(
				@ModelAttribute("cm") CommonMap cm
				, Model model
			) throws Exception{
		
		String tableName = "TB_BOARD_UPLOAD";
		boardList(model, cm.getDataMap(), tableName);
		
		return "/homepage/bbs/uploadbbsList";
	}
	
	@RequestMapping(value="/homepage/support.do", params="mode=uploadView")
	public String uploadView(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			) throws Exception{
		
		boardView(model, cm.getDataMap());
		
		return "/homepage/bbs/uploadView";
	}
	
	@RequestMapping(value="/homepage/support.do", params="mode=uploadWrite")
	public String uploadWrite(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			, @RequestParam("mode") String mode
			) throws Exception{
		
		if(cm.getLoginInfo().isLogin() != false || !cm.getDataMap().getString("guest").equals("")){
			boardView(model, cm.getDataMap());
		} else {
			cm.getDataMap().setString("url",mode);
			mode = "loginForm";
		}
		
		return findView(mode, "/homepage/bbs/uploadForm");
	}
	
	@RequestMapping(value="/homepage/support.do", params="mode=uploadModify")
	public String uploadModify(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			, @RequestParam("mode") String mode
			, HttpServletRequest request
			) throws Exception{
		if(cm.getLoginInfo().isLogin() != false || !cm.getDataMap().getString("guest").equals("")){
			boardView(model, cm.getDataMap());
		} else {
			cm.getDataMap().setString("url",mode);
			mode = "loginForm";
		}
		
		
		return findView(mode, "/homepage/bbs/uploadForm");
	}
	
	@RequestMapping(value="/homepage/support.do", params="mode=uploadDelete")
	public String uploadDelete(
			@RequestParam("mode") String mode
			) throws BizException{
		
		return findView(mode, "/homepage/bbs/uploadForm");
	}
	
	@RequestMapping(value="/homepage/support.do", params="mode=uploadExec", consumes={MediaType.MULTIPART_FORM_DATA_VALUE})
	public String uploadDelete(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			, @RequestParam("mode") String mode
			) throws Exception{
		
		boardExec(cm);
		
		return findView(mode, "/homepage/bbs/uploadExec");
	}
}
