<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%  
// prgnm : 과목 검색 팝업
// date : 2008-07-31
// auth : Lym
%>

<!-- [s] commonImport -->
<%@ include file="/commonInc/include/commonImport.jsp" %>
<!-- [e] commonImport -->

<%
	
	DataMap requestMap = (DataMap)request.getAttribute("REQUEST_DATA");
	requestMap.setNullToInitialize(true);
	
	//과정기수 정보.
	DataMap grseqRowMap = (DataMap)request.getAttribute("GRSEQ_ROW_DATA");
	grseqRowMap.setNullToInitialize(true);

	//과목 리스트.
	DataMap listMap = (DataMap)request.getAttribute("LIST_DATA");
	listMap.setNullToInitialize(true);
	
	//강사 리스트.
	DataMap tutorListMap = (DataMap)request.getAttribute("TUTOR_LIST_DATA");
	tutorListMap.setNullToInitialize(true);

	String listStr = "";
	String tmpStr = "";
	int tmpInt = 0;

	String tutorNoStr = "";
	String tutorNameStr = "";
	String tutorClassNoStr = "";
	String tutorClassNameStr = "";

	for(int i=0; i < listMap.keySize("subj"); i++){

		tmpInt = 0;
		tutorNoStr = "";
		tutorNameStr = "";
		tutorClassNoStr = "";
		tutorClassNameStr = "";

		for(int k=0; k < tutorListMap.keySize("subj"); k++){
			if( listMap.getString("subj", i).equals(tutorListMap.getString("subj", k)) ){

				if( tmpInt > 0 ){
					tutorNoStr += "|";
					tutorNameStr += "|";
				}

				tutorNoStr			+= tutorListMap.getString("userno", k);
				tutorNameStr		+= tutorListMap.getString("name", k);

				tutorClassNoStr		= tutorListMap.getString("classroomNo", k);
				tutorClassNameStr	= tutorListMap.getString("classroomName", k);

				tmpInt++;
			}
		}

		listStr += "\n<tr>";

		//구분
		listStr += "\n	<td>" + listMap.getString("lectypeNm", i) + "</td>";

		//과목명
		tmpStr = "<a href=\"javascript:go_click('" + listMap.getString("subj", i) + "', '" + listMap.getString("lecnm", i) + "', '" + tutorNoStr + "', '" + tutorNameStr + "','" + tutorClassNoStr + "', '" + tutorClassNameStr + "')\">" + listMap.getString("lecnm", i) + "</a>";
		listStr += "\n	<td class='br0' style='padding-left:5px;text-align:left'>" + tmpStr + "</td>";

		listStr += "</tr>";
	}

	//row가 없으면.
	if( listMap.keySize("subj") <= 0){

		listStr += "<tr>";
		listStr += "	<td class='br0' colspan='100%' style='height:80px;'>등록된 과목이 없습니다.</td>";
		listStr += "</tr>";

	}


%>

<!-- [s] commonHtmlTop include 필수 -->
<jsp:include page="/commonInc/include/commonHtmlTop.jsp" flush="false"/>
<!-- [e] commonHtmlTop include -->

<script language="JavaScript">
<!--

//강의실 클릭시.
function go_click(subj, lecnm, tutorNo, tutorName, tutorClassNo, tutorClassName) {

	//과목정보
	(opener.$("subj")).value = subj;
	(opener.$("lecnm")).value = lecnm;

	//강사
	(opener.$("tuserno")).value = tutorNo;
	(opener.$("tusernoName")).value = tutorName;

	//강의실 (빈값이라면 이미 선택된 강의실 정보를 지우지 않기 위해 추가)
	if( tutorClassNo != "" && tutorClassName != ""){
		(opener.$("classroomNo")).value = tutorClassNo;
		(opener.$("classroomName")).value = tutorClassName;
	}

	window.close();

}

//-->
</script>

<body leftmargin="0" topmargin=0>

<form id="pform" name="pform" method="post">
<input type="hidden" id="mode" name="mode"				value="<%=requestMap.getString("mode")%>">
<input type="hidden" id="qu" name="qu"					value='<%=requestMap.getString("qu")%>'>

<input type="hidden" id="grcode" name="grcode"				value='<%=requestMap.getString("grcode")%>'>
<input type="hidden" id="grseq" name="grseq"				value='<%=requestMap.getString("grseq")%>'>

<table class="pop01">
	<tr>
		<td class="titarea">
			<!-- 타이틀영역 -->
			<div class="tit">
				<h1 class="h1"><img src="../images/bullet_pop.gif" /> 강의조회(시간표)</h1>
			</div>
			<!--// 타이틀영역 -->			
		</td>
	</tr>
	<tr>
		<td class="con">
			<!-- 리스트  -->
			<table class="datah01">
				<thead>
				<tr>
					<th>과목구분</th>
					<th class="br0">과목명</th>
				</tr>
				</thead>

				<tbody>
				<%= listStr %>
				</tbody>
			</table>
			<!--//리스트  -->	
			
			<!-- 하단 닫기 버튼  -->
			<table class="btn02">
				<tr>
					<td class="center">
						<input type="button" value="닫기" onclick="window.close();" class="boardbtn1" />
					</td>
				</tr>
			</table>
			<!--// 하단 닫기 버튼  -->
		</td>
	</tr>
</table>


</form>

</body>
