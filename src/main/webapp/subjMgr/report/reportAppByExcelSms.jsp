<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%  
// prgnm : 과제물출제 sms용 엑셀
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

	//과정 명, 과정 데이트
	DataMap grcodeMap = (DataMap)request.getAttribute("GRCODEROW_DATA");
	grcodeMap.setNullToInitialize(true);
	
	StringBuffer html = new StringBuffer();
	
	for(int i=0;i < listMap.keySize("userno"); i++){
		html.append("<tr>");
		
		try{
			String[] hp = listMap.getString("hp").split("-");;
			String hp1 = "";
			String hp2 = "";
			String hp3 = "";
			String totHp = "";
			
			hp1 = hp[0];
			hp2 = hp[1];
			hp3 = hp[2];
			totHp = hp1+hp2+hp3;
			html.append("<td class='xl42'>"+totHp+"</td>");
			
		}catch (Exception e) {
			html.append("<td class='xl42'>"+listMap.getString("hp")+"</td>");
			
		}
		
		html.append("<td>"+listMap.getString("name", i)+"</td>");
		html.append("<td>"+grcodeMap.getString("grcodenm")+" 과정의 과제물 제출기간은 "+grcodeMap.getString("reportDate")+" 입니다.</td>");
		html.append("</tr>");
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



<table width="800" cellpadding="0" cellspacing="0" border="1" bordercolorlight="#000000" bordercolordark="#ffffff">
	<tr>
		<td>휴대폰번호</td>
		<td>이름</td>
		<td>메세지내용</td>
	</tr>
	<%=html.toString() %>
</table>





