<%@ page language="java" contentType="text/html; charset=UTF-8" %>

<!-- [s] commonImport -->
<%@ include file="/commonInc/include/commonImport.jsp" %>
<!-- [e] commonImport -->


<%

	String tmpMenuName = Util.getValue( request.getParameter("titleNm") );
	String currentMenuName = "";
	
	if(tmpMenuName == ""){

		//현재화면 메뉴 명칭
		DataMap currentMenuNameMap = (DataMap)request.getAttribute("CURRENT_TITLE_NAME_ROW");
								
		if(currentMenuNameMap != null){
			if(currentMenuNameMap.keySize("menuName") > 0){
				currentMenuName = currentMenuNameMap.getString("menuName");
			}
		}else{
			currentMenuName = tmpMenuName;
		}
	}else{
		currentMenuName = tmpMenuName;
	}

%>
<!-- space --><table width="100%" height="10"><tr><td></td></tr></table>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="commonTitleTable">
	<tr>
		<td height="22">
			<img src="/images/bullet_title.gif" width="5" height="14" align="middle">&nbsp;
			<font color="#00689F" style="font-weight:bold"><%= currentMenuName %></font>
		</td>
	</tr>
	<tr>
		<td>
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr><td height="2" bgcolor="#00AF9C" ></td></tr>
				<tr><td height="2" bgcolor="#D9D9D9" ></td></tr>
			</table>
		</td>
	</tr>
</table>
<!-- space --><table width="100%" height="10"><tr><td></td></tr></table>