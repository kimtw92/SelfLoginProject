package loti.courseMgr.web;

import java.sql.SQLException;
import java.util.Enumeration;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import loti.courseMgr.service.EducationScoringService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.MultipartResolver;

import ut.lib.exception.BizException;
import ut.lib.login.LoginCheck;
import ut.lib.login.LoginInfo;
import ut.lib.support.CommonMap;
import ut.lib.support.DataMap;
import ut.lib.util.OMRReader;
import ut.lib.util.WebUtils;
import common.controller.BaseController;

@Controller
public class EducationScoringController extends BaseController {

	@Autowired
	private EducationScoringService educationScoringService;
	
	
	
	@ModelAttribute("cm")
	public CommonMap common(CommonMap cm
			              , Model model
			              , HttpServletRequest request
			              , HttpServletResponse response
			              ) throws BizException {
		
		try {
			
			DataMap requestMap = cm.getDataMap();
			requestMap.setNullToInitialize(true);
			
			String mode = requestMap.getString("mode");
			
			if (mode.equals("")) {
				mode = "list";
				requestMap.setString("mode", mode);
			}
			
			//관리자 로그인 체크 (관리자 페이지에는 모두 있어야 함.)
			LoginInfo memberInfo = LoginCheck.adminCheck(request, response, requestMap.getString("menuId"));
			if (memberInfo == null) {
				return null;
			}
			
			//공통 Comm Select Box 값 초기 셋팅.
			HttpSession session = request.getSession(); //세션
			if (requestMap.getString("year").equals("")) {
				requestMap.setString("year", (String)session.getAttribute("sess_year"));
			}
			if (requestMap.getString("grcode").equals("")) {
				requestMap.setString("grcode", (String)session.getAttribute("sess_grcode"));
			}
			
			model.addAttribute("REQUEST_DATA", requestMap);
			model.addAttribute("LOGIN_INFO", memberInfo);
		} catch (Exception e) {
			throw new BizException(e);
		} finally {
			
		}
		
		return cm;
	}
	
	@RequestMapping(value="/courseMgr/offScoring.do", params="mode=form", method=RequestMethod.GET)
	public String form(
				@ModelAttribute("cm") CommonMap cm
			) throws SQLException{
		
		DataMap examAnsList = educationScoringService.findExamAnsByKeyExceptUserid(cm.getDataMap());
		
		return "/courseMgr/scoring/offScoringForm";
//		return "/courseMgr/courseSeq/courseSeqList";
	}
	
	@RequestMapping(value="/courseMgr/offScoring.do", params="mode=grseqInfoAjax", method=RequestMethod.GET)
	public String grseqInfoAjax(
				@ModelAttribute("cm") CommonMap cm
				, Model model
			) throws Exception{
		
		DataMap grseqInfo = educationScoringService.findOneGrseqByKey(cm.getDataMap(), cm.getLoginInfo());
		
		model.addAttribute("grseqInfo", grseqInfo);
		
		return "/courseMgr/scoring/offScoringAjax";
	}
	
	@RequestMapping(value="/courseMgr/offScoring.do", params="mode=ansAjax", method=RequestMethod.GET)
	public String ansAjax(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			) throws Exception{
		
		DataMap ansList = educationScoringService.findAnsBySubjAndGrcodeAndGrseqAndIdExam(cm.getDataMap());
		
		model.addAttribute("ansList", ansList);
		
		return "/courseMgr/scoring/ansAjax";
	}
	
	@RequestMapping(value="/courseMgr/offScoring.do", params="mode=ansExcel", method=RequestMethod.GET)
	public String ansExcel(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			, HttpServletRequest request
			, HttpServletResponse response
			) throws Exception{
		
		DataMap ansList = educationScoringService.exportAnsToExcel(cm.getDataMap(), request, response);
		
		model.addAttribute("ansList", ansList);
		
		return "/courseMgr/scoring/ansAjax";
	}
	
	@RequestMapping(value="/courseMgr/offScoring.do", params="mode=ansScoringListExcel", method=RequestMethod.GET)
	public String ansScoringListExcel(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			, HttpServletRequest request
			, HttpServletResponse response
			) throws Exception{
		
		List<Map> ansScoringList = educationScoringService.exportAnsScoringListToExcel(cm.getDataMap(), request, response);
		
		model.addAttribute("ansScoringList", ansScoringList);
		
		return "/courseMgr/scoring/ansScoringList";
	}
	
