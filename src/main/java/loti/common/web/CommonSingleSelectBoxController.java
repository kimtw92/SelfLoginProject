package loti.common.web;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import loti.baseCodeMgr.service.DicService;
import loti.common.service.CommonService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import ut.lib.login.LoginInfo;
import ut.lib.support.CommonMap;
import ut.lib.support.DataMap;
import ut.lib.util.Util;
import common.controller.BaseController;

@Controller
public class CommonSingleSelectBoxController extends BaseController {

	@Autowired
	private CommonService commonService;
	
	@Autowired
	private DicService dicService;
	
	@ModelAttribute("cm")
	public CommonMap common(
				CommonMap cm
				, HttpServletRequest request
			){
		
		// 리퀘스트 받기
		DataMap requestMap = cm.getDataMap();
		requestMap.setNullToInitialize(true);
		
		// 로그인 정보
		LoginInfo memberInfo = (LoginInfo)request.getAttribute("LOGIN_INFO");
		
		//default mode
		String mode = Util.getValue(requestMap.getString("mode"));		
		
		return cm;
	}
	
	public String findView(String mode, String defaultView){
		return defaultView;
	}
	
	@RequestMapping(value="/commonInc/singleSelectBox.do", params="mode=dicGroup")
	public String dicGroup(
				@ModelAttribute("cm") CommonMap cm
				, Model model
			) throws Exception{
		
		DataMap requestMap = cm.getDataMap();
		
		DataMap listMap = commonService.selectDicGroupCodeByCbo();
		
		// 결과 데이타 (selectBox 태그가 들어 있음)
		model.addAttribute("LIST_MAP", listMap);
		
		return findView(requestMap.getString("mode"), "/commonInc/ajax/commonSearchSingleSelectBox");
	}
	
	@RequestMapping(value="/commonInc/singleSelectBox.do", params="mode=subj")
	public String subj(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			) throws Exception{
		
		DataMap requestMap = cm.getDataMap();
		
		DataMap listMap = commonService.selectSubjCodeByCbo();
		
		// 결과 데이타 (selectBox 태그가 들어 있음)
		model.addAttribute("LIST_MAP", listMap);
		
		return findView(requestMap.getString("mode"), "/commonInc/ajax/commonSearchSingleSelectBox");
	}
	
	@RequestMapping(value="/commonInc/singleSelectBox.do", params="mode=dicType")
	public String dicType(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			) throws Exception{
		
		DataMap requestMap = cm.getDataMap();
		
		DataMap listMap = dicService.selectDicTypeList();
		
		// 결과 데이타 (selectBox 태그가 들어 있음)
		model.addAttribute("LIST_MAP", listMap);
		
		return findView(requestMap.getString("mode"), "/commonInc/ajax/commonSearchSingleSelectBox");
	}
	
	@RequestMapping(value="/commonInc/singleSelectBox.do", params="mode=tutorGubun")
	public String tutorGubun(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			) throws Exception{
		
		DataMap requestMap = cm.getDataMap();
		
		DataMap listMap = commonService.selectTutorGubunByCbo();
		
		// 결과 데이타 (selectBox 태그가 들어 있음)
		model.addAttribute("LIST_MAP", listMap);
		
		return findView(requestMap.getString("mode"), "/commonInc/ajax/commonSearchSingleSelectBox");
	}
	
	@RequestMapping(value="/commonInc/singleSelectBox.do", params="mode=tutorLevel")
	public String tutorLevel(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			) throws Exception{
		
		DataMap requestMap = cm.getDataMap();
		
		DataMap listMap = commonService.selectTutorLevelByCbo();
		
		// 결과 데이타 (selectBox 태그가 들어 있음)
		model.addAttribute("LIST_MAP", listMap);
		
		return findView(requestMap.getString("mode"), "/commonInc/ajax/commonSearchSingleSelectBox");
	}
}
