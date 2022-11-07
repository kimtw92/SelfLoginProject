<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%  
// prgnm : 평가마스터 리스트 평가수설정 팝업
// date  : 2008-08-19
// auth  :  CHJ
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
	/////////////////////////////////////////////////////////////////////////////////////////////
	DataMap grCodenm=(DataMap)request.getAttribute("grCodenm");//과목명
	grCodenm.setNullToInitialize(true);
	DataMap evInfoGrseq=(DataMap)request.getAttribute("evInfoGrseq");//평가 여부 
	evInfoGrseq.setNullToInitialize(true);
	DataMap ptypeMap=(DataMap)request.getAttribute("ptypeMap");//중간/최종 평가  횟수
	ptypeMap.setNullToInitialize(true);
	DataMap mptypeMap=(DataMap)request.getAttribute("mptypeMap");//상시평가 횟수
	mptypeMap.setNullToInitialize(true);
	DataMap closingMap=(DataMap)request.getAttribute("closingMap");//종료여부
	closingMap.setNullToInitialize(true);

	String mevalYn="";
	String levalYn="";
	String nevalCnt="0";
	String actionMode="";
	
	if(!evInfoGrseq.isEmpty()){
		mevalYn	 = evInfoGrseq.getString("mevalYn");//중간평가
		levalYn    = evInfoGrseq.getString("levalYn");//최종평가
		nevalCnt   = evInfoGrseq.getString("nevalCnt");//상시평가
		actionMode ="grevl_edit";//수정모드
	} else actionMode ="grevl_ins";//입력모드
	
	String meval_list="";
	String leval_list="";
	String nevel_list="";
	String conf_button="";
	
	for(int i=0;i<ptypeMap.keySize("gptype");i++){
		ptypeMap.addString(ptypeMap.getString("gptype",i), ptypeMap.getString("gcnt",i));
	}
	//중간평가 여부 select Box
	if (!ptypeMap.getString("M").equals("") && !ptypeMap.getString("M").equals("0")) {
		meval_list ="<input type='hidden' name='mevalYn' value='Y'>Yes";
	} else if (mevalYn.equals("Y")) {
		meval_list ="<select name='mevalYn'><option value='N'>No</option><option value='Y' selected>Yes</option></select>";
	} else {
		meval_list ="<select name='mevalYn'><option value='N' selected>No</option><option value='Y'>Yes</option></select>";
	}	            
	//최종평가 여부 select Box
	if (!ptypeMap.getString("T").equals("") && !ptypeMap.getString("T").equals("0")) {
		leval_list ="<input type='hidden' name='levalYn' value='Y'>Yes";
	} else if (levalYn.equals("Y")) {
		leval_list ="<select name='levalYn'><option value='N'>No</option><option value='Y' selected>Yes</option></select>";
	} else {
		leval_list ="<select name='levalYn'><option value='N' selected>No</option><option value='Y'>Yes</option></select>";
	}	

	int optionCnt=0;
	if(!mptypeMap.getString("mytype").equals("0")){
		optionCnt=Integer.parseInt(mptypeMap.getString("mptype"));
	}            	
	//상시평가 횟수 select box
	nevel_list = "<select name='nevalCnt'>";
	for (int i=optionCnt ; i <= 2; i++) { //상시평가횟수
		if (i == Integer.parseInt(nevalCnt)){
			nevel_list += "<option value='"+i+"' selected>"+i+"회</option>";
		}
		else nevel_list += "<option value='"+i+"'>"+i+"회</option>";
	}
	nevel_list += "</select>";
	// 오늘 날짜 받아옴
	String getToday =  new java.text.SimpleDateFormat("yyyyMMdd").format(new Date()); 
	//과정 종료 여부에 따른 버튼
	if ( closingMap.getString("closing").equals("Y") || Integer.parseInt(closingMap.getString("endday")) < Integer.parseInt(getToday) ) {
		conf_button ="";
	} else {
		conf_button ="<input type='button' value='확인' onclick=\"javascript:go_action('"+actionMode+"');\" class='boardbtn1'>";
	}
	//과정 정보
	String infoStr=requestMap.getString("commGrseq").substring(0,4)+" "+grCodenm.getString("grcodenm")+" "+requestMap.getString("commGrseq").substring(4,6);
 %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<!-- [s] commonHtmlTop include 필수 -->
<!-- include 됨. -->
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<title>인천광역시인재개발원에 오신 것을 환영합니다.</title>

<link href="../commonInc/css/master_style.css" rel="stylesheet" type="text/css">
<link href="../commonInc/css/style2.css" rel="stylesheet" type="text/css">
<link href="../commonInc/css/protoload.css" rel="stylesheet" type="text/css">

<script language="javascript" src="commonInc/js/prototype-1.6.0.2.js"></script>
<script language="javascript" src="commonInc/js/commonJs.js"></script>
<script language="javascript" src="commonInc/js/NChecker.js"></script>
<script language="javascript" src="commonInc/js/category.js"></script>
<script language="javascript" src="commonInc/js/protoload.js"></script>
<script language="javascript" src="commonInc/inno/InnoDS.js"></script>
<script language="JavaScript">
<!--
	function go_action(mod){
		var f = document.pform;
		f.mode.value = mod;
		f.submit();
	}
//-->
</script>

</head>

<!-- [e] commonHtmlTop include -->
<body>
<form name="pform" >
<input type="hidden" name="mode" value=""/>
<input type="hidden" name="commYear" 					value="<%=requestMap.getString("commYear") %>"/>
<input type="hidden" name="commGrcode" 				value="<%=requestMap.getString("commGrcode")%>"/>
<input type="hidden" name="commGrseq" 				value="<%=requestMap.getString("commGrseq")%>"/>
<input type="hidden" name="menuId"						value="<%=requestMap.getString("menuId")%>">
<table class="pop01">
	<tr>
		<td class="titarea">
			<!-- 타이틀영역 -->
			<div class="tit">
				<h1 class="h1"><img src="../images/bullet_pop.gif" /> 과정기수별 평가마스터</h1>
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
					<th class="br0" colspan="4"><%=infoStr%></th>
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
					<td class="bg01">평가여부</td>
					<td><%=meval_list %></td>					
					<td><%=leval_list %></td>
					<td><%=nevel_list %></td>
				</tr>
				</tbody>
			</table>
			<!-- //리스트  -->

			<!-- 하단 닫기 버튼  -->
			<table class="btn02">
				<tr>
					<td class="center">
						<%=conf_button %>
						<input type="button" value="닫기" onclick="javascript:self.close();" class='boardbtn1'>
					</td>
				</tr>
			</table>
			<!--// 하단 닫기 버튼  -->
		</td>
	</tr>
</table>
</form>

</body>
