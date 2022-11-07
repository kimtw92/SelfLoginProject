<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%
// prgnm : 과정과제물평가출제 리스트
// date : 2008-07-22
// auth : 정 윤철
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
	
	//로그인된 사용자 정보
	LoginInfo memberInfo = (LoginInfo)request.getAttribute("LOGIN_INFO");
	
	//각 셀렉박스에대한 구분 변수
	String qu = requestMap.getString("qu");
	//과정명 옵션박스 
	StringBuffer grcodeSelectBox = new StringBuffer();
	if(qu.equals("grcode")){//과정명
		grcodeSelectBox.append("<select name=\"grcode\" onchange=\"clearAjax('2')\" class=\"mr10\">");
		grcodeSelectBox.append("<option value=\"\" selected> **선택하세요** </option>");
		if(listMap.keySize("code") > 0 ){
			for(int i=0; i < listMap.keySize("code"); i++){
				grcodeSelectBox.append("<option value=\""+listMap.getString("code", i)+"\">"+listMap.getString("codenm",i) +"</option>");

			}	
		}else{
			grcodeSelectBox.append("<option value=\"\">과정명 없습니다.</option>");
		}		
		
		grcodeSelectBox.append("</select>");
	}else if(qu.equals("grseq")){//기수명
		grcodeSelectBox.append("<select name=\"grseq\" onchange=\"clearAjax('3')\" class=\"mr10\">");
		grcodeSelectBox.append("<option value=\"\" selected> **선택하세요** </option>");
		
		if(listMap.keySize("code") > 0 ){
			for(int i=0; i < listMap.keySize("code"); i++){
				grcodeSelectBox.append("<option value=\""+listMap.getString("code", i)+"\">"+listMap.getString("codenm",i) +"</option>");
		
			}	

		}else{
			grcodeSelectBox.append("<option value=\"\">기수명이 없습니다.</option>");
		}		
		
		grcodeSelectBox.append("</select>");
	}else if(qu.equals("classno")){//반
		grcodeSelectBox.append("<select name=\"classno\" onchange=\"createSubSelectBox('end')\" class=\"mr10\">");
		grcodeSelectBox.append("<option value=\"\" selected> **선택하세요** </option>");
		if(listMap.keySize("classno") > 0 ){

			for(int i=0; i < listMap.keySize("classno"); i++){
				grcodeSelectBox.append("<option value=\""+listMap.getString("classno", i)+"\">"+listMap.getString("classnm",i) +"</option>");

			}	
		}else{
			grcodeSelectBox.append("<option value=\"\">반이 없습니다.</option>");
		}				
		
		grcodeSelectBox.append("</select>");
		
	}else if(qu.equals("subj")){//과목명
		grcodeSelectBox.append("<select name=\"subj\" onchange=\"clearAjax('4')\" class=\"mr10\">");
		grcodeSelectBox.append("<option value=\"\" selected> **선택하세요** </option>");

		if(listMap.keySize("code") > 0 ){

			for(int i=0; i < listMap.keySize("code"); i++){
				grcodeSelectBox.append("<option value=\""+listMap.getString("code", i)+"\">"+listMap.getString("codenm",i) +"</option>");

			}	
		}else{
			grcodeSelectBox.append("<option value=\"\">과목명이  없습니다.</option>");
		}				
		
		grcodeSelectBox.append("</select>");
		
	}else if(qu.equals("end")){
		
		//과정운영자만 전체를 보고 다른 운영자는 평가 엑셀 과제물범위를 볼 수 없다.
		String displayNone = "display:none";
		
		grcodeSelectBox.append("\n	<table class=\"datah01\">");
		grcodeSelectBox.append("\n	<thead>");
		grcodeSelectBox.append("\n		<tr>");
		grcodeSelectBox.append("\n			<th>선택</th>");
		grcodeSelectBox.append("\n			<th>회차</th>");
		grcodeSelectBox.append("\n			<th width=\"40%\">제목</th>");
		
		grcodeSelectBox.append("\n			<th>첨부</th>");
		grcodeSelectBox.append("\n			<th>평가<br />등급</th>");
		grcodeSelectBox.append("\n			<th style=\""+displayNone+"\">평가</th>");
		grcodeSelectBox.append("\n			<th style=\""+displayNone+"\">EXCEL</th>");
		grcodeSelectBox.append("\n			<th class=\"br0\">배점</th>");
		grcodeSelectBox.append("\n			<th style=\""+displayNone+"\">과제물 범위</th>");
		
		
		grcodeSelectBox.append("\n		</tr>");
		grcodeSelectBox.append("\n	</thead>");
		grcodeSelectBox.append("\n	<tbody>");
		if(listMap.keySize("grcode") > 0){
			for(int i =0; listMap.keySize("grcode") > i; i++){
				
				grcodeSelectBox.append("\n	<tr>");
				grcodeSelectBox.append("\n	<td><input type=\"checkBox\" name=\"chk\" id=\"chk_"+i+"\" value=\""+listMap.getString("dates", i)+"\"</td>");
				grcodeSelectBox.append("\n	<td>"+listMap.getString("dates", i)+"회</td>");
				grcodeSelectBox.append("\n	<td><a href=\"javaScript:go_form('modify', '"+listMap.getString("dates", i)+"')\">"+listMap.getString("title", i)+"</a></td>");
				grcodeSelectBox.append("\n	<td class=\"tableline11\">"+(!listMap.getString("groupfileNo",i).equals("-1") ? 
											"<a href='javascript:fileDownloadPopup("+listMap.getString("groupfileNo", i)+");'><img src=/images/compressed.gif border=0 valign='middle'></a>" : 
											"&nbsp;" ) +"</td>");
				grcodeSelectBox.append("\n	<td><input type=\"button\" class=\"boardbtn1\" value=\"설정\" onclick=\"go_gardePop('"+listMap.getString("dates", i)+"')\"</td>");
				grcodeSelectBox.append("\n	<td style=\""+displayNone+"\"><input type=\"button\" class=\"boardbtn1\" value=\"평가\" onclick=\"go_parity('"+listMap.getString("dates", i)+"')\"</td>");
				grcodeSelectBox.append("\n	<td style=\""+displayNone+"\"><input type=\"button\" class=\"boardbtn1\" value=\"EXCEL출력\" onclick=\"go_Excel('"+listMap.getString("dates", i)+"')\"</td>");
			
				grcodeSelectBox.append("\n	<td class=\"br0\">"+listMap.getString("point", i)+"&nbsp</td>");
				grcodeSelectBox.append("\n	<td style=\""+displayNone+"\" class=\"br0\">"+listMap.getString("rpartf", i)+"차시~"+listMap.getString("rpartt", i)+"차시</td>");
				
				grcodeSelectBox.append("\n	</tr>");	
			}
			grcodeSelectBox.append("\n	</tbody>");
		}else{
			grcodeSelectBox.append("\n	<tr>");
			grcodeSelectBox.append("\n	<td style=\"height:100px;\" colspan=\"100%\" class=\"br0\"> 등록된 데이터가 없습니다. </td>");
			grcodeSelectBox.append("\n	</tr>");
		}
		grcodeSelectBox.append("\n	</table>");
	}

	

%>

<%=grcodeSelectBox.toString()%>
