<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%  
// prgnm : 강사설문 분석출력 EXCEL
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
	
	//설문 문제 리스트
	DataMap listMap = (DataMap)request.getAttribute("LIST_DATA");
	listMap.setNullToInitialize(true);

	//설문 결과 리스트.
	DataMap listResultMap = (DataMap)request.getAttribute("LIST_RESULT_DATA");
	listResultMap.setNullToInitialize(true);

	StringBuffer listStr = new StringBuffer(); //리스트 결과 변수.
	
	boolean lineStart = true;
	int lineNo = 0;
	int lineCol = 1;
	int enoughtCnt = 0;
	int totalVal = 0;
	int key = 0;
	for(int i=0; i < listResultMap.keySize("questionNo"); i++){

		key++;
		
		if(lineStart){
			
			listStr.append("\n<tr height='25'>");
			
			//과목명
			listStr.append("\n	<td align='center' bgcolor='#FFFFFF'>" + listMap.getString("subjnm", lineNo) + "</td>");
		
			//강사명
			listStr.append("\n	<td align='center' bgcolor='#FFFFFF'>" + listMap.getString("name", lineNo) + "</td>");
			
		}

		//
		listStr.append("\n	<td align='center' bgcolor='#FFFFFF'>" + listResultMap.getInt("anscnt", i) + "</td>");
		
		if( (listResultMap.getInt("questionNo", i) % 3 == 2 && listResultMap.getInt("answerNo", i) < 3) 
				|| (listResultMap.getInt("questionNo", i) % 3 == 0 && listResultMap.getInt("answerNo", i) < 3) ){
			
			enoughtCnt += listResultMap.getInt("anscnt", i);
		}
		
		lineStart = false;

		if( key % 11 == 2)
			totalVal = listResultMap.getInt("total", i);
		if( key % 11 == 0){
			
			listStr.append("\n	<td align='center' bgcolor='#FFFFFF'>");
			
			if( listResultMap.getInt("total", i) > 0 && enoughtCnt > 0){
				/*
				System.out.println("\n ### enoughtCnt = " + enoughtCnt );
				System.out.println("\n ### listResultMap.getInt('total', i) = " + listResultMap.getInt("total", i) );
				System.out.println("\n ### totalVal = " + totalVal );
				System.out.println("\n ### 1 = " +  ((double)enoughtCnt / (listResultMap.getInt("total", i) +  totalVal)) * 100  );
				System.out.println("\n ### 2 = " +  Math.round( ((double)enoughtCnt / (listResultMap.getInt("total", i) +  totalVal)) * 100 )  );
				System.out.println("\n ### i = " + i + "  ###" +  (Math.round( ((double)enoughtCnt / (listResultMap.getInt("total", i) +  totalVal)) * 100 ) / 100) * 100 );
				*/
				listStr.append( Math.round( ((double)enoughtCnt / (listResultMap.getInt("total", i) +  totalVal)) * 100 ) );
			}else
				listStr.append("0");
			
			listStr.append("</td>");
			listStr.append("\n</tr>");
			
			lineStart = true;
			lineNo++;
			enoughtCnt = 0;
			//47 / (76+80)
		}
	
	} //end for 

	//row가 없으면.
	if( listMap.keySize("questionNo") <= 0){

		listStr.append("\n<tr>");
		listStr.append("\n	<td colspan='12' height='100' align=center>검색된 내용이 없습니다.</td>");
		listStr.append("\n</tr>");

	}

%>


<%
String toToYear = "과정_과목평가결과_" + DateUtil.getDateTime();
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
		<td height=30 valign=top>
			<font color=000000><b>교과목별 운영에 대한 평가</b></font>
		</td>
	</tr>
	<tr>
		<td bgcolor="E5E5E5">

			<table cellpadding=2 cellspacing=1 width=100% border=1 bordercolorlight="#000000" bordercolordark="#ffffff">

				<tr height='25'>
					<td bgcolor='#EFF9EE' align=center rowspan="2"><b>교 과 목</b></td>
					<td bgcolor='#EFF9EE' align=center rowspan="2"><b>강사명</b></td>
					<td bgcolor='#EFF9EE' align=center colspan="4"><b>강의내용</b></td>
					<td bgcolor='#EFF9EE' align=center colspan="3"><b>배정시간</b></td>
					<td bgcolor='#EFF9EE' align=center colspan="5"><b>강의기법</b></td>

				</tr>

				<tr height='25'>
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
					<td bgcolor='#EFF9EE' align=center><b>우수도</b></td>
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