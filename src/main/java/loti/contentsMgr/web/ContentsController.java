package loti.contentsMgr.web;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import loti.contentsMgr.service.ContentsService;

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
import common.controller.BaseController;

@Controller
public class ContentsController extends BaseController {
	
	@Autowired
	private ContentsService contentsService;
	
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
	 * 콘텐츠 관리 리스트
	 */
	@RequestMapping(value="/contentsMgr/contents.do", params = "mode=list")
	public String list(@ModelAttribute("cm")CommonMap cm, Model model) throws BizException {
		DataMap requestMap = cm.getDataMap();
		requestMap.setNullToInitialize(true);
		
		if (requestMap.getString("currPage").equals("")) {
			requestMap.setInt("currPage", 1); //페이지
		}
		if (requestMap.getString("rowSize").equals("")) {
			requestMap.setInt("rowSize", 20); //페이지당 보여줄 갯수
		}
		if (requestMap.getString("pageSize").equals("")) {
			requestMap.setInt("pageSize", 10); //페이지 블럭 갯수
		}
		
		DataMap listMap = contentsService.selectContentSubjList(requestMap);

		model.addAttribute("LIST_DATA", listMap);
		
		return "/contentsMgr/contents/contentsList";
	}
	
	/**
	 * 강사관리자 - 콘테츠 보기 리스트
	 */
	@RequestMapping(value="/contentsMgr/contents.do", params = "mode=selectLecturerList")
	public String selectLecturerList(@ModelAttribute("cm")CommonMap cm, Model model) throws BizException {
		DataMap requestMap = cm.getDataMap();
		requestMap.setNullToInitialize(true);
		
		if (requestMap.getString("currPage").equals("")) {
			requestMap.setInt("currPage", 1); //페이지
		}
		if (requestMap.getString("rowSize").equals("")) {
			requestMap.setInt("rowSize", 20); //페이지당 보여줄 갯수
		}
		if (requestMap.getString("pageSize").equals("")) {
			requestMap.setInt("pageSize", 10); //페이지 블럭 갯수
		}
		
		DataMap listMap = contentsService.selectLecturerList(requestMap);

		model.addAttribute("LIST_DATA", listMap);
		
		return "/contentsMgr/contents/contentsLecturerList";
	}
	/**
	 * 등록된 회차 리스트.
	 */
	@RequestMapping(value="/contentsMgr/contents.do", params = "mode=seq_list")
	public String seq_list(@ModelAttribute("cm")CommonMap cm, Model model) throws BizException {
		DataMap requestMap = cm.getDataMap();
		requestMap.setNullToInitialize(true);
		
		//등록된 회차 리스트
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("subj", requestMap.getString("subj"));
		paramMap.put("sampleYn", "");
		DataMap listMap = contentsService.selectScormMappingOrgList(paramMap);

		//과목 정보
		DataMap subjMap = contentsService.selectSubjBySimpleRow(requestMap.getString("subj"));
		
		model.addAttribute("LIST_DATA", listMap);
		model.addAttribute("SUBJ_ROW_DATA", subjMap);
		
		return "/contentsMgr/contents/contentsSeqList";
	}
	
	/**
	 * 맛보기 팝업
	 */
	@RequestMapping(value="/contentsMgr/contents.do", params = "mode=sample")
	public String sample(@ModelAttribute("cm")CommonMap cm, Model model) throws BizException {
		DataMap requestMap = cm.getDataMap();
		requestMap.setNullToInitialize(true);
		
		//등록된 회차 리스트
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("subj", requestMap.getString("subj"));
		paramMap.put("sampleYn", "Y");
		DataMap listMap = contentsService.selectScormMappingOrgList(paramMap);

		model.addAttribute("LIST_DATA", listMap);
		
		return "/contentsMgr/contents/contentsSamplePop";
	}
	
	/**
	 * ajax 맛보기 유무 설정
	 */
	@RequestMapping(value="/contentsMgr/contents.do", params = "mode=ajax_exec")
	public String ajax_exec(@ModelAttribute("cm")CommonMap cm, Model model) throws BizException {
		DataMap requestMap = cm.getDataMap();
		requestMap.setNullToInitialize(true);
		
		String qu = requestMap.getString("qu");
		
		if (qu.equals("preview")) { //맛보기 설정
			//맛보기 설정
			contentsService.updateScormMappingOrgByPreviewYn(requestMap);
		}
		
		return "/commonInc/ajax/ajaxBlankPage";
	}
}
