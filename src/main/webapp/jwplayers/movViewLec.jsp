<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
// prgnm 	: 동영상강의 VIEW(마이페이지 >> 강의듣기)
// date		: 2009-06-11
// auth 	: hwani
%>

<!-- [s] commonImport -->
<%@ include file="/commonInc/include/commonImport.jsp" %>
<!-- [e] commonImport -->


<%

DataMap rowMap = (DataMap)request.getAttribute("ROW_DATA");
rowMap.setNullToInitialize(true);

//request 데이터
DataMap requestMap = (DataMap)request.getAttribute("REQUEST_DATA");
requestMap.setNullToInitialize(true);


String timeHh = rowMap.getString("timeHh");	//학습시간 - 시
String timeMm = rowMap.getString("timeMm");	//학습시간 - 분
String timeSs = rowMap.getString("timeSs");	//학습시간 - 초


String movUrl = rowMap.getString("movUrl");

String grcode = requestMap.getString("strGrcode");
String grseq  = requestMap.getString("strGrseq");
String subj   = requestMap.getString("subj");
String orgDir = requestMap.getString("orgDir");


System.out.println("req >>> movViewLec.jsp >>> requestMap ==================================\n" + requestMap);
System.out.println("req >>> movViewLec.jsp >>> rowMap ==================================\n" + rowMap);
System.out.println("rtn >>> movViewLec.jsp >>> movUrl ============== " + movUrl);
System.out.println("rtn >>> movViewLec.jsp >>> timehh ============== " + timeHh);
System.out.println("rtn >>> movViewLec.jsp >>> timemm ============== " + timeMm);
System.out.println("rtn >>> movViewLec.jsp >>> timeSs ============== " + timeSs);



%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link rel="stylesheet" type="text/css" href="/commonInc/css/movie/popup.css" />


<!-- [s] commonHtmlTop include 필수 -->
<script language="javascript" src="/commonInc/js/prototype-1.6.0.2.js"></script>
<script language="javascript" src="/commonInc/js/commonJs.js"></script>
<script language="javascript" src="/commonInc/js/NChecker.js"></script>
<script language="javascript" src="/commonInc/js/protoload.js"></script>
<script language="javascript" src="/commonInc/inno/InnoDS.js"></script>
<!-- [e] commonHtmlTop include -->

<!-- JW Players -->
<script type="text/javascript" src="/jwplayers/silverlight.js"></script>
<script type="text/javascript" src="/jwplayers/wmvplayer.js"></script>
<script type='text/javascript' src='/jwplayers/swfobject.js'></script>
<!-- //JW Players -->


<title>동영상 상세보기</title>



<!-- FLV Player -->
<script type='text/javascript'>

//학습시간 변수
var timeHh = Number("<%=timeHh%>");
var timeMm = Number("<%=timeMm%>");
var timeSs = Number("<%=timeSs%>");

var timerID;

