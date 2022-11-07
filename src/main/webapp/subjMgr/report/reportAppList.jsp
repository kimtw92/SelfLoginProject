<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%  
// prgnm : 과제물출제
// date  : 2008-07-22
// auth  : 정윤철
// Modifier : 최석호
// Modified : 2009-04-22 
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
	
	//등급 데이터
	DataMap rowMap = (DataMap)request.getAttribute("GRADELIST_DATA");
	rowMap.setNullToInitialize(true);
	
	//제출자
	DataMap evlCntMap = (DataMap)request.getAttribute("EVLCNTROW_DATA");
	evlCntMap.setNullToInitialize(true);
	
	//반명, 반 번호
	DataMap classNameMap = (DataMap)request.getAttribute("CLASSNAMEROW_DATA");
	classNameMap.setNullToInitialize(true);
	
	//과정 명, 과정 데이트
	DataMap grcodeMap = (DataMap)request.getAttribute("GRCODEROW_DATA");
	grcodeMap.setNullToInitialize(true);
	
	//점수
	DataMap pointRowMap = (DataMap)request.getAttribute("POINTROW_DATA");
	pointRowMap.setNullToInitialize(true);
	
	StringBuffer html = new StringBuffer();
	//알파벳 시작값
	char alph = 65;
	String temp = "";
	int rowIndex = 1;
	int rowNum = 0;
	if(listMap.keySize("userno") > 0){
		for(int i=0; i < listMap.keySize("userno"); i++){
			html.append("<tr></tr>");
			//교번
			html.append("<td>"+listMap.getString("eduno", i)+"</td>");
			//이름
			html.append("<td>"+listMap.getString("name", i)+"</td>");
			
			if(!listMap.getString("groupfileNo", i).equals("0") &&
			   !listMap.getString("groupfileNo", i).equals("-1") &&
			   !listMap.getString("groupfileNo", i).equals("")){

				//레포트 제출
				//html.append("\n	<td class=\"tableline11\">"+(!listMap.getString("groupfileNo",i).equals("-1") ? 
						//"<a href='javascript:fileDownloadPopup("+listMap.getString("groupfileNo", i)+");'><img src=/images/compressed.gif border=0 valign='middle'></a>" : 
						//"&nbsp;" ) +"</td>");
				html.append("\n	<td class=\"tableline11\"> <a href='javascript:fileDownloadPopup("+listMap.getString("groupfileNo", i)+");'><img src=/images/compressed.gif border=0 valign='middle'></a> </td>");
				
			}else{
				//미제출
				html.append("\n	<td class=\"tableline11\">미제출<input type=\"hidden\" name=\"noRoport\" value=\""+listMap.getString("userno", i)+"\"></td>");
				
			}
			
			//fnFileUploadPop('groupfileNo_" + rowIndex + "','" + listMap.getString("groupfileNo", i) + "');\
			//<input type=\"button\" value=\"파일\" onclick=\"fnFileUploadPop('groupfileNo_" + rowIndex + "','" + listMap.getString("groupfileNo", i) + "');\" class=\"boardbtn1\"> ");
			
			//업로드
			//html.append("<td class=\"tableline11\"><a href=\"javascript:fnFileUploadPop('groupfileNo_" + i + "','" + listMap.getString("groupfileNo", i) + "');\"><img src=\"/images/compressed.gif\" border=0 valign=\"middle\"></a></td>");
			html.append("	<td align=\"center\" >");
			html.append("		<input type=\"button\" value=\"파일\" onclick=\"fnFileUploadPop('groupfileNo_" + rowIndex + "','" + listMap.getString("groupfileNo", i) + "','"+ listMap.getString("userno", i) +"');\" class=\"boardbtn1\"> ");
			html.append("	</td>");
			html.append("<input type=\"hidden\" name=\"groupfileNo\" id=\"groupfileNo_" + i + "\" value=\"" + listMap.getString("groupfileNo", i) + "\" > ");
			
			
			
			//제출일자
			html.append("<td>"+listMap.getString("submitDate", i)+"</td>");
			//핸드폰번호
			html.append("<td>"+listMap.getString("hp", i)+"</td>");
			//생년월일
			html.append("<td>"+listMap.getString("resno", i)+"</td>");
			//소속
			html.append("<td>"+listMap.getString("deptnm", i)+"</td>");
			//점수
			html.append("<td>"+listMap.getString("submitPoint", i)+"</td>");
			
			//등급선택
			html.append("<td>");
			html.append("<input type=\"hidden\" value=\""+listMap.getString("userno",i)+"\" name=\"userno\">");
			html.append("<select id=\"grade_"+i+"\"  name=\"gradeNo\" onchange=\"changeGreade(this.value,'"+i+"')\">");
			html.append("<option value=\"\">등급설정</option>");
			
			for(int j=0; j < rowMap.keySize("gradeNo"); j++){
				html.append("<option value=\""+rowMap.getString("gradePoint", j)+"\">"+(alph++)+"등급</option>");
				
			}
			

			
			html.append("<option value=\"T\">등급외 설정</option>");
			
			int x = 0;
			
			for(int j =0; j < evlCntMap.keySize(); j++){
				if(listMap.getString("userno",i).equals(evlCntMap.getString("userno",j))){
					html.append("<input type=\"hidden\" name=\"chkCnt\" value=\"Y\">");
					x ++;
				}
			}
			if (x == 0){
				html.append("<input type=\"hidden\" name=\"chkCnt\" value=\"N\">");
			}
			
			html.append("</td>");

			//점수수정			
			html.append("<td class=\"br0\"><input type=\"text\" id=\"submitPoint_"+i+"\"  size=\"3\" maxlength=\"3\" name=\"submitPoint\" value=\""+listMap.getString("submitPoint", i)+"\"></td>");
			
			
			html.append("<tr></tr>");
			alph = 65;
			temp = "";
			rowNum = i+1;
			rowIndex++;
		}
	}
	
	
