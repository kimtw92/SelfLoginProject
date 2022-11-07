package loti.baseCodeMgr.web;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import loti.baseCodeMgr.service.SubjService;
import loti.contentsMgr.service.ContentsService;
import loti.movieMgr.service.MovieService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
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
import ut.lib.util.Constants;
import ut.lib.util.SpringUtils;
import ut.lib.util.Util;
import common.controller.BaseController;

@Controller
public class SubjController extends BaseController {
	
	@Autowired
	private SubjService subjService;
	@Autowired
	private MovieService movieService;
	@Autowired
	private ContentsService contentsService;
	
	@ModelAttribute("cm")
	public CommonMap common(CommonMap cm
			              , Model model
			              , HttpServletRequest request
			              , HttpServletResponse response
			              , @RequestParam(value="mode", required=false, defaultValue="") String mode
			              , @RequestParam(value="menuId", required=false, defaultValue="") String menuId) throws BizException {
		
		try {
			DataMap requestMap = cm.getDataMap();
			requestMap.setNullToInitialize(true);
			
			mode = Util.getValue(requestMap.getString("mode"));
			
			//관리자 로그인 체크 (관리자 페이지에는 모두 있어야 함.)
			LoginInfo memberInfo = null;
			
			HttpSession session = request.getSession();
			requestMap.setString("luserno", (String)session.getAttribute("sess_no"));
			
			if (mode.equals("subjPop") || mode.equals("subjPopAjax") || mode.equals("subjFileDown")) {
				memberInfo = LoginCheck.adminCheckPopup(request, response);
			} else {
				memberInfo = LoginCheck.adminCheck(request, response, menuId);
			}
			
			if (memberInfo == null) {
				return null;
			}
			
			model.addAttribute("REQUEST_DATA", requestMap);
			model.addAttribute("LOGIN_INFO", memberInfo);
		} catch (Exception e) {
			throw new BizException(e);
		} finally {
			
		}
		
		return cm;
	}
	
	/**
	 * 가 ~ 기타 까지 한글인덱스 코드
	 */
	@RequestMapping(value="/baseCodeMgr/subj.do", params = "mode=list")
	public String selectCharIndex(@ModelAttribute("cm")CommonMap cm, Model model) throws BizException {
		DataMap requestMap = cm.getDataMap();
		requestMap.setNullToInitialize(true);
		
		DataMap listMap = null;				
		listMap = subjService.selectCharIndex();
		model.addAttribute("CHARINDEX_DATA", listMap);
		
		if (requestMap.getString("s_indexSeq").equals("")) {
			selectSubjList(cm, model);
		} else {
			// 한글 인덱스 클릭시
			selectSubjListByIndex(cm, model);
		}
		
		return "/baseCodeMgr/subj/subjList";
	}
	
	/**
	 * 과목관리 리스트(인덱스 사용안하는 것)
	 */
	public void selectSubjList(@ModelAttribute("cm")CommonMap cm, Model model) throws BizException {
		DataMap requestMap = cm.getDataMap();
		requestMap.setNullToInitialize(true);
		
		DataMap listMap = null;
		
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
		
		listMap = subjService.selectSubjList(requestMap);
		model.addAttribute("LIST_DATA", listMap);
	}
	
	/**
	 * 과목관리 리스트(인덱스 사용)
	 */
	public void selectSubjListByIndex(@ModelAttribute("cm")CommonMap cm, Model model) throws BizException {
		DataMap requestMap = cm.getDataMap();
		requestMap.setNullToInitialize(true);
		
		DataMap listMap = null;
		
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
		
		listMap = subjService.selectSubjListByIndex(requestMap);
		model.addAttribute("LIST_DATA", listMap);
	}
	
