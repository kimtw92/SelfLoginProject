<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%  
// prgnm : 강사정보 팝업
// date  : 2008-07-03
// auth  : kang
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
	
	// 기본 정보
	DataMap baseMap = (DataMap)request.getAttribute("BASEINFO_ROW");
	if(baseMap == null) baseMap = new DataMap();
	baseMap.setNullToInitialize(true);
	
	// 경력사항
	DataMap historyMap = (DataMap)request.getAttribute("HISTORY_LIST");
	if(historyMap == null) historyMap = new DataMap();
	historyMap.setNullToInitialize(true);
	
	StringBuffer sbHistory1 = new StringBuffer();
	StringBuffer sbHistory2 = new StringBuffer();
	StringBuffer sbHistory3 = new StringBuffer();
	StringBuffer sbHistory4 = new StringBuffer();
	
	if(historyMap.keySize("ocgubun") > 0){
		for(int i=0; i < historyMap.keySize("ocgubun"); i++){
			
			if(historyMap.getString("ocgubun", i).equals("1")){
				sbHistory1.append("<li>* " + historyMap.getString("ocinfo", i) + "</li><br>");
			}
			if(historyMap.getString("ocgubun", i).equals("2")){
				sbHistory2.append("<li>* " + historyMap.getString("ocinfo", i) + "</li><br>");
			}
			if(historyMap.getString("ocgubun", i).equals("3")){
				sbHistory3.append("<li>* " + historyMap.getString("ocinfo", i) + "</li><br>");
			}
			if(historyMap.getString("ocgubun", i).equals("4")){
				sbHistory4.append("<li>* " + historyMap.getString("ocinfo", i) + "</li><br>");
			}
			
		}		
	}
	
	
	// 출강현황
	DataMap classMap_1 = (DataMap)request.getAttribute("CLASS_LIST2");
	if(classMap_1 == null) classMap_1 = new DataMap();
	classMap_1.setNullToInitialize(true);
	
	DataMap classMap_2 = (DataMap)request.getAttribute("CLASS_LIST1");
	if(classMap_2 == null) classMap_2 = new DataMap();
	classMap_2.setNullToInitialize(true);
	
	
	StringBuffer sbClass1 = new StringBuffer();
	StringBuffer sbClass2 = new StringBuffer();
	int xNum = 0;
	
	
	if(classMap_1.keySize("grcode") > 0){
		for(int i=0; i < classMap_1.keySize("grcode"); i++){
			
			if( classMap_1.getString("tgubun" , i).equals("1") ){
				sbClass1.append("<tr>");
				sbClass1.append("	<td class=\"in\">" + classMap_1.getString("gryear", i) + "</td>");
				sbClass1.append("	<td class=\"in\">" + classMap_1.getString("studydate", i) + "</td>");
				sbClass1.append("	<td class=\"in\" style=\"word-break:break-all;\" >" + classMap_1.getString("grcodenm", i) + "</td>");
				sbClass1.append("	<td class=\"in\">" + classMap_1.getString("subjnm", i) + " (" + classMap_1.getString("grseq", i) + ") </td>");
				
				if("201501".equals(classMap_1.getString("grseq", i))&& "10G0000039".equals(classMap_1.getString("grcode", i))) { // 201501 값 2시간 고정
					if("NUN0003768".equals(classMap_1.getString("subj", i)) || "NUN0004748".equals(classMap_1.getString("subj", i))) {
						sbClass1.append("	<td class=\"in\">2</td>");
					} else {
						sbClass1.append("	<td class=\"in\">" + classMap_1.getString("studytime", i) + "</td>");
					}
				} else {
					sbClass1.append("	<td class=\"in\">" + classMap_1.getString("studytime", i) + "</td>");
				}

				sbClass1.append("	<td class=\"in\">" + classMap_1.getString("trat", i) + "</td>");
				sbClass1.append("	<td class=\"in\">" + classMap_1.getString("total", i) + "</td>");
				sbClass1.append("	<td class=\"in\">&nbsp;</td>");
				sbClass1.append("	<td class=\"in br0\">&nbsp;</td>");
				sbClass1.append("</tr>");
			}
			
			if( classMap_1.getString("tgubun" , i).equals("0") ){
				sbClass2.append("<tr >");
				sbClass2.append("	<td class=\"in\">" + classMap_1.getString("gryear", i) + "</td>");
				sbClass2.append("	<td class=\"in\">" + classMap_1.getString("studydate", i) + "</td>");
				sbClass2.append("	<td class=\"in\" style=\"word-break:break-all;\" >" + classMap_1.getString("grcodenm", i) + "</td>");
				sbClass2.append("	<td class=\"in\" style=\"word-break:break-all;\" >" + classMap_1.getString("subjnm", i) + " (" + classMap_1.getString("grseq", i) + ") </td>");
				sbClass2.append("	<td class=\"in\">" + classMap_1.getString("studytime", i) + "</td>");
				sbClass2.append("	<td class=\"in\">" + classMap_1.getString("trat", i) + "</td>");
				sbClass2.append("	<td class=\"in\">" + classMap_1.getString("total", i) + "</td>");
				sbClass2.append("	<td class=\"in\">&nbsp;</td>");
				sbClass2.append("	<td class=\"in br0\">&nbsp;</td>");
				sbClass2.append("</tr>");
			}
			
			xNum ++;	
		}
		
	}
	
	
	/*
	if(classMap_2.keySize("grcode") > 0){
		for(int i=0; i < classMap_2.keySize("grcode"); i++){
			
			if( classMap_2.getString("tgubun" , i).equals("1") ){
				sbClass1.append("<tr>");
				sbClass1.append("	<td class=\"in\">" + classMap_2.getString("gryear", i) + "</td>");
				sbClass1.append("	<td class=\"in\">" + classMap_2.getString("studydate", i) + "</td>");
				sbClass1.append("	<td class=\"in\" style=\"word-break:break-all;\" >" + classMap_2.getString("grcodenm", i) + "</td>");
				sbClass1.append("	<td class=\"in\">" + classMap_2.getString("subjnm", i) + " (" + classMap_2.getString("grseq", i) + ") </td>");
				sbClass1.append("	<td class=\"in\">" + classMap_2.getString("studytime", i) + "</td>");
				sbClass1.append("	<td class=\"in\">" + classMap_2.getString("trat", i) + "</td>");
				sbClass1.append("	<td class=\"in\">"+classMap_2.getString("total", i)+"</td>");
				sbClass1.append("	<td class=\"in\">&nbsp;</td>");
				sbClass1.append("	<td class=\"in br0\">&nbsp;</td>");
				sbClass1.append("</tr>");
			}
			
			if( classMap_2.getString("tgubun" , i).equals("0") ){
				sbClass2.append("<tr >");
				sbClass2.append("	<td class=\"in\">" + classMap_2.getString("gryear", i) + "</td>");
				sbClass2.append("	<td class=\"in\">" + classMap_2.getString("studydate", i) + "</td>");
				sbClass2.append("	<td class=\"in\" style=\"word-break:break-all;\" >" + classMap_2.getString("grcodenm", i) + "</td>");
				sbClass2.append("	<td class=\"in\" style=\"word-break:break-all;\" >" + classMap_2.getString("subjnm", i) + " (" + classMap_2.getString("grseq", i) + ") </td>");
				sbClass2.append("	<td class=\"in\">" + classMap_2.getString("studytime", i) + "</td>");
				sbClass2.append("	<td class=\"in\">" + classMap_2.getString("trat", i) + "</td>");
				sbClass2.append("	<td class=\"in\">"+classMap_2.getString("total", i)+"</td>");
				sbClass2.append("	<td class=\"in\">&nbsp;</td>");
				sbClass2.append("	<td class=\"in br0\">&nbsp;</td>");
				sbClass2.append("</tr>");
			}
			
			xNum ++;
		}
	}
	*/
	
	if (xNum == 0){
		sbClass1.append("<tr>");
		sbClass1.append("	<td align=\"center\" style=\"height:100px\" colspan=\"100%\" class=\"br0\">내역이 없습니다.</td>");
		sbClass1.append("</tr>");
		
		sbClass2.append(sbClass1.toString());
	}
	
