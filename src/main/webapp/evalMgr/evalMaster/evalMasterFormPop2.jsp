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
   	DataMap grCodeLecNm=(DataMap)request.getAttribute("grCodeLecNm");//과정명, 과목명
   	grCodeLecNm.setNullToInitialize(true);
   	DataMap closingMap=(DataMap)request.getAttribute("closingMap");//과정종료여부
	closingMap.setNullToInitialize(true);
   	DataMap subjType=(DataMap)request.getAttribute("subjType");
	subjType.setNullToInitialize(true);
   	DataMap datesInfo=(DataMap)request.getAttribute("datesInfo");
	datesInfo.setNullToInitialize(true);
   	DataMap subjInfo=(DataMap)request.getAttribute("subjInfo");
	subjInfo.setNullToInitialize(true);

	String bf_ins_ptype="";
	String default_jscript="";
	DataMap ckPtypeMap=new DataMap();
	
	String optionList="";
	if(!datesInfo.isEmpty()){
		for(int i=0;i<datesInfo.keySize("dates");i++){
			optionList +="<option value='"+datesInfo.getString("dates",i)+"'>"+datesInfo.getString("dates",i)+"</option>";
		}
	}else{
		optionList="<option value='01'>전체</option>";
	}
	
	String r_eval_type="";

	for(int i=0;i<subjInfo.keySize("ptype");i++){
		String ck_ptype = subjInfo.getString("ptype",i);

		if (bf_ins_ptype.equals("")) bf_ins_ptype += "'"+ck_ptype+"'";
		else bf_ins_ptype += ",'"+ck_ptype+"'";
		
		String r_dates	= subjInfo.getString("dates",i);
		String r_partf	= subjInfo.getString("partf",i);
		String r_partt	= subjInfo.getString("partt",i);
		r_eval_type		= subjInfo.getString("evalType",i);
		
		DataMap temp=new DataMap();
		temp.setString("ptypeNm",subjInfo.getString("ptype_nm",i));
		temp.setString("dates_op","<select name='dates_"+ck_ptype+"'>"+optionList+"</select>");
		temp.setString("partf_op","<select name='partf_"+ck_ptype+"'>"+optionList+"</select>");
		temp.setString("partt_op","<select name='partt_"+ck_ptype+"'>"+optionList+"</select>");
		
		String eval_type_op="";
		eval_type_op+="<select name='eval_type_"+ck_ptype+"'>";
		if (r_eval_type.equals("S")) {	// 과목		
			eval_type_op+="<option value='G'>과정</option>";
			eval_type_op+="<option value='S' selected>과목</option>";
		} else {	// 과정
			eval_type_op+="<option value='G' selected>과정</option>";
			eval_type_op+="<option value='S'>과목</option>";
		}		
		eval_type_op+="</select>";
		
		temp.setString("eval_type_op",eval_type_op);
		
		default_jscript +="\n document.pform.dates_"+ck_ptype+".value='"+r_dates+"';";
		default_jscript +="\n document.pform.partf_"+ck_ptype+".value='"+r_partf+"';";
		default_jscript +="\n document.pform.partt_"+ck_ptype+".value='"+r_partt+"';";
		default_jscript +="\n document.pform.eval_type_"+ck_ptype+".value='"+r_eval_type+"';";
		
		ckPtypeMap.set(ck_ptype,temp);
	}
	
	DataMap jobPtype=new DataMap();
	if(!requestMap.getString("ptypeM").equals("") & requestMap.getString("ptypeM").equals("Y") || bf_ins_ptype.split("M").length>1){
		jobPtype.addString("ptype","M");
		jobPtype.addString("ptypeNm","중간");
	}
	if(!requestMap.getString("ptypeT").equals("") & requestMap.getString("ptypeT").equals("Y") || bf_ins_ptype.split("T").length>1){
		jobPtype.addString("ptype","T");	
		jobPtype.addString("ptypeNm","최종");
	}
	if(!requestMap.getString("ptype1").equals("") & requestMap.getString("ptype1").equals("Y") || bf_ins_ptype.split("1").length>1){
		jobPtype.addString("ptype","1");	
		jobPtype.addString("ptypeNm","상시1회");
	}
	if(!requestMap.getString("ptype2").equals("") & requestMap.getString("ptype2").equals("Y") || bf_ins_ptype.split("2").length>1){
		jobPtype.addString("ptype","2");	
		jobPtype.addString("ptypeNm","상시2회");
	}
	if(!requestMap.getString("ptype3").equals("") & requestMap.getString("ptype3").equals("Y") || bf_ins_ptype.split("3").length>1){
		jobPtype.addString("ptype","3");	
		jobPtype.addString("ptypeNm","상시3회");
	}
	if(!requestMap.getString("ptype4").equals("") & requestMap.getString("ptype4").equals("Y") || bf_ins_ptype.split("4").length>1){
		jobPtype.addString("ptype","4");	
		jobPtype.addString("ptypeNm","상시4회");
	}
	if(!requestMap.getString("ptype5").equals("") & requestMap.getString("ptype5").equals("Y") || bf_ins_ptype.split("5").length>1){
		jobPtype.addString("ptype","5");	
		jobPtype.addString("ptypeNm","상시5회");
	}
	
	int record_ordnum=0;
	DataMap recordList=new DataMap();
	DataMap temp=new DataMap();
	
	for (int i=0; i < jobPtype.keySize("ptype"); i++) {
		String ck_ptype = jobPtype.getString("ptype",i);
		temp=new DataMap();
		if((DataMap)ckPtypeMap.get(ck_ptype) != null){
			temp=(DataMap)ckPtypeMap.get(ck_ptype);	
		}
		if (bf_ins_ptype.split(ck_ptype).length>1) {	// 수정및 삭제작업		
			if (requestMap.getString(("ptype"+ck_ptype)).equals("N")) {	// 삭제작업
				temp.setString("jobMode","D");
			} else {	// 수정작업
				temp.setString("jobMode","U");
			}
		} else {	// 추가작업
			temp.setString("jobMode","I");
			temp.setString("ptypeNm",jobPtype.getString("ptypeNm",i));
			temp.setString("dates_op","<select name='dates_"+ck_ptype+"'>"+optionList+"</select>");
			temp.setString("partf_op","<select name='partf_"+ck_ptype+"'>"+optionList+"</select>");
			temp.setString("partt_op","<select name='partt_"+ck_ptype+"'>"+optionList+"</select>");			
			
			String eval_type_op="";	
			eval_type_op+="<select name='eval_type_"+ck_ptype+"'>";
			if (r_eval_type.equals("S")) {	// 과목
				eval_type_op += "<option value='G'>과정</option>";
				eval_type_op += "<option value='S' selected>과목</option>";
			} else {	// 과정				
				eval_type_op += "<option value='G' selected>과정</option>";
				eval_type_op += "<option value='S'>과목</option>";
			}
			eval_type_op += "</select>";
			temp.addString("eval_type_op",eval_type_op);
		}
		record_ordnum=record_ordnum+1;
		temp.setString("ptype",ck_ptype);
		temp.setString("cnt",String.valueOf(record_ordnum));
		recordList.set(ck_ptype,temp);	
	}
   	String conf_button="";
   	// 오늘 날짜 받아옴
	String getToday =  new java.text.SimpleDateFormat("yyyyMMdd").format(new Date()); 
	//과정 종료 여부에 따른 버튼
	if ( closingMap.getString("closing").equals("Y") || Integer.parseInt(closingMap.getString("endday")) < Integer.parseInt(getToday) ) {
		conf_button ="";
	} else {
		conf_button ="<input type='button' value='확인' onclick=\"javascript:go_action('subjevlMode');\" class='boardbtn1'>";
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
		var ptypeStr="";		

		for( i=0; i < ptypeObj.length; i++){		 
			if( i>0){
				ptypeStr += "|";						
			}	
			ptypeStr += ptypeObj[i].value;
		}		
		f.ptypeStr.value=ptypeStr;
		f.submit();
	}
