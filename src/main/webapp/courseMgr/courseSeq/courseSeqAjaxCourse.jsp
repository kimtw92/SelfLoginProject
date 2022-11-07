<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
// prgnm : SELECTBOX의 과정 리스트
// date : 2008-06-11
// auth : Lym
%>

<%@ include file="/commonInc/include/commonImport.jsp" %>

<%

	//필수 코딩 내용 //////////////////////////////////////////////////////////////////////

	//request 데이터
	DataMap requestMap = (DataMap)request.getAttribute("REQUEST_DATA");
	requestMap.setNullToInitialize(true);
		
	////////////////////////////////////////////////////////////////////////////////////

	//과정 목록.	
	DataMap listMap = (DataMap)request.getAttribute("LIST_DATA");
	listMap.setNullToInitialize(true);

	String selectBoxStr = "";

	for(int i=0; i < listMap.keySize("grcode"); i++){
		
		String selected = ( listMap.getString("grcode", i).equals(requestMap.getString("grcode")) ) ? "selected" : "";
		
		selectBoxStr += "<option value='" + listMap.getString("grcode",i) + "' " + selected + ">" + listMap.getString("grcodenm",i) + "</option>";
	}


%>

<select name="grcode" onChange="setCommSession('grCode', this.value);go_reload();" style="width:250px;font-size:12px">
	<option value="">**선택하세요**</option>
	<%= selectBoxStr %>
</select>