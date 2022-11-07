<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%  
// prgnm : 과목코드별 문항등록 메시지 처리
%>
<!-- [s] commonImport -->
<%@ include file="/commonInc/include/commonImport.jsp" %>
<!-- [e] commonImport -->
<%
    //request 데이터
	DataMap requestMap = (DataMap)request.getAttribute("REQUEST_DATA");
	requestMap.setNullToInitialize(true);
	
	//String msg = (String)request.getAttribute("msg");
	String msg = requestMap.getString("msg");
	System.out.println("msg="+msg);
%>
<SCRIPT LANGUAGE="JavaScript">
<!--
    //모드값 저장
    var mode = "questionList";
    var menuId = "<%=requestMap.getString("menuId")%>";
    var subj = "<%=requestMap.getString("subj")%>";
    var subjnm = "<%=requestMap.getString("subjnm")%>";
    var s_subjIndexSeq = "<%= requestMap.getString("s_subjIndexSeq") %>";
    var s_subjUseYn = "<%= requestMap.getString("s_subjUseYn") %>";
    var s_subType = "<%= requestMap.getString("s_subType") %>";
    var s_subjSearchTxt = "<%= requestMap.getString("s_subjSearchTxt") %>";
    var subjCurrPage = "<%= requestMap.getString("subjCurrPage") %>";
    var s_difficulty = "<%= requestMap.getString("s_difficulty") %>";
    var s_useYn = "<%= requestMap.getString("s_useYn") %>";
    var s_qType = "<%= requestMap.getString("s_qType") %>";
    var currPage = "<%= requestMap.getString("currPage") %>";

    var url = "";
    var param = "";
    
	alert("<%=msg%>");

	param = param + "?mode=" + mode;
	param = param + "&menuId=" + menuId;
	param = param + "&subj=" + subj;
	param = param + "&subjnm=" + subjnm;
	param = param + "&s_subjIndexSeq=" + s_subjIndexSeq;
	param = param + "&s_subjUseYn=" + s_subjUseYn;
	param = param + "&s_subType=" + s_subType;
	param = param + "&s_subjSearchTxt=" + s_subjSearchTxt;
	param = param + "&subjCurrPage=" + subjCurrPage;
	param = param + "&s_difficulty=" + s_difficulty;
	param = param + "&s_useYn=" + s_useYn;
	param = param + "&s_qType=" + s_qType;
	param = param + "&currPage=" + currPage;
	
	url = "/baseCodeMgr/questionMgr.do" + param;
	
	window.opener.location.href = url;
	self.close();
//-->
</SCRIPT>
