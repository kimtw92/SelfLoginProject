package loti.courseMgr.web;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import loti.courseMgr.service.OutTimeTableService;

import org.springframework.beans.factory.annotation.Autowired;
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
import common.controller.BaseController;

@Controller
public class OutTimeTableController extends BaseController {

	@Autowired
	private OutTimeTableService outTimeTableService;
	
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
			
			model.addAttribute("REQUEST_DATA", requestMap);
			model.addAttribute("LOGIN_INFO", memberInfo);
		} catch (Exception e) {
			throw new BizException(e);
		} finally {
			
		}
		
		return cm;
	}
	
	/**
	 * 외부강사 시간표 리스트.
	 */
	@RequestMapping(value="/courseMgr/outTimeTable.do", params = "mode=list")
	public String list(@ModelAttribute("cm") CommonMap cm, Model model) throws BizException {
		DataMap requestMap = cm.getDataMap();
		requestMap.setNullToInitialize(true);
		
		//리퀘스트로 넘어온 날짜가 없다면 오늘날짜로 셋팅.
        String reqDate = requestMap.getString("searchDate"); //기준되는 날짜.
        if( reqDate.equals("") ){
        	reqDate = DateUtil.getDateTime();
        	requestMap.setString("searchDate", reqDate);
        }
        
		String weekSdate = ""; //기준일 주차의 시작일(일요일)
		String weekEdate = ""; //현재주차의 종료일 (토요일)
		
		String prevWeekDate = ""; //지난주 일자 (기준일의 일주일전)
		String nextWeekDate = ""; //다음주의 일자 (기준일의 일주일후)
		
		String prevMonthDate = ""; //지난주 일자 (기준일의 일주일전)
		String nextMonthDate = ""; //다음주의 일자 (기준일의 일주일후)
		
		//기준일의 시작일, 종료일, 지난주의 일자, 다음주의 일자 를  구한다.
		DataMap tmpDateMap = outTimeTableService.selectOutTimeTableByEtcRow(reqDate);
		if(tmpDateMap == null) tmpDateMap = new DataMap();
		tmpDateMap.setNullToInitialize(true);
		
		weekSdate = tmpDateMap.getString("weekStartDate"); //기준일의 시작일
		weekEdate = tmpDateMap.getString("weekEndDate"); //기준일의 종료일
		prevWeekDate = tmpDateMap.getString("prevWeekDate"); //기준일의 일주일전
		nextWeekDate = tmpDateMap.getString("nextWeekDate"); //기준일의 일주일후
		prevMonthDate = tmpDateMap.getString("prevMonthDate"); //기준일의 1달전
		nextMonthDate = tmpDateMap.getString("nextMonthDate"); //기준일의 1달후
		
		requestMap.setString("weekSdate", weekSdate);
		requestMap.setString("weekEdate", weekEdate);
		requestMap.setString("prevWeekDate", prevWeekDate);
		requestMap.setString("nextWeekDate", nextWeekDate);
		requestMap.setString("prevMonthDate", prevMonthDate);
		requestMap.setString("nextMonthDate", nextMonthDate);
		
		//교시 정보. (세로) START
		//DataMap timeGosiMap = timeService.selectTimeGosiList("");;
		
		//요일 정보 (가로)
		DataMap weekDateList = outTimeTableService.selectOutTimeTableByWeekDateRow(weekSdate);
		
		//강의실 정보 (세로)
		DataMap classList = outTimeTableService.selectClassRoomList();
		
		//시간표  리스트 
		DataMap listMap = outTimeTableService.selectOutTimeTableList(weekSdate, weekEdate);
		
		//request.setAttribute("GOSI_LIST_DATA", timeGosiMap);
		model.addAttribute("WEEK_LIST_MAP", weekDateList);
		model.addAttribute("CLASS_LIST_MAP", classList);
		model.addAttribute("LIST_DATA", listMap);
		
		return "/courseMgr/outTimeTable/outTimeTableList";
	}
	
	/**
	 * 등록 / 수정
	 */
	@RequestMapping(value="/courseMgr/outTimeTable.do", params = "mode=form")
	public String form(@ModelAttribute("cm") CommonMap cm, Model model) throws BizException {
		DataMap requestMap = cm.getDataMap();
		requestMap.setNullToInitialize(true);
		
		String qu = requestMap.getString("qu");
		
		DataMap rowMap = null;	//시간표 정보.
		
		//교시 사용여부
		DataMap gosiMap = outTimeTableService.selectOutTimeTableByStudytimeChkList(requestMap.getString("classNo"), requestMap.getString("studydate"), requestMap.getInt("seq"));
		
		//강의실 정보
		DataMap classMap = outTimeTableService.selectClassRoomRow(requestMap.getString("classNo"));
		
		if(qu.equals("insert")){ //과목 선택
			rowMap = new DataMap();
		}else if(qu.equals("update")){ //과목 수정
			rowMap = outTimeTableService.selectOutTimeTableRow(requestMap.getString("classNo"), requestMap.getString("studydate"), requestMap.getInt("seq"));
		}
		
		model.addAttribute("ROW_DATA", rowMap);
		model.addAttribute("GOSI_LIST_DATA", gosiMap);
		model.addAttribute("CLASS_ROW_DATA", classMap);
		
		return "/courseMgr/outTimeTable/outTimeTableFormPop";
	}

	/**
	 * 등록 / 수정 / 삭제 실행
	 */
	@RequestMapping(value="/courseMgr/outTimeTable.do", params = "mode=exec")
	public String exec(@ModelAttribute("cm") CommonMap cm, Model model) throws BizException {
		DataMap requestMap = cm.getDataMap();
		requestMap.setNullToInitialize(true);
		
		//사용자 정보 추출.
		LoginInfo loginInfo = (LoginInfo)cm.getRequest().getAttribute("LOGIN_INFO");
		
		String msg = ""; //결과 메세지.
		
		int result = 0;
		if(requestMap.getString("qu").equals("insert")){ //등록
			//시간표 등록
			result = outTimeTableService.insertOutTimeTable(requestMap, loginInfo.getSessNo());
			
			if(result > 0)
				msg = "등록 되었습니다.";
			else
				msg = "실패";
		}else if(requestMap.getString("qu").equals("update")){ //수정
			//시간표 수정
			result = outTimeTableService.updateOutTimeTable(requestMap, loginInfo.getSessNo());
			
			if(result > 0)
				msg = "수정 되었습니다.";
			else 
				msg = "실패";
		}else if(requestMap.getString("qu").equals("delete")){ //시간표 초기화
			//시간표 삭제
			result = outTimeTableService.deleteOutTimeTable(requestMap.getString("classNo"), requestMap.getString("studydate"), requestMap.getInt("seq"));
			
			if(result > 0)
				msg = "삭제 되었습니다.";
			else
				msg = "실패";
		}
		
		model.addAttribute("RESULT_MSG", msg);
		
		return "/courseMgr/outTimeTable/outTimeTableExec";
	}
}
