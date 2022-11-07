package loti.common.web;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import loti.common.service.StuEnterService;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import ut.lib.login.LoginCheck;
import ut.lib.login.LoginInfo;
import ut.lib.support.CommonMap;
import ut.lib.support.DataMap;
import common.controller.BaseController;

@Controller
public class SearchMemberController extends BaseController {

	@Autowired
	private StuEnterService stuEnterService;
	
	@ModelAttribute("cm")
	public CommonMap common(
				CommonMap cm
				, HttpServletRequest request
				, HttpServletResponse response
			) throws Exception{
		
		//요청처리 - get, post 방식의 파라미터를 DataMap 에 저장
		DataMap requestMap = cm.getDataMap();
		//초기화 옵션(true 일경우 데이터를 뽑을때 null 일경우 초기화 - 빈문자열, 0....)
		requestMap.setNullToInitialize(true);
		
		
		//관리자 로그인 체크. (관리자 페이지에는 모두 있어야 함)
		LoginInfo memberInfo = LoginCheck.adminCheckPopup(request, response);
		if (memberInfo == null) return null;
		
		//default mode
		if(requestMap.getString("mode").equals(""))
			requestMap.setString("mode", "list");
	
		//리퀘스트 정보를 담고있는 DataMap을 Attribute 에 추가
		request.setAttribute("REQUEST_DATA", requestMap);
		
		return cm;
	}
	
	public String findView(String mode, String defaultView){
		return defaultView;
	}
	
	/**
	 * 회원 검색.
	 * @throws Exception 
	 */
	@RequestMapping(value="/commonInc/searchMember.do", params="mode=list")
	public String list(
				@ModelAttribute("cm") CommonMap cm
				, Model model
				, HttpSession session
			) throws Exception{
		
		DataMap requestMap = cm.getDataMap();
		
		//사용자 정보 추출.
		LoginInfo loginInfo = cm.getLoginInfo();
		
		//리스트
		DataMap listMap = null;
		
		//2011.01.11 - woni82
		//관리자에서 회원을 검색할때 사용하는 프로세스
		if( !requestMap.getString("searchValue").equals("") ){ //검색단어가 있을경우만 검색.
			
			//2011.01.09 - woni82
			//주민등록번호가 등록이 안되기 때문에 주석처리하고 userid로 검색하도록 한다.
			if(requestMap.getString("qu").equals("resno")){
				
				//주민등록으로 검색
				listMap = stuEnterService.selectMemberSimpleByResnoRow(requestMap.getString("searchValue"), loginInfo.getSessClass(), loginInfo.getSessDept());
			
			}
			String sess_ldapcode = (String)session.getAttribute("sess_ldapcode");
			if(requestMap.getString("qu").equals("userid")){	
				//userid 검색
				listMap = stuEnterService.selectMemberSimpleByUseridRow(requestMap.getString("searchValue"), loginInfo.getSessClass(), loginInfo.getSessDept(), sess_ldapcode);
			}
			else if(requestMap.getString("qu").equals("name")){	
				//이름으로 검색.
				listMap = stuEnterService.selectMemberSimpleByNameRow(requestMap.getString("searchValue"), loginInfo.getSessClass(), loginInfo.getSessDept(), sess_ldapcode);
				
			}else{
				listMap = new DataMap();
			}
			
		}else{
			
			listMap = new DataMap();
			
		}

		
		model.addAttribute("LIST_DATA", listMap);
		
		return findView(requestMap.getString("mode"), "/commonInc/popup/searchMemberPop");
	}
}
