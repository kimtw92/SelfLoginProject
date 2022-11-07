<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%  
//prgnm : 외래강사 수당관리 강사별 수당내역 엑셀
//date  : 2008-07-21
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
	
	String userno = "";
	int rowCnt = 1;
	int gmoney = 0;
	int pmoney = 0;
	int tmoney = 0;
	int cmoney = 0;
	
	StringBuffer html = new StringBuffer();
	
	if(listMap.keySize("userno") > 0){
		for(int i=0; listMap.keySize("userno") > i; i++){
			
			String sTime = "";
			String eTime = "";
			String totalTime = "";
			if(listMap.getInt("totime",i) == (listMap.getInt("maxStudytime",i) - listMap.getInt("minStudytime",i)+1)){
				if(listMap.getInt("minStudytime",i) == 1){
					sTime = "09:00";
					
				}else if(listMap.getInt("minStudytime",i) == 2){
					sTime = "10:00";
					
				}else if(listMap.getInt("minStudytime",i) == 3){
					sTime = "11:00";
					
				}else if(listMap.getInt("minStudytime",i) == 4){
					sTime = "12:00";
					
				}else if(listMap.getInt("minStudytime",i) == 5){
					sTime = "13:00";
					
				}else if(listMap.getInt("minStudytime",i) == 6){
					sTime = "14:00";
					
				}else if(listMap.getInt("minStudytime",i) == 7){
					sTime = "15:00";
					
				}else if(listMap.getInt("minStudytime",i) == 8){
					sTime = "16:00";
					
				}else if(listMap.getInt("minStudytime",i) == 9){
					sTime = "17:00";
					
				}
				
				if(listMap.getInt("maxStudytime",i) == 1){
					eTime = "09:50";
					
				}else if(listMap.getInt("maxStudytime",i) == 2){
					eTime = "10:50";
					
				}else if(listMap.getInt("maxStudytime",i) == 3){
					eTime = "11:50";
					
				}else if(listMap.getInt("maxStudytime",i) == 4){
					eTime = "12:50";
					
				}else if(listMap.getInt("maxStudytime",i) == 5){
					eTime = "13:50";
					
				}else if(listMap.getInt("maxStudytime",i) == 6){
					eTime = "14:50";
					
				}else if(listMap.getInt("maxStudytime",i) == 7){
					eTime = "15:50";
					
				}else if(listMap.getInt("maxStudytime",i) == 8){
					eTime = "16:50";
					
				}else if(listMap.getInt("maxStudytime",i) == 9){
					eTime = "17:50";
					
				}
			}
			
			if(sTime.equals("")){
				totalTime = "-";
			}else{
				totalTime = sTime+"~"+eTime;
			}
			
			
			html.append("\n	<tr>");
			
			for(int j = i+1; listMap.keySize("userno") > j; j++){
				if(listMap.getString("userno", i).equals(listMap.getString("userno", j))){
					rowCnt++;
			
				}else{
					break;
					
				}
			}
			
			for(int j = i; listMap.keySize("userno") > j; j++){
				if(listMap.getString("userno", i).equals(listMap.getString("userno", j))){
					gmoney += listMap.getInt("gmoney",j);
					pmoney += listMap.getInt("pmoney",j);
					tmoney += listMap.getInt("tmoney",j);
					cmoney += listMap.getInt("cmoney",j);
			
				}else{
					break;
					
				}
			}
			
			if(!userno.equals(listMap.getString("userno", i))){				
				html.append("\n	<td align=\"center\" rowSpan=\""+rowCnt+"\">"+listMap.getString("name",i)+"&nbsp;</td>");
				html.append("\n	<td align=\"center\" rowSpan=\""+rowCnt+"\">"+listMap.getString("resno",i)+"&nbsp;</td>");
				html.append("\n	<td align=\"center\" rowSpan=\""+rowCnt+"\">"+listMap.getString("tposition",i)+"<br>"+listMap.getString("jikwi", i)+"<br>"+listMap.getString("homeTel", i)+"&nbsp;</td>");
			
			}
			
				
			html.append("\n	<td align=\"center\">"+listMap.getString("grcodenm",i)+"<br>"+listMap.getString("lecnm", i)+"&nbsp;</td>");
			
			if(listMap.getInt("amtGubun", i) <= 2){
				html.append("\n	<td align=\"center\">"+listMap.getString("lecturedate",i)+"&nbsp;</td>");
				html.append("\n	<td align=\"center\">"+listMap.getString("lecturetime",i)+"&nbsp;</td>");
				html.append("\n	<td align=\"center\">"+totalTime+"</td>");
				
			}else{
				html.append("\n	<td align=\"center\">&nbsp;</td>");
				html.append("\n	<td align=\"center\">&nbsp;</td>");
				html.append("\n	<td align=\"center\">&nbsp;</td>");
				
			}
			
			if(!userno.equals(listMap.getString("userno" , i))){					
				html.append("\n	<td align=\"center\" rowSpan=\""+rowCnt+"\">"+gmoney+"&nbsp;</td>");
				html.append("\n	<td align=\"center\" rowSpan=\""+rowCnt+"\">"+pmoney+"&nbsp;</td>");
				html.append("\n	<td align=\"center\" rowSpan=\""+rowCnt+"\">"+tmoney+"&nbsp;</td>");
				html.append("\n	<td align=\"center\" rowSpan=\""+rowCnt+"\">"+cmoney+"&nbsp;</td>");
				html.append("\n	<td align=\"center\" rowSpan=\""+rowCnt+"\" class=\"br0\">"+listMap.getString("levelName",i)+"&nbsp;</td>");
			}	
			
			html.append("\n	</tr>");
			
			rowCnt = 1;
			gmoney = 0;
			pmoney = 0;
			tmoney = 0;
			cmoney = 0;
			
			userno = listMap.getString("userno", i);
		}
	}else{
		html.append("<tr>");
		html.append("<td align=\"center\" colspan=\"100%\" style=\"height:100px\">등록된 강사 등급이 없습니다.</td>");
		html.append("</tr>");		
	}
	
%>

<%
String toToYear = requestMap.getString("sDate")+"_"+requestMap.getString("eDate")+"_강사별수당내역";
//String excel_filename = new String(	toToYear.getBytes(), "ISO-8859-1");
// String excel_filename = java.net.URLEncoder.encode(toToYear, "ISO-8859-1");
	WebUtils.setFileHeader(request, response, toToYear+".xls", "UTF-8", "UTF-8");
response.setHeader("Content-Description", "JSP Generated Data"); 
response.setContentType( "application/vnd.ms-excel" );
request.setCharacterEncoding("UTF-8");
%>
<meta http-equiv="Content-Type" content="application/vnd.ms-excel; charset=UTF-8">
<table width="1200" border="1" cellpadding="0" cellspacing="0" bordercolordark="#ffffff" bordercolorlight="#000000">
	<thead>
	<tr>
		<th rowspan="2">성명</th>
		<th rowspan="2">주민번호</th>
		<th rowspan="2">소속 및 직위(연락처)</th>
		<th colspan="8">구분</th>
		<th class="br0" rowspan="2">강사등급</th>
	</tr>
	<tr>
		<th>과정명/과목</th>
		<th>강의일자</th>
		<th>강의교시</th>
		<th>강의시간</th>
		<th>강사료</th>
		<th>원고료</th>
		<th>출제수당</th>
		<th>사이버강사료</th>
	</tr>
	</thead>
	
	<tbody>
	<%=html.toString() %>
	</tbody>

</table>
