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
	
	DataMap rowMap = (DataMap)request.getAttribute("SUBJ_ROW_DATA");
	rowMap.setNullToInitialize(true);
	
	DataMap listMap = (DataMap)request.getAttribute("QUESTION_LIST_DATA");
	listMap.setNullToInitialize(true);
	
	String subj = rowMap.getString("subj");
	String subjnm = rowMap.getString("subjnm");
	
	StringBuffer listStr = new StringBuffer(); //리스트 결과 변수.
	if (listMap.keySize("idQ") > 0) {
		for(int i=0; i < listMap.keySize("idQ"); i++) {
			
			listStr.append("\n<tr height='25'>");
			listStr.append("	<td align='center' bgcolor='#FFFFFF'>").append(listMap.getString("idQ", i)).append("</td>");
			listStr.append("	<td align='center' bgcolor='#FFFFFF'>").append(String.valueOf((i+1))).append("</td>");
			listStr.append("	<td align='center' bgcolor='#FFFFFF'>").append(listMap.getString("difficulty", i)).append("</td>");
			listStr.append("	<td align='center' bgcolor='#FFFFFF'>").append(listMap.getString("qtype", i)).append("</td>");
			listStr.append("	<td align='center' bgcolor='#FFFFFF'>").append(listMap.getString("excount", i)).append("</td>");
			listStr.append("	<td align='center' bgcolor='#FFFFFF'>").append(listMap.getString("cacount", i)).append("</td>");
			listStr.append("	<td bgcolor='#FFFFFF'>").append(listMap.getString("q", i)).append("</td>");
			listStr.append("	<td bgcolor='#FFFFFF'>").append(listMap.getString("ex1", i)).append("</td>");
			listStr.append("	<td bgcolor='#FFFFFF'>").append(listMap.getString("ex2", i)).append("</td>");
			listStr.append("	<td bgcolor='#FFFFFF'>").append(listMap.getString("ex3", i)).append("</td>");
			listStr.append("	<td bgcolor='#FFFFFF'>").append(listMap.getString("ex4", i)).append("</td>");
			listStr.append("	<td bgcolor='#FFFFFF'>").append(listMap.getString("ex5", i)).append("</td>");
			listStr.append("	<td align='center' bgcolor='#FFFFFF'>").append(listMap.getString("ca", i)).append("</td>");
			listStr.append("	<td bgcolor='#FFFFFF'>").append(listMap.getString("explain", i)).append("</td>");
			listStr.append("	<td bgcolor='#FFFFFF'>").append(listMap.getString("hint", i)).append("</td>");
			listStr.append("	<td align='center' bgcolor='#FFFFFF'>").append(listMap.getString("useYn", i)).append("</td>");
			listStr.append("</tr>");
		}
	} else {
		listStr.append("\n<tr>");
		listStr.append("\n	<td colspan='16' height='100' align=center>검색된 내용이 없습니다.</td>");
		listStr.append("\n</tr>");
	}
%>

<%
String toToYear = subjnm + " 문항 목록";
WebUtils.setFileHeader(request, response, toToYear+".xls", "UTF-8", "UTF-8");
response.setHeader("Content-Description", "JSP Generated Data");
response.setContentType("application/vnd.ms-excel");
request.setCharacterEncoding("UTF-8");
%>
<meta http-equiv="Content-Type" content="application/vnd.ms-excel; charset=UTF-8">

<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td height=30 valign=top></td>
	</tr>
	<tr>
		<td height=30 valign=top>
			<font color=000000><b>□ <%=subjnm %> 문항 목록</b></font>
		</td>
	</tr>
	<tr>
		<td bgcolor="E5E5E5">
			<table cellpadding=2 cellspacing=1 width=100% border=1 bordercolorlight="#000000" bordercolordark="#ffffff">
				<tr height='25'>
					<td bgcolor='#EFF9EE' align=center><b>Q_ID</b></td>
					<td bgcolor='#EFF9EE' align=center><b>번호</b></td>
					<td bgcolor='#EFF9EE' align=center><b>난이도</b></td>
					<td bgcolor='#EFF9EE' align=center><b>문제유형</b></td>
					<td bgcolor='#EFF9EE' align=center><b>보기수</b></td>
					<td bgcolor='#EFF9EE' align=center><b>정답수</b></td>
					<td bgcolor='#EFF9EE' align=center><b>문항</b></td>
					<td bgcolor='#EFF9EE' align=center><b>보기1</b></td>
					<td bgcolor='#EFF9EE' align=center><b>보기2</b></td>
					<td bgcolor='#EFF9EE' align=center><b>보기3</b></td>
					<td bgcolor='#EFF9EE' align=center><b>보기4</b></td>
					<td bgcolor='#EFF9EE' align=center><b>보기5</b></td>
					<td bgcolor='#EFF9EE' align=center><b>정답</b></td>
					<td bgcolor='#EFF9EE' align=center><b>해설</b></td>
					<td bgcolor='#EFF9EE' align=center><b>힌트</b></td>
					<td bgcolor='#EFF9EE' align=center><b>사용여부</b></td>
				</tr>
				<%= listStr.toString() %>
			</table>

		</td>
	</tr>

	<tr>
		<td>
			&#160;
		</td>
	</tr>
</table>