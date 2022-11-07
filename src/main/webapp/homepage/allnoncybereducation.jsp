<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commonInc/include/commonImport.jsp" %>

<html>
<head>

<title>인천사이버교육센터(시민포털)에 오신것을 환영합니다</title>
<link rel="stylesheet" type="text/css" href="/commonInc/css/skin1/popup.css" />
</head>
<%

	DataMap listMap = (DataMap)request.getAttribute("ALL_NON_CYBER_LIST");
	listMap.setNullToInitialize(true);
	
	
	StringBuffer sbListHtml = new StringBuffer();

	if(listMap.keySize("rownum") > 0){		
		for(int i=0; i < listMap.keySize("rownum"); i++){
			sbListHtml.append("<tr>");
			sbListHtml.append("<td class=\"sbj\"><a href=\"/homepage/course.do?mode=courseinfopopup&grcode="+listMap.getString("grcode", i)+"&grseq="+listMap.getString("grseq", i)+"\">"+listMap.getString("grcodeniknm", i)+"</a></td>");
			sbListHtml.append("<td>"+listMap.getString("eapplyst", i)+"~"+listMap.getString("eapplyed", i)+"</td>");
			sbListHtml.append("<td>"+listMap.getString("tseat", i)+"</td>");
			sbListHtml.append("<td>40</td>");
			sbListHtml.append("<td>"+listMap.getString("started", i)+"~"+listMap.getString("enddate", i)+"</td>");
			sbListHtml.append("</tr>	");		
		}
	}
%>

<body>
<div class="top">
	<h1 class="h1">수강신청중인과정</h1>
</div>
<div class="contents">

	<div class="h10"></div>
	
	<!-- data -->
	<table class="dataH01" style="width:555px;">	
	<colgroup>
		<col width="" />
		<col width="" />
		<col width="" />
		<col width="" />
		<col width="" />
	</colgroup>

	<thead>
	<tr>
		<th>과정명</th>
		<th>신청기간</th>
		<th>인원</th>
		<th>이수시간</th>
		<th>교육기간</th>
	</tr>
	</thead>
	                                                                        
	<tbody>
	<%=sbListHtml %>
	</tbody>
	</table>
	<!-- //data --> 

	<!-- button -->
	<div class="btnC" style="width:555px;">
		<a href="javascript:window.close();"><img src="/images/skin1/button/btn_close01.gif" alt="닫기" /></a>		
	</div>	
	<!-- //button -->
</div>
</body>
</html>
