
function imgChg(obj){
	var img = null;
	var imgName = null;
	
	
	
	if(obj != null){
		for(i=0; i<obj.childNodes.length; i++){
			if(obj.childNodes[i].nodeName == "IMG"){
				img = obj.childNodes[i];
			}
		}
	}

	if(img != null){
		imgName = img.src;
		if(imgName.indexOf("_over") > -1){
			img.src = imgName.replace(/_over\.gif/g, ".gif");
		}else{
			img.src = imgName.replace(/\.gif/g, "_over.gif");
		}
	}
}

function initMoving(target, position, topLimit, btmLimit) {
 if (!target)
  return false;

 var obj = target;
 obj.initTop = position;
 obj.topLimit = topLimit;
 obj.bottomLimit = document.documentElement.scrollHeight - btmLimit;
 obj.style.position = "relative";             
 obj.top = obj.initTop;
 obj.left = obj.initLeft;
 if (typeof(window.pageYOffset) == "number") {
  obj.getTop = function() {
   return window.pageYOffset;
  }
 } else if (typeof(document.documentElement.scrollTop) == "number") {
  obj.getTop = function() {
   return document.documentElement.scrollTop;
  }
 } else {
  obj.getTop = function() {
   return 0;
  }
 }

 if (self.innerHeight) {
  obj.getHeight = function() {
   return self.innerHeight;
  }
 } else if(document.documentElement.clientHeight) {
  obj.getHeight = function() {
   return document.documentElement.clientHeight;
  }
 } else {
  obj.getHeight = function() {
   return 500;
  }
 }

 obj.move = setInterval(function() {
  if (obj.initTop > 0) {
   pos = obj.getTop() + obj.initTop;
  } else {
   pos = obj.getTop() + obj.getHeight() + obj.initTop;
   //pos = obj.getTop() + obj.getHeight() / 2 - 15;
  }

  if (pos > obj.bottomLimit)
   pos = obj.bottomLimit;
  if (pos < obj.topLimit)
   pos = obj.topLimit;

  interval = obj.top - pos;
  obj.top = obj.top - interval / 3;
  obj.style.top = obj.top + "px";
 }, 30)                        //
}


function tabOn(tabid,a) {
	for (i=1;i<=10;i++) {
		if(i<10){inn="0"+i;} else {inn=""+i;}
		tabMenu = document.getElementById("tab"+tabid+"m"+i);
		tabContent = document.getElementById("tab"+tabid+"c"+i);
		if (tabMenu) { 
			if (tabMenu.tagName=="IMG") { tabMenu.src = tabMenu.src.replace("_over.gif", ".gif"); } 
			if (tabMenu.tagName=="A") { tabMenu.className=""; } 
		}
		if (tabContent) { tabContent.style.display="none"; }
	}
	if(a<10){ann="0"+a;} else {ann=""+a;}
	tabMenu = document.getElementById("tab"+tabid+"m"+a);
	tabContent = document.getElementById("tab"+tabid+"c"+a);
//	alert(tabMenu.tagName);
	if (tabMenu) { 
		if (tabMenu.tagName=="IMG") { tabMenu.src = tabMenu.src.replace(".gif", "_over.gif"); } 
		if (tabMenu.tagName=="A") { tabMenu.className="on"; } 
	}
	if (tabContent) { tabContent.style.display="block"; }
	tabMore = document.getElementById("tab"+tabid+"more");
}


function MM_showHideLayers() { //v9.0
  var i,p,v,obj,args=MM_showHideLayers.arguments;
  for (i=0; i<(args.length-2); i+=3) 
  with (document) if (getElementById && ((obj=getElementById(args[i]))!=null)) { v=args[i+2];
    if (obj.style) { obj=obj.style; v=(v=='show')?'visible':(v=='hide')?'hidden':v; }
    obj.visibility=v; }
}


function MM_swapImgRestore() { //v3.0
  var i,x,a=document.MM_sr; for(i=0;a&&i<a.length&&(x=a[i])&&x.oSrc;i++) x.src=x.oSrc;
}
function MM_preloadImages() { //v3.0
  var d=document; if(d.images){ if(!d.MM_p) d.MM_p=new Array();
    var i,j=d.MM_p.length,a=MM_preloadImages.arguments; for(i=0; i<a.length; i++)
    if (a[i].indexOf("#")!=0){ d.MM_p[j]=new Image; d.MM_p[j++].src=a[i];}}
}

