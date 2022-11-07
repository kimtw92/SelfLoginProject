<%@ page language = "java" contentType = "text/html; charset=EUC-KR"%>

<%@ page import="gov.mogaha.gpin.sp.util.SAMLConstants" %>

<%!
    String getSession(HttpSession session, String attrName)
    {
        return session.getAttribute(attrName) != null ? (String)session.getAttribute(attrName) : "";
    }
%>

중복확인코드(dupInfo)
<%= getSession(session, "dupInfo") %>
                                          
                                          
개인식별번호(virtualNo)              
<%= getSession(session, "virtualNo") %>
                                          
                                          
이름(realName)       
<%= getSession(session, "realName") %>
                                          
                                          
성별(sex)            
<%= getSession(session, "sex") %>  
                                          
                                          
나이코드(age)            
<%= getSession(session, "age") %>    
                                          
                                          
생년월일(birthDate)  
<%= getSession(session, "birthDate") %>
                                          
                                          
국적(nationalInfo)   
<%= getSession(session, "nationalInfo") %>
                                          
                                          
본인인증방법(authInfo)               
<%= getSession(session, "authInfo") %>
	
	