	/**
	 * 과목코드 일반과목 등록
	 */
	@RequestMapping(value="/baseCodeMgr/subj.do", params = "mode=sform")
	public String sform(@ModelAttribute("cm")CommonMap cm, Model model) throws BizException {
		DataMap requestMap = cm.getDataMap();
		requestMap.setNullToInitialize(true);
		
		//Lcms 테마 카테고리
		DataMap lcmsCateMap = contentsService.selectLcmsImageCategoryList();
		model.addAttribute("LCMSIMAGECATE_LIST_DATA", lcmsCateMap);
		
		return "/baseCodeMgr/subj/subjForm";
	}
	
	/**
	 * 과목코드 기본 정보 (업데이트 상세보기용)
	 */
	@RequestMapping(value="/baseCodeMgr/subj.do", params = "mode=sUform")
	public String selectSubjRow(@ModelAttribute("cm")CommonMap cm, Model model) throws BizException {
		DataMap requestMap = cm.getDataMap();
		requestMap.setNullToInitialize(true);

		//과목정보
		DataMap rowMap = subjService.selectSubjRow(requestMap.getString("subj"));				
		
		//Lcms 테마 카테고리
		DataMap lcmsCateMap = contentsService.selectLcmsImageCategoryList();
		
		//과목의 등록된 콘텐츠 정보
		DataMap contentMappingListMap = subjService.selectSubjByContentMappingList(requestMap.getString("subj"));
		
		model.addAttribute("SUBJROW_DATA", rowMap);
		model.addAttribute("LCMSIMAGECATE_LIST_DATA", lcmsCateMap);
		model.addAttribute("COTENTMAPPING_LIST_DATA", contentMappingListMap);
		
		return "/baseCodeMgr/subj/subjForm";
	}
	
	/**
	 * 콘텐츠 매핑
	 */
	@RequestMapping(value="/baseCodeMgr/subj.do", params = "mode=contentMapping")
	public String contentMapping(@ModelAttribute("cm")CommonMap cm, Model model) throws BizException {
		DataMap requestMap = cm.getDataMap();
		requestMap.setNullToInitialize(true);
		
		//과목의 등록된 콘텐츠 정보
		DataMap contentMappingListMap = subjService.selectSubjByContentMappingList(requestMap.getString("subj"));				
		
		//Lcms 테마 카테고리
		DataMap lcmsContentListMap = subjService.selectLcmsCategoryList();

		model.addAttribute("COTENTMAPPING_LIST_DATA", contentMappingListMap);
		model.addAttribute("LCMSCONTENT_LIST_DATA", lcmsContentListMap);
		
		return "/baseCodeMgr/subj/subjContentMappingPop";
	}

	/**
	 * 과목코드 (일반과목) 등록
	 */
	@RequestMapping(value="/baseCodeMgr/subj.do", params = "mode=sInsert")
	public String insertSubjByGeneral(@ModelAttribute("cm")CommonMap cm, Model model) throws BizException {
		DataMap requestMap = cm.getDataMap();
		requestMap.setNullToInitialize(true);
		
		String msg = "";
		String resultType = "";
		String bookFileNM = "";
		String proFileNM = "";
		
		DataMap fileMap = (DataMap)requestMap.get("UPLOAD_FILE");
		
		if (fileMap != null) {
			fileMap.setNullToInitialize(true);
			
			if (fileMap.keySize("fileUploadOk") > 0) {
				if (fileMap.getLong("bookFileNm_fileSize") > 0 ) {
					bookFileNM = fileMap.getString("bookFileNm_fileName");		
				}
				if (fileMap.getLong("proFileNm_fileSize") > 0 ) {
					proFileNM = fileMap.getString("proFileNm_fileName");		
				}
			}
		}
		LoginInfo loginInfo = (LoginInfo)cm.getRequest().getAttribute("LOGIN_INFO");
		requestMap.setString("sessNo", loginInfo.getSessNo());
		requestMap.setString("bookFileNm", bookFileNM);
		requestMap.setString("proFileNm", proFileNM); 
		
		int result = 0;
		if ("M".equals(requestMap.getString("subjtype"))) {
			//동영상과목
			result = subjService.insertSubjByGeneralMov(requestMap); 
		} else {
			//사이버등 일반과목
			result = subjService.insertSubjByGeneral(requestMap);
		}
		
		if (result > 0) {
			msg = "등록 되었습니다.";
			resultType = "ok";
		} else {			
			msg = "등록시 오류가 발생했습니다.";
			resultType = "saveError";			
		}
		model.addAttribute("RESULT_MSG", msg);
		model.addAttribute("RESULT_TYPE", resultType);
		
		return "/baseCodeMgr/subj/subjExec";
	}
	
