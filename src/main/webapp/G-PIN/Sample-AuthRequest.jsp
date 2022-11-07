<%@page import="gov.mogaha.gpin.sp.proxy.GPinProxy"%>
<%@ page language = "java" contentType = "text/html; charset=UTF-8"%>

 
<%
    /**
     * 사용자 본인인증을 요청하는 페이지입니다.
     * 회원가입, 게시판 글쓰기등 본인인증이 필요한 경우에 이 페이지를 호출하시면 됩니다.
     * 인증이 완료되면 session에 사용자정보가 설정됩니다.
     * 설정된 사용자 정보를 참조하는 방법은 Sample-AuthResponse를 참조하시기 바랍니다.
     */
    
    //2010.01.10 - woni82 
    // i-Pin 인증 후 데이터를 넘겨주는 주소를 지정해주는 페이지
    
    // 인증완료후 session에 저장된 사용자정보를 참조할 페이지, (이용기관 인증수신페이지와 다릅니다.)
    // TODO 이용기관에서 사용하실 페이지를 지정합니다.
    // session.setAttribute("gpinAuthRetPage", "Sample-AuthResponse.jsp");
	String gpinAuthRetPage = request.getParameter("gpinAuthRetPage") == null ? "":request.getParameter("gpinAuthRetPage");

	if("joinstep".equals(gpinAuthRetPage)) {
		session.setAttribute("gpinAuthRetPage", "GMAuthResponse.jsp");
	} else if("lecturer".equals(gpinAuthRetPage)) {
		session.setAttribute("gpinAuthRetPage", "GMAuthResponse3.jsp?gpinAuthRetPage=" + gpinAuthRetPage);
	} else if("ipinFindId".equals(gpinAuthRetPage)) {
		session.setAttribute("gpinAuthRetPage", "GMAuthResponse2.jsp?gpinAuthRetPage=" + gpinAuthRetPage);
	} else if("ipinFindPw".equals(gpinAuthRetPage)) {
		session.setAttribute("gpinAuthRetPage", "GMAuthResponse2.jsp?gpinAuthRetPage=" + gpinAuthRetPage);
	} else {
		return; // 에러 유도
	}
    // 인증 수신시 요청처와 동일한 위치인지를 확인할 요청자IP를 session에 저장합니다.
    session.setAttribute("gpinUserIP", request.getRemoteAddr());

    GPinProxy proxy = GPinProxy.getInstance(this.getServletConfig().getServletContext());

    String requestHTML = "인증요청 메시지생성 실패";
    try
    {
        if (request.getParameter("Attr") != null)
        {
            requestHTML = proxy.makeAuthRequest(Integer.parseInt(request.getParameter("Attr")));
        }
        else
        {
            requestHTML = proxy.makeAuthRequest();
        }
    }
    catch(Exception e)
    {
        // 에러에 대한 처리는 이용기관에 맞게 처리할 수 있습니다.
        e.printStackTrace();
        out.println(e.getMessage());
    }
    // 인증 요청페이지를 생성하여 자동으로 공공I-PIN으로 forwarding 합니다.
    out.println(requestHTML);
%>
