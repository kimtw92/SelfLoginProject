<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%  
// prgnm : 입교 현황 분석
// date : 2008-09-24
// auth : 정윤철
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

// 회원데이터
DataMap memberDamoMap = (DataMap)request.getAttribute("MEMBERDAMO_ROW");
if(memberDamoMap == null) memberDamoMap = new DataMap();
memberDamoMap.setNullToInitialize(true);

// 강사데이터
DataMap tutorDamoMap = (DataMap)request.getAttribute("TUTORDAMO_ROW");
if(tutorDamoMap == null) tutorDamoMap = new DataMap();
tutorDamoMap.setNullToInitialize(true);

// 강사 담당분야
StringBuffer sbTutorGubunHtml = new StringBuffer();
DataMap tutorGubunMap = (DataMap)request.getAttribute("TUTOR_GUBUN_LIST");
if(tutorGubunMap == null) tutorGubunMap = new DataMap();
tutorGubunMap.setNullToInitialize(true);

//출강현황
DataMap tutorClassInfo = (DataMap)request.getAttribute("TUTOR_CLASSINFO_LIST");
StringBuffer tutorClassHtml1 = new StringBuffer();
StringBuffer tutorClassHtml2 = new StringBuffer();
//값이 있는지 없는지 체크
int tutClass1 = 0;
int tutClass2 = 0;
if(tutorClassInfo.keySize() > 0){
	for(int i=0; tutorClassInfo.keySize() >i; i++){

		//주강사
		if(tutorClassInfo.getString("tgubun", i).equals("1")){
			tutClass1++;
			tutorClassHtml1.append("<tr>");
			tutorClassHtml1.append("	<td>"+tutorClassInfo.getString("gryear", i)+"</td>");
			tutorClassHtml1.append("	<td>"+tutorClassInfo.getString("grcodenm", i)+"</td>");
			tutorClassHtml1.append("	<td>"+tutorClassInfo.getString("subjnm", i)+"</td>");
			tutorClassHtml1.append("	<td>"+tutorClassInfo.getString("studytime", i)+"</td>");
			tutorClassHtml1.append("	<td>"+tutorClassInfo.getString("trat", i)+"</td>");
			tutorClassHtml1.append("	<td>"+(tutorClassInfo.getString("groupfileNo", i).equals("-1") ?  "<a href='javascript:fileDownloadPopup("+tutorClassInfo.getString("groupfileNo")+");'><img src=/images/compressed.gif border=0 valign='middle'></a>" : "&nbsp;" )+"</td>");
			tutorClassHtml1.append("	<td>&nbsp;</td>");
			tutorClassHtml1.append("<tr>");
		}
		
		//보조강사
		if(tutorClassInfo.getString("tgubun", i).equals("0")){
			tutClass2++;
			tutorClassHtml2.append("<tr>");
			tutorClassHtml2.append("	<td>"+tutorClassInfo.getString("gryear", i)+"</td>");
			tutorClassHtml2.append("	<td>"+tutorClassInfo.getString("grcodenm", i)+"</td>");
			tutorClassHtml2.append("	<td>"+tutorClassInfo.getString("subjnm", i)+"</td>");
			tutorClassHtml2.append("	<td>"+tutorClassInfo.getString("studytime", i)+"</td>");
			tutorClassHtml2.append("	<td>"+tutorClassInfo.getString("trat", i)+"</td>");
			tutorClassHtml2.append("	<td>"+(tutorClassInfo.getString("groupfileNo", i).equals("-1") ?  "<a href='javascript:fileDownloadPopup("+tutorClassInfo.getString("groupfileNo")+");'><img src=/images/compressed.gif border=0 valign='middle'></a>" : "&nbsp;" )+"</td>");
			tutorClassHtml2.append("	<td>&nbsp;</td>");
			tutorClassHtml2.append("<tr>");
		}

	}
	

}
//데이터가 없을경우 문구.
if(tutClass1 == 0){
	tutorClassHtml1.append("<tr>");
	tutorClassHtml1.append("<td colspan=\"100%\" align=\"center\" height=\"300\">등록된데이터가없습니다</td>");
	tutorClassHtml1.append("<tr>");
}

if(tutClass2 == 0){
	tutorClassHtml2.append("<tr>");
	tutorClassHtml2.append("<td colspan=\"100%\" align=\"center\" height=\"300\">등록된데이터가없습니다</td>");
	tutorClassHtml2.append("<tr>");
}

String type = (String)request.getAttribute("TYPE");

// 각종 전화번호
String[] aryHomeTel = new String[3];
String[] aryHp = new String[3];
String[] aryOfficeTel = new String[3];
String[] aryFax = new String[3];

