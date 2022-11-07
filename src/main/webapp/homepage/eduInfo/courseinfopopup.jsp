<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<title>인천사이버교육센터(시민포털)에 오신것을 환영합니다</title>
<link rel="stylesheet" type="text/css" href="/commonInc/css/skin1/popup.css" />
</head>
<%@ include file="/commonInc/include/commonImport.jsp" %>
<%!
public String emptyToZeroString(String str){
	if(str == null || str.length() == 0){
		return "0";
	}else{
		return str;
	}
}
%>
<%

	// 필수, request 데이타
	DataMap requestMap = (DataMap)request.getAttribute("REQUEST_DATA");
	requestMap.setNullToInitialize(true);
	// 년도
	String year = (String)request.getAttribute("YEAR");
	
	DataMap popupMap1 = (DataMap)request.getAttribute("COURSE_INFO_POPUP1");
	popupMap1.setNullToInitialize(true);
	
	DataMap popupMap2 = (DataMap)request.getAttribute("COURSE_INFO_POPUP2");
	popupMap2.setNullToInitialize(true);
	
	//과정 기수 정보.(기간별 인원 및 교육기간)
	DataMap grSeqMap = (DataMap)request.getAttribute("COURSE_INFO_PERSON");
	grSeqMap.setNullToInitialize(true);
	
	//
	
	StringBuffer sumHtml = new StringBuffer();
	StringBuffer subSumHtml1 = new StringBuffer();
	StringBuffer subSumHtml2 = new StringBuffer();
	StringBuffer subSumHtml3 = new StringBuffer();
	StringBuffer subDetail1 = new StringBuffer();
	StringBuffer subDetail2 = new StringBuffer();
	StringBuffer subDetail3 = new StringBuffer();

	
	
	DataMap sum = (DataMap)request.getAttribute("COURSE_INFO_SUM");
	sum.setNullToInitialize(true);
	
	if(sum.keySize("sub1") == 1){
		sumHtml.append("<td><strong>"+sum.getString("sub1",0)+"</strong></td>");
		sumHtml.append("<td><strong>"+sum.getString("sub2",0)+"</strong></td>");
		sumHtml.append("<td><strong>"+sum.getString("sub3",0)+"</strong></td>");
		sumHtml.append("<td>"+sum.getString("sub4",0)+"</td>");
	}

	DataMap detail = (DataMap)request.getAttribute("COURSE_INFO_DETAIL");
	detail.setNullToInitialize(true);		
	
	DataMap subSum1 = (DataMap)request.getAttribute("COURSE_INFO_SUB_SUM1");
	subSum1.setNullToInitialize(true);
	
	DataMap subSum2 = (DataMap)request.getAttribute("COURSE_INFO_SUB_SUM2");
	subSum2.setNullToInitialize(true);
	
	DataMap subSum3 = (DataMap)request.getAttribute("COURSE_INFO_SUB_SUM3");
	subSum3.setNullToInitialize(true);

	int rowspan1 = Integer.parseInt(subSum1.getString("rowspan",0)) + 1;
	int rowspan2 = Integer.parseInt(subSum2.getString("rowspan",0)) + 1;
	int rowspan3 = Integer.parseInt(subSum3.getString("rowspan",0)) + 1;

	
	subSumHtml1.append("<tr>");
	subSumHtml1.append("<th class=\"bl0\" rowspan=\""+rowspan1+"\">소양분야</th> ");
	subSumHtml1.append("<td>소계</td>");
	subSumHtml1.append("<td>"+emptyToZeroString(subSum1.getString("sub1",0))+"</td>");
	subSumHtml1.append("<td>"+emptyToZeroString(subSum1.getString("sub2",0))+"</td>");
	subSumHtml1.append("<td>"+emptyToZeroString(subSum1.getString("sub3",0))+"</td>");
	subSumHtml1.append("<td>"+emptyToZeroString(subSum1.getString("sub4",0))+"</td>");
	subSumHtml1.append("</tr>");
	
	for(int i=0; i<detail.keySize("annaeTitle");i++) {
		if(detail.getString("annaeGubun",i).equals("1") ) {
			subDetail1.append("<tr> ");
			subDetail1.append("<td class=\"sbj\">"+emptyToZeroString(detail.getString("annaeTitle",i))+"</td> ");
			subDetail1.append("<td>"+emptyToZeroString(detail.getString("title1Sub1",i))+"</td> ");
			subDetail1.append("<td>"+emptyToZeroString(detail.getString("title1Sub2",i))+"</td> ");
			subDetail1.append("<td>"+emptyToZeroString(detail.getString("title1Sub3",i))+"</td> ");
			subDetail1.append("<td>"+emptyToZeroString(detail.getString("title1Sub4",i))+"</td> ");
			subDetail1.append("</tr>	");	
		}	
	}
	
	subSumHtml2.append("<tr>");
	subSumHtml2.append("<th class=\"bl0\" rowspan=\""+rowspan2+"\">직무분야</th> ");
	subSumHtml2.append("<td>소계</td>");
	subSumHtml2.append("<td>"+emptyToZeroString(subSum2.getString("sub1",0))+"</td>");
	subSumHtml2.append("<td>"+emptyToZeroString(subSum2.getString("sub2",0))+"</td>");
	subSumHtml2.append("<td>"+emptyToZeroString(subSum2.getString("sub3",0))+"</td>");
	subSumHtml2.append("<td>"+emptyToZeroString(subSum2.getString("sub4",0))+"</td>");
	subSumHtml2.append("</tr>");
	
	for(int i=0; i<detail.keySize("annaeTitle");i++) {
		if(detail.getString("annaeGubun",i).equals("2") ) {
			subDetail2.append("<tr> ");
			subDetail2.append("<td class=\"sbj\">"+emptyToZeroString(detail.getString("annaeTitle",i))+"</td> ");
			subDetail2.append("<td>"+emptyToZeroString(detail.getString("title1Sub1",i))+"</td> ");
			subDetail2.append("<td>"+emptyToZeroString(detail.getString("title1Sub2",i))+"</td> ");
			subDetail2.append("<td>"+emptyToZeroString(detail.getString("title1Sub3",i))+"</td> ");
			subDetail2.append("<td>"+emptyToZeroString(detail.getString("title1Sub4",i))+"</td> ");
			subDetail2.append("</tr>	");	
		}	
	}	
	
	subSumHtml3.append("<tr>");
	subSumHtml3.append("<th class=\"bl0\" rowspan=\""+rowspan3+"\">행정기타</th> ");
	subSumHtml3.append("<td>소계</td>");
	subSumHtml3.append("<td>"+emptyToZeroString(subSum3.getString("sub1",0))+"</td>");
	subSumHtml3.append("<td>"+emptyToZeroString(subSum3.getString("sub2",0))+"</td>");
	subSumHtml3.append("<td>"+emptyToZeroString(subSum3.getString("sub3",0))+"</td>");
	subSumHtml3.append("<td>"+emptyToZeroString(subSum3.getString("sub4",0))+"</td>");
	subSumHtml3.append("</tr>");	
	
	for(int i=0; i<detail.keySize("annaeTitle");i++) {
		if(detail.getString("annaeGubun",i).equals("3") ) {
			subDetail3.append("<tr> ");
			subDetail3.append("<td class=\"sbj\">"+emptyToZeroString(detail.getString("annaeTitle",i))+"</td> ");
			subDetail3.append("<td>"+emptyToZeroString(detail.getString("title1Sub1",i))+"</td> ");
			subDetail3.append("<td>"+emptyToZeroString(detail.getString("title1Sub2",i))+"</td> ");
			subDetail3.append("<td>"+emptyToZeroString(detail.getString("title1Sub3",i))+"</td> ");
			subDetail3.append("<td>"+emptyToZeroString(detail.getString("title1Sub4",i))+"</td> ");
			subDetail3.append("</tr>	");	
		}	
	}	
