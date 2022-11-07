<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
// prgnm : 상단의 과정의 과목별 반구성 Select Box 생성
// date : 2008-09-08
// auth : Lym
%>

<%@ include file="/commonInc/include/commonImport.jsp" %>

<%

	//필수 코딩 내용 //////////////////////////////////////////////////////////////////////

	//request 데이터
	DataMap requestMap = (DataMap)request.getAttribute("REQUEST_DATA");
	requestMap.setNullToInitialize(true);
		
	//로그인된 사용자 정보
	LoginInfo memberInfo = (LoginInfo)request.getAttribute("LOGIN_INFO");
	////////////////////////////////////////////////////////////////////////////////////

	
	DataMap listMap = (DataMap)request.getAttribute("LIST_DATA");
	if(listMap == null) listMap = new DataMap();
	listMap.setNullToInitialize(true);
	
	String commClass		= requestMap.getString("commClass");		// Onload시 사용되는 선택된 평가명
	
	String objStr = "";
	String tmpStr = "";
	for(int i=0; i < listMap.keySize("classno"); i++){
		
		tmpStr = "";

		if(listMap.getString("classno", i).equals(commClass)) 
			tmpStr = "selected";
		
		objStr = "<option value='" + listMap.getString("classno", i) + "' " + tmpStr + ">" + listMap.getString("classnm", i) + "</option>";

	}

%>

<select name="commClass" class="mr10">
	<option value=''>**선택하세요**</option>
	<%= objStr %>
</select>
