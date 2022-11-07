package loti.index.web;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import loti.baseCodeMgr.service.MenuService;
import loti.courseMgr.service.QuestionService;
import loti.homepageMgr.service.BoardService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import ut.lib.login.LoginCheck;
import ut.lib.login.LoginInfo;
import ut.lib.support.CommonMap;
import ut.lib.support.DataMap;
import common.controller.BaseController;


@Controller
public class SysAdminController extends BaseController {

	@Autowired
	private MenuService menuService;
	
	@Autowired
	private BoardService boardService;
	
	@Autowired
	private QuestionService questionService;
	
	@ModelAttribute("cm")
	public CommonMap common(
			CommonMap cm
			, HttpServletRequest request
			, HttpServletResponse response
		) throws Exception{
		
		// 리퀘스트 받기
		DataMap requestMap = cm.getDataMap();
		requestMap.setNullToInitialize(true);
		
		//관리자 로그인 체크
		LoginInfo memberInfo = LoginCheck.adminCheck(request, response, requestMap.getString("menuId"));
		if (memberInfo == null){		
			response.sendRedirect("/");
			return null;
		}
		
		//리퀘스트 정보를 담고있는 DataMap을 Attribute 에 추가
		request.setAttribute("REQUEST_DATA", requestMap);
		
		return cm;
	}
	
	
	
	@RequestMapping(value="/index/sysAdminIndex.do")
	public String index(
			@ModelAttribute("cm") CommonMap cm
			, HttpServletRequest request
			, HttpServletResponse response
			) throws Exception{
		return sysAdmin(cm, request, response);
	}
	
	@RequestMapping(value="/index/sysAdminIndex.do", params="mode=sysAdmin")
	public String sysAdmin(
				@ModelAttribute("cm") CommonMap cm
				, HttpServletRequest request
				, HttpServletResponse response
			) throws Exception{
		
		list(request, response, cm.getDataMap());
		
		return "/index/sysAdminIndex";
	}
	
	@RequestMapping(value="/index/sysAdminIndex.do", params="mode=courseAdmin")
	public String courseAdmin(
			@ModelAttribute("cm") CommonMap cm
			, HttpServletRequest request
			, HttpServletResponse response
			) throws Exception{
		
		list(request, response, cm.getDataMap());
		
		return "/index/sysAdminIndex";
	}
	
	/**
	 * 인덱스 리스트
	 * 작성일 : 8월 7일
	 * 작성자 : 정 윤철
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	public void list(
	          HttpServletRequest request,
	          HttpServletResponse response,
	          DataMap requestMap) throws Exception {
	
		//사용자 정보 추출.
		LoginInfo loginInfo = (LoginInfo)request.getAttribute("LOGIN_INFO");
		
	
		
		//현재 권한 체크
		String cboAuth = "";
		
		if(!requestMap.getString("cboAuth").equals("")){
			//권한값이 있을경우 사용
			cboAuth = requestMap.getString("cboAuth");
		
		}else{
			//없을경우 사용자의 권한을 사용
			cboAuth = loginInfo.getSessClass();
		
		}
		
		// 관리자페이지의 우측 상단 레이어부분 추가 시작
		request.setAttribute("LAYER_LIST", menuService.getLayerList());
		// 관리자페이지의 우측 상단 레이어부분 추가 끝
		
		//과정질문방 질문 리스트
		DataMap questionMap = questionService.selectQuestionPopup();
		//게시판 Q&A 질문 리스트
		DataMap bbsMap = boardService.selectBbsPopup();
		
		requestMap.setString("cboAuth", cboAuth);
		
		DataMap listMap = menuService.selectMenuList(cboAuth);
		
		request.setAttribute("LIST_DATA", listMap);
		request.setAttribute("QUESTION_DATA", questionMap);
		request.setAttribute("BBS_DATA", bbsMap);
	}
}
