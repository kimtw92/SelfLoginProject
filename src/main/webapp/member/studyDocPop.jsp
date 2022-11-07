<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%  
// prgnm : 학적정보 수정 팝업
// date : 2008-06-03
// auth : 정 윤철
%>

<!-- [s] commonImport -->
<%@ include file="/commonInc/include/commonImport.jsp" %>
<!-- [e] commonImport -->

<%
	
	DataMap requestMap = (DataMap)request.getAttribute("REQUEST_DATA");
	requestMap.setNullToInitialize(true);
	
	DataMap listMap = (DataMap)request.getAttribute("LIST_DATA");
	listMap.setNullToInitialize(true);
	
	DataMap eucactionlListMap = (DataMap)request.getAttribute("EDUCATIONLLIST_DATA");
	eucactionlListMap.setNullToInitialize(true);
	
	DataMap deptListMap = (DataMap)request.getAttribute("DEPTLIST_DATA");
	deptListMap.setNullToInitialize(true);
	
	String grseq = listMap.getString("a_grseq") + listMap.getString("b_grseq");
%>
<!-- [s] commonHtmlTop include 필수 -->
<jsp:include page="/commonInc/include/commonHtmlTop.jsp" flush="false"/>
<!-- [e] commonHtmlTop include -->

<SCRIPT LANGUAGE="JavaScript">
<!--
	function go_exec(){
		if(NChecker($("pform"))){
			if(confirm("수정 하시겠습니까?")){
				$("mode").value = "modifyStudyExec";
				pform.action = "/member/member.do";
				pform.submit();
			}
		}
	}
	
	function searchJikForm(){
		$("mode").value = "";
		pform.action = "/search/searchDept.do";
		var popWindow = popWin('about:blank', 'majorPop', '500', '350', 'no', 'no');
		pform.target = "majorPop";
		pform.submit();
		pform.target = "";
	}
	
//-->
</SCRIPT>