//-->
</script>

</head>
<body>
<form name="pform" action="/evalMgr/evalMaster.do">
<input type="hidden" name="mode" value=""/>
<input type="hidden" name="commYear" 					value="<%=requestMap.getString("commYear") %>"/>
<input type="hidden" name="commGrcode" 				value="<%=requestMap.getString("commGrcode")%>"/>
<input type="hidden" name="commGrseq" 				value="<%=requestMap.getString("commGrseq")%>"/>
<input type="hidden" name="commSubj"					value="<%=requestMap.getString("commSubj") %>"/>
<input type="hidden" name="menuId"						value="<%=requestMap.getString("menuId")%>">

<input type="hidden" name="bf_ins_ptype"				value="<%=bf_ins_ptype %>"/>
<input type="hidden" name="ptypeStr"						value=""/>

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
						<th class="br0" colspan="6">
							<%=requestMap.getString("commGrseq").substring(0,4) %>년&nbsp;&nbsp;
							<%=grCodeLecNm.getString("grcodenm")%>&nbsp;&nbsp;
							<%=requestMap.getString("commGrseq").substring(4,6) %>기수&nbsp;&nbsp;
							<%=grCodeLecNm.getString("lecnm") %>
						</th>
					</tr>
					<tr>
						<th>순서</th>
						<th>평가유형</th>
						<th>평가차시(목차)</th>
						<th>범위지정</th>
						<th>평가분류</th>
						<th>삭제</th>
					</tr>				
				</thead>

				<tbody>
				<%				
					DataMap listMap=new DataMap();
					for (int i=0; i < jobPtype.keySize("ptype"); i++) {
						String ck_ptype = jobPtype.getString("ptype",i);
						if((DataMap)recordList.get(ck_ptype) != null){
							listMap=(DataMap)recordList.get(ck_ptype);	
				 %>
				<tr>
					<td><%=listMap.getString("cnt") %></td>
					<td><%=listMap.getString("ptypeNm") %></td>
					<td><%=listMap.getString("dates_op") %></td>
					<td><%=listMap.getString("partf_op") %><%=listMap.getString("partt_op") %></td>
					<td><%=listMap.getString("eval_type_op") %></td>
					<td>
							<%if(listMap.getString("jobMode").equals("D")){ %>
								<input type="hidden" name='del_<%=ck_ptype %>' value='D'>ⅴ
							<%}else{ %>
       							<input type="checkbox" name='del_<%=ck_ptype %>' value='D'>
							<%} %>													
						<input type="hidden" name="job_mode_<%=ck_ptype %>" value="<%=listMap.getString("jobMode")%>">
						<input type="hidden" name="ptype_key[]" value="<%=ck_ptype %>">
					</td>
				</tr>
				<%}
				}
				if(recordList.isEmpty()){ %>
				<tr>
					 <td height="22" colspan="6">등록된 평가마스터 정보가 없습니다.</td>
				</tr>
				<%} %>
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
<Script language='javascript'>
<%=default_jscript%>
ptypeObj=document.getElementsByName('ptype_key[]');
</script>