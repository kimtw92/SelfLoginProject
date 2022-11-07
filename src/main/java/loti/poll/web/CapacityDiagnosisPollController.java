package loti.poll.web;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import common.controller.BaseController;
import loti.common.service.CommonService;
import loti.poll.service.CapacityDiagnosisPollService;
import ut.lib.login.LoginCheck;
import ut.lib.login.LoginInfo;
import ut.lib.support.CommonMap;
import ut.lib.support.DataMap;

@Controller
public class CapacityDiagnosisPollController extends BaseController {

	@Autowired
	private CapacityDiagnosisPollService CapacityDiagnosisPollService;

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
		
		 //요청처리 - get, post 방식의 파라미터를 DataMap 에 저장
		DataMap requestMap = cm.getDataMap();
		//초기화 옵션(true 일경우 데이터를 뽑을때 null 일경우 초기화 - 빈문자열, 0....)
		requestMap.setNullToInitialize(true);
		
		//default mode
		if(requestMap.getString("mode").equals("")){
			requestMap.setString("mode", "view");
		}
		
		//관리자 로그인 체크. (관리자 페이지에는 모두 있어야 함)
		//LoginInfo memberInfo = LoginCheck.adminCheck(request, response, requestMap.getString("menuId"));
		//if (memberInfo == null) return null;
		
		
		
		//공통 Comm Select Box 값 초기 셋팅.
		if(requestMap.getString("commGrcode").equals("")){
			requestMap.setString("commGrcode", (String)session.getAttribute("sess_grcode"));
		}
		if(requestMap.getString("commGrseq").equals("")){
			requestMap.setString("commGrseq", (String)session.getAttribute("sess_grseq"));
		}
		
		//리퀘스트 정보를 담고있는 DataMap을 Attribute 에 추가
		model.addAttribute("REQUEST_DATA", requestMap);
		
