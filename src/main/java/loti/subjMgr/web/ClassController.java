package loti.subjMgr.web;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import loti.common.service.CommonService;
import loti.subjMgr.service.ClassService;

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
public class ClassController extends BaseController {

	@Autowired
	private ClassService classService;
	
	@Autowired
	private CommonService commonService;
	
	@ModelAttribute("cm")
	public CommonMap common(
				CommonMap cm
				, HttpServletRequest request
				, HttpServletResponse response
				, Model model
				, HttpSession session
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
		if(requestMap.getString("commSubj").equals("")){
			requestMap.setString("commSubj", (String)session.getAttribute("sess_subj"));
		}
		
		// 리퀘스트 정보를 담고있는 DataMap을 Attribute 에 추가
		model.addAttribute("REQUEST_DATA", requestMap);
		
		return cm;
	}
	
	public String findView(String mode, String defaultView){
		return defaultView;
	}
	
	/**
	 * 입교자 반지정 여부
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @param requestMap
	 * @throws Exception
	 */
	public void selectCountBySubjresult(
			Model model
			, DataMap requestMap) throws Exception {
		
		DataMap rowMap = null;				
		rowMap = classService.selectCountBySubjresult(requestMap);				
		model.addAttribute("ROWDATA_COUNTSUBJRESULT", rowMap);						
	}
	
	/**
	 * 기관별 입교자 리스트
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @param requestMap
	 * @throws Exception
	 */
	public void selectDeptClassList(
			Model model
			, DataMap requestMap) throws Exception {
		
		DataMap listMap = null;				
		listMap = classService.selectDeptClassList(requestMap);				
		model.addAttribute("DEPTCLASS_LIST", listMap);						
	}
	
	/**
	 * 반 리스트
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @param requestMap
	 * @throws Exception
	 */
	public void selectClassList(
			Model model
			, DataMap requestMap) throws Exception {
		
		DataMap listMap = null;				
		listMap = classService.selectClassList(requestMap);				
		model.addAttribute("CLASS_LIST", listMap);						
	}
	
	@RequestMapping(value="/subjMgr/class.do", params="mode=classList")
	public String classList(
				@ModelAttribute("cm") CommonMap cm
				, Model model
			) throws Exception{
		
		DataMap requestMap = cm.getDataMap();
		
		if( !requestMap.getString("commGrcode").equals("") &&
			!requestMap.getString("commGrseq").equals("") &&
			!requestMap.getString("commSubj").equals("") ){
			
			// 입교자 반지정 여부
			selectCountBySubjresult(model, requestMap);
		
			// 기관별 입교자 리스트
			selectDeptClassList(model, requestMap);
			
			// 반 리스트
			selectClassList(model, requestMap);
	
		}
		
		return findView(requestMap.getString("mode"), "/subjMgr/class/classList");
	}
	
	/**
	 * 반지정 현황보기
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @param requestMap
	 * @throws Exception
	 */
	public void selectClassViewList(
			Model model
			, DataMap requestMap) throws Exception {
		
		DataMap listMap = new DataMap();
		DataMap rowMap1 = new DataMap();
		DataMap rowMap2 = new DataMap();
		
		rowMap1 = commonService.selectGrCodeByRow(requestMap.getString("commGrcode"));
		rowMap2 = commonService.selectSubjByRow(requestMap.getString("commSubj"));		
		listMap = classService.selectClassViewList(requestMap);
		
		model.addAttribute("LIST_DATA", listMap);
		model.addAttribute("GRCODENM", rowMap1);
		model.addAttribute("SUBJNM", rowMap2);
		
	}
	
	@RequestMapping(value="/subjMgr/class.do", params="mode=classViewList")
	public String classViewList(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			) throws Exception{
		
		DataMap requestMap = cm.getDataMap();
		
		selectClassViewList(model, requestMap);
		
		return findView(requestMap.getString("mode"), "/subjMgr/class/classViewList");
	}
	
	/**
	 * 수강인원
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @param requestMap
	 * @throws Exception
	 */
	public void selectCountByStuLec(
			Model model
			, DataMap requestMap) throws Exception {
		
		DataMap rowMap = null;				
		rowMap = classService.selectCountByStuLec(requestMap);				
		model.addAttribute("STULEC_COUNT_ROW", rowMap);						
	}
	
