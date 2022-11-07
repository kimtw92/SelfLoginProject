<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%  
// prgnm : 평가마스터 리스트 평가수설정 팝업
// date  : 2008-08-21
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
	DataMap grCodeLecNm=(DataMap)request.getAttribute("grCodeLecNm");//과정명,과목명
	grCodeLecNm.setNullToInitialize(true);
	DataMap evInfoGrseq=(DataMap)request.getAttribute("evInfoGrseq");//중간,최종,상시 평가여부 및 횟수
	evInfoGrseq.setNullToInitialize(true);
	DataMap closingMap=(DataMap)request.getAttribute("closingMap");//과정 종료 여부
	closingMap.setNullToInitialize(true);
	DataMap subjPtype=(DataMap)request.getAttribute("subjPtype");//
	subjPtype.setNullToInitialize(true);
	
	String mevalYn="";
	String levalYn="";
	String nevalCnt="0";
	String conf_button="";
	int totColspan =1;
	
	if(!evInfoGrseq.isEmpty()){
		mevalYn	 = evInfoGrseq.getString("mevalYn");//중간평가
		levalYn    = evInfoGrseq.getString("levalYn");//최종평가
		nevalCnt   = evInfoGrseq.getString("nevalCnt");//상시평가		
	} 
	
	// 오늘 날짜 받아옴
	String getToday =  new java.text.SimpleDateFormat("yyyyMMdd").format(new Date()); 
	//과정 종료 여부에 따른 버튼
	if ( closingMap.getString("closing").equals("Y") || Integer.parseInt(closingMap.getString("endday")) < Integer.parseInt(getToday) ) {
		conf_button ="";
	} else {
		conf_button ="<input type='button' value='확인' onclick=\"javascript:go_action('subjevl');\" class='boardbtn1'>";
	}
	
	String mevalSubjYn="";
	String levalSubjYn="";
	DataMap evalSubj=new DataMap();
	DataMap nevalArr=new DataMap();	
	nevalArr.setNullToInitialize(true);

	//중간/최종 부분 설정
	if(!subjPtype.isEmpty()){
		for(int i=0;i<subjPtype.keySize("ptype");i++){
			String ptype=subjPtype.getString("ptype",i);
			evalSubj.addString(ptype,"Y");
			if(ptype.equals("M")) mevalSubjYn="Y";
			if(ptype.equals("T"))	levalSubjYn="Y";
		}
	}		
		
	for (int i=1; i<=Integer.parseInt(nevalCnt); i++) {
		nevalArr.addString("ptypeYn",evalSubj.getString(""+i+""));
		nevalArr.addInt("ptypeKey",i);		
	}	
	//테이블의 TH colspan 값
	if (mevalYn.equals("Y")) totColspan=totColspan +1;
	if (levalYn.equals("Y")) totColspan=totColspan+1;
	totColspan = totColspan + Integer.parseInt(nevalCnt);
	//상시평가 부분
	String thStr="";
	String tdStr="";
	if(!nevalArr.isEmpty()){
		for(int i=0;i<nevalArr.keySize("ptypeYn");i++){ 
			thStr +="<th>상시"+nevalArr.getString("ptypeKey",i) +"회</th>";
			tdStr +="<td>"; 
			tdStr +="<select name=ptype"+nevalArr.getString("ptypeKey",i)+">";
				
			if(nevalArr.getString("ptypeYn",i).equals("Y")){
		    	tdStr +="<option value='N'>No</option><option value='Y' selected>Yes</option>";
			}else{
				tdStr +="<option value='N'>No</option><option value='Y' >Yes</option>";
			}
			tdStr +="</td>";
		}
	} 
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
<body>
<form name="pform">
<input type="hidden" name="mode" value=""/>
<input type="hidden" name="commYear" 					value="<%=requestMap.getString("commYear") %>"/>
<input type="hidden" name="commGrcode" 				value="<%=requestMap.getString("commGrcode")%>"/>
<input type="hidden" name="commGrseq" 				value="<%=requestMap.getString("commGrseq")%>"/>
<input type="hidden" name="commSubj"					value="<%=requestMap.getString("commSubj") %>"/>
<input type="hidden" name="menuId"						value="<%=requestMap.getString("menuId")%>">

<table class="pop01">
	<tr>
		<td class="titarea">
			<!-- 타이틀영역 -->
			<div class="tit">
				<h1 class="h1"><img src="../images/bullet_pop.gif" /> 강의(과목기수)별 평가마스터</h1>
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
					<th class="br0" colspan="<%=totColspan %>">
						<%=evInfoGrseq.getString("grseq").substring(0,4) %>년&nbsp;&nbsp;
						<%=grCodeLecNm.getString("grcodenm")%>&nbsp;&nbsp;
						<%=evInfoGrseq.getString("grseq").substring(4,6) %>기수&nbsp;&nbsp;
						<%=grCodeLecNm.getString("lecnm") %>
					</th>
				</tr>
				<tr>
					<th>차시(회)</th>
					<%if(mevalYn.equals("Y")){ %>
					<th>중간평가</th>
					<%} 
						if(levalYn.equals("Y")){ %>
					<th>최종평가</th>
					<%} %>
					<%=thStr%> 
				</tr>
				</thead>

				<tbody>
				<tr>
					<td height="30"  align="center" bgcolor="EEFCDD">
					평가여부
					</td>
					<%if(mevalYn.equals("Y")){ %><!-- 중간평가 -->
					<td>
						<select name="ptypeM" class="mr10">
							<%if(mevalSubjYn.equals("Y")){ %>
								<option value="N">No</option>
								<option value="Y" selected>Yes</option>
							<%}else{ %>
								<option value="N">No</option>
								<option value="Y">Yes</option>
							<%} %>
						</select>
					</td>
					<%} %>
					<%if(levalYn.equals("Y")){ %><!-- 최종평가 -->
					<td>
						<select name="ptypeT" class="mr10">
							<%if(levalSubjYn.equals("Y")){ %>
								<option value="N">No</option>
								<option value="Y" selected>Yes</option>
							<%}else{ %>
								<option value="N">No</option>
								<option value="Y">Yes</option>
							<%} %>
						</select>
					</td>
					<%} %>
					<%=tdStr %>				  
				</tr>
				</tbody>
			</table>
			<!-- //리스트  -->

			<!-- 하단 닫기 버튼  -->
			<table class="btn02">
				<tr>
					<td class="center">
						<%=conf_button %>
						<input type="button" value="닫기" onclick="self.close();" class='boardbtn1'>						
					</td>
				</tr>
			</table>
			<!--// 하단 닫기 버튼  -->
		</td>
	</tr>
</table>
</form>
</body>