%>

<!-- [s] commonHtmlTop include 필수 -->
<jsp:include page="/commonInc/include/commonHtmlTop.jsp" flush="false"/>
<!-- [e] commonHtmlTop include -->




<script language="JavaScript">
<!--
//정렬순서변경
function changeOrder(order){
	$("mode").value="reportAppList";
	$("order").value=order;
	pform.action = "/subjMgr/report.do";
	pform.submit();

}

//저장
function go_save(){
	//if(NChecker($("pform"))){	
		var l = <%=rowNum %>;
		
		for(var i=0; i < l; i++){  
			// alert(i);
			var pointValue = $("submitPoint_"+(i)).value;
			// alert(pointValue);
			var chkNum = pointValue - <%=pointRowMap.getString("gradePoint")%>;
			if(chkNum > 0){
				alert("평가등급이 최대점수보다 높아서 등록할 수 없습니다.");
				$(obj).focus();
				return false;
				break;
			}
		}
		// alert("확인");
		if( confirm('저장 하시겠습니까?')){
			$("mode").value="reportAppExec";
			pform.action = "/subjMgr/report.do";
			pform.submit();	
		}
	//}
}


//등급 변경
function changeGreade(point, id){
	//gubun : 등급에 따른 점수설정
	//id	: 넘길 아이디 번지 수
	//point : 점수
	
	var gradeId = "grade_"+id;
	var gradeNoLen = $(gradeId).length;
	var submitPoint = "submitPoint_"+id;
	
	//등급 셀렉티드
	for(var i=0; i < gradeNoLen; i++) {
	
	    if($(gradeId).options[i].value == point){
	     	if(point == "T"){
		     	$(submitPoint).value = "";
		     	$(submitPoint).readOnly = false;
		     	
	     	}else{
		     	$(submitPoint).value = point;
		     	$(submitPoint).readOnly = true;
		     	
	     	}
	     	break;
		}
	}
}

