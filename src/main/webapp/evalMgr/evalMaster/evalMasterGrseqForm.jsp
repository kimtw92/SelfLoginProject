<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%  
// prgnm : 과정평가수 설정
// date : 2008-07-07
// auth : LYM
%>

<!-- [s] commonImport -->
<%@ include file="/commonInc/include/commonImport.jsp" %>
<!-- [e] commonImport -->

<%
    //request 데이터
	DataMap requestMap = (DataMap)request.getAttribute("REQUEST_DATA");
	requestMap.setNullToInitialize(true);       
	String curYear = requestMap.getString("commGrseq").substring(0,4);
	String curSeq = requestMap.getString("commGrseq").substring(4,6);
	//과정명조회
	DataMap GRCODE_NM = (DataMap)request.getAttribute("GRCODE_NM");
	GRCODE_NM.setNullToInitialize(true);
	//과정기수평가마스터조회
	DataMap GRSEQ_INFO = (DataMap)request.getAttribute("GRSEQ_INFO");
	GRSEQ_INFO.setNullToInitialize(true);
	//중간기말평가 평가횟수 조회
	DataMap PTYPE_INFO = (DataMap)request.getAttribute("PTYPE_INFO");
	PTYPE_INFO.setNullToInitialize(true);
	
	String mevalYn = GRSEQ_INFO.getString("mevalYn");
	String levalYn = GRSEQ_INFO.getString("levalYn");
	int nevalCnt = GRSEQ_INFO.getInt("nevalCnt");
	
	
	//중간 기말 평가횟수 배열	
	int pArray[] = new int[2];
	for(int i=0; i < PTYPE_INFO.keySize("gcnt"); i++){
		//중간 평가횟수
		if( PTYPE_INFO.getString("gptype", i).equals("M")) pArray[0] = PTYPE_INFO.getInt("gcnt", i);
		//최종평가횟수
		if( PTYPE_INFO.getString("gptype", i).equals("T")) pArray[1] = PTYPE_INFO.getInt("gcnt", i);
		
	}
	String mHtml = "";	
	
	if (pArray[0] > 0) {	// 중간평가
		mHtml ="<input type=hidden name=meval_yn value='Y'>Yes";
	} else if (mevalYn.equals("Y")) {
		mHtml ="<select name=meval_yn class=mr10><option value='N'>No</option><option value='Y' selected>Yes</option></select>";
	} else {
		mHtml ="<select name=meval_yn class=mr10><option value='N' selected>No</option><option value='Y'>Yes</option></select>";
	}	
	String tHtml = "";
	if (pArray[1] > 0) {	// 최종평가
		tHtml ="<input type=hidden name=leval_yn value='Y'>Yes";
	} else if (levalYn.equals("Y")) {
		tHtml ="<select name=leval_yn class=mr10><option value='N'>No</option><option value='Y' selected>Yes</option></select>";
	} else {
		tHtml ="<select name=leval_yn class=mr10><option value='N' selected>No</option><option value='Y'>Yes</option></select>";
	}	
	
	//상시평가횟수 조회
	DataMap MTYPE_INFO = (DataMap)request.getAttribute("MTYPE_INFO");
	MTYPE_INFO.setNullToInitialize(true);
	int mTypeCnt = MTYPE_INFO.getInt("mptype");


	int str_position = 0;

	if (mTypeCnt > 0) str_position = mTypeCnt;
	String nHtml = "";
	nHtml = "<select name='neval_cnt'>";
	for(int i=str_position; i <=5; i++){
		if (i == nevalCnt) nHtml += "<option value='"+i+"' selected>"+i+"회</option>";
		else nHtml += "<option value='"+i+"'>"+i+"회</option>";
	}
	nHtml += "</select>";	

%>


						
<!-- [s] commonHtmlTop include 필수 -->
<jsp:include page="/commonInc/include/commonHtmlTop.jsp" flush="false"/>
<!-- [e] commonHtmlTop include -->
<script language="JavaScript">
<!--





//-->
</script>
<script language="JavaScript" src="/AIViewer/AIScript.js"></script>

<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">

<form id="pform" name="pform" method="post">
<input type="hidden" name="menuId"				value="<%=requestMap.getString("menuId")%>">
<input type="hidden" name="mode"				value="<%=requestMap.getString("mode")%>">

<input type="hidden" name="qu"					value='<%=requestMap.getString("qu")%>'>

<table class="pop01">
	<tr>
		<td class="titarea">
			<!-- 타이틀영역 -->
			<div class="tit">
				<h1 class="h1"><img src="/images/bullet_pop.gif" /> 과정기수별 평가마스터</h1>
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
					<th class="br0" colspan="4"><%=curYear %>년  <%=GRCODE_NM.getString("grcodenm") %>  <%=curSeq %>기수</th>
				</tr>
				<tr>
					<th></th>
					<th>중간평가</th>
					<th>최종평가</th>
					<th class="br0">상시평가회수</th>
				</tr>
				</thead>

				<tbody>
				<tr>
					<td class="bg01">평가여부 </td>
					<td><%=mHtml %></td>
					<td><%=tHtml %></td>
					<td class="br0 sbj"><%=nHtml %></td>
				</tr>
				</tbody>
			</table>
			<!-- //리스트  -->

			<!-- 하단 닫기 버튼  -->
			<table class="btn02">
				<tr>
					<td class="center">
						<input type="button" value="닫기" onclick="fnSubjReg('oform');" class='boardbtn1'>
					</td>
				</tr>
			</table>
			<!--// 하단 닫기 버튼  -->
		</td>
	</tr>
</table>


</form>
<script language="JavaScript">
  document.write(tagAIGeneratorOcx);
</script>

</body>
