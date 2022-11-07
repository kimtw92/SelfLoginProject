<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%   
// prgnm : 교육수료증/상장발급
// date : 2008-07-11 
// auth : LYM
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

	String tmpStr = "";	
	//과정기수 정보.
	DataMap grseqRowMap = (DataMap)request.getAttribute("GRSEQ_ROW_DATA");
	grseqRowMap.setNullToInitialize(true);

	//리스트
	DataMap listMap = (DataMap)request.getAttribute("LIST_DATA");
	listMap.setNullToInitialize(true);

	StringBuffer listStr = new StringBuffer(); //리스트 결과 변수.
	for(int i=0; i < listMap.keySize("grcode"); i++){
		listStr.append("\n<tr>");	
		int tmpSeqno = listMap.getInt("seqno", i); //임시 석차
		String tmpPaccept = Util.getValue(listMap.getString("paccept", i), "0"); // 임시 총점
		String seqno = ""; //석차
		String paccept = ""; //총점	
		if( memberInfo.getSessClass().equals(Constants.ADMIN_SESS_CLASS_ADMIN)
				|| memberInfo.getSessClass().equals(Constants.ADMIN_SESS_CLASS_DEPT ) ){			
			seqno = tmpSeqno + "";
			paccept = tmpPaccept;			
		}else{
			if( tmpSeqno <= 3 && Double.parseDouble(tmpPaccept) >= 60){
				seqno = tmpSeqno + "";
				paccept = tmpPaccept;
			}else{
				seqno = "*";
				if( listMap.getString("rgrayn", i).equals("Y") && Double.parseDouble(tmpPaccept) == 60) 
					paccept = "*";
				else if( listMap.getString("rgrayn", i).equals("Y") && Double.parseDouble(tmpPaccept) > 0) 
					paccept = "60점 이상";
				else 
					paccept = "60점 미만";
			}		
		}
			
		//수료번호
		listStr.append("\n	<td>" + listMap.getString("rno", i) + "</td>");

		//상장
		tmpStr = listMap.getString("rawardno", i).equals("") ? "&nbsp;" : "<font color=red>" + listMap.getString("rawardno", i) + "</font>";
		listStr.append("\n	<td>" + tmpStr + "</td>");
		
		//CheckBox
		if(requestMap.getString("searchOrder").equals("seqno") && tmpSeqno <= 3)
			tmpStr = "checked";
		else
			tmpStr = "";
		tmpStr = "<input type='checkbox' name='chkUserno[]' class='chk_01' value='" + listMap.getString("userno", i) + "' "+tmpStr+">";
		listStr.append("\n	<td>" + tmpStr + "</td>");
		
		//아이디
		listStr.append("\n	<td>" + listMap.getString("userId", i) + "</td>");
		
		//주민번호
		//tmpStr = StringReplace.subString(listMap.getString("resno", i), 0, 6) + "-XXXXXXX";
		//listStr.append("\n	<td>" + tmpStr + "</td>");
		
		//소속
		listStr.append("\n	<td>" + listMap.getString("rdeptnm", i) + "</td>");
		
		//부서
		listStr.append("\n	<td>" + listMap.getString("rdeptsub", i) + "</td>");
		
		//직급명
		listStr.append("\n	<td>" + listMap.getString("rjiknm", i) + "</td>");
		
		//성명
		listStr.append("\n	<td>" + listMap.getString("rname", i) + "</td>");

		//교번
		listStr.append("\n	<td>" + listMap.getString("eduno", i) + "</td>");

		//석차
		listStr.append("\n	<td>" + seqno + "</td>");
		
		//성적
		listStr.append("\n	<td class='br0'>" + paccept + "</td>");
		
		listStr.append("\n</tr>");
	} //end for 

	//row가 없으면.
	if( listMap.keySize("grcode") <= 0){

		listStr.append("\n<tr>");
		listStr.append("\n	<td colspan='100%' class='br0' style='height:100px'>검색된 내용이 없습니다.</td>");
		listStr.append("\n</tr>");

	}

%>

