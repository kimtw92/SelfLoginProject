<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%  
// prgnm : 강사 검색 팝업
// date : 2008-07-31
// auth : Lym
%>

<!-- [s] commonImport -->
<%@ include file="/commonInc/include/commonImport.jsp" %>
<!-- [e] commonImport -->

<%
	
	DataMap requestMap = (DataMap)request.getAttribute("REQUEST_DATA");
	requestMap.setNullToInitialize(true);
	
	//과목 리스트.
	DataMap listMap = (DataMap)request.getAttribute("LIST_DATA");
	listMap.setNullToInitialize(true);
	

	String listStr = "";
	String tmpStr = "";

	for(int i=0; i < listMap.keySize("userno"); i++){

		listStr += "\n<tr>";

		//선택
		tmpStr = "<input type='checkbox' class='chk_01' name='userno' value='" + listMap.getString("userno", i) + "|" + listMap.getString("name", i) + "' "+(listMap.getString("isSelect", i).equals("1") ? "checked" : "" ) +">";
		listStr += "\n	<td>" + tmpStr + "</td>";

		//강사명
		listStr += "\n	<td>" + listMap.getString("name", i) + "</td>";

		//주민번호.
		listStr += "\n	<td class='br0' style='padding-left:5px;text-align:left'>" + StringReplace.subString(listMap.getString("resno", i), 0, 6) + "-XXXXXXX"+ "</td>";

		listStr += "</tr>";
	}

	//row가 없으면.
	if( listMap.keySize("userno") <= 0){

		listStr += "<tr>";
		listStr += "	<td class='br0' colspan='100%' style='height:50px;'>검색된 강사가 없습니다.</td>";
		listStr += "</tr>";

	}


%>

<!-- [s] commonHtmlTop include 필수 -->
<jsp:include page="/commonInc/include/commonHtmlTop.jsp" flush="false"/>
<!-- [e] commonHtmlTop include -->

<script language="JavaScript">
<!--

//강사 선택
function go_submit() {


	var radioUser = pform.userno;
	var tuserno = "";
	var tusernoName = "";
	var tmpInt = 0;
	if(radioUser.length == undefined || radioUser.length == 1){
		if(radioUser.checked){

			tmpInt++;
			var value = radioUser.value.split("|");
			tuserno = value[0];
			tusernoName = value[1];

		}
	}else{
		for( i=0; i < radioUser.length ; i++){
		
			if(radioUser[i].checked == true){

				var value = radioUser[i].value.split("|");
				if(tmpInt > 0){
					tuserno += "|";
					tusernoName += "|";
				}

				tuserno += value[0];
				tusernoName += value[1];

				tmpInt++;
			}
		}

	}


	if(tmpInt <= 0){
		alert("강사를 선택해 주세요");
		return;
	}else{
		(opener.$("tuserno")).value = tuserno;
		(opener.$("tusernoName")).value = tusernoName;
		window.close();
	}

}

//-->
</script>

<body leftmargin="0" topmargin=0>

<form id="pform" name="pform" method="post">
<input type="hidden" name="mode"				value="<%=requestMap.getString("mode")%>">
<input type="hidden" name="qu"					value='<%=requestMap.getString("qu")%>'>

<table class="pop01">
	<tr>
		<td class="titarea">
			<!-- 타이틀영역 -->
			<div class="tit">
				<h1 class="h1"><img src="/images/bullet_pop.gif" /> 강의조회(시간표)</h1>
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
					<th>선택</th>
					<th>강사명</th>
					<th class="br0">강사주민번호</th>
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
					<%if( listMap.keySize("userno") > 0){%>
						<input type="button" value="확인" onclick="go_submit();" class="boardbtn1" />
					<%}%>
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
