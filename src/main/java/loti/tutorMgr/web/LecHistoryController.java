package loti.tutorMgr.web;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import loti.common.service.CommonService;
import loti.tutorMgr.service.LecHistoryService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import ut.lib.login.LoginCheck;
import ut.lib.login.LoginInfo;
import ut.lib.support.CommonMap;
import ut.lib.support.DataMap;
import common.controller.BaseController;

@Controller
public class LecHistoryController extends BaseController {

	private Map<String, String> views;
	
	public LecHistoryController() {
		views = new HashMap<String, String>();
	}
	
	public String findView(String mode, String defaultView){
		String view = this.views.get(mode);
		if(view==null){
			return defaultView;
		}
		return view;
	}
	
	@Autowired
	private LecHistoryService lecHistoryService;
	
	@Autowired
	private CommonService commonService;
	
	@ModelAttribute("cm")
	public CommonMap common(
				CommonMap cm
				, HttpServletResponse response
				, Model model
				, @RequestParam(value="mode", required=false, defaultValue="") String mode
			) throws Exception{
		
		// 리퀘스트 받기
		DataMap requestMap = cm.getDataMap();
		requestMap.setNullToInitialize(true);
		
		// default mode
		System.out.println("mode="+mode);
		
		//관리자 로그인 체크
		LoginInfo memberInfo = null;
		
		
		if(mode.equals("searchTutorPop") || mode.equals("formPop") ){
			memberInfo = LoginCheck.adminCheckPopup(cm.getRequest(), response);
		}else{
			memberInfo = LoginCheck.adminCheck(cm.getRequest(), response, requestMap.getString("menuId") );
		}
		
		// 리퀘스트 정보를 담고있는 DataMap을 Attribute 에 추가
		model.addAttribute("REQUEST_DATA", requestMap);
		
		return cm;
	}
	
	/**
	 * 강의기록 입력 리스트
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @param requestMap
	 * @throws Exception
	 */
	public void tutorLecHistoryList(
				Model model
				, DataMap requestMap
			) throws Exception {
		
		DataMap listMap = null;
		
		// 페이지
		if (requestMap.getString("currPage").equals("")){
			requestMap.setInt("currPage", 1);
		}
		// 페이지당 보여줄 갯수
		if (requestMap.getString("rowSize").equals("")){
			requestMap.setInt("rowSize", 15); 
		}
		// 페이지 블럭 갯수
		if (requestMap.getString("pageSize").equals("")){
			requestMap.setInt("pageSize", 10);
		}
		
		// 강의기록입력 리스트
		listMap = lecHistoryService.tutorLecHistoryList(requestMap);
		
		model.addAttribute("LIST_DATA", listMap);	
	}
	
	@RequestMapping(value="/tutorMgr/lecHistory.do", params="mode=list")
	public String list(
				Model model
				, @ModelAttribute("cm") CommonMap cm
				, @RequestParam("mode") String mode
			) throws Exception{
		
		tutorLecHistoryList(model, cm.getDataMap());
		
		return findView(mode, "/tutorMgr/lecHistory/lecHistoryList");
	}
	
	/**
	 * 강의기록 입력 화면
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @param requestMap
	 * @throws Exception
	 */
	public void formPop(
			Model model,
			DataMap requestMap) throws Exception {
		
		DataMap rowMap = null;
				
		String mode = requestMap.getString("mode");
		
		String no = requestMap.getString("no");

		
		
		rowMap = lecHistoryService.tutorLecHistoryInfo(no);
				
		model.addAttribute("ROW_MAP", rowMap);
		
		System.out.println("mode="+mode);
	}
	
	@RequestMapping(value="/tutorMgr/lecHistory.do", params="mode=formPop")
	public String formPop(
			Model model
			, @ModelAttribute("cm") CommonMap cm
			, @RequestParam("mode") String mode
			) throws Exception{
		
		formPop(model, cm.getDataMap());
		
		return findView(mode, "/tutorMgr/lecHistory/lecHistoryFormPop");
	}
	
