<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%  
// prgnm : 직급구분코드 등록 
// date : 2008-05-14
// auth : 정 윤철
%>

<!-- [s] commonImport -->
<%@ include file="/commonInc/include/commonImport.jsp" %>
<!-- [e] commonImport -->

<%
    //request 데이터
	DataMap requestMap = (DataMap)request.getAttribute("REQUEST_DATA");
	requestMap.setNullToInitialize(true);       

	DataMap selectBoxMap = (DataMap)request.getAttribute("SELECTBOX_DATA");
	selectBoxMap.setNullToInitialize(true);
	
	//직급코드관리 셀렉트박스 리스트
	StringBuffer selectBoxList = new StringBuffer();
	for(int i=0;selectBoxMap.keySize("jikgubunnm") >i;i++){
		selectBoxList.append("<option value=\""+selectBoxMap.getString("jikgubun",i)+"\">"+selectBoxMap.getString("jikgubunnm",i)+"");
	}
	


%>
						
						
<!-- [s] commonHtmlTop include 필수 -->
<jsp:include page="/commonInc/include/commonHtmlTop.jsp" flush="false"/>
<!-- [e] commonHtmlTop include -->
<SCRIPT LANGUAGE="JavaScript">

	function go_exec(qu){
		if(NChecker($("pform"))){
			//db필드에 코드와 코드명 이 not null이기에 체크한다.
			//직급구분코드와 직급코드명은 셀렉박스의 값으로 넘어간다.
			if( $F("code") == ""){
				alert("코드를  입력하십시오");
				return false;
			}
			
			if( $F("codenm") == ""){
				alert("코드명을  입력하십시오");
				return false;
			}
			
			if(qu == "insert"){
				//등록모드
				if( confirm('등록 하시겠습니까?')){
					$("mode").value = "guBunCodeExec";
					$("qu").value = "insert";
					pform.submit();
				}
			}
		}
	}


//-->
</SCRIPT>

<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">

<form name="pform" action="/baseCodeMgr/position.do" method="post">
<input type="hidden" name="qu"		 	value="<%=requestMap.getString("qu")%>">
<input type="hidden" name="menuId" 		value="<%=requestMap.getString("menuId") %>">
<input type="hidden" name="mode" 		value="">
<input type="hidden" name="search" 		value="<%=requestMap.getString("search") %>">
<input type="hidden" name="currPage" 		value="<%=requestMap.getString("currPage") %>">

<table cellspacing="0" cellpadding="0" border="0" width="100%" height="100%">
	<tr><td height="4" bgcolor="#0081C4" nowrap></td></tr>
	<tr>
		<td height="45" bgcolor="#FFFFFF" style="padding-left:10px" nowrap>
			<!-- 타이틀영역-->
			<table cellspacing="0" cellpadding="0" border="0">
				<tr>
					<td width="15" align="left"><img src="/images/bullet_pop.gif" width="10" height="22" border="0"></td>
					<td><font color="#000000" style="font-weight:bold; font-size:13px">직급구분코드 등록</font></td>
				</tr>
			</table>
			<!-- /타이틀영역-->
		</td>
	</tr>
	<tr>
		<td height="100%" class="popupContents " valign="top">
			<!-- 본문영역-->
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr bgcolor="#375694">
					<td height="2" colspan="100%"></td>
				</tr>
				<tr>
					<td  class="tableline11" bgcolor="#E4EDFF" align="center"><strong>구분명</strong></td>
					<td class="tableline21" style="padding-left:10px">
						<select name="guBun">
							<%=selectBoxList.toString() %>
						</select>
					</td>
				</tr>
				<tr>
					<td class="tableline11" bgcolor="#E4EDFF" align="center"><strong>코드</strong></td>
					<td class="tableline21" style="padding-left:10px"><input class="textfield" type="text" maxlength="3" size="3" name="code" value="" dataform="num!숫자만 입력해야 합니다."></td>
				</tr>
				<tr>
					<td class="tableline11" bgcolor="#E4EDFF" align="center"><strong>코드명</strong></td>
					<td class="tableline21" style="padding-left:10px"><input class="textfield" maxlength="20" type="text"  name="codenm" value=""></td>
				</tr>
				<tr>
					<td class="tableline11" bgcolor="#E4EDFF" align="center"><strong>서열</strong></td>
					<td class="tableline21" style="padding-left:10px"><input class="textfield" type="text" size="3" maxlength="3" name="orders" value="" dataform="num!숫자만 입력해야 합니다."></td>
				</tr>
				<tr>
					<td class="" bgcolor="#E4EDFF" align="center"><strong>사용여부</strong></td>
					<td class="" style="padding-left:10px">&nbsp;Yes<input type="radio" name="useYn" value="Y" checked>&nbsp;&nbsp;No<input type="radio" name="useYn" value="N"></td>
				</tr>
				<tr bgcolor="#375694">
					<td height="2" colspan="100%"></td>
				</tr>
				<!-- space -->
				<tr><td height="10"></td></tr>
				<tr>
					<td colspan='3' align='center'><input type=button value='저장' onclick="go_exec('insert')" class=boardbtn1>&nbsp;&nbsp;<input type=button value='닫기' onClick=self.close(); class=boardbtn1></td>
				</tr>
			</table>
					
			<!-- /본문영역-->
		</td>
	</tr>

</table>

</form>
</body>

