<%@ page language="java" contentType="text/html; charset=UTF-8" %>

<%  
// prgnm : 관리자용 상단 메뉴 include 용
// date : 2008-05-05
// auth : kang
%>

<!-- [s] commonImport -->
<%@ include file="/commonInc/include/commonImport.jsp" %>
<!-- [e] commonImport -->

<%

	DataMap requestMap = (DataMap)request.getAttribute("REQUEST_DATA");
	requestMap.setNullToInitialize(true);
	
	// 선택한 메뉴에 대한 ID
	String menuId = requestMap.getString("menuId");
	String hrefClass = "a_topmenu_listHover";
	String tmpMenuId = "";
	StringTokenizer sToken = new StringTokenizer(menuId, "-");

	for(int i = 0; i < sToken.countTokens(); i++){
		if(i == 0){
			tmpMenuId = sToken.nextToken();		
		}
	}


	//메뉴 정보
	DataMap menuMap = (DataMap)request.getAttribute("TOPMENU_DATA");
	menuMap.setNullToInitialize(true);
		
	StringBuffer sbHtml = new StringBuffer();
	
	sbHtml.append("<table cellspacing='0' cellpadding='0' border='0' height='48'>");
	sbHtml.append("    <tr>");
	
	
		
	for(int i=0; i < menuMap.keySize("menuName"); i++){
		
		if(tmpMenuId.equals( menuMap.getString("menuDepth1",i) ) ){
			hrefClass = "a_topmenu_listHover";
		}else{
			hrefClass = "a_topmenu_list";
		}
		
		sbHtml.append(" <td style=\"padding:5px 15px\" nowrap>");
        sbHtml.append("		<a href=\""+ menuMap.getString("menuUrl", i) +"\" class=\"" + hrefClass + "\">");
    	sbHtml.append("		<b>" + menuMap.getString("menuName", i) + "</b>");
        sbHtml.append("		</a>");
        sbHtml.append("	</td>");
        sbHtml.append("	<td valign=\"top\"><img src=\"/images/navi_pt.gif\" width=\"7\" height=\"6\" border=\"0\"></td>");
	}
    //?
	session.setAttribute("sess_currenttopmenu", ut.lib.util.Util.getValue(menuMap.getString("menuDepth1", 0), "0") );	// 현재 상단 메뉴ID
		
	sbHtml.append("	</tr>");
	sbHtml.append("</table>");
%>


<script language="JavaScript">
<!--
//로그아웃.
function fnLoginOut(){
	pform.action = "/homepage/login.do?mode=loginOut";
	pform.submit();	
}

//-->
</script>

<!-- ::::::::::::::: START : GNB, SNB :::::::::::::::::-->
<table cellspacing="0" cellpadding="0" border="0" width="100%">
    <tr>
        <td height="35" bgcolor="#DCDCDC">
            <!-- 네트워크 메뉴, 쪽지, 정보수정, 로그아웃 버튼-->
            <table cellspacing="0" cellpadding="0" border="0" width="100%">
                <tr>
                    <td width="30%">
                        <table cellspacing="0" cellpadding="0" border="0">
                            <tr>
                                <td width="15"></td>
                                <td width="89" align="left"><a href="http://www.cyber.incheon.kr/"><img src="/images/gnb_m001.gif" height="13" border="0" alt="시민사이버교육"></a></td>
                                <td width="53" align="left"><a href="javascript:fnGIndex();"><img src="/images/gnb_m002.gif" height="13" border="0" alt="Sitemap"></a></td>
                                <td width="48" align="left"><a href="javascript:alert('url미정');"><img src="/images/gnb_m003.gif" height="13" border="0" alt="English"></a></td>
                            </tr>
                        </table>
                    </td>
                    <td width="70%" align="right">
                        <table cellspacing="0" cellpadding="0" border="0">
                            <tr>
								<!-- <td style="padding-right:5px" valign="bottom"><a href="http://loti.incheon.go.kr/lcms/login/proclogin.jsp?id=admin&passwd=dunet" target="_blank"><img src="/images/lcms.gif"></a></td> -->
								<td style="padding-right:5px" valign="bottom"><a href="/lcms/login/proclogin.jsp?id=admin" target="_blank"><img src="/images/lcms.gif" alt="LCMS"></a></td>
                                <td style="padding-right:5px" valign="bottom"><a href="/homepage/login.do?mode=userInfoChange"><img src="/images/btn_infor.gif" width="88" height="22" border="0" alt="개인정보수정"></a></td>
                                <td style="padding-right:10px" valign="bottom"><a href="javascript:fnLoginOut();"><img src="/images/btn_logout.gif" width="64" height="22" border="0" alt="로그아웃"></a></td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
            <!-- /네트워크 메뉴, 쪽지, 정보수정, 로그아웃 버튼-->
        </td>
    </tr>
    <tr><td height="3" bgcolor="#C3C3C3"></td></tr>
</table>

<!--[s] Top Menu -->
<table cellspacing="0" cellpadding="0" border="0" width="100%">
    <tr>
        <td height="48" bgcolor="#FFFFFF">
            <%= sbHtml.toString() %>
        </td>
    </tr>
</table>
<!--[e] Top Menu -->

<!-- ::::::::::::::: END : GNB, SNB :::::::::::::::::-->