for(int i=0; i < 3; i++){
	aryHomeTel[i] = "";
	aryHp[i] = "";
	aryOfficeTel[i] = "";
	aryFax[i] = "";
}


int stCount = 0;	
StringTokenizer stHomeTel = new StringTokenizer(memberDamoMap.getString("homeTel"), "-" );
StringTokenizer stHp = new StringTokenizer(memberDamoMap.getString("hp"), "-" );
StringTokenizer stOfficeTel = new StringTokenizer(memberDamoMap.getString("officeTel"), "-" );
StringTokenizer stFax = new StringTokenizer(tutorDamoMap.getString("fax"), "-" );

stCount = stHomeTel.countTokens();		
for(int i=0; i < stCount; i++){
	aryHomeTel[i] = stHomeTel.nextToken();		
}

stCount = stHp.countTokens();		
for(int i=0; i < stCount; i++){
	aryHp[i] = stHp.nextToken();		
}

stCount = stOfficeTel.countTokens();		
for(int i=0; i < stCount; i++){
	aryOfficeTel[i] = stOfficeTel.nextToken();		
}

stCount = stFax.countTokens();		
for(int i=0; i < stCount; i++){
	aryFax[i] = stFax.nextToken();		
}

//집전화번호
String homeTel = aryHomeTel[0]+"-"+aryHomeTel[1]+"-"+aryHomeTel[2];
if(aryHomeTel[0].equals("") && aryHomeTel[1].equals("") && aryHomeTel[2].equals("")){
	homeTel = "";
}

//팩스번호
String faxNumber = aryFax[0]+"-"+aryFax[1]+"-"+aryFax[2];
if(aryFax[0].equals("") && aryFax[1].equals("") && aryFax[2].equals("")){
	faxNumber = "";
}

//핸드폰번호
String hpNumber = aryOfficeTel[0]+"-"+aryOfficeTel[1]+"-"+aryOfficeTel[2];
if(aryOfficeTel[0].equals("") && aryOfficeTel[1].equals("") && aryOfficeTel[2].equals("")){
	hpNumber = "";
}

//사무실번호
String officeNumber = aryHp[0]+"-"+aryHp[1]+"-"+aryHp[2];
if(aryHp[0].equals("") && aryHp[1].equals("") && aryHp[2].equals("")){
	officeNumber = "";
}

// 학력
DataMap historyMap1 = (DataMap)request.getAttribute("TUTOR_HISTORY1");
if(historyMap1 == null) historyMap1 = new DataMap();
historyMap1.setNullToInitialize(true);

String[] aryHistory1 = new String[3];
for(int i=0; i < 3; i++){
	aryHistory1[i] = "";
}
if(historyMap1.keySize("ocinfo") > 0){
	for(int i=0; i < historyMap1.keySize("ocinfo"); i++){
		aryHistory1[i] = historyMap1.getString("ocinfo");
	}
}



// 전공분야
DataMap historyMap2 = (DataMap)request.getAttribute("TUTOR_HISTORY2");
if(historyMap2 == null) historyMap2 = new DataMap();
historyMap2.setNullToInitialize(true);
	
StringBuilder sbHistory2 = new StringBuilder();
int countByHistory2 = 0;

if(historyMap2.keySize("ocinfo") > 0){
	
	countByHistory2 = historyMap2.keySize("ocinfo");
	
	for(int i=0; i < historyMap2.keySize("ocinfo"); i++){
		sbHistory2.append(historyMap2.getString("ocinfo",i) + "<br>");
	}
}


// 경력사항
DataMap historyMap3 = (DataMap)request.getAttribute("TUTOR_HISTORY3");
if(historyMap3 == null) historyMap3 = new DataMap();
historyMap3.setNullToInitialize(true);

StringBuilder sbHistory3 = new StringBuilder();
int countByHistory3 = 0;

if(historyMap3.keySize("ocinfo") > 0){
	
	countByHistory3 = historyMap3.keySize("ocinfo");
	
	for(int i=0; i < historyMap3.keySize("ocinfo"); i++){
		sbHistory3.append("*"+historyMap3.getString("ocinfo",i) + "<br>");
	}
	
}




// 저서 및 주요논문
DataMap historyMap4 = (DataMap)request.getAttribute("TUTOR_HISTORY4");
if(historyMap4 == null) historyMap4 = new DataMap();
historyMap4.setNullToInitialize(true);

StringBuilder sbHistory4 = new StringBuilder();
int countByHistory4 = 0;