<!-- [s] commonHtmlTop include 필수 -->
<jsp:include page="/commonInc/include/commonHtmlTop.jsp" flush="false"/>
<!-- [e] commonHtmlTop include -->

	<script language="JavaScript" type="text/JavaScript">
	<!--	
		//comm Selectbox선택후 리로딩 되는 함수.
		function go_reload(){
			go_list();
		}
		
		//검색
		function go_search(){
			go_list();
		}
		
		//리스트
		function go_list(){
			$("mode").value = "certi_ach";
			pform.action = "/courseMgr/certiResult.do";
			pform.submit();
		}
		
		//리스트 checkBox
		function listSelectAll() {
			var chkobj = document.getElementsByName("chkUserno[]");
			for(i=0; i < chkobj.length; i++){
				chkobj[i].checked = $("chkAll").checked;
			}
		}
		
		//수료증 출력
		function go_print1() {
			var check_cnt =0;
			var a_usernolist = '';
			if(!checkFormVal())
				return;
			if ($F("masterName") == '') {
				alert('교육원장명을 입력하세요.');
				$("masterName").focus();
				return;
			}
			var chkObj = document.getElementsByName("chkUserno[]");
			for(i=0; i < chkObj.length; i++){
				if (chkObj[i].checked == false) continue;
				v_userno = chkObj[i].value;
				a_usernolist = a_usernolist + v_userno + '|' ;
				check_cnt++;
			}
			if (check_cnt ==0) {
				alert('수료증 출력대상자를 선택하세요.');
				return;
			}
			popAI("http://<%= Constants.AIREPORT_URL %>/report/report_45.jsp?p_grcode="+$F("grcode")+"&p_grseq="+$F("grseq")+"&p_name=" + $F("masterName") + "&p_userno=" + a_usernolist);
		}
		
		//수료증 HTML
		function go_htmlView() {
			if(!checkFormVal())
				return;
			if ($F("masterName") == '') {
				alert('교육원장명을 입력하세요.');
				$("masterName").focus();
				return;
			}
			var checkCnt = 0;
			var chkObj = document.getElementsByName("chkUserno[]");
			for(i=0; i < chkObj.length; i++){
				if (chkObj[i].checked) 
					checkCnt++;
			}
			if(checkCnt <= 0){
				alert('수료증 출력대상자를 선택하세요.');
				return;
			}
			popWin("", "pop_ResultDocHtml", "1024", "1050", "1", "0");
			$("mode").value = "certi_html";
			$("qu").value = "";
			pform.target = "pop_ResultDocHtml";
			pform.action = "/courseMgr/certiResult.do";
			pform.submit();
			pform.target = "";
			//window.open('./certiform_rno.php?a_grcode={a_grcode}&a_grseq={a_grseq}&a_master_name='+a_master_name+'&a_userno='+a_usernolist,'CERTI_FORM','toolbar=yes,scrollbars=yes,top=200,left=300,width=1024,height=800');
		}
		
		//상장 출력
		function go_print2(mod){
			var msg = "";
			var checkCnt = 0;
			if(!checkFormVal())
				return;
			if ($F("masterName") == '') {
				alert('교육원장명을 입력하세요.');
				$("masterName").focus();
				return;
			}
			var chkObj = document.getElementsByName("chkUserno[]");
			for(i=0; i < chkObj.length; i++){
				if (chkObj[i].checked) 
					checkCnt++;	
			}
		
			if ($F("certino") != "")
				msg = "증서번호 " + $F("certino") + "번 부터 ";
				msg += "상장을 출력 하시겠습니까?";
			
			if (checkCnt > 0) {
				if( NChecker(document.pform) && confirm(msg) ){
					//선택이 되어있으면 상장을 입력하고 출력한다 (출력은 실행후 go_print3('AWARD_PRINT');로 호출됨.
					$("mode").value = "certi_exec";
					$("qu").value = "award_print";
					pform.target ="EXEC_IFRAME";
					pform.action = "/courseMgr/certiResult.do";
					pform.submit();
					pform.target ="";
				}
			} else {
				if (confirm(msg))
					go_print3("AWARD_PRINT");
			}
		}
		
		//출력 
		//mode = mas_print : 표창장 출력 
		//		award_print : 상장
		function go_print3(mode) {
			var check_cnt =0;
			var a_usernolist ='';
			if(!checkFormVal())
				return;
			if ($F("masterName") == '') {
				alert('교육원장명을 입력하세요.');
				$("masterName").focus();
				return;
			}
			var chkObj = document.getElementsByName("chkUserno[]");
			for(i=0; i < chkObj.length; i++){
				if (chkObj[i].checked == false) continue;
				v_userno = chkObj[i].value;
				a_usernolist = a_usernolist + v_userno + '|' ;
				check_cnt++;
			}
			if (mode == "MAS_PRINT") 
				popAI("http://<%= Constants.AIREPORT_URL %>/report/report_43.jsp?p_grcode="+$F("grcode")+"&p_grseq="+$F("grseq")+"&p_name="+$F("masterName")+"");
			else if (mode =='AWARD_PRINT') 
				popAI("http://<%= Constants.AIREPORT_URL %>/report/report_44.jsp?p_grcode="+$F("grcode")+"&p_grseq="+$F("grseq")+"&p_name="+$F("masterName")+"&p_userno=");	
		}
		
		//발급대장 출력
		function go_print4() {
			if ($F("grcode") == '') {
				alert('과정을 선택하세요.');
				return;
			}
			if ($F("grseq") == '') {
				alert('기수를 선택하세요.');
				return;
			}
			popAI("http://<%= Constants.AIREPORT_URL %>/report/report_42.jsp?p_grcode="+$F("grcode")+"&p_grseq="+$F("grseq")+"&p_orderby=" + $F("searchOrder"));
		}
		
		//Ajax 으로 상장일괄삭제 / 수료번호일괄삭제 / 수료번호재생성  실행.
		function go_action(qu){
			if(!checkFormVal())
				return;
			var confirmMsg = "";
			var resultMsg = "";
			var returnFunc = "";
			if (qu == "rawardno_del") {
				confirmMsg ='상장부여 정보를 삭제하시겠습니까?';
				resultMsg = "상장부여 정보가 삭제되었습니다.";	
			} else if (qu == "rno_del") {
				confirmMsg ='수료번호를 삭제하시겠습니까?';
				resultMsg = "수료번호가 삭제되었습니다.";	
			} else if (qu == "rno_add") {
				if(!NChecker(document.pform)){
					return;
				}
				confirmMsg ='수료번호를 재부여하시겠습니까?';
				resultMsg = "수료번호가 부여 되었습니다.";	
			} 	
			if (qu != "") {
				if (confirm(confirmMsg)) {	
					var objAjax = new Object();
					objAjax.url = "/courseMgr/certiResult.do";
					objAjax.pars = "mode=ajax_exec&qu="+qu+"&year="+ $F("year") +"&grcode="+ $F("grcode") + "&grseq=" + $F("grseq") + "&certino=" + $F("certino");
					objAjax.aSync = true; 
					objAjax.targetDiv = "";
					objAjax.successMsg = resultMsg;
					objAjax.successFunc = "go_reload();";
					objAjax.isLoadingYn = "Y";
					
					go_ajaxCommonObj(objAjax); //Ajax 통신.	
				}
			}
		}
		
		//과정 기수 및 교육원장 체크.
		function checkFormVal(){
			if ($F("year") == "") {
				alert('년도를 선택하세요.');
				return false;
			}
			if ($F("grcode") == '') {
				alert('과정을 선택하세요.');
				return false;
			}
			if ($F("grseq") == '') {
				alert('기수를 선택하세요.');
				return false;
			}
			return true;
		}
		
		//로딩시.
		onload = function()	{
			//정렬
			var searchOrder = '<%=requestMap.getString("searchOrder")%>';
			$("searchOrder").value = searchOrder;
			//상단 Onload시 셀렉트 박스 선택.
			var commYear = "<%= requestMap.getString("commYear") %>";
			var commGrCode = "<%= requestMap.getString("commGrcode") %>";
			var commGrSeq = "<%= requestMap.getString("commGrseq") %>";
			
			//*********************** reloading 하려는 항목을 적어준다. 리로딩을 사용하지 않으면 "" 그렇지 않으면(grCode, grSeq, grSubj)
			var reloading = "grSeq"; 
		
			/****** body 상단의 년도, 과정, 기수, 과목등의 select box가 있을경우 밑에 내용 실행. */
			getCommYear(commYear); //년도 생성.
			getCommOnloadGrCode(reloading, commYear, commGrCode);
			getCommOnloadGrSeq(reloading, commYear, commGrCode, commGrSeq);
		}
		
		function go_formChk(){
		
			go_search();
		}
	//-->
	</script>
	<script language="JavaScript" src="/AIViewer/AIScript.js"></script>

