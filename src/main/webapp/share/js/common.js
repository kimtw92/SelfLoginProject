function imageOver(imgs) {
	imgs.src = imgs.src.replace("off.gif", "on.gif");
}
function imageOut(imgs) {
	imgs.src = imgs.src.replace("on.gif", "off.gif");
}

// png ���� ���� ó�� 
function setPng24(obj) {
    obj.width=obj.height=1;
    obj.className=obj.className.replace(/\bpng24\b/i,'');
    obj.style.filter = "progid:DXImageTransform.Microsoft.AlphaImageLoader(src='"+ obj.src +"',sizingMethod='image');"
    obj.src='';
    return '';
}

function ChangeImage(strImg,alt_a)
{
	document.b_img.src = strImg;
	document.b_img.alt = alt_a;
}

function MM_showHideLayers() { //v9.0
  var i,p,v,obj,args=MM_showHideLayers.arguments;
  for (i=0; i<(args.length-2); i+=3) 
  with (document) if (getElementById && ((obj=getElementById(args[i]))!=null)) { v=args[i+2];
    if (obj.style) { obj=obj.style; v=(v=='show')?'visible':(v=='hide')?'hidden':v; }
    obj.visibility=v; }
}

///////////////////////////////////////////
// IE activeX patch
// author Jackie Lee (jackie72@korea.com)
// http://www.motiongr.com
// create date 2007.06.19
// version 1.0
// ������ �������� ������ �ֽñ� �ٶ��ϴ�
///////////////////////////////////////////

//flash(��¿���ID��NAME,�÷������ϰ��,WIDTH,HEIGHT,FLASHVARS,BackgroundColor,WMOD)

function flash(fid,fnm,wid,hei,fvs,bgc,wmd) {
	var flash_tag = "";
	flash_tag = '<object classid="clsid:d27cdb6e-ae6d-11cf-96b8-444553540000" codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=8,0,0,0" width="'+wid+'" height="'+hei+'" id="'+fid+'" align="middle">';
	flash_tag +='<param name="allowScriptAccess" value="always" />';
	flash_tag +='<param name="allowFullScreen" value="false" />';
	flash_tag +='<param name="movie" value="'+fnm+'" />';
	flash_tag +='<param name="FlashVars" value="'+fvs+'" />';
	flash_tag +='<param name="quality" value="high" />';
	flash_tag +='<param name="bgcolor" value="'+bgc+'" />';
	flash_tag +='<param name="wmode" value="'+wmd+'" />';
	flash_tag +='<embed src="'+fnm+'" quality="high" bgcolor="'+bgc+'" FlashVars="'+fvs+'" wmode="'+wmd+'" width="'+wid+'" height="'+hei+'" name="'+fid+'" align="middle" allowScriptAccess="always" allowFullScreen="false" type="application/x-shockwave-flash" pluginspage="http://www.macromedia.com/go/getflashplayer" />';
	flash_tag +='</object>';
	
	document.write(flash_tag);
}

function phone_tab(id) {
	for(num=1; num<=2; num++) document.getElementById('phone'+num).style.display='none'; 
	document.getElementById(id).style.display='block'; //�ش� ID�� ����
}

function board_tab(id) {
	for(num=1; num<=3; num++) document.getElementById('board'+num).style.display='none'; 
	document.getElementById(id).style.display='block'; //�ش� ID�� ����
}

function site_tab(id) {
	for(num=1; num<=3; num++) document.getElementById('site'+num).style.display='none'; 
	document.getElementById(id).style.display='block'; //�ش� ID�� ����
}

//�۷ι� �׺���̼�(2Depth �޴��׷�)�� ���� ���콺 �Ǵ� Ű���� ����(����/����)����
function openSub(id) {
	try {
		for(num=1; num<=6; num++) 
		{
			document.getElementById('sub'+num).style.display='none';
		
		}

		document.getElementById(id).style.display='block'; //�ش� ID�� ����
	} catch (e) {
	}
}

function outSub(id) {
	try {
		for(num=1; num<=6; num++) 
		{
			document.getElementById('sub'+num).style.display='none';
		
		}

		document.getElementById(id).style.display='block'; //�ش� ID�� ����
	} catch (e) {
	}
}

var cssmenuids=["cssmenu1"] //Enter id(s) of CSS Horizontal UL menus, separated by commas
var csssubmenuoffset=-1 //Offset of submenus from main menu. Default is 0 pixels.

function createcssmenu2(){
for (var i=0; i<cssmenuids.length; i++){
  var ultags=document.getElementById(cssmenuids[i]).getElementsByTagName("ul")
    for (var t=0; t<ultags.length; t++){
            ultags[t].style.top=ultags[t].parentNode.offsetHeight+csssubmenuoffset+"px"
        var spanref=document.createElement("span")
            spanref.className="arrowdiv"
            spanref.innerHTML="&nbsp;&nbsp;&nbsp;&nbsp;"
            ultags[t].parentNode.getElementsByTagName("a")[0].appendChild(spanref)
        ultags[t].parentNode.onmouseover=function(){
        this.getElementsByTagName("ul")[0].style.visibility="visible"
		
        }
        ultags[t].parentNode.onmouseout=function(){
            this.getElementsByTagName("ul")[0].style.visibility="hidden"
    }
    }
  }
}

if (window.addEventListener)
window.addEventListener("load", createcssmenu2, false)
else if (window.attachEvent)
window.attachEvent("onload", createcssmenu2)