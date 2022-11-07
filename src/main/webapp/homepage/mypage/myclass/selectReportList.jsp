<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
// prgnm 	: 과제물 리스트
// date		: 2008-08-28
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

StringBuffer sbListHtml = new StringBuffer();

String pageStr = "";
int iNum = 0;
if(listMap.keySize("subj") > 0){		
	for(int i=0; i < listMap.keySize("subj"); i++){
		
		sbListHtml.append("<tr>\n");
		sbListHtml.append("<td class=\"bl0\">"+(i+1)+"회</td>\n");
		
		sbListHtml.append("<td class=\"bl0\">");
		if (listMap.getString("displayYn",i).equals("Y")){
			sbListHtml.append("<a href=\"javascript:report_form('"+listMap.getString("subj",i)+"','"+listMap.getString("grcode",i)+"','"+listMap.getString("grseq",i)+"','"+listMap.getString("classno",i)+"','"+listMap.getString("dates",i)+"');\">")
			.append(listMap.getString("title",i))
			.append("</a>");
		} else {
			sbListHtml.append("<a href=\"javascript:alert('제출기간이 아닙니다.')\">")
			.append(listMap.getString("title",i))
			.append("</a>");
		}
		sbListHtml.append("</td>\n");
		
		sbListHtml.append("<td>");
		if (Util.getIntValue(listMap.getString("groupfileNo", i),0) > 0){
			sbListHtml.append("<a href=\"javascript:fileDownloadPopup("+listMap.getString("groupfileNo",i)+");\"><img src=\"/images/"+ skinDir+"/icon/icon_fileDwn.gif\" alt=\"한글file 첨부\" />\n");
		} 
		sbListHtml.append("</td>");
		
		sbListHtml.append("<td>"+listMap.getString("point",i)+"</td>\n");
		
		sbListHtml.append("<td class=\"bl0\">");
		if (listMap.getString("displayYn",i).equals("Y")){
			sbListHtml.append("<a href=\"javascript:report_form('"+listMap.getString("subj",i)+"','"+listMap.getString("grcode",i)+"','"+listMap.getString("grseq",i)+"','"+listMap.getString("classno",i)+"','"+listMap.getString("dates",i)+"');\">")
			.append("<img src=\"/images/"+skinDir+"/button/btn_submit04.gif\" alt=\"제출하기\" />")
			.append("</a>");
		} else {
			sbListHtml.append("<a href=\"javascript:alert('제출기간이 아닙니다.')\">")
			.append("<img src=\"/images/"+skinDir+"/button/btn_submit04.gif\" alt=\"제출하기\" />")
			.append("</a>");
		}
		sbListHtml.append("</td>\n");
		
		sbListHtml.append("<td>");
		if (listMap.getInt("rsGroupfileNo", i) > 1){
			sbListHtml.append("<a href=\"javascript:fileDownloadPopup("+listMap.getString("rsGroupfileNo",i)+");\"><img src=\"/images/"+ skinDir+"/icon/icon_fileDwn.gif\" alt=\"한글file 첨부\" />\n");
		} else {
			sbListHtml.append("--");
		}
		sbListHtml.append("</td>");
		
		sbListHtml.append("<td><a href=\"javascript:onView('"+listMap.getString("subj",i)+"','"+listMap.getString("grcode",i)+"','"+listMap.getString("grseq",i)+"','"+listMap.getString("classno",i)+"','"+listMap.getString("dates",i)+"');\"><img src=\"/images/"+skinDir+"/button/btn_opinion.gif\" alt=\"의견보기\" /></a></td>\n");
		
		sbListHtml.append("</tr>\n");
		
		iNum ++;

	}
}else{
	// 리스트가 없을때
	sbListHtml.append("<tr>\n");
	sbListHtml.append("<td colspan=\"7\">과제물이 없습니다</td>\n");
	sbListHtml.append("</tr>\n");
}
%>

<script language="JavaScript" type="text/JavaScript">
function onView(subj, grcode, grseq, classno, dates, userno){
	window.open('./myclass.do?mode=viewReport&grcode='+grcode+'&subj='+subj+'&grseq='+grseq+'&classno='+classno+'&dates='+dates,'REP_COMMENT','toolbar=no,location=no,status=no,menubar=no,scrollbars=yes,resizable=no,width=420,height=400,top=300,left=500')	
}

<!--
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
//-->
</script>

<body leftmargin="0" topmargin="0" marginwidth=0 marginheight="0" >

<form id="pforam" name="pform" method="post">
<!-- 필수 -->
<input type="hidden"  id="grcode" name="grcode"  value="<%=requestMap.getString("grcode") %>" />
<input type="hidden"  id="grseq" name="grseq"  value="<%=requestMap.getString("grseq") %>" />
<input type="hidden"  id="subj" name="subj"  value="<%=requestMap.getString("subj") %>" />
<input type="hidden"  id="classno" name="classno"  value="<%=requestMap.getString("classno") %>" />
<input type="hidden"  id="dates" name="dates"   />
<input type="hidden"  id="goto" name="goto"  />


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

			
						<!-- data -->
						<table class="bList01">	
						<colgroup>
							<col width="50" />
							<col width="*" />
							<col width="70" />
							<col width="50" />
							<col width="70" />
							<col width="70" />
							<col width="70" />
						</colgroup>
			
						<thead>
						<tr>
							<th class="bl0"><img src="/images/<%= skinDir %>/table/th_090501.gif" alt="회차" /></th>				
							<th><img src="/images/<%= skinDir %>/table/th_sbj.gif" alt="제목" /></th>
							<th><img src="/images/<%= skinDir %>/table/th_tfile.gif" alt="출제파일" /></th>
							<th><img src="/images/<%= skinDir %>/table/th_distribution.gif" alt="배점" /></th>
							<th><img src="/images/<%= skinDir %>/table/th_subjec01.gif" alt="과제물제출" /></th>
							<th><img src="/images/<%= skinDir %>/table/th_tfile02.gif" alt="제출파일" /></th>
							<th><img src="/images/<%= skinDir %>/table/th_opinion.gif" alt="평가의견" /></th>
						</tr>
						</thead>
			
						<tbody>
						<%=sbListHtml.toString() %>
						</tbody>
						</table>
						<!-- //data --> 
						<div class="BtmLine"></div>
						
						<div class="TbBttTxt01"></div>
						<div class="spaceNone"></div>
			
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