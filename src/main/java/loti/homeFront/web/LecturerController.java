package loti.homeFront.web;

import java.net.URLDecoder;

import loti.common.service.CommonService;
import loti.homeFront.service.LecturerService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import ut.lib.support.CommonMap;
import ut.lib.support.DataMap;
import ut.lib.util.Util;

import common.controller.BaseController;

@Controller
public class LecturerController extends BaseController {

	@Autowired
	private LecturerService lecturerService;
	
	@Autowired
	private CommonService commonService;
	
	@ModelAttribute("cm")
	public CommonMap common(
				CommonMap cm
				, Model model
				, @RequestParam(value="mode", required=false, defaultValue="") String mode
			) throws Exception{
		
		DataMap requestMap = cm.getDataMap();
		requestMap.setNullToInitialize(true);				

		model.addAttribute("REQUEST_DATA", requestMap);
		
		return cm;
	}
	
	public String findView(Model model, String mode, String view){
		
		model.addAttribute("mode", mode);
		
		if("errorMsg".equals(mode)){
			return "/homepage/errorMsg";
		}
		if("lecturer4".equals(mode)){
			return "/homepage/lecturer04";
		}
		
		return view;
	}
	
	@RequestMapping(value="/homepage/lecturer.do", params="mode=lecturer1")
	public String lecturer1(
				@ModelAttribute("cm") CommonMap cm
				, @RequestParam("mode") String mode
				, Model model
			){
		
		return findView(model, mode, "/homepage/lecturer01");
	}
	
	@RequestMapping(value="/homepage/lecturer.do", params="mode=lecturer2", method={RequestMethod.GET, RequestMethod.PUT, RequestMethod.DELETE})
	public String lecturer2(
			@ModelAttribute("cm") CommonMap cm
			, @RequestParam("mode") String mode
			, Model model
			){
		
		mode = "errorMsg";
		model.addAttribute("errorCode", "-9999");
		model.addAttribute("errorMsg", "잘못된 방법으로 접근 하셨습니다.");
		
		return findView(model, mode, "/homepage/lecturer02");
	}
	
	@RequestMapping(value="/homepage/lecturer.do", params="mode=lecturer3", method={RequestMethod.GET, RequestMethod.PUT, RequestMethod.DELETE})
	public String lecturer3(
			@ModelAttribute("cm") CommonMap cm
			, @RequestParam("mode") String mode
			, Model model
			){
		
		mode = "errorMsg";
		model.addAttribute("errorCode", "-9999");
		model.addAttribute("errorMsg", "잘못된 방법으로 접근 하셨습니다.");
		
		return findView(model, mode, "/homepage/lecturer02");
	}
	
	@RequestMapping(value="/homepage/lecturer.do", params="mode=lecturer2", method=RequestMethod.POST)
	public String lecturer2Post(
			@ModelAttribute("cm") CommonMap cm
			, @RequestParam("mode") String mode
			, Model model
			){
		
		return findView(model, mode, "/homepage/lecturer02");
	}
	
	@RequestMapping(value="/homepage/lecturer.do", params="mode=lecturer3", method=RequestMethod.POST)
	public String lecturer3Post(
			@ModelAttribute("cm") CommonMap cm
			, @RequestParam("mode") String mode
			, Model model
			){
		
		return findView(model, mode, "/homepage/lecturer03");
	}
	
	@RequestMapping(value="/homepage/lecturer.do", params="mode=lecturerSearch")
	public String lecturerSearch(
				@ModelAttribute("cm") CommonMap cm
				, @RequestParam("mode") String mode
				, Model model
				, @RequestParam(value="name", required=false, defaultValue="") String name
				, @RequestParam(value="birth1", required=false, defaultValue="") String birth1
				, @RequestParam(value="birth2", required=false, defaultValue="") String birth2
				, @RequestParam(value="birth3", required=false, defaultValue="") String birth3
				, @RequestParam(value="password", required=false, defaultValue="") String password
			) throws Exception{
		
		name = URLDecoder.decode(name, "UTF-8");
	
		model.addAttribute("name", name);
		model.addAttribute("birth1", birth1);
		model.addAttribute("birth2", birth2);
		model.addAttribute("birth3", birth3);
		model.addAttribute("LECTURER_LIST" , lecturerService.getLecturerSearch(name, birth1+birth2+birth3, password));
		
		return findView(model, mode, "/homepage/lecturerSearch");
	}
	
