<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%  
// prgnm : 출강강사 명단 리스트 엑셀
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
	int rowSpan = 0;
	
	String grcode = "";
	String grseq = "";
	String subj = "";
	String strDate = "";
	//몇번째 라인인지 체크한다.
	int lineChk = 0;
	for(int i=0; listMap.keySize("grcode") > i; i++){
	
		if(lineChk == 0){
			rowSpan = 1;
			for(int j =(i+1); listMap.keySize("grcode") > j; j++ ){
				if(listMap.getString("grcode",i).equals(listMap.getString("grcode",j)) 
					&& listMap.getString("grseq",i).equals(listMap.getString("grseq",j)) 
					&& listMap.getString("subj",i).equals(listMap.getString("subj",j)) 
					&& listMap.getString("strDate",i).equals(listMap.getString("strDate",j))  ){
					rowSpan++;
					lineChk++;
				}else{
					break;
				}
			}
		}else{
			rowSpan = 0;
			lineChk--;
		}
		
		html.append("<tr>");
		if(rowSpan > 0){

			html.append("<td height=\"28\" rowspan=\""+rowSpan+"\" class=\"tableline11\">"+(i+1)+"</td>");
			html.append("<td height=\"28\" rowspan=\""+rowSpan+"\" class=\"tableline11\">"+listMap.getString("grcodenm", i)+"</td>");
			html.append("<td height=\"28\" rowspan=\""+rowSpan+"\" class=\"tableline11\">"+listMap.getString("lecnm", i)+"</td>");
			html.append("<td height=\"28\" rowspan=\""+rowSpan+"\" class=\"tableline11\">"+listMap.getString("grseq", i)+"</td>");

		}
		
		html.append("<td height=\"28\" class=\"tableline11\">"+listMap.getString("name", i)+"</td>");
		html.append("<td height=\"28\" class=\"tableline11\">"+(listMap.getString("tgubun", i).equals("1") ? "주강사" : "보조강사")+"</td>");
		html.append("<td height=\"28\" class=\"tableline11\">"+listMap.getString("tposition", i)+"</td>");
		html.append("<td height=\"28\" class=\"tableline11\">"+listMap.getString("deptsub", i)+"</td>");
		html.append("<td height=\"28\" class=\"tableline11\">"+listMap.getString("jikwi", i)+"</td>");
		html.append("<td height=\"28\" class=\"tableline11\">"+listMap.getString("homeTel", i)+"</td>");
		html.append("<td height=\"28\" class=\"tableline11\">"+listMap.getString("homeAddr", i)+"</td>");
		html.append("<td height=\"28\" class=\"tableline11\">"+listMap.getString("tlevel", i)+"</td>");
		html.append("<td height=\"28\" class=\"tableline11\">"+listMap.getString("ttime", i)+"</td>");
		
		html.append("</tr>");

		grcode = listMap.getString("grcode", i);
		grseq = listMap.getString("grseq",i);
		subj = listMap.getString("subj",i);
		strDate = listMap.getString("strDate",i);
		
	}
	
%>
<%
String toToYear = "출강강사 명단";
//String excel_filename = new String(	toToYear.getBytes(), "ISO-8859-1");
WebUtils.setFileHeader(request, response, toToYear+".xls", "UTF-8", "UTF-8");
response.setHeader("Content-Description", "JSP Generated Data"); 
response.setContentType( "application/vnd.ms-excel" );
request.setCharacterEncoding("UTF-8");
%>
<meta http-equiv="Content-Type" content="application/vnd.ms-excel; charset=UTF-8">



<table width="800" border="0" cellpadding="0" cellspacing="0" border=1 bordercolorlight=#000000 bordercolordark=#ffffff>
<tr bgcolor="F7F7F7" align = center>
	<td height="28" class="tableline11"><b>연번</td>
	<td height="28" class="tableline11"><b>과정명</td>
	<td height="28" class="tableline11"><b>교과목</td>
	<td height="28" class="tableline11"><b>기수</td>
	<td height="28" class="tableline11"><b>강사명</td>
	<td height="28" class="tableline11"><b>강사구분</td>
	<td height="28" class="tableline11"><b>강사소속</td>
	<td height="28" class="tableline11"><b>소속부서</td>
	<td height="28" class="tableline11"><b>직위</td>
	<td height="28" class="tableline21"><b>전화번호</td>
	<td height="28" class="tableline21"><b>집주소</td>	
	<td height="28" class="tableline11"><b>강사등급</td>
	<td height="28" class="tableline11"><b>강의시간</td>
</tr>
</table>

<table width=100% cellpadding=0 cellspacing=0 align=center border=1>
		<%=html.toString() %>
</table>