function MM_findObj(n, d) { //v4.01
  var p,i,x;  if(!d) d=document; if((p=n.indexOf("?"))>0&&parent.frames.length) {
    d=parent.frames[n.substring(p+1)].document; n=n.substring(0,p);}
  if(!(x=d[n])&&d.all) x=d.all[n]; for (i=0;!x&&i<d.forms.length;i++) x=d.forms[i][n];
  for(i=0;!x&&d.layers&&i<d.layers.length;i++) x=MM_findObj(n,d.layers[i].document);
  if(!x && d.getElementById) x=d.getElementById(n); return x;
}

function MM_swapImage() { //v3.0
  var i,j=0,x,a=MM_swapImage.arguments; document.MM_sr=new Array; for(i=0;i<(a.length-2);i+=3)
   if ((x=MM_findObj(a[i]))!=null){document.MM_sr[j++]=x; if(!x.oSrc) x.oSrc=x.src; x.src=a[i+2];}
}

function openWindow(name, url, left, top, width, height, toolbar, menubar, statusbar, scrollbar, resizable) {
  toolbar_str = toolbar ? 'yes' : 'no';
  menubar_str = menubar ? 'yes' : 'no';
  statusbar_str = statusbar ? 'yes' : 'no';
  scrollbar_str = scrollbar ? 'yes' : 'no';
  resizable_str = resizable ? 'yes' : 'no';
  window.open(url, name, 'left='+left+',top='+top+',width='+width+',height='+height+',toolbar='+toolbar_str+',menubar='+menubar_str+',status='+statusbar_str+',scrollbars='+scrollbar_str+',resizable='+resizable_str);
}
	
function openWindowForTop(name, url, left, top, width, height, toolbar, menubar, statusbar, scrollbar, resizable) {
  toolbar_str = toolbar ? 'yes' : 'no';
  menubar_str = menubar ? 'yes' : 'no';
  statusbar_str = statusbar ? 'yes' : 'no';
  scrollbar_str = scrollbar ? 'yes' : 'no';
  resizable_str = resizable ? 'yes' : 'no';
  window.open(url, name, 'left='+left+',top='+top+',width='+width+',height='+height+',toolbar='+toolbar_str+',menubar='+menubar_str+',status='+statusbar_str+',scrollbars='+scrollbar_str+',resizable='+resizable_str);
}

// JScript 파일
var zoomRate = 20;
var maxRate = 200;
var minRate = 100;
var curRate = 100;
function zoomInOut(contentid, how)
{
	var bIE = false;
  if (bIE && (
  			((how == "in")&&(curRate >= maxRate)) ||
  			((how == "out") && (curRate <= minRate))
  	) ) {
    return;   
  }
  if (how == "in") {
  	if(bIE) {
    	curRate = curRate + zoomRate;
    	document.body.style.zoom = curRate + '%';	
    }
    else {
    	scaleFont(+1);
    }
  }
  else if (how == "def"){
  	if(bIE) {
  		document.body.style.zoom = 1;
  		curRate = 100;
  	}
  	else {
  		scaleFont(0);
	  }	
	}
	else{
		if(bIE) {
    	curRate = curRate + (-1)*zoomRate;
    	document.body.style.zoom = curRate + '%';	
    }
    else {
			scaleFont(-1);
    }
  }
}


var fSize = 12;
function scaleFont( n )
{
		if(n == 0) fSize = 12;
		else fSize = fSize + n;
		if(fSize > 20) { fSize = 20; return; }
		if(fSize < 12) { fSize = 12; return; }
    var objTd = document.getElementsByTagName( "td" );
		var objSpan = document.getElementsByTagName( "span" );
		var objA = document.getElementsByTagName( "a" );
		var objP = document.getElementsByTagName( "p" );
		//var objFont = document.getElementsByTagName( "font" );
    for( i=0; i < objTd.length; i++ )
    {
          objTd[i].style.fontSize = fSize + "px";
          if(fSize > 15) 
						objTd[i].style.lineHeight = "1.5";
    }
    for( i=0; i < objSpan.length; i++ )
    {
          objSpan[i].style.fontSize = fSize + "px";
          if(fSize > 15) 
						objSpan[i].style.lineHeight = "1.5";
    }
    for( i=0; i < objA.length; i++ )
    {
          objA[i].style.fontSize = fSize + "px";
          if(fSize > 15) 
						objA[i].style.lineHeight = "1.5";
    }
		for( i=0; i < objP.length; i++ )
    {
          objP[i].style.fontSize = fSize + "px";
          if(fSize > 15) 
						objP[i].style.lineHeight = "1.5";
    }
    /*for( i=0; i < objFont.length; i++ )
    {
          objFont[i].style.fontSize = fSize + "px";
          if(fSize > 15) 
						objFont[i].style.lineHeight = "1.5";
    }*/
}

