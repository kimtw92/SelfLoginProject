<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%  
// prgnm : 자유게시판
// date : 2008-09-30
// auth : jong03
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
	var seq = "<%=requestMap.getString("seq")%>";
	var boardId = "<%=requestMap.getString("boardId")%>";	
	var qu = "<%=requestMap.getString("qu")%>";
	var boardName = "<%=requestMap.getString("boardName")%>"; 
    //이동할 주소값 저장
    var url = "";
    //메시지 
	alert("<%=requestMap.getString("msg")%>");
	//메뉴아이디 
	var menuId = "<%=requestMap.getString("menuId")%>";
	var sessClass = "<%=requestMap.getString("sessClass")%>";
	
	if(mode=="freeBoardExec"){
		if(qu == "deleteBbsBoard"){
		//게시판 삭제 후 이동
			url = "/homepage/support.do?mode=freeBoardList&boardId="+boardId+"&qu="+qu;
			location.href = url;
		}else{
			//게시판 등록,수정 후 이동
			url = "/homepage/support.do?mode=freeBoardView&seq="+seq+"&boardId="+boardId+"&qu=selectBbsBoardview";
			location.href = url;
		}
	}
  //-->
  </SCRIPT>