	/**
	 * 강의기록입력용 과정,기수,과목 셀렉트박스
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @param requestMap
	 * @throws Exception
	 */
	public void lecCodeAjax(
			Model model
			, DataMap requestMap) throws Exception {
		
		DataMap listMap = null;
		
		
		String mode = requestMap.getString("mode");
		String objId = requestMap.getString("objId");
		String code = requestMap.getString("code");
		String codeNm = requestMap.getString("codeNm");
		String findCode = requestMap.getString("findCode");
		String width = requestMap.getString("width");
		String isOneData = requestMap.getString("isOneData").toLowerCase();
		String ptype = requestMap.getString("ptype");
		
		String grCode = requestMap.getString("grCode");
		String grSeq = requestMap.getString("grSeq");
		String subj = requestMap.getString("subj");

		
		if(ptype.equals("grCode")){
			// 과정
			listMap = commonService.selectGrCodeByLec();
		}
		
		if(ptype.equals("grSeq")){
			// 기수
			listMap = commonService.selectGrSeqByLec(grCode);
		}
		
		if(ptype.equals("subj")){
			// 과목
			listMap = commonService.selectSubjByLec(grCode, grSeq);
		}
		
		model.addAttribute("LIST_MAP", listMap);				
	}
	
	@RequestMapping(value="/tutorMgr/lecHistory.do", params="mode=lecCodeAjax")
	public String lecCodeAjax(
			Model model
			, @ModelAttribute("cm") CommonMap cm
			, @RequestParam("mode") String mode
			) throws Exception{
		
		lecCodeAjax(model, cm.getDataMap());
		
		return findView(mode, "/tutorMgr/lecHistory/lecHistoryBySelectBoxAjax");
	}
	
	/**
	 * 강사기록 등록
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @param requestMap
	 * @param sessNo
	 * @throws Exception
	 */
	public void insert(
			Model model,
			DataMap requestMap,
			String sessNo) throws Exception {
		
		String mode = requestMap.getString("mode");
		
		String msg = "";
		String resultType = "";
		int result = 0;
		
		String strDate = requestMap.getString("strDate");
		
		/**
		 * 월요일 체크
		 */
		DataMap checkMondayMap = null;
		checkMondayMap = lecHistoryService.checkMonday(strDate);				
		if(checkMondayMap == null) checkMondayMap = new DataMap();
		
		if(checkMondayMap.size() > 0 ){
			if(checkMondayMap.get("chkMonday").equals("Y")){
								
				/**
				 * 교육기간 중복 체크
				 */
				DataMap checkDup = null;
				checkDup = lecHistoryService.checkLecHistoryDupcnt(requestMap);
				if(checkDup == null) checkDup = new DataMap();
				if("0".equals(checkDup.getString("dupcnt"))){
					
					result = lecHistoryService.insertTutorLecHistory(requestMap, sessNo);
					
					if(result > 0){			
						msg = "저장 되었습니다.";						
						resultType = "insertOk";			
											
					}else{			
						msg = "저장시 오류가 발생했습니다.";
						resultType = "saveError";			
					}
					
				}else{
					msg = "교육기간이 중복되는 데이터가 있습니다. 확인 후 다시 입력해 주십시요.";						
					resultType = "dupErr";
				}								
			}else{
				msg = "선택한 강의시작일이 월요일이 아닙니다.";						
				resultType = "mondayErr";	
			}
		}else{
			msg = "저장시 오류가 발생했습니다.";
			resultType = "saveError";
		}		
				
		
		model.addAttribute("RESULT_MSG", msg);
		model.addAttribute("RESULT_TYPE", resultType);
		
		System.out.println("mode="+mode);
	}
	
	@RequestMapping(value="/tutorMgr/lecHistory.do", params="mode=insert", method=RequestMethod.POST)
	public String insert(
			Model model
			, @ModelAttribute("cm") CommonMap cm
			, @RequestParam("mode") String mode
			) throws Exception{
		
		insert(model, cm.getDataMap(), cm.getLoginInfo().getSessNo());
		
		return findView(mode, "/tutorMgr/lecHistory/lecHistoryFormExec");
	}
	