	/**
	 * 과목코드 (일반과목 ) 수정 
	 */
	@RequestMapping(value="/baseCodeMgr/subj.do", params = "mode=sUpdate")
	public String updateSubjByGeneral(@ModelAttribute("cm")CommonMap cm, Model model) throws BizException {
		DataMap requestMap = cm.getDataMap();
		requestMap.setNullToInitialize(true);
		
		String msg = "";
		String resultType = "";
		
		String bookFileNM = "";
		String proFileNM = "";
		
		DataMap fileMap = requestMap.containsKey("UPLOAD_FILE") ? (DataMap)requestMap.get("UPLOAD_FILE") : new DataMap();
		
		if (fileMap.keySize() > 0) {
			String pDir = SpringUtils.getRealPath() + Constants.UPLOAD + Constants.NAMOUPLOAD_SUBJDATA;
			
			// 부교재
			if (fileMap.getString("bookFileNm_fileSize") != null) {
				if (fileMap.getLong("bookFileNm_fileSize") > 0 ) {
					bookFileNM = fileMap.getString("bookFileNm_fileName");
					
					// 신규 파일이 있을경우 이전 파일은 삭제한다.
					if ( !requestMap.getString("orgBookFile").equals("") ) {
						FileUtil.deleteFile(pDir, requestMap.getString("orgBookFile") );
					}
				}
			} else {
				// 파일을 올리지 않았으면 이전 파일명을 넣는다.
				bookFileNM = requestMap.getString("orgBookFile");
			}
			
			// 학습프로그램
			if (fileMap.getString("proFileNm_fileSize") != null) {
				if (fileMap.getLong("proFileNm_fileSize") > 0 ) {
					proFileNM = fileMap.getString("proFileNm_fileName");
					
					// 신규 파일이 있을경우 이전 파일은 삭제한다.
					if ( !requestMap.getString("orgProFile").equals("") ) { 
						FileUtil.deleteFile(pDir, requestMap.getString("orgProFile") );
					}
				}
			} else {
				// 파일을 올리지 않았으면 이전 파일명을 넣는다.
				proFileNM = requestMap.getString("orgProFile");
			}
		} else {
			// 파일을 올리지 않았으면 이전 파일명을 넣는다.
			bookFileNM = requestMap.getString("orgBookFile");
			proFileNM = requestMap.getString("orgProFile");
		}
		LoginInfo loginInfo = (LoginInfo)cm.getRequest().getAttribute("LOGIN_INFO");
		requestMap.setString("sessNo", loginInfo.getSessNo());
		requestMap.setString("bookFileNm", bookFileNM);
		requestMap.setString("proFileNm", proFileNM);
		
		int result = 0;
		if ("M".equals(requestMap.getString("subjtype"))) {
			result = subjService.updateSubjByGeneralMov(requestMap);
		} else {
			result = subjService.updateSubjByGeneral(requestMap);
		}
		
		if(result > 0){
			msg = "수정 되었습니다.";
			resultType = "ok";
		} else {			
			msg = "수정시 오류가 발생했습니다.";
			resultType = "saveError";			
		}
						
		model.addAttribute("RESULT_MSG", msg);
		model.addAttribute("RESULT_TYPE", resultType);
		
		return "/baseCodeMgr/subj/subjExec";
	}
	
