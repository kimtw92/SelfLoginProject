<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%  
// prgnm : 사용자 권한 변경시 세션저장
// date : 2008-05-05
// auth : kang
%>

<%	
	System.out.println("sess_currentauth=" + (String)session.getAttribute("sess_currentauth")  );
%>
