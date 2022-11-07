<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%  
// prgnm : 평가항목관리 평가배점변경 팝업
// date  : 2008-09-01
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
	DataMap exam=(DataMap)request.getAttribute("exam");
	exam.setNullToInitialize(true);
	String examList="";
	if(exam.keySize("exType") >0){
		for(int i=0;i<exam.keySize("exType");i++){
			examList +="<tr>";
			examList +="<td><input type=hidden name='ex_type[]' value='"+exam.getString("exType",i)+"'>"+exam.getString("exName",i)+"</td>";
			examList +="<td><input type='text' class='textfield' name='ex_point[]' value='0' style='width:30px' onBlur='javascript:goConfirm();'/></td>";
			examList +="<td><input type='text' class='textfield' name='ex_weight[]' value='0' style='width:30px' onBlur='javascript:goConfirm();'/></td>";
			examList +="<td><input type='text' class='textfield' name='ex_calval[]' value='0' style='width:30px' readonly /></td>";
			examList +="</tr>";
		}
	}else{
		examList="<tr><td height='30' colspan='4'>일괄 배점입력이 불가능합니다.</td></tr>";
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
		var f = document.form1;
		if (confirm('일괄수정 하시겠습니까?')) {
			batch_val();
			window.close();
		}
		
	}
	
	function batch_val() {
		var i =0;
		var j = 0;
		
		psubjObj = opener.document.getElementsByName('p_subj[]');
		pmgakpointObj = opener.document.getElementsByName('p_mgakpoint[]');
		pmgakweightObj	= opener.document.getElementsByName('p_mgakweight[]');
		pmjupointObj = opener.document.getElementsByName('p_mjupoint[]');
		pmjuweightObj	= opener.document.getElementsByName('p_mjuweight[]');
		plgakpointObj = opener.document.getElementsByName('p_lgakpoint[]');
		plgakweightObj	= opener.document.getElementsByName('p_lgakweight[]');
		pljupointObj = opener.document.getElementsByName('p_ljupoint[]');
		pljuweightObj	= opener.document.getElementsByName('p_ljuweight[]');
		
		pngakpoint1Obj = opener.document.getElementsByName('p_ngakpoint1[]');
		pngakweight1Obj	= opener.document.getElementsByName('p_ngakweight1[]');
		pnjupoint1Obj = opener.document.getElementsByName('p_njupoint1[]');
		pnjuweight1Obj	= opener.document.getElementsByName('p_njuweight1[]');
		
		pngakpoint2Obj = opener.document.getElementsByName('p_ngakpoint2[]');
		pngakweight2Obj	= opener.document.getElementsByName('p_ngakweight2[]');
		pnjupoint2Obj = opener.document.getElementsByName('p_njupoint2[]');
		pnjuweight2Obj	= opener.document.getElementsByName('p_njuweight2[]');
		
		pngakpoint3Obj = opener.document.getElementsByName('p_ngakpoint3[]');
		pngakweight3Obj	= opener.document.getElementsByName('p_ngakweight3[]');
		pnjupoint3Obj = opener.document.getElementsByName('p_njupoint3[]');
		pnjuweight3Obj	= opener.document.getElementsByName('p_njuweight3[]');
		
		pngakpoint4Obj = opener.document.getElementsByName('p_ngakpoint4[]');
		pngakweight4Obj	= opener.document.getElementsByName('p_ngakweight4[]');
		pnjupoint4Obj = opener.document.getElementsByName('p_njupoint4[]');
		pnjuweight4Obj	= opener.document.getElementsByName('p_njuweight4[]');
		
		pngakpoint5Obj = opener.document.getElementsByName('p_ngakpoint5[]');
		pngakweight5Obj	= opener.document.getElementsByName('p_ngakweight5[]');
		pnjupoint5Obj = opener.document.getElementsByName('p_njupoint5[]');
		pnjuweight5Obj	= opener.document.getElementsByName('p_njuweight5[]');
		
		
		pcal_mgakObj	= opener.document.getElementsByName('p_cal_mgak[]');
		pcal_mjuObj	= opener.document.getElementsByName('p_cal_mju[]');
		pcal_lgakObj	= opener.document.getElementsByName('p_cal_lgak[]');
		pcal_ljuObj	= opener.document.getElementsByName('p_cal_lju[]');
		
		pcal_ngak1Obj	= opener.document.getElementsByName('p_cal_ngak1[]');
		pcal_nju1Obj	= opener.document.getElementsByName('p_cal_nju1[]');
		
		pcal_ngak2Obj	= opener.document.getElementsByName('p_cal_ngak2[]');
		pcal_nju2Obj	= opener.document.getElementsByName('p_cal_nju2[]');
		
		pcal_ngak3Obj	= opener.document.getElementsByName('p_cal_ngak3[]');
		pcal_nju3Obj	= opener.document.getElementsByName('p_cal_nju3[]');
		
		pcal_ngak4Obj	= opener.document.getElementsByName('p_cal_ngak4[]');
		pcal_nju4Obj	= opener.document.getElementsByName('p_cal_nju4[]');
		
		pcal_ngak5Obj	= opener.document.getElementsByName('p_cal_ngak5[]');
		pcal_nju5Obj	= opener.document.getElementsByName('p_cal_nju5[]');
		
		
		pptype_mObj	= opener.document.getElementsByName('p_ptype_m[]');
		pptype_tObj	= opener.document.getElementsByName('p_ptype_t[]');
		pptype_1Obj	= opener.document.getElementsByName('p_ptype_1[]');
		pptype_2Obj	= opener.document.getElementsByName('p_ptype_2[]');
		pptype_3Obj	= opener.document.getElementsByName('p_ptype_3[]');
		pptype_4Obj	= opener.document.getElementsByName('p_ptype_4[]');		                                                               
		pptype_5Obj	= opener.document.getElementsByName('p_ptype_5[]');
		
		for (i=0; i < ex_typeObj.length; i++) {
			if (ex_typeObj[i].value == 'mgakpoint') {	// 중간객관식인경우
				
				for (j=0; j < psubjObj.length; j++) {
					
					

					if (pmgakpointObj[j].readOnly == false) pmgakpointObj[j].value = Number(ex_pointObj[i].value);
					if (pmgakweightObj[j].readOnly == false) pmgakweightObj[j].value = Number(ex_weightObj[i].value);
					
				}
			} 
			else if (ex_typeObj[i].value == 'mjupoint' ) {	// 중간주관식인경우
				for (j=0; j < psubjObj.length; j++) {
					
					if (pmjupointObj[j].readOnly == false) pmjupointObj[j].value = Number(ex_pointObj[i].value);
					if (pmjuweightObj[j].readOnly == false) pmjuweightObj[j].value = Number(ex_weightObj[i].value);
				}
			} 
			
			else if (ex_typeObj[i].value == 'lgakpoint') {	// 최종객관식인경우
				
				for (j=0; j < psubjObj.length; j++) {
					
					
					if (plgakpointObj[j].readOnly == false) plgakpointObj[j].value = Number(ex_pointObj[i].value);
					if (plgakweightObj[j].readOnly== false) plgakweightObj[j].value = Number(ex_weightObj[i].value);
					
				}
			} 
			else if (ex_typeObj[i].value == 'ljupoint' ) {	// 최종주관식인경우
				for (j=0; j < psubjObj.length; j++) {
					
					
					if (pljupointObj[j].readOnly == false) pljupointObj[j].value = Number(ex_pointObj[i].value);
					if (pljuweightObj[j].readOnly == false) pljuweightObj[j].value = Number(ex_weightObj[i].value);
				}
			} 
			
			else if (ex_typeObj[i].value == 'ngakpoint1') {	// 상시1회 객관식인경우
				
				for (j=0; j < psubjObj.length; j++) {
					
					
					if (pngakpoint1Obj[j].readOnly == false) pngakpoint1Obj[j].value = Number(ex_pointObj[i].value);
					if (pngakweight1Obj[j].readOnly == false) pngakweight1Obj[j].value = Number(ex_weightObj[i].value);
					
				}
			} 
			else if (ex_typeObj[i].value == 'njupoint1' ) {	// 상시1회 주관식인경우
				for (j=0; j < psubjObj.length; j++) {
					
					
					if (pnjupoint1Obj[j].readOnly == false) pnjupoint1Obj[j].value = Number(ex_pointObj[i].value);
					if (pnjuweight1Obj[j].readOnly == false) pnjuweight1Obj[j].value = Number(ex_weightObj[i].value);
				}
			} 
			

			
			else if (ex_typeObj[i].value == 'ngakpoint2') {	// 상시2회 객관식인경우
				
				for (j=0; j < psubjObj.length; j++) {
					

					if (pngakpoint2Obj[j].readOnly == false) pngakpoint2Obj[j].value = Number(ex_pointObj[i].value);
					if (pngakweight2Obj[j].readOnly == false) pngakweight2Obj[j].value = Number(ex_weightObj[i].value);
					
				}
			} 
			else if (ex_typeObj[i].value == 'njupoint3' ) {	// 상시3회 주관식인경우
				for (j=0; j < psubjObj.length; j++) {


					if (pnjupoint3Obj[j].readOnly == false) pnjupoint3Obj[j].value = Number(ex_pointObj[i].value);
					if (pnjuweight3Obj[j].readOnly == false) pnjuweight3Obj[j].value = Number(ex_weightObj[i].value);
				}
			} 
			
			else if (ex_typeObj[i].value == 'ngakpoint4') {	// 상시4회 객관식인경우
				
				for (j=0; j < psubjObj.length; j++) {


					if (pngakpoint4Obj[j].readOnly == false) pngakpoint4Obj[j].value = Number(ex_pointObj[i].value);
					if (pngakweight4Obj[j].readOnly == false) pngakweight4Obj[j].value = Number(ex_weightObj[i].value);
					
				}
			} 
			else if (ex_typeObj[i].value == 'njupoint5' ) {	// 상시5회 주관식인경우
				for (j=0; j < psubjObj.length; j++) {


					if (pnjupoint5Obj[j].readOnly == false) pnjupoint5Obj[j].value = Number(ex_pointObj[i].value);
					if (pnjuweight5Obj[j].readOnly == false) pnjuweight5Obj[j].value = Number(ex_weightObj[i].value);
				}
			} 
			
			
		}
		
		opener.goConfirm();

	}
	
	function goConfirm(){
		var i;
		//일반과목 배점정보
		if(<%=exam.getString("exCnt")%> >= 1){
			for(i=0;i<<%=exam.getString("exCnt")%>;i++){
				// 중간평가
				ex_calvalObj[i].value =  Math.round(Number(ex_pointObj[i].value) * Number(ex_weightObj[i].value)*100)/100;
			}
		}
	}
	
//-->
</script>

</head>
<body>
<form name="pform">
<table class="pop01">
	<tr>
		<td class="titarea">
			<!-- 타이틀영역 -->
			<div class="tit">
				<h1 class="h1"><img src="../images/bullet_pop.gif" /> 평가배점일괄 변경하기</h1>
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
					<th>평가구분</th>
					<th>문항수</th>
					<th>문항당배점</th>
					<th class="br0">문항수*배점</th>
				</tr>
				</thead>

				<tbody>
				<%=examList %>
				</tbody>
			</table>
			<!-- //리스트  -->

			<!-- 하단 닫기 버튼  -->
			<table class="btn02">
				<tr>
					<td class="center">
						<%=exam.getString("confButton") %>
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
<Script language='javascript'>
ex_typeObj = document.getElementsByName('ex_type[]');
ex_pointObj	= document.getElementsByName('ex_point[]');
ex_weightObj = document.getElementsByName('ex_weight[]');
ex_calvalObj	= document.getElementsByName('ex_calval[]');

goConfirm();
</script>