package loti.tutorMgr.web;

import javax.servlet.http.HttpServletResponse;

import loti.common.service.CommonService;
import loti.tutorMgr.service.TutorClassService;
import loti.tutorMgr.service.TutorMgrService;

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
public class TutorClassController extends BaseController {

	@Autowired
	private TutorClassService tutorClassService;
	
	@Autowired
	private TutorMgrService tutorMgrService;
	
	@Autowired
	private CommonService commonService;
	
	@ModelAttribute("cm")
	public CommonMap common(
				CommonMap cm
				, HttpServletResponse response
			) throws Exception{
		// 리퀘스트 받기
		DataMap requestMap = cm.getDataMap();
		requestMap.setNullToInitialize(true);
		
		// default mode
		String mode = Util.getValue(requestMap.getString("mode"));		
		System.out.println("mode="+mode);
		
		//관리자 로그인 체크
		LoginInfo memberInfo = null;
		
		
		if(mode.equals("searchTutorPop") ){
			memberInfo = LoginCheck.adminCheckPopup(cm.getRequest(), response);
		}else{
			memberInfo = LoginCheck.adminCheck(cm.getRequest(), response, requestMap.getString("menuId") );
		}
		
		if (memberInfo == null){			
			return null;
		}
		
		return cm;
	}
	
	/**
	 * 강사지정 리스트
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @param requestMap
	 * @throws Exception
	 */
	public void selectTutorClassList(
			CommonMap cm,
			Model model,
			DataMap requestMap) throws Exception {
		
		DataMap listMap = null;
		DataMap subjMap = null;
		
				
		
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
		
		
		String grCode = Util.getValue( (String)cm.getSession().getAttribute("sess_grcode") , "");
		String grSeq = Util.getValue( (String)cm.getSession().getAttribute("sess_grseq") , "");
				
		String sqlWhere = "";
		
		
		// 강사 지정 리스트
		listMap = tutorClassService.selectTutorClassList(requestMap, grCode, grSeq, sqlWhere);
		
		// 과목 리스트
		subjMap = tutorClassService.selectSubjSeq(grCode, grSeq);
		
		
		model.addAttribute("LIST_DATA", listMap);
		model.addAttribute("SUBJ_DATA", subjMap);
		
	}
	
	@RequestMapping(value="/tutorMgr/tclass.do", params="mode=list")
	public String list(
				@ModelAttribute("cm") CommonMap cm
				, Model model
			) throws Exception{
		
		selectTutorClassList(cm, model, cm.getDataMap());
		
		return "/tutorMgr/tutorClass/tutorClassList";
	}
	
	/**
	 * 강사지정 화면
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @param requestMap
	 * @throws Exception
	 */
	public void tutorClassForm(
			Model model,
			DataMap requestMap) throws Exception {
		
		DataMap listMap = null;
		DataMap gubunMap = null;		// 담당 분야
		DataMap classRoomMap = null;	// 강의실
		DataMap subjNmRowMap = null;	// 과목명
		
		/** 페이징 필수 항목 **/
		
		// 페이지
		if (!requestMap.getString("s_currPage").equals("")){
			requestMap.setInt("currPage", 1);
		}else{
			if (requestMap.getString("currPage").equals("")){
				requestMap.setInt("currPage", 1);
			}
		}
		
		// 페이지당 보여줄 갯수
		if (requestMap.getString("rowSize").equals("")){
			requestMap.setInt("rowSize", 15); 
		}
		// 페이지 블럭 갯수
		if (requestMap.getString("pageSize").equals("")){
			requestMap.setInt("pageSize", 10);
		}
		
		String modeType = requestMap.getString("modeType");
		String subj = requestMap.getString("subj");
		
		// 리스트
		if(modeType.equals("insert")){
			listMap = tutorClassService.selectTutorSubjInputList(requestMap);
		}else{
			listMap = tutorClassService.selectClassTutorInfo(requestMap);
		}
				
		// 담당 분야 전체 리스트
		gubunMap = tutorMgrService.selectTutorGubun();
		
		// 강의실 전체 리스트
		classRoomMap = tutorClassService.selectClassRoom();		
		
		// 과목명
		subjNmRowMap = commonService.selectSubjByRow(subj);
		
		System.out.println(listMap);
		model.addAttribute("LIST_DATA", listMap);
		model.addAttribute("TUTOR_GUBUN_LIST", gubunMap);
		model.addAttribute("CLASSROOM_LIST", classRoomMap);
		model.addAttribute("SUBJNM_ROW", subjNmRowMap);
		
	}
	
	@RequestMapping(value="/tutorMgr/tclass.do", params="mode=form")
	public String form(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			) throws Exception{
		
		tutorClassForm(model, cm.getDataMap());
		
		return "/tutorMgr/tutorClass/tutorClassFormList";
	}
	