function MM_jumpMenuGo1(objId,targ,restore){ //v9.0
 
	var selObj = null; 
	with (document) {
		if (getElementById) selObj = getElementById(objId);

		if (selObj) eval("window.open('"+selObj.options[selObj.selectedIndex].value+"')");

		if (restore) selObj.selectedIndex=0;
	}

}

/* header 관련 script */

var fontColorIndex = 0;		//fontColorIndex Defalut
var bgColorIndex = 0;		//fontColorIndex Defalut
var ScreenSize = 100;		//ScreenSize Default
var VoiceSpeed = 3;			//VoiceSpeed Default
var VoiceVolum = 3;			//VoiceVolum Default


var beforeBgColor;
var beforeTag;
var beforeTableTag;

//var afontSize = new Array();

var aVoice = new Array();
aVoice[1] = 1;
aVoice[2] = 2;
aVoice[3] = 3;
aVoice[4] = 4;
aVoice[5] = 5;

var aScreen = new Array();
aScreen[1] = 100;
aScreen[2] = 125;
aScreen[3] = 150;
aScreen[4] = 175;
aScreen[5] = 200;

var fontColor = new Array();
fontColor[0] = "";
fontColor[1] = "";
fontColor[2] = "#ffff00";
fontColor[3] = "#ffffff";
fontColor[4] = "#6666ff";
fontColor[5] = "#ff6666";
fontColor[6] = "#ff66ff";
fontColor[7] = "#66ff66";

var bgColor = new Array();
bgColor[0] = "";
bgColor[1] = "";
bgColor[2] = "#000000";
bgColor[3] = "#6666ff";
bgColor[4] = "#ff6666";
bgColor[5] = "#ff66ff";
bgColor[6] = "#66ff66";


function readCookie( str ){
	var key = str + "=" ;
	var key_len = key.length;
	var cookie_len = document.cookie.length;
	var i = 0;

	while (i < cookie_len )	{
		var j = i + key_len;
		if ( document.cookie.substring( i, j ) == key ){
			var cookie_end = document.cookie.indexOf(";",j);

			if (cookie_end == -1){
				cookie_end = document.cookie.length;
			}
			return document.cookie.substring(j,cookie_end );
		}
		i++
	}
	return ""
}


function space_setCookie( key, value, term ){
	var expire = new Date();
	expire.setDate( expire.getDate() + term );
	document.cookie = key + "=" + escape( value ) + "; path=/; expires=" + expire.toGMTString() + ";";
}


//setTimeout( "bodyactive();", 5000);

/*****************************************************************/
//
/*****************************************************************/
function bodyactive(){
	if (window.ActiveXObject) { // IE
		var sRes = "";
		sRes = IsInstalled();
		if( sRes == true ){
			document.body.insertAdjacentHTML("BeforeEnd",objectTag);
		}else{
		}
	}
}

/*****************************************************************/
/*PageInit()*/
/*****************************************************************/
function f_PageInit(){


		if( readCookie("VoiceStart").length == 0){
			space_setCookie("VoiceStart", VoiceStart , 1);
		}else VoiceStart = readCookie("VoiceStart");

		if( readCookie("VoiceVolum").length == 0 ){
			space_setCookie("VoiceVolum", VoiceVolum, 1);
		}else VoiceVolum = readCookie("VoiceVolum");

		if( readCookie("VoiceSpeed").length == 0 ){
			space_setCookie("VoiceSpeed", VoiceSpeed, 1);
		}else VoiceSpeed = readCookie("VoiceSpeed");

		var res = NetlightObjectType(NetLightCOM);
		if( res == true ){
		f_VoiceStart( readCookie("VoiceStart") )};

		if( typeof(DynamicNetLightCOM) != 'undefined' ){


			VoiceVolum = parseFloat(readCookie("VoiceVolum"));
			NetLightCOM.VoiceVolume=VoiceVolum;
			f_ImgChg(VoiceVolum, "volum");

			VoiceSpeed = parseFloat(readCookie("VoiceSpeed"));
			NetLightCOM.VoiceSpeed=VoiceSpeed;
			f_ImgChg(VoiceSpeed, "speed");
		}
		else{
			f_ImgChg("", "COM");
		}

		fontColorIndex = readCookie("fontColorIndex");
		bgColorIndex = readCookie("bgColorIndex");
		f_FontInit();

}


