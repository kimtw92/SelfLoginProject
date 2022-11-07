<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%  
// prgnm : 전체 학습현황 엑셀 출력
// date : 2008-08-14
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

	
	//수강생 리스트
	DataMap listMap = (DataMap)request.getAttribute("LIST_DATA");
	listMap.setNullToInitialize(true);

	//과목 리스트
	DataMap subjListMap = (DataMap)request.getAttribute("SUBJ_LIST_DATA");
	subjListMap.setNullToInitialize(true);

	//수강생의 과목별 점수 리스트
	DataMap subjStuPointListMap = (DataMap)request.getAttribute("STUPOINT_LIST_DATA");
	subjStuPointListMap.setNullToInitialize(true);


	StringBuffer listStr = new StringBuffer(); //리스트 결과 변수.
	String tmpStr = "";
	int tmpInt = 0;
	double tmpDouble = 0;

	for(int i=0; i < listMap.keySize("userno"); i++){

		listStr.append("\n<tr height='25'>");

		//번호
		listStr.append("\n	<td align='center' bgcolor='#FFFFFF'>" + (i+1) + "</td>");

		//성명
		listStr.append("\n	<td align='center' bgcolor='#FFFFFF'>" + listMap.getString("name", i) + "</td>");

		//ID
		listStr.append("\n	<td align='center' bgcolor='#FFFFFF'>" + listMap.getString("userId", i) + "</td>");

		//기관
		if( listMap.getString("deptnm", i).equals("6280000") )
			tmpStr = listMap.getString("deptnm", i);
		else
			tmpStr = listMap.getString("deptnm", i).replace("인천광역시", "");
		listStr.append("\n	<td align='center' bgcolor='#FFFFFF'>" + tmpStr + "</td>");

		//직급
		listStr.append("\n	<td align='center' bgcolor='#FFFFFF'>" + listMap.getString("jiknm", i) + "</td>");


		//과목별 점수.
		tmpDouble = 0;
		for(int j=0; j < subjListMap.keySize("subj"); j++){

			tmpInt = 0;
			for(int k=0; k < subjStuPointListMap.keySize("subj"); k++){

				//수강생이 같고 과목 정보가 같으면
				if( listMap.getString("userno", i).equals(subjStuPointListMap.getString("userno", k)) && subjListMap.getString("subj", j).equals(subjStuPointListMap.getString("subj", k)) ){
					listStr.append("\n	<td align='center' bgcolor='#FFFFFF'>" + subjStuPointListMap.getString("subjTotpoint", k) + "</td>");
					tmpDouble += HandleNumber.toDouble(subjStuPointListMap.getString("subjTotpoint", k));
					tmpInt++;
					break;
				}
			}
			//수강생 과목별  정보가 없으면 0
			if(tmpInt == 0)
				listStr.append("\n	<td align='center' bgcolor='#FFFFFF'>0</td>");
		}

		if( !memberInfo.getSessClass().equals(Constants.ADMIN_SESS_CLASS_DEPT) ){
			//총점 과목의 합 + 특수 점수(과대 및 부대등)
			tmpDouble += HandleNumber.toDouble(listMap.getString("addpoint", i));
			listStr.append("\n	<td align='center' bgcolor='#FFFFFF'>" + HandleNumber.getCommaPointNumber(tmpDouble) + "</td>");
            listStr.append("\n	<td >" + HandleNumber.toDouble(listMap.getString("avreport", i)) + "</td>");
            listStr.append("\n	<td >" + HandleNumber.toDouble(listMap.getString("stuTotpoint", i)) + "</td>");
		}


		listStr.append("\n</tr>");

	} //end for listMap.keySize("dept")


	//row가 없으면.
	if( listMap.keySize("userno") <= 0){

		listStr.append("\n<tr>");
		listStr.append("\n	<td colspan='6' height='100' align=center>검색된 내용이 없습니다.</td>");
		listStr.append("\n</tr>");

	}

	String subjListStr = "";
	for(int i=0; i < subjListMap.keySize("subj"); i++)
		subjListStr += "<td bgcolor='#EFF9EE' align=center><b>" + subjListMap.getString("lecnm", i) + "</td>";

%>


<%
String toToYear = "전체학습현황";
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
			<font color=000000><b>□ 전체 학습 현황</b></font>
		</td>
	</tr>

	<tr>
		<td bgcolor="E5E5E5">

			<table cellpadding=2 cellspacing=1 width=100% border=1 bordercolorlight="#000000" bordercolordark="#ffffff">

				<tr height='25'>
					<td bgcolor='#EFF9EE' align=center><b>번호</b></td>
					<td bgcolor='#EFF9EE' align=center><b>성명</b></td>
					<td bgcolor='#EFF9EE' align=center><b>ID</b></td>
					<td bgcolor='#EFF9EE' align=center><b>기관</b></td>
					<td bgcolor='#EFF9EE' align=center><b>직급</b></td>
					<%= subjListStr %>
				<%if( !memberInfo.getSessClass().equals(Constants.ADMIN_SESS_CLASS_DEPT) ){%>
					<td bgcolor='#EFF9EE' align=center><b>총점</b></td>
					<td bgcolor='#EFF9EE' align=center><b>과제점수</b></td>
					<td bgcolor='#EFF9EE' align=center><b>과제합</b></td>
				<%}%>
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