	/**
	 * 과목 삭제
	 */
	@RequestMapping(value="/baseCodeMgr/subj.do", params = "mode=delete")
	public String deleteSubj(@ModelAttribute("cm")CommonMap cm, Model model) throws BizException {
		DataMap requestMap = cm.getDataMap();
		requestMap.setNullToInitialize(true);
		
		String msg = "";
		String resultType = "";
		
		String pDir = SpringUtils.getRealPath() + Constants.UPLOAD + Constants.NAMOUPLOAD_SUBJDATA;
		
		int result = subjService.deleteSubj(requestMap);
								
		if (result > 0) {
			if ( !requestMap.getString("orgBookFile").equals("") ) {
				FileUtil.deleteFile(pDir, requestMap.getString("orgBookFile") );
			}
			if ( !requestMap.getString("orgProFile").equals("") ) {
				FileUtil.deleteFile(pDir, requestMap.getString("orgProFile") );
			}
			
			msg = "삭제 되었습니다.";
			resultType = "deleteok";
		} else {			
			msg = "삭제시 오류가 발생했습니다.";
			resultType = "saveError";			
		}
		
		model.addAttribute("RESULT_MSG", msg);
		model.addAttribute("RESULT_TYPE", resultType);
		
		return "/baseCodeMgr/subj/subjExec";
	}
	
	/**
	 * 선택과목 추가용 검색 리스트 
	 */
	@RequestMapping(value="/baseCodeMgr/subj.do", params = "mode=subjPopAjax")
	public String selectSearchSubjPop(@ModelAttribute("cm")CommonMap cm, Model model) throws BizException {
		DataMap requestMap = cm.getDataMap();
		requestMap.setNullToInitialize(true);
		
		DataMap listMap = null;				
		listMap = subjService.selectSearchSubjPop(requestMap.getString("searchTxt"));	
		
		model.addAttribute("LIST_DATA", listMap);
		
		return "/baseCodeMgr/subj/searchOptionSubPopByDataAjax";
	}
	
	@RequestMapping(value="/baseCodeMgr/subj.do", params = "mode=oform")
	public String oform(@ModelAttribute("cm")CommonMap cm, Model model) throws BizException {
		return "/baseCodeMgr/subj/optionSubjForm";
	}
	
	/**
	 * 과목코드 업데이트 화면 (선택과목)
	 */
	@RequestMapping(value="/baseCodeMgr/subj.do", params = "mode=oUform")
	public String oUform(@ModelAttribute("cm")CommonMap cm, Model model) throws BizException {
		// 과목코드 업데이트 화면 (선택과목)
		selectSubjRow(cm, model);
		selectSubjgrp(cm, model);
					
		return "/baseCodeMgr/subj/optionSubjForm";
	}
	
	/**
	 * 선택과목 리스트
	 */
	public void selectSubjgrp(@ModelAttribute("cm")CommonMap cm, Model model) throws BizException {
		DataMap requestMap = cm.getDataMap();
		requestMap.setNullToInitialize(true);
		
		DataMap listMap = null;				
		listMap = subjService.selectSubjgrp(requestMap.getString("subj"));
		model.addAttribute("SUBJGRP_DATA", listMap);	
	}
	
	/**
	 * 선택 과목 등록(기본정보 등록 후 선택과목 등록)
	 */
	@RequestMapping(value="/baseCodeMgr/subj.do", params = "mode=oInsert")
	public String insertOptionSubj(@ModelAttribute("cm")CommonMap cm, Model model) throws BizException {
		DataMap requestMap = cm.getDataMap();
		requestMap.setNullToInitialize(true);
		
		String msg = "";
		String resultType = "";
		
		LoginInfo loginInfo = (LoginInfo)cm.getRequest().getAttribute("LOGIN_INFO");
		requestMap.setString("sessNo", loginInfo.getSessNo());
		
		int result = subjService.insertOptionSubj(requestMap);
								
		if (result > 0) {
			msg = "저장 되었습니다.";
			resultType = "ok";
		} else {			
			msg = "저장시 오류가 발생했습니다.";
			resultType = "saveError";			
		}
		
		model.addAttribute("RESULT_MSG", msg);
		model.addAttribute("RESULT_TYPE", resultType);
		
		return "/baseCodeMgr/subj/subjExec";
	}
	