	/**
	 * 분반구성 리스트
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @param requestMap
	 * @param strClassNo1
	 * @param strClassNo2
	 * @throws Exception
	 */
	public void selectStuLecList(
			Model model
			, DataMap requestMap,
			String strClassNo1, String strClassNo2) throws Exception {
		
		DataMap listMap = null;
		DataMap rowMap1 = null;
		DataMap rowMap2 = null;
		
		listMap = classService.selectStuLecList(requestMap, strClassNo1, strClassNo2);		
		rowMap1 = commonService.selectGrCodeByRow(requestMap.getString("commGrcode"));
		rowMap2 = commonService.selectSubjByRow(requestMap.getString("commSubj"));
		
		model.addAttribute("LIST_DATA", listMap);
		model.addAttribute("GRCODENM", rowMap1);
		model.addAttribute("SUBJNM", rowMap2);
	}
	
	@RequestMapping(value="/subjMgr/class.do", params="mode=classFormPop")
	public String classFormPop(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			) throws Exception{
		
		DataMap requestMap = cm.getDataMap();
		
		// 반 지정 팝업						
		
		// 수강인원
		selectCountByStuLec(model, requestMap);				
					
		// CLASSNO 데이타 만들기
		String classNo1 = "";
		String classNo2 = "";
		for(int i=1; i < ( requestMap.getInt("classCnt") + 1 ) ; i++){
			if(i==1){
				classNo1 = "'" + i + "'";
				classNo2 = "" + i + "";
			}else{
				classNo1 += ",'" + i + "'";
				classNo2 += "," + i + "";
			}
		}
		
		if( !classNo2.replaceAll(",","").equals("") ){
			selectStuLecList(model, requestMap, classNo1, classNo2);
		}
		
		return findView(requestMap.getString("mode"), "/subjMgr/class/classFormPop");
	}
	
	/**
	 * 반 구성 등록
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @param requestMap
	 * @param sessNo
	 * @throws Exception
	 */
	public void insertBySubjClass(
			Model model,
			DataMap requestMap,
			String sessNo) throws Exception {
		
		
		String msg = "";
		String resultType = "";
		
		int result = classService.insertBySubjClass(requestMap, sessNo);
								
		if(result > 0){
			
			msg = "등록 되었습니다.";
			resultType = "ok";
			
		}else{			
			msg = "등록시 오류가 발생했습니다.";
			resultType = "saveError";			
		}
						
		model.addAttribute("RESULT_MSG", msg);
		model.addAttribute("RESULT_TYPE", resultType);		
	}
	
	@RequestMapping(value="/subjMgr/class.do", params="mode=insertSubjClass")
	public String insertSubjClass(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			) throws Exception{
		
		DataMap requestMap = cm.getDataMap();
		
		insertBySubjClass(model, requestMap, cm.getLoginInfo().getSessNo());
		
		return findView(requestMap.getString("mode"), "/subjMgr/class/classExec");
	}
	
	/**
	 * 반 갯수 지정 카운트
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @param requestMap
	 * @throws Exception
	 */
	public void selectCountBySubjClass(
			Model model,
			DataMap requestMap) throws Exception {
		
		DataMap rowMap = null;				
		rowMap = classService.selectCountBySubjClass(requestMap);				
		model.addAttribute("COUNT_SUBJCLASS_ROW", rowMap);						
	}
	
	@RequestMapping(value="/subjMgr/class.do", params="mode=classReg")
	public String classReg(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			) throws Exception{
		
		DataMap requestMap = cm.getDataMap();
		
		// 입교자 반지정 리스트 화면
		
		// 반 갯수 카운트
		selectCountBySubjClass(model, requestMap);
		
		
		return findView(requestMap.getString("mode"), "/subjMgr/class/classReg");
	}
	
	/**
	 * 과정명, 기수명, 반 셀렉트박스용 데이타
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @param requestMap
	 * @throws Exception
	 */
	public void selectTopInfo(
			Model model,
			DataMap requestMap) throws Exception {
		
		DataMap listMap = null;
		DataMap rowMap1 = null;
		DataMap rowMap2 = null;
		
		listMap = classService.selectSubjClass(requestMap.getString("commGrcode"),
											requestMap.getString("commGrseq"),
											requestMap.getString("commSubj") );
		
		
		rowMap1 = commonService.selectGrCodeByRow(requestMap.getString("commGrcode"));
		rowMap2 = commonService.selectSubjByRow(requestMap.getString("commSubj"));
		
		model.addAttribute("SUBJCLASS_LIST", listMap);
		model.addAttribute("GRCODENM", rowMap1);
		model.addAttribute("SUBJNM", rowMap2);
	}
	
