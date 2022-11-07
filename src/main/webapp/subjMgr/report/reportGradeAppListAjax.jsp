<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%
// prgnm : 과목과제물평과 관리 리스트 AJAX
// date : 2008-07-29
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
			grcodeSelectBox.append("<option value=\"\">과정명이 없습니다.</option>");
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
			grcodeSelectBox.append("<option value=\"\">기수가 없습니다.</option>");
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
		
	}else if(qu.equals("end")){
		grcodeSelectBox.append("\n	<table class=\"datah01\">");
		grcodeSelectBox.append("\n	<thead>");
		grcodeSelectBox.append("\n		<tr>");
		grcodeSelectBox.append("\n			<th>회차</th>");
		grcodeSelectBox.append("\n			<th width=\"40%\">제목</th>");
		grcodeSelectBox.append("\n			<th>과제물 범위</th>");
		grcodeSelectBox.append("\n			<th>첨부</th>");
		grcodeSelectBox.append("\n			<th>평가<br />등급</th>");
		grcodeSelectBox.append("\n			<th>배점</th>");
		grcodeSelectBox.append("\n			<th>출제여부</th>");
		grcodeSelectBox.append("\n			<th class=\"br0\">기능</th>");
		grcodeSelectBox.append("\n		</tr>");
		grcodeSelectBox.append("\n	</thead>");
		grcodeSelectBox.append("\n	<tbody>");
		if(!requestMap.getString("year").equals("") && !requestMap.getString("classno").equals("") && !requestMap.getString("grcode").equals("") && !requestMap.getString("grseq").equals("")){
			if(listMap.keySize("grcode") > 0){
				for(int i =0; listMap.keySize("grcode") > i; i++){
					
					grcodeSelectBox.append("\n	<tr>");
					grcodeSelectBox.append("\n	<td>"+listMap.getString("dates", i)+"회</td>");
					grcodeSelectBox.append("\n	<td><a href=\"javaScript:go_form('modify', '"+listMap.getString("dates", i)+"')\">"+listMap.getString("title", i)+"</a></td>");
					grcodeSelectBox.append("\n	<td>"+listMap.getString("rpartf", i)+"차시~차시"+listMap.getString("rpartt", i)+"</td>");
					grcodeSelectBox.append("\n	<td class=\"tableline11\">"+(!listMap.getString("groupfileNo",i).equals("-1") ? 
												"<a href='javascript:fileDownloadPopup("+listMap.getString("groupfileNo", i)+");'><img src=/images/compressed.gif border=0 valign='middle'></a>" : 
												"&nbsp;" ) +"</td>");
					grcodeSelectBox.append("\n	<td><input type=\"button\" class=\"boardbtn1\" value=\"설정\" onclick=\"go_gardePop('"+listMap.getString("dates", i)+"')\"</td>");
					grcodeSelectBox.append("\n	<td>"+listMap.getString("point", i)+"</td>");
					grcodeSelectBox.append("\n	<td>");
					
					if(i < requestMap.getInt("cnt")){
						if(!listMap.getString("subj", i).equals("")){
							grcodeSelectBox.append("출제완료");
							
						}else{
							grcodeSelectBox.append("미출제");						
							
						}
					}
					
					grcodeSelectBox.append("\n	</td>");
					
					if(i < requestMap.getInt("cnt")){
						if(!listMap.getString("subj", i).equals("")){
							grcodeSelectBox.append("\n	<td class=\"br0\"><input type=\"button\" class=\"boardbtn1\" value=\"평가하기\" onclick=\"go_parity('"+listMap.getString("dates", i)+"')\"</td>");
							
						}else{
							grcodeSelectBox.append("\n	<td class=\"br0\"><input type=\"button\" class=\"boardbtn1\" value=\"출제하기\" onclick=\"go_parity('"+listMap.getString("dates", i)+"')\"</td>");
							
						}
					}else{
						grcodeSelectBox.append("\n	<td class=\"br0\">&nbsp;</td>");
					}
					
					grcodeSelectBox.append("\n	</tr>");	
				}
				grcodeSelectBox.append("\n	</tbody>");
			}else{
				grcodeSelectBox.append("\n	<tr>");
				grcodeSelectBox.append("\n	<td style=\"height:100px;\" class=\"br0\" colspan=\"100%\"> 평가담당자가 평가배점관리 >> 평가항목관리에서 과제물 출제회수을 입력하셔야 과목과제물을 등록할수 있습니다. </td>");
				grcodeSelectBox.append("\n	</tr>");
			}
		}else{
			grcodeSelectBox.append("\n	<tr>");
			grcodeSelectBox.append("\n	<td style=\"height:100px;\" class=\"br0\" colspan=\"100%\">검색 하여 주십시오.</td>");
			grcodeSelectBox.append("\n	</tr>");			
		}
			grcodeSelectBox.append("\n	</table>");
		
	}else if(qu.equals("subj")){
		grcodeSelectBox.append("\n	<input type=\"hidden\" name=\"subj\" value=\""+listMap.getString("code")+"\">");
	}

	

%>

<%=grcodeSelectBox.toString()%>