%>

<!-- [s] commonHtmlTop include 필수 -->
<jsp:include page="/commonInc/include/commonHtmlTop.jsp" flush="false"/>
<!-- [e] commonHtmlTop include -->

<script language="JavaScript" type="text/JavaScript">
<!--

function fnTab(pindex){
	if(pindex == "1"){
		$("divClass1").style.display = "";
		$("divClass2").style.display = "none";
	}else{
		$("divClass1").style.display = "none";
		$("divClass2").style.display = "";
	}
}

//-->
</script>
<script for="window" event="onload">
<!--

//-->
</script>

<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" >

<form id="sform" name="sform" method="post" enctype="multipart/form-data">

<input type="hidden" name="menuId" 	value="<%=requestMap.getString("menuId")%>">
<input type="hidden" name="mode" id="mode" value="<%=requestMap.getString("mode")%>">


<table class="pop01">
	<tr>
		<td class="titarea">
			<!-- 타이틀영역 -->
			<div class="tit">
				<h1 class="h1"><img src="../images/bullet_pop.gif" /> 강사 소개</h1>
			</div>
			<!--// 타이틀영역 -->
		</td>
	</tr>
	<tr>
		<td class="con">

			<!-- 상단 버튼  -->
			<table class="btn01">
				<tr>
					<td class="right">
						<input type="button" value="출력하기" onclick="printArea();" class="boardbtn1">
					</td>
				</tr>
			</table>
			<!--// 상단 버튼  -->

			<!-- date -->
			<div id="idPrint">
			<table  class="dataw01">
				<tr>
					<th colspan="2">성명</th>
					<td><%= baseMap.getString("name") %> ( <%= baseMap.getString("cname") %> ) </td>
					<th>(강사등록일)</th>
					<td>
						<%= baseMap.getString("indate") %>
					</td>
				</tr>
				<tr>
					<th width="120" colspan="2">주민등록번호</th>
					<td colspan="3"><%= baseMap.getString("resno") %></td>
				</tr>
				
				<tr>
					<th colspan="2">은행정보</th>
					<td>
						<%= baseMap.getString("bankname") %>
					</td>
					<th>계좌번호</th>
					<td>
						<%= baseMap.getString("bankno") %>
					</td>
				</tr>
				<tr>
					<th colspan="2">새주소</th>
					<td colspan="3">( <%= baseMap.getString("newhomepost")%>) <br/ > <%= baseMap.getString("newaddr1") %>&nbsp;<%= baseMap.getString("newaddr2") %></td>
					
					</td>
				</tr>

				<tr>
					<th rowspan="3">주소</th>
					<th>(자택)</th>
					<td style="word-break:break-all;">
						( <%= baseMap.getString("homePost") %> )<br><br>
						<%= baseMap.getString("homeAddr") %>
					</td>
					<th>(전화)</th>
					<td>
						<%= baseMap.getString("homeTel") %>
					</td>
				</tr>
				<tr>
					<th rowspan="2">(직장)</th>
					<td rowspan="2">
						( <%= baseMap.getString("officePost") %> )<br><br>
						<%= baseMap.getString("officeAddr") %>
					</td>
					<th>(전화)</th>
					<td>
						<%= baseMap.getString("officeTel") %>
					</td>
				</tr>
				<tr>
					
					<th>(FAX)</th>
					<td>
						<%= baseMap.getString("fax") %>
					</td>
				</tr>
				<tr>
					<th>연락처</th>
					<th>(핸드폰)</th>
					<td>
						<%= baseMap.getString("hp") %>
					</td>
					<th>(E-mail)</th>
					<td>
						<%= baseMap.getString("email") %>
					</td>
				</tr>
				<tr>
					<th rowspan="4">학력 및<br />담당분야</th>
					<th>등급</th>
					<td>
						<%= baseMap.getString("levelName") %>
					</td>
					<th>담당분야</th>
					<td>
						<%= baseMap.getString("gubunnm") %>
					</td>
				</tr>
				<tr>
					<th>직업군</th>
					<td colspan="3">
						<%= baseMap.getString("job") %>
					</td>
				</tr>
				<tr>
					<th>소속</th>
					<td>
						<%= baseMap.getString("tposition") %>
					</td>
					<th>직위</th>
					<td>
						<%= baseMap.getString("jikwi") %>
					</td>
				</tr>
				<tr>
					<th>학위</th>
					<td>
						<ul class="coment01">
							<%= sbHistory1.toString() %>
						</ul>
					</td>
					<th>전공</th>
					<td>
						<ul class="coment01">
							<%= sbHistory2.toString() %>
						</ul>
					</td>
				</tr>
				<tr>
					<th colspan="2">경력</th>
					<td colspan="3">
						<ul class="coment01">
							<%= sbHistory3.toString() %>
						</ul>
					</td>
				</tr>				
				<tr>
					<th colspan="2">저서</th>
					<td colspan="3">
						<ul class="coment01">
							<%= sbHistory4.toString() %>
						</ul>
					</td>
				</tr>
				<tr>
					<th colspan="2">출강현황</th>
					<td colspan="3">
						<br>
						<input type="button" id="btnGubun1" value="주강사 내역" 	onclick="fnTab('1');" class="boardbtn1">
						<input type="button" id="btnGubun2" value="보조강사 내역" 	onclick="fnTab('2');" class="boardbtn1">
						<br><br>
						
						<div id="divClass1" style="display:">
							<table class="intable" >						
								<tr>
									<th class="in" width="40" rowspan="2">년도</th>
									<th class="in" width="70" rowspan="2">강의일자</th>
									<th class="in" width="150" rowspan="2">과정명</th>
									<th class="in" width="150" rowspan="2">강의제목</th>
									<th class="in" width="60" rowspan="2">강의시간</th>
									<th class="in" width="60" colspan="2" style="padding-left:40px;">만족도</th>
									<th class="in" width="50" rowspan="2">첨부파일</th>
									<th class="in br0" width="40" rowspan="2">비고</th>
								</tr>
								<tr>
									<th class="in" width="60">리커트</th>
									<th class="in" width="60">매우만족+만족</th>
								</tr>
								<%= sbClass1.toString() %>
							</table>
						</div>
						
						<div id="divClass2" style="display:none">
							<table class="intable" >						
								<tr>
									<th class="in" width="40" rowspan="2">년도</th>
									<th class="in" width="70" rowspan="2">강의일자</th>
									<th class="in" width="150" rowspan="2">과정명</th>
									<th class="in" width="150" rowspan="2">강의제목</th>
									<th class="in" width="60" rowspan="2">강의시간</th>
									<th class="in" width="60" colspan="2">만족도</th>
									<th class="in" width="50" rowspan="2">첨부파일</th>
									<th class="in br0" width="40" rowspan="2">비고</th>
								</tr>
								<tr>
									<th class="in" width="60">리커트</th>
									<th class="in" width="60">매우만족+만족</th>
								</tr>
								<%= sbClass2.toString() %>					
							</table>
						</div>
						<br>
					</td>
				</tr>
				<tr>
					<th colspan="2">강사소개서 첨부파일</th>
					<td colspan="3">
					<% if(!baseMap.getString("groupfileNo").equals("0")) { %>
						<%=(!baseMap.getString("groupfileNo").equals("-1") ?  "<a href='javascript:fileDownloadPopup("+baseMap.getString("groupfileNo")+");'><img src=/images/compressed.gif border=0 valign='middle'></a>" : "&nbsp;" )%>
					<% } %>
					</td>
				</tr>						
			</table>
			</div>
			<!-- //date -->

			<!-- 하단 닫기 버튼  -->
			<table class="btn02">
				<tr>
					<td class="center">
						<input type="button" value="닫기" onclick="self.close();" class="boardbtn1">
					</td>
				</tr>
			</table>
			<!--// 하단 닫기 버튼  -->
		</td>
	</tr>
</table>

<script language="JavaScript"> 
var initBody;

 function beforePrint(){ 
	initBody = document.body.innerHTML;
	document.body.innerHTML = idPrint.innerHTML;
} 

function afterPrint(){
	document.body.innerHTML = initBody;
}

function printArea(){
	window.print();
} 

window.onbeforeprint = beforePrint;
window.onafterprint = afterPrint;

</script> 

</form>
</body>