	/**
	 * 강사지정 update
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @param requestMap
	 * @throws Exception
	 */
	public void update(
			Model model,
			DataMap requestMap) throws Exception {
				
		String msg = "";
		String resultType = "";
		int result = 0;
		
		result = tutorClassService.updateClassTutor(requestMap);
			
		if(result > 0){
			
			msg = "수정 되었습니다.";						
			resultType = "ok";			

		}else{			
			msg = "수정시 오류가 발생했습니다.";
			resultType = "saveError";			
		}
		
		model.addAttribute("RESULT_MSG", msg);
		model.addAttribute("RESULT_TYPE", resultType);		
	}
	
	@RequestMapping(value="/tutorMgr/tclass.do", params="mode=update")
	public String update(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			) throws Exception{
		
		update(model, cm.getDataMap());
		
		return "/tutorMgr/tutorClass/tutorClassExec";
	}
	
	/**
	 * 강사 지정 insert
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @param requestMap
	 * @param sessNo
	 * @throws Exception
	 */
	public void insert(
			Model model
			, DataMap requestMap) throws Exception {
				
		DataMap chkMap = null;
		
		String msg = "";
		String resultType = "";
		int result = 0;
		
		String tuserno = requestMap.getString("s_tuserno");
		String tgubun = requestMap.getString("s_tgubun");
		String groupfileNo = requestMap.getString("s_groupfileNo");
		String resourceNo = requestMap.getString("s_resourceNo");
		String carReserveYn = requestMap.getString("s_carReserveYn");
		String classroomNo = requestMap.getString("s_classroomNo");
		
		requestMap.setString("tuserno", tuserno);
		requestMap.setString("tgubun", tgubun);
		requestMap.setString("groupfileNo", groupfileNo);
		requestMap.setString("resourceNo", resourceNo);
		requestMap.setString("carReserveYn", carReserveYn);
		requestMap.setString("classroomNo", classroomNo);
		
		chkMap = tutorClassService.checkClassTutor(requestMap);
		if( Util.parseInt(chkMap.get("rescnt")) == 0 ){
			
			requestMap.setString("lecevalpoint", "");
			requestMap.setNullToInitialize(true);
			
			result = tutorClassService.insertClassTutor(requestMap);
			
			
			if(result > 0){
				
				msg = "저장 되었습니다.";						
				resultType = "ok";			

			}else{			
				msg = "저장시 오류가 발생했습니다.";
				resultType = "saveError";			
			}		
			
		}else{
			msg = "해당과목에는 이미 지정하신 강사가 등록되어있습니다.";						
			resultType = "chkErr";
		}
				
		
		model.addAttribute("RESULT_MSG", msg);
		model.addAttribute("RESULT_TYPE", resultType);		
	}
	
	@RequestMapping(value="/tutorMgr/tclass.do", params="mode=insert")
	public String insert(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			) throws Exception{
		
		insert(model, cm.getDataMap());
		
		return "/tutorMgr/tutorClass/tutorClassExec";
	}
	
	/**
	 * 강사지정 delete
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @param requestMap
	 * @throws Exception
	 */
	public void delete(
			Model model
			, DataMap requestMap) throws Exception {
				
		String msg = "";
		String resultType = "";
		int result = 0;
		
		String tuserno = requestMap.getString("s_tuserno");	
		
		requestMap.setString("tuserno", tuserno);
				
		result = tutorClassService.deleteClassTutor(requestMap);
			
		if(result > 0){
			
			msg = "삭제 되었습니다.";						
			resultType = "ok";			

		}else{			
			msg = "삭제시 오류가 발생했습니다.";
			resultType = "saveError";			
		}
		
		model.addAttribute("RESULT_MSG", msg);
		model.addAttribute("RESULT_TYPE", resultType);		
	}
	
	@RequestMapping(value="/tutorMgr/tclass.do", params="mode=delete")
	public String delete(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			) throws Exception{
		
		delete(model, cm.getDataMap());
		
		return "/tutorMgr/tutorClass/tutorClassExec";
	}
	
	/**
	 * 강사소개 팝업창
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @param requestMap
	 * @throws Exception
	 */
	public void tutorInfoPop(
			Model model
			, DataMap requestMap) throws Exception {
		
		DataMap baseInfoMap = null;
		DataMap historyMap = null;
		DataMap classMap1 = null;
		DataMap classMap2 = null;
		
		String userno = requestMap.getString("userno");
		
		
		// 기본 정보
		baseInfoMap = tutorClassService.tutorInfoPopByBaseInfo(userno);
		
		// 경력사항
		historyMap = tutorClassService.tutorInfoPopByHistory(userno);
		
		// 출강현황
		classMap1 = tutorClassService.tutorInfoPopByClassTutor(userno);
		classMap2 = tutorClassService.tutorInfoPopByClassTutorNew(userno);
		
		
		model.addAttribute("BASEINFO_ROW", baseInfoMap);
		model.addAttribute("HISTORY_LIST", historyMap);
		model.addAttribute("CLASS_LIST1", classMap1);
		model.addAttribute("CLASS_LIST2", classMap2);
		
	}
	
	@RequestMapping(value="/tutorMgr/tclass.do", params="mode=infoPop")
	public String infoPop(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			) throws Exception{
		
		tutorInfoPop(model, cm.getDataMap());
		
		return "/tutorMgr/tutorClass/printTutorInfoPop";
	}
}