	@RequestMapping(value="/subjMgr/class.do", params="mode=dept1")
	public String dept1(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			) throws Exception{
		
		DataMap requestMap = cm.getDataMap();
		
		// 기관별 분반 Type1
		selectTopInfo(model, requestMap);
		
		// 기관별 입교자 리스트
		selectDeptClassList(model, requestMap);
		
		
		return findView(requestMap.getString("mode"), "/subjMgr/class/classRegByDeptList1");
	}
	
	/**
	 * 기관별 분반 Type2 리스트
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @param requestMap
	 * @throws Exception
	 */
	public void selectSubjClassByDeptType2(
			Model model,
			DataMap requestMap) throws Exception {
		
		DataMap listMap = null;				
		listMap = classService.selectSubjClassByDeptType2(requestMap);				
		model.addAttribute("DATA_LIST", listMap);						
	}
	
	@RequestMapping(value="/subjMgr/class.do", params="mode=dept2")
	public String dept2(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			) throws Exception{
		
		DataMap requestMap = cm.getDataMap();
		
		// 기관별 분반 Type2
		selectTopInfo(model, requestMap);
		
		// 기관별 분반 Type2 리스트
		selectSubjClassByDeptType2(model, requestMap);
		
		
		return findView(requestMap.getString("mode"), "/subjMgr/class/classRegByDeptList2");
	}
	
	/**
	 * 자유분반 리스트
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @param requestMap
	 * @throws Exception
	 */
	public void selectFreeList(
			Model model,
			DataMap requestMap) throws Exception {
		
		DataMap listMap = null;
				
		listMap = classService.selectFreeList(requestMap);
		
		model.addAttribute("LIST_DATA", listMap);
	}
	
	@RequestMapping(value="/subjMgr/class.do", params="mode=free")
	public String free(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			) throws Exception{
		
		DataMap requestMap = cm.getDataMap();
		
		// 자유분반 리스트
		selectTopInfo(model, requestMap);
		selectFreeList(model, requestMap);
		
		return findView(requestMap.getString("mode"), "/subjMgr/class/classRegByFree");
	}
	
	/**
	 * 조건별 분반  설정 리스트
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @param requestMap
	 * @throws Exception
	 */
	public void selectOptionList(
			Model model,
			DataMap requestMap) throws Exception {
		
		DataMap listMap = null;				
		listMap = classService.selectOptionList(requestMap);				
		model.addAttribute("LIST_DATA", listMap);						
	}
	
	@RequestMapping(value="/subjMgr/class.do", params="mode=option")
	public String option(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			) throws Exception{
		
		DataMap requestMap = cm.getDataMap();
		
		// 조건별 분반 리스트
		selectTopInfo(model, requestMap);
		selectOptionList(model, requestMap);
		
		return findView(requestMap.getString("mode"), "/subjMgr/class/classRegByOption");
	}
	
	/**
	 * 타 과목 동일반 구성하기
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @param requestMap
	 * @throws Exception
	 */
	public void selectOtherPopList(
			Model model,
			DataMap requestMap) throws Exception {
		
		DataMap listMap = null;
		DataMap rowMap1 = null;
						
		listMap = classService.selectOtherClassList(requestMap);
		rowMap1 = commonService.selectSubjByRow(requestMap.getString("commSubj"));
		
		model.addAttribute("LIST_DATA", listMap);
		model.addAttribute("SUBJNM", rowMap1);
	}
	
	@RequestMapping(value="/subjMgr/class.do", params="mode=otherPop")
	public String otherPop(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			) throws Exception{
		
		DataMap requestMap = cm.getDataMap();
		
		// 타 과목 동일반 구성하기			
		selectOtherPopList(model, requestMap);
		
		return findView(requestMap.getString("mode"), "/subjMgr/class/orderClassPop");
	}
	
	/**
	 * 단일 분반 저장
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @param requestMap
	 * @throws Exception
	 */
	public void insertSubjClassBySingle(
			Model model,
			DataMap requestMap) throws Exception {
				
		String msg = "";
		String resultType = "";
		
		int result = classService.insertSubjClassBySingle(requestMap);
								
		if(result > 0){
			
			msg = "지정 되었습니다.";
			resultType = "single_ok";
			
		}else{			
			msg = "단일분반 지정시 오류가 발생했습니다.";
			resultType = "saveError";			
		}
						
		model.addAttribute("RESULT_MSG", msg);
		model.addAttribute("RESULT_TYPE", resultType);		
	}
	
	@RequestMapping(value="/subjMgr/class.do", params="mode=saveBySingle")
	public String saveBySingle(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			) throws Exception{
		
		DataMap requestMap = cm.getDataMap();
		
		// 단일 분반 등록
		insertSubjClassBySingle(model, requestMap);
		
		return findView(requestMap.getString("mode"), "/subjMgr/class/classExec");
	}
	