/*****************************************************************/
/*Init()*/
/*****************************************************************/
function f_FontInit(){

		/*
		if (readCookie("setfontsize").length == 0 ){
			space_setCookie("setfontsize", setfontsize, 1);
		}else setfontsize = readCookie("setfontsize");	

		if( readCookie("fontSize").length == 0 ){
			space_setCookie("fontSize", fontSize, 1);
		}else fontSize = readCookie("fontSize");		


		if (readCookie("SetFont").length == 0 ){
			space_setCookie("SetFont", SetFont, 1);
		}else SetFont = readCookie("SetFont");			
		*/

		if( readCookie("fontColorIndex").length == 0 ){
			space_setCookie("fontColorIndex", 0, 1);
		}else fontColorIndex = readCookie("fontColorIndex");

		if ( readCookie("bgColorIndex").length == 0 ){
			space_setCookie("bgColorIndex", 0, 1);
		}else bgColorIndex = readCookie("bgColorIndex");

		if ( readCookie("zoomVal").length == 0 ){
			space_setCookie("zoomVal", "100%", 7);
		}else currZoom = readCookie("zoomVal")+"%";		

		zoomInOut("");

		//setFontSize(setfontsize);
		f_setFace();



}


function setFontSize(val){
	afontSize[1] = val;
	for( var i=2; i<6; i++ ){
		val = parseInt(val) + 3;
		afontSize[i] = val;
	}
}



function f_objectInsert(mode){
	var sRes = "";
	sRes = IsInstalled();
	if( sRes == true ){
		document.body.insertAdjacentHTML("BeforeEnd", objectTag);
	}else{
		var com = confirm("You should install program to use Voice Service.\n\nDo you want to install?");

		if( com == true ){
			top.location.href="/NetLight2/ActiveX.jsp?conf_Lang=enu";
		}
	}
}


function f_VoiceStart(str){
	//-setTimeout("", 2000);
	if( typeof(DynamicNetLightCOM) != 'undefined' ){
		if( str == "start" ){
			f_ImgChg('', "VoiceStart");
			if( FrameLength == 2 ){

				if( typeof(eval(FrameMainName +"document.all['VoiceLink']")) == 'object' ){
					eval(FrameMainName +"document.all['VoiceLink']").href = "JavaScript:NetReader('VoiceStop');";
					eval(FrameMainName +"document.all['VoiceLink']").title="Voice on";

				}
			}else{
				if( typeof(document.all['VoiceLink']) == 'object' ){
					document.all['VoiceLink'].href="JavaScript:NetReader('VoiceStop');";
					document.all['VoiceLink'].title="Voice on";

				}
			}

			DynamicNetLightCOM.VoiceActive=true;
		}
		else if( str == "stop"){
			f_ImgChg('', "VoiceStop");
			if( FrameLength == 2 ){
				if( typeof(eval(FrameMainName +"document.all['VoiceLink']")) == 'object' ){
					eval(FrameMainName +"document.all['VoiceLink']").href="JavaScript:NetReader('VoiceStart');";
					eval(FrameMainName +"document.all['VoiceLink']").title="Voice off";
				}
			}else{
				if( typeof(document.all['VoiceLink']) == 'object' ){
					document.all['VoiceLink'].href="JavaScript:NetReader('VoiceStart');";
					document.all['VoiceLink'].title="Voice off";
				}
			}


			DynamicNetLightCOM.VoiceActive=false;
		}
		space_setCookie("VoiceStart", str, 1);
	}else{

		f_objectInsert("voice");
	}
}

function f_setFontColor(val){
	if ( val >= 0 && val <= 7 )
	{
		fontColorIndex = val;
		f_setFace();
	}
}


