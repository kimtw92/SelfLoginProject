package loti.movieMgr.web;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import loti.common.service.CommonService;
import loti.movieMgr.service.MovieService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import ut.lib.exception.BizException;
import ut.lib.login.LoginCheck;
import ut.lib.login.LoginInfo;
import ut.lib.support.CommonMap;
import ut.lib.support.DataMap;
import common.controller.BaseController;

@Controller
public class MovieController extends BaseController {

	@Autowired
	private MovieService movieService;
	
	@Autowired
	private CommonService commonService;
	
	@ModelAttribute("cm")
	public CommonMap common(
				CommonMap cm
				, HttpServletRequest request
				, HttpServletResponse response
				, Model model
			) throws Exception{
		
		 //요청처리. 요청 파라미터를 DataMap에 저장
		DataMap requestMap = cm.getDataMap();
		//요청객체 초기화
		requestMap.setNullToInitialize(true);
		
		//관리자 로그인 체크(관리자 페이지 로직에는 모두 포함)
		LoginInfo memberInfo = LoginCheck.adminCheck(request, response, requestMap.getString("menuId"));
		if (memberInfo == null) return null;
		 
//		LoginInfo loginInfo = (LoginInfo)request.getAttribute("LOGIN_INFO");
//		if(loginInfo.isLogin() == false){
//			//로그인 안되어 있음
//			System.out.println("로그인 안되어 있음");
//			return null;
//			mode="LoginForm";
//		}
		
		//중메뉴 기본 모드 : list
		if(requestMap.getString("mode").equals("")) {
			requestMap.setString("mode", "list");
		}
		
		//정보 DataMap을 Attribute에 추가
		model.addAttribute("REQUEST_DATA", requestMap);
		
		return cm;
	}
	
	public String findView(String mode, String defaultView){
		return defaultView;
	}
	
	@RequestMapping(value="/movieMgr/movie.do")
	public String defaultProcess(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			) throws BizException{
		
		return list(cm, model);
	}
	
	@RequestMapping(value="/movieMgr/movie.do", params="mode=list")
	public String list(
				@ModelAttribute("cm") CommonMap cm
				, Model model
			) throws BizException{
		
		DataMap requestMap = cm.getDataMap();
		
		//분류 리스트
		DataMap listMap = null; 
		listMap = movieService.selectDivList(requestMap);
		
		model.addAttribute("LIST_DATA", listMap);
		
		return findView(requestMap.getString("mode"), "/movieMgr/movie/movDivList");
	}
	
	@RequestMapping(value="/movieMgr/movie.do", params="mode=divForm")
	public String divForm(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			) throws BizException{
		
		DataMap requestMap = cm.getDataMap();
		
		//분류 정보
		DataMap rowMap = movieService.selectDivRow(requestMap.getString("divCode"));
		if(rowMap == null) rowMap = new DataMap();
		rowMap.setNullToInitialize(true);
		
		model.addAttribute("ROW_DATA", rowMap);
		
		return findView(requestMap.getString("mode"), "/movieMgr/movie/movDivFormPop");
	}
	
	@RequestMapping(value="/movieMgr/movie.do", params="mode=divExec")
	public String divExec(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			) throws BizException{
		
		DataMap requestMap = cm.getDataMap();
		
		//사용자 정보 추출
		LoginInfo loginInfo = cm.getLoginInfo();
		
		String msg = "";	//결과 메세지.
		int result = 0;
		
		if(requestMap.getString("qu").equals("insert")) {			//분류 입력
			
			requestMap.setString("luserno", loginInfo.getSessNo());
			
			result = movieService.insertDivInfo(requestMap);
			
			if(result > 0)	msg = "입력 되었습니다.";
			else 			msg = "실패";
			
		} else if(requestMap.getString("qu").equals("update")) {	//분류 수정

			result = movieService.updateDivInfo(requestMap);
			
			if(result > 0)	msg = "수정 되었습니다.";
			else			msg = "실패";
			
		} else if(requestMap.getString("qu").equals("delete")) {	//분류 삭제

			result = movieService.deleteDivInfo(requestMap);
			
			if(result > 0)	msg = "삭제 되었습니다.";
			else			msg = "실패";
		}
		
		model.addAttribute("RESULT_MSG", msg);
		
		return findView(requestMap.getString("mode"), "/movieMgr/movie/movExec");
	}
	
	@RequestMapping(value="/movieMgr/movie.do", params="mode=subjList")
	public String subjList(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			) throws BizException{
		
		DataMap requestMap = cm.getDataMap();
		
		return findView(requestMap.getString("mode"), "/movieMgr/movie/movSubjList");
	}
	
