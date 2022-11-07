<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%  
// prgnm : 숙제
// date : 2008-09-30
// auth :jong03
%>
<!-- [s] commonImport -->
<%@ include file="/commonInc/include/commonImport.jsp" %>
<!-- [e] commonImport -->
<%
    //request 데이터
	DataMap requestMap = (DataMap)request.getAttribute("REQUEST_DATA");
	requestMap.setNullToInitialize(true);
%>
  <SCRIPT LANGUAGE="JavaScript">
  <!--
    //모드값 저장
    
    var mode = "<%=requestMap.getString("mode")%>";
	var subj = "<%=requestMap.getString("subj")%>";
	
	
	
    //이동할 주소값 저장
    var url = "";
    //메시지 
    <%
    	String msg = requestMap.getString("msg");
    	if(msg == null || msg == "") {
    		msg = "제출 완료";
    	}
    %>
	alert("<%=msg%>");
	//메뉴아이디 
	var sessClass = "<%=requestMap.getString("sessClass")%>";
	
	//게시판 등록,수정 후 이동
	url = "/mypage/myclass.do?mode=selectReportList&subj="+subj;
	location.href = url;

  //-->
  </SCRIPT>