<body leftmargin="0" topmargin=0>
	<form name="pform">
	<input type="hidden" name="mode">
	<input type="hidden" name="qu">
	<input type="hidden" name="menuId" value="<%=requestMap.getString("menuId") %>">
	<!-- 유저넘버  -->

	<input type="hidden" name="userno" value="<%=listMap.getString("userno") %>">
	<!-- 유저 주민번호  -->
	<input type="hidden" name="resno" value="<%=requestMap.getString("resno") %>">
	<!-- 기관코드 -->
	<input type="hidden" name="grcode" value="<%=listMap.getString("grcode") %>">
	<!-- 과정년도기수 -->
	<input type="hidden" name="grseq" value="<%=grseq %>">
	<!-- 직급검색전 리턴시켜주어야할 위치를 지정 해주는 히든 값 t1 :  직급코드 t2 : 직급명 -->
	<input type="hidden" name="t1" value="pform.rjik">
	<input type="hidden" name="t2" value="pform.rjiknm">
	
	
    <table cellspacing="0"  cellpadding="0" border="0" style="padding:0 0 0 0" width="100%" height="100%">
        <tr><td height="4" bgcolor="#0081C4" nowrap></td></tr>
        <tr>
            <td height="45" bgcolor="#FFFFFF" style="padding-left:10px" nowrap>
                <!-- [s]타이틀영역-->
                <table cellspacing="0" cellpadding="0" border="0">
                    <tr>
                    	<td width="15" align="left"><img src="/images/bullet_pop.gif" width="10" height="22" border="0"></td>
						<td><font color="#000000" style="font-weight:bold; font-size:13px">개인별 학적부 자료수정</font></td>
                    </tr>
                </table>
                <!-- [e]타이틀영역-->
            </td>
        </tr>
        
        <tr>
            <td height="100%" class="popupContents " valign="top">
                <!-- [s]본문영역-->
				<table width="85%" border="0" align="center" cellpadding="0" cellspacing="0" >
					<tr bgcolor="#375694">
						<td height="2" colspan="100%"></td>
					</tr>
					<tr>
						<td colspan="100%" width="100%">
							<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" >
								<tr>
									<td height="30"  style="width:98px" class="tableline11" align="center" bgcolor="#E4EDFF">
									주민번호
									</td>
									<td height="30"  width="100" style="padding-left:10px" colspan=2 class="tableline21" align="left" bgcolor="#ffffff">
									<%=listMap.getString("rresno") %>
									</td>
									<td height="30" width="100" class="tableline11" align="center" bgcolor="#E4EDFF">
									이름
									</td>
									<td height="30" width="50" style="padding-left:10px" colspan=2 class="tableline21" align="left" bgcolor="#ffffff">
									<%=listMap.getString("rname") %>
									</td>
								</tr>
							</table>
						</td>
					</tr>
					<tr>
						<td colspan="100%" width="100%">
							<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" >
								<tr>
									<td height="30" style="width:98px" class="tableline11" align="center" bgcolor="#E4EDFF">
									학력
									</td>
									<td height="30" width="100" style="padding-left:10px"  colspan=2 class="tableline21" align="left" bgcolor="#ffffff">
										<select name="rschool">
										<option value="">==학력선택==</option>
										<%if(eucactionlListMap.keySize("gubun") > 0){ %>
										
											<% for(int i=0;eucactionlListMap.keySize() > i;i++){%>
											<option value="<%=eucactionlListMap.getString("gubun",i) %>"><%=eucactionlListMap.getString("gubunnm",i) %></option>
										<%	}
										} %>
										</select>
									</td>
									<td height="30" width="100" class="tableline11" align="center" bgcolor="#E4EDFF">
									과정명
									</td>
									<td height="30" style="padding-left:10px"  width="50" class="tableline21" align="left" bgcolor="#ffffff">
										<%=listMap.getString("grcodeniknm")%>
									</td>
								</tr>
							</table>
						</td>
					</tr>

					<tr>
						<td colspan="100%" width="100%">
							<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" >
								<tr>
									<td height="30" style="width:98px" class="tableline11" align="center" bgcolor="#E4EDFF">
									과정년도
									</td>
									<td height="30" width="100" style="padding-left:10px"  colspan=2 class="tableline21" align="left" bgcolor="#ffffff">
									<%=listMap.getString("a_grseq")%>
									</td>
									<td height="30" width="100" class="tableline11" align="center" bgcolor="#E4EDFF">
									과정기수
									</td>
									<td height="30" width="50" style="padding-left:10px"  colspan=2 class="tableline21" align="left" bgcolor="#ffffff">
									<%=listMap.getString("b_grseq")%>
									</td>
								</tr>
							</table>
						</td>
					</tr>
					<tr>
						<td colspan="100%" width="100%">
							<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" >
								<tr>
									<td height="30" style="width:98px" class="tableline11" align="center" bgcolor="#E4EDFF">
									교번
									</td>
									<td height="30" width="100"  colspan=2 style="padding-left:10px" class="tableline21" align="left" bgcolor="#ffffff">
									<%=listMap.getString("eduno")%>
									</td>
									<td height="30" width="100"  class="tableline11" align="center" bgcolor="#E4EDFF">
									수료번호
									</td>
									<td height="30" width="50"  colspan=2 style="padding-left:10px" class="tableline21" align="left" bgcolor="#ffffff">
									<input type=text class="textfield" maxlength="5" size="5" name="rno" value="<%=listMap.getString("rno")%>">
									</td>
								</tr>
							</table>
						</td>
					</tr>
					
					<tr>
						<td height="30"  style="width:67px" class="tableline11" align="center" bgcolor="#E4EDFF">
						소속
						</td>
						<td height="30"   style="padding-left:10px" colspan=2 class="tableline21" align="left" bgcolor="#ffffff">
						<select name=rdept>
						<option value="">==소속기관 선택==</option>
						<%if(deptListMap.keySize("dept") > 0){ %>
						
							<% for(int i=0;deptListMap.keySize("dept") > i;i++){%>
							<option value="<%=deptListMap.getString("dept",i) %>"><%=deptListMap.getString("deptnm",i) %></option>
						<%	}
						} %>
						</select>
						</td>
					</tr>

					<tr>
						<td height="30"  class="tableline11" align="center" bgcolor="#E4EDFF">
						부서명
						</td>
						<td height="30"  style="padding-left:10px"  colspan=2 class="tableline21" align="left" bgcolor="#ffffff">
						<input class="textfield" maxlength="14" type=text name=rdeptsub value="<%=listMap.getString("rdeptsub")%>">
						
						</td>
					</tr>

					<tr>
						<td height="30"  class="tableline11" align="center" bgcolor="#E4EDFF">
						직급
						</td>
						<td height="30"  colspan=2  style="padding-left:10px" class="tableline21" align="left" bgcolor="#ffffff">
						<input class="textfield" type=text name="rjiknm" value="<%=listMap.getString("rjiknm") %>" readonly>
						<input type=hidden name=rjik value="<%=listMap.getString("jik") %>">
						&nbsp;<input type=button value="검색" class='boardbtn1' onClick="searchJikForm();">
						
						</td>
					</tr>

					<tr>
						<td height="30"  class="tableline11" align="center" bgcolor="#E4EDFF">
						입교일
						</td>
						<td height="30"  colspan="2"  style="padding-left:10px" class="tableline21" align="left" bgcolor="#ffffff">
						<input class="textfield" type=text maxlength="8" size = "8" name=started  value="<%=listMap.getString("started")%>">
						
						</td>
					</tr>
					<tr>
						<td height="30" width="" class="tableline11" align="center" bgcolor="#E4EDFF">
						수료일
						</td>
						<td height="30" width="" colspan=2  style="padding-left:10px"  class="tableline21" align="left" bgcolor="#ffffff">
						<input type=text class="textfield" maxlength="8" size = "8" name="enddate" value="<%=listMap.getString("enddate")%>">
						</td>
					</tr>


					<tr>
						<td height="30"  class="tableline11" align="center" bgcolor="#E4EDFF">
						총점
						</td>
						<td height="30"  colspan=2 style="padding-left:10px" class="tableline21" align="left" bgcolor="#ffffff">
						<input type=text maxlength="5" size = "5" class="textfield" name="paccept" value="<%=listMap.getString("paccept")%>">
						</td>
					</tr>


					<tr>
						<td height="30"  class="tableline11" align="center" bgcolor="#E4EDFF">
						석차
						</td>
						<td height="30"  colspan=2 style="padding-left:10px" class="tableline21" align="left" bgcolor="#ffffff">
						<input type=text maxlength="5" size = "5" class="textfield" name="seqno" value="<%=listMap.getString("seqno")%>">
						</td>
					</tr>


					<tr>
						<td height="30"  class="tableline11" align="center" bgcolor="#E4EDFF">
						총원
						</td>
						<td height="30"  colspan=2 style="padding-left:10px" class="tableline21" align="left" bgcolor="#ffffff">
						<input type=text class="textfield" maxlength="5" size = "5" name="totno" value="<%=listMap.getString("totno")%>">
						</td>
					</tr>


					<tr>
						<td height="30"  class="tableline11" align="center" bgcolor="#E4EDFF">
						수료구분
						</td>
						<td height="30"  colspan=2 style="padding-left:10px" class="tableline21" align="left" bgcolor="#ffffff">
						<select name="rgrayn">
						<OPTION VALUE="Y">수료
						<OPTION VALUE="N">미수료
						<OPTION VALUE="X">해당없음
						</select>
						
						</td>
					</tr>

					<tr>
						<td height="30"  class="tableline11" align="center" bgcolor="#E4EDFF">
						작성자
						</td>
						<td height="30"  colspan=2 class="tableline21" style="padding-left:10px" align="left" bgcolor="#ffffff">
						<input type=text maxlength="10" class="textfield" name="grman" value="<%=listMap.getString("grman")%>">
						</td>
					</tr>

					<tr>
						<td height="30"  class="tableline11" align="center" bgcolor="#E4EDFF">
						확인자
						</td>
						<td height="30"  colspan=2 class="tableline21" align="left" style="padding-left:10px" bgcolor="#ffffff">
						<input type=text maxlength="10" class="textfield" name="confirmman" value="<%=listMap.getString("confirmman")%>">
						</td>
					</tr>
					<tr bgcolor="#375694">
						<td height="2" colspan="100%"></td>
					</tr>
					<tr>
						<td height="10" colspan="100%"></td>
					</tr>
					<tr>
						<td colspan=3 align="center" bgcolor="#ffffff">
								<%if(!requestMap.getString("sessClass").equals("3")){ %>
								<input type=button name='btn' value=저장 class='boardbtn1' onClick=javascript:go_exec()>
								&nbsp;
								
								<%}else{ %>
									&nbsp;
								<%} %>
								<input type="button" name="close" value="닫기" onClick="window.close();" class="boardbtn1">
						</td>
					</tr>
					</table>

				<!-- [E]본문영역-->		
                
            </td>
        </tr>
	    
	</table>
	</form>
</body>
	
<SCRIPT LANGUAGE="JavaScript">
<!--
	//학력 셀렉티드
	 	var rschool = "<%=listMap.getString("rschool")%>";
	 	rschoolLen = $("rschool").options.length
		 for(var i=0; i < rschoolLen; i++) {
		     if($("rschool").options[i].value == rschool){
		      	$("rschool").selectedIndex = i;
			 }
	 	 }
	 	 
	 //기관 셀렉티드

	 	var rdept = "<%=listMap.getString("rdept")%>";
	 	rdeptLen = $("rdept").options.length
		 for(var i=0; i < rdeptLen; i++) {
		     if($("rdept").options[i].value == rdept){
		      	$("rdept").selectedIndex = i;
			 }
	 	 }
	 	 
//-->
</script>
	