	/**
	 * 선택 과목 수정
	 */
	@RequestMapping(value="/baseCodeMgr/subj.do", params = "mode=oUpdate")
	public String updateOptionSubj(@ModelAttribute("cm")CommonMap cm, Model model) throws BizException {
		DataMap requestMap = cm.getDataMap();
		requestMap.setNullToInitialize(true);
		
		String msg = "";
		String resultType = "";
		
		int result = subjService.updateSubjByGeneral(requestMap);
								
		if (result > 0) {
			msg = "수정 되었습니다.";
			resultType = "ok";
		} else {			
			msg = "수정시 오류가 발생했습니다.";
			resultType = "saveError";			
		}
						
		model.addAttribute("RESULT_MSG", msg);
		model.addAttribute("RESULT_TYPE", resultType);
		
		return "/baseCodeMgr/subj/subjExec";
	}
	
	/**
	 * Ajax관련 (콘텐츠 매핑시 콘텐츠 정보, ...)
	 */
	@RequestMapping(value="/baseCodeMgr/subj.do", params = "mode=ajax_exec")
	public String ajax_exec(@ModelAttribute("cm")CommonMap cm, Model model) throws BizException {
		DataMap requestMap = cm.getDataMap();
		requestMap.setNullToInitialize(true);
		
		//Lcms 콘텐츠의 속한 정보 조회
		DataMap contentOrgList = subjService.selectLcmsOrganizationList(requestMap.getString("ctId"));
		
		model.addAttribute("CONTENT_ORG_LIST_DATA", contentOrgList);
		
		return "/baseCodeMgr/subj/subjContentMappingByAjax";
	}

	/**
	 * 동영상강의 임시 과목코드 
	 */
	/*public void selectTempSequence(
			ActionMapping mapping, 
			ActionForm form, 
			HttpServletRequest request, 
			HttpServletResponse response, 
			DataMap requestMap) throws Exception {
		
		//Service Instance
		MovieSV sv = new MovieSV();	
		
		//시퀀스
		DataMap tmpSeqMap = sv.selectSequence();
		
		System.out.println("tmpSeqMap =========== " + tmpSeqMap.getString("tmpSeq"));
		
		request.setAttribute("TMP_SEQ", tmpSeqMap.getString("tmpSeq"));
	}*/
	
	/**
	 * 동영상강의 리스트(Ajax)
	 */
	@RequestMapping(value="/baseCodeMgr/subj.do", params = "mode=contentMappingMovU")
	public String selectMovContList(@ModelAttribute("cm")CommonMap cm, Model model) throws BizException {
		DataMap requestMap = cm.getDataMap();
		requestMap.setNullToInitialize(true);
		
		//생성하려는 과목에 대한 콘텐츠 리스트 조회
		DataMap movContList = movieService.selectContListBySubj(requestMap);
		
		model.addAttribute("MOV_LIST_DATA", movContList);
		
		return "/baseCodeMgr/subj/movContentMappingPop";
	}
	
	/**
	 * 동영상 리스트 
	 */
	@RequestMapping(value="/baseCodeMgr/subj.do", params = "mode=ajax_movContList")
	public String ajax_movContList(@ModelAttribute("cm")CommonMap cm, Model model) throws BizException {
		DataMap requestMap = cm.getDataMap();
		requestMap.setNullToInitialize(true);
		
		//생성하려는 과목에 대한 콘텐츠 리스트 조회
		DataMap movContList = movieService.selectContListBySubj(requestMap);
		
		model.addAttribute("MOV_LIST_DATA", movContList);
		
		return "/baseCodeMgr/subj/movContentMappingByAjax";
	}
	
