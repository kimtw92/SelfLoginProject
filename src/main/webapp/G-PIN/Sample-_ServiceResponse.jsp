<%@ page language = "java" contentType = "text/html; charset=EUC-KR"%>

<%@ page import="gov.mogaha.gpin.sp.util.SAMLConstants" %>

<%!
    String getSession(HttpSession session, String attrName)
    {
        return session.getAttribute(attrName) != null ? (String)session.getAttribute(attrName) : "";
    }
%>

�ߺ�Ȯ���ڵ�(dupInfo)
<%= getSession(session, "dupInfo") %>
                                          
                                          
���νĺ���ȣ(virtualNo)              
<%= getSession(session, "virtualNo") %>
                                          
                                          
�̸�(realName)       
<%= getSession(session, "realName") %>
                                          
                                          
����(sex)            
<%= getSession(session, "sex") %>  
                                          
                                          
�����ڵ�(age)            
<%= getSession(session, "age") %>    
                                          
                                          
�������(birthDate)  
<%= getSession(session, "birthDate") %>
                                          
                                          
����(nationalInfo)   
<%= getSession(session, "nationalInfo") %>
                                          
                                          
�����������(authInfo)               
<%= getSession(session, "authInfo") %>
	
	