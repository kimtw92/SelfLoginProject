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
//2���޴�����
//����޴� ��� �Ⱥ��̰�, ž�̹��� �⺻�̹�����
//10�̶�°��� ������ ���Դϴ�. �޴��� 10�� �Ѵ´ٸ� �� ����ŭ �������ֽø� �˴ϴ�.
for(i=1; i<10; i++){
if(document.getElementById("top2m" + i)){
  hide_menu = document.getElementById("top2m"+i);
  hide_menu.style.display = 'none';
}else{
}

  //�̹����� ����Ʈ �̹����� �ٲ��ִ� �κ�
if(document.getElementById("menu" + i)){
  def_img = document.getElementById("menu"+i);
  def_img.src = "../images/skin1/menu/topMu_1depth0" + i + ".gif";
}else{
}
}

top1Menu = document.getElementById("menu"+a);
top2Menu = document.getElementById("top2m"+a);

var d1n = 0; if(d1n<10){d1nn='0'+d1n;} //������ġ1���޴����������޾ƿ�

if(a<10){ann='0'+a;}
if (a==0){ //������ġ1���޴����ý�.. �̹�Ȱ��ȭ�Ǿ��־�ƹ������۾���
}else{
  //���콺 �̺�Ʈ �߻��� �޴� �̹����� �ٲ��ִ� �κ�
//"M"�� �̹��� �̸��� �պκ� ann�� ��ȣ "_on"�� �̹��� ���ϳ��� �޺�
// �޴��� ex) ����Ʈ : M01.gif, ���� M01_on.gif
if (top1Menu) { top1Menu.src="../images/menu/topMu_1depth0" + ann + "_on.gif"; }
if (top2Menu) {
  top2Menu.style.display = 'block'; 
}
}
} 
function top2menuHide(a){ //2���޴����߱�
top1Menu = document.getElementById("menu"+a);
top2Menu = document.getElementById("top2m"+a);

var d1n = 0; if(d1n<10){d1nn='0'+d1n;} //������ġ1���޴����������޾ƿ�

if(a<10){ann='0'+a;}
if (top1Menu) { top1Menu.src="../images//menu/topMu_1depth0" + ann + ".gif"; }
if (top2Menu) { top2Menu.style.display = 'none'; }
if (d1n!=8&&d1n!=""&&d1n!=0){
document.getElementById("menu"+d1n+"").src = "../images/menu/topMu_1depth0"+d1nn+"_on.gif"; //������ġ1���޴�Ȱ��
document.getElementById("top2m"+d1n+"").style.display = 'block'; //������ġ1���޴�Ȱ��
}
}
document.onload=top2menuHide(0); //�������ε��������ġ1���޴�Ȱ��
//-->



//�����޴�
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