	/**
	 * 기관별 분반 업데이트
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @param requestMap
	 * @throws Exception
	 */
	public void updateSubjClassByDept(
			Model model,
			DataMap requestMap) throws Exception {
				
		String msg = "";
		String resultType = "";
		int result = 0;
		
		if( requestMap.getString("mode").equals("saveByDept1") ){
			result = classService.updateSubjClassByDept1(requestMap);
		}else{
			result = classService.updateSubjClassByDept2(requestMap);
		}
		
		if(result > 0){
			
			msg = "저장 되었습니다.";
			
			if(requestMap.getString("mode").equals("saveByDept1")){
				resultType = "dept1_ok";
			}else{
				resultType = "dept2_ok";
			}
								
		}else{			
			msg = "저장시 오류가 발생했습니다.";
			resultType = "saveError";			
		}
						
		model.addAttribute("RESULT_MSG", msg);
		model.addAttribute("RESULT_TYPE", resultType);		
	}
	
	@RequestMapping(value="/subjMgr/class.do", params="mode=saveByDept1")
	public String saveByDept1(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			) throws Exception{
		
		DataMap requestMap = cm.getDataMap();
		
		// 기관별 분반 Type1 저장
		updateSubjClassByDept(model, requestMap);
	
		return findView(requestMap.getString("mode"), "/subjMgr/class/classExec");
	}
	
	@RequestMapping(value="/subjMgr/class.do", params="mode=saveByDept2")
	public String saveByDept2(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			) throws Exception{
		
		DataMap requestMap = cm.getDataMap();
		
		// 기관별 분반 Type2 저장
		updateSubjClassByDept(model, requestMap);
		
		return findView(requestMap.getString("mode"), "/subjMgr/class/classExec");
	}
	
	/**
	 * 자유 분반, 조건별 분반 업데이트
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @param requestMap
	 * @throws Exception
	 */
	public void updateSubjClassByFreeOption(
			Model model,
			DataMap requestMap) throws Exception {
				
		String msg = "";
		String resultType = "";
		int result = 0;
		
		if(requestMap.getString("mode").equals("saveByFree")){
			result = classService.updateSubjClassByFree(requestMap);
		}else{
			result = classService.updateSubjClassByOption(requestMap);
		}
				
		if(result > 0){
			
			msg = "저장 되었습니다.";
			
			if(requestMap.getString("mode").equals("saveByFree")){
				resultType = "free_ok";
			}else{
				resultType = "option_ok";
			}
								
		}else{			
			msg = "저장시 오류가 발생했습니다.";
			resultType = "saveError";			
		}
						
		model.addAttribute("RESULT_MSG", msg);
		model.addAttribute("RESULT_TYPE", resultType);		
	}
	
	@RequestMapping(value="/subjMgr/class.do", params="mode=saveByOption")
	public String saveByOption(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			) throws Exception{
		
		DataMap requestMap = cm.getDataMap();
		
		// 조건별 분반 업데이트
		updateSubjClassByFreeOption(model, requestMap);
		
		return findView(requestMap.getString("mode"), "/subjMgr/class/classExec");
	}
	
	@RequestMapping(value="/subjMgr/class.do", params="mode=saveByFree")
	public String saveByFree(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			) throws Exception{
		
		DataMap requestMap = cm.getDataMap();
		
		// 자유분반 업데이트
		updateSubjClassByFreeOption(model, requestMap);
		
		return findView(requestMap.getString("mode"), "/subjMgr/class/classExec");
	}
	/**
	 * 타 과목 동일반 구성하기 업데이트
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @param requestMap
	 * @throws Exception
	 */
	public void updateSubjClassByOther(
			Model model,
			DataMap requestMap) throws Exception {
				
		String msg = "";
		String resultType = "";
		int result = 0;
		
		
		result = classService.updateSubjClassByOther(requestMap);
				
		if(result > 0){
			
			msg = "저장 되었습니다.";						
			resultType = "other_ok";			
								
		}else{			
			msg = "저장시 오류가 발생했습니다.";
			resultType = "saveError_Pop";			
		}
				

		model.addAttribute("RESULT_MSG", msg);
		model.addAttribute("RESULT_TYPE", resultType);		
	}
	
	@RequestMapping(value="/subjMgr/class.do", params="mode=saveByOther")
	public String saveByOther(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			) throws Exception{
		
		DataMap requestMap = cm.getDataMap();
		
		// 타 과목 동일반 구성하기 저장
		updateSubjClassByOther(model, requestMap);
		
		return findView(requestMap.getString("mode"), "/subjMgr/class/classExec");
	}
	
