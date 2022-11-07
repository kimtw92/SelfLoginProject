package loti.courseMgr.web;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import loti.courseMgr.service.CourseGuideService;
import loti.courseMgr.service.CourseSeqService;
import loti.courseMgr.service.StuEnterService;
import loti.courseMgr.service.TimeTableService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import ut.lib.exception.BizException;
import ut.lib.login.LoginCheck;
import ut.lib.login.LoginInfo;
import ut.lib.support.CommonMap;
import ut.lib.support.DataMap;
import common.controller.BaseController;

@Controller
public class CourseGuideController extends BaseController {

	@Autowired
	private CourseGuideService courseGuideService;
	@Autowired
	private CourseSeqService courseSeqService;
	@Autowired
	@Qualifier("courseMgrStuEnterService")
	private StuEnterService stuEnterService;
	@Autowired
	@Qualifier("courseMgrTimeTableService")
	private TimeTableService timeTableService;
	
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
			
			if (mode.equals("")) {
				mode = "list";
				requestMap.setString("mode", mode);
			}
			
			//관리자 로그인 체크 (관리자 페이지에는 모두 있어야 함.)
			LoginInfo memberInfo = LoginCheck.adminCheck(request, response, menuId);
			if (memberInfo == null) {
				return null;
			}
			
			//공통 Comm Select Box 값 초기 셋팅.
			HttpSession session = request.getSession(); //세션
			if(requestMap.getString("commYear").equals(""))
				requestMap.setString("commYear", (String)session.getAttribute("sess_year"));
			if(requestMap.getString("commGrcode").equals(""))
				requestMap.setString("commGrcode", (String)session.getAttribute("sess_grcode"));
			//if(requestMap.getString("commGrseq").equals(""))
			//	requestMap.setString("commGrseq", (String)session.getAttribute("sess_grseq"));
			
