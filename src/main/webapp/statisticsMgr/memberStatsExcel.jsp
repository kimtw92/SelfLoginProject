<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%  
// prgnm : 가입회원에 대한 통계 엑셀
// date : 2008-08-12
// auth : 정 윤철
%>

<!-- [s] commonImport -->
<%@ include file="/commonInc/include/commonImport.jsp" %>
<!-- [e] commonImport -->

<%
    //request 데이터
	DataMap requestMap = (DataMap)request.getAttribute("REQUEST_DATA");
	requestMap.setNullToInitialize(true);

	//리스트 데이터
	DataMap listMap = (DataMap)request.getAttribute("LIST_DATA");
	listMap.setNullToInitialize(true);
	
	//학력리스트  데이터
	DataMap educationMap = (DataMap)request.getAttribute("EDUCATION_LIST_DATA");
	listMap.setNullToInitialize(true);

	//필드 카운터수
	int fieldCount = requestMap.getInt("fieldCount");
	
	StringBuffer html = new StringBuffer();
	StringBuffer subMenu = new StringBuffer();
	//검색조건
	String searchType = requestMap.getString("searchType");
	//검색조건명
	String searchName = "";
	
	//월수가 1월~ 12월을 넘어가 다음년도가 될경우를 대비
	int tempCount = 0;
	if(fieldCount > 0){
		tempCount = Integer.parseInt(requestMap.getString("sDate").substring(4, 6));
		for(int i= 0; fieldCount > i; i++){
			if(tempCount > 12){
				tempCount = 1;
			}
			subMenu.append("<td align=\"center\" bgcolor=\"#BFFFBF\" >"+tempCount+"월</td>");
			tempCount++;
		}
	}

	//학력별에서 비어있는 항목을 한번만 표현하기위한 체크 변수
	int schoolCount = 0;
	if(listMap.keySize() > 0){
		for(int i = 0; listMap.keySize() > i; i++){
			html.append("<tr>");
			html.append("<td>"+(i+1)+"</td>");
			
			//월별검색 데이터는 제목이없으므로 빈값처리한다.
			if(searchType.equals("month")){
				//월별
				html.append("<td>월별</td>");
				
			}else if(searchType.equals("dept")){
				//기관별
				html.append("<td>"+listMap.getString("deptnm", i)+"</td>");
				
			}else if(searchType.equals("jik")){
				//직급별
				html.append("<td>"+listMap.getString("jiknm", i)+"</td>");				
				
			}else if(searchType.equals("sigun")){
				//시군별
				html.append("<td>"+listMap.getString("sigugun", i)+"</td>");
				
			}else if(searchType.equals("school")){
				//학력별
				for(int k = 0;  k < educationMap.keySize("gubun"); k++){
					if(listMap.getString("school", i).equals(educationMap.getString("gubun", k))){
						html.append("<td>"+educationMap.getString("gubunnm", k)+"</td>");
					}
					if(listMap.getString("school", i).equals("") && schoolCount == 0){
						html.append("<td>미등록</td>");
						schoolCount = 1;
					}
				}

				
			}else if(searchType.equals("resno")){
				//연령별
				if(i < 6){
					html.append("<td>"+listMap.getString("userAge", i)+"대</td>");					
				}else{
					html.append("<td>"+listMap.getString("userAge", i)+"대 이상</td>");					
				}
			}
			
			for(int j = 0; (fieldCount-1) > j; j++){
				
				if(searchType.equals("resno")){

					html.append("<td>"+listMap.getString("t"+(j+1), i)+"</td>");	
					
				}else{
					html.append("<td>"+listMap.getString("month"+(j+1), i)+"</td>");
					
				}
					
				
			}
			html.append("<td class=\"br0\">&nbsp;</td>");
			html.append("</tr>");
		}
	}else{
		html.append("<tr>");
		html.append("<td style=\"height:100px;\" colspan=\"100%\" class=\"br0\">등록된 데이터가없습니다.");
		html.append("</td>");
		html.append("</tr>");
	}
	
	
	//검색조건별로 파일이름 지정
	if(searchType.equals("resno")){
		searchName = "연령별 가입자 통계";
	}else if(searchType.equals("dept")){
		searchName = "기관별 가입자 통계";		
	}else if(searchType.equals("jik")){
		searchName = "직급별 가입자 통계";		
	}else if(searchType.equals("sigun")){
		searchName = "지역별 가입자 통계";		
	}else if(searchType.equals("school")){
		searchName = "학력별 가입자 통계";				
	}else if(searchType.equals("month")){
		searchName = "월별 가입자 통계";				
	}
	
	WebUtils.setFileHeader(request, response, searchName+".xls", "UTF-8", "UTF-8");
	response.setHeader("Content-Description", "JSP Generated Data"); 
	response.setContentType( "application/vnd.ms-excel");
	request.setCharacterEncoding("UTF-8");
	
%>
<meta http-equiv="Content-Type" content="application/vnd.ms-excel; charset=UTF-8">
<body leftmargin="0" topmargin="0" marginwidth=0 marginheight="0" >

<form id="pform" name="pform" method="post">
<input type="hidden" name="mode" value="">
<input type="hidden" name="qu" value="">
<input type="hidden" name="menuId" value="<%=requestMap.getString("menuId") %>">

<table width=100% cellpadding=0 cellspacing=0 align=center border=1>
	<tr>
		<td align="center" bgcolor="#BFFFBF">번호</td>
		<td align="center" bgcolor="#BFFFBF">제목</td>
		<%=subMenu.toString() %>
		<td align="center" bgcolor="#BFFFBF">비고</td>
	</tr>

	<%=html.toString() %>
</table>

</form>
</body>
