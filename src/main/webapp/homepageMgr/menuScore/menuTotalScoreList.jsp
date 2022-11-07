<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- [s] commonImport -->
<%@ include file="/commonInc/include/commonImport.jsp" %>
<!-- [e] commonImport -->
<%
	
	////////////////////////////////////////////////////////////////////////////////////
	StringBuffer html = new StringBuffer();
	//리스트 데이터
	DataMap listMap = (DataMap)request.getAttribute("LIST_DATA");
	listMap.setNullToInitialize(true);
	if(listMap.keySize("menuscore") > 0){

		for(int i =0; i < listMap.keySize("menuscore"); i++){
			html.append("\n	<tr>");
			html.append("\n	<td align='center'><input style='width:100%;' type='text' value='"+(i+1)+"' /></td>");
			html.append("\n	<td align='center'><input style='width:100%;' type='text' value='"+listMap.getString("menuscorename", i)+"' /></td>");
			html.append("\n	<td align='center'><input style='width:100%;' type='text' value='"+listMap.getString("menuscore", i)+"' /></td>");
			html.append("\n	<td align='center'><input style='width:100%;' type='text' value='"+listMap.getString("opinion", i)+"' /></td>");
			html.append("\n	<td align='center'><input style='width:100%;' type='text' value='"+listMap.getString("userinfo", i)+"' /></td>");
			html.append("\n	<td align='center'><input style='width:100%;' type='text' value='"+listMap.getString("enterdate", i)+"' /></td>");
			html.append("\n	</tr>");
		}
	}else{
		html.append("\n	<tr>");
		html.append("\n	<td colspan=\"100%\" align=\"center\" class=\"br0\" style=\"height:100px;\">등록된 데이터가 없습니다.</td>");
		html.append("\n	</tr>");		
	}

%>

<script language="JavaScript" type="text/JavaScript">

//리스트
function go_list(){
	pform.action = "/homepageMgr/menuScore.do?mode=menuScoreList";
	pform.submit();
}

</script>


<body leftmargin="0" topmargin="0" marginwidth=0 marginheight="0" >

<form id="pform" name="pform" method="post">

<table cellspacing="0" cellpadding="0" border="0" width="100%" height="100%">
    <tr>
        <td height="100%" valign="top" align="center" class="leftMenuIllust">
        </td>

        <td colspan="2" valign="top" class="leftMenuBg">
          
                             

			<!--[s] subTitle -->
			<table width="100%" height="10"><tr><td></td></tr></table>
			<table width="100%" border="0" cellspacing="0" cellpadding="0" class="contentsSubTitleTable">			
				<tr>
					<td height="20">
						<img src="/images/bullet003.gif"  align="bottom">&nbsp;<strong>만족도참여 리스트</strong>
					</td>
				</tr>
			</table>
			<!--[e] subTitle -->

			<!--[s] Contents Form  -->
			<table cellspacing="0" cellpadding="0" border="0" width="100%" class="contentsTable">
				<tr>
					<td>
                    
                    <!-- search[s] -->
					<table width="100%" border="0" cellpadding="0" cellspacing="0">
						<tr bgcolor="#5071B4">
							<td colspan="100%" height="2"></td>
						</tr>
						
						<tr bgcolor="#5071B4">
							<td colspan="100%" height="2"></td>
						</tr>
					</table>
                    <!-- search[e] -->
                    					
					<!---[s] content -->
					<!-- space --><table width="100%" height="10"><tr><td></td></tr></table>
					<table width="100%" border="0" cellpadding="0" cellspacing="0">
						  <tr>
							<td height="2" colspan="100%" bgcolor="#375694"></td>
						  </tr>
						<tr bgcolor="#5071B4">
						  <td height="28" width="10%" align="center" class="tableline11 white" ><strong>No</strong></td>
						  <td height="28" width="18%" align="center" class="tableline11 white" ><strong>만족도</strong></td>
						  <td height="28" width="15%" align="center" class="tableline11 white" ><strong>만족점수</strong></td>
						  <td class="tableline11 white" align="center"><strong>의견</strong></td>
  						  <td class="tableline11 white" align="center" width="15%"><strong>유저정보</strong></td>
  						  <td class="tableline11 white" align="center" width="15%"><strong>입력일</strong></td>
						</tr>
						<tr>
							<td height="2" colspan="100%" bgcolor="#375694" style="" ></td>
						</tr>
						<%=html.toString()%>
						<tr bgcolor="#5071B4">
							<td colspan="100%" height="2"></td>
						</tr>
                    </table>
						<div class="h10"></div>
					</td>
				</tr>
			</table>
			<!--[e] Contents Form  -->
        </td>
    </tr>
</table>

	
</form>
</body>