%>



<!-- popup size 603x889 -->
<body>
<div class="top">
	<h1 class="h1"><%=popupMap1.getString("grcodenm",0) %><span class="txt_gray"><%=year %></span></h1>
</div>
<div class="contents">
	<!-- data -->
	<table class="dataW02">
		<tr>
			<th width="83" class="bl0">과정분류</th>
			<td width="196"><%=popupMap1.getString("mcodeName",0) %>교육</td>
			<th width="83">상세분류</th>
			<td width="196"><%=popupMap1.getString("scodeName",0) %>교육</td>
		</tr>
		<tr>
			<th width="83" class="bl0">과정명</th>
			<td colspan="3"><%=popupMap1.getString("grcodenm",0) %></td>
		</tr>
		<tr>
			<th width="83" class="bl0">교육목표</th>
			<td colspan="3">
				<%=Util.N2Br(popupMap2.getString("goal",0)) %>
			</td>
		</tr>
		<tr>
			<th width="83" class="bl0">교육대상</th>
			<td colspan="3"><%=Util.N2Br(popupMap2.getString("target",0)) %></td>
		</tr>
		<tr>
			<th width="83" class="bl0">교육인원</th>
			<td colspan="3">
				<%// 이전소스 Util.N2Br(popupMap2.getString("inwon",0)) %>
				<%
					//개설된 차수의 교육인원
					for(int i=0; i < grSeqMap.keySize("grseq"); i++) {
						if(grSeqMap.getString("sdate",i).length() == 0){ 
							continue;
						}
						if(year.equals(grSeqMap.getString("sdate",i).substring(0, 4))) { 
							out.print("&nbsp;&nbsp;제 "+grSeqMap.getInt("grseq",i)+" 기 "+grSeqMap.getString("tseat",i)+" 명<br>");
						}
					}
				%>
			</td>
		</tr>
		<tr>
			<th width="83" class="bl0">교육기간</th>
			<td colspan="3">
				<%// 이전 소스 Util.N2Br(popupMap2.getString("gigan",0)) %>
				<%
					//개설된 차수의 교육기간
					for(int i=0; i < grSeqMap.keySize("grseq"); i++) {
						if(grSeqMap.getString("sdate",i).length() == 0){ 
							continue;
						}
						if(year.equals(grSeqMap.getString("sdate",i).substring(0, 4))) {
							out.print("&nbsp;&nbsp;제 "+grSeqMap.getInt("grseq",i)+" 기 "+grSeqMap.getString("sdate",i)+" ~ "+grSeqMap.getString("edate",i)+"<br>");
						}
					}
				%>
			</td>
		</tr>
		<tr>
			<th width="83" class="bl0">교육운영</th>
			<td colspan="3"><%=Util.N2Br(popupMap2.getString("yunyoung",0)) %></td>
		</tr>
		<tr>
			<th width="83" class="bl0">교육편성</th>
			<td class="outDate" colspan="3">
			<!-- inData -->
			<table class="inData">
				<tr>
					<th class="bl0" rowspan="2">구분</th>
					<th class="in" rowspan="2">계</th>
					<th class="in" rowspan="2">소양분야</th>
					<th class="in" colspan="3">직무분야</th>
					<th class="in" rowspan="2">행정및기타</th>
				</tr>
				<tr>
					<th class="in">소계</th>
					<th class="in">직무공통</th>
					<th class="in">직무전문</th>
				</tr>
				<tr>
					<td class="bl0">시간</td>
					<td class="in"><%=popupMap2.getString("sigange",0) %></td>
					<td class="in"><%=popupMap2.getString("sibunya",0) %></td>
					<td class="in"><%=popupMap2.getString("sisoge",0) %></td>
					<td class="in"><%=popupMap2.getString("sicommon",0) %></td>
					<td class="in"><%=popupMap2.getString("sijunmun",0) %></td>
					<td class="in"><%=popupMap2.getString("sietc",0) %></td>
				</tr>
				<tr>
					<td class="bl0">비율</td>
					<td class="in"><%=popupMap2.getString("rategange",0) %></td>
					<td class="in"><%=popupMap2.getString("ratebunya",0) %></td>
					<td class="in"><%=popupMap2.getString("ratesoge",0) %></td>
					<td class="in"><%=popupMap2.getString("ratecommon",0) %></td>
					<td class="in"><%=popupMap2.getString("ratejunmun",0) %></td>
					<td class="in"><%=popupMap2.getString("rateetc",0) %></td>
				</tr>
			</table>
			<!-- //inData -->
			</td>
		</tr>
	</table>
	<!-- //data -->
	<div class="space01"></div>

	<!-- data -->
	<table class="dataH03">	
	<colgroup>
		<col width="70" />
		<col width="*" />
		<col width="69" />
		<col width="69" />
		<col width="69" />
		<col width="47" />
	</colgroup>

	<thead>
	<tr>
		<th class="bl0" rowspan="2">구분</th>
		<th rowspan="2">과목</th>
		<th colspan="3">시간</th>
		<th rowspan="2">비고</th>
	</tr>
	<tr>
		<th>계</th>
		<th>강의</th>
		<th>참여식</th>
	</tr>
	</thead>

	<tbody>
	<tr>
		<td class="bl0" colspan="2">합계</td>
		<%=sumHtml %>
	</tr>
	<%=subSumHtml1 %>
	<%=subDetail1 %>
	<%=subSumHtml2 %>
	<%=subDetail2 %>
	<%=subSumHtml3 %>
	<%=subDetail3%>
	</tbody>
	</table>
	<!-- //data -->

	<!-- button -->
	<div class="btnC">
		<a href="javascript:window.close();"><img src="/images/skin1/button/btn_submit03.gif" alt="확인" /></a>		
	</div>	
	<!-- //button -->
</div>
</body>
</html>