	@RequestMapping(value="/courseMgr/offScoring.do", params="mode=saveAnsForm", method=RequestMethod.GET)
	public String saveAnsForm(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			) throws Exception{
		DataMap examMList = educationScoringService.findExamMByGrcodeAndGrseq(cm.getDataMap());
		model.addAttribute("examMList", examMList);
		return "/courseMgr/scoring/saveAnsForm";
	}
	
	@RequestMapping(value="/courseMgr/offScoring.do", params="mode=saveAns", method=RequestMethod.POST)
	public String saveAns(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			) throws Exception{
		
		int count = educationScoringService.saveOmrAns(cm.getDataMap(), cm.getLoginInfo());
		
		model.addAttribute("stuCnt", count);
		
		return "/courseMgr/scoring/saveAns";
	}
	
	@RequestMapping(value="/courseMgr/offScoring.do", params="mode=sendToLms", method=RequestMethod.POST)
	public String sendToLms(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			) throws Exception{
		
		int count = educationScoringService.sendToLms(cm.getDataMap(), cm.getLoginInfo());
		
		model.addAttribute("count", count);
		
		return "/courseMgr/scoring/sendToLms";
	}
	
	@RequestMapping(value="/courseMgr/offScoring.do", params="mode=scoringAns", method=RequestMethod.POST)
	public String scoringAns(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			) throws Exception{
		
		int res = educationScoringService.scoringAns(cm.getDataMap());
		
		model.addAttribute("res", res);
		
		return "/courseMgr/scoring/scoringAns";
	}
	
	@RequestMapping(value="/courseMgr/offScoring.do", params="mode=updateAns", method=RequestMethod.POST)
	public String updateAns(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			) throws Exception{
		
		int res = educationScoringService.updateAns(cm.getDataMap());
		
		model.addAttribute("res", res);
		
		return "/courseMgr/scoring/updateAns";
	}
	
	@RequestMapping(value="/courseMgr/offScoring.do", params="mode=completeAns", method=RequestMethod.POST)
	public String completeAns(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			) throws Exception{
		
		int res = educationScoringService.completeAns(cm.getDataMap());
		
		model.addAttribute("res", res);
		
		return "/courseMgr/scoring/completeAns";
	}
	
	@RequestMapping(value="/courseMgr/offScoring.do", params="mode=deleteAns", method=RequestMethod.POST)
	public String deleteAns(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			) throws Exception{
		
		int res = educationScoringService.deleteAns(cm.getDataMap());
		
		model.addAttribute("res", res);
		
		return "/courseMgr/scoring/deleteAns";
	}
	
	@RequestMapping(value="/courseMgr/offScoring.do", params="mode=deleteOneAns", method=RequestMethod.POST)
	public String deleteOneAns(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			) throws Exception{
		
		int res = educationScoringService.deleteAns(cm.getDataMap());
		
		model.addAttribute("res", res);
		
		return "/courseMgr/scoring/deleteOneAns";
	}
	
	@RequestMapping(value="/courseMgr/offScoring.do", params="mode=deleteBakAns", method=RequestMethod.POST)
	public String deleteBakAns(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			) throws Exception{
		
		int res = educationScoringService.deleteBakAns(cm.getDataMap());
		
		model.addAttribute("res", res);
		
		return "/courseMgr/scoring/deleteBakAns";
	}
	
	@RequestMapping(value="/courseMgr/offScoring.do", params="mode=restoreAns", method=RequestMethod.POST)
	public String restoreAns(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			) throws Exception{
		
		int res = educationScoringService.restoreAns(cm.getDataMap());
		
		model.addAttribute("res", res);
		
		return "/courseMgr/scoring/restoreAns";
	}
	
	@RequestMapping(value="/courseMgr/offScoring.do", params="mode=containsAns", method=RequestMethod.POST)
	public String containsAns(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			) throws Exception{
		
		List<String> usernos = educationScoringService.containsAnsByUserno(cm.getDataMap());
		
		model.addAttribute("usernos", usernos);
		
		return "/courseMgr/scoring/containsAns";
	}
	
	@RequestMapping(value="/courseMgr/offScoring.do", params="mode=userAnswers", method=RequestMethod.GET)
	public String userAnswers(
			@ModelAttribute("cm") CommonMap cm
			, Model model
			) throws Exception{
		
		List<Map> answers = educationScoringService.selectAnswers(cm.getDataMap());
		
		model.addAttribute("answers", answers);
		
		return "/courseMgr/scoring/userAnswers";
	}
	
	
	
}
