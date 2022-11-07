function fnTopMenu1_Type1() 
{
	this.menu = new Array();
	this.menuseq = 0;
	
	this.Start = function() {
		this.MenuBox = document.getElementById(this.DivName).getElementsByTagName("ul")[0].childNodes;
		
		// 메뉴의 갯수를 파악하는 부분
		//this.MenuLength = this.MenuBox.length;
		
		// 메뉴의 1뎁스 링크부분에 마우스나 키보드의 반응을 넣는 부분
		for ( var i=0; i<this.MenuLength; i++ ) {
			if ( this.MenuBox.item(i).tagName != "LI" ) { continue; }
			this.MenuLink = this.MenuBox.item(i).getElementsByTagName("a")[0];
			this.MenuLink.i = i;
			this.MenuLink.fnName = this.fnName;
			this.MenuLink.onmouseover = this.MenuLink.onfocus = function()	{ eval(this.fnName +".fnMouseOver(" + this.i + ")") }

			this.MenuSubBox = this.MenuBox.item(i).getElementsByTagName("div")[0];
			this.MenuSubMenu = this.MenuSubBox.getElementsByTagName("ul")[0].getElementsByTagName("li");
			this.MenuSubMenuLength = this.MenuSubMenu.length;
			
			// 메뉴의 2뎁스 링크부분에 마우스나 키보드의 반응을 넣는 부분
			for ( var j=0; j<this.MenuSubMenuLength; j++ ) {
				this.MenuSubLink = this.MenuSubMenu.item(j).getElementsByTagName("a")[0];
				this.MenuSubLink.i = i;
				this.MenuSubLink.j = j;
				this.MenuSubLink.fnName = this.fnName;
				/*
				this.MenuSubLink.onmouseover = this.MenuSubLink.onfocus = function()		{ eval(this.fnName +".fnMouseSubOver(" + this.i + "," + this.j + ")") }
				this.MenuSubLink.onmouseout = this.MenuSubLink.onblur = function()		{ eval(this.fnName +".fnMouseSubOut(" + this.i + "," + this.j + ")") }
				*/
			}
			
			this.MenuSubBox.style.display = "none";
			
			this.menuseq++;
			this.menu[this.menuseq] = i
		}
		
		if ( this.DefaultMenu != 0 ) {
			this.fnMouseOver(this.menu[this.DefaultMenu]);
			if ( this.DefaultSubMenu != 0 ) {
				this.fnMouseSubOver(this.menu[this.DefaultMenu],this.DefaultSubMenu - 1);
			}
		}
	}
	
	// 메뉴의 1뎁스 링크부분에 마우스나 키보드의 반응에 의해 실행하는 부분
	this.fnMouseOver = function(val) {
		for ( var i=0; i<this.MenuLength; i++ ) {
			if ( this.MenuBox.item(i).tagName != "LI" ) { continue; }
			this.MenuImg = this.MenuBox.item(i).getElementsByTagName("a")[0].getElementsByTagName("img")[0];
			this.MenuSDiv = this.MenuBox.item(i).getElementsByTagName("div")[0];
			if ( i == val ) {
				this.MenuImg.src = this.MenuImg.src.replace("_off.gif","_on.gif");
				this.MenuSDiv.style.display = "block";
			} else {
				this.MenuImg.src = this.MenuImg.src.replace("_on.gif","_off.gif");
				this.MenuSDiv.style.display = "none";
			}
		}
	}
	
	// 메뉴의 2뎁스 링크부분에 마우스나 키보드의 반응에 의해 실행하는 부분
	this.fnMouseSubOver = function(mnum,snum) {
		this.SubMenuImg = this.MenuBox.item(mnum).getElementsByTagName("div")[0].getElementsByTagName("ul")[0].getElementsByTagName("li")[snum].getElementsByTagName("a")[0].getElementsByTagName("img")[0];
		this.SubMenuImg.src = this.SubMenuImg.src.replace("_off.gif","_on.gif");
	}
	this.fnMouseSubOut = function(mnum,snum) {
		this.SubMenuImg = this.MenuBox.item(mnum).getElementsByTagName("div")[0].getElementsByTagName("ul")[0].getElementsByTagName("li")[snum].getElementsByTagName("a")[0].getElementsByTagName("img")[0];
		this.SubMenuImg.src = this.SubMenuImg.src.replace("_on.gif","_off.gif");
	}	
}

$(function(){
	$('.mLv2').hide();
	
	$('.mLv1').mouseover(function(){
		var index = $(this).index('.mLv1');
		$('.mLv2').each(function(i){
			if(index == i)
			{
				if($('.mLv1Img').eq(i).attr('src').lastIndexOf("_on.gif") == -1)
					$('.mLv1Img').eq(i).attr('src', $('.mLv1Img').eq(i).attr('src').replace(/.gif/,'_on.gif'));
				$(this).show();
			}
			else
			{
				$('.mLv1Img').eq(i).attr('src', $('.mLv1Img').eq(i).attr('src').replace(/_on.gif/,'.gif'));
				$(this).hide();
			}
		});
	});
	$('#btnMenuAllOpen').click(function(){
		$('#menu_all').show();
	});
	$('#btnMenuAllClose').click(function(){
		$('#menu_all').hide();
	});
});