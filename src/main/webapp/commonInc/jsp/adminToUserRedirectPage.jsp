<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%  
// prgnm : 관리자 화면에서 사용자 화면으로 이동
// date  : 2008-09-10
// auth  : kang
%>

<%@ include file="/commonInc/include/commonImport.jsp" %>
<%

	//request 데이터
	DataMap requestMap = (DataMap)request.getAttribute("REQUEST_DATA");
	requestMap.setNullToInitialize(true);
	
	String mode = requestMap.getString("mode");
	
	if(mode.equals("userInfoChange")){
		// 개인정보 수정
		response.sendRedirect("/mypage/myclass.do?mode=personalinfomodify");
		
	}else if(mode.equals("userPaper")){
		// 쪽지함
		response.sendRedirect("/mypage/paper.do?mode=recieve");
		
	}else if(mode.equals("eduinfo7-7")){
		// 오시는 길
		response.sendRedirect("/homepage/introduce.do?mode=eduinfo7-7");
		
	}else if(mode.equals("policy")){
		// 개인정보보호정책
		response.sendRedirect("/homepage/index.do?mode=policy");
	
	}else if(mode.equals("spam")){
		// 이메일 무단수집거부
		response.sendRedirect("/homepage/index.do?mode=spam");
	
	}else if(mode.equals("worktel")){
		// 이용약관
		response.sendRedirect("/homepage/index.do?mode=worktel");
	}
	

%>

