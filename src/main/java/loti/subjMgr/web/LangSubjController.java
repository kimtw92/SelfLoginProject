package loti.subjMgr.web;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import loti.common.service.CommonService;
import loti.subjMgr.service.LangSubjService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import ut.lib.login.LoginCheck;
import ut.lib.login.LoginInfo;
import ut.lib.support.CommonMap;
import ut.lib.support.DataMap;
import ut.lib.util.Util;
import common.controller.BaseController;

@Controller
public class LangSubjController extends BaseController {

	@Autowired
	private LangSubjService langSubjService;
	
	@Autowired
	private CommonService commonService;
	
	@ModelAttribute("cm")
	public CommonMap common(
				CommonMap cm
				, HttpServletRequest request
				, HttpServletResponse response
				, HttpSession session
				, Model model
			) throws Exception{
		
		// 리퀘스트 받기
		DataMap requestMap = cm.getDataMap();
		requestMap.setNullToInitialize(true);
		
		// default mode
		String mode = Util.getValue(requestMap.getString("mode"));		
		System.out.println("mode="+mode);
		
		//관리자 로그인 체크
		LoginInfo memberInfo = null;
		
		if(mode.equals("classFormPop") || 
			mode.equals("otherPop") ||
			mode.equals("saveByOther") ){
			
			memberInfo = LoginCheck.adminCheckPopup(request, response);
		}else{
			memberInfo = LoginCheck.adminCheck(request, response, requestMap.getString("menuId") );
		}
					
		if (memberInfo == null){			
			return null;
		}
		
		
		// 공통 Comm Select Box 값 초기 셋팅.
		if(requestMap.getString("commYear").equals("")){
			requestMap.setString("commYear", (String)session.getAttribute("sess_year"));
		}
		if(requestMap.getString("commGrcode").equals("")){
			requestMap.setString("commGrcode", (String)session.getAttribute("sess_grcode"));
		}
		if(requestMap.getString("commGrseq").equals("")){
			requestMap.setString("commGrseq", (String)session.getAttribute("sess_grseq"));
		}
		
		// 리퀘스트 정보를 담고있는 DataMap을 Attribute 에 추가
		model.addAttribute("REQUEST_DATA", requestMap);
		
		return cm;
	}
	
	public String findView(String mode, String view){
		return view;
	}
	
	/**
	 * 어학점수관리 리스트
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @param requestMap
	 * @throws Exception
	 */
	public void selectLangSubjList(
			Model model
			, DataMap requestMap) throws Exception {
		
		DataMap listMap = null;
		
		String sqlWhere = "";
		
		if( !requestMap.getString("commYear").equals("") ){
			sqlWhere = " AND SJ.GRSEQ LIKE '" + requestMap.getString("commYear") + "%' ";
		}		
		
		if( !requestMap.getString("commGrcode").equals("") ){
			sqlWhere += " AND SJ.GRCODE = '" + requestMap.getString("commGrcode") + "' ";
		}
		
		if( !requestMap.getString("commGrseq").equals("") ){
			sqlWhere += " AND SJ.GRSEQ = '" + requestMap.getString("commGrseq") + "' ";
		}
						
		listMap = langSubjService.selectLangSubjList(requestMap, sqlWhere);				
		model.addAttribute("LIST_DATA", listMap);						
	}
	
	@RequestMapping(value="/subjMgr/langSubj.do", params="mode=list")
	public String list(
				@ModelAttribute("cm") CommonMap cm
				, Model model
			) throws Exception{
		
		DataMap requestMap = cm.getDataMap();
		
		if( !requestMap.getString("commYear").equals("") &&
				!requestMap.getString("commGrcode").equals("") &&
				!requestMap.getString("commGrseq").equals("") ){
				
			selectLangSubjList(model, requestMap);			
		}
		
		return findView(requestMap.getString("mode"), "/subjMgr/langSubj/langSubjList");
	}
	
	@RequestMapping(value="/subjMgr/langSubj.do", params="mode=form")
	public String form(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			) throws Exception{
		
		DataMap requestMap = cm.getDataMap();
		
		DataMap listMap = null;	// 어학점수입력 리스트
		DataMap rowMap1 = null;	// 과정명
		DataMap rowMap2 = null;	// 과목명
		DataMap rowMap3 = null;	// 반 셀렉트박스용
		
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
		
		
		String sqlWhere = "";
		
		if( !requestMap.getString("selSubjClass").equals("") ){
			sqlWhere = "AND		A.CLASSNO	=	'" + requestMap.getString("selSubjClass") + "' ";
		}

		rowMap1 = commonService.selectGrCodeByRow(requestMap.getString("grCode"));
		rowMap2 = commonService.selectSubjByRow(requestMap.getString("subj"));
		rowMap3 = langSubjService.selectClassList(requestMap.getString("grCode"),
										requestMap.getString("grSeq"),
										requestMap.getString("subj"));
		
		listMap = langSubjService.selectLangSubjFormList(requestMap,
												requestMap.getString("grCode"),
												requestMap.getString("grSeq"),
												requestMap.getString("subj"), 
												sqlWhere);		
				
		model.addAttribute("GRCODENM", rowMap1);
		model.addAttribute("SUBJNM", rowMap2);
		model.addAttribute("SUBJCLASS_LIST", rowMap3);										
		model.addAttribute("LIST_DATA", listMap);				
		
		return findView(requestMap.getString("mode"), "/subjMgr/langSubj/langSubjForm");
	}
	
	@RequestMapping(value="/subjMgr/langSubj.do", params="mode=save")
	public String save(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			) throws Exception{
		
		DataMap requestMap = cm.getDataMap();
		
		String msg = "";
		String resultType = "";
		int result = 0;
		
		
		result = langSubjService.updateLangSubj(requestMap);
				
		if(result > 0){
			
			msg = "저장 되었습니다.";						
			resultType = "ok";			
								
		}else{			
			msg = "저장시 오류가 발생했습니다.";
			resultType = "saveError";			
		}				
		
		model.addAttribute("RESULT_MSG", msg);
		model.addAttribute("RESULT_TYPE", resultType);				
		
		return findView(requestMap.getString("mode"), "/subjMgr/langSubj/langSubjExec");
	}
}
