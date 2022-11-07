<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%  
// prgnm : 우수강사 엑셀출력
// date  : 2008-07-10
// auth  : 정윤철
%>

<!-- [s] commonImport -->
<%@ include file="/commonInc/include/commonImport.jsp" %>
<!-- [e] commonImport -->

<%
    //request 데이터
	DataMap requestMap = (DataMap)request.getAttribute("REQUEST_DATA");
	requestMap.setNullToInitialize(true);

	// 필수 코딩 내용 //////////////////////////////////////////////////////////////////////
	//로그인된 사용자 정보
	LoginInfo memberInfo = (LoginInfo)request.getAttribute("LOGIN_INFO");
	
    //navigation 데이터
	DataMap navigationMap = (DataMap)request.getAttribute("NAVIGATION_DATA");
	navigationMap.setNullToInitialize(true);
	
	// 상단 navigation
	String navigationStr = LoginCheck.NavigationCreate(memberInfo, navigationMap);
	////////////////////////////////////////////////////////////////////////////////////
	
	//엑셀 데이터
	DataMap listMap = (DataMap)request.getAttribute("LIST_DATA");
	listMap.setNullToInitialize(true);
	
	StringBuffer html = new StringBuffer();
	
	if(listMap.keySize("subjnm") > 0){

		for(int i=0; i < listMap.keySize("subjnm"); i++){
			html.append("<tr>");
			html.append("<td height=\"28\" align=\"center\">"+(listMap.getString("subjnm", i).equals("") ? "&nbsp" : listMap.getString("subjnm",i) )+"</td>");
			html.append("<td align=\"center\">"+(listMap.getString("tposition", i).equals("") ? "&nbsp" : listMap.getString("tposition",i) )+"</td>");
			html.append("<td align=\"center\">"+(listMap.getString("name", i).equals("") ? "&nbsp" : listMap.getString("name",i) )+"</td>");
			html.append("<td align=\"center\">"+(listMap.getString("grname", i).equals("") ? "&nbsp" : listMap.getString("grname", i) )+"</td>");
			html.append("<td align=\"center\">"+(listMap.getString("num1", i).equals("") ? "&nbsp" : listMap.getString("num1", i) )+"</td>");
			html.append("<td align=\"center\">"+(listMap.getString("num2", i).equals("") ? "&nbsp" : listMap.getString("num2", i) )+"</td>");
			html.append("<td align=\"center\">"+(listMap.getString("num3", i).equals("") ? "&nbsp" : listMap.getString("num3", i) )+"</td>");
			html.append("<td align=\"center\">"+(listMap.getString("num4", i).equals("") ? "&nbsp" : listMap.getString("num4", i) )+"</td>");
			html.append("<td align=\"center\">"+(listMap.getString("rat", i).equals("") ? "&nbsp" : listMap.getString("rat", i) )+"</td>");
			html.append("</tr>");
		}
	}else{
		html.append("<tr>");
		html.append("<td align=\"center\" colspan=\"9\" style=\"height:100px;text-align:center;\">등록된 출강강사가 없습니다.</td>");
		html.append("</tr>");	
	}
	
%>
<%
String toToYear = "우수강사_"+requestMap.getString("sDate")+"_"+requestMap.getString("eDate")+"_"+requestMap.getString("sPer")+"퍼센트이상";
//String excel_filename = new String(	toToYear.getBytes(), "ISO-8859-1");
	WebUtils.setFileHeader(request, response, toToYear+".xls", "UTF-8", "UTF-8");
response.setHeader("Content-Description", "JSP Generated Data"); 
response.setContentType( "application/vnd.ms-excel" );
request.setCharacterEncoding("UTF-8");
%>
<meta http-equiv="Content-Type" content="application/vnd.ms-excel; charset=UTF-8">



<table width="800" border="0" cellpadding="0" cellspacing="0" border="1" bordercolorlight="#000000" bordercolordark="#ffffff">
	<tr>
		<th rowspan="2">과목명</th>
		<th colspan="2">강사</th>
		<th rowspan="2">과정명</th>
		<th colspan="4">강의 만족도</th>
		<th rowspan="2" class="br0">비율(%)</th>								
	</tr>
	<tr>
		<th>소속</th>
		<th>강사명</th>
		<th>매우우수</th>	
		<th>우수</th>	
		<th>보통</th>	
		<th>미흡</th>	
	</tr>	
</table>

<table width=100% cellpadding=0 cellspacing=0 align=center border=1>
		<%=html.toString() %>
</table>






