<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%  
// prgnm : 자퇴/미등록/퇴교자 조회 엑셀 출력
// date : 2008-07-16
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
	//String tmpStr = "";

	for(int i=0; i < listMap.keySize("userno"); i++){

		listStr.append("\n<tr height='25'>");


		//번호
		listStr.append("\n	<td align='center' bgcolor='#FFFFFF'>" + (i+1) + "</td>");

		//이름
		listStr.append("\n	<td align='center' bgcolor='#FFFFFF'>" + listMap.getString("name", i) + "</td>");

		//소속기관
		listStr.append("\n	<td align='center' bgcolor='#FFFFFF'>" + listMap.getString("deptnm", i) + "</td>");

		//퇴교처리일
		listStr.append("\n	<td align='center' bgcolor='#FFFFFF'>" + listMap.getString("cancelDate", i) + "</td>");

		//퇴교구분
		listStr.append("\n	<td align='center' bgcolor='#FFFFFF'>" + listMap.getString("ckindnm", i) + "</td>");

		//퇴교사유
		listStr.append("\n	<td align='center' bgcolor='#FFFFFF'>" + listMap.getString("reason", i) + "</td>");


		listStr.append("\n</tr>");

	} //end for listMap.keySize("userno")

	//row가 없으면.
	if( listMap.keySize("userno") <= 0){

		listStr.append("\n<tr>");
		listStr.append("\n	<td colspan='6' height='100' align=center>퇴교자가 없습니다</td>");
		listStr.append("\n</tr>");

	}


	//과정 기수 명.
	String grseqNm = grseqRowMap.getString("grcodeniknm").equals("") ? "선택된 과정/기수 정보가 없습니다. 과정/기수를 선택하세요!" : grseqRowMap.getString("grcodeniknm") + " - " + grseqRowMap.getString("substrYear") + "년 " + grseqRowMap.getString("substrSeq") + "기";

%>

<%
String toToYear = grseqRowMap.getString("grcodeniknm") + "자퇴_미등록_퇴교자";
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
	</tr>
	<tr>
		<td height=30 valign=top></td>
	</tr>
	<tr>
		<td height=30 valign=top>
			<font color=000000><b>□ 퇴교자 명단 조회</b></font>
		</td>
	</tr>

	<tr>
		<td bgcolor="E5E5E5">

			<table cellpadding=2 cellspacing=1 width=100% border=1 bordercolorlight="#000000" bordercolordark="#ffffff">

				<tr height='25'>
					<td bgcolor='#EFF9EE' align=center><b>번호</b></td>
					<td bgcolor='#EFF9EE' align=center><b>이름</b></td>
					<td bgcolor='#EFF9EE' align=center><b>소속기관</b></td>
					<td bgcolor='#EFF9EE' align=center><b>퇴교처리일</b></td>
					<td bgcolor='#EFF9EE' align=center><b>퇴교구분</b></td>
					<td bgcolor='#EFF9EE' align=center><b>퇴교사유</b></td>
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