//파일확장자 확인
function linkChk(movUrl) {

	//시간누적
	currentTime();
	timerID = window.setInterval(currentTime, 1000);

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


//시간 누적
function currentTime() {

//	if(timeSs == 60) {
//		alert("hh ====> " + timeHh);
//		alert("mm ====> " + timeMm);
//		alert("ss ====> " + timeSs);
//	}
	
	timeSs++;
	
	if(timeSs > 60) {
		timeSs = 0;
		timeMm++;

		if(timeMm > 60) {
			timeMm = 0;
			timeHh++;
		}
	}
}



//WMV
var player; 
function view_wmv(movUrl) {
	movUrl = "/jwplayers/video.wmv";	//테스트용 파일...
	var elm = document.getElementById("wmvplayer");
	var src = "/jwplayers/wmvplayer.xaml";
	var cfg = { file:""+movUrl, width:"413", height:"295" };
	player = new jeroenwijering.Player(elm,src,cfg);
	
	//addListeners();
	
	elm.style.display = "block";
}

//FLV
function view_flv(movUrl) {
	var s1 = new SWFObject('/jwplayers/player-viral.swf','player','413','295','9','#ffffff');
	var elm = document.getElementById("flvplayer");
	s1.addParam('allowfullscreen','true');
	s1.addParam('allowscriptaccess','always');
	s1.addParam('wmode','opaque');
	s1.addParam('flashvars','file='+movUrl);
	s1.write('flvplayer');
	
	elm.style.display = "block";
}


//이벤트
//function addListeners() {
//	if(player.view) {
		//player.addListener('VOLUME',volumeUpdate);
		//player.addListener('LOAD',loadUpdate);
		//player.addListener('STATE',stateUpdate);
		//player.addListener('TIME',timeUpdate);
		//player.addListener('BUFFER',bufferUpdate);
//	} else {
//		setTimeout("addListeners()",100);
//	}
//};


//재생시간
//function timeUpdate(pos,dur) { 
//	currentPosition = pos;

//	if(pos < 3) {
		//alert(pos);
//	}

	//var tmp = document.getElementById("time"); 
	//if (tmp) { tmp.innerHTML = "<b>Position:</b> "+pos+", <b>duration:</b> "+dur; } 
//};


//창닫을때 학습시간 갱신
//window.onunload = function(){
	
function init() {	

	//타이머 멈춘다.
	window.clearInterval(timerID);

	setUpdateCmiTime();

	

}

//LCMS_CMI 학습시간 갱신 호출
function setUpdateCmiTime() {

	var grcode = "<%=grcode%>";
	var grseq  = "<%=grseq%>";
	var subj   = "<%=subj%>";
	var orgDir = "<%=orgDir%>";
	
	opener.window.setCmiTime(grcode, grseq, subj, orgDir, timeHh, timeMm, timeSs);
	
	
	
	

	//document.pform.action = "/movieMgr/movie.do";
	//$("mode").value = "updateCmiTime";
	//alert("exec ~~~~~~~~~~~ ");
	//document.pform.submit();
}

function go_reload() {

	opener.window.location.reload();
	
}


</script>
<!-- //JW Players -->


</head>
<%if (movUrl.indexOf("mms://") != -1){ %>
<body>
<%} else if (movUrl.indexOf("<param") != -1){ %>
<body>
<%} else { %>
<body onload="linkChk('<%=movUrl%>');" onunload="init();">
<%} %>

<form name="pform" method="post">
	<input type='hidden' name='mode'		id='mode'  		value="" />
	<input type='hidden' name='timeHh'		id='timeHh'   	value="" />      
	<input type='hidden' name='timeMm'   	id='timeMm'		value="" />
	<input type='hidden' name='timeSs'   	id='timeSs'		value="" />
	<input type='hidden' name='strGrcode'   id='strGrcode'	value="<%= requestMap.getString("strGrcode") %>" />
	<input type='hidden' name='strGrseq'   	id='strGrseqh'	value="<%= requestMap.getString("strGrseq") %>" />
	<input type='hidden' name='subj'   		id='subj'		value="<%= requestMap.getString("subj") %>" />
	<input type='hidden' name='strUserId'   id='strUserId'	value="<%= requestMap.getString("strUserId") %>" />       
</form>

<!-- Ajax 테스트용... 삭제예정 -->
<div id="divList" name="divList"> </div>



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

<%if (movUrl.indexOf("<param") != -1){ out.print("<div id=\"movieplayer\">"+movUrl+"</div>");} %>

<%
	if (movUrl.indexOf("mms://") != -1){
%>
		<div id="movieplayer">
			<object classid="CLSID:6BF52A52-394A-11d3-B153-00C04F79FAA6" id="player" width="413" height="295">
				<param name="url" value="<%=movUrl %>">
				<param name="src" value="<%=movUrl %>">
				<param name="autostart" value="true">
				<!-- [if !IE] -->
				<!-- object type="video/x-ms-wmv" data="<%=movUrl %>" width="413" height="295">
					<param name="src" value="<%=movUrl %>">
					<param name="autostart" value="true">
					<param name="controller" value="true">
				</object -->
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


<!-- JW Players -->

<!-- WMV Player -->
<script type="text/javascript">

/*
<!--

-->
*/	
</script>





</html>