if(historyMap4.keySize("ocinfo") > 0){
	
	countByHistory4 = historyMap4.keySize("ocinfo");
	
	for(int i=0; i < historyMap4.keySize("ocinfo"); i++){
		sbHistory4.append(historyMap4.getString("ocinfo",i) + "<br>");
	}
	
}

//주민번호 앞에 6자리만 보여주고 뒤에는 *로 한다.
String resno1 = "";
if(!memberDamoMap.getString("resno").endsWith("")){
	resno1 = memberDamoMap.getString("resno")+"*******";
	
}
%>

<!-- [s] commonHtmlTop include 필수 -->
<jsp:include page="/commonInc/include/commonHtmlTop.jsp" flush="false"/>
<!-- [e] commonHtmlTop include -->

<script language="JavaScript" type="text/JavaScript">
<!--

function newSetPrintSettings() {
  try {
		factory.printing.header = ""; // Header에 들어갈 문장
		factory.printing.footer = ""; // Footer에 들어갈 문장
		factory.printing.portrait = true // true 면 가로인쇄, false 면 세로 인쇄
		factory.printing.leftMargin = 1.0 // 왼쪽 여백 사이즈
		factory.printing.topMargin = 10.0 // 위 여백 사이즈
		factory.printing.rightMargin = 1.0 // 오른쪽 여백 사이즈
		factory.printing.bottomMargin = 1.0 // 아래 여백 사이즈
		factory.printing.paperSource = "Manual feed"; // 종이 Feed 방식
	}catch (e)
	{
    	//alert('출력중 에러가 발생 하였습니다.');
    	return;
	}
}

function SetPrintSettings() {
	try {
		factory.printing.header = ""; // Header에 들어갈 문장
		factory.printing.footer = ""; // Footer에 들어갈 문장
		factory.printing.portrait = true // true 면 가로인쇄, false 면 세로 인쇄
		factory.printing.leftMargin = 0.0 // 왼쪽 여백 사이즈
		factory.printing.topMargin = 5.0 // 위 여백 사이즈
		factory.printing.rightMargin = 0.0 // 오른쪽 여백 사이즈
		factory.printing.bottomMargin = 5.0 // 아래 여백 사이즈
	//	factory.printing.SetMarginMeasure(2); // 테두리 여백 사이즈 단위를 인치로 설정합니다.
	//	factory.printing.printer = factory.printing.DefaultPrinter(); // 프린트 할 프린터 이름
	//	factory.printing.paperSize = "A4"; // 용지 사이즈
	//	factory.printing.paperSource = "Manual feed"; // 종이 Feed 방식
	//	factory.printing.collate = true; // 순서대로 출력하기
	//	factory.printing.copies = 1; // 인쇄할 매수
	//	factory.printing.SetPageRange(false, 1, 1); // True로 설정하고 1, 3이면 1페이지에서 3페이지까지 출력
	}catch (e)
	{
    	alert('출력중 에러가 발생 하였습니다.');
    	return;
	}
}

//-->
</script>
<body leftmargin="0" topmargin="0" marginwidth=0 marginheight="0" >

<script language="JavaScript">
<!--
//Scriptx Obj
com_printManager1();
com_printManager2();
com_printManager3();

//-->
</script>

