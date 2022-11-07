
function fnGoMenu(menuNum,htmlId){
	//location.href = "/homepage/html.do?mode=ht&htmlId=" + htmlId;
	if(menuNum == '1') {
		location.href = "/mypage/myclass.do?mode=" + htmlId;	
	} else if(menuNum == '2') {
		location.href = "/homepage/infomation.do?mode=" + htmlId;
	}else if(menuNum == '3') {
		location.href = "/homepage/course.do?mode=" + htmlId;
	}else if(menuNum == '4') {
		location.href = "/homepage/attend.do?mode=" + htmlId;
	}else if(menuNum == '5') {
		location.href = "/homepage/support.do?mode=" + htmlId;
	}else if(menuNum == '6') {
		location.href = "/homepage/ebook.do?mode=" + htmlId;
	}else if(menuNum == '7') {
		location.href = "/homepage/introduce.do?mode=" + htmlId;
	}else if(menuNum == '8') {
		location.href = "/mypage/paper.do?mode=" + htmlId;
	}else if(menuNum == '9') {
		location.href = "/homepage/index.do?mode=" + htmlId;
	}else if(menuNum == '10') {
		location.href = "/homepage/join.do?mode=" + htmlId;
	}	
}

function openSub(id) {
	for(num=1; num<=6; num++) 
	{
		document.getElementById('sub'+num).style.display='none';
	
	}

	document.getElementById(id).style.display='block'; //해당 ID만 보임
}

function outSub() {
	for(num=1; num<=6; num++) 
	{
		document.getElementById('sub'+num).style.display='none';
	
	}

	//document.getElementById(id).style.display='block'; //해당 ID만 보임
}