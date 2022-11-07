<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
// prgnm 	: 입교안내
// date		: 2008-08-07
// auth 	: kang
%>

<%@ include file="/commonInc/include/commonImport.jsp" %>
<%@ include file="/commonInc/include/comInclude.jsp" %>
<jsp:include page="/commonInc/include/comHtmlTop.jsp" flush="false">
	<jsp:param name="cssName" value="layout" />
</jsp:include>
<script language="javascript" src="/commonInc/js/commonJs.js"></script>
<%

//필수, request 데이타
DataMap requestMap = (DataMap)request.getAttribute("REQUEST_DATA");
requestMap.setNullToInitialize(true);

// 보드 뷰 
DataMap viewMap = (DataMap)request.getAttribute("BOARDVIEW_DATA");
requestMap.setNullToInitialize(true);

StringBuffer innerHtml = new StringBuffer();

if (viewMap.getInt("groupfileNo") > 0){
	
	DataMap fileGroup = (DataMap)viewMap.get("FILE_GROUP_LIST");
	
	if (fileGroup.keySize("groupfileNo") > 0){
		
		for(int i=0,l=fileGroup.keySize("groupfileNo");i<l;i++){
			
			String fileName =  fileGroup.getString("fileName");
			String extName = fileName.substring(fileName.indexOf(".")+1,fileName.length());
			
			if (!extName.equals("hwp") && !extName.equals("jpg")){
				extName = "fileDwn";
			}
			// 권한없음으로 나와서 임시로 처리함
			if (extName.equals("hwp")){
				extName = "han";
			}
						
			innerHtml.append("<a href=\"javascript:fileDownload('"+fileGroup.getInt("groupfileNo")+"', '"+fileGroup.getString("fileNo")+"');\">");
			innerHtml.append("<img src=\"/images/"+ skinDir +"/icon/icon_"+extName+".gif\" /><span class=\"vp2\">"+fileGroup.getString("fileName")+"</span>");
			innerHtml.append("</a>&nbsp;");
			//if ( i != 0 && i%4 == 0){
			//	innerHtml.append("<br />");
			//}
		}
	}
	
}

%>

<script language="JavaScript" type="text/JavaScript">
<!--

// 페이지 이동
function go_page(page) {
	$("currPage").value = page;
	fnList();
}

// 리스트
function fnList(){

	pform.action = "/homepage/support.do?mode=readList";
	pform.submit();
}
//리스트
function goSearch(){
	$("currPage").value = "1";
	pform.action = "/homepage/support.do?mode=readList";
	pform.submit();
}

function setDelete(){
	$("qu").value = "deleteBbsBoard";
	$("boardId").value = "READING";
	pform.action = "/homepage/support.do?mode=readExec";
	pform.submit();
}

function setModify(){
	$("qu").value = "modifyBbsBoard";
	$("boardId").value = "READING";
	pform.action = "/homepage/support.do?mode=readModify";
	pform.submit();
}
//-->
</script>

<body leftmargin="0" topmargin="0" marginwidth=0 marginheight="0" >

<form id="pform" name="pform" method="post">
<!-- 필수 -->
<input type="hidden" name="seq"		value="<%= requestMap.getString("seq") %>">
<input type="hidden" name="qu">
<input type="hidden" name="boardId">

<div id="wrapper">
	<div id="dvwhset">
		<div id="dvwh">
		
			<!--[s] header -->
			<jsp:include page="/commonInc/include/comHeader.jsp" flush="false">
				<jsp:param name="topMenu" value="5" />
			</jsp:include>
			<!--[e] header -->						
			
			<div id="middle">			
				<!--[s] left -->
				<jsp:include page="/commonInc/include/comLeftMenu.jsp" flush="false">
					<jsp:param name="leftMenu" value="4" />
					<jsp:param name="leftIndex" value="1" />
					<jsp:param name="leftSubIndex" value="5" />
				</jsp:include>
				<!--[e] left -->

				<!-- contentOut s ===================== -->
				<div id="subContentArear">
					<!-- content image -->
					<div id="contImg"><div id="contImg"><img src="/images/<%= skinDir %>/sub/img_cont03.gif" alt="학습지원" /></div></div>
					<!-- //content image -->
			
					<!-- title/location -->
					<div id="top_title">
						<h1 id="title"></h1>
						<div id="location">
						<ul> 
							<li class="home"><a href="">HOME</a></li>
							<li>열린광장</li>
							<li class="on">독서감상문</li>
						</ul>
						</div>
					</div>
					<!-- title/location -->
					<div class="spaceTop"></div>
			
					<!-- content s ===================== -->
					<div id="content">
						<!-- title --> 
						<!-- title --> 
						<h2 class="h2L" style="height:30px">독서감상문</h2>
						<!--div class="txtR">(<span class="txt_org">*</span> 필수입력사항)</div-->
						<!-- //title -->
						<div class="h9"></div>
						<!--div class="txtR">(<span class="txt_org">*</span> 필수입력사항)</div-->
						<!-- //title -->
						<div class="h9"></div>
			
						
			
						<!-- view -->
						<table class="bView01">	
						<tr>
							<th class="bl0" width="75"><img src="/images/<%= skinDir %>/table/th_wName01.gif" alt="작성자" /></th>
							<td width="320"><%=viewMap.getString("username", 0) %></td>
							<th width="75"><img src="/images/<%= skinDir %>/table/th_date.gif" alt="작성일" /></th>
							<td width="100"><%=viewMap.getString("regdate", 0) %></td>
						</tr>
						<tr>
							<th class="bl0"><img src="/images/<%= skinDir %>/table/th_sbj.gif" alt="제목" /></th>
							<td colspan="3">
								<%=viewMap.getString("title", 0) %>
							</td>
						</tr>
						<tr>
							<th class="bl0">패스워드</th>
							<td colspan="3">
								<input type="password" value="" name="passwd" class="input02 w160" />
							</td>
						</tr>
						<tr>
							<th class="bl0"><img src="/images/<%= skinDir %>/table/th_addfile01.gif" alt="첨부파일" /></th>
							<td colspan="3">
								<%=innerHtml.toString() %>
							</td>
						</tr>
						
						<tr>
							<td class="bl0 cont" colspan="4">
							<%=StringReplace.convertHtmlDecodeNamo(viewMap.getString("content", 0))%>
							</td>
						</tr>
						</table>	
						<!-- //view -->
			
						<!-- button -->
						<div class="btnRbtt">
							<a href="javascript:setModify();"><img src="/images/<%= skinDir %>/button/btn_revision.gif" alt="리스트" /></a>
							<a href="javascript:setDelete();"><img src="/images/<%= skinDir %>/button/btn_delete02.gif" alt="삭제" /></a>
							<a href="javascript:fnList();"><img src="/images/<%= skinDir %>/button/btn_list02.gif" alt="리스트" /></a>	
						</div>
						<!-- //button -->
						<div class="h80"></div>
					</div>
					<!-- //content e ===================== -->
			


				</div>
				<!-- //contentOut e ===================== -->

				<div class="spaceBtt"></div>
			</div>			
		</div>
		
		<div id="divQuickMenu" style="position:absolute; top:10; left:89%; width:90px; height:264px; z-index:1">
			<!--[s] quick -->
			<jsp:include page="/commonInc/include/comQuick.jsp" flush="false"/>
			<!--[e] quick -->
		</div>
	</div>
	<!--[s] footer -->
	<jsp:include page="/commonInc/include/comFoot.jsp" flush="false"/>
	<!--[e] footer -->
</div>

</form>
</body>	