	/**
	 * 과목코드 생성 
	 */
	@RequestMapping(value="/baseCodeMgr/subj.do", params = "mode=contentMappingMov")
	public String selectSubjCode(@ModelAttribute("cm")CommonMap cm, Model model) throws BizException {
		DataMap requestMap = cm.getDataMap();
		requestMap.setNullToInitialize(true);
		
		String subjCode = "";
		
		if (!requestMap.getString("subj").equals("")) {	
			subjCode = requestMap.getString("subj");
		} else {
			subjCode =	movieService.selectSubjCode();	//과목코드 생성
		}
		
		model.addAttribute("SUBJ_CODE", subjCode);
		
		return "/baseCodeMgr/subj/movContentMappingPop";
	}
	
	/**
	 * 동영상강의 학습 삭제(과목코드별)
	 */
	@RequestMapping(value="/baseCodeMgr/subj.do", params = "mode=deleteMovBySubj")
	public String deleteMovBySubj(@ModelAttribute("cm")CommonMap cm, Model model) throws BizException {
		DataMap requestMap = cm.getDataMap();
		requestMap.setNullToInitialize(true);
		
		String msg = "";
		
		int delRtn = movieService.deleteContInfoBySubj(requestMap);
		System.out.println("rtn del MovBySubj === " + delRtn);
		
		if(delRtn > 0) {
			msg = "ok";
		} else {
			msg = "fail";
		}
		
		model.addAttribute("RESULT_MSG", msg);
		
		return "/baseCodeMgr/subj/movExec";
	}
	
	/**
	 * [삭제예정] 동영상강의 상세정보
	 */
	public void selectMovContInfo(@ModelAttribute("cm")CommonMap cm, Model model) throws BizException {
		DataMap requestMap = cm.getDataMap();
		requestMap.setNullToInitialize(true);
		
		//생성하려는 과목에 대한 콘텐츠 리스트 조회
		DataMap movContRow = movieService.selectContRow(requestMap.getString("contCode"));
		
		model.addAttribute("ROW_DATA", movContRow);
	}
	
	/**
	 * 동영상강의 등록
	 */
	@RequestMapping(value="/baseCodeMgr/subj.do", params = "mode=movExec")
	public String insertMov(@ModelAttribute("cm")CommonMap cm, Model model) throws BizException {
		DataMap requestMap = cm.getDataMap();
		requestMap.setNullToInitialize(true);
		
		String msg = "";
		int result = movieService.insertContInfo(requestMap);		//동영상 등록
		
		if (result > 0) {
			msg = "ok";
		} else {
			msg = "fail";
		}
		
		model.addAttribute("RESULT_MSG", msg);
		
		return "/baseCodeMgr/subj/movExec";
	}
	
	/**
	 * 동영상강의 학습 삭제(학습코드별)
	 */
	@RequestMapping(value="/baseCodeMgr/subj.do", params = "mode=deleteMov")
	public String deleteMov(@ModelAttribute("cm")CommonMap cm, Model model) throws BizException {
		DataMap requestMap = cm.getDataMap();
		requestMap.setNullToInitialize(true);
		
		DataMap movMap = new DataMap();
		String msg = "";
		
		int resultValue = movieService.deleteContInfo(requestMap);
		
		if(resultValue > 0) {
			//동영상 리스트
			msg = "ok";
			movMap = movieService.selectContListBySubj(requestMap);
		} else {
			msg = "fail";
		}
		
		model.addAttribute("RESULT_MSG", msg);
		model.addAttribute("MOV_LIST_DATA", movMap);
		
		return "/baseCodeMgr/subj/movContentMappingByAjax";
	}
	
	@RequestMapping(value="/baseCodeMgr/subj.do", params = "mode=subjPop")
	public String subjPop(@ModelAttribute("cm")CommonMap cm, Model model) throws BizException {
		return "/baseCodeMgr/subj/searchOptionSubjPop";
	}
	
	@RequestMapping(value="/baseCodeMgr/subj.do", params = "mode=contForm")
	public String contForm(@ModelAttribute("cm")CommonMap cm, Model model) throws BizException {
		return "/baseCodeMgr/subj/movContFormPop";
	}	
}