	@RequestMapping(value="/movieMgr/movie.do", params="mode=subjForm")
	public String subjForm(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			) throws BizException{
		
		DataMap requestMap = cm.getDataMap();
		
		return findView(requestMap.getString("mode"), "/movieMgr/movie/movSubjFormPop");
	}
	
	@RequestMapping(value="/movieMgr/movie.do", params="mode=subjExec")
	public String subjExec(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			) throws BizException{
		
		DataMap requestMap = cm.getDataMap();
		
		return findView(requestMap.getString("mode"), "/movieMgr/movie/movExec");
	}
	
	@RequestMapping(value="/movieMgr/movie.do", params="mode=contList")
	public String contList(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			) throws BizException{
		
		DataMap requestMap = cm.getDataMap();
		
		//페이징 파라미터
		if (requestMap.getString("currPage").equals(""))	requestMap.setInt("currPage", 1);  //페이지
		if (requestMap.getString("rowSize").equals(""))		requestMap.setInt("rowSize", 20);  //페이지당 보여줄 갯수
		if (requestMap.getString("pageSize").equals("")) 	requestMap.setInt("pageSize", 20); //페이지 블럭 갯수
		
		if("movList".equals(requestMap.getString("mode"))) {
			//사용자단의 경우 - 분류 리스트 필요
			DataMap divListMap 	= movieService.selectDivList(requestMap);
			model.addAttribute("DIV_LIST_DATA", divListMap);
		}

		//동영상 리스트
		DataMap listMap 	= movieService.selectContList(requestMap);
		
		model.addAttribute("LIST_DATA", listMap);
		
		return findView(requestMap.getString("mode"), "/movieMgr/movie/movContList");
	}
	
	@RequestMapping(value="/movieMgr/movie.do", params="mode=contForm")
	public String contForm(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			) throws Exception{
		
		DataMap requestMap = cm.getDataMap();
		
		//service Instance
		DataMap rowMap  = new DataMap(); 
		
		//학습 정보
		if("update".equals(requestMap.getString("qu"))) {	//UPDATE
			
			rowMap = movieService.selectContRow(requestMap.getString("contCode"));
			if(rowMap == null) rowMap = new DataMap();
			rowMap.setNullToInitialize(true);
			System.out.println(rowMap.getInt("groupfileNo"));
			System.out.println("++시작 ++++++++++++++++");
			
			commonService.selectUploadFileList(rowMap);
			System.out.println("++시작 ++++++++++++++++");
			
		} else if("movView".equals(requestMap.getString("mode"))) {	//VIEW
			
			//동영상강의 조회수 갱신
			int updateVisit = movieService.updateVisitCountMov(requestMap);
			
			//동영상강의 상세정보 조회
			rowMap = movieService.selectContRow(requestMap.getString("contCode"));
			// if(rowMap == null) rowMap = new DataMap();
			// rowMap.setNullToInitialize(true);
			
		} else if("movViewLec".equals(requestMap.getString("mode"))) {
			
			//동영상강의 상세정보 조회(LCMS_CMI 학습시간 정보 조회)
			rowMap = movieService.selectContRowLec(requestMap);
			// if(rowMap == null) rowMap = new DataMap();
			// rowMap.setNullToInitialize(true);
			
			//LCMS_CMI 학습시간 정보 조회
			
		}
		
		model.addAttribute("ROW_DATA", rowMap);
		
		return findView(requestMap.getString("mode"), "/movieMgr/movie/movContFormPop");
	}
	
