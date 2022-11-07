<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%  
// prgnm : 접속통계 엑셀
// date  : 2008-08-13
// auth  : kang
%>

<!-- [s] commonImport -->
<%@ include file="/commonInc/include/commonImport.jsp" %>
<!-- [e] commonImport -->

<%

	//request 데이터
	DataMap requestMap = (DataMap)request.getAttribute("REQUEST_DATA");
	requestMap.setNullToInitialize(true);
	
	LoginInfo memberInfo = (LoginInfo)request.getAttribute("LOGIN_INFO");
	
	////////////////////////////////////////////////////////////////////////////////////
	
	
	String sDate = Util.getValue(requestMap.getString("sDate"),(String)request.getAttribute("DATE_FROM"));
	String eDate = Util.getValue(requestMap.getString("eDate"),(String)request.getAttribute("DATE_TO"));
	String ptype = Util.getValue( requestMap.getString("ptype"),"day");
	
	
	// 리스트
	StringBuffer sbListHtml = new StringBuffer();
	DataMap listMap = (DataMap)request.getAttribute("LIST_DATA");
	if(listMap == null) listMap = new DataMap();
	listMap.setNullToInitialize(true);
	
	String bgColor = "";
	String txtRegDate = "";
	
	if(listMap.keySize("regDate") > 0){		
		for(int i=0; i < listMap.keySize("regDate"); i++){
			
			// tr 배경색
			if(listMap.getString("pflag", i).equals("A")){
				bgColor = "bgcolor=\"#cccccc\"";
				txtRegDate = listMap.getString("regDate", i) + " 누계";
			}else if(listMap.getString("pflag", i).equals("B")){
				bgColor = "";
				txtRegDate = listMap.getString("regDate", i) + " ";
			}
			
			sbListHtml.append("<tr " + bgColor + " align=\"center\" >");
			sbListHtml.append("	<td>" + txtRegDate + "</td>");
			sbListHtml.append("	<td>" + Util.moneyFormValue(listMap.getString("countNlogin", i)) + "</td>");
			sbListHtml.append("	<td>" + Util.moneyFormValue(listMap.getString("countLogin", i)) + "</td>");
			sbListHtml.append("	<td>" + Util.moneyFormValue(listMap.getString("totalCount", i)) + "</td>");
			sbListHtml.append("</tr>");
			
		}
	}
	
	String toToYear = "접속통계_" + sDate + "_" + eDate;
	// String excel_filename = new String(	toToYear.getBytes(), "ISO-8859-1");
WebUtils.setFileHeader(request, response, toToYear+".xls", "UTF-8", "UTF-8");
	response.setHeader("Content-Description", "JSP Generated Data"); 
	response.setContentType( "application/vnd.ms-excel" );
	request.setCharacterEncoding("UTF-8");
			
%>
<meta http-equiv="Content-Type" content="application/vnd.ms-excel; charset=UTF-8">

<table width="95%" border="1" cellpadding="0" cellspacing="0" >
	<tr bgcolor="F7F7F7" align="center" height="30">
		<td class="tableline11" colspan="4"><b><%= toToYear %></b></td>
	</tr>
	<tr bgcolor="F7F7F7" align="center" height="28">
		<td class="tableline11" >일자</td>
		<td class="tableline11" >로그인전</td>
		<td class="tableline11" >로그인후</td>
		<td class="tableline11" class="br0">총 접속수</td>
	</tr>
	
	<%= sbListHtml.toString() %>
	
</table>