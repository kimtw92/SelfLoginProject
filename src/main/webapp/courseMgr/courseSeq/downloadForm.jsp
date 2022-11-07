<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%  
// prgnm : 과목코드별 문항 목록 엑셀 출력
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
	LoginCheck loginChk = new LoginCheck();
	String navigationStr = loginChk.NavigationCreate(memberInfo, navigationMap);
	////////////////////////////////////////////////////////////////////////////////////
	
	DataMap listMap = (DataMap)request.getAttribute("LIST_DATA");
	listMap.setNullToInitialize(true);
	
	StringBuffer listStr = new StringBuffer(); //리스트 결과 변수.
	if (listMap.keySize("subj") > 0) {
		listStr.append("\n<tr height='25'>");
		for(int i=0; i<listMap.keySize("subj"); i++) {
			listStr.append("	<td align='center' bgcolor='#FFFFFF'>").append(listMap.getString("subj", i)).append("</td>");
			listStr.append("	<td align='center' bgcolor='#FFFFFF'>").append(listMap.getString("subjnm", i)).append("</td>");
		}
		listStr.append("</tr>");
	}
%>

<%
String toToYear = "집합교육 시험지 생성 서식";
WebUtils.setFileHeader(request, response, toToYear+".xls", "UTF-8", "UTF-8");
response.setHeader("Content-Description", "JSP Generated Data");
response.setContentType("application/vnd.ms-excel");
request.setCharacterEncoding("UTF-8");
%>
<meta http-equiv="Content-Type" content="application/vnd.ms-excel; charset=UTF-8">

<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td bgcolor="E5E5E5">
			<table cellpadding=2 cellspacing=1 width=100% border=1 bordercolorlight="#000000" bordercolordark="#ffffff">
				<%= listStr.toString() %>
			</table>
		</td>
	</tr>
</table>