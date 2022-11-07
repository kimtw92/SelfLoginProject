package ut.lib.login;

import java.io.IOException;
import java.net.URLEncoder;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import loti.common.service.CommonService;
import loti.mypage.service.PaperService;

import org.springframework.stereotype.Component;

import ut.lib.support.DataMap;
import ut.lib.util.Constants;
import ut.lib.util.SpringUtils;
import ut.lib.util.Util;


/**
 * 로그인 확인 하는 페이지
 * 사용자 및 관리자 어느 곳에서든 호출시 사용할수 있다.
 * 
 * @author 이용문
 *
 */
@Component
public class LoginCheck {

	/**
	 * 로그인 확인 (Get 방식의 요청이 들어왓을경우..요청경로와 쿼리스트링을 읽어서 되돌아올 url 을 설정)
	 * @param request
	 * @param response
	 * @return
	 * @throws IOException
	 */
	public static LoginInfo Check(HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		LoginInfo loginInfo = (LoginInfo)request.getAttribute("LOGIN_INFO");
		
		//System.out.println("LoginInfo Check(HttpServletRequest request, HttpServletResponse response)");
		
		String rtn = Util.getNowUrl(request);
		
		if (loginInfo.isLogin()) {
			request.setAttribute("RELOAD_URL", rtn);
			return loginInfo;
		} else {
			
			response.sendRedirect(Constants.LOGIN_FAIL_URL + "&rtn=" + rtn);
			//response.sendRedirect(Constants.LOGIN_FAIL_URL);
			return null;
		}
	}

	/**
	 * 로그인 확인(로그인후 이동할 특정경로를 포함)
	 * @param url
	 * @param request
	 * @param response
	 * @return
	 * @throws IOException
	 */
	public static LoginInfo Check(String url, HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		LoginInfo loginInfo = (LoginInfo)request.getAttribute("LOGIN_INFO");
		
		//System.out.println("Check(String url, HttpServletRequest request, HttpServletResponse response)");
		
		String retrunURL = URLEncoder.encode(url, "UTF-8");
		
		if (loginInfo.isLogin()) {			
			request.setAttribute("RELOAD_URL", retrunURL);
			return loginInfo;
		} else {			
			response.sendRedirect(Constants.LOGIN_FAIL_URL + "&rtn=" + retrunURL);
			//response.sendRedirect(Constants.LOGIN_FAIL_URL);
			return null;
		}
	}

	/**
	 * 관리자 로그인 확인 (요청경로와 파라미터를 확인하여 되돌아올 url 을 설정)
	 * @param request
	 * @param response
	 * @return
	 * @throws IOException
	 */
	public static LoginInfo adminCheck(HttpServletRequest request, HttpServletResponse response) throws Exception {

		System.out.println("테스트33 - 1111");
		LoginInfo loginInfo = adminCheck(request, response, "");
		
		String retrunURL = Util.getNowUrl(request);
		
		if (loginInfo != null){
			
			request.setAttribute("RELOAD_URL", retrunURL);
			return loginInfo;
		}else{
			return null;
		}
	}
	public static LoginInfo adminCheck(HttpServletRequest request, HttpServletResponse response, String menuId) throws Exception {

		System.out.println("테스트33 - 2222");
		
		
			LoginInfo loginInfo = (LoginInfo)request.getAttribute("LOGIN_INFO");
		System.out.println("loginInfo : " + loginInfo.toString());
		String retrunURL = Util.getNowUrl(request);

		System.out.println("loginInfo.isLogin() : " + loginInfo.isLogin());
		System.out.println("loginInfo.getSessAdminYN() : " + loginInfo.getSessAdminYN());
		System.out.println("loginInfo: " + loginInfo.getSessNo() + "//");
			loginInfo.setSessAdminYN("Y");
		System.out.println("loginInfo.getSessAdminYN() : " + loginInfo.getSessAdminYN());
		
		//로그인이 상태 확인. (관리자 체크 확인 조건 추가)
		if (loginInfo.isLogin() && loginInfo.getSessAdminYN() != null && loginInfo.getSessAdminYN().equals("Y")) { 
			
			//사용할 service
			CommonService commonService = SpringUtils.getBean(CommonService.class);
			PaperService paperService = SpringUtils.getBean(PaperService.class);
			
			DataMap leftMenuData = null;		// 왼쪽 메뉴
			DataMap navagationData = null; 		// 네이게이션 정보
			DataMap currentMenuNameData = null;	// 현재 선택한 메뉴명
			DataMap paperCountData = null;		// 현재 쪽지 갯수
			
			//관리자 상단메뉴 정보.
			DataMap topMenuData = commonService.selectTopMenu( loginInfo.getSessCurrentAuth() );
			
			//관리자왼쪽 메뉴 정보.
			String[] menuCode = {"1","0","0"}; //default
			
			if(menuId != null && !menuId.equals("")){
				try{
					String[] tmpMenuCode = null;
					tmpMenuCode = menuId.split("-");
					
					for(int i=0;i<tmpMenuCode.length;i++){
						menuCode[i] = Util.getValue(tmpMenuCode[i], "0");
					}
					
				}catch(Exception e){ 
					menuCode[0] = "1"; 
					System.out.print("\n # menuCode Exception \n");
				}
				
				leftMenuData = commonService.selectTotalLeftMenu(loginInfo.getSessCurrentAuth(), Integer.parseInt(menuCode[0]));
				navagationData = commonService.selectNavigationMenu(loginInfo.getSessCurrentAuth(), Integer.parseInt(menuCode[0]), Integer.parseInt(menuCode[1]), Integer.parseInt(menuCode[2]));
				currentMenuNameData = commonService.selectCurrentMenuName(loginInfo.getSessCurrentAuth(), Integer.parseInt(menuCode[0]), Integer.parseInt(menuCode[1]), Integer.parseInt(menuCode[2]));
								
				
			
			}else{
				topMenuData.setNullToInitialize(true);
				leftMenuData = commonService.selectTotalLeftMenu(loginInfo.getSessCurrentAuth(), topMenuData.getInt("menuDepth1", 0));
				navagationData = commonService.selectNavigationMenu(loginInfo.getSessCurrentAuth(), 0,0,0);								
			}
			
			
			request.setAttribute("TOPMENU_DATA", topMenuData); 			//상단메뉴
			request.setAttribute("LEFTMENU_DATA", leftMenuData);		//왼쪽메뉴
			request.setAttribute("NAVIGATION_DATA", navagationData); 	//네비게이션
			
			if(currentMenuNameData != null){
				request.setAttribute("CURRENT_TITLE_NAME_ROW", currentMenuNameData );	// 현재 화면 상단 명칭
			}
			
			
			// 새쪽지
			paperCountData = paperService.paperNewCount(loginInfo.getSessNo());
			request.setAttribute("NEW_PAPER", paperCountData);
			
			
			request.setAttribute("RELOAD_URL", retrunURL);
			
			return loginInfo;
			
		} else {
			
			System.out.println("====== 세션아웃 =======");
						
			response.sendRedirect(Constants.LOGIN_FAIL_URL + "&rtn=" + retrunURL);
						
			return null;
			
		}
	}
	