<body leftmargin="0" topmargin="0" marginwidth=0 marginheight="0" >
	<form id="pform" name="pform" method="post" onSubmit="go_formChk();return false;">
	
		<input type="hidden" name="menuId"				value="<%= requestMap.getString("menuId") %>">
		<input type="hidden" name="mode"				value="<%= requestMap.getString("mode") %>">
		<input type="hidden" name="qu"					value="">
		<input type="hidden" name="year"				value="<%= requestMap.getString("commYear") %>">
		<input type="hidden" name="grcode"				value="<%= requestMap.getString("commGrcode") %>">
		<input type="hidden" name="grseq"				value="<%= requestMap.getString("commGrseq") %>">
		
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
					<div class="h10"></div>
					<!--[s] Contents Form  -->
					<table cellspacing="0" cellpadding="0" border="0" width="100%"
						class="contentsTable">
						<tr>
							<td>
		
								<!-- 검색 -->
								<table class="search01">
									<tr>
										<th width="80" class="bl0">
											년도
										</th>
										<td width="20%">
											<div id="divCommYear" class="commonDivLeft">										
												<select name="commYear" onChange="getCommGrCode('grSeq');" class="mr10">
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
											<input type="button" value="검색" onclick="go_search();return false;" class="boardbtn1">
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
										<th>
											정렬
										</th>
										<td>
											<select name="searchOrder" class="mr10">
												<option value="eduno">교번순조회</option>
												<option value="seqno">성적순조회</option>
												<option value="dept">부서코드조회</option>
											</select>
										</td>
									</tr>
								</table>
								<!--//검색 -->	
								<div class="space01"></div>
		
								<table class="btn01">
									<tr>
										<td class="right">
											교육원장
											<input type="text" class="textfield" name="masterName" value="" style="width:80px" />
											증서시작번호
											<input type="text" class="textfield" name="certino" value="" style="width:50px" required="true!증서시작번호를 입력해주세요." dataform="num!증시시작번호를 숫자로 입력해주세요." >
											<input type="button" value="수료증출력" onclick="go_htmlView();" class="boardbtn1">
											<input type="button" value="상장출력" onclick="go_print2();" class="boardbtn1">
											<input type="button" value="표창장출력" onclick="go_print3('MAS_PRINT');" class="boardbtn1">
										</td>
									</tr>
								</table>
		
								<table class="btn01">
									<tr>
										<td class="right">
											<input type="button" value="상장일괄삭제" onclick="go_action('rawardno_del');" class="boardbtn1">
											<input type="button" value="수료번호일괄삭제" onclick="go_action('rno_del');" class="boardbtn1">
											<input type="button" value="수료번호재생성" onclick="go_action('rno_add');" class="boardbtn1">
											<input type="button" value="발급대장출력" onclick="go_print4();" class="boardbtn1">
										</td>
									</tr>
								</table>
								<div class="h5"></div>
								
								<!--[s] 리스트  -->
								<table class="datah01">
									<thead>
										<tr>
											<th>수료번호</th>
											<th>상장</th>
											<th>
												<input type="checkbox" class="chk_01" name="chkAll" onClick="listSelectAll();"value="Y" >
												선택
											</th>
											
											<th>ID</th>
											<!-- 
											<th>주민번호</th>
											 -->
											 
											<th>소속</th>
											<th>부서</th>
											<th>직급명</th>
											<th>성명</th>
											<th>교번</th>
											<th>순위</th>
											<th class="br0">총점</th>
										</tr>
									</thead>
									<tbody>
									<%= listStr.toString() %>
									</tbody>
								</table>
								<!--//[e] 리스트  -->
							</td>
						</tr>
					</table>
					<!--//[e] Contents Form  -->
					<div class="space_ctt_bt"></div>                            
		        </td>
		    </tr>
		</table>
		
		<!--[s] bottom -->
			<jsp:include page="/commonInc/include/commonAdminBottom.jsp" flush="false"/>
		<!--[e] bottom -->
		
	</form>
	
	<script language="JavaScript">
		//AI Report
		document.write(tagAIGeneratorOcx);
	</script>
	<iframe style="display:none" name="EXEC_IFRAME"></iframe>
</body>

