<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>


<%  
// date  : 2008-07-22
// prgnm : 프리뷰
// auth  : 정윤철
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
	
	
%>
<script language="JavaScript">
<!--
var url = "<%= requestMap.getString("url")%>";
GetAVIPlayer(url, 500, 400);

function GetAVIPlayer(url,width,height){

	var EmbedStr = '';
	EmbedStr += "<object id='MediaPlayer' classid='CLSID:22D6f312-B0F6-11D0-94AB-0080C74C7E95' width='" + width + "' height='" + height + "' align='center'>";
	EmbedStr += "<param name='Filename' value='" + url + "'>";
	EmbedStr += "<param name='AudioStream' value='-1'>";
	EmbedStr += "<param name='AutoSize' value='0'>";
	EmbedStr += "<param name='AutoStart' value='1'>";
	EmbedStr += "<param name='AnimationAtStart' value='-1'>";
	EmbedStr += "<param name='AllowScan' value='-1'>";
	EmbedStr += "<param name='AllowChangeDisplaySize' value='-1'>";
	EmbedStr += "<param name='AutoRewind' value='true'>";
	EmbedStr += "<param name='Balance' value='1'>";
	EmbedStr += "<param name='BaseURL' value>";
	EmbedStr += "<param name='BufferingTime' value='15'>";
	EmbedStr += "<param name='CaptioningID' value>";
	EmbedStr += "<param name='ClickToPlay' value='1'>";
	EmbedStr += "<param name='CursorType' value='0'>";
	EmbedStr += "<param name='CurrentPosition' value='-1'>";
	EmbedStr += "<param name='CurrentMarker' value='0'>";
	EmbedStr += "<param name='DefaultFrame' value>";
	EmbedStr += "<param name='DisplayBackColor' value='0'>";
	EmbedStr += "<param name='DisplayForeColor' value='16777215'>";
	EmbedStr += "<param name='DisplayMode' value='0'>";
	EmbedStr += "<param name='DisplaySize' value='0'>";
	EmbedStr += "<param name='Enabled' value='-1'>";
	EmbedStr += "<param name='EnableContextMenu' value='false'>";
	EmbedStr += "<param name='EnablePositionControls' value='-1'>";
	EmbedStr += "<param name='EnableFullScreenControls' value='0'>";
	EmbedStr += "<param name='EnableTracker' value='-1'>";
	EmbedStr += "<param name='InvokeURLs' value='-1'>";
	EmbedStr += "<param name='Language' value='-1'>";
	EmbedStr += "<param name='Mute' value='0'>";
	EmbedStr += "<param name='PlayCount' value='1'>";
	EmbedStr += "<param name='PreviewMode' value='0'>";
	EmbedStr += "<param name='Rate' value='1'>";
	EmbedStr += "<param name='SelectionStart' value='0'>";
	EmbedStr += "<param name='SelectionEnd' value='0'>";
	EmbedStr += "<param name='SendOpenStateChangeEvents' value='-1'>";
	EmbedStr += "<param name='SendWarningEvents' value='-1'>";
	EmbedStr += "<param name='SendErrorEvents' value='-1'>";
	EmbedStr += "<param name='SendKeyboardEvents' value='0'>";
	EmbedStr += "<param name='SendMouseClickEvents' value='-1'>";
	EmbedStr += "<param name='SendMouseMoveEvents' value='1'>";
	EmbedStr += "<param name='SendPlayStateChangeEvents' value='1'>";
	EmbedStr += "<param name='ShowCaptioning' value='0'>";
	EmbedStr += "<param name='ShowControls' value='1'>";
	EmbedStr += "<param name='ShowAudioControls' value='1'>";
	EmbedStr += "<param name='ShowDisplay' value='0'>";
	EmbedStr += "<param name='ShowGotoBar' value='0'>";
	EmbedStr += "<param name='ShowPositionControls' value='-1'>";
	EmbedStr += "<param name='ShowStatusBar' value='0'>";
	EmbedStr += "<param name='ShowTracker' value='-1'>";
	EmbedStr += "<param name='TransparentAtStart' value='0'>";
	EmbedStr += "<param name='VideoBorderWidth' value='0'>";
	EmbedStr += "<param name='VideoBorderColor' value='0'>";
	EmbedStr += "<param name='VideoBorder3D' value='1'>";
	EmbedStr += "<param name='Volume' value='100'>";
	EmbedStr += "<param name='WindowlessVideo' value='0'>";
	EmbedStr += "</object> ";

document.write(EmbedStr);
return;


}


//-->
</script>
