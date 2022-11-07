<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%  
// prgnm : 강사이력관리 엑셀 출력
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
	
	if(listMap.keySize("name") > 0){

		for(int i=0; i < listMap.keySize("name"); i++){
			html.append("<tr>");
			html.append("<td height=\"28\" align=\"center\">"+i+"</td>");
			html.append("<td align=\"center\">"+(listMap.getString("name", i).equals("") ? "&nbsp" : listMap.getString("name",i) )+"</td>");
			
			html.append("<td align=\"center\">"+(listMap.getString("tposition", i).equals("") ? "&nbsp" : listMap.getString("tposition",i) )+"&nbsp;");
			html.append(listMap.getString("jikwi",i).equals("") ? "" : listMap.getString("jikwi",i) + "</td>");
			
			html.append("<td align=\"center\">"+(listMap.getString("grcodeniknm", i).equals("") ? "&nbsp" : listMap.getString("grcodeniknm",i) )+"</td>");
			html.append("<td align=\"center\">"+(listMap.getString("lecnm", i).equals("") ? "&nbsp" : listMap.getString("lecnm", i) )+"</td>");
			
			html.append("<td align=\"center\">"+(listMap.getString("resno", i).equals("") ? "&nbsp" : listMap.getString("resno", i) )+"</td>");
			
			html.append("<td align=\"center\">"+(listMap.getString("bankname", i).equals("") ? "&nbsp" : listMap.getString("bankname", i) ));
			html.append("&nbsp;"+(listMap.getString("bankno", i).equals("") ? "&nbsp" : listMap.getString("bankno", i) )+"</td>");
			
			html.append("<td align=\"center\">"+(listMap.getString("started", i).equals("") ? "&nbsp" : listMap.getString("started", i) )+"</td>");
			html.append("<td align=\"center\">"+(listMap.getString("tottime", i).equals("") ? "&nbsp" : listMap.getString("tottime", i) )+"</td>");
			html.append("<td align=\"center\">"+(listMap.getString("levelName", i).equals("") ? "&nbsp" : listMap.getString("levelName", i) )+"</td>");
			html.append("<td align=\"center\">"+(listMap.getString("job", i).equals("") ? "&nbsp" : listMap.getString("job", i) )+"</td>");
			html.append("</tr>");
		}
	}else{
		html.append("<tr>");
		html.append("<td align=\"center\" colspan=\"100%\" width=\"100%\" style=\"height:100px\">등록된 데이터가  없습니다.</td>");
		html.append("</tr>");	
	}
	
%>
<%
String toToYear = requestMap.getString("sDate")+"~"+requestMap.getString("eDate")+"_강사이력관리";
//String excel_filename = new String(	toToYear.getBytes(), "ISO-8859-1");
WebUtils.setFileHeader(request, response, toToYear+".xls", "UTF-8", "UTF-8");
response.setHeader("Content-Description", "JSP Generated Data"); 
response.setContentType( "application/vnd.ms-excel" );
request.setCharacterEncoding("UTF-8");
%>
<meta http-equiv="Content-Type" content="application/vnd.ms-excel; charset=UTF-8">
<HEAD>
<style>
BODY td {COLOR: black;FONT-SIZE: 15px;font-family:돋움; }
BODY th {COLOR: black;FONT-SIZE: 15px;font-family:돋움; }
</style>
</HEAD>


<table width="800" border="0" cellpadding="0" cellspacing="0" border=1 bordercolorlight=#000000 bordercolordark=#ffffff>
	<tr>
		<th>번호</th>
		<th>성명</th>
		<th>소속 및 직위</th>
		<th>과정명</th>
		<th>과목명</th>
		<th>주민등록번호</th>
		<th>은행 계좌번호</th>
		<th>강의일자</th>
		<th>총시간</th>	
		<th class="br0">강사등급</th>
		<th>직업군</th>
	</tr>							
</table>

<table width=100% cellpadding=0 cellspacing=0 align=center border=1>
		<%=html.toString() %>
</table>






