var isMozilla_t;var objDiv_t=null;var objDiv2_t=null;var DivID_t="traceFrame";var over1_t=false;var DivID2_t="tracerHelp";var over2_t=false;var traceLine=1;var traceErr=0;var trcflg=false;var stat=0;var trcError1=true;var trccolor="#D3F4F4";var secs=0;var timerID=null;var timerRunning=false;var delay=10;var temp1="";var traceRun=false;var trcClose=(eval(trcRead("trcClose")))?true:false;var trcflg=(eval(trcRead("trcCol")))? true:false;function $trc(){var elements=new Array();for (var i=0;i<arguments.length;i++){var element=arguments[i];if(typeof element=='string')element=document.getElementById(element);if(arguments.length==1)return element;elements.push(element);}return elements;}function buildTracerDiv(){document.write('\n<style type="text/css">div.traceFrame{border:1px #c6c6c6 solid;position:absolute;top:2%;left:70%;-moz-border-radius:10px;border-radius:10px;height:500px;background:lightyellow;width:300px;z-index:100000000000000;}div.tracerDrag{font-family:Verdana;border-bottom:1px #c6c6c6 solid;font-size:14px;font-weight:bolder;-moz-border-radius:10px;border-radius:10px;width:300px;cursor:move;height:25px;color:#909090;text-indent:8px;padding-top:3px;z-index:1000000;background:#86E8F2}div.tracerInner{position:absolute;top:65px;left:4px;font-family:Courier, "Courier New", monospace;border:1px #c6c6c6 solid;background:#F3F9F9;color:#000000;font-size:12px;overflow:auto;height:398px;width:290px;z-index:1000000;border-top:none;padding:1px;padding-top:8px;}input.trcBut{position:absolute;top:474px;margin:1px;font-weight:bolder;font-family:Verdana;font-size:10px;border:1px #c2c2c2 solid;border-top:none;border-left:none;z-index:1000000;height:20px;width:50px;}input.trcbutn{font-weight:bolder;font-family:Verdana;font-size:10px;border:1px #c2c2c2 solid;border-top:none;border-left:none;z-index:1000000;}input.trctext{position:absolute;top:474px;font-weight:bolder;font-family:Verdana;border:1px #c6c6c6 solid;border-bottom:none;border-right:none;z-index:1000000;height:20px;width:130px;}textarea.trcEval{position:absolute;font-family:Verdana;font-size:12px;overflow:auto;border:1px #666666 solid;border-bottom:1px #c9c9c9 solid;border-right:1px #c9c9c9 solid;width:275px;z-index:1000000;height:228px;padding:4px;}span.traceStat{font-weight:bolder;font-family:Courier, "Courier New", monospace;color:#ff0000;font-size:10px;text-decoration:blink;z-index:1000000;position:absolute;}span.traceInfo{font-weight:lighter;font-family:Verdana;z-index:1000000;color:#777777;}div.tracerHelp{border:1px #c6c6c6 solid;position:absolute;display:none;left:30%;background:lightyellow;font-size:12px;width:400px;text-align:justify;padding:5px;z-index:100000000000000;}div.tracerError{border:1px #FF9900 solid;background:#FD3631;color:#FFFFFF;z-index:1000000;font-weight:bold;}div.tracerTags{border:1px #c6c6c6 solid;position:absolute;top:45px;height:20px;z-index:1000000;border-top:none;font-weight:bolder;font-size:12px;cursor:default;}div.trcShadow{z-index:-1;left:0px;top:0px;border:4px black solid;border-top:none;border-left:none;opacity:0.2;filter:alpha(opacity=20);}.trcConcole{height:130px;width:282px;background:#CCCCCC;overflow:auto;border:1px #999999 solid;border-bottom:1px #c9c9c9 solid;border-right:1px #c9c9c9 solid;}div.trcOpen{width:120px;height:20px;border:1px #999999 solid;border-bottom:none;border-right:none;background:#3399CC;position:absolute;z-index:2000000000;right:0%;bottom:0%;padding:3px;text-align:center;cursor:default;color:#CCFFCC;font-size:15px;font-weight:bold;display:none;}div.trcErrorNot{position:absolute;font-family:Verdana;color:red;text-decoration:blink;font-size:15px;display:none;}</style>');errorStat=(trcError1)? "Started":"Stopped";document.write('<div align="center" id="traceFrame" class="traceFrame"><div align="center" id="traceShadow" class="traceFrame trcShadow"></div><div id="tracerTrag" align="left" class="tracerDrag" ondblclick="void(0);" onmouseover="javascript:over1_t=true;" onmouseout="javascript:over1_t=false;"><div id="trcdrag_err" class="trcErrorNot" style="left:143px;">Error!</div><input style="color:#FF0000;top:1px;left:270px;width:25px;" class="trcBut" type="button" value="X" onmousedown="closeTracer()"><input  style="top:1px;left:243px;width:25px;" class="trcBut" type="button" onmousedown="tracerCollapse()" value="__"><input style="color:#009900;top:1px;left:216px;width:25px;" class="trcBut" type="button" onmousedown="tracerInfo()" value="?">= Trace Output =</div><div class="tracerTags" id="traceAllTag" style="background:#00CCFF;left:4px;width:55px;" onclick="tracerFlip(2)">All</div><div class="tracerTags" id="traceOutTag" style="background:#F3F9F9;left:59px;width:55px;" onclick="tracerFlip(1)">Output</div><div class="tracerTags" id="traceExeTag" style="background:lightblue;left:114px;width:55px;" onclick="tracerFlip(4)">Run JS</div><div class="tracerTags" id="traceErrTag" style="background:#F3F9CC;left:169px;width:55px;" onclick="tracerFlip(3)">Errors</div><div class="tracerTags" id="traceSetTag" style="background:#9BF4BF;left:224px;width:70px;" onclick="tracerFlip(5)">Settings</div><div id="traceInnerAll" align="left" class="tracerInner" style="background:#00CCFF;visibility:hidden"></div><div id="traceInner" align="left" class="tracerInner"></div><div id="traceInner2" align="left" class="tracerInner" style="background:#F3F9CC;visibility:hidden"></div><div id="traceInnerExe" align="left" class="tracerInner" style="background:lightblue;visibility:hidden"><div id="trcConsole" class="trcConcole"></div><textarea id="trcEval" class="trcEval"></textarea><input type="button" class="trcBut" style="left:4px;top:380px;" onclick="trcApply()" value="Apply" /></div><div id="traceInnerSet" align="left" class="tracerInner" style="background:#9BF4BF;visibility:hidden;font-family:Verdana;">Error Handling:<input class="trcbutn" type="button" onclick="trcError()" value="start" />&nbsp;&nbsp;<input class="trcbutn" type="button" onclick="trcStopError()" value="stop" />&nbsp;&nbsp;<span id="errorStat">'+errorStat+'</span><br><br>Shadow:<input class="trcbutn" type="button" onclick="trcShdwD();" value="Display" />&nbsp;&nbsp;<input class="trcbutn" type="button" onclick="trcShdwH()" value="Hide" /></div><div style="height:28px" align="left"><input class="trcBut" id="trcBut1" style="left:4px;" type="button" value="clear" onclick="clearTracer()"><input class="trctext" id="trcwatch" style="left:58px;" type="text" onkeypress="trckeypress(event);"><input class="trcBut" id="trcBut3" style="left:193px;" type="button" value="Watch" onclick="tracerWatch()"><input class="trcBut" id="trcBut4" style="left:247px;" type="button" value="Stop" onclick="stopTracerWatch()"><span id="traceStat" class="traceStat" style="left:200px;top:29px;" ></span></div></div><div id="tracerHelp" class="tracerHelp" style="opacity=0;" ondblclick="void(0);" onmouseover="over2_t=true;" onmouseout="over2_t=false;"></div><div id="trcOpenBut" class="trcOpen" onclick="closeTracer()">Open Trace</div>');}function tracerInfo(){delay=60;timer("fadeIn('tracerHelp')");delay=10;var text="<div style='text-align:left;border:1px #CCCCCC solid'>Please e-mail me about any suggestions, bugs or questions. serkanyersen@gmail.com</div><b>Help:</b><br>This Program is written By Serkan Yersen. <br> This programs main idea is to debugging javascript applications easily. and getting rid of the alerts<br> it can show you the runtime errors, with line numbers and file names<br> there are some functions that you can use, such as:<br> <b>trace():</b><br> this function is the same of alert(), but it prompts results to this area. and give them numbers.<br> <b>traceArr():</b><br>this function displays the arrays and it shows you to each element of an array. <br><b>traceAssoc():</b> This function is for associative arrays. if give this function an associative array it will show you the key and the value of each array element.<br><b>traceStr():</b>This function is almost the same as traceArr() but it works for strings shows you the each character of a string with numbers.<br> There is also one functionality right down there,<br> <b>Watch:</b> When you write an ID of an Object in text box, watch follows that elements content and prompts here. it's quite useful for hidden elements and auto changing elements.<br> <b>License:</b><br>Copyright (C) 2006, INTERLOGY LLC, Serkan Yersen<br>www.interlogy.com / www.jotform.com You can use the code in every where.keeping the comments will be appriciated but not required. Writer of this code is not responsible of any damages that users may have,use it in your own risk. Some of the codes in this application are belong to the Massimo Beatini's js floating dimming div application.You must not claim that you've writen the code, please show some respect to the coder.<br><input style='font-weight:bolder;font-family:Verdana;border:1px #c6c6c6 solid;\' type='button' value='close' align='center' onclick='closeHelp();'>";$trc('tracerHelp').innerHTML=text;}function closeHelp(){ delay=60;timer("fadeOut('tracerHelp')");delay=10;}function trcApply(){try{eval(document.getElementById('trcEval').value);}catch(e){traceError(e);}}function trcCreate(name,value,days){if(days){var date=new Date();date.setTime(date.getTime()+(days*24*60*60*1000));var expires=";expires="+date.toGMTString();}else var expires="";document.cookie=name+"="+value+expires+";path=/";}function trcRead(name){var nameEQ=name+"=";var ca=document.cookie.split(';');for(var i=0;i<ca.length;i++){var c=ca[i];while (c.charAt(0)==' ') c=c.substring(1,c.length);if(c.indexOf(nameEQ)==0) return c.substring(nameEQ.length,c.length);}return null;}function trckeypress(evt){evt=(evt) ? evt:window.event;if(evt.keyCode==13){tracerWatch();return false;}else{ return true;}}function traceEncode(str){var str2=false;if(typeof(str)=="object")return str;if(typeof(str) != "string")return str;if(str){ var text=document.createTextNode(str);var div=document.createElement('div');div.appendChild(text);return div.innerHTML;}else return str2;}function trcEraseError(elem){elem.style.background="#F3F9CC";elem.style.textDecoration="none";elem.style.color="black";if(trcRead("trcFlip") != "3"){$trc('traceErrTag').style.opacity=".4";$trc('traceErrTag').style.filter="alpha(opacity=40)";}$trc('trcdrag_err').style.display="none";$trc('trcOpenBut').innerHTML="Open Tracer";$trc('trcOpenBut').style.color="";$trc('trcOpenBut').style.textDecoration="";}function tracerFlip(stat){var elem=$trc('traceInner2','traceInnerAll','traceInner','traceErrTag','traceInnerExe','trcConsole','traceInnerSet');var tags=$trc('traceOutTag','traceAllTag','traceErrTag','traceExeTag','traceSetTag');for (x=0;x<elem.length;x++){if(x!=5 && x!=3)elem[x].style.visibility="hidden";}for (i=0;i<tags.length;i++){tags[i].style.opacity=".4";tags[i].style.filter="alpha(opacity=40)";}if(stat==3)trcEraseError(elem[3]);switch(parseInt(stat)){case 1:elem[2].style.visibility="visible";elemCH='traceOutTag';break;case 2:elem[1].style.visibility="visible";elemCH='traceAllTag';break;case 3:elem[0].style.visibility="visible";elemCH='traceErrTag';break;case 4:elem[4].style.visibility="visible";elemCH='traceExeTag';elem[5].style.display="block";break;case 5:elem[6].style.visibility="visible";elemCH='traceSetTag';break;default:trace("There is an error in the code wrong page id: "+stat);elem[1].style.visibility="visible";elemCH='traceAllTag';break;}$trc(elemCH).style.opacity="1.0";$trc(elemCH).style.filter="alpha(opacity=100)";trcCreate("trcFlip",stat,365);}function tracerAdd(main,add){var temp,temp2;inner=$trc(main).innerHTML;temp=inner;inner=add;inner += temp;$trc(main).innerHTML=inner;inner2=$trc('traceInnerAll').innerHTML;temp2=inner2;inner2=add;inner2 += temp2;$trc('traceInnerAll').innerHTML=inner2;$trc('trcConsole').innerHTML=inner2;}function trace(msg){trccolor=(trccolor=="#D3F4F4")? "#B3EBE8":"#D3F4F4";style="style='word-wrap:break-word;background:"+trccolor+"'";if(arguments.length>1){var args="<br>&nbsp;&nbsp;1: "+traceEncode(arguments[0]);for(x=1;x<arguments.length;x++){args += "<br>&nbsp;&nbsp;"+(x+1)+": "+traceEncode(arguments[x]);}var add="<div "+style+"><span class='traceInfo'>"+traceLine+"</span>:&nbsp;&nbsp;"+args+"</div>";}else var add="<div "+style+"><span class='traceInfo'>"+traceLine+"</span>:&nbsp;&nbsp;"+ traceEncode(msg)+"</div>";tracerAdd('traceInner',add);traceLine += 1;}function traceError(msg){traceErr++;$trc('traceErrTag').style.opacity="1.0";$trc('traceErrTag').style.filter="alpha(opacity=100)";$trc('traceErrTag').style.background="#FF0000";$trc('traceErrTag').style.textDecoration="blink";$trc('traceErrTag').style.color="yellow";if(eval(trcRead("trcCol")) || eval(trcRead("trcClose")))$trc('trcdrag_err').style.display="block";$trc('trcOpenBut').innerHTML="Error!";$trc('trcOpenBut').style.color="red";$trc('trcOpenBut').style.textDecoration="blink";if(arguments.length>1){var args="<br>&nbsp;&nbsp;1: "+traceEncode(arguments[0]);for(x=1;x<arguments.length;x++){args += "<br>&nbsp;&nbsp;"+(x+1)+": "+traceEncode(arguments[x]);}add="<div class='tracerError'><span >"+traceErr+"</span>:&nbsp;Error:<br>&nbsp;"+args+"</div>";}else add="<div class='tracerError'><span >"+traceErr+"</span>:&nbsp;Error:<br>&nbsp;"+ traceEncode(msg)+"</div>";tracerAdd('traceInner2',add);}function traceAssoc(arr){if(trccolor=="#D3F4F4") trccolor="#B3EBE8";else trccolor="#D3F4F4";var add="<div style='background:"+trccolor+"'>";add += "<span class='traceInfo'>"+traceLine+"</span>:<br>";for(var x in arr){add += "<span class='traceInfo'> -Key['"+x+"']: </span>"+ traceEncode(arr[x])+"<br>";}add += "</div>";tracerAdd('traceInner',add);traceLine += 1;}function traceArr(arr){if(trccolor=="#D3F4F4") trccolor="#B3EBE8";else trccolor="#D3F4F4";var add="<div style='background:"+trccolor+"'>";add += "<span class='traceInfo'>"+traceLine+"</span>:<br>";for(var x=0;x<arr.length;x++){add += "<span class='traceInfo'> - Arr["+x+"]: </span>"+ traceEncode(arr[x]) +"<br>";}add += "</div>";tracerAdd('traceInner',add);traceLine += 1;}function traceStr(str){if(trccolor=="#D3F4F4") trccolor="#B3EBE8";else trccolor="#D3F4F4";var add="<div style='background:"+trccolor+"'>";add += "<span class='traceInfo'>"+traceLine+"</span>:&nbsp;&nbsp;"+traceEncode(str)+"<br>";for(var x=0;x<str.length;x++){add += "<span class='traceInfo'> - String["+x+"]: </span>"+ str.charAt(x)+"<br>";}add += "</div>";tracerAdd('traceInner',add);traceLine += 1;}function MouseDown_t(e){if(over1_t){if(isMozilla_t){objDiv_t=$trc(DivID_t);X=e.layerX;Y=e.layerY;return false;}else{objDiv_t=$trc(DivID_t);objDiv_t=objDiv_t.style;X=event.offsetX;Y=event.offsetY;}}if(over2_t){if(isMozilla_t){objDiv2_t=$trc(DivID2_t);X=e.layerX;Y=e.layerY;return false;}else{objDiv2_t=$trc(DivID2_t);objDiv2_t=objDiv2_t.style;X=event.offsetX;Y=event.offsetY;}}}function MouseMove_t(e){if(objDiv_t){if(isMozilla_t){objDiv_t.style.top=(e.pageY-Y) + 'px';objDiv_t.style.left=(e.pageX-X) + 'px';return false;}else{objDiv_t.pixelLeft=event.clientX-X + document.body.scrollLeft;objDiv_t.pixelTop=event.clientY-Y + document.body.scrollTop;return false;}}if(objDiv2_t){if(isMozilla_t){objDiv2_t.style.top=(e.pageY-Y) + 'px';objDiv2_t.style.left=(e.pageX-X) + 'px';return false;}else{objDiv2_t.pixelLeft=event.clientX-X + document.body.scrollLeft;objDiv2_t.pixelTop=event.clientY-Y + document.body.scrollTop;return false;}}}var top,left;function MouseUp_t(){if(objDiv_t){top=(isMozilla_t)? objDiv_t.style.top:objDiv_t.pixelTop;left=(isMozilla_t)? objDiv_t.style.left:objDiv_t.pixelLeft;trcCreate("trcTop",top,365);trcCreate("trcLeft",left,365);}objDiv_t=null;objDiv2_t=null;}function clearTracer(){$trc('traceInner').innerHTML="";$trc('traceInner2').innerHTML="";$trc('traceInnerAll').innerHTML="";$trc('trcConsole').innerHTML="";trcEraseError($trc('traceErrTag'));traceLine=1;traceErr =0;}function closeTracer(){$trc('traceFrame').style.display=(!trcClose)? "block":"none";$trc('trcOpenBut').style.display=(trcClose)? "block":"none";trcCreate("trcClose",trcClose,365);trcClose=(trcClose)? false:true;}function trcShdwD(){trcCreate("trcShClose","display",365);$trc('traceShadow').style.display="block";}function trcShdwH(){trcCreate("trcShClose","hide",365);$trc('traceShadow').style.display="none";}function tracerCollapse(width){trcCreate("trcCol",trcflg,365);var visibility, height;if(trcflg){visibility="hidden";height=(isMozilla_t)? "28px":"28px";trcflg=false;}else{visibility="visible";height="500px";trcflg=true;}elems=$trc('traceInner2','traceInner','traceInnerAll','traceOutTag','traceAllTag','traceErrTag','trcBut1','trcwatch','trcBut3','trcBut4','traceStat','traceExeTag','traceInnerExe','traceShadow','traceInnerSet','traceSetTag');for(var x=0;x<elems.length;x++){elems[x].style.visibility=visibility;}$trc('traceFrame').style.height=height;if(trcflg)tracerFlip(trcRead("trcFlip"));}function printError_t(){ traceErr++;$trc('traceErrTag').style.opacity="1.0";$trc('traceErrTag').style.filter="alpha(opacity=100)";$trc('traceErrTag').style.background="#FF0000";$trc('traceErrTag').style.textDecoration="blink";$trc('traceErrTag').style.color="yellow";if(eval(trcRead("trcCol")) || eval(trcRead("trcClose")))$trc('trcdrag_err').style.display="block";$trc('trcOpenBut').innerHTML="Error!";$trc('trcOpenBut').style.color="red";$trc('trcOpenBut').style.textDecoration="blink";var inner=$trc('traceInner2').innerHTML;var tracedFileName=new Array();tracedFileName=e_file.split('/');var error_d="<div class='tracerError' id='tracerError"+traceErr+"'><br>"+traceErr+": Error in file: <a href='" + e_file + "' target='_blank'>" + tracedFileName[tracedFileName.length -1] + "</a><br>Line :" + e_line + "<br>Error: " + e_msg+"<br></div>";tracerAdd('traceInner2',error_d);}function trcError(){window.onerror=function(msg, file_loc, line_no){ e_msg=msg; e_file=file_loc; e_line=line_no;printError_t();return true;};$trc('errorStat').innerHTML='Started';trcCreate("trcError1","true",365);}function trcStopError(){window.onerror=null;trcCreate('trcError1','false',365);$trc('errorStat').innerHTML='Stopped';}var trctemp1=new Array();var trctemp;function tracerWatch(){if($trc('trcwatch').value){var id="$trc('"+$trc('trcwatch').value.replace(/,/g,"','")+"')";var ids=eval(id);if(ids.length>0 || ids != ""){if(!traceRun){$trc('traceStat').innerHTML="Watching";$trc('trcwatch').disabled=true;traceRun= true;}self.status=secs;secs=secs - 1;timerRunning=true;timerID=self.setTimeout("tracerWatch()", delay);if(ids.length>0){for(i in ids){if(trctemp1[i] != ids[i].value){ trace(ids[i].id+"= "+ids[i].value);}trctemp1[i]=ids[i].value;}}else{var obj=$trc(ids);if(trctemp != obj.value){ trace(obj.id+".value= "+obj.value);}trctemp=obj.value;}}else trace("You have to enter the ID of an object. for example id of an hidden field. when it changes this will show you the content.");}else trace("You have to enter the ID of an object. for example id of an hidden field. when it changes this will show you the content.");}function stopTracerWatch(){$trc('trcwatch').disabled=false;if(timerRunning){clearTimeout(timerID);$trc('traceStat').innerHTML="";}timerRunning=false;traceRun= false;}function timer(func,duration){self.status=secs;secs=secs + 1;timerRunning=true;timerID=self.setTimeout(func, delay);if(secs==50){clearTimeout(null);}}function fadeOut(elem){var d=$trc(elem);if(isMozilla_t){var op=d.style.opacity;op=op/2;d.style.opacity=op - 0.01;if(d.style.opacity>0)timer("fadeOut('tracerHelp')");else{d.style.display="none";d.style.opacity=0;}}else{var op=(d.style.filter)? d.style.filter.match(/alpha\(opacity=(.*)\)/)[1]:100;op=parseInt(op)-10;d.style.filter="alpha(opacity="+op+")";if(op>0)timer("fadeOut('tracerHelp')");else{d.style.display="none";d.style.filter="alpha(opacity=0)";}}}function fadeIn(elem){var d=$trc(elem);if(isMozilla_t){d.style.display="block";if(d.style.opacity<0)d.style.opacity=0;op=d.style.opacity;op++;d.style.opacity=op/2;if(d.style.opacity<1)timer("fadeIn('tracerHelp')");else d.style.opacity=1;}else{d.style.display="block";var op=(d.style.filter)? d.style.filter.match(/alpha\(opacity=(.*)\)/)[1]:0;op=(parseInt(op)+1)*2;d.style.filter="alpha(opacity="+op+")";if(op<100)timer("fadeIn('tracerHelp')");else d.style.filter="alpha(opacity=100)";}}function init_t(){isMozilla_t=(document.all) ? 0:1;buildTracerDiv();document.onmousedown=MouseDown_t;document.onmousemove=MouseMove_t;document.onmouseup=MouseUp_t;if(trcRead("trcError1") != null){if(eval(trcRead("trcError1")))trcError();}else{trcError1=true;trcError();}}function trcDefaults(){init_t();if(trcRead("trcShClose")=="hide")trcShdwH();else trcShdwD();trcFlip=(eval(trcRead("trcFlip")))? trcRead("trcFlip"):"1";tracerFlip(trcFlip);$trc(DivID_t).style.top=trcRead("trcTop");$trc(DivID_t).style.left=trcRead("trcLeft");tracerCollapse();closeTracer();}trcDefaults();