<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
// prgnm 	: 숙제
// date		: 2008-09-30
// auth 		: jong03
%>

<%@ include file="/commonInc/include/commonImport.jsp" %>
<%@ include file="/commonInc/include/comInclude.jsp" %>
<jsp:include page="/commonInc/include/comHtmlTop.jsp" flush="false">
	<jsp:param name="cssName" value="layout" />
</jsp:include>
<script language="javascript" src="/commonInc/js/commonJs.js"></script>
<%


// 필수, request 데이타
DataMap requestMap = (DataMap)request.getAttribute("REQUEST_DATA");
requestMap.setNullToInitialize(true);


// 리스트
DataMap listMap = (DataMap)request.getAttribute("LIST_DATA");
listMap.setNullToInitialize(true);

%>

<script language="JavaScript" type="text/JavaScript">
// <!--
function report_form(subj, grcode, grseq, classno, dates)	{
	$("grcode").value = grcode;
	$("grseq").value = grseq;
	$("subj").value = subj;
	$("classno").value = classno;
	$("dates").value = dates;
	document.pform.action = "/mypage/myclass.do?mode=reportView";
	document.pform.submit();
}

function down_popup(gno, fno){
	window.open('/lib/FileComp/index_down.php?groupfile_no='+ gno +'&file_no='+ fno,'download','left=150, top=150, width=510, height=310, menubar=no, toolbar=no, scrollbars=no, status=no, resizable=no')
}

function go_save(){
	$("mode").value = "reportExec";
	pform.action = "/mypage/myclass.do?mode=reportExec";
	pform.submit();
}
//수정시 inno에 기존 파일 넣은 변수 및 함수.
var g_ExistFiles = new Array();
function OnInnoDSLoad(){

// document.InnoDS.RemoveAllFiles();

}

//-->
</script>

<body leftmargin="0" topmargin="0" marginwidth=0 marginheight="0" >

<form id="pform" name="pform" method="post" enctype="multipart/form-data">
<!-- 필수 -->
<input type="hidden"  name="grcode"  value="<%=requestMap.getString("grcode") %>" />
<input type="hidden"  name="grseq"  value="<%=requestMap.getString("grseq") %>" />
<input type="hidden"  name="subj"  value="<%=requestMap.getString("subj") %>" />
<input type="hidden"  name="classno"  value="<%=requestMap.getString("classno") %>" />
<input type="hidden"  name="dates"  value="<%=requestMap.getString("classno") %>" />
<input type="hidden"  name="mode"  value="<%=requestMap.getString("classno") %>" />
<input type="hidden"  name="goto"  />

<!-- INNO FILEUPLOAD 사용시 UPLOAD 경로 지정해줌.-->
<input type="hidden" name="INNO_SAVE_DIR"		value='<%=Constants.UPLOADDIR_HOMEPAGE%>'>
<div id="wrapper">
	<div id="dvwhset">
		<div id="dvwh">
		
			<!--[s] header -->
			<jsp:include page="/commonInc/include/comHeader.jsp" flush="false">
				<jsp:param name="topMenu" value="7" />
			</jsp:include>
			<!--[e] header -->						
			
			<div id="middle">			
				<!--[s] left -->
				<jsp:include page="/commonInc/include/comLeftMenu.jsp" flush="false">
					<jsp:param name="leftMenu" value="7" />
					<jsp:param name="leftIndex" value="1" />
				</jsp:include>
				<!--[e] left -->

				<!-- contentOut s ===================== -->
				<div id="subContentArear">
					<!-- content image
					<div id="contImg"><img src="/images/<%= skinDir %>/sub/img_cont00.jpg" alt="" /></div>
					//content image -->
			
					<!-- title/location -->
					<div id="top_title">
						<h1 id="title"><img src="/images/<%= skinDir %>/title/tit_mypage.gif" alt="마이페이지" /></h1>
						<div id="location">
						<ul> 
							<li class="home"><a href="">HOME</a></li>
							<li>마이페이지</li>
							<li>나의 강의실</li>
							<li class="on">과제물</li>
						</ul>
						</div>
					</div>
					<!-- title/location -->
					<div class="spaceTop"></div>
			
					<!-- content s ===================== -->
					<div id="content">
						<!-- title --> 
						<h2 class="h2L"><img src="/images/<%= skinDir %>/title/tit_lectureR01.gif" class="mr8" alt="나의강의실" /><img src="/images/<%= skinDir %>/title/tit_subject.gif" alt="과제물" /></h2>
						<!-- //title -->
						<div class="h15"></div>
			
						<!-- title --> 
						<h4 class="h4Ltxt"><%=listMap.getString("subjnm") %></h4>
						<!-- //title -->
						<div class="h9"></div>
			
						<!-- view -->
						<table class="bView01">	
						<tr>
							<th class="bl0">제목</th>
							<td ><%=listMap.getString("title") %></td>
							<th class="bl0">차시</th>
							<td><%=listMap.getString("dates") %>차시</td>
						</tr>
						<tr>
							<th class="bl0" width="75">첨부파일</th>
							<td colspan="3">
								<a href="javascript:fileDownloadPopup('<%=listMap.getString("groupfileNo") %>');"><img src="/images/<%=skinDir %>/button/btn_download2.gif" alt="다운로드" /></a><br/><br/>
                                <jsp:include page="/fileupload/multplFileSelector.jsp" flush="true"/>
							</td>
						</tr>
						<tr>
							<th class="bl0">기간</th>
							<td colspan="3">
								<%=listMap.getString("submstDate") + "일 " + listMap.getString("submstTime") + " 시 ~ " + listMap.getString("submedDate") + "일 " + listMap.getString("submedTime")+"시" %>
							</td>
						</tr>
						<tr>
							<th class="bl0">제출형식 내용</th>
							<td colspan="3">
								<%=StringReplace.convertHtmlDecode(listMap.getString("content")) %>
							</td>
						</tr>
						</table>	
						<!-- //view -->
			
						<!-- button -->
						<div class="btnRbtt">			
							<a href="javascript:go_save();"><img src="/images/<%=skinDir %>/button/btn_save01.gif" alt="저장" /></a>
							<a href="javascript:history.go(-1)"><img src="/images/<%=skinDir %>/button/btn_list02.gif" alt="리스트" /></a>
						</div>
						<!-- //button -->
						<div class="space"></div>
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