			model.addAttribute("REQUEST_DATA", requestMap);
			model.addAttribute("LOGIN_INFO", memberInfo);
		} catch (Exception e) {
			throw new BizException(e);
		} finally {
			
		}
		
		return cm;
	}
	
	/**
	 * 과정 안내문 관리 리스트.
	 */
	@RequestMapping(value="/courseMgr/courseGuide.do", params = "mode=list")
	public String list(@ModelAttribute("cm") CommonMap cm, Model model) throws BizException {
		DataMap requestMap = cm.getDataMap();
		requestMap.setNullToInitialize(true);
		
		if (requestMap.getString("currPage").equals(""))	requestMap.setInt("currPage", 1); //페이지
		if (requestMap.getString("rowSize").equals(""))		requestMap.setInt("rowSize", 15); //페이지당 보여줄 갯수
		if (requestMap.getString("pageSize").equals("")) 	requestMap.setInt("pageSize", 10); //페이지 블럭 갯수
		
		//리스트
		DataMap listMap = courseGuideService.selectGrGuideList(requestMap.getString("commYear"), requestMap.getString("commGrcode"), requestMap);

		model.addAttribute("LIST_DATA", listMap);
		
		return "/courseMgr/courseGuide/courseGuideList";
	}
	
	/**
	 * 과정 안내문 관리 등록/ 수정 폼.
	 */
	public void form_com(@ModelAttribute("cm") CommonMap cm, Model model) throws BizException {
		DataMap requestMap = cm.getDataMap();
		requestMap.setNullToInitialize(true);
		
		String qu = requestMap.getString("qu");
		String grcode = requestMap.getString("commGrcode");
		
		DataMap rowMap = null;	//과정 공지 관리 상세 내용
		
		if(requestMap.getString("guideTitle").equals(""))
			requestMap.setString("guideTitle", "1단계");
		
		//폼에서 검색으로 다시 넘어왔을경우에는 insert인지 update인지 확인.
		boolean searchBool = false;
		if(qu.equals("search")){
			//과정 안내문 기수가 있으면 수정.
			int tmpResult = courseGuideService.selectGrGuideChk(grcode, requestMap.getString("commGrseq"), requestMap.getString("guideTitle"));
			if(tmpResult > 0) 
				qu = "update";
			else 
				qu = "insert";
			
			requestMap.setString("qu", qu);
			
			searchBool = true;
		}
		if(qu.equals("insert")){ //등록 폼
			rowMap = new DataMap();
			
			//검색시는 선택된 과정 기수를 쓰지만 추가로 넘어온 insert는 과정 기수의 Max Grseq
			if(!searchBool)
				requestMap.setString("commGrseq", courseGuideService.selectGrGuideMaxGrseq(requestMap.getString("commYear"), grcode));
			
		}else if(qu.equals("update")){ //수정
			//과정 안내문 내용 Row
			rowMap = courseGuideService.selectGrGuideRow(grcode, requestMap.getString("commGrseq"), requestMap.getString("guideTitle"));
		}
		
		//과정 기수 정보.
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("grcode", grcode);
		paramMap.put("grseq", requestMap.getString("commGrseq"));
		
		DataMap grseqMap = courseSeqService.selectGrseqSimpleRow(paramMap);
		
		model.addAttribute("ROW_DATA", rowMap);
		model.addAttribute("GRSEQ_ROW_DATA", grseqMap);
	}
	
	/**
	 * 과정 안내문 관리 등록/ 수정 폼.
	 */
	@RequestMapping(value="/courseMgr/courseGuide.do", params = "mode=form")
	public String form(@ModelAttribute("cm") CommonMap cm, Model model) throws BizException {
		form_com(cm, model);
		
		return "/courseMgr/courseGuide/courseGuideForm";
	}
	
	/**
	 * 과정 안내문 관리 등록/ 수정 폼.
	 */
	@RequestMapping(value="/courseMgr/courseGuide.do", params = "mode=view")
	public String view(@ModelAttribute("cm") CommonMap cm, Model model) throws BizException {
		form_com(cm, model);
		
		return "/courseMgr/courseGuide/courseGuideForm";
	}
	
	/**
	 * 미리보기.
	 * @param mapping
	 */
	@RequestMapping(value="/courseMgr/courseGuide.do", params = "mode=preview")
	public String preview(@ModelAttribute("cm") CommonMap cm, Model model) throws BizException {
		DataMap requestMap = cm.getDataMap();
		requestMap.setNullToInitialize(true);
		
		String grcode = requestMap.getString("grcode");
		String grseq = requestMap.getString("grseq");
		
		//과정 기수 정보.
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("grcode", grcode);
		paramMap.put("grseq", grseq);
		
		DataMap grseqMap = courseSeqService.selectGrseqSimpleRow(paramMap);
		if(grseqMap == null) grseqMap = new DataMap();
		grseqMap.setNullToInitialize(true);
		
		//과목 정보.
		//DataMap subjListMap = service.selectSubjClassByMaxClassNoList(grcode, grseq);
		
		//과정안내 데이터
		DataMap rowMap = courseGuideService.selectGrGuideRow(grcode, grseq, requestMap.getString("guideTitle"));
		
		model.addAttribute("GRSEQ_ROW_DATA", grseqMap);
		model.addAttribute("ROW_DATA", rowMap);
		//model.addAttribute("SUBJ_STRING", subjListMap.getString("subj"));
		
		if(rowMap == null) rowMap = new DataMap();
		rowMap.setNullToInitialize(true);
		
		DataMap guide2 = null; //교과목 편성시간 및 강사
		DataMap guide3 = null; //교육시간표
		DataMap guide4 = null; //교육생(입교자)현황
		DataMap guide5 = null; //교육생(입교자)명단.
		
		if(rowMap.getString("guide2").equals("Y"))
			guide2 = courseGuideService.selectCourseGuideBySubjTutorList(grcode, grseq);
		else
			guide2 = new DataMap();
		
		if(rowMap.getString("guide3").equals("Y")){
			guide3 = timeTableService.selectTimeTableList(grcode, grseq, grseqMap);
		}else
			guide3 = new DataMap();
		
		if(rowMap.getString("guide4").equals("Y")){
			//교육인원 기관
			DataMap depListMap = stuEnterService.selectDeptByAppInfoList(grcode, grseq);
			if(depListMap == null) depListMap = new DataMap();
			depListMap.setNullToInitialize(true);
			//기관/계급명 CROSS 통계
			DataMap deptResultList = stuEnterService.selectDeptDogsCrossList(grcode, grseq, depListMap);
			
			//직렬별 리스트.
			DataMap jikListMap = stuEnterService.selectJikrByAppInfoList(grcode, grseq);
			if(jikListMap == null) jikListMap = new DataMap();
			jikListMap.setNullToInitialize(true);
			
			//직렬/계급명 CROSS 통계
			DataMap jikrResultList = stuEnterService.selectJikrDogsCrossList(grcode, grseq, jikListMap);
			
			//학력별 리스트
			DataMap schMap = stuEnterService.selectAppInfoStatisticsBySchoolRow(grcode, grseq);
			
			//연령별 정보
			DataMap ageRowMap = stuEnterService.selectAppInfoStatisticsByAgeRow(grcode, grseq);
			
			guide4 = new DataMap();
			guide4.add("DEPT_LIST_DATA", depListMap);
			guide4.add("DEPTDOGS_LIST_DATA", deptResultList);
			guide4.add("JIKR_LIST_DATA", jikListMap);
			guide4.add("JIKRDOGS_LIST_DATA", jikrResultList);
			guide4.add("AGE_ROW_DATA", ageRowMap);
			guide4.add("SCHOOL_ROW_DATA", schMap);
		}else
			guide4 = new DataMap();
		
		if(rowMap.getString("guide4").equals("Y")){
			//교육생 명단 리스트.
			guide5 = stuEnterService.selectAppInfoBySessAndDeptList(grcode, grseq);
		}else
			guide5 = new DataMap();
		
		model.addAttribute("GUIDE2_DATA", guide2);
		model.addAttribute("GUIDE3_DATA", guide3);
		model.addAttribute("GUIDE4_DATA", guide4);
		model.addAttribute("GUIDE5_DATA", guide5);
		
		System.out.println("#1");
		
		return "/courseMgr/courseGuide/courseGuidePreviewPop";
	}
	
	/**
	 * 과정 안내문 관리 등록/ 수정/ 삭제 실행.
	 */
	@RequestMapping(value="/courseMgr/courseGuide.do", params = "mode=exec")
	public String exec(@ModelAttribute("cm") CommonMap cm, Model model) throws BizException {
		DataMap requestMap = cm.getDataMap();
		requestMap.setNullToInitialize(true);
		
		// 결과 메세지.
		String qu = requestMap.getString("qu");
		String msg = ""; 
		
		//실제 데이터 처리. 
		if(qu.equals("insert")){ //등록
			int result = courseGuideService.insertGrGuide(requestMap);
			if(result == -1)
				msg = "이미 등록되어있습니다.";
			else if (result > 0)
				msg = "등록 되었습니다.";
			else
				msg = "실패 되었습니다.";
		}else if(requestMap.getString("qu").equals("update")){ //수정.
			int result = courseGuideService.updateGrGuide(requestMap);
			if (result > 0)
				msg = "수정 되었습니다.";
			else
				msg = "실패 ";
		}else if(requestMap.getString("qu").equals("delete")){ //삭제
			int result = courseGuideService.deleteGrGuide(requestMap.getString("commGrcode"), requestMap.getString("commGrseq"), requestMap.getString("guideTitle"));
			if (result > 0)
				msg = "수정 되었습니다.";
			else
				msg = "실패 ";
			msg = "삭제 되었습니다.";
		}

		model.addAttribute("RESULT_MSG", msg);
		
		return "/courseMgr/courseGuide/courseGuideExec";
	}
}
