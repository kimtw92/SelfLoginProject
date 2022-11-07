package loti.courseMgr.web;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import loti.courseMgr.service.CompleteProgressService;
import loti.courseMgr.service.CourseSeqService;
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
import ut.lib.util.DateUtil;
import ut.lib.util.StringReplace;
import common.controller.BaseController;

@Controller("courseMgrTimeTableController")
public class TimeTableController extends BaseController {

	@Autowired
	@Qualifier("courseMgrTimeTableService")
	private TimeTableService timeTableService;
	@Autowired
	private CourseSeqService courseSeqService;
	@Autowired
	private CompleteProgressService completeProgressService;
	
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
			if(requestMap.getString("commGrseq").equals(""))
				requestMap.setString("commGrseq", (String)session.getAttribute("sess_grseq"));
			
			model.addAttribute("REQUEST_DATA", requestMap);
			model.addAttribute("LOGIN_INFO", memberInfo);
		} catch (Exception e) {
			throw new BizException(e);
		} finally {
			
		}
		
		return cm;
	}
	
	/**
	 * 시간표 리스트.
	 */
	@RequestMapping(value="/courseMgr/timeTable.do", params = "mode=list")
	public String list(@ModelAttribute("cm")CommonMap cm, Model model) throws BizException {
		DataMap requestMap = cm.getDataMap();
		requestMap.setNullToInitialize(true);
		
		//사용자 정보 추출.
		LoginInfo loginInfo = (LoginInfo)cm.getRequest().getAttribute("LOGIN_INFO");
		
		DataMap grseqRowMap = null;
		DataMap listMap = null;
		DataMap grseqClassroomMap = null; //기수의 강의실 정보.
		
		if(requestMap.getString("searchKey").equals(""))
			requestMap.setString("searchKey", "MORNING");
		
		if(!requestMap.getString("commGrcode").equals("") && !requestMap.getString("commGrseq").equals("")){
			
			//과정 기수 정보
			grseqRowMap = courseSeqService.selectGrSeqRow(requestMap.getString("commGrcode"), requestMap.getString("commGrseq"));
			if(grseqRowMap == null) grseqRowMap = new DataMap();
			grseqRowMap.setNullToInitialize(true);
			
			//리스트
			listMap = timeTableService.selectTimeTableList(requestMap, grseqRowMap, loginInfo);
			
			//기수의 강의실 및 과정장.
			grseqClassroomMap = timeTableService.selectClassRoomByGrseqRow(requestMap.getString("commGrcode"), requestMap.getString("commGrseq")); //기수의 강의실 정보.
		
		}else{
			grseqRowMap = new DataMap();
			listMap = new DataMap();
			grseqClassroomMap = new DataMap(); //기수의 강의실 정보.
		}
		model.addAttribute("LIST_DATA", listMap);
		model.addAttribute("GRSEQ_ROW_DATA", grseqRowMap);
		model.addAttribute("GRSEQ_CLASSROOM_ROW_DATA", grseqClassroomMap);
		
		return "/courseMgr/timeTable/timeTableList";
	}
	
	
	
	/**
	 * 시간표 등록(과목선택) / 과목수정 / 과목 추가. 
	 */
	@RequestMapping(value="/courseMgr/timeTable.do", params = "mode=form")
	public String form(@ModelAttribute("cm")CommonMap cm, Model model) throws BizException {
		DataMap requestMap = cm.getDataMap();
		requestMap.setNullToInitialize(true);
		
		//사용자 정보 추출.
		//LoginInfo loginInfo = (LoginInfo)request.getAttribute("LOGIN_INFO");
		
		String grcode = requestMap.getString("grcode");
		String grseq = requestMap.getString("grseq");
		String qu = requestMap.getString("qu");
		
		DataMap grSeqRowMap = courseSeqService.selectGrSeqRow(grcode, grseq); //과정 기수 정보.
		DataMap grseqClassroomMap = timeTableService.selectClassRoomByGrseqRow(grcode, grseq); //기수의 강의실 정보.
		
		DataMap rowMap = null;	//시간표 정보.
		DataMap tutorMap = null; //강사
		
		if(qu.equals("insert")){ //과목 선택
			
			rowMap = new DataMap();
			tutorMap = new DataMap();
			
		}else if(qu.equals("update")){ //과목 수정
			
			rowMap = timeTableService.selectTimeTableRow(requestMap);
			tutorMap = timeTableService.selectTimeTableTuListBySubj(requestMap);
			
		}else if(qu.equals("add")){ //과목 추가.
			
			rowMap = new DataMap();
			tutorMap = new DataMap();
			
		}
		model.addAttribute("ROW_DATA", rowMap);
		model.addAttribute("TUTOR_LIST_DATA", tutorMap);
		model.addAttribute("GRSEQ_ROW_DATA", grSeqRowMap);
		model.addAttribute("GRSEQ_CLASSROOM_ROW_DATA", grseqClassroomMap);
		
		return "/courseMgr/timeTable/timeTableFormPop";
	}
	
	/**
	 * 교과목편성시간및 강사
	 */
	@RequestMapping(value="/courseMgr/timeTable.do", params = "mode=view")
	public String view(@ModelAttribute("cm")CommonMap cm, Model model) throws BizException {
		DataMap requestMap = cm.getDataMap();
		requestMap.setNullToInitialize(true);
		
		//사용자 정보 추출.
		//LoginInfo loginInfo = (LoginInfo)request.getAttribute("LOGIN_INFO");
		
		String grcode = requestMap.getString("grcode");
		String grseq = requestMap.getString("grseq");
		
		DataMap grSeqRowMap = courseSeqService.selectGrSeqRow(grcode, grseq); //과정 기수 정보.
		
		//과목분류별 건수를 조회
		DataMap subjGubunCntMap = timeTableService.selectTimeTableBySubjGubunCount(grcode, grseq);
		
		DataMap listMap = timeTableService.selecttimeTableBySubjGubunList(grcode, grseq);

		model.addAttribute("LIST_DATA", listMap);
		model.addAttribute("COUNT_LIST_DATA", subjGubunCntMap);
		model.addAttribute("GRSEQ_ROW_DATA", grSeqRowMap);
		
		return "/courseMgr/timeTable/timeTableViewPop";
	}
	
	/**
	 * 시간표 출력양식
	 */
	@RequestMapping(value="/courseMgr/timeTable.do", params = "mode=print")
	public String print(@ModelAttribute("cm")CommonMap cm, Model model) throws BizException {
		DataMap requestMap = cm.getDataMap();
		requestMap.setNullToInitialize(true);
		
		if(requestMap.getString("searchStarted").equals(""))
			requestMap.setString("searchStarted", DateUtil.getDateTime());
		if(requestMap.getString("searchEnddate").equals(""))
			requestMap.setString("searchEnddate", DateUtil.getDateTime());
		
		if(requestMap.getString("searchType").equals(""))
			requestMap.setString("searchType", "M");
		
		//일자로 검색된 과정 정보.
		DataMap listMap = new DataMap();
		if(requestMap.getString("search").equals("GO"))
			listMap = timeTableService.selectTimeTableByPrint(requestMap);
		else
			listMap = new DataMap();
		model.addAttribute("LIST_DATA", listMap);
		
		return "/courseMgr/timeTable/timeTablePrint";
	}
	
	/**
	 * 과목선택/과목수정/과목추가 / 일자별 삭제 / 초기화 실행
	 */
	@RequestMapping(value="/courseMgr/timeTable.do", params = "mode=exec")
	public String exec(@ModelAttribute("cm")CommonMap cm, Model model) throws BizException {
		DataMap requestMap = cm.getDataMap();
		requestMap.setNullToInitialize(true);
		
		//사용자 정보 추출.
		LoginInfo loginInfo = (LoginInfo)cm.getRequest().getAttribute("LOGIN_INFO");
		
		
		String msg = ""; //결과 메세지.
		
		String grcode = requestMap.getString("grcode");
		String grseq = requestMap.getString("grseq");
		
		Map<String, Object> paramMap = null;
		
		int result = 0;
		if(requestMap.getString("qu").equals("insert")){ //등록
			
			//현재 등록 여부 체크
			result = timeTableService.selectTimeTableBySubjChk(grcode, grseq, requestMap.getString("studydate"), requestMap.getInt("studytime"), requestMap.getString("subj"));
			if(result > 0)
				msg = "같은 교시에 같은과목은 등록할 수  없습니다.";
			else{
				
				if(!requestMap.getString("classroomNo").equals("") 
						&& timeTableService.selectOutTimeTableChk(requestMap.getString("classroomNo"), requestMap.getString("studydate"), requestMap.getInt("studytime")) > 0){
					
					msg = "외부강사 시간표와 중복되어 등록 할 수 없습니다.";
					
				}else{
					//시간표 등록
					result = timeTableService.insertTimeTable(requestMap, loginInfo.getSessNo());
					
					if(result > 0)
						msg = "과목이 등록 되었습니다.";
					else
						msg = "실패";
				}
				
			}

			
		}else if(requestMap.getString("qu").equals("update")){ //수정
			
			if(!requestMap.getString("classroomNo").equals("") 
					&& timeTableService.selectOutTimeTableChk(requestMap.getString("classroomNo"), requestMap.getString("studydate"), requestMap.getInt("studytime")) > 0){
				
				msg = "외부강사 시간표와 중복되어 등록 할 수 없습니다.";
				
			}else{
				
				//시간표 수정
				result = timeTableService.updateTimeTable(requestMap, loginInfo.getSessNo());
				
				if(result > 0)
					msg = "과목이 수정 되었습니다.";
				else if(result < 0)
					msg = "같은 교시에 같은과목은 등록할 수  없습니다.";
				else 
					msg = "실패";
				
			}

			
		}else if(requestMap.getString("qu").equals("add")){ //과목 추가
			
			//시간표 수정
			result = timeTableService.addTimeTable(requestMap, loginInfo.getSessNo());
			
			if(result > 0)
				msg = "과목이 추가 되었습니다.";
			else if(result < 0){
				if(result == -2)
					msg = "외부강사 시간표와 중복되어 등록 할 수 없습니다.";
				else
					msg = "같은 교시에 같은과목은 등록할 수  없습니다.";
			}else 
				msg = "실패";
			
		}else if(requestMap.getString("qu").equals("delete")){ //시간표 초기화
			
			
			//이미 이수된 과정기수는 수정이 불가능하다.
			paramMap = new HashMap<String, Object>();
			paramMap.put("grcode", grcode);
			paramMap.put("grseq", grseq);
			result = completeProgressService.selectGrseqCloseYesChk(paramMap);
			if(result > 0)
				msg = "이수된 과정기수는 시간표 초기화가 불가능합니다.";
			else{
				
				//시간표 초기화
				result = timeTableService.deleteTimeTableGrseq(grcode, grseq);
				
				if(result > 0)
					msg = "초기화 되었습니다.";
				else
					msg = "실패";
				
			}
			
			
		}else if(requestMap.getString("qu").equals("delete_date")){ //일자 선택 삭제.

			//이미 이수된 과정기수는 수정이 불가능하다.
			paramMap = new HashMap<String, Object>();
			paramMap.put("grcode", grcode);
			paramMap.put("grseq", grseq);
			result = completeProgressService.selectGrseqCloseYesChk(paramMap);
			if(result > 0)
				msg = "이수된 과정기수는 시간표 초기화가 불가능합니다.";
			else{
				
				//해당일 시간표 초기화 
				result = timeTableService.deleteTimeTableDay(grcode, grseq, requestMap.getString("studydate"));
				
				if(result > 0)
					msg = "삭제되었습니다.";
				else
					msg = "실패";
				
			}
		
		}else if(requestMap.getString("qu").equals("complete")){ //시간표 확정

			//시간표 내용으로 개설과정의 강의시간 수정
			result = timeTableService.updateSubjSeqByLessonTime(grcode, grseq);
			
			if(result > 0)
				msg = "과목별시간이 강의(과목기수)정보의 강의시간으로 세팅되었습니다.";
			else
				msg = "실패";
				
			
		}
		
		model.addAttribute("RESULT_MSG", msg);
		
		return "/courseMgr/timeTable/timeTableExec";
	}
	
	/**
	 * 과목 검색
	 */
	@RequestMapping(value="/courseMgr/timeTable.do", params = "mode=search_subj")
	public String search_subj(@ModelAttribute("cm")CommonMap cm, Model model) throws BizException {
		DataMap requestMap = cm.getDataMap();
		requestMap.setNullToInitialize(true);
		
		String grcode = requestMap.getString("grcode");
		String grseq = requestMap.getString("grseq");
		
		DataMap grSeqRowMap = courseSeqService.selectGrSeqRow(grcode, grseq); //과정 기수 정보.
		DataMap tutorListMap = timeTableService.selectClassTutorListByClassRoom(grcode, grseq); //강사 리스트.
		DataMap listMap = timeTableService.selectSubjSeqBySubjSearchList(grcode, grseq); //과목리스트
		
		model.addAttribute("GRSEQ_ROW_DATA", grSeqRowMap);
		model.addAttribute("TUTOR_LIST_DATA", tutorListMap);
		model.addAttribute("LIST_DATA", listMap);
		
		return "/courseMgr/timeTable/searchSubjPop";
	}
	
	/**
	 * 강사 검색
	 */
	@RequestMapping(value="/courseMgr/timeTable.do", params = "mode=search_tutor")
	public String search_tutor(@ModelAttribute("cm")CommonMap cm, Model model) throws BizException {
		DataMap requestMap = cm.getDataMap();
		requestMap.setNullToInitialize(true);
		
		//강사 검색.
		DataMap listMap = null;
		//과목 추가의 시간 항목은 여러개가  '|' 문자를 포함한 형태로 입력 될수 있다. 
		if(requestMap.getString("studytime").indexOf("|") > -1){
			
			int studyTime = -3;
			
			try{
				studyTime = Integer.parseInt(StringReplace.subString(requestMap.getString("studytime"), 0, requestMap.getString("studytime").indexOf("|")));
			}catch(Exception e){
				studyTime = -3;
			}
			
			listMap = timeTableService.selectClassTutorByTimeTableSubjList(requestMap.getString("grcode"), requestMap.getString("grseq"), requestMap.getString("studydate"), studyTime, requestMap.getString("subj")); //과목리스트
		}else
			listMap = timeTableService.selectClassTutorByTimeTableSubjList(requestMap.getString("grcode"), requestMap.getString("grseq"), requestMap.getString("studydate"), requestMap.getInt("studytime"), requestMap.getString("subj")); //과목리스트
		
		model.addAttribute("LIST_DATA", listMap);
		
		return "/courseMgr/timeTable/searchTutorPop";
	}
}
