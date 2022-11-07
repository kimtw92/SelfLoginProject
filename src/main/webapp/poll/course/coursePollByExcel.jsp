<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%  
// prgnm : 강사설문 설문출력 EXCEL
// date : 2008-09-19
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

	
	String tmpStr = "";	
	
	//리스트
	DataMap listMap = (DataMap)request.getAttribute("LIST_DATA");
	listMap.setNullToInitialize(true);

	StringBuffer listStr = new StringBuffer(); //리스트 결과 변수.
	/*   2009.02.20 수정 요청에 따른 변경
	for(int i=0; i < listMap.keySize("questionNo"); i++){

		listStr.append("\n<tr height='25'>");
		
		//과목명
		listStr.append("\n	<td align='center' bgcolor='#FFFFFF'>" + listMap.getString("subjnm", i) + "</td>");
	
		//강사명
		listStr.append("\n	<td align='center' bgcolor='#FFFFFF'>" + listMap.getString("name", i) + "</td>");

		//강의내용
		listStr.append("\n	<td align='center' bgcolor='#FFFFFF' colspan='4'>문제번호" + (listMap.getInt("questionNo", i)-2) + "</td>");

		//배정시간
		listStr.append("\n	<td align='center' bgcolor='#FFFFFF' colspan='3'>문제번호" + (listMap.getInt("questionNo", i)-1) + "</td>");

		//강의기법
		listStr.append("\n	<td align='center' bgcolor='#FFFFFF' colspan='4'>문제번호" + listMap.getInt("questionNo", i) + "</td>");


		listStr.append("\n</tr>");
	
	
	} //end for 
  	*/
  	int x = 1;
	String temname = "";
	String temsubjnm = "";
	for(int i=0; i < listMap.keySize("name"); i++){
		if (temname.equals( listMap.getString("name", i)) && temsubjnm.equals( listMap.getString("subjnm", i))){
			
		} else {
			temname = listMap.getString("name", i);
			temsubjnm = listMap.getString("subjnm", i);
			listStr.append("\n<tr height='25'>");
			listStr.append("\n	<td align='center' bgcolor='#FFFFFF'>" + x + "</td>");
			//과목명
			listStr.append("\n	<td align='center' bgcolor='#FFFFFF'>" + listMap.getString("subjnm", i) + "</td>");
		    // 강의시간 (이후 추가)
			listStr.append("\n	<td align='center' bgcolor='#FFFFFF'></td>");
			//강사명
			listStr.append("\n	<td align='center' bgcolor='#FFFFFF'>" + listMap.getString("name", i) + "</td>");
	
			listStr.append("\n</tr>");
			x ++;
		}
	
	
	} //end for 
	//row가 없으면.
	if( listMap.keySize("name") <= 0){

		listStr.append("\n<tr>");
		listStr.append("\n	<td colspan='4' height='100' align=center>검색된 내용이 없습니다.</td>");
		listStr.append("\n</tr>");

	}

%>


<%
String toToYear = "과정_과목평가설문지_" + DateUtil.getDateTime();
WebUtils.setFileHeader(request, response, toToYear+".xls", "UTF-8", "UTF-8");
response.setHeader("Content-Description", "JSP Generated Data");
response.setContentType("application/vnd.ms-excel");
request.setCharacterEncoding("UTF-8");
%>
<meta http-equiv="Content-Type" content="application/vnd.ms-excel; charset=UTF-8">



<table width="800" border="0" cellspacing="0" cellpadding="0">

	<tr>
		<td height=30 valign=top></td>
	</tr>
	<tr>
		<td bgcolor="E5E5E5">

			<table cellpadding=2 cellspacing=1 width=100% border=1 bordercolorlight="#000000" bordercolordark="#ffffff">

				<tr height='25'>
					<td bgcolor='#EFF9EE' align=center><b>문제 번호</b></td>
					<td bgcolor='#EFF9EE' align=center><b>교 과 목</b></td>
					<td bgcolor='#EFF9EE' align=center><b>강의시간</b></td>
					<td bgcolor='#EFF9EE' align=center><b>강사명</b></td>
				</tr>

				<!-- tr height='25'>
					<td bgcolor='#EFF9EE' align=center><b>매우<br>우수</b></td>
					<td bgcolor='#EFF9EE' align=center><b>우수</b></td>
					<td bgcolor='#EFF9EE' align=center><b>보통</b></td>
					<td bgcolor='#EFF9EE' align=center><b>미흡</b></td>
					<td bgcolor='#EFF9EE' align=center><b>적정</b></td>
					<td bgcolor='#EFF9EE' align=center><b>연장</b></td>
					<td bgcolor='#EFF9EE' align=center><b>단축</b></td>
					<td bgcolor='#EFF9EE' align=center><b>매우<br>우수</b></td>
					<td bgcolor='#EFF9EE' align=center><b>우수</b></td>
					<td bgcolor='#EFF9EE' align=center><b>보통</b></td>
					<td bgcolor='#EFF9EE' align=center><b>미흡</b></td>
				</tr -->
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