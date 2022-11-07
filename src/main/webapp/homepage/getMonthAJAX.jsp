<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commonInc/include/commonImport.jsp" %>

<%
// date	: 2008-08-26
// auth 	: 양정환
%>

<%
	DataMap requestMap = (DataMap)request.getAttribute("MONTH_AJAX_LIST");
	requestMap.setNullToInitialize(true);
	
	StringBuffer monthListHtml = new StringBuffer();

// 	monthListHtml.append("<div id='mex' class='montabcontent'>");
	monthListHtml.append("<ul>");
	if(requestMap.keySize("grcodeniknm") > 0){		
		for(int i=0; i < requestMap.keySize("grcodeniknm"); i++){

			String grcode = requestMap.getString("grcode", i); 
			String gubun = requestMap.getString("gubun", i);		
			String checklist = "";
			
			if(checklist.indexOf(grcode) != -1) {
				if("10G0000091".equals(grcode))  {
					gubun = "기본";
				} else {
					gubun = "혼합";
				}
			}

			if("전문".equals(gubun) || "시책".equals(gubun) || "리더십역량".equals(gubun) || "국정가치".equals(gubun)) {
				gubun = "집합";
			}else{
				gubun = "집합";
			}

			String months = requestMap.getString("started", i).substring(5, 7);
			
			if("06".equals(months)){
				/* if("10G0000358".equals(grcode)){	// 가족사랑학습 1기
					gubun = "화상";
				} else if("10G0000312".equals(grcode)){	// 예술과 리더십
					gubun = "화상";
				} else if("10G0000324".equals(grcode)){	// 음악과 시간예술 과정
					gubun = "화상";
				} else if("10G0000359".equals(grcode)){	// 인구와 미래
					gubun = "화상";
				} else if("10G0000350".equals(grcode)){	// 공직자 맞춤형 커뮤니케이션 2기
					gubun = "화상+집합";
				} else {
					gubun = "화상";
				} */
				gubun = "화상";
			} else if("07".equals(months)){
				/* if("10G0000240".equals(grcode)){	// 행복한 인문학 과정
					gubun = "화상";
				} else if("10G0000345".equals(grcode)){	// 사회적 가치와 사회적 경제 이해
					gubun = "화상";
				} else if("10G0000294".equals(grcode)){	// 다문화사회의 이해과정
					gubun = "화상";
				} else if("10G0000155".equals(grcode)){	// 의회실무과정
					gubun = "화상";
				} else if("10G0000334".equals(grcode)){	// 예산회계 및 보조금 실무 과정
					gubun = "화상";
				} else if("10G0000242".equals(grcode)){	// 행정사 양성과정
					gubun = "화상";
				} else if("10G0000347".equals(grcode)){	// 시민과 함께하는 시정(민관협치)
					gubun = "화상";
				} else if("10G0000350".equals(grcode)){	// 공직자 맞춤형 커뮤니케이션(3기)
					gubun = "화상+집합";
				} */
				gubun = "화상";
			} else if("11".equals(months)){ // 임시...
				if("10G0000346".equals(grcode)){	// 인천특별시대 미래
					gubun = "화상";
				} else if("10G0000341".equals(grcode)){	// 자치분권과 마을공동체
					gubun = "화상";
				} else if("10G0000343".equals(grcode)){	// 시민소통 및 갈등관리
					gubun = "화상";
				} else if("10G0000344".equals(grcode)){	// 규제개혁과 적극행정
					gubun = "화상";
				} else if("10G0000270".equals(grcode)){	// 재난안전관리자 과정
					gubun = "화상";
				} else if("10G0000362".equals(grcode)){	// 그린뉴딜과 디지털세상의 이해
					gubun = "화상";
				} else if("10G0000255".equals(grcode)){	// 문화와 예술과정
					gubun = "화상";
				} else if("10G0000357".equals(grcode)){	// 극지의 이해과정
					gubun = "화상";
				} else if("10G0000165".equals(grcode)){	// 빅데이터 이해와 활용과정
					gubun = "화상";
				} else if("10G0000352".equals(grcode)){	// 5급 승진후보자 역량강화
					gubun = "화상";
				} else if("10G0000231".equals(grcode)){	// 신임인재양성과정
					gubun = "화상";
				} 
			} else if("02".equals(months)){
				gubun = "화상";
			} else if("03".equals(months)){
				gubun = "화상";
			} else if("04".equals(months)){
				if(!grcode.equals("10G0000381")){ // 4급 승진후보자 역량강화 이외에는 화상
					gubun = "화상";
				} 
			} else if("05".equals(months)){
				//if(!grcode.equals("10G0000252")){ // 행복한 제2막 인생도약 과정
					gubun = "화상";
				//} 
			} else if("08".equals(months)){
				gubun = "화상";
			} else if("09".equals(months)){
				gubun = "화상";
			} else if("10".equals(months)){
				gubun = "화상";
			}
			String title = requestMap.getString("grcodeniknm", i);			
			System.out.println("@@@@@@@@@@@@@@@@@@@@@@@@@    " + title);
			
			String subStrTitle = title;
			if(title.length() >= 25 )	subStrTitle = title.substring(0, 24) + "..."; 
			
// 			monthListHtml.append("<li>");
// 			monthListHtml.append("	<span class=\"tit\" style=\"text-align:left;\">[" + gubun + "]</span><a href=\"javascript:popWin('/homepage/course.do?mode=courseinfopopup&grcode="+requestMap.getString("grcode", i)+"&grseq="+requestMap.getString("grseq", i)+"','aaa','603','680','yes','yes')\" title=\""+title+"\">"+ subStrTitle +"</a>");
// 			monthListHtml.append("	<span class=\"data\">" + requestMap.getString("started", i) + "~"+requestMap.getString("enddate", i) +"</span>");
// 			monthListHtml.append("</li> \n");

			if(title.equals("test") || title.equals("M.TEST") || title.equals("외국어정예과정(영어) 선발") || title.equals("외국어정예과정(중국어) 선발 ")){						
			}else{
				monthListHtml.append("<li>");
				
				monthListHtml.append("<a href=\"javascript:popWin('/homepage/course.do?mode=courseinfopopup&grcode="+requestMap.getString("grcode", i)+"&grseq="+requestMap.getString("grseq", i)+"','aaa','603','680','yes','yes')\" title=\""+title+"\">" +"<font color='aqua;'>["+gubun+"]</font> &nbsp;&nbsp;"+subStrTitle+"</a><span style='padding-right: 23px;'>" + requestMap.getString("started", i) + "~"+requestMap.getString("enddate", i) +"</span>");
				
				//monthListHtml.append("<a href=\"javascript:popWin('/homepage/course.do?mode=courseinfopopup&grcode="+requestMap.getString("grcode", i)+"&grseq="+requestMap.getString("grseq", i)+"','aaa','603','680','yes','yes')\" title=\""+title+"\">" +"["+gubun+"]"+subStrTitle +requestMap.getString("started", i) + "~"+requestMap.getString("enddate", i)+"</a><span>" + requestMap.getString("started", i) + "~"+requestMap.getString("enddate", i) +"</span>");
				monthListHtml.append("</li> \n");		
			}
			
		}
	}else {
		monthListHtml.append("<li>해당월은 과정이 없습니다.</li>");
	}
	
	monthListHtml.append("</ul>");
// 	monthListHtml.append("</div>");

%>
<%= monthListHtml.toString()%>