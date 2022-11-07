<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
// prgnm : 컨텐츠의 상단의 평가명 리스트 생성
// date : 2008-08-22
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
	
	String exam		= requestMap.getString("commExam");		// Onload시 사용되는 선택된 평가명
	
	String objStr = "";
	String tmpStr = "";
	for(int i=0; i < listMap.keySize("idExam"); i++){
		
		tmpStr = "";

		if(listMap.getString("idExam", i).equals(exam)) 
			tmpStr = "selected";
		
		objStr = "<option value='" + listMap.getString("idExam", i) + "' " + tmpStr + ">" + listMap.getString("title", i) + "</option>";

	}

%>

<select name="commExam" style="width:250px;font-size:12px">
	<option value=''>**선택하세요**</option>
	<%= objStr %>
</select>
