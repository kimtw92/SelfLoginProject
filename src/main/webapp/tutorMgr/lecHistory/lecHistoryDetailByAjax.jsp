<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%  
// prgnm : 강의기록 상세 리스트 ajax
// date  : 2008-07-14
// auth  : kang
%>

<%@ include file="/commonInc/include/commonImport.jsp" %>

<%

	//필수 코딩 내용 //////////////////////////////////////////////////////////////////////
	
	//request 데이터
	DataMap requestMap = (DataMap)request.getAttribute("REQUEST_DATA");
	requestMap.setNullToInitialize(true);
		
	//로그인된 사용자 정보
	LoginInfo memberInfo = (LoginInfo)request.getAttribute("LOGIN_INFO");
	////////////////////////////////////////////////////////////////////////////////////

	String mode = requestMap.getString("mode");
	
	StringBuffer sbListHtml = new StringBuffer();
	
	DataMap listMap = (DataMap)request.getAttribute("LIST_MAP");
	if(listMap == null) listMap = new DataMap();
	listMap.setNullToInitialize(true);
	
	sbListHtml.append("<table cellspacing=\"0\" cellpadding=\"0\" border=\"0\" width=\"100%\" class=\"contentsTable\">");
	
	sbListHtml.append("	<tr>");
	sbListHtml.append("		<td>");
	sbListHtml.append("			<table class=\"datah01\">");
	sbListHtml.append("			<thead>");
	sbListHtml.append("				<tr>");
	sbListHtml.append("					<th>연번</th>");
	sbListHtml.append("					<th>연월일(기간)</th>");
	sbListHtml.append("					<th>과정명</th>");
	sbListHtml.append("					<th>강의과목</th>");
	sbListHtml.append("					<th>시간</th>");
	sbListHtml.append("					<th>교육인원</th>");
	sbListHtml.append("					<th>비고</th>");
	sbListHtml.append("					<th>수정</th>");
	sbListHtml.append("					<th class=\"br0\">삭제</th>");
	sbListHtml.append("				</tr>");
	sbListHtml.append("			</thead>");			
	
	
	if(listMap.keySize("grcode") > 0){		
		for(int i=0; i < listMap.keySize("grcode"); i++){
			
			sbListHtml.append("<tr>");
			sbListHtml.append("	<td >" + (i+1) + "</td>");
			sbListHtml.append("	<td >" + listMap.getString("strDate", i) + "~" + listMap.getString("endDate", i) + " (" + listMap.getString("tdate", i) +  ")</td>");
			sbListHtml.append("	<td >" + listMap.getString("grcodenm", i) + "</td>");
			sbListHtml.append("	<td >" + listMap.getString("lecnm", i) + "</td>");
			
			sbListHtml.append("	<td >" + listMap.getString("ttime", i) + "</td>");
			sbListHtml.append("	<td >" + listMap.getString("eduinwon", i) + "</td>");
			sbListHtml.append("	<td ></td>");
			
			sbListHtml.append("	<td >");			
			if( listMap.getInt("no", i) > 0){
				sbListHtml.append(" <a href=\"javascript:fnModifyForm('" + listMap.getString("tuserno", i) + "','" + listMap.getString("grcode", i) + "','" + listMap.getString("grseq", i) + "','" + listMap.getString("subj", i) + "','" + listMap.getInt("no", i) + "');\">수정</a>");
			}			
			sbListHtml.append("	</td>");
			
			sbListHtml.append("	<td class=\"br0\">");
			if( listMap.getInt("no", i) > 0){
				sbListHtml.append(" <a href=\"javascript:fnDelete('" + listMap.getString("no", i) + "','" + listMap.getString("tuserno", i) + "');\">삭제</a>");
			}	
			sbListHtml.append("	</td>");
						
			sbListHtml.append("</tr>");
		}
	}else{
		sbListHtml.append("<tr><td align=\"center\" style=\"height:100px\" colspan=\"100%\" class=\"br0\">등록된 내용이 없습니다.</td></tr>");
	}
	
	sbListHtml.append("			</table>");
	sbListHtml.append("		</td>");
	sbListHtml.append("	</tr>");
	sbListHtml.append("</table>");

%>
<%= sbListHtml.toString() %>

