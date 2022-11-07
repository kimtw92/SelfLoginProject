<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%  
// prgnm : 용어사전 보기
// date  : 2008-06-02
// auth  : kang
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
	    
	////////////////////////////////////////////////////////////////////////////////////
	
	
	// 과목명
	DataMap rowMap = (DataMap)request.getAttribute("ROW_DATA");
	requestMap.setNullToInitialize(true);
	
	// 색인 데이타
	DataMap groupsMap = (DataMap)request.getAttribute("GROUPS_DATA");
	groupsMap.setNullToInitialize(true);
	
	String subjNM = " <b>[ " +  rowMap.getString("subjnm") + " ]</b> ";
	
	
	StringBuffer sbIndex = new StringBuffer();
	for(int i=0; i < groupsMap.keySize("groups"); i++){		
		sbIndex.append("<a href=\"javascript:fnIndex('" + groupsMap.getString("groups",i) + "');\">" + groupsMap.getString("groups",i) + "</a> ");
	}
	
	
%>


<!-- [s] commonHtmlTop include 필수 -->
<jsp:include page="/commonInc/include/commonHtmlTop.jsp" flush="false"/>
<!-- [e] commonHtmlTop include -->

<script language="JavaScript" type="text/JavaScript">

var groups = "가";

// 닫기
function fnCancel(){
	self.close();
}

function fnIndex(pindex){

	if(pindex == null){
		pindex = "가";
	}
	$("searchTxt").value = "";
	groups = pindex;
	fnSearch();
}

// 검색
function fnSearch(){

	
	var url = "dic.do";
	var pars = "mode=searchDic";
	pars += "&subj=<%= requestMap.getString("subj") %>";
	pars += "&searchTypes=" + $F("searchTypes");
	pars += "&searchTxt=" + $F("searchTxt");
	pars += "&groups=" + groups;
	
	var divID = "divList";
	
	var myAjax = new Ajax.Updater(
			{success: divID },
			url, 
			{
				method: "post", 
				parameters: pars,
				onLoading : function(){
					$(document.body).startWaiting('bigWaiting');
				},
				onSuccess : function(){						
					window.setTimeout( $(document.body).stopWaiting.bind( $(document.body) ), 500);
				},
				onFailure : function(){					
					window.setTimeout( $(document.body).stopWaiting.bind( $(document.body) ), 500);
					alert("데이타를 가져오지 못했습니다.");
				}				
			}
		);
}



</script>
<script for="window" event="onload">

	fnSingleSelectBoxByAjax("dicType", 
						"divTypes", 
						"searchTypes", 
						"types", 
						"typenm", 
						"", 
						"150", 
						"true", 
						"false", 
						"true");
						
	window.setTimeout( fnIndex, 500);

</script>

<body leftmargin="0" topmargin="0" marginwidth=0 marginheight="0" >

<form id="sform" name="sform" method="post">

<input type="hidden" name="menuId" 	value="<%=requestMap.getString("menuId")%>">
<input type="hidden" name="mode" id="mode" value="">


<table cellspacing="0" cellpadding="0" border="0" width="100%" height="100%">
	<tr><td height="4" bgcolor="#0081C4" nowrap></td></tr>
	<tr>
		<td height="45" bgcolor="#FFFFFF" style="padding-left:10px" nowrap>
			<!--[s] 타이틀 영역-->
			<table cellspacing="0" cellpadding="0" border="0">
				<tr>
					<td width="15" align="left"><img src="/images/bullet_pop.gif" width="10" height="22" border="0"></td>
					<td><font color="#000000" style="font-weight:bold; font-size:13px">용어사전 리스트 <%= subjNM %></font></td>
				</tr>
			</table>
			<!--[e] 타이틀 영역-->
		</td>
	</tr>
	<tr>
		<td height="100%" class="popupContents" valign="top" bgcolor="#E4E3E4">
		
			<!--[s] contents  -->			
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td height="20">
						<%= sbIndex.toString() %>
					</td>
				</tr>
			</table>

			
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr ><td height="5" colspan="100%"></td></tr>
				<tr bgcolor="#375694"><td height="2" colspan="100%"></td></tr>
				<tr height="28" bgcolor="F7F7F7" >
					<td width="100" align="center" class="tableline11"><strong>찾을 검색어 </strong></td>
					<td align="left" class="tableline11" bgcolor="#FFFFFF" style="padding:0 0 0 9">
						<input type="text" name="searchTxt" size="20" onKeyPress="if(event.keyCode == 13) { fnSearch(); return false;}">
					</td>
					<td width="100" align="center" class="tableline11"><strong>분류선택</strong></td>
					<td align="left" class="tableline21" bgcolor="#FFFFFF" style="padding:0 0 0 9">
						<div id="divTypes">
							<select name="searchTypes"></select>
						</div>
					</td>
					<td width="100" align="center" class="tableline21" bgcolor="#FFFFFF">
						<input type="button" name="btnSearch" value="검 색" onclick="fnSearch();" class="boardbtn1">
					</td>
				</tr>				
				<tr bgcolor="#375694"><td height="2" colspan="100%"></td></tr>
			</table>
			
			
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr ><td height="5" colspan="100%"></td></tr>
				<tr bgcolor="#375694"><td height="2" colspan="100%"></td></tr>
				<tr height="28" bgcolor="#5071B4">
					<td width="30%" align="center" class="tableline11 white"><strong>용 어</strong></td>					
					<td align="center" class="tableline11 white"><strong>설 명</strong></td>
				</tr>
				
				<tr>
					<td colspan="100%">					
						<div id="divList"></div>
					</td>
				</tr>
								
			</table>
			
		
			<!--[e] contents -->
		</td>
	</tr>
	<tr>
		<td height="50" align="center" nowrap>			
			<input type="button" name="btnCancel" value="닫 기" onclick="fnCancel();" class="boardbtn1">
		</td>
	</tr>
</table>


</form>
</body>
		

