<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%  
// prgnm : 개인정보조회출력 엑셀
// date : 2008-10-92
// auth : 정 윤철
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
	
	String sDate = requestMap.getString("date1");
	String eDate = requestMap.getString("date2");
	
	StringBuffer html = new StringBuffer();
	if(listMap.keySize("userno") > 0){
		for(int i=0; i < listMap.keySize("userno"); i++){
			html.append("<tr>");
			html.append("	<td class=\"tableline11\" align=\"center\">"+i+1+"</td>");
			html.append("	<td class=\"tableline11\" align=\"center\">"+listMap.getString("name", i)+"</td>");
			html.append("	<td class=\"tableline11\" align=\"center\">"+(listMap.getString("gubun", i).equals("1") ? "교육확인서" : "출강확인서")+"</td>");
			html.append("	<td class=\"tableline11\" align=\"center\">"+listMap.getString("content", i)+"</td>");
			html.append("	<td class=\"tableline21\" align=\"center\">"+listMap.getString("regdate", i)+"</td>");
			html.append("</tr>");
		}
	}else{
		html.append("<tr>");
		html.append("	<td height=\"100\" align=\"center\" colspan=\"100%\" >등록된 내역이 없습니다.</td>");
		html.append("</tr>");
	}
	
%>
<%
String toToYear = sDate+"~"+eDate+"개인정보조회출력";
// String excel_filename = new String(	toToYear.getBytes(), "ISO-8859-1");
WebUtils.setFileHeader(request, response, toToYear+".xls", "UTF-8", "UTF-8");
response.setHeader("Content-Description", "JSP Generated Data"); 
response.setContentType( "application/vnd.ms-excel" );
request.setCharacterEncoding("UTF-8");
%>
<meta http-equiv="Content-Type" content="application/vnd.ms-excel; charset=UTF-8">

<table width=100% cellpadding=0 cellspacing=0 align=center border=1>
	<tr>
		<td colspan="100%">개인정보조회출력</td>
	</tr>
</table>


<table width=100% cellpadding=0 cellspacing=0 align=center border=1>
	<tr>
		<td height="28" width="5%" align="center" class="tableline11 white" ><strong>NO</strong></td>
		<td class="tableline11 white" align="center" width="15%"><strong>요청인</strong></td>
		<td class="tableline11 white" align="center" width="15%"><strong>구분</strong></td>
		<td class="tableline11 white" align="center" width="46%"><strong>사유</strong></td>
		<td class="tableline11 white" align="center" width="10%"><strong>발급일</strong></td>
	</tr>
	<%=html.toString() %>
</table>






