<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%  
// prgnm : 교육생(입교자)조회 엑셀 출력
// date : 2008-08-05
// auth : LYM
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

	//리스트
	DataMap listMap = (DataMap)request.getAttribute("LIST_DATA");
	listMap.setNullToInitialize(true);

	//간단한 과정 기수 정보
	DataMap grseqRowMap = (DataMap)request.getAttribute("GRSEQ_ROW_DATA");
	grseqRowMap.setNullToInitialize(true);

	StringBuffer listStr = new StringBuffer(); //리스트 결과 변수.

	for(int i=0; i < listMap.keySize("userno"); i++){

		listStr.append("\n<tr height='25'>");


		//교번
		listStr.append("\n	<td align='center' bgcolor='#FFFFFF'>" + listMap.getString("eduno", i) + "</td>");

		//아이디
		listStr.append("\n	<td align='center' bgcolor='#FFFFFF'>" + listMap.getString("userId", i) + "</td>");

		//기관
		listStr.append("\n	<td align='center' bgcolor='#FFFFFF'>" + listMap.getString("deptnm", i) + "</td>");

		//소속
		listStr.append("\n	<td align='center' bgcolor='#FFFFFF'>" + listMap.getString("deptsub", i) + "</td>");

		//직급
		listStr.append("\n	<td align='center' bgcolor='#FFFFFF'>" + listMap.getString("jiknm", i) + "</td>");

		//이름
		listStr.append("\n	<td align='center' bgcolor='#FFFFFF'>" + listMap.getString("name", i) + "</td>");

		//전화
		listStr.append("\n	<td align='center' bgcolor='#FFFFFF'>" + listMap.getString("hp", i) + "</td>");

		//성별
		listStr.append("\n	<td align='center' bgcolor='#FFFFFF'>" + listMap.getString("sex", i) + "</td>");

		//나이
		listStr.append("\n	<td align='center' bgcolor='#FFFFFF'>" + listMap.getString("age", i) + "</td>");

		listStr.append("\n</tr>");

	} //end for listMap.keySize("userno")



	//row가 없으면.
	if( listMap.keySize("userno") <= 0){

		listStr.append("\n<tr>");
		listStr.append("\n	<td colspan='100%' height='100' class='br0'>검색된 학생이 없습니다</td>");
		listStr.append("\n</tr>");

	}


	//과정 기수 명.
	String grseqNm = grseqRowMap.getString("grcodeniknm") + " - " + grseqRowMap.getString("substrYear") + "년 " + grseqRowMap.getString("substrSeq") + "기 교육생 명단";

%>

<%
String toToYear = grseqRowMap.getString("grcodeniknm") + "_교육생(입교자)조회";
WebUtils.setFileHeader(request, response, toToYear+".xls", "UTF-8", "UTF-8");
response.setHeader("Content-Description", "JSP Generated Data");
response.setContentType("application/vnd.ms-excel");
request.setCharacterEncoding("UTF-8");
%>

<meta http-equiv="Content-Type" content="application/vnd.ms-excel; charset=UTF-8">

<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td align="center" colspan="2">
			<b> <%= grseqNm %> </b>
		</td>
	</tr>
	<tr>
		<td>
			&nbsp;
		</td>
		<td>
	<tr>
		<td height=30 valign=top></td>
	</tr>
	<tr>
		<td height=30 valign=top>
			<font color=000000><b>□ 교육생(입교자)조회</b></font>
		</td>
	</tr>

	<tr>
		<td bgcolor="E5E5E5">

			<table cellpadding=2 cellspacing=1 width=100% border=1 bordercolorlight="#000000" bordercolordark="#ffffff">

				<tr height='25'>
					<td bgcolor='#EFF9EE' align=center><b>교번</b></td>
					<td bgcolor='#EFF9EE' align=center><b>아이디</b></td>
					<td bgcolor='#EFF9EE' align=center><b>기관</b></td>
					<td bgcolor='#EFF9EE' align=center><b>소속</b></td>
					<td bgcolor='#EFF9EE' align=center><b>직급</b></td>
					<td bgcolor='#EFF9EE' align=center><b>성명</b></td>
					<td bgcolor='#EFF9EE' align=center><b>전화</b></td>
					<td bgcolor='#EFF9EE' align=center><b>성별</b></td>
					<td bgcolor='#EFF9EE' align=center><b>나이</b></td>
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