//엑셀
function go_excel(){
	$("mode").value="reportAppExcel";

	pform.action = "/subjMgr/report.do";
	pform.submit();
	
}


//SMS용 엑셀
function go_smsExcel(){
	$("mode").value="reportAppSmsExcel";
	pform.action = "/subjMgr/report.do";
	pform.submit();
	
}

//전페이지 주소
function go_list(){
	$("mode").value=$F("urlGubun");
	pform.action = "/subjMgr/report.do";
	pform.submit();
}


//파일업로드 팝업
function fnFileUploadPop(obj, groupfileNo, luserno){

	var url = "report.do";
	url += "?mode=reportFileUploadPop";
	url += "&retObj=pform." + obj;
	url += "&groupfileNo=" + groupfileNo;
	url += "&luserno=" + luserno;
	url += "&grcode="  + '<%= requestMap.getString("grcode") %>';
	url += "&grseq="   + '<%= requestMap.getString("grseq") %>';
	url += "&subj="    + '<%= requestMap.getString("subj") %>';
	url += "&classno=" + '<%= requestMap.getString("classno") %>';
	url += "&dates="   + '<%= requestMap.getString("dates") %>';
	
	pwinpop = popWin(url,"cPop","600","400","yes","yes");
}

//파일 저장 후 처리
function fnFileUploadOk(){
	//페이지 리로드
	$("mode").value="reportAppList";
	pform.action = "/subjMgr/report.do";
	pform.submit();
	//location.reload();
}


//로딩시.
onload = function()	{
<%
	for(int i=0; listMap.keySize("userno")>i;i++){
%>

	var gradeNoLen = $("grade_<%=i%>").length;
	
	//등급 셀렉티드
	for(var i=0; i < gradeNoLen; i++) {
	
	    if($("grade_<%=i%>").options[i].value == "<%= listMap.getString("submitPoint" ,i)%>"){
	   		  //해당등급 셀렉티드
	     	$("grade_<%=i%>").selectedIndex = i;
	     	$("submitPoint_<%=i%>").readOnly = true;
	     	break;
	     	
		}else if($("submitPoint_<%=i%>").value == "" || $("submitPoint_<%=i%>").value == null){
	   		  //등급설정
	     	$("grade_<%=i%>").selectedIndex = 0;
	     	$("submitPoint_<%=i%>").readOnly = true;
			break;
	     	
		}else{
			//등급외 설정
			$("grade_<%=i%>").selectedIndex = i;
	     	$("submitPoint_<%=i%>").readOnly = false;
						
		}
	}
<%}%>
}


//-->
</script>


<body leftmargin="0" topmargin="0" marginwidth=0 marginheight="0" >

<form id="pform" name="pform" method="post" >
<input type="hidden" name="menuId" 	value="<%= requestMap.getString("menuId") %>">
<input type="hidden" name="mode"	value="<%= requestMap.getString("mode") %>">
<input type="hidden" name="qu"		value="">
<!-- 차시 -->
<input type="hidden" name="dates"		value="<%=requestMap.getString("dates") %>">
<!-- 정렬순 -->
<input type="hidden" name="order">
<input name="subj" type="hidden" value="<%=requestMap.getString("subj") %>">
<input name="grcode" type="hidden" value="<%=requestMap.getString("grcode") %>">
<input name="grseq" type="hidden" value="<%=requestMap.getString("grseq") %>">
<input name="classno" type="hidden" value="<%=requestMap.getString("classno") %>">
<input name="sessNo" type="hidden" value="<%= memberInfo.getSessNo() %>">