	/**
	 * 업데이트
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @param requestMap
	 * @param sessNo
	 * @throws Exception
	 */
	public void update(
			Model model,
			DataMap requestMap,
			String sessNo) throws Exception {
		
		String mode = requestMap.getString("mode");
		
		String msg = "";
		String resultType = "";
		int result = 0;
		
		String grCode = requestMap.getString("grCode");
		String grSeq = requestMap.getString("grSeq");
		String subj = requestMap.getString("subj");
		String strDate = requestMap.getString("strDate");
		String tDate = requestMap.getString("tDate");
		String tTime = requestMap.getString("tTime");
		String eduinwon = requestMap.getString("eduinwon");
		String userno = requestMap.getString("userno");
		
		String no = requestMap.getString("no");
		
		String sqlWhere = "AND NO <> " + no;
		
		/**
		 * 월요일 체크
		 */
		DataMap checkMondayMap = null;
		checkMondayMap = lecHistoryService.checkMonday(strDate);				
		if(checkMondayMap == null) checkMondayMap = new DataMap();
		
		if(checkMondayMap.size() > 0 ){
			if(checkMondayMap.get("chkMonday").equals("Y")){
								
				/**
				 * 교육기간 중복 체크
				 */
				DataMap checkDup = null;
				checkDup = lecHistoryService.checkLecHistoryDupcnt(requestMap);
				if(checkDup == null) checkDup = new DataMap();
				if("0".equals(checkDup.getString("dupcnt"))){
					
					result = lecHistoryService.updateTutorLecHistory(requestMap, sessNo);
					
					if(result > 0){			
						msg = "수정 되었습니다.";						
						resultType = "updateOk";			
											
					}else{			
						msg = "수정시 오류가 발생했습니다.";
						resultType = "saveError";			
					}
					
				}else{
					msg = "교육기간이 중복되는 데이터가 있습니다. 확인 후 다시 입력해 주십시요.";						
					resultType = "dupErr";
				}								
			}else{
				msg = "선택한 강의시작일이 월요일이 아닙니다.";						
				resultType = "mondayErr";	
			}
		}else{
			msg = "수정시 오류가 발생했습니다.";
			resultType = "saveError";
		}		
				
		
		model.addAttribute("RESULT_MSG", msg);
		model.addAttribute("RESULT_TYPE", resultType);
		
		System.out.println("mode="+mode);
	}
	
	@RequestMapping(value="/tutorMgr/lecHistory.do", params="mode=update", method=RequestMethod.POST)
	public String update(
			Model model
			, @ModelAttribute("cm") CommonMap cm
			, @RequestParam("mode") String mode
			) throws Exception{
		
		update(model, cm.getDataMap(), cm.getLoginInfo().getSessNo());
		
		return findView(mode, "/tutorMgr/lecHistory/lecHistoryFormExec");
	}
	

	/**
	 * 강의기록 강사별 상세 리스트
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @param requestMap
	 * @throws Exception
	 */
	public void selectLecHistoryDetail(
			Model model,
			DataMap requestMap) throws Exception {
		
		DataMap listMap = null;
				
		String mode = requestMap.getString("mode");
		
		String userno = requestMap.getString("userno");
						
		listMap = lecHistoryService.selectLecHistoryDetail(userno);
				
		model.addAttribute("LIST_MAP", listMap);
		
		System.out.println("mode="+mode);
	}
	
	@RequestMapping(value="/tutorMgr/lecHistory.do", params="mode=detailAjax")
	public String detailAjax(
			Model model
			, @ModelAttribute("cm") CommonMap cm
			, @RequestParam("mode") String mode
			) throws Exception{
		
		selectLecHistoryDetail(model, cm.getDataMap());
		
		return findView(mode, "/tutorMgr/lecHistory/lecHistoryDetailByAjax");
	}
	
	/**
	 * 삭제
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @param requestMap
	 * @param sessNo
	 * @throws Exception
	 */
	public void delete(
			Model model
			, DataMap requestMap) throws Exception {
		
		String mode = requestMap.getString("mode");
		
		String msg = "";
		String resultType = "";
		int result = 0;
		
		
		String no = requestMap.getString("no");
												
		result = lecHistoryService.deleteTutorLecHistory(no);
		
		if(result > 0){			
			msg = "삭제 되었습니다.";						
			resultType = "deleteOk";			
								
		}else{			
			msg = "삭제시 오류가 발생했습니다.";
			resultType = "saveError";			
		}
					
		model.addAttribute("RESULT_MSG", msg);
		model.addAttribute("RESULT_TYPE", resultType);
		
		System.out.println("mode="+mode);
	}
	
	@RequestMapping(value="/tutorMgr/lecHistory.do", params="mode=delete")
	public String delete(
			Model model
			, @ModelAttribute("cm") CommonMap cm
			, @RequestParam("mode") String mode
			) throws Exception{
		
		delete(model, cm.getDataMap());
		
		return findView(mode, "/tutorMgr/lecHistory/lecHistoryFormExec");
	}
	
}