function f_setBgColor(val){
	if ( val >= 0 && val <= 6 )
	{
		bgColorIndex = val;
		f_setFace();
	}
}


function f_ImgChg(val, flag){
	//Start
	if(flag == "VoiceStart"){
		if( FrameLength == 2 ){
			if( typeof(eval(FrameMainName +"document.all['VoiceStart']")) == 'object' ){
				eval(FrameMainName +"document.all['VoiceStart']").alt="Voice off";
				eval(FrameMainName +"document.all['VoiceStart']").title="Voice off";
				eval(FrameMainName +"document.all['VoiceStart']").src = VoiceOnImg;
			}
		}else{
			if( typeof(document.all['VoiceStart']) == 'object' ){
				document.all['VoiceStart'].alt="Voice off";
				document.all['VoiceStart'].title="Voice off";
				document.all['VoiceStart'].src = VoiceOnImg;
			}
		}
	}
	//Stop
	else if(flag == "VoiceStop"){
		if( FrameLength == 2 ){
			if( typeof(eval(FrameMainName +"document.all['VoiceStart']")) == 'object' ){
				eval(FrameMainName +"document.all['VoiceStart']").alt="Voice on";
				eval(FrameMainName +"document.all['VoiceStart']").title="Voice on";
				eval(FrameMainName +"document.all['VoiceStart']").src = VoiceOffImg;
			}
		}else{
			if( typeof(document.all['VoiceStart']) == 'object' ){
				document.all['VoiceStart'].alt="Voice on";
				document.all['VoiceStart'].title="Voice on";
				document.all['VoiceStart'].src = VoiceOffImg;
			}
		}
	}


	//Not NetLightCOM
	else if( flag == "COM" ){
	}
}


function f_setFace(){
	var objs_td		= new Array();
	var objs_a		= new Array();
	var ogjs_span	= new Array();
	var objs_p		= new Array();
	var objs_li		= new Array();
	var Space_FontColor = fontColorIndex;	//fontColor[fontColorIndex]; //
	var Space_BGColor   = bgColorIndex; 	//bgColor[bgColorIndex];

	objs_td		= document.getElementsByTagName("td");
	objs_a		= document.getElementsByTagName("a");
	ogjs_span	= document.getElementsByTagName("span");
	objs_p		= document.getElementsByTagName("P");
	objs_div	= document.getElementsByTagName("div");
	objs_li		= document.getElementsByTagName("li");


	objs_dl		= document.getElementsByTagName("dl");
	objs_dt		= document.getElementsByTagName("dt");
	objs_dd		= document.getElementsByTagName("dd");
	objs_pre	= document.getElementsByTagName("pre");
	objs_font	= document.getElementsByTagName("font");

	objs_h3	= document.getElementsByTagName("h3");
	objs_h4	= document.getElementsByTagName("h4");


	for (i=0;i<objs_dl.length;i++){
		if (Space_FontColor !="0") objs_dl[i].style.color=fontColor[fontColorIndex];
		if (Space_BGColor !="0") objs_dl[i].style.backgroundColor=bgColor[bgColorIndex];
	}
	for (i=0;i<objs_dt.length;i++){
		if (Space_FontColor !="0") objs_dt[i].style.color=fontColor[fontColorIndex];
		if (Space_BGColor !="0") objs_dt[i].style.backgroundColor=bgColor[bgColorIndex];
	}
	for (i=0;i<objs_dd.length;i++){
		if (Space_FontColor !="0") objs_dd[i].style.color=fontColor[fontColorIndex];
		if (Space_BGColor !="0") objs_dd[i].style.backgroundColor=bgColor[bgColorIndex];
	}
	for (i=0;i<objs_pre.length;i++){
		if (Space_FontColor !="0") objs_pre[i].style.color=fontColor[fontColorIndex];
		if (Space_BGColor !="0") objs_pre[i].style.backgroundColor=bgColor[bgColorIndex];
	}
	for (i=0;i<objs_font.length;i++){
		//objs_td[i].style.fontSize=fontSize+'px';
		if (Space_FontColor !="0") objs_font[i].style.color=fontColor[fontColorIndex];
		//objs_font[i].style.backgroundColor=bgColor[bgColorIndex];
	}


	for (i=0;i<objs_td.length;i++){
		//objs_td[i].style.fontSize=fontSize+'px';
		if (Space_FontColor !="0") objs_td[i].style.color=fontColor[fontColorIndex];
		if (Space_BGColor !="0") objs_td[i].style.backgroundColor=bgColor[bgColorIndex];
	}

	for (i=0;i<objs_a.length;i++){
		//objs_a[i].style.fontSize=fontSize+'px';
		if (Space_FontColor !="0") objs_a[i].style.color=fontColor[fontColorIndex];
	}

	for (i=0;i<ogjs_span.length;i++){
		//ogjs_span[i].style.fontSize=fontSize+'px';
		if (Space_FontColor !="0") ogjs_span[i].style.color=fontColor[fontColorIndex];
	}

	for (i=0;i<objs_p.length;i++){
		//objs_p[i].style.fontSize=fontSize+'px';
		if (Space_FontColor !="0") objs_p[i].style.color=fontColor[fontColorIndex];
	}

	for (i=0;i<objs_div.length;i++){
		//objs_div[i].style.fontSize=fontSize+'px';
		if (Space_FontColor !="0") objs_div[i].style.color=fontColor[fontColorIndex];
		if (Space_BGColor !="0") objs_div[i].style.backgroundColor=bgColor[bgColorIndex];
	}

	for (i=0;i<objs_li.length;i++){
		//objs_div[i].style.fontSize=fontSize+'px';
		if (Space_FontColor !="0") objs_li[i].style.color=fontColor[fontColorIndex];
		if (Space_BGColor !="0") objs_li[i].style.backgroundColor=bgColor[bgColorIndex];
	}

	for (i=0;i<objs_h3.length;i++){
		//objs_div[i].style.fontSize=fontSize+'px';
		if (Space_FontColor !="0") objs_h3[i].style.color=fontColor[fontColorIndex];
		if (Space_BGColor !="0") objs_h3[i].style.backgroundColor=bgColor[bgColorIndex];
	}

	for (i=0;i<objs_h4.length;i++){
		//objs_div[i].style.fontSize=fontSize+'px';
		if (Space_FontColor !="0") objs_h4[i].style.color=fontColor[fontColorIndex];
		if (Space_BGColor !="0") objs_h4[i].style.backgroundColor=bgColor[bgColorIndex];
	}

	if ( document.all['fontSelect'] == '[object]' && document.all['bgSelect'] == '[object]' ){
		document.all['fontSelect'].selectedIndex	= parseInt(fontColorIndex);
		document.all['bgSelect'].selectedIndex		= parseInt(bgColorIndex);
	}

	//space_setCookie("fontSize", fontSize, 1);					
	space_setCookie("fontColorIndex", fontColorIndex, 1);		
	space_setCookie("bgColorIndex", bgColorIndex, 1);			
}


