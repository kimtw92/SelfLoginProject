<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%  
// prgnm : 과제물출제 리스트 엑셀
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
	
	//리스트 데이터
	DataMap listMap = (DataMap)request.getAttribute("LIST_DATA");
	listMap.setNullToInitialize(true);

	
	StringBuffer html = new StringBuffer();
	if(listMap.keySize("userno") > 0 ){
		for(int i=0; listMap.keySize("userno") > i; i++){
	
			
			html.append("<tr>");
	
			html.append("<td height=\"28\" class=\"tableline11\">"+listMap.getString("eduno", i)+"&nbsp;</td>");
			html.append("<td height=\"28\" class=\"tableline11\">"+listMap.getString("classno", i)+"&nbsp;</td>");
			html.append("<td height=\"28\" class=\"tableline11\">"+listMap.getString("name", i)+"&nbsp;</td>");
			if(!listMap.getString("groupfileNo", i).equals("0")){
				html.append("<td height=\"28\" class=\"tableline11\">제출</td>");
			}else{
				html.append("<td height=\"28\" class=\"tableline11\">미제출</td>");
			}
			html.append("<td height=\"28\" class=\"tableline11\">"+listMap.getString("submitDate", i)+"&nbsp;</td>");
			html.append("<td height=\"28\" class=\"tableline11\">"+listMap.getString("resno", i)+"&nbsp;</td>");
			html.append("<td height=\"28\" class=\"tableline11\">"+listMap.getString("deptnm", i)+"&nbsp;</td>");
			html.append("<td height=\"28\" class=\"tableline11\">"+listMap.getString("jikwi", i)+"&nbsp;</td>");
			html.append("<td height=\"28\" class=\"tableline11\">"+listMap.getString("submitPoint", i)+"&nbsp;</td>");
			
			html.append("</tr>");			
			
		}
	}else{
		html.append("<tr>");
		html.append("<td colspan=\"100%\"> 등록된 데이터가 없습니다.");
		html.append("</td>");
		html.append("</tr>");
	}
%>
<%
String toToYear = "과제물평가리스트";
//String excel_filename = new String(	toToYear.getBytes(), "ISO-8859-1");
WebUtils.setFileHeader(request, response, toToYear+".xls", "UTF-8", "UTF-8");
response.setHeader("Content-Description", "JSP Generated Data"); 
response.setContentType( "application/vnd.ms-excel" );
request.setCharacterEncoding("UTF-8");
%>
<meta http-equiv="Content-Type" content="application/vnd.ms-excel; charset=UTF-8">

<table width="100%" border="1" cellpadding="0" cellspacing="0" bordercolorlight="#000000" bordercolordark="#ffffff">
	<tr >
		<td  align="center"><strong>교번</strong></td>
		<td  align="center"><strong>반</strong></td>
		<td  align="center"><strong>이름</strong></td>
		<td  align="center"><strong>제출여부</strong></td>
		<td  align="center"><strong>제출일자</strong></td>
		<td  align="center"><strong>생년월일</strong></td>
		<td  align="center"><strong>소속기관</strong></td>
		<td  align="center"><strong>직급</strong></td>
		<td  align="center"><strong>점수</strong></td>
	</tr>
</table>

<table width=100% cellpadding=0 cellspacing=0 align=center border=1>
		<%=html.toString() %>
</table>






