<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%  
// prgnm : 평가 담당자 > 평가점수관리 > 특수과목점수입력
// date : 2008-08-04
// auth : 최형준
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
	String optionList = (String)request.getAttribute("OPTION_LIST");
	String infoStr = (String)request.getAttribute("INFO_STR");
	String langOption =(String)request.getAttribute("LANG_OPTION");
	String confButton =(String)request.getAttribute("CONF_BUTTON");
	
	if(confButton.equals("OK")){
		confButton="<input type='button' value='저장' class='boardbtn1' onclick='submitQa("+requestMap.getString("spsubj_totpoint")+");'>";
	}
	
	String classList = "";
	
	if(!requestMap.getString("classList").equals("") ){
		classList=requestMap.getString("classList");
		
	}else{
		//데이터가 없을때의 처리가 없어서 해놓았습니다.
		//작성자 정윤철 작성일 9월 16일
		classList= "<tr height=\"100\"><td colspan=\"100%\" bgcolor=\"#FFFFFF\" align=\"center\" class=\"tableline21\"> 검색된 내역이 없습니다. </td></tr>";
	}
	

%>

<!-- [s] commonHtmlTop include 필수 -->
<jsp:include page="/commonInc/include/commonHtmlTop.jsp" flush="false"/>
<!-- [e] commonHtmlTop include -->
<head>
<script language="JavaScript" type="text/JavaScript">
<!--
	
	//comm Selectbox선택후 리로딩 되는 함수.
	function go_reload(){
		go_list();
	}
	//검색
	function go_search(){
		var f = document.pform;
		f.a_eval_method.value="";
		if (f.commGrcode.value =='') {
			alert('과정을 선택하세요');
			return;
		}
		if (f.commGrseq.value =='') {
			alert('기수를 선택하세요');
			return;
		}
		$("excelMode").value="";
		go_list();
	}
	//리스트
	function go_list(){		
		$("mode").value = "list";
		pform.method.value="post";
		pform.action = "/evalMgr/score.do";
		pform.submit();
	}

	function change_method (sel_obj) {
		var f = document.pform;
		$("excelMode").value="";
//		if (f.comm_grcode.value =='') {
//			alert('과정을 선택하세요');
//		return;
//		}
		if (f.commGrseq.value =='') {
				alert('기수를 선택하세요');
			return;
		}
		if (f.commSubj.value =='') {
				alert('과목을 선택하세요');
			return;
		}
		f.a_eval_method.value=sel_obj.value;
		go_list();
	}
		
	function submitQa(totpoint) {
		var f = document.pform;

		for(var i=0;i<pointObj.length;i++){
			if (pointObj[i].value > totpoint){				
				var j=i+1;
				alert(j+" 번째 입력하신 점수가 총점보다 큽니다. 저장할 수 없습니다.");
				return;
			}
		}
		if (confirm("저장하시겠습니까?")) {		
			var pointStr="";
			var classStr="";
			
			for(i=0; i <pointObj.length; i++){		 
					if( i>0){
						pointStr += "|";							
						classStr += "|";
					}	
					pointStr += pointObj[i].value;
					classStr += classnoObj[i].value; 
			}		

			$("pointStr").value=pointStr;
			$("classStr").value=classStr;
			
			pform.mode.value = f.a_eval_method.value;
			pform.method="post";
			pform.action = "/evalMgr/score.do";
			pform.submit();			
		}
	}
	
	//excel 출력
	function go_excel(){
		var f = document.pform;
		if (f.commGrcode.value =='') {
			alert('과정을 선택하세요');
			return;
		}
		if (f.commGrseq.value =='') {
			alert('기수를 선택하세요');
			return;
		}
		if(f.commSubj.value == ''){
			alert('과목을 선택하세요');
			return;
		}
		f.a_eval_method.value=f.ch_eval_method.value;
		$("excelMode").value="ok";
		go_list();
	}

-->
</script>
<script for="window" event="onload">
<!--
	var commYear = "<%= requestMap.getString("commYear") %>";
	var commGrCode = "<%= requestMap.getString("commGrcode") %>";
	var commGrSeq = "<%= requestMap.getString("commGrseq") %>";
	//var commSubj = "<%= requestMap.getString("commSubj") %>";
	
	var reloading = ""; 

	getCommYear(commYear);														// 년도
	getCommOnloadGrCode(reloading, commYear, commGrCode);						// 과정
	getCommOnloadGrSeq(reloading, commYear, commGrCode, commGrSeq);				// 기수
	//getCommOnloadSubj(reloading, commYear, commGrCode, commGrSeq, commSubj);	// 과목
//-->
</script>
</head>
<body>
<form id="pform" name="pform" method="post">
<input type="hidden" name="menuId"						value="<%=requestMap.getString("menuId")%>">
<input type="hidden" name="mode"							value="<%=requestMap.getString("mode")%>">
<input type="hidden" name="spsubj_totpoint"			value="<%=requestMap.getString("spsubj_totpoint") %>">
<input type="hidden" name="class_cnt" 					value="<%=requestMap.getString("class_cnt") %>">
<input type="hidden" name="a_eval_method"			value="<%=requestMap.getString("a_eval_method") %>">

<input type="hidden" name="pointStr"						value="">
<input type="hidden" name="classStr"						value="">
<input type="hidden" name="excelMode" value="">