	/**
	 * 팝업 페이지의 관리자 체크 메소드
	 * 기존 adminCheck() 메소드의 경우는 상단 및 왼쪽 메뉴등의 DB정보를 가져 오는 부분이 있어서 제거한 메소드.
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	public static LoginInfo adminCheckPopup(HttpServletRequest request, HttpServletResponse response) throws Exception {
		System.out.println("테스트44");
		LoginInfo loginInfo = (LoginInfo)request.getAttribute("LOGIN_INFO");
		
		String retrunURL = Util.getNowUrl(request);
		
		//로그인이 상태 확인. (관리자 체크 확인 조건 추가)
		if (loginInfo.isLogin() && loginInfo.getSessAdminYN() != null && loginInfo.getSessAdminYN().equals("Y")) { 
						
			request.setAttribute("RELOAD_URL", retrunURL);
			
			return loginInfo;
			
		} else {
						
			response.sendRedirect(Constants.LOGIN_FAIL_URL + "&rtn=" + retrunURL);
			return null;
			
		}
	}
	
	/**
	 * 상단 Navigation
	 * @param loginInfo
	 * @param navagationData
	 * @return
	 */
	public static String NavigationCreate(LoginInfo loginInfo, DataMap navagationData){
		
		StringBuffer sbNav = new StringBuffer();
		
		sbNav.append("<table cellspacing=\"0\" cellpadding=\"0\" border=\"0\" width=\"100%\">");
		sbNav.append("	<tr>");
		sbNav.append("		<td rowspan=\"3\" width=\"6\" style=\"background:#FFFFFF URL(/images/bg_navi.gif) repeat-y\" nowrap></td>");
		sbNav.append("		<td height=\"1\" bgcolor=\"#E3E3E3\"></td>");
		sbNav.append("	</tr>");
		sbNav.append("	<tr>");
		sbNav.append("		<td bgcolor=\"#F5F5F5\" height=\"33\" align=\"right\" class=\"font1\" style=\"padding-right:10px\">");
				
		if (!navagationData.getString("navigation").equals("")){
			sbNav.append("<a href=\""+loginInfo.getSessCurrentAuthHome()+"\">HOME</a>" + navagationData.getString("navigation"));
	    }else{
	    	sbNav.append("HOME");
	    }
		
		sbNav.append("		</td>");
		sbNav.append("	</tr>");
		sbNav.append("	<tr><td height=\"1\" bgcolor=\"#E3E3E3\"></td></tr>");
		sbNav.append("</table>");
		
		return sbNav.toString();
	}

}
