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

String movUrl = rowMap.getString("movUrl");


%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link rel="stylesheet" type="text/css" href="/commonInc/css/movie/popup.css" />


<!-- JW Players -->
<script type="text/javascript" src="/jwplayers/silverlight.js"></script>
<script type="text/javascript" src="/jwplayers/wmvplayer.js"></script>
<script type='text/javascript' src='/jwplayers/swfobject.js'></script>
<!-- //JW Players -->


<title>동영상 상세보기</title>



<!-- FLV Player -->
<script type='text/javascript'>


//파일확장자 확인
function linkChk(movUrl) {
	//alert(movUrl);
	var  str_dotlocation, str_ext, str_low;
	str_value  = movUrl;
	
	str_low   = str_value.toLowerCase(str_value);
	str_dotlocation = str_low.lastIndexOf(".");
	str_ext   = str_low.substring(str_dotlocation+1);

	//alert(str_ext);
	switch (str_ext) {
		case "wmv" :
			view_wmv(movUrl); 
		case "wma" :
			view_wmv(movUrl);
		    return true;
		    break;
		default:
			view_flv(movUrl);
	}
}

//WMV
var player; 
function view_wmv(movUrl) {
	//alert("wmv =========== " + movUrl);
	//movUrl = "/jwplayers/video.wmv";	//테스트용 파일...
	var elm = document.getElementById("wmvplayer");
	var src = "/jwplayers/wmvplayer.xaml";
	var cfg = { height:"390", width:"443", file:movUrl, autostart:"true" };
	player = new jeroenwijering.Player(elm,src,cfg);
	//addListeners();
	elm.style.display = "block";
}

//FLV 동영상 보기
function view_flv(movUrl) {
	
	var flvDiv = document.getElementById("flvplayer");
	
	//var s1 = new SWFObject('/jwplayers/player-viral.swf','ply','470','320','9','#ffffff');
	//var s1 = new SWFObject('/jwplayers/player-viral.swf','player','413','295','9','#ffffff');
	//var s1 = new SWFObject('/jwplayers/player-viral.swf','player','413','295','9');
	//s1.addParam('allowfullscreen','true');
	//s1.addParam('allowscriptaccess','always');
	//s1.addParam('wmode','opaque');
	//s1.addParam('flashvars','file=http://content.longtailvideo.com/videos/flvplayer.flv');
	//s1.addParam('flashvars','file='+movUrl);
	//s1.addParam('flashvars','file=video.flv');
	//s1.write('flvplayer');
	//s1.write('preview');
	
	
	var s1 = new SWFObject('/jwplayers/player-viral.swf','player','433','390','9','#ffffff');
	var elm = document.getElementById("flvplayer");
	s1.addParam('allowfullscreen','true');
	s1.addParam('allowscriptaccess','always');
	s1.addParam('wmode','opaque');
	s1.addParam('flashvars','file='+movUrl);
	s1.write('flvplayer');
	
	elm.style.display = "block";
	
	//flvDiv.style.display = "block";
	
	//var flashvars = false;
	//var params = {};
	//var attributes = {
	  //id: "myDynamicContent",
	  //name: "myDynamicContent"
	//};
	
	//swfobject.embedSWF("/jwplayers/video.swf", "myContent", "300", "120", "9.0.0","expressInstall.swf", flashvars, params, attributes);
}


//이벤트
function addListeners() {
	//if(player.view) {
		//player.addListener('VOLUME',volumeUpdate);
		//player.addListener('LOAD',loadUpdate);
		//player.addListener('STATE',stateUpdate);
		player.addListener('TIME',timeUpdate);
		//player.addListener('BUFFER',bufferUpdate);
	//} else {
		//setTimeout("addListeners()",100);
	//}
}

//재생시간
function timeUpdate(pos,dur) { 
	currentPosition = pos;

	if(pos < 3) {
		//alert(pos);
	}

	//var tmp = document.getElementById("time"); 
	//if (tmp) { tmp.innerHTML = "<b>Position:</b> "+pos+", <b>duration:</b> "+dur; } 
}

window.onunload = function() {

	
    window.opener.location.reload();
}

</script>
<!-- //JW Players -->


</head>
<%if (movUrl.indexOf("mms://") != -1){ %>
<body>
<%} else if (movUrl.indexOf("<param") != -1){ %>
<body>
<%} else { %>
<body onload="linkChk('<%=movUrl%>');">
<%} %>
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





<!-- JW Players -->
<div id="wmvplayer" style="display:none;"></div>

<div id="flvplayer" style="display:none;"></div>

<%
	if (movUrl.indexOf("<param") != -1){ 
		out.print("<div id=\"movieplayer\">"+movUrl+"</div>");
	} 
%>
<%
	if (movUrl.indexOf("mms://") != -1){
%>
		<div id="movieplayer">
			<object classid="CLSID:6BF52A52-394A-11d3-B153-00C04F79FAA6" id="player" width="443" height="390">
				<param name="url" value="<%=movUrl %>">
				<param name="src" value="<%=movUrl %>">
				<param name="autostart" value="true">
				<!-- [if !IE] -->
				<!-- <object type="video/x-ms-wmv" data="<%=movUrl %>" width="413" height="295">
					<param name="src" value="<%=movUrl %>">
					<param name="autostart" value="true">
					<param name="controller" value="true">
				</object> -->
				<!-- <![endif] -->
			</object>
		</div>
<%	
	//	out.print("<div id=\"movieplayer\"><OBJECT data=\""+movUrl+"\" type=\"video/mpeg\"></obejct></div>");
	} 
%>


<!-- 
<h2>RECEIVED UPDATES</h2> 
<ul> 
	<li id="buffer"></li> 
	<li id="state"></li> 
	<li id="time"></li> 
	<li id="load"></li> 
	<li id="volume"></li> 
</ul>
 -->
 
<!-- //JW Players -->




                	
                </td>
                <td valign="top"><table width="100%" height="390" border="0" cellpadding="0" cellspacing="0">
                  <tr>
                    <td height="35" valign="top" style="background:url(/images/movie/table/pop_stopM.gif) repeat-x left 0;"><img src="/images/movie/table/pop_stop.gif" width="212" height="35"></td>
                    <td valign="top"><img src="/images/movie/table/pop_stopR.gif" width="20" height="35"></td>
                  </tr>
                  <tr>
                    <td style="background:url(/images/movie/table/pop_L.gif) repeat-y left 0;">
					<div style="margin:0; padding:0 10px 10px 20px; height:308px; overflow:scroll; overflow-x:hidden; line-height:18px; background:url(/images/movie/table/pop_L.gif) repeat-y left 0;">
						<%=Util.N2Br(rowMap.getString("contSummary"))%>
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


<!-- JW Players -->

<!-- WMV Player -->
<script type="text/javascript">

/*
<!--

-->
*/	
</script>





</html>