		return cm;
	}
	
	public String findView(String mode, String defaultView){
		System.out.println("=============================== mode: " + mode);
		return defaultView;
	}
	/*
	@RequestMapping(value="/poll/capacityDiagnosisPoll.do")
	public String defaultProcess(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			) throws Exception{
		return null; //view(cm, model);
	}
	*/
	// 5급역량강화과정 역량진단 설문 페이지 이동
	@RequestMapping(value="/poll/capacityDiagnosisPoll.do", params="mode=view")
	public String view(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			) throws Exception{
		DataMap requestMap = cm.getDataMap();
		System.out.println("/poll/capacityDiagnosisPoll.do... view");
		String mode = "view";
		String url = "";
		//사용자 정보 추출.
		LoginInfo loginInfo = cm.getLoginInfo();

		requestMap.setString("userno", loginInfo.getSessNo());
		System.out.println("requestMap: =========================== " + requestMap.toString());
		DataMap listMap = CapacityDiagnosisPollService.selectCapacityDiagnosisByCheck(requestMap);
		
		if(listMap.size() > 0){
			requestMap.set("msg", "이미 작성하셨습니다.");
			url = "/poll/capacityDiagnosis/result";
		} else {
			model.addAttribute("mode", "view");
			model.addAttribute("grcode", requestMap.getString("grcode"));
			model.addAttribute("grseq", requestMap.getString("grseq"));
			model.addAttribute("banda", requestMap.getString("banda"));
			System.out.println("=============================== model : " + model.toString());
			
			url = "/poll/capacityDiagnosis/capacityDiagnosisPollView";
		}
		model.addAttribute("REQUES_DATA", requestMap);
		return findView(mode, url);
	}
	
	@RequestMapping(value="/poll/capacityDiagnosisPoll.do", params="mode=form")
	public String form(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			) throws Exception{
		
		DataMap requestMap = cm.getDataMap();

		//사용자 정보 추출.
		LoginInfo loginInfo = cm.getLoginInfo();

		requestMap.setString("userno", loginInfo.getSessNo());
		
		// 설문작성 내용 등록...
		int resultcnt = CapacityDiagnosisPollService.insertCapacityDiagnosis(requestMap);
		
		if (resultcnt > 0){
			// 역량강화과정 역량진단 설문지 결과 조회
			DataMap listMap = CapacityDiagnosisPollService.selectCapacityDiagnosisBySearchList(requestMap);
			model.addAttribute("LIST_DATA", listMap);
		}
//		requestMap.setString("commGrcode", requestMap.getString("grcode"));
//		requestMap.setString("commGrseq", requestMap.getString("grseq"));
//		requestMap.setString("userNo", loginInfo.getSessNo());	
		
		return findView(requestMap.getString("mode"), "/poll/capacityDiagnosis/capacityDiagnosisPollByResult");
	}
	
	@RequestMapping(value="/poll/capacityDiagnosisPoll.do", params="mode=result_excel")
	public String tutor_poll_excel(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			) throws Exception{
		
		DataMap requestMap = cm.getDataMap();
		//사용자 정보 추출.
		LoginInfo loginInfo = cm.getLoginInfo();
		requestMap.setString("userno", loginInfo.getSessNo());

		//설문 리스트
		DataMap listMap = CapacityDiagnosisPollService.selectCapacityDiagnosisBySearchList(requestMap);
		
		model.addAttribute("LIST_DATA", listMap);
		
		return findView(requestMap.getString("mode"), "/poll/capacityDiagnosis/capacityDiagnosisPollByExcel");
	}

	// 4급역량강화과정 역량진단 설문 페이지 이동
	@RequestMapping(value="/poll/capacityDiagnosisPoll4.do", params="mode=view")
	public String view4(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			) throws Exception{
		DataMap requestMap = cm.getDataMap();
		System.out.println("/poll/capacityDiagnosisPoll.do... view");
		String mode = "view";
		String url = "";
		//사용자 정보 추출.
		LoginInfo loginInfo = cm.getLoginInfo();

		requestMap.setString("userno", loginInfo.getSessNo());
		System.out.println("requestMap: =========================== " + requestMap.toString());
		DataMap listMap = CapacityDiagnosisPollService.selectCapacityDiagnosisByCheck(requestMap);
		
		if(listMap.size() > 0){
			requestMap.set("msg", "이미 작성하셨습니다.");
			url = "/poll/capacityDiagnosis4/result";
		} else {
			model.addAttribute("mode", "view");
			model.addAttribute("grcode", requestMap.getString("grcode"));
			model.addAttribute("grseq", requestMap.getString("grseq"));
			model.addAttribute("banda", requestMap.getString("banda"));
			System.out.println("=============================== model : " + model.toString());
			
			url = "/poll/capacityDiagnosis4/capacityDiagnosisPollView";
		}
		model.addAttribute("REQUES_DATA", requestMap);
		return findView(mode, url);
	}
	
	@RequestMapping(value="/poll/capacityDiagnosisPoll4.do", params="mode=form")
	public String form4(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			) throws Exception{
		
		DataMap requestMap = cm.getDataMap();

		//사용자 정보 추출.
		LoginInfo loginInfo = cm.getLoginInfo();

		requestMap.setString("userno", loginInfo.getSessNo());
		
		// 설문작성 내용 등록...
		int resultcnt = CapacityDiagnosisPollService.insertCapacityDiagnosis(requestMap);
		
		if (resultcnt > 0){
			// 역량강화과정 역량진단 설문지 결과 조회
			DataMap listMap = CapacityDiagnosisPollService.selectCapacityDiagnosisBySearchList(requestMap);
			model.addAttribute("LIST_DATA", listMap);
		}
//		requestMap.setString("commGrcode", requestMap.getString("grcode"));
//		requestMap.setString("commGrseq", requestMap.getString("grseq"));
//		requestMap.setString("userNo", loginInfo.getSessNo());	
		
		return findView(requestMap.getString("mode"), "/poll/capacityDiagnosis4/capacityDiagnosisPollByResult");
	}
	
	@RequestMapping(value="/poll/capacityDiagnosisPoll4.do", params="mode=result_excel")
	public String tutor_poll4_excel(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			) throws Exception{
		
		DataMap requestMap = cm.getDataMap();
		//사용자 정보 추출.
		LoginInfo loginInfo = cm.getLoginInfo();
		requestMap.setString("userno", loginInfo.getSessNo());

		//설문 리스트
		DataMap listMap = CapacityDiagnosisPollService.selectCapacityDiagnosisBySearchList(requestMap);
		
		model.addAttribute("LIST_DATA", listMap);
		
		return findView(requestMap.getString("mode"), "/poll/capacityDiagnosis4/capacityDiagnosisPollByExcel");
	}

}