var changeTextColor1;
var changeBgColor1;
function f_setFontColor1(val){
	if ( !val || val == 'undefined' ) return;
	changeTextColor1 = val;
}
function f_setBgColor1(val){
	if ( !val || val == 'undefined' ) return;
	changeBgColor1 = val;
}

function f_setFontColorGo() {
	if ( !changeTextColor1 ) {
		alert("Choose a color change");
		return;
	}
	f_setFontColor(changeTextColor1);
}


function f_setBgColorGo() {
	if ( !changeBgColor1 ) {
		alert("Choose a color change");
		return;
	}
	f_setBgColor(changeBgColor1);
}
//-->
/*********************************************************/
function FontPlus1(uid)
{

	var m = document.getElementById('container');
    var mnSize = m.style.fontSize   ? m.style.fontSize   : '9pt';
    var miSize = parseInt(mnSize.replace('pt',''));

    if (miSize < 12)
    {
        m.style.fontSize   = (miSize + 1) + 'pt';
        m.style.lineHeight = '120%';
    }




    var l = document.getElementById('content');
	var c = document.getElementById('conapp');
    var nSize = l.style.fontSize   ? l.style.fontSize   : '9pt';
    var iSize = parseInt(nSize.replace('pt',''));


    if (iSize < 12)
    {
        l.style.fontSize   = (iSize + 1) + 'pt';
        l.style.lineHeight = '120%';
		c.style.fontSize = '9pt';
    }


	var h3Tag = l.getElementsByTagName("h3");
	if(h3Tag.length > 0){

		for(k = 0; k < h3Tag.length; k++) {
			var nSize2 = h3Tag.item(k).style.fontSize   ? h3Tag.item(k).style.fontSize   : '12pt';
		    var iSize2 = parseInt(nSize2.replace('pt',''));
			 if (iSize2 < 15)
			{
					h3Tag.item(k).style.fontSize = (iSize2 + 1) + 'pt';
					h3Tag.item(k).style.lineHeight = '120%';
			}

		}
	}

	var h4Tag = l.getElementsByTagName("h4");
	if(h4Tag.length > 0){

		for(k = 0; k < h4Tag.length; k++) {
			var nSize3 = h4Tag.item(k).style.fontSize   ? h4Tag.item(k).style.fontSize   : '9pt';
		    var iSize3 = parseInt(nSize3.replace('pt',''));
			 if (iSize3 < 12)
			{
					h4Tag.item(k).style.fontSize = (iSize3 + 1) + 'pt';
					h4Tag.item(k).style.lineHeight = '120%';
			}

		}
	}


}



