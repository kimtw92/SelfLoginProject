<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%  
// prgnm : 강의실 현황 엑셀 출력
// date : 2008-06-19
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
	LoginCheck loginChk = new LoginCheck();
	String navigationStr = loginChk.NavigationCreate(memberInfo, navigationMap);
	////////////////////////////////////////////////////////////////////////////////////
	
	//엑셀 데이터
	DataMap rowMap = (DataMap)request.getAttribute("EXCEL_DATA");
	rowMap.setNullToInitialize(true);
	
	DataMap rowMap2 = rowMap;
	
	
	String year = StringReplace.subString(requestMap.getString("date"), 0, 4);
	String month = StringReplace.subString(requestMap.getString("date"), 4, 6);

	StringBuffer day = new StringBuffer();

	for(int i=1	; i <= DateUtil.getMonthDate(year, month); i++){
		if(i < 10){
			day.append("<td>0"+i+"</td>");
		}else{
			day.append("<td>"+i+"</td>");
		}
	}
	
	String bgcolr = "";
	
	String tmpStr = "";
	int tmpCnt = 0;
	StringBuffer name = new StringBuffer();
	if(rowMap.keySize("grcode") > 0){
		
		for(int i =0;i < rowMap.keySize("grcode"); i++){ //

			
			if(!tmpStr.equals(rowMap.getString("grcode", i))){
				
				
				if( tmpCnt > 0){
					name.append("\n	</tr>");
				}
				
				name.append("\n	<tr>");
				name.append("\n	<td>" + rowMap.getString("classGrname", i) + "</td>");
				
				
				for(int j=1	; j <= DateUtil.getMonthDate(year, month); j++){
					
					
					boolean isCheck = false;
					
					for(int k =0;k < rowMap2.keySize("grcode"); k++){
						
						
						if(rowMap.getString("grcode", i).equals(rowMap2.getString("grcode", k))
								&& Util.plusZero(j).equals(rowMap2.getString("studydate", k))){
							
							isCheck = true;
							break;
							
						}
						
					}
					
					if(isCheck){
						name.append("\n	<td bgcolor = \"#BFFFBF\">&nbsp;</td>");
					}else{
						name.append("\n	<td>&nbsp;</td>");
					}
					
				}
				
				tmpCnt ++;
				
			}
		
			tmpStr = rowMap.getString("grcode", i);
		}
	}else{
		name.append("\n	</tr>");
	}


	if(rowMap.keySize("grcode") <= 0){
		name.append("<tr><td colspan=\"100%\">강의실 사용 내역이 존재하지 않습니다</td><tr>");
	}
%>
<%
String toToYear = year+"-"+month+"강의실 사용현황";
// String excel_filename = new String(	toToYear.getBytes(), "ISO-8859-1");
	WebUtils.setFileHeader(request, response, toToYear+".xls", "UTF-8", "UTF-8");
response.setHeader("Content-Description", "JSP Generated Data"); 
response.setContentType( "application/vnd.ms-excel" );
request.setCharacterEncoding("UTF-8");
%>
<meta http-equiv="Content-Type" content="application/vnd.ms-excel; charset=UTF-8">



<table width=100% cellpadding=0 cellspacing=0 align=center border=1>
	<tr>
		<td colspan="100%"><%=requestMap.getString("date").substring(0,4) %> - <%=requestMap.getString("date").substring(4, 6) %>강의실 사용현황</td>
	</tr>
</table>


<table width=100% cellpadding=0 cellspacing=0 align=center border=1>
	<tr>
		<td>내역</td>
		<%=day.toString() %>
		
	</tr>
		<%=name.toString() %>
</table>






