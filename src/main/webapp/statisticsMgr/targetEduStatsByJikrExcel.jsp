<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%  
// prgnm : 대상별 교육훈련실적 - 직렬별 엑셀
// date  : 2008-07-24
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

	// 직렬별 테이블 만들기
	StringBuffer sbColHtml = new StringBuffer();
	DataMap colMap = (DataMap)request.getAttribute("COL_DATA");
	if(colMap == null) colMap = new DataMap();
	colMap.setNullToInitialize(true);
	
	if(colMap.keySize("codenm") > 0){		
		for(int i=0; i < colMap.keySize("codenm"); i++){			
			sbColHtml.append("<td class=\"tableline11\" >" + colMap.getString("codenm",i) + "</td>" );						
		}
	}
	
	int colCount = colMap.keySize("codenm");
	String colName = "";
	String bgColor = "";
	
	// 리스트
	StringBuffer sbListHtml = new StringBuffer();
	DataMap listMap = (DataMap)request.getAttribute("LIST_DATA");
	if(listMap == null) listMap = new DataMap();
	listMap.setNullToInitialize(true);
	
	if(listMap.keySize("grcodenm") > 0){		
		for(int i=0; i < listMap.keySize("grcodenm"); i++){
			
			// tr 배경색
			if(listMap.getString("pflag", i).equals("A")){
				bgColor = "bgcolor=\"#cccccc\"";				
			}else if(listMap.getString("pflag", i).equals("B")){
				bgColor = "bgcolor=\"ffcc00\"";
			}else{
				bgColor = "";
			}
			
			sbListHtml.append("<tr " + bgColor + " >");
			
			sbListHtml.append("	<td>" + listMap.getString("gubunnm", i) + "</td>");
			sbListHtml.append("	<td>" + listMap.getString("grcodenm", i) + "</td>");			
			sbListHtml.append("	<td>" + Util.moneyFormValue(listMap.getString("totalSum", i)) + "</td>");
			
			// 직렬갯수 만큼  td 생성
			for(int j=0; j < colCount; j++){
				colName = "col" + (j+1);
				sbListHtml.append("	<td>" + Util.moneyFormValue(listMap.getString(colName, i)) + "</td>");
			}
						
			sbListHtml.append("</tr>");
		}
	}else{
		sbListHtml.append("<tr><td style=\"height:100px\" colspan=\"100%\">데이타가 없습니다.</td></tr>");
	}
	
	String toToYear = "대상별교육훈련실적_직렬별_" + requestMap.getString("searchYear");
	String month = requestMap.getString("month");
	if(!"".equals(month)) {
		toToYear = toToYear + "_" + month;
	}
	
	// String excel_filename = new String(	toToYear.getBytes(), "ISO-8859-1");
	WebUtils.setFileHeader(request, response, toToYear+".xls", "UTF-8", "UTF-8");
	response.setHeader("Content-Description", "JSP Generated Data"); 
	response.setContentType( "application/vnd.ms-excel" );
	request.setCharacterEncoding("UTF-8");
%>
<meta http-equiv="Content-Type" content="application/vnd.ms-excel; charset=UTF-8">


<table width="95%" border="1" cellpadding="0" cellspacing="0" >
	<tr bgcolor="F7F7F7" align="center" height="30">
		<td class="tableline11" colspan="<%= colCount + 3 %>"><b><%= toToYear %></b></td>
	</tr>
	<tr bgcolor="F7F7F7" align="center" height="28">
		<td class="tableline11" >구분</td>
		<td class="tableline11" >과정명</td>
		<td class="tableline11" >총계</td>
		<%= sbColHtml.toString() %>
	</tr>
	<%= sbListHtml.toString() %>
</table>