	/**
	 * 동영상강의 학습 입력/수정/삭제 실행
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @param requestMap
	 * @throws Exception
	 */
	public void contExec(
			Model model
			, DataMap requestMap
			, LoginInfo loginInfo
			) throws Exception {
		
		String msg = "";	//결과 메세지.
		int result = 0;
		
		//--  파일 등록 시작   --//
		int groupfileNo = -1;
		
		DataMap fileMap =  null;
		try {
			fileMap = (DataMap)requestMap.get("UPLOAD_FILE");
		} catch(Exception e) {
			
		}
		
		if(fileMap == null) fileMap = new DataMap();
		fileMap.setNullToInitialize(true);
		
		// if(fileMap.keySize("fileSysName") > 0 || fileMap.keySize("existFile") > 0 || fileMap.keySize("deleteFile") > 0)
		groupfileNo = commonService.insertInnoUploadFile(fileMap, requestMap.getString("INNO_SAVE_DIR"), loginInfo.getSessNo());
		// requestMap.setInt("fileGroupNo",fileGroupNo);
		requestMap.setInt("groupfileNo" ,groupfileNo);
		//--  파일 등록 종료  --//		
		
		
		if(requestMap.getString("qu").equals("insert")) {			//분류 입력
			
			requestMap.setString("luserno", loginInfo.getSessNo());
			
			result = movieService.insertContInfo(requestMap);
			
			if(result > 0)	msg = "입력 되었습니다.";
			else 			msg = "실패";
			
		} else if(requestMap.getString("qu").equals("update")) {	//분류 수정

			result = movieService.updateContInfo(requestMap);
			
			if(result > 0)	{ 
				msg = "수정 되었습니다.";
				requestMap.setString("mode", "contExec");
			} else {
				msg = "실패";
			}
			
		} else if(requestMap.getString("qu").equals("delete")) {	//분류 삭제

			result = movieService.deleteContInfo(requestMap);
			
			if(result > 0)	msg = "삭제 되었습니다.";
			else			msg = "실패"; 
			
		} else if(requestMap.getString("mode").equals("updateCmiTime")) {	//학습시간 갱신
			
			requestMap.setString("strUserId", loginInfo.getSessNo());
			result = movieService.updateCmiTime(requestMap);
			
			if(result > 0)	msg = "ok";
			else			msg = "fail";
		}
		
			
			
		model.addAttribute("RESULT_MAP", requestMap);
		model.addAttribute("RESULT_MSG", msg);
	}
	
	@RequestMapping(value="/movieMgr/movie.do", params="mode=contExec")
	public String contExec(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			) throws Exception{
		
		DataMap requestMap = cm.getDataMap();
		
		contExec(model, requestMap, cm.getLoginInfo());
		
		return findView(requestMap.getString("mode"), "/movieMgr/movie/movExec");
	}
	
	@RequestMapping(value="/movieMgr/movie.do", params="mode=contView")
	public String contView(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			) throws Exception{
		
		DataMap requestMap = cm.getDataMap();
		
		return findView(requestMap.getString("mode"), "/movieMgr/movie/movContView");
	}
	
	/**
	 * 동영상강의 학습 리스트
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @param requestMap
	 * @throws Exception
	 */
	public void contList_(
			Model model,
			DataMap requestMap) throws Exception {
		
		
		//페이징 파라미터
		if (requestMap.getString("currPage").equals(""))	requestMap.setInt("currPage", 1);  //페이지
		if (requestMap.getString("rowSize").equals(""))		requestMap.setInt("rowSize", 20);  //페이지당 보여줄 갯수
		if (requestMap.getString("pageSize").equals("")) 	requestMap.setInt("pageSize", 20); //페이지 블럭 갯수
		
		if("movList".equals(requestMap.getString("mode"))) {
			//사용자단의 경우 - 분류 리스트 필요
			DataMap divListMap 	= movieService.selectDivList(requestMap);
			model.addAttribute("DIV_LIST_DATA", divListMap);
		}

		//동영상 리스트
		DataMap listMap 	= movieService.selectContList_(requestMap);
		
		model.addAttribute("LIST_DATA", listMap);
	}
	
	@RequestMapping(value="/movieMgr/movie.do", params="mode=movList")
	public String movList(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			) throws Exception{
		
		DataMap requestMap = cm.getDataMap();
		
		contList_(model, requestMap);
		
		return findView(requestMap.getString("mode"), "/movieMgr/movie/movList");
	}
	
	@RequestMapping(value="/movieMgr/movie.do", params="mode=movView")
	public String movView(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			) throws Exception{
		
		DataMap requestMap = cm.getDataMap();
		
		contForm(cm, model);
		
		return findView(requestMap.getString("mode"), "/jwplayers/movView");
	}
	
	@RequestMapping(value="/movieMgr/movie.do", params="mode=movViewLec")
	public String movViewLec(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			) throws Exception{
		
		DataMap requestMap = cm.getDataMap();
		
		contForm(cm, model);
		
		return findView(requestMap.getString("mode"), "/jwplayers/movViewLec");
	}
	
	@RequestMapping(value="/movieMgr/movie.do", params="mode=updateCmiTime")
	public String updateCmiTime(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			) throws Exception{
		
		DataMap requestMap = cm.getDataMap();
		
		contExec(model, requestMap, cm.getLoginInfo());
		
		return findView(requestMap.getString("mode"), "/movieMgr/movie/movExec");
	}
	
}
