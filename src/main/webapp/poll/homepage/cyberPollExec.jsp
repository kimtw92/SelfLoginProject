  <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%  
// prgnm : Cyber poll 메시지 관리
// date : 2008-06-04
// auth : 정 윤철
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
	var qu = "<%=requestMap.getString("qu")%>";
    var msg = "<%=requestMap.getString("msg")%>";
    //메뉴아이디 
	var menuId = "<%=requestMap.getString("menuId")%>";

    
    var url = "";

    if(mode == "exec"){//타이틀글 관련 메시지 처리
		if(qu == "insert" && msg == "back"){
			alert("중복된 값입니다.\n확인 후 다시 입력 하십시오.");
			
		}else if(qu == "modify" && msg == "back"){
			alert("중복된 값입니다.\n확인 후 다시 입력 하십시오.");
			
		}else{
			//메시지 
			alert("<%=requestMap.getString("msg")%>");
			
		}
		
		//타이틀글 등록, 수정, 삭제 후 이
		url = "/poll/homepage.do?menuId="+menuId;
		location.href = url;
	}else if(mode = "subExec"){
		//메시지 
		alert("<%=requestMap.getString("msg")%>");
		
		//전체글 삭제후 이동
		if(qu == "allDelete"){
			url = "/poll/homepage.do?menuId="+menuId;
			location.href = url;
		}else if(qu == "deleteSamp"){
			//질문글, 항목 등록 수정 후 이동
			url = "/poll/homepage.do?mode=subForm&menuId="+menuId+"&titleNo=<%=requestMap.getString("titleNo")%>";
			location.href = url;
		}else if(qu == "resultInsert"){
			//답변글 등록 후 이동
			url = "/poll/homepage.do?menuId="+menuId;
			opener.location.href = url;
			window.close();

		}else{
			//질문글, 항목 등록 수정 후 이동
			url = "/poll/homepage.do?mode=subForm&menuId="+menuId+"&titleNo=<%=requestMap.getString("titleNo")%>&questionNo=<%=requestMap.getString("questionNo")%>";
			location.href = url;
		}
		
			
	}
	
	
	

	
  //-->
  </SCRIPT>
