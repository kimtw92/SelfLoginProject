package ut.lib.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import ut.lib.login.LoginInfo;
import ut.lib.util.*;


/**
 * .do 페이지 호출시 모든 페이지에서 로그인 정보를 확인해 주기 위해서 사용한다.
 * 
 * 
 * @author 이용문
 *
 */
public class LoginFilter implements Filter {

	/**
	 *
	 * @uml.property name="filterConfig"
	 * @uml.associationEnd
	 * @uml.property name="filterConfig" multiplicity="(0 1)"
	 */
	private FilterConfig filterConfig;

	/**
	 *
	 * @uml.property name="context"
	 * @uml.associationEnd
	 * @uml.property name="context" multiplicity="(0 1)"
	 */
	private ServletContext context;


	public void init(FilterConfig filterConfig) throws ServletException {
		this.filterConfig = filterConfig;
		context = filterConfig.getServletContext();
		context.log("Client Login Filter " + filterConfig.getFilterName() + " Initialized");

	}

	public void doFilter(ServletRequest request, ServletResponse response, FilterChain filterChain) throws IOException, ServletException {
		
		HttpServletRequest req 	= (HttpServletRequest)request;
		//HttpServletResponse res = (HttpServletResponse)response;		
		
		HttpSession session = req.getSession();
		
		LoginInfo loginInfo = new LoginInfo();
		
		if (session.getAttribute("sess_loginYn") == null || !((String)session.getAttribute("sess_loginYn")).equals("Y")){
			
			loginInfo.setBoolLogin(false);
			
		} else { //로그인 되어있을경우.
			
			loginInfo.setBoolLogin(true);
			
			loginInfo.setSessLoginYn( Util.getValue( (String)session.getAttribute("sess_loginYn") ) ); 					//로그인 유무
			loginInfo.setSessNo(Util.getValue( (String)session.getAttribute("sess_no") ) ); 								//유저번호
			loginInfo.setSessName(Util.getValue( (String)session.getAttribute("sess_name") ) );  							//유저명
			loginInfo.setSessUserId(Util.getValue( (String)session.getAttribute("sess_userid") ) ); 						//유저아이디
			loginInfo.setSessUserHp(Util.getValue( (String)session.getAttribute("sess_userhp") ) ); 						//유저폰
			loginInfo.setSessResNo(Util.getValue( (String)session.getAttribute("sess_resno") ) ); 						//유저비번
			//System.out.println("\n ## Class = " + (String)session.getAttribute("sess_class"));
			loginInfo.setSessClass(Util.getValue( (String)session.getAttribute("sess_class") ) ); 						//유저 권한
			loginInfo.setSessDept(Util.getValue( (String)session.getAttribute("sess_dept") ) ); 							//유저기관
			loginInfo.setSessPartcd(Util.getValue( (String)session.getAttribute("sess_partcd") ) ); 						//유저 부서
			
			loginInfo.setSessAuth( (String[][])session.getAttribute("sess_auth") ); 						//유저 권한
			loginInfo.setSessCurrentAuth(Util.getValue( (String)session.getAttribute("sess_currentauth") ) ); 			//현재 권한
			loginInfo.setSessAdminYN(Util.getValue( (String)session.getAttribute("sess_adminyn") ) ); 					//관리자 여부.
			loginInfo.setSessCurrentAuthHome(Util.getValue( (String)session.getAttribute("sess_currentauthhome") ) ); 	//현재 권한의 home url
			
			loginInfo.setSessGubun(Util.getValue( (String)session.getAttribute("sess_gubun") ) );							//Left의 진행과정=1, 전체과정=2
			loginInfo.setSessYear(Util.getValue( (String)session.getAttribute("sess_year") ) );							//Left의 년도
			loginInfo.setSessGrcode(Util.getValue( (String)session.getAttribute("sess_grcode") ) );						//Left의 과정
			loginInfo.setSessGrseq(Util.getValue( (String)session.getAttribute("sess_grseq") ) );							//Left의 기수
			loginInfo.setSessSubj(Util.getValue( (String)session.getAttribute("sess_subj") ) );							//Left의 과목
			loginInfo.setSessUserEmail(Util.getValue( (String)session.getAttribute("sess_email") ) );	
			loginInfo.setSessUserJik(Util.getValue( (String)session.getAttribute("sess_jik") ) );
			loginInfo.setSessUserDept(Util.getValue( (String)session.getAttribute("sess_userdept") ) );
		}

		req.setAttribute("LOGIN_INFO", loginInfo);
		
		filterChain.doFilter(request, response);
				
		//System.out.println("===== doFilter() end =======");
		return;
	}

	/**
	 *
	 * @uml.property name="filterConfig"
	 */
	public FilterConfig getFilterConfig() {
		return filterConfig;
	}

	/**
	 *
	 * @uml.property name="filterConfig"
	 */
	public void setFilterConfig(FilterConfig filterConfig) {
		this.filterConfig = filterConfig;
	}

	public void destroy() {
		filterConfig = null;
	}
}