	/**
	 * 입교자 반편성용 리스트
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @param requestMap
	 * @throws Exception
	 */
	public void selectStuClassList(
			Model model,
			DataMap requestMap) throws Exception {
		
		DataMap listMap = null;
		
		String sqlWhere = "";
		
		sqlWhere = " AND A.GRSEQ LIKE '" + requestMap.getString("commYear") + "%' ";
		
		if( !requestMap.getString("commGrcode").equals("") ){
			sqlWhere += " AND A.GRCODE = '" + requestMap.getString("commGrcode") + "' ";
		}
		
		if( !requestMap.getString("commGrseq").equals("") ){
			sqlWhere += " AND A.GRSEQ = '" + requestMap.getString("commGrseq") + "' ";
		}
						
		listMap = classService.selectStuClassList(requestMap, sqlWhere);				
		model.addAttribute("LIST_DATA", listMap);						
	}
	
	@RequestMapping(value="/subjMgr/class.do", params="mode=stuClassList")
	public String stuClassList(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			) throws Exception{
		
		DataMap requestMap = cm.getDataMap();
		
		// 입교자 반편성 리스트
		selectStuClassList(model, requestMap);
				
		return findView(requestMap.getString("mode"), "/subjMgr/class/stuClassList");
	}
	
	/**
	 * 입교자 지정 리스트 상단 과목 셀렉트박스	 
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @param requestMap
	 * @throws Exception
	 */
	public void selectStuClassTopInfo(
			Model model,
			DataMap requestMap) throws Exception {
		
		DataMap listMap = null;
		DataMap rowMap1 = null;
		DataMap rowMap2 = null;
		DataMap rowMap3 = null;
		
		listMap = classService.selectStuClassTopSubj(requestMap.getString("subj"));		
		rowMap1 = commonService.selectGrCodeByRow(requestMap.getString("grCode"));
		rowMap2 = commonService.selectSubjByRow(requestMap.getString("subj"));
		rowMap3 = classService.selectCheckGrayn(requestMap.getString("grCode"),
											requestMap.getString("grSeq"),
											requestMap.getString("s_refSubj"));
		
		model.addAttribute("REFSUBJ_LIST", listMap);
		model.addAttribute("GRCODENM", rowMap1);
		model.addAttribute("SUBJNM", rowMap2);
		model.addAttribute("GRAYN", rowMap3);
	}
	
	/**
	 * 입교자 반편성 선택과목에 해당하는 리스트
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @param requestMap
	 * @throws Exception
	 */
	public void selectStuClassSubList(
			Model model,
			DataMap requestMap) throws Exception {
		
		DataMap listMap = null;
		
		listMap = classService.selectStuClassListByDetail(requestMap.getString("grCode"),
				requestMap.getString("grSeq"),
				requestMap.getString("subj"),
				requestMap.getString("s_refSubj"));
		
		
		model.addAttribute("LIST_DATA", listMap);
		
	}
	
	@RequestMapping(value="/subjMgr/class.do", params="mode=stuFormList")
	public String stuFormList(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			) throws Exception{
		
		DataMap requestMap = cm.getDataMap();
		
		// 지정하기 화면 리스트
		selectStuClassTopInfo(model, requestMap);
		selectStuClassSubList(model, requestMap);
		
		return findView(requestMap.getString("mode"), "/subjMgr/class/stuClassFormList");
	}
	
	/**
	 * 입교자 반편성 선택과목 과목수강정보에 업데이트
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @param requestMap
	 * @throws Exception
	 */
	public void updateStuClassListByDetail(
			Model model,
			DataMap requestMap) throws Exception {
				
		String msg = "";
		String resultType = "";
		int result = 0;
		
		
		result = classService.updateStuClassListByDetail(requestMap);
				
		if(result > 0){
			
			msg = "저장 되었습니다.";						
			resultType = "stuUpdate_ok";			
								
		}else{			
			msg = "저장시 오류가 발생했습니다.";
			resultType = "saveError";			
		}				
		
		model.addAttribute("RESULT_MSG", msg);
		model.addAttribute("RESULT_TYPE", resultType);		
	}
	
	@RequestMapping(value="/subjMgr/class.do", params="mode=saveStu")
	public String saveStu(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			) throws Exception{
		
		DataMap requestMap = cm.getDataMap();
		
		// 지정하기 화면 저장
		updateStuClassListByDetail(model, requestMap);
		
		return findView(requestMap.getString("mode"), "/subjMgr/class/classExec");
	}
}
