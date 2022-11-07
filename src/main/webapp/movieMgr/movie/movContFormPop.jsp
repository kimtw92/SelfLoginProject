<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%  
// prgnm : 동영상 강의 학습 입력/수정 화면 (팝업)
// date  : 2009-06-03
// auth  : hwani
%>

<!-- [s] commonImport -->
<%@ include file="/commonInc/include/commonImport.jsp" %>
<!-- [e] commonImport -->

<%
    //request 데이터
	DataMap requestMap = (DataMap)request.getAttribute("REQUEST_DATA");
	requestMap.setNullToInitialize(true);       

	//String qu = requestMap.getString("qu");
	
    //동영상 상세정보
	DataMap rowMap = (DataMap)request.getAttribute("ROW_DATA");
	rowMap.setNullToInitialize(true); 
	
	//입력/수정 버튼
	String buttonStr = "";
	if("insert".equals(requestMap.getString("qu")))
		buttonStr = "<input type='button' value='입력' onclick='go_add();' class='boardbtn1'>";
	else
		buttonStr = "<input type='button' value='수정' onclick='go_modify();' class='boardbtn1'>";	

	//파일 정보 START
	/**
	String fileStr = "";
	String tmpStr = ""; //넘어가는 값.
	
	DataMap fileMap = (DataMap)rowMap.get("FILE_GROUP_LIST");
	
	if(fileMap == null)
		fileMap = new DataMap();
	
	fileMap.setNullToInitialize(true);

	for(int i=0; i < fileMap.keySize("groupfileNo"); i++){

		tmpStr = fileMap.getString("groupfileNo", i) + "#" + fileMap.getString("fileNo", i); 
// 		fileStr += "document.InnoDS.AddTempFile('" + fileMap.getString("fileName", i) + "', " + fileMap.getInt("fileSize", i) + ", '" + tmpStr + "');";
// 		fileStr += "g_ExistFiles['" + tmpStr + "'] = false;";

        fileStr += "var input"+i+" = document.createElement('input');\n";
		fileStr += "input"+i+".value='"+fileMap.getString("fileName", i)+"';\n";
		fileStr += "input"+i+".setAttribute('fileNo', '"+tmpStr+"');\n";
		fileStr += "input"+i+".name='existFile';\n";
		fileStr += "multi_selector.addListRow(input"+i+");\n\n";
	}
	*/
	
%>


						
<!-- [s] commonHtmlTop include 필수 -->
<jsp:include page="/commonInc/include/commonHtmlTop.jsp" flush="false"/>
<!-- [e] commonHtmlTop include -->

<script language="JavaScript">
<!--

//입력 실행
function go_add()	{

	$("mode").value = "contExec";
	$("qu").value   = "insert";
	pform.action = "/movieMgr/movie.do?mode=contExec";
	pform.submit();

}

//수정 실행
function go_modify()	{

	$("mode").value = "contExec";
	$("qu").value   = "update";

	pform.action = "/movieMgr/movie.do?mode=contExec";
	pform.submit();

}


//수정시 inno에 기존 파일 넣은 변수 및 함수.
var g_ExistFiles = new Array();
function OnInnoDSLoad(){


}

//로딩시.
onload = function()	{

	<%// = fileStr %>
}

//-->
</script>


<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">

<form id="pform" name="pform" method="post" enctype="multipart/form-data">
<input type="hidden" name="menuId"				value="<%=requestMap.getString("menuId")%>">
<input type="hidden" name="mode"				value="<%=requestMap.getString("mode")%>">
<input type="hidden" name="qu"					value='<%=requestMap.getString("qu")%>'>

<input type="hidden" name="contCode"			value='<%=requestMap.getString("contCode")%>'>
<input type="hidden" name="divCode"				value='<%=requestMap.getString("divCode")%>'>

<!-- INNO FILEUPLOAD 사용시 UPLOAD 경로 지정해줌.-->
<input type="hidden" name="INNO_SAVE_DIR"		value='<%=Constants.UPLOADDIR_HOMEPAGE%>'>
<table class="pop01">
	<tr>
		<td class="titarea">
			<!-- 타이틀영역 -->
			<div class="tit">
				<h1 class="h1"><img src="/images/bullet_pop.gif" />동영상강의 학습 입력/수정</h1>
			</div>
			<!--// 타이틀영역 -->
		</td>
	</tr>
	<tr>
		<td class="con">
			<!-- date -->
			<table  class="dataw01">
				<tr>
					<th width="70px">학습명</th>
					<td>
						<input type="text" class="textfield" name="contName" value="<%= rowMap.getString("contName") %>" style="width:500" />&nbsp;
					</td>
				</tr>
				<tr>
					<th>학습 URL</th>
					<td>
						<input type="text" class="textfield" name="movUrl" value="<%= rowMap.getString("movUrl") %>" style="width:500" />&nbsp;
					</td>
				</tr>
				<tr>
					<th>등 록 일</th>
					<td>
						<input type="text" class="textfield" name="movEntDate" value="<%= rowMap.getString("movEntDate") %>" style="width:200" />&nbsp;(입력예: 2009-01-04)
					</td>
				</tr>
				<tr>
					<th>학습시간</th>
					<td>
						<input type="text" class="textfield" name="movTime" value="<%= rowMap.getInt("movTime") %>" style="width:50" maxlength="2" />분&nbsp;
						<input type="text" class="textfield" name="movMin" value="<%= rowMap.getInt("movMin") %>" style="width:50" maxlength="2" />초&nbsp;
					</td>
				</tr>
				<tr>
					<th>내용요약</th>
					<td>
						<textarea name="contSummary" class="textfield" style="width:100%;height:150px" class="box" required="true!해설이 없습니다." maxchar="900!글자수가 많습니다." /><%= rowMap.getString("contSummary") %></textarea>
					</td>
				</tr>
				<tr>
					<th>섬네일<br/>이미지</th>
					<td>
                                <jsp:include page="/fileupload/multplFileSelector.jsp" flush="true"/>
					</td>
				</tr>
			</table>
			<!-- //date -->

			<!-- 하단 닫기 버튼  -->
			<table class="btn02">
				<tr>
					<td class="center">
						<%= buttonStr %>
						<input type="button" value="닫기" onclick="javascript:window.close();" class="boardbtn1">
					</td>
				</tr>
			</table>
			<!--// 하단 닫기 버튼  -->
		</td>
	</tr>
</table>

</form>
</body>