<table cellspacing="0" cellpadding="0" border="0" width="100%" height="100%">
    <tr>
        <td width="211" height="86" valign="bottom" align="center" nowrap><img src="/images/incheon_logo.gif" width="192" height="56" border="0"></td>
        <td width="8" valign="top" nowrap><img src="/images/lefttop_bg.gif" width="8" height="86" border="0"></td>
        <td width="100%">
            <!--[s] 공통 top include -->
            <jsp:include page="/commonInc/include/commonAdminTopMenu.jsp" flush="false"/>
            <!--[e] 공통 top include -->
        </td>
    </tr>
    <tr>
        <td height="100%" valign="top" align="center" class="leftMenuIllust">
            <!--[s] 공통 Left Menu  -->
            <jsp:include page="/commonInc/include/commonAdminLeftMenu.jsp" flush="false"/>
            <!--[e] 공통 Left Menu  -->
        </td>

        <td colspan="2" valign="top" class="leftMenuBg">
          
            <!--[s] 경로 네비게이션-->
            <%= navigationStr %>            
            <!--[e] 경로 네비게이션-->
                                    
			<!--[s] 타이틀 -->
			<jsp:include page="/commonInc/include/commonAdminTitle.jsp" flush="false"/>
			<!--[e] 타이틀 -->


			<!-- subTitle -->
			<!-- space --><table width="100%" height="10"><tr><td></td></tr></table>
			<table width="100%" border="0" cellspacing="0" cellpadding="0" class="contentsSubTitleTable">
				<tr>
					<td height="20">
						<img src="/images/bullet003.gif" width="11" height="11" align="bottom">&nbsp;<strong>특수과목점수입력</strong>
					</td>
				</tr>
			</table>
			<!--// subTitle -->


			<!--[s] Contents Form  -->
			<table width="90%" align="center">
			<tr>
				<td>
					<%
					if(!requestMap.getString("sessClass").equals("7")){
					%>
					<table class="search01" align="center">			
					<tr>
						<th width="80" class="bl0">
							년도
						</th>
						<td width="20%">
							<div id="divCommYear" class="commonDivLeft">										
								<select name="commYear" onChange="getCommGrCode('subj');" class="mr10">
									<option value="">**선택하세요**</option>
								</select>
							</div>
						</td>
						<th width="80">
							과정명
						</th>
						<td>
	
							<div id="divCommGrCode" class="commonDivLeft">
								<select name="commGrcode" class="mr10">
									<option value="">**선택하세요**</option>
								</select>
							</div>
	
						</td>
						<td width="100" class="btnr" rowspan="2">
							<input type="button" value="검색" onclick="go_search();" class="boardbtn1"><br>
							<input type="button" value="Excel" onclick="go_excel();" class="boardbtn1">
						</td>
					</tr>
					<tr>
						<th class="bl0">
							기수명
						</th>
						<td>
							<div id="divCommGrSeq" class="commonDivLeft">
								<select name="commGrseq" class="mr10">
									<option value="">**선택하세요**</option>
								</select>
							</div>
						</td>
						<th class="bl0">
							과목
						</th>
						<td>
							<div id="divCommSubj2" class="commonDivLeft">										
								<select name="commSubj" style="width:250px;font-size:12px" onchange="javascript:go_search();">
									<option value="">**선택하세요**</option>
									<%=optionList %>
								</select>
							</div>
						</td>
					</tr>
					</table>
					<%
					}
					%>
					&nbsp;
					<table width="100%" cellpadding="0" cellspacing="0" border="0">					
					<tr> 
						<td>&nbsp;</td>
						<td colspan="10">
							<table width=100% border="0" cellpadding="0" cellspacing="0" >
							<tr bgcolor="ffffff"> 
								<td>
								&nbsp;
								</td>
								<td colspan="3" align=right>
								<%=infoStr %>	&nbsp;&nbsp;평가점수 입력
								&nbsp;&nbsp;
								<%
								if(!requestMap.getString("sessClass").equals("7")){
								%>
								<select name="ch_eval_method" onChange="change_method(this);">									
									<option value="person">개인별평가</option>
									<option value="class">반별평가</option>
									<%=langOption%>
								</select>
								&nbsp;&nbsp;
								<%}else{ %>
								<input type="hidden" name="ch_eval_method" value="person">
								<%} %>								
								<%=confButton.toString()%>
								</td>
							</tr>							
							<tr><td height="10"></td></tr>									
							</table>
						</td>
					</tr>
					</table>					 
					 	<table width="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="E5E5E5">
							<tr bgcolor="#375694"> 
								<td height="2" colspan="10"></td>
							</tr>
							<tr bgcolor="#5071B4"  height='28' > 
								<td  align='center' class="tableline11 white"><div align="center"><strong>No</strong></div></td>
								<td  align='center' class="tableline11 white"><div align="center"><strong>교번</strong></div></td>
								<td   align='center' class="tableline11 white"><div align="center"><strong>성명</strong></div></td>
								<td  align='center' class="tableline11 white"><div align="center"><strong>주민번호</strong></div></td>
								<td  align='center' class="tableline11 white"><div align="center"><strong>소속기관</strong></div></td>
								<td  align='center' class="tableline11 white"><div align="center"><strong>직급</strong></div></td>
								<td  align='center' class="tableline11 white"><div align="center"><strong>점수</strong></div></td>
							</tr>
							<%=classList %>
							<tr bgcolor="#5071B4">
								<td colspan="100%"></td>
							</tr>
							</table>
				</td>
			</tr>
			</table>
			<!--[e] Contents Form  -->

			<!-- space --><table width="100%" height="30"><tr><td></td></tr></table>
				                            
        </td>
    </tr>
</table>

<!--[s] bottom -->
<jsp:include page="/commonInc/include/commonAdminBottom.jsp" flush="false"/>
<!--[e] bottom -->
	
</form>
</body>
<script language="javascript" type="text/javascript">
document.pform.ch_eval_method.value='<%=requestMap.getString("a_eval_method")%>';
pointObj= document.getElementsByName('classPoint[]');
classnoObj= document.getElementsByName('h_classno[]');
</script>