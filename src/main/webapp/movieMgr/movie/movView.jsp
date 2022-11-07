<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
// prgnm 	: 동영상강의 VIEW
// date		: 2009-06-11
// auth 	: hwani
%>

<!-- [s] commonImport -->
<%@ include file="/commonInc/include/commonImport.jsp" %>
<!-- [e] commonImport -->


<%

DataMap rowMap = (DataMap)request.getAttribute("ROW_DATA");
rowMap.setNullToInitialize(true);


%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<link rel="stylesheet" type="text/css" href="/commonInc/css/movie/popup.css" />
<title>동영상 상세보기</title>
</head>

<body>
<table width="100%">
  <tr>
    <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td width="10" height="10"><img src="/images/movie/table/pop_ta01.gif" width="10" height="10"></td>
        <td background="/images/movie/table/pop_ta02.gif"></td>
        <td width="10"><img src="/images/movie/table/pop_ta03.gif" width="10" height="10"></td>
      </tr>
      <tr>
        <td background="/images/movie/table/pop_ta04.gif"></td>
        <td bgcolor="#FFFFFF" style="padding:10px;"><table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr>
            <td><h2><%= rowMap.getString("contName") %></h2></td>
          </tr>
          <tr>
            <td><table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td width="415" valign="top" style="padding-right:10px; ">
                	<!-- <img src="/images/movie/temp/player_sample.gif" width="413" height="295"> -->

					<!-- 서울인재개발원 U-지식여행 테스트 -->
					<OBJECT ID="AxPlayer"  CLASSID="CLSID:62255DEA-3E2F-48b0-AA3D-589F86D6FFAA" codebase="http://axisdb.hscdn.com/cab/AxPlayer2115.cab#version=2,1,1,5" width="413" height="295">
						
						<param name="AutoPlay" value="true">
					 
						<param name="volume" value=50>
						<param name="showControlPane" value="true">
						<param name="checkMonitor" value="0">
						<param name="info3" value="DCU7su5yJQE1/AXMZ2p6X6X21N/97hBB5ZrJs9mRMONB+d4tc11WPwymfJAbP/l+lkihGnaKs5XWc6BjNLXDiiLb5KbSm16c94S8vgAkQojSGGt7Z4dShBvoMtzCHUN8UPv77S1oCf972xz92xLwo6EvU1MjCi1ov1MGdEGRXK/xH0J8dKP1y8CJBTLYi+d6KxS/NdI1xzfn1PP3lFlRjOqtWvjZBqAdvTGzwZV63SXp5VAkeEZd4dK8Ls5HvRzCvOirCkki4DrkM1SjRXyL+ZDTU9b1JSrtx/E8qeOsRr7NwCjoImvNedYQFLvLaLXg">
						<param name="playlog" value="true">
						<param name="contentid" value="3042">
					  <param name="dupcheck" value="true"> 
					  <param name="startdatetime" value="6121500006165269210407736">
					  
					  <param name="canshowratecontrol" value="false">
					  
					</OBJECT>

                	
                </td>
                <td valign="top"><table width="100%" height="297" border="0" cellpadding="0" cellspacing="0">
                  <tr>
                    <td height="35" valign="top" style="background:url(/images/movie/table/pop_stopM.gif) repeat-x left 0;"><img src="/images/movie/table/pop_stop.gif" width="212" height="35"></td>
                    <td valign="top"><img src="/images/movie/table/pop_stopR.gif" width="20" height="35"></td>
                  </tr>
                  <tr>
                    <td style="background:url(/images/movie/table/pop_L.gif) repeat-y left 0;">
					<div style="margin:0; padding:0 10px 10px 15px; height:208px; overflow:scroll; overflow-x:hidden; line-height:18px; background:url(/images/movie/table/pop_L.gif) repeat-y left 0;">
<%= rowMap.getString("contSummary") %>
					  </div>
					  
					  
					  

					  
					  
					  
					  
					  
					  
					  
					  </td>
                    <td background="/images/movie/table/pop_R.gif"></td>
                  </tr>
                  <tr>
                    <td height="7" background="/images/movie/table/pop_sbtmM.gif"><img src="/images/movie/table/pop_sbtm.gif" width="212" height="7"></td>
                    <td height="7"><img src="/images/movie/table/pop_sbtmR.gif" width="20" height="7"></td>
                  </tr>
                </table></td>
              </tr>
            </table></td>
          </tr>
        </table></td>
        <td background="/images/movie/table/pop_ta05.gif"></td>
      </tr>
      <tr>
        <td width="10" height="10"><img src="/images/movie/table/pop_ta06.gif" width="10" height="10"></td>
        <td background="/images/movie/table/pop_ta07.gif"></td>
        <td><img src="/images/movie/table/pop_ta08.gif" width="10" height="10"></td>
      </tr>
    </table></td>
  </tr>
</table>
</body>
</html>