function FontMinus1(uid)
{


    var m = document.getElementById('container');
    var mnSize = m.style.fontSize ? m.style.fontSize : '9pt';
    var miSize = parseInt(mnSize.replace('pt',''));

    if (miSize > 6)
    {
        m.style.fontSize = (miSize - 1) + 'pt';
        m.style.lineHeight = '120%';
    }

	var l = document.getElementById('content');
	var c = document.getElementById('conapp');
    var nSize = l.style.fontSize ? l.style.fontSize : '9pt';
    var iSize = parseInt(nSize.replace('pt',''));

    if (iSize > 6)
    {
        l.style.fontSize = (iSize - 1) + 'pt';
        l.style.lineHeight = '120%';
		c.style.fontSize = '9pt';
    }

	var h3Tag = l.getElementsByTagName("h3");
	if(h3Tag.length > 0){

		for(k = 0; k < h3Tag.length; k++) {
			var nSize2 = h3Tag.item(k).style.fontSize   ? h3Tag.item(k).style.fontSize   : '12pt';
		    var iSize2 = parseInt(nSize2.replace('pt',''));
			 if (iSize2 > 9)
			{
					h3Tag.item(k).style.fontSize = (iSize2 - 1) + 'pt';
					h3Tag.item(k).style.lineHeight = '120%';
			}

		}
	}

	var h4Tag = l.getElementsByTagName("h4");
	if(h4Tag.length > 0){

		for(k = 0; k < h4Tag.length; k++) {
			var nSize3 = h4Tag.item(k).style.fontSize   ? h4Tag.item(k).style.fontSize   : '9pt';
		    var iSize3 = parseInt(nSize3.replace('pt',''));
			 if (iSize3 > 6)
			{
					h4Tag.item(k).style.fontSize = (iSize3 - 1) + 'pt';
					h4Tag.item(k).style.lineHeight = '120%';
			}

		}
	}


}
function FontBase1()
{

    var l = document.getElementById('container');
        l.style.fontSize = 10 + 'pt';
        l.style.lineHeight = '1.03em';


    var l = document.getElementById('content');
	var c = document.getElementById('conapp');
        l.style.fontSize = 10 + 'pt';
        l.style.lineHeight = '1.03em';
		c.style.fontSize = '9pt';

	var h3Tag = l.getElementsByTagName("h3");
	if(h3Tag.length > 0){

		for(k = 0; k < h3Tag.length; k++) {
			h3Tag.item(k).style.fontSize = '12pt';
			h3Tag.item(k).style.lineHeight = '1.3em';
		}
	}

	var h4Tag = l.getElementsByTagName("h4");
	if(h4Tag.length > 0){

		for(k = 0; k < h4Tag.length; k++) {
			h4Tag.item(k).style.fontSize = '9pt';
			h4Tag.item(k).style.lineHeight = '1.3em';
		}
	}


}

function showDiv(cnt,category,req){
	for(var i=1; i<=cnt ; i++){
		if(i == req){
			document.getElementById(category+i).style.display = "block";
		}else{
			document.getElementById(category+i).style.display = "none";
		}
	}
}

var initBody;
function beforePrint(){
boxes = document.body.innerHTML;
document.body.innerHTML = print_wrap.innerHTML;
}
function afterPrint(){
document.body.innerHTML = boxes;
}
function printArea(){
window.print();
}
window.onbeforeprint = beforePrint;
window.onafterprint = afterPrint;
