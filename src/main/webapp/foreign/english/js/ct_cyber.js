<!--
//TOP MENU
function top2menuView(a){ 

for(i=1; i<10; i++){
	if(a==i) {
		document.getElementById("topmainimg"+a).src="../images/menu/topMu_1depth0"+a+"_on.gif";
		for(j=1; j<9; j++){
			if(a!=j){
				document.getElementById("topmainimg"+j).src="../images/menu/topMu_1depth0"+j+".gif";
			}
		}
	}
}	
//2차메뉴보기
//서브메뉴 모두 안보이게, 탑이미지 기본이미지로
//10이라는값은 임의의 값입니다. 메뉴가 10개 넘는다면 그 수만큼 수정해주시면 됩니다.
for(i=1; i<10; i++){
if(document.getElementById("top2m" + i)){
  hide_menu = document.getElementById("top2m"+i);
  hide_menu.style.display = 'none';
}else{
}

  //이미지를 디폴트 이미지로 바꿔주는 부분
if(document.getElementById("menu" + i)){
  def_img = document.getElementById("menu"+i);
  def_img.src = "../images/skin1/menu/topMu_1depth0" + i + ".gif";
}else{
}
}

top1Menu = document.getElementById("menu"+a);
top2Menu = document.getElementById("top2m"+a);

var d1n = 0; if(d1n<10){d1nn='0'+d1n;} //현재위치1차메뉴정수값을받아옴

if(a<10){ann='0'+a;}
if (a==0){ //현재위치1차메뉴선택시.. 이미활성화되어있어아무런동작안함
}else{
  //마우스 이벤트 발생시 메뉴 이미지를 바꿔주는 부분
//"M"은 이미지 이름의 앞부분 ann은 번호 "_on"은 이미지 파일네임 뒷분
// 메뉴명 ex) 디폴트 : M01.gif, 오버 M01_on.gif
if (top1Menu) { top1Menu.src="../images/menu/topMu_1depth0" + ann + "_on.gif"; }
if (top2Menu) {
  top2Menu.style.display = 'block'; 
}
}
} 
function top2menuHide(a){ //2차메뉴감추기
top1Menu = document.getElementById("menu"+a);
top2Menu = document.getElementById("top2m"+a);

var d1n = 0; if(d1n<10){d1nn='0'+d1n;} //현재위치1차메뉴정수값을받아옴

if(a<10){ann='0'+a;}
if (top1Menu) { top1Menu.src="../images//menu/topMu_1depth0" + ann + ".gif"; }
if (top2Menu) { top2Menu.style.display = 'none'; }
if (d1n!=8&&d1n!=""&&d1n!=0){
document.getElementById("menu"+d1n+"").src = "../images/menu/topMu_1depth0"+d1nn+"_on.gif"; //현재위치1차메뉴활성
document.getElementById("top2m"+d1n+"").style.display = 'block'; //현재위치1차메뉴활성
}
}
document.onload=top2menuHide(0); //페이지로드시현재위치1차메뉴활성
//-->



//좌측메뉴
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

function toggleD(obj)  { 
	if (obj.style.display == 'none') 
		obj.style.display = ''; 
	else 
		obj.style.display = 'none'; 
	}
//-->