<input type="hidden" name="urlGubun" value="<%=requestMap.getString("urlGubun")%>">
<table cellspacing="0" cellpadding="0" border="0" width="100%" height="100%">
    <tr>
        <td width="211" height="86" valign="bottom" align="center" nowrap><img src="/images/incheon_logo.gif" width="192" height="56" border="0"></td>
        <td width="8" valign="top" nowrap><img src="/images/lefttop_bg.gif" width="8" height="86" border="0"></td>
        <td width="100%">
            <!--[s] 공통 top include -->
            <jsp:include page="/commonInc/include/commonAdminTopMenu.jsp" flush="false"/>
            <!--[e] 공통 top include -->
        </td>
    </tr>
    
    <tr>
        <td height="100%" valign="top" align="center" class="leftMenuIllust">
            <!--[s] 공통 Left Menu  -->
            <jsp:include page="/commonInc/include/commonAdminLeftMenu.jsp" flush="false"/>            	
            <!--[e] 공통 Left Menu  -->
        </td>

        <td colspan="2" valign="top" class="leftMenuBg">
          
            <!--[s] 경로 네비게이션-->
            <%= navigationStr %>
            <!--[e] 경로 네비게이션-->
                                    
			<!--[s] 타이틀 -->
			<jsp:include page="/commonInc/include/commonAdminTitle.jsp" flush="false" />
			<!--[e] 타이틀 -->

			<!--[s] subTitle -->
			<table width="100%" height="10"><tr><td></td></tr></table>
			<table width="100%" border="0" cellspacing="0" cellpadding="0" class="contentsSubTitleTable">			
				<tr>
					<td height="20">
						<img src="/images/bullet003.gif"  align="bottom">&nbsp;<strong>	과제물 평가하기</strong>
					</td>
				</tr>
			</table> 
			<div class="h10"></div>
			<!--[s] Contents Form  -->
			<table cellspacing="0" cellpadding="0" border="0" width="100%"
				class="contentsTable">
				<tr>
					<td>
						<!-- 검색  -->
						<table class="search01">
							<tr>
								<th width="80" class="bl0">정렬순서</th>
								<td width="">
								<select name="order" onchange="changeOrder(this.value);">
								<option value="EDUNO">교번 정렬</option>
								<option value="SUBMIT_DATE">제출일자순 정렬</option>
								<option value="SUBMIT_POINT">성적 정렬</option>
								</select>
								</td>
							
							</tr>
						</table>
						<!--//검색  -->	
						<div class="space01"></div>
						<table width="100%">
							<tr>
								<td align="right">
									<input type="button" value="저장" class="boardbtn1" onClick="go_save();">
									<input type="button" value="리스트" class="boardbtn1" onClick="go_list();">
									<input type="button" value="EXCEL" class="boardbtn1" onClick="go_excel();">
									<input type="button" value="SMS용" class="boardbtn1" onClick="go_smsExcel();">
								</td>
							</tr>
						</table>
						<!-- 리스트  -->
						<table class="datah01">
							<thead>
							<tr>
								<th>교번</th>
								<th width="50">이름</th>
								<th>제출파일</th>
								<th>업로드</th>
								<th>제출일자</th>
								<th>핸드폰</th>
								<th>생년월일</th>
								<th>소속</th>
								<th>점수</th>
								<th>등급선택</th>
								<th class="br0">점수수정</th>
							</tr>
							</thead>
							<%=html.toString() %>
								
						</table>
						<table width="100%">
							<tr>
								<td align="right">
									<input type="button" value="저장" class="boardbtn1" onClick="go_save();">
									<input type="button" value="리스트" class="boardbtn1" onClick="go_list();">
									<input type="button" value="EXCEL" class="boardbtn1" onClick="go_excel();">
									<input type="button" value="SMS용" class="boardbtn1" onClick="go_smsExcel();">
								</td>
							</tr>
						</table>
						<!--//리스트  -->	
						<div class="h5"></div>
						
					</td>
				</tr>
			</table>
			<!--//[e] Contents Form  -->
			<div class="space_ctt_bt"></div>                     
        </td>
    </tr>
</table>

<!--[s] bottom -->
<jsp:include page="/commonInc/include/commonAdminBottom.jsp" flush="false"/>
<!--[e] bottom -->

</form>
</body>