<%@page import="ut.lib.login.LoginInfo"%>
<%@page import="ut.lib.util.Constants"%>
<%@page import="ut.lib.support.DataMap"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	
	//request 데이터
	DataMap requestMap = (DataMap)request.getAttribute("REQUEST_DATA");
	requestMap.setNullToInitialize(true);
	
	//로그인된 사용자 정보
	LoginInfo memberInfo = (LoginInfo)request.getAttribute("LOGIN_INFO");

	//과정기수 리스트.
	DataMap listMap = (DataMap)request.getAttribute("grseqInfo");
	listMap.setNullToInitialize(true);
	
	StringBuffer listStr = new StringBuffer(); //리스트 결과 변수.
	String tmpGrcode = ""; //과정코드
	String tmpGrSeq = ""; //과정기수코드
	String tmpStr = "";

	//과정별 리스트.
	for(int i=0; i < listMap.keySize("grcode"); i++){

		tmpStr = "";

		tmpGrcode = listMap.getString("grcode", i);	
		tmpGrSeq = listMap.getString("grseq", i);	

		listStr.append("\n<tr>");

		//과정명
		listStr.append("\n	<td rowspan='" + listMap.getString("subjCount", i) + "'>" + listMap.getString("grcodenm", i) + "</td>");
		
		//과정기수
		String modifyGrSeq = "<a href=\"javascript:go_modify('"+tmpGrSeq+"');\">" + listMap.getString("grseq", i) + "</a>";
		listStr.append("\n	<td rowspan='" + listMap.getString("subjCount", i) + "'>" + modifyGrSeq + tmpStr + "</td>");
		
		//동기모임
		//tmpStr = (listMap.getString("cafeYn", i).equals("Y") ? "완료" : "<a href=\"javascript:go_addCafe('"+tmpGrSeq+"');\">생성</a>");
		//listStr.append("\n	<td align='center' class='tableline11' rowspan='" + listMap.getString("subjCount", i) + "'>" + tmpStr + "</td>");
		
		//과목리스트중 기본 과목정보 담겨져 있는 map추출. (일반,선택 과목 모두 이맵안에 SUBJ_REF_LIST_MAP map에 들어있다.)
		DataMap subjList = (DataMap)listMap.get("SUBJ_LIST_MAP", i);
		if(subjList == null) subjList = new DataMap();
		subjList.setNullToInitialize(true);

		for(int j=0; j < subjList.keySize("subj"); j++){
			
			//과목 리스트 담겨져 있는 map추출.
			DataMap subjRefList = (DataMap)subjList.get("SUBJ_REF_LIST_MAP", j);
			if(subjRefList == null) subjRefList = new DataMap();
			subjRefList.setNullToInitialize(true);
			
			if(j > 0){ //처음만 빼고
				listStr.append("\n<tr>");
			}
			for(int k=0; k < subjRefList.keySize("subj"); k++){
				
				if(k > 0){ //처음만 빼고
					listStr.append("\n<tr>");
				}else{

					//과목구분
					if( subjList.getString("lecType", j).equals("S") ) 
						tmpStr = "일반";
					else if( subjList.getString("lecType", j).equals("P") ) 
						tmpStr = "선택<br>(<a href=\"javascript:go_modifySubj('"+tmpGrSeq+"', '"+subjList.getString("refSubj", j)+"');\">"+subjList.getString("refSubjnm", j)+"</a>)";
					else 
						tmpStr = "&nbsp;";
					listStr.append("\n	<td rowspan='" + subjRefList.keySize("subj") + "'>" + tmpStr + "</td>");

				}
				
				//과목분류
				if( subjRefList.getString("subjtype", k).equals("Y") ) tmpStr = "사이버";
				else if (subjRefList.getString("subjtype", k).equals("N") ) tmpStr = "집합";
				else if (subjRefList.getString("subjtype", k).equals("S") ) tmpStr = "특수";
				else if (subjRefList.getString("subjtype", k).equals("M") ) tmpStr = "동영상";
				else tmpStr = "";
				listStr.append("\n	<td>" + tmpStr + "</td>");

				//과목명
				tmpStr = "<a id=\"a_"+subjRefList.getString("subj", k)+"\" href=\"javascript:saveAnsForm('"+tmpGrcode+"', '"+tmpGrSeq+"', '"+subjRefList.getString("subj", k)+"', '"+subjRefList.getString("subjnm", k)+"');\">" + subjRefList.getString("subjnm", k) + "</a>&nbsp;";
				listStr.append("\n	<td>" + tmpStr + "</td>");

				//인원
				tmpStr = subjRefList.getString("count1", k) + "/" + subjRefList.getString("count2", k) + "/" + subjRefList.getString("count3", k);
				listStr.append("\n	<td>" + tmpStr + "</td>");

				//교육기간
				tmpStr = subjRefList.getString("started", k) +  " ~<br>" + subjRefList.getString("enddate", k) + "&nbsp;";
				listStr.append("\n	<td>" + tmpStr + " </td>");

// 				listStr.append("\n	<td class='br0'>")
// 						.append("<input type=\"text\" name=\"subj\" value=\"").append(subjRefList.getString("subj")).append("\"")
// 						.append("style=\"display:none;\" />")
// 						.append("<input name=\"file\" type=\"file\" accept=\"text/plain\">&nbsp;</td>");

				listStr.append("\n</tr>");
			}
			
		}
		//과정기수는 있지만 과목이 없는 경우(예외처리)
		if(subjList.keySize("subj") <= 0){
			listStr.append("<td colspan='8'>&nbsp;</td></tr>");
		}
		

	}

	//row가 없으면.
	if( listMap.keySize("grcode") <= 0){

		listStr.append("<tr>");
		listStr.append("	<td colspan='100%' style=\"height:100px\" class=\"br0\">등록된 과정이 없습니다.</td>");
		listStr.append("</tr>");

	}
%>
<table class="datah01">
	<thead>
	<tr>
		<th>과정명</th>
		<th>과정<br>기수</th>
		<th>과목<br>구분</th>
		<th>과목<br />분류</th>
		<th>과목명</th>
		<th>인원</th>
		<th>교육기간</th>
		<%//<th class="br0">답안지</th> %>
	</tr>
	</thead>

	<tbody>
		<%= listStr.toString() %>
	</tbody>
</table>