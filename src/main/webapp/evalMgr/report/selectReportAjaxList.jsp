<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%
// prgnm : 과정과제물평가출제 리스트
// date : 2008-07-22
// auth : 정 윤철(09-1 CHJ수정)
%>

<!-- [s] commonImport -->
<%@ include file="/commonInc/include/commonImport.jsp" %>
<!-- [e] commonImport -->

<%

	//request
	DataMap requestMap = (DataMap)request.getAttribute("REQUEST_DATA");
	requestMap.setNullToInitialize(true);
	
	//각 셀렉박스 데이터
	DataMap listMap = (DataMap)request.getAttribute("LIST_DATA");
	listMap.setNullToInitialize(true);

	//각 셀렉박스에대한 구분 변수
	String qu = requestMap.getString("qu");
	//과정명 옵션박스 
	StringBuffer grcodeSelectBox = new StringBuffer();
	
	if(qu.equals("year")){		
		grcodeSelectBox.append("<select name=\"commYear\" onchange=\"createSubSelectBox('grcode')\" class=\"mr10\">");
		grcodeSelectBox.append("<option value=\"\" selected> **선택하세요** </option>");
		if(listMap.keySize("year") > 0){
			for(int i=0; i < listMap.keySize("year"); i++){
				grcodeSelectBox.append("<option value=\""+listMap.getString("year", i)+"\" >"+listMap.getString("year",i) +"</option>");
			}	
		}
		grcodeSelectBox.append("</select>");
		
	}else if(qu.equals("grcode")){//과정명
		grcodeSelectBox.append("<select name=\"commGrcode\" onchange=\"createSubSelectBox('grseq')\" class=\"mr10\">");
		grcodeSelectBox.append("<option value=\"\" selected> **선택하세요** </option>");
		if(listMap.keySize("grcode") > 0 ){
			for(int i=0; i < listMap.keySize("grcode"); i++){
				grcodeSelectBox.append("<option value=\""+listMap.getString("grcode", i)+"\">"+listMap.getString("grcodenm",i) +"</option>");
			}	
		}
		grcodeSelectBox.append("</select>");
	}else if(qu.equals("grseq")){//기수명
		grcodeSelectBox.append("<select name=\"commGrseq\" onchange=\"createSubSelectBox('classno')\" class=\"mr10\">");
		grcodeSelectBox.append("<option value=\"\" selected> **선택하세요** </option>");
		
		if(listMap.keySize("grseq") > 0 ){
			for(int i=0; i < listMap.keySize("grseq"); i++){
				grcodeSelectBox.append("<option value=\""+listMap.getString("grseq", i)+"\">"+listMap.getString("grseqnm",i) +"</option>");
			}	
		}
		
		grcodeSelectBox.append("</select>");
	}else if(qu.equals("classno")){//반
		grcodeSelectBox.append("<select name=\"classno\" onchange=\"createSubSelectBox('end')\" class=\"mr10\">");
		grcodeSelectBox.append("<option value=\"\" selected> **선택하세요** </option>");
		if(listMap.keySize("classno") > 0 ){
			for(int i=0; i < listMap.keySize("classno"); i++){
				grcodeSelectBox.append("<option value=\""+listMap.getString("classno", i)+"\">"+listMap.getString("classnm",i) +"</option>");
			}	
		}		
		grcodeSelectBox.append("</select>");
		
	}else if(qu.equals("end")){
		grcodeSelectBox.append("\n	<table class=\"datah01\">");
		grcodeSelectBox.append("\n	<thead>");
		grcodeSelectBox.append("\n		<tr>");
		grcodeSelectBox.append("\n			<th>회차</th>");
		grcodeSelectBox.append("\n			<th width=\"40%\">제목</th>");
		grcodeSelectBox.append("\n			<th>과제물 범위</th>");
		grcodeSelectBox.append("\n			<th>배점</th>");
		grcodeSelectBox.append("\n			<th width=\"10%\">출제여부</th>");
		grcodeSelectBox.append("\n			<th>비고</th>");
		grcodeSelectBox.append("\n		</tr>");
		grcodeSelectBox.append("\n	</thead>");
		grcodeSelectBox.append("\n	<tbody>");
		
		if(listMap.keySize("title") > 0){
			for(int i =0; listMap.keySize("grcode") > i; i++){
				grcodeSelectBox.append("\n	<tr>");
				grcodeSelectBox.append("\n	<td>"+(i+1)+"회</td>");
				grcodeSelectBox.append("\n	<td>"+listMap.getString("title",i)+"</td>");
				grcodeSelectBox.append("\n	<td>");
				if(!listMap.getString("rpartf",i).equals("")){
					grcodeSelectBox.append(listMap.getString("rpartf",i)+"차시~"); 
				}
				if(!listMap.getString("rpartt",i).equals("")){
					grcodeSelectBox.append(listMap.getString("rpartt",i)+"차시"); 
				}
				grcodeSelectBox.append("</td>");
				grcodeSelectBox.append("\n	<td>"+listMap.getString("point",i)+"</td>");
				if(!listMap.getString("subj",i).equals("")){
					grcodeSelectBox.append("\n	<td>출제완료</td>");
				}else{
					grcodeSelectBox.append("\n	<td>미출제</td>");
				}
				grcodeSelectBox.append("\n	<td><input type=\"button\" value=\"문자 보내기\" class=\"boardbtn1\" onClick=\"javascript:send_sms('"+listMap.getString("subj",i)+"', '"+listMap.getString("grcode",i)+"', '"+listMap.getString("grseq",i)+"', '"+listMap.getString("classno",i)+"', '"+listMap.getString("dates",i)+"');\"></td>");
				grcodeSelectBox.append("\n	</tr>");	
			}
		}else{
			grcodeSelectBox.append("\n	<tr>");
			grcodeSelectBox.append("\n	<td style=\"height:100px;\" colspan=\"100%\" class=\"br0\"> 등록된 데이터가 없습니다. </td>");
			grcodeSelectBox.append("\n	</tr>");
		}
		grcodeSelectBox.append("\n	</tbody>");
		grcodeSelectBox.append("\n	</table>");
	}

	

%>

<%=grcodeSelectBox.toString()%>