<table cellspacing="0" cellpadding="0" border="0" width="100%" height="100%">
	<tr><td height="4" bgcolor="#0081C4" nowrap></td></tr>
	<tr>
		<td height="45" bgcolor="#FFFFFF" style="padding-left:10px" nowrap>
			<!-- 타이틀영역-->
			<table cellspacing="0" cellpadding="0" border="0">
				<tr>
					<td width="15" align="left"><img src="/images/bullet_pop.gif" width="10" height="22" border="0"></td>
					<td><font color="#000000" style="font-weight:bold; font-size:13px">강사 상세 정보</font></td>
				</tr>
			</table>
			<!-- /타이틀영역-->
		</td>
	</tr>
    <tr>
		<td height="100%" class="popupContents " valign="top">
			<!--[s] Contents Form  -->
			<table cellspacing="0" cellpadding="0" border="0" width="100%" class="contentsTable">
				<tr>
					<td>
						<table class="dataw01">
							<tr>
								<th colspan="2">이름(한글)</th>
								<td colspan="3"><%= memberDamoMap.getString("name") %>(<%= tutorDamoMap.getString("cname") %>)</td>
							</tr>
							<tr>
								<th width="17%" colspan="2">주민등록번호</th>
								<td colspan="3">
									<%=resno1.toString() %>
								</td>
							</tr>
							<tr>
								<th rowspan="3">주소</th>
								<th>(자택)</th>
								<td>
									<%= memberDamoMap.getString("homePost1") %>-<%= memberDamoMap.getString("homePost2") %>
									<br>
									<%= memberDamoMap.getString("homeAddr") %>	
								</td>
								<th>(전화)</th>
								<td><%= homeTel.toString() %></td>
							</tr>						
							<tr>
								<th>(직장)</th>
								<td>									
									<%= memberDamoMap.getString("officePost1") %>- <%= memberDamoMap.getString("officePost2") %>
									<br>
									<%= memberDamoMap.getString("officeAddr") %>
								</td>
								<th>전화</th>
								<td><%= officeNumber.toString() %></td>
							</tr>
							<tr>
								<th >(FAX)</th>
								<td colspan="100%"><%= faxNumber.toString() %></td>
							</tr>
							<tr >
								<th>연락처</th>
								<th>(핸드폰)</th>
								<td><%= hpNumber.toString() %></td>
								<th>(E-mail)</th>
								<td><%= memberDamoMap.getString("email") %></td>
							</tr>
							<tr>
								<th rowspan="4">학력 및 <br>담당 분야</th>
								<th>등급</th>
								<td><%= tutorDamoMap.getString("tlevel") %>급</td>
								<th>담당분야</th>
								<td><%= sbTutorGubunHtml.toString() %></td>
							</tr>
							<tr>
								<th>직업군</th>
								<td colspan="100%"><%= tutorDamoMap.getString("job") %></td>
							</tr>
							<tr>
								<th>소속</th>
								<td><%= tutorDamoMap.getString("tposition") %></td>
								<th>직위</th>
								<td><%= memberDamoMap.getString("jikwi") %></td>
							</tr>
							<tr>
								<th>학위</th>
								<td><%= aryHistory1[0] %><br>
									<%= aryHistory1[1] %><br>
									<%= aryHistory1[2] %>
								</td>
								<th>전공</th>
								<td><%= sbHistory2.toString() %></td>
							</tr>
							<tr>
								<th colspan="2">경력</th>
								<td colspan="3"><%= sbHistory3.toString() %></td>
							</tr>
							<tr>
								<th colspan="2">저서</th>
								<td colspan="3"><%= sbHistory4.toString() %></td>
							</tr>
							<tr height="300">
								<th colspan="2">출강현황</th>
								<td colspan="3" height="300">
									<table id="tutor1"  class="dataw01">
										<tr>
											<td colspan="7"><input type="button" onclick="displayOnOff('1')" class="boardbtn1" value="주강사내역"><input onclick="displayOnOff('2')" type="button" class="boardbtn1" value="보조강사내역"></td>											
										</tr>
										<tr>
											<th width="40">년도</th>
											<th width="200">과정명</th>
											<th width="100">강의 제목</th>
											<th width="40">강의<br> 시간</th>
											<th width="40">강의<br>평가</th>
											<th width="40">첨부<br>파일</th>
											<th>비고</th>
										</tr>
										<%=tutorClassHtml1.toString() %>
									</table>
									<table id="tutor2" class="dataw01" style="display:none" >
										<tr>
											<td colspan="7"><input type="button" onclick="displayOnOff('1')" class="boardbtn1" value="주강사내역"><input onclick="displayOnOff('2')" type="button" class="boardbtn1" value="보조강사내역"></td>											
										</tr>
										<tr>
											<th width="40">년도</th>
											<th width="200">과정명</th>
											<th width="100">강의 제목</th>
											<th width="40">강의<br> 시간</th>
											<th width="40">강의<br>평가</th>
											<th width="40">첨부<br>파일</th>
											<th>비고</th>
										</tr>
										<%=tutorClassHtml2.toString() %>
									</table>
																		
								</td>
							</tr>
							<tr>
								<th>은행정보</th><th>은행</th><td><%= tutorDamoMap.getString("bankname") %></td>
								<th>계좌번호</th><td><%= tutorDamoMap.getString("bankno") %></td>
							</tr>
						</table>
						
						<table class="btn01" style="clear:both;">
							<tr>
								<td align="center">
									<input type="button" value="출력" onclick="report_print();" class="boardbtn1">
									<input type="button" value="닫기" onclick="self.close();" class="boardbtn1">
								</td>
							</tr>
						</table>						
					
						<br><br><br>
					</td>
				</tr>
			</table>
			<!--[e] Contents Form  -->
				                            
        </td>
    </tr>
</table>
			<!--//[e] Contents Form  -->
<!--[ 코딩 끝 ] ------------------------------------------------------------------------------------------------------>
<SCRIPT LANGUAGE="JavaScript">
<!--
newSetPrintSettings();
//factory.printing.Preview();
factory.printing.Print(true, window);
//-->
</SCRIPT>