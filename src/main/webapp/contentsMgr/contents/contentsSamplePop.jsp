<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%  
// prgnm : 콘텐츠 맛보기 팝업
// date : 2008-09-04
// auth : Lym
%>

<!-- [s] commonImport -->
<%@ include file="/commonInc/include/commonImport.jsp" %>
<!-- [e] commonImport -->

<%
	
	DataMap requestMap = (DataMap)request.getAttribute("REQUEST_DATA");
	requestMap.setNullToInitialize(true);
	
	//과목의 등록된 회차 리스트
	DataMap listMap = (DataMap)request.getAttribute("LIST_DATA");
	listMap.setNullToInitialize(true);

	StringBuffer listStr = new StringBuffer(); //리스트 결과 변수.
	String tmpStr = "";
	String tmpStr2 = "";
	for(int i=0; i < listMap.keySize("subj"); i++){

		listStr.append("\n<tr>");

		//번호
		//listStr.append("\n	<td>" + listMap.getString("dates", i) + "</td>");
		listStr.append("\n	<td>" + (i+1) + "</td>");

		//회차명
		listStr.append("\n	<td>" + listMap.getString("orgTitle", i) + "</td>");

		//맛보기
		tmpStr = "<a href=\"javascript:go_contentPreview('"+listMap.getString("subj", i)+"', '"+listMap.getString("ctId", i)+"', '"+listMap.getString("orgDir", i)+"', '"+listMap.getString("orgDirName", i)+"', 'N', '"+listMap.getString("menuyn", i)+"', '"+listMap.getString("skinId", i)+"', '"+listMap.getString("lcmsWidth", i)+"', '"+listMap.getString("lcmsHeight", i)+"')\">[보기]</a>";
		listStr.append("\n	<td class='br0'>" + tmpStr + "</td>");


		listStr.append("\n</tr>");

	} //end for listMap.keySize("dept")


	//row가 없으면.
	if( listMap.keySize("subj") <= 0){

		listStr.append("\n<tr>");
		listStr.append("\n	<td colspan='100%' class='br0' style='height:100px'>맛보기로 등록된 회차가 없습니다.</td>");
		listStr.append("\n</tr>");

	}


%>

<!-- [s] commonHtmlTop include 필수 -->
<jsp:include page="/commonInc/include/commonHtmlTop.jsp" flush="false"/>
<!-- [e] commonHtmlTop include -->

<script language="JavaScript">
<!--

//미리보기
function go_contentPreview(subj, ctId, orgDir, orgDirname, review, menuYn, skinId, lcmsWidth, lcmsHeight){

	var url = "/lcms/lecture/lecture_frame.jsp?subj=" + subj + "&ctId=" + ctId + "&orgDir=" + orgDir + "&orgDirname=" + orgDirname + "&review=" + review + "&menuYn=" + menuYn + "&skinId=" + skinId;

	popWin(url, "pop_lcmsContentPreview", lcmsWidth, lcmsHeight, "0", "1");

}


//페이지 로딩시.
onload = function(){


}

//-->
</script>

<body leftmargin="0" topmargin="0">

<form name="pform" method="post">
<input type="hidden" name="menuId"				value="<%=requestMap.getString("menuId")%>">
<input type="hidden" name="mode"				value="<%=requestMap.getString("mode")%>">
<input type="hidden" name="qu"					value="<%=requestMap.getString("qu")%>">

<input type="hidden" name="subj"				value="<%=requestMap.getString("subj")%>">


<table width="100%" cellspacing="0" cellpadding="0" border="0">
	<tr><td height="4" bgcolor="#0081C4" nowrap></td></tr>
	<tr>
		<td height="45" bgcolor="#FFFFFF" style="padding-left:10px" nowrap>

			<!-- 타이틀영역 -->
			<table cellspacing="0" cellpadding="0" border="0">
				<tr>
					<td width="15" align="left"><img src="/images/bullet_pop.gif" width="10" height="22" border="0"></td>
					<td><font color="#000000" style="font-weight:bold; font-size:13px">콘텐츠 맛보기</font></td>
				</tr>
			</table>
			<!--// 타이틀영역 -->
		</td>
	</tr>
	<tr>
		<td valign="top" style="background:#FFFFFF URL(/images/bg_pop.gif) repeat-x; padding:20px; line-height:18px" >
			
			<!--[s] 리스트  -->
			<table class="datah01">
				<thead>
				<tr>
					<th>번호</th>
					<th>강의명</th>
					<th class="br0">맛보기</th>
				</tr>
				</thead>

				<tbody>
				<%= listStr.toString() %>
				</tbody>
			</table>


			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr height='28' >
					<td align="center">
						<input type="button" class="boardbtn1" value='확인' onClick="javascript:self.close();">
					</td>
				</tr>
			</table>

			<!-- space --><table width="100%" height="20"><tr><td></td></tr></table>
			
			<!--// 본문영역 -->

		</td>
	</tr>
	<tr>
		<td height="20" align="center" nowrap></td>
	</tr>
</table>


</form>

</body>
