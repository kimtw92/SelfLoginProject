package ut.lib.util;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.StringTokenizer;
import java.util.Enumeration;

/**
 * Class <b> LoginUtil.java </b><br>.
 * 사용자 프론트 로그인 관련 관리 클래스
 * @author  서지현 (coolluck@pentabreed.com)
 * @version	2005. 8. 17.
 */
public class LoginUtil {
    HttpServletRequest request = null;
    HttpServletResponse response = null;

    private String returnURL = "";
    private String strDomain = "";

    // 쿠키 관련 변수
    private String userId = "";
    private String userGrade = "";
    private String userName = "";
    private String userEmail = "";
    private String userGender = "";
    private String userType = "";

    // 로그인 여부
    private boolean blnLogin = false;

	public LoginUtil(HttpServletRequest request)	 {
	    this.request = request;

	    // 쿠키값 변수에 세팅
	    setCookieValue();
	}

    /**
     * 로그인 여부 체크
     *
     * @return 로그인 여부를 return합니다. (true:로그인 한 경우, false:로그인 안한 경우)
     */
	public boolean chkLogin() {
	    if (!userId.trim().equals("")) {
	        blnLogin = true;
	    } else {
	        this.returnURL = returnURLSetting();
	    }

	    return blnLogin;
	}

    /**
     * 로그인후 돌아갈 페이지의 URL
     */
	private String returnURLSetting() {
	    String strReqURI = request.getRequestURI();		// 웹루트부터의 path
	    String strTmpReturnURL = "";
	    StringTokenizer tmpDomain = new StringTokenizer(request.getRequestURL().substring(7),"/");

	    if(tmpDomain.hasMoreTokens()){
	        strDomain = "http://" + tmpDomain.nextToken().toString();
	    }

	    try {
	        strTmpReturnURL = strDomain + strReqURI;

	    	int z = 0;

	    	for (Enumeration enumeration = request.getParameterNames(); enumeration.hasMoreElements(); ) {
	    		String org_str = (String)enumeration.nextElement();
	    		String as[] = request.getParameterValues(org_str);

	    		if(z == 0) {
	    		    strTmpReturnURL = strTmpReturnURL + "?";
	    		} else if(z > 0) {
	    		    strTmpReturnURL = strTmpReturnURL + "&";
	    		}

	    		strTmpReturnURL = strTmpReturnURL + org_str + "=" + as[0];
	    		z++;
	    	}
	    }catch (Exception e) {
	        //
	    }

	    return strTmpReturnURL;
	}

    /**
     * 쿠키값 변수에 세팅
     */
	private void setCookieValue() {
	    try {
	    	this.userId = Util.getCookie(request, "C_MIDXXX");
	    	this.userGrade = Util.getCookie(request, "C_CLEVEL");
	    	this.userName = Util.getCookie(request, "C_MKNAME");
	    	this.userEmail = Util.getCookie(request, "C_MEMAIL");
	    	this.userGender = Util.getCookie(request, "C_ESEXXX");
	    	this.userType = Util.getCookie(request, "C_MUTYPE");
	    } catch (Exception e) {
	    	//
	    }
	}

    /**
     * @return userEmail을 리턴합니다.
     */
    public String getUserEmail() {
        return userEmail;
    }
    /**
     * @return userGender을 리턴합니다.
     */
    public String getUserGender() {
        return userGender;
    }
    /**
     * @return userGrade을 리턴합니다.
     */
    public String getUserGrade() {
        return userGrade;
    }
    /**
     * @return userId을 리턴합니다.
     */
    public String getUserId() {
        return userId;
    }
    /**
     * @return userName을 리턴합니다.
     */
    public String getUserName() {
        return userName;
    }
    /**
     * @return userType을 리턴합니다. (정식회원이면 1, 이벤트 참여만 가능한 회원이면 2)
     */
    public String getUserType() {
        return userType;
    }
    /**
     * @return returnURL을 리턴합니다.
     */
    public String getReturnURL() {
        return returnURL;
    }
    /**
     * @return alert Message를 리턴합니다.
     */
    public String getLoginAlertMsg() {
        return "로그인 하셔야 합니다.";
    }
    /**
     * @return alert Message를 리턴합니다.
     */
    public String getEventAlertLoginMsg() {
        return "사용자 ID [" + this.userId + "]는 가입신청을 처리중입니다. 이벤트 참여는 가능합니다.";
    }
}