	@RequestMapping(value="/homepage/lecturer.do", params="mode=deleteLecturer", method={RequestMethod.GET, RequestMethod.PUT, RequestMethod.DELETE})
	public String deleteLecturer(Model model){
		String mode = "errorMsg";
		model.addAttribute("errorCode", "-9999");
		model.addAttribute("errorMsg", "잘못된 방법으로 접근 하셨습니다.");
		return findView(model, mode, "");
	}
	
	@RequestMapping(value="/homepage/lecturer.do", params="mode=deleteLecturer", method=RequestMethod.POST)
	public String deleteLecturerPost(
			@ModelAttribute("cm") CommonMap cm
			, @RequestParam("mode") String mode
			, Model model
			, @RequestParam(value="seqno", required=false, defaultValue="") String seqno
			, @RequestParam(value="name", required=false, defaultValue="") String name
			, @RequestParam(value="birth1", required=false, defaultValue="") String birth1
			, @RequestParam(value="birth2", required=false, defaultValue="") String birth2
			, @RequestParam(value="birth3", required=false, defaultValue="") String birth3
			, @RequestParam(value="password", required=false, defaultValue="") String password
			) throws Exception{
		
			
		String groupFileNo = Util.getValue(lecturerService.getLecturerFileNo(seqno, name, birth1+birth2+birth3, password), "");	// 삭제전 파일 넘버 받아온다		
		int errorCode = lecturerService.deleteLecturer(seqno);

		if(errorCode == 1){
			if(!"".equals(groupFileNo)) {
				lecturerService.deleteFileInfo(Integer.valueOf(groupFileNo)); // 파일삭제
			}
			model.addAttribute("result","ok");
		}else{
			model.addAttribute("result","fail");
		}
		
		return findView(model, mode, "/homepage/eduInfo/reservationconfirmAjaxAction");
	}
	@RequestMapping(value="/homepage/lecturer.do", params="mode=fromLecturer", method={RequestMethod.GET, RequestMethod.PUT, RequestMethod.DELETE})
	public String fromLecturer(Model model){
		
		String mode = "errorMsg";
		model.addAttribute("errorCode", "-9999");
		model.addAttribute("errorMsg", "잘못된 방법으로 접근 하셨습니다.");
		
		return findView(model, mode, "");
	}
	@RequestMapping(value="/homepage/lecturer.do", params="mode=fromLecturer", method=RequestMethod.POST)
	public String fromLecturerPost(
			@ModelAttribute("cm") CommonMap cm
			, @RequestParam("mode") String mode
			, Model model
			, @RequestParam(value="seqno", required=false, defaultValue="") String seqno
			, @RequestParam(value="name", required=false, defaultValue="") String name
			, @RequestParam(value="birth1", required=false, defaultValue="") String birth1
			, @RequestParam(value="birth2", required=false, defaultValue="") String birth2
			, @RequestParam(value="birth3", required=false, defaultValue="") String birth3
			, @RequestParam(value="password", required=false, defaultValue="") String password
			) throws Exception{
		
		name = URLDecoder.decode(Util.getValue(name), "UTF-8");
		String birth = birth1+birth2+birth3;
	
		//파일 정보 가져오기.
		model.addAttribute("seqno", seqno);
		String groupFileNo = lecturerService.getLecturerFileNo(seqno, name, birth1+birth2+birth3, password);
		model.addAttribute("name", name);
		model.addAttribute("birth1", birth1);
		model.addAttribute("birth2", birth2);
		model.addAttribute("birth3", birth3);
		model.addAttribute("groupFileNo", groupFileNo);
		model.addAttribute("LECTURER_LIST" , lecturerService.getLecturerView(seqno, name, birth, password));
		model.addAttribute("LECTURER_HISTORY_LIST1" , lecturerService.lecturerHistoryList(seqno, "1"));
		model.addAttribute("LECTURER_HISTORY_LIST2" , lecturerService.lecturerHistoryList(seqno, "2"));
		model.addAttribute("LECTURER_HISTORY_LIST3" , lecturerService.lecturerHistoryList(seqno, "3"));
		model.addAttribute("LECTURER_HISTORY_LIST4" , lecturerService.lecturerHistoryList(seqno, "4"));
		if(!"".equals(groupFileNo)) {
			model.addAttribute("FILE_GROUP_LIST", commonService.selectUploadFileList(Integer.valueOf(groupFileNo)));
		}
		
		return findView(model, mode, "/homepage/fromLecturer");
	}
	
}
