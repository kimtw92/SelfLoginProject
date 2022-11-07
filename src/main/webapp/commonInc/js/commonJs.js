


//***************************************************************
// singleSelectBox 용
// date : 2008.06.01
// auth : kang
// 참고 페이지 : /LOTI/WebRoot/baseCodeMgr/dic/dicList.jsp
// [ 파라메터 설명 ]
// mode : action 에 넘길 mode값
// divId : selectBox를 만들 레이어 name
// objId : selectBox Name
// code : selectBox value에 해당하는 컬럼명
// codeNm : selectBox 에 표시될 컬럼명
// findCode : selectBox를 생성한 뒤 selected 로 설정값
// width : selectBox 넓이
// asyn : Ajax 를 비동기로 동작 = true,  동기로 동작 = false
// isOneData : true= findCode에 해당하는 하나의 값만 나타남
// isLoading : loading 이미지 표시유무 tre, flase
//***************************************************************
var singleSelectBoxCreateCount = 0;

function fnSingleSelectBoxByAjax(mode, divId, objId, code, codeNm, findCode, width, asyn, isOneData, isLoading){

	singleSelectBoxCreateCount += 1;

	var url = "/commonInc/singleSelectBox.do";
	var pars = "mode=" + mode;
	pars += "&objId=" + objId;
	pars += "&code=" + code;
	pars += "&codeNm=" + codeNm;
	pars += "&findCode=" + findCode;
	pars += "&width=" + width;
	pars += "&isOneData=" + isOneData;
	
	
	var myAjax = new Ajax.Updater(
		{success:divId},
		url, 
		{
			asynchronous : asyn,
			method : "get", 
			parameters : pars,
			onLoading : function(){				
				
				$(objId).style.width = width;
				$(objId).options.add(new Option("데이타 불러오는중..", ""));
				
				if(isLoading == "true"){
					//$(objId).startWaiting('bigWaiting');
					$(document.body).startWaiting('bigWaiting');
				}
			},
			onSuccess : function(){
												
				singleSelectBoxCreateCount -= 1;
				
				if(singleSelectBoxCreateCount <= 0){
					if(isLoading == "true"){
						//$(document.body).stopWaiting();						
						window.setTimeout( $(document.body).stopWaiting.bind( $(document.body) ), 500);
						singleSelectBoxCreateCount = 0;
					}
				}
				

			},
			onFailure : function(){
			
				alert("셀렉트박스 생성시 오류가 발생했습니다.");
				$(objId).options.add(new Option("", ""));
				
				if(isLoading == "true"){
					window.setTimeout( $(document.body).stopWaiting.bind( $(document.body) ), 500);
				}
			}			
		}
	);
}

//숫자체크
function isNum(str, inputName){
	//inputName 체크할려는 네임 
	//str 체크할려는 값 
	if(str.length <= 0){
		//빈값이 들어왔을경우	
		alert(inputName+" 입력하십시요");
		return false;
	}
	
	for(i=0; i<str.length; i++){
		var cv = str.charCodeAt(i);
		if(( 47 >= cv || 58 <= cv)){
			if(inputName != null || inputName != ""){
				alert(inputName+" 숫자로 정확히 입력해 주십시요.");
				return false;
			}else{
				alert("숫자로 정확히 입력해 주십시요.");
				return false;
			}
		}
	}   
  return true;
}








function trim(str){
	return str.replace(/(^\s*)|(\s*$)/gi, "");
}


//문자제한
function inputCharsOnly(input, chars, type){      
    for(var inx=0; inx<input.value.length; inx++){ 
        if(chars.indexOf(input.value.charAt(inx)) == -1){ 
            if(type == 'alpha') 
                alert('알파벳만 허용 됩니다.'); 
            else if(type == 'number') 
                alert('숫자만 허용 됩니다.'); 
            else if(type == 'nokorean') 
                alert('한글을 제외한 나머지만 허용 됩니다.'); 
            else if(type == 'numbar')
                alert('숫자와 소수점(.)만 허용됩니다.');
                
            input.value = ''; 
            input.focus(); 
            return false; 
        } 
    }     
    return true;
}

// 한글이외의 캐릭터가 있을경우 false 
// 한자나 숫자 영문의 경우 false 
function checkKoreanOnly( koreanChar ) {
   
   if ( koreanChar == null ) return false ;
   
   for(var i=0; i < koreanChar.length; i++){ 

     var c=koreanChar.charCodeAt(i); 

     //( 0xAC00 <= c && c <= 0xD7A3 ) 초중종성이 모인 한글자 
     //( 0x3131 <= c && c <= 0x318E ) 자음 모음 

     if( !( ( 0xAC00 <= c && c <= 0xD7A3 ) || ( 0x3131 <= c && c <= 0x318E ) ) ) {      
        return false ; 
     }
   }  
   return true ;
}

// 영문 이외의 캐릭터가 있을경우 false 
function checkEnglishOnly( englishChar ) {  
    
    if ( englishChar == null ) return false ;
       
    for( var i=0; i < englishChar.length;i++){          
       var c=englishChar.charCodeAt(i);       
       if( !( (  0x61 <= c && c <= 0x7A ) || ( 0x41 <= c && c <= 0x5A ) ) ) {         
        return false ;       
       }
     }      
    return true ;    
}

// null -> "" 로 변환
function nullToEmpty(str){
	if(str == null){
		return "";
	}else{
		return str;
	}
}

function fileDownloadPopup(groupfileNo){
	//alert(groupfileNo);
	var url = "/commonInc/fileDownload.do";
	var pars = "?mode=popup&groupfileNo="+groupfileNo;
	popWin( url+pars, "fileDownPop", 450, 300, 0, 0);
}

// ut.lib.servlet.DownloadServlet 이용
// path : 예> /AS_tmp/subjdata/
function fnGoFileDown(path, name){
	location.href = "/Down/Download?downFileName=" + path + "&downPath=" + name;
}

function fnGoFileDownNoPds(path, name){
	location.href = "/Down/Download?downFileName=" + path + "&downPath=" + name + "&isPds=no";
}


//파일 다운로드.
function fileDownload(groupfileNo, fileNo){
	//alert(groupfileNo);
	var url = "/Down/DownloadInno";
	var pars = "?groupfileNo=" + groupfileNo + "&fileNo=" + fileNo;

	location.href = url + pars;

}

// 가운데 팝업
function popWin( url, name, w, h, scroll, status) {

  	var wl = (window.screen.width/2) - ((w/2) + 10);
  	var wt = (window.screen.height/2) - ((h/2) + 50);

  	var option = "height="+h+",width="+w+",left="+wl+",top="+wt+",screenX="+wl+",screenY="+wt+",scrollbars="+scroll + ", status="+status;
	
	commonPopWin = window.open( url, name, option );
  	commonPopWin.focus();

}

// 팝업관리 사용자가 위치 직접 입력
function popupWindow( url, name, w, h, l, t, scroll, status) {
	// w : width
	// h : height
	// l : left
	// t : top

  	var option = "height="+h+",width="+w+",left="+l+",top="+t+",screenX="+l+",screenY="+t+",scrollbars="+scroll + ", status="+status;
	
	commonPopWin = window.open( url, name, option );
  	commonPopWin.focus();

}


// value 가 "" 이면 숫자 0 을 리턴
function emptyToNum(value){

	var retValue = "";
	
	if( value != "" ){
		retValue = value;		
	}else{
		retValue = "0";
	}
	
	return retValue;
}

// 문자열에 특수기호가 있다면 true 를 return...	
function isCheckIDChar(sBuf) {		
	var sChk = "!@#$%&*()|'[];:\" ^|><~`=+-\\/{}^_,.?";   //Allowed Charater : '_' (under score)
	for ( var i=0; i<sBuf.length; i++ ) {
		if (sChk.indexOf(sBuf.charAt(i)) >= 0) {
			alert("아이디에 특수기호가 있습니다.  아이디는 영문자와 숫자만 가능합니다.");
			return true;
		}
	}
	return false;
}

/*---------------------------------------------------------+
|	LPAD	: 주어진 Value값의 좌측에 chr문자를 PADDING하여 리턴
|   	value	: 의미있는 값
|	chr	: 좌측에 붙이고자 하는 값
|	length	: return 해야 하는 값의 총길이
+----------------------------------------------------------*/
function LPAD(value, chr, length){
	var Str = new String();
	var StrLength = 0;
	var ReqLength = 0;
	var RetStr = new String();
	var AppendChr = new String();

	Str = value + "";
	StrLength = Str.length;

	ReqLength = length - StrLength;

	AppendChr = chr + "";

	for (var i=0; i<ReqLength; i++)
	{
		RetStr += AppendChr;
	}
	RetStr += value;
	return RetStr;
}

/*---------------------------------------------------------+
|	RPAD	: 주어진 Value값의 우측측에 chr문자를 PADDING하여 리턴
|   	value	: 의미있는 값
|	chr	: 좌측에 붙이고자 하는 값
|	length	: return 해야 하는 값의 총길이
+----------------------------------------------------------*/
function RPAD(value, chr, length){

	var Str = new String();
	var StrLength = 0;
	var ReqLength = 0;
	var RetStr = new String();
	var AppendChr = new String();
	var RetString = new String();

	Str = value + "";
	StrLength = Str.length;

	ReqLength = length - StrLength;

	AppendChr = chr + "";

	for (var i=0; i<ReqLength; i++)
	{
		RetStr += AppendChr;
	}
	RetString = Str + RetStr;
	return RetString;
}

// 텍스트에서 특정 문자 제거
// str : 문자
// str2 : 제거할 문자
function textDel(str,str2){

	var retValue = "";
	var i = 0;
	for (i = 0; i < str.length; i++) {

		if (str.charAt (str.length - i -1) != str2) {
			retValue = str.charAt (str.length - i -1) + retValue;
		}
	}
    return retValue;
}



/*--------------------------------------------------+
|	검색어 검사 파라메터 스트링에 [']/["]/[#]/[$]/[%]/[*]/[--] 입력여부 검사
+--------------------------------------------------*/
function IsValidCharSearch(param)
{
	var str = new String();
	str = param + "";

	while ( ( str.indexOf("'") > -1 )
			||( str.indexOf('"') > -1 )
			||( str.indexOf('#') > -1 )
			||( str.indexOf('$') > -1 )
			||( str.indexOf('%') > -1 )
			||( str.indexOf('*') > -1 )
			||( str.indexOf('--') > -1 )
		){
		
		alert ("검색어 입력어로서 [']/[\"]/[#]/[$]/[%]/[*]/[--] 문자를 사용할 수 없습니다.");
		return false
	}

	return true;
}


// 두번째 파라미터로 넘긴 특정 문자 체크 
function isCharaterCheck(arg_v,arg_ch)
{
	for (i=0; i < arg_v.length; i++)
	{
		var substr = arg_v.substring(i, i+1);		
		if (arg_ch.indexOf(substr) < 0) 
			return false;	
		
	}
	
	return true;
}
// 영숫자 판별
function isAlphaNumCheck(arg_v)
{
	var alpha_num_Str = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";

	for (i=0; i < arg_v.length; i++)
	{
		var substr = arg_v.substring(i, i+1);		
		if (alpha_num_Str.indexOf(substr) < 0) 
			return false;	
		
	}
	
	return true;
}



//Only Korean
function Check_onlyKorean(id_text){
	for ( var i=0; i < id_text.length; i++ ) {
		if ( id_text.charCodeAt(i) < 0xAC00 || id_text.charCodeAt(i) > 0xD7A3){
			if (( id_text.charCodeAt(i) < 12593 || id_text.charCodeAt(i) > 12643 ) && ( id_text.charCodeAt(i) != 32)) {
				return true;
			}
		}
	}	
	return false;
}









// 나모 웹 에디터
function fnWebEdit(objname, width, height){

	var cont = "<OBJECT WIDTH=0 HEIGHT=0 CLASSID='clsid:5220cb21-c88d-11cf-b347-00aa00a28331'>"
	+"<PARAM NAME='LPKPath' VALUE='/commonInc/webedit/NamoWec5_IMCLOTI.lpk'></OBJECT>"
	+"<OBJECT ID='" + objname + "' WIDTH='" + width + "' HEIGHT='"+ height + "'CLASSID='CLSID:7C560EB1-E258-419c-9323-B807A747719F' "
	+" CODEBASE='/commonInc/webedit/NamoWec.cab#version=5,0,0,47'>"
	+"<param name='InitFileURL' value='/commonInc/webedit/namowec.env'>"
	+"<param name='InitFileVer' value='2.4'>"
	+"</OBJECT>";
	document.write(cont);
}


/*--------------------------------------------------+
|	F11, F5, 소스보기 막기, ctrl-c, ctrl-v 막기
| document.onkeydown = processKey;
| document.oncontextmenu = nocontextmenu;
| document.onselectstart=new Function("return false");
| document.ondragstart=new Function("return false");
+--------------------------------------------------*/
if (window.event){ // 넷스케이프에서만 대문자 E.
  document.captureEvents(event.MOUSEUP); // mouse up 이벤트를 잡음
}
function nocontextmenu() {
   event.cancelBubble = true
   event.returnValue = false;
   return false;
}
function processKey()
{
	
    if( (event.ctrlKey == true && (event.keyCode == 78 || event.keyCode == 82 || event.keyCode == 86 || event.keyCode == 80)) ||
        (event.keyCode >= 112 && event.keyCode <= 123)){
            event.keyCode = 0;
            event.cancelBubble = true;
            event.returnValue = false;
    }
}
// 기능을 취소하려면 아래부분 모두 주석처리
//document.onkeydown = processKey;	// 특정 키 금지
//document.oncontextmenu = nocontextmenu;	// 오른쪽 버튼 팝업 금지
//document.onselectstart=new Function("return false"); // 텍스트 셀렉트 금지
//document.ondragstart=new Function("return false"); // 화면 드래그 금지








// 년도 생성
function getCommYear(year){

	var strYear = "";
	var commYear = $("commYear");
	var currentYear = new Date().getYear();
	                    			
	for(var i=new Date().getYear()+1; i>= 2000; i--)
		commYear.options.add(new Option(i, i));
	
	// 인자로 넘어온 값이 있으면 인자년도 아니면 현재년도
	if(year != ""){
		commYear.value = year;
	}else{
		commYear.value = new Date().getYear();
	}
		
}



/**
* 과정 목록 가져오기

	인자 설명 =  
		commYear : 년도
		commGrCode : 선택한 과정값 (selected 목적)
*/
function getCommOnloadGrCode(reloading, commYear, commGrCode){

	fnAjaxCommSelectBox("grCode", reloading, "Y", commYear, commGrCode);

}

/**
* 과정 기수 가져오기

	인자 설명 =  
		commYear : 년도
		commGrCode : 선택한 과정값 (selected 목적)
*/
function getCommOnloadGrSeq(reloading, commYear, commGrCode, commGrSeq){

	fnAjaxCommSelectBox("grSeq", reloading, "Y", commYear, commGrCode, commGrSeq);

}

/**
* 과목 리스트 가져오기

	인자 설명 =  
		commYear : reloading 여부
		commYear : 년도
		commGrCode : 과정
		commGrSeq : 기수
		commSubj : 선택한 과목값 (selected 목적)
*/
function getCommOnloadSubj(reloading, commYear, commGrCode, commGrSeq, commSubj){

	fnAjaxCommSelectBox("subj", reloading, "Y", commYear, commGrCode, commGrSeq, commSubj);

}

/**
* 평가명 리스트 가져오기

	인자 설명 =  
		commYear : 년도
		commGrCode : 과정
		commGrSeq : 기수
		commExam : 선택한 평가정보 값 (selected 목적)
*/
function getCommOnloadExam(commGrCode, commGrSeq, commExam){

	if($("commExam") && commGrCode != "" && commGrSeq != ""){

		var objAjax = new Object();
		objAjax.url = "/commonInc/ajax/bodyCommSelectBox.do";
		objAjax.pars = "mode=commonExam&commGrCode="+ commGrCode + "&commGrseq=" + commGrSeq + "&commExam=" + commExam;
		objAjax.aSync = false; 
		objAjax.targetDiv = "divCommExam";
		objAjax.successMsg = "";
		objAjax.successFunc = "";

		go_ajaxCommonObj(objAjax); //Ajax 통신.

	}

}

/**
* 반구성 리스트 가져오기

	인자 설명 =  
		commYear : 년도
		commGrCode : 과정
		commGrSeq : 기수
		commSubj : 과목
		commClass : 선택한 반정보 값 (selected 목적)
*/
function getCommOnloadClass(commGrCode, commGrSeq, commSubj, commClass){

	if($("commClass") && commGrCode != "" && commGrSeq != "" && commSubj != ""){

		var objAjax = new Object();
		objAjax.url = "/commonInc/ajax/bodyCommSelectBox.do";
		objAjax.pars = "mode=commonClass&commGrCode="+ commGrCode + "&commGrseq=" + commGrSeq + "&commSubj=" + commSubj + "&commClass=" + commClass;
		objAjax.aSync = false; 
		objAjax.targetDiv = "divCommClass";
		objAjax.successMsg = "";
		objAjax.successFunc = "";

		go_ajaxCommonObj(objAjax); //Ajax 통신.

	}

}

/*
* 사이버 과정 목록

	인자 설명 =  
		commYear : 년도
		commGrSeq : 선택한 기수값 (selected 목적)
*/
function getCyberCommOnloadGrSeq(reloading, commYear, commGrSeq){

	fnAjaxCommSelectBox("cyberGrSeq", reloading, "Y", commYear, "", commGrSeq);

}
/*
* 사이버 과정 목록

	인자 설명 =  
		commYear : 년도
		commGrSeq : 선택한 기수값
		commGrCode : 선택한 과정값 (selected 목적)

*/
function getCyberCommOnloadGrCode(reloading, commYear, commGrCode, commGrSeq){

	fnAjaxCommSelectBox("cyberGrCode", reloading, "Y", commYear, commGrCode, commGrSeq);

}




/**
* body의 상단공통의 과정 목록 가져 오기.
*/
function getCommGrCode(reloading){
	//alert("과정 목록");
	var onloadYn = "N";
	var commYear = "";
	if ($("commYear")) 
		commYear = $F("commYear");
	var commGrCode = "";
	var commGrseq = "";
	var commSubj = "";

	fnAjaxCommSelectBox("grCode", reloading, onloadYn, commYear, commGrCode, commGrseq, commSubj);

	//과정 기수 항목 지우기.
	if($("divCommGrSeq") && $("commGrseq"))
		selectCommBoxReset($("commGrseq"));
	
	//과목 항목 지우기.
	if($("divCommSubj") && $("commSubj")){
		selectCommBoxReset($("commSubj"));
	}

	//평가 항목 지우기.
	if($("divCommExam") && $("commExam")){
		selectCommBoxReset($("commExam"));
	}

}




/**
* body의 상단공통의 과정기수 목록 가져 오기.
*/
function getCommGrSeq(reloading){

	//alert("과정기수 목록");
	var onloadYn = "N";
	var commYear = "";
	if ($("commYear")) 
		commYear = $F("commYear");
	var commGrCode = "";

	var commYear = "";
	if ($("commYear")) commYear = $F("commYear");
	else commYear = "";

	var commGrCode = "";
	if ($("commGrCode")) commGrCode = $F("commGrCode");
	else commGrCode = "";
	
	var commGrseq = "";
	var commSubj = "";

	fnAjaxCommSelectBox("grSeq", reloading, onloadYn, commYear, commGrCode, commGrseq, commSubj);


	//과목 항목 지우기.
	if($("divCommSubj") && $("commSubj")){
		selectCommBoxReset($("commSubj"));
	}

	//평가 항목 지우기.
	if($("divCommExam") && $("commExam")){
		selectCommBoxReset($("commExam"));
	}

}
/**
* body의 상단공통의 과목 목록 가져 오기.
*/
function getCommSubj(reloading){
	//alert("과목 목록");
	var onloadYn = "N";
	var commYear = "";
	if ($("commYear")) commYear = $F("commYear");
	else commYear = "";

	var commGrCode = "";
	if ($("commGrCode")) commGrCode = $F("commGrCode");
	else commGrCode = "";
	
	var commGrseq = "";
	if ($("commGrseq")) commGrseq = $F("commGrseq");
	else commGrseq = "";

	var commSubj = "";

	fnAjaxCommSelectBox("subj", reloading, onloadYn, commYear, commGrCode, commGrseq, commSubj);

}

/**
* body의 상단공통의 평가 목록 가져 오기.
*/
function getCommExam(){

	if( $("commExam") && $F("commGrCode") != "" && $F("commGrseq") != "" ){ //평가명 Obj 가 있다면.

		var objAjax = new Object();
		objAjax.url = "/commonInc/ajax/bodyCommSelectBox.do";
		objAjax.pars = "mode=commonExam&commGrCode="+ $F("commGrCode") + "&commGrseq=" + $F("commGrseq");
		objAjax.aSync = false; 
		objAjax.targetDiv = "divCommExam";
		objAjax.successMsg = "";
		objAjax.successFunc = "";

		go_ajaxCommonObj(objAjax); //Ajax 통신.

	}

}

/**
* body의 상단공통의 반정보 가져 오기.
*/
function getCommClass(){

	if( $("commClass") && $F("commGrCode") != "" && $F("commGrseq") != "" && $F("commSubj") != "" ){ //과정,기수,과목,반선택 Obj 가 있다면.

		var objAjax = new Object();
		objAjax.url = "/commonInc/ajax/bodyCommSelectBox.do";
		objAjax.pars = "mode=commonClass&commGrCode="+ $F("commGrCode") + "&commGrseq=" + $F("commGrseq") + "&commSubj=" + $F("commSubj");
		objAjax.aSync = false; 
		objAjax.targetDiv = "divCommClass";
		objAjax.successMsg = "";
		objAjax.successFunc = "";

		go_ajaxCommonObj(objAjax); //Ajax 통신.

	}

}


/**
* Cyber과정용 기수 검색
*/
function getCyberCommGrSeq(reloading){

	var onloadYn = "N";
	var commYear = "";
	if ($("commYear")) 
		commYear = $F("commYear");
	var commGrseq = "";
	var commGrCode = "";
	var commSubj = "";

	fnAjaxCommSelectBox("cyberGrSeq", reloading, onloadYn, commYear, commGrCode, commGrseq, commSubj);

	//과정 항목 지우기.
	if($("divCyberCommGrCode") && $("commGrcode"))
		selectCommBoxReset($("commGrcode"));
	
	//과목 항목 지우기.
	if($("divCyberCommSubj") && $("commSubj")){
		selectCommBoxReset($("commSubj"));
	}

}
/**
* Cyber과정용 과정 검색
*/
function getCyberCommGrCode(reloading){

	var onloadYn = "N";
	var commYear = "";
	if ($("commYear")) 
		commYear = $F("commYear");

	var commGrseq = "";
	if ($("commGrseq")) 
		commGrseq = $F("commGrseq");

	var commGrCode = "";
	var commSubj = "";

	fnAjaxCommSelectBox("cyberGrCode", reloading, onloadYn, commYear, commGrCode, commGrseq, commSubj);

	//과목 항목 지우기.
	if($("divCyberCommSubj") && $("commSubj")){
		selectCommBoxReset($("commSubj"));
	}

}

/**
* Cyber과정용 과목 검색
*/
function getCyberCommSubj(reloading){

	var onloadYn = "N";
	var commYear = "";
	if ($("commYear")) 
		commYear = $F("commYear");
	

	var commGrseq = "";
	if ($("commGrseq")) 
		commGrseq = $F("commGrseq");

	var commGrCode = "";
	if ($("commGrcode")) 
		commGrCode = $F("commGrcode");

	var commSubj = "";

	fnAjaxCommSelectBox("cyberGrSubj", reloading, onloadYn, commYear, commGrCode, commGrseq, commSubj);

	//과목 항목 지우기.
	if($("divCyberCommSubj") && $("commSubj")){
		selectCommBoxReset($("commSubj"));
	}

}



/**
* body에서 상단 select box를 공통으로 호출 하는 함수
* ajax 통신으로 결과 조건의 select박스를 만들어 온다.
* 
* pmode			: 구하고자 하는 값 'grCode', 'grSeq', 'grSubj' ...
* reloading		: reloading 되는 부분을 알려주는 값 ('grCode', 'grSeq', 'grSubj'...)
* onloadYn		: onload 되는 값을 reloading 되면 안되므로 인자 추가.
* commYear		: 년도
* commGrCode	: 과정코드
* commGrseq		: 과정기수
* commSubj		: 과목코드
*/
function fnAjaxCommSelectBox(pmode, reloading, onloadYn, commYear, commGrCode, commGrseq, commSubj){

	//alert([pmode, reloading, onloadYn, commYear, commGrCode, commGrseq, commSubj]);
	var url = "/commonInc/ajax/bodyCommSelectBox.do";
	var pars = "pmode=" + pmode+"&reloading="+reloading+"&onloadYn="+onloadYn;
	var divId = "";

	switch(pmode){
		case "grCode":
			// 과정코드 가져오기			
			pars += "&year=" + commYear;
			pars += "&grCode=" + commGrCode; //SELECTED를 위한 과정 코드값.
			
			divId = "divCommGrCode";
			break;
			
		case "grSeq":
			// 기수 가져오기
			pars += "&year=" + commYear;						
			pars += "&grCode=" + commGrCode;
			pars += "&grSeq=" + commGrseq;
			
			divId = "divCommGrSeq";
			break;
			
		case "subj":
		
			// 과목가져오기						
			pars += "&grCode=" + commGrCode;			
			pars += "&grSeq=" + commGrseq;
			pars += "&subj=" + commSubj;
			
			divId = "divCommSubj";
			break;

		case "cyberGrSeq":
		
			// Cyber 과정의 기수 가져오기
			pars += "&year=" + commYear;
			pars += "&grSeq=" + commGrseq;
			
			divId = "divCyberCommGrSeq";
			break;

		case "cyberGrCode":
		
			// Cyber 과정의 과정 가져오기
			pars += "&year=" + commYear;
			pars += "&grSeq=" + commGrseq;
			pars += "&grCode=" + commGrCode;
			
			divId = "divCyberCommGrCode";
			break;

		case "cyberGrSubj":
		
			// Cyber 과정의 과목 가져오기
			pars += "&year=" + commYear;
			pars += "&grCode=" + commGrCode;			
			pars += "&grSeq=" + commGrseq;
			pars += "&subj=" + commSubj;
			
			divId = "divCyberCommSubj";
			break;
	}
	
	
	var myAjax = new Ajax.Updater(
		{success:divId},
		url, 
		{
			asynchronous : false,
			method: "get", 
			parameters: pars,
			onFailure : function(){
				alert("Select 생성시 오류가 발생했습니다.");
			}
		}
	);

			
}



/*
* 상단 공통 comm select box 에서 
* 최종으로 선택시 세션에 저장 시켜 주는 메소드.
*/

function setCommSession(gubun, value){

	//alert([gubun, value]);
	var url = "/commonInc/ajax/bodyCommSelectBox.do";
	var pars = "mode=commonSession&selectFieldName=" + gubun+"&selectFieldValue="+value;
	//var divId = "";

	var myAjax = new Ajax.Request(
		url, 
		{
			asynchronous : false,
			method: "get", 
			parameters: pars,
			onFailure : function(){
				alert("Select 세션 저장시 오류 발생.");
			}
		}
	);

}

//우편번호 검색
/*
function searchZip(){
	pform.action = "/search/searchZip.do";
	var popWindow = popWin('about:blank', 'majorPop11', '400', '250', 'no', 'no');
	pform.target = "majorPop11";
	pform.submit();
	pform.target = "";
}
*/
//우편번호 검색
function searchZip(post1, post2, addr){
	var url = "/search/searchZip.do";
	url += "?mode=zipcode";
	url += "&zipCodeName1=pform." + post1;
	url += "&zipCodeName2=pform." + post2;
	url += "&zipAddr=pform." + addr;
	pwinpop = popWin(url,"cPop","420","350","yes","yes");
}

//select box의 모든 항목을 없애는 메소드.
function selectCommBoxReset(oSelect) {

	len = oSelect.options.length;
	for(i = len-1; i >= 0 ; i--)
		oSelect.remove(i);

	var oOption = document.createElement("OPTION");
	oSelect.options.add(oOption);
	oOption.innerText = "**선택하세요**";
	oOption.value = "";

}





/**
* 달력 불러오는 함수

	인자 설명 =  
		frm : 폼이름 (현시스템은 폼이 하나고 prototype을 사용하기 때문에 폼값은 안넘겨도 된다. 예외처리로 사용가능하게 해놓음)
		obj : 달력 결과를 뿌려줄 객체 이름.
*/
function fnPopupCalendar(frm, obj){

	// 현재 obj에 있는 날짜
	var oDate = $F(obj);
	
	result = window.showModalDialog("/commonInc/jsp/calendar.jsp?oDate="+oDate, "calendar", "dialogWidth:256px; dialogHeight:280px; center:yes; status:no;");

	if (result == -1 || result == null || result == ""){
		return;
	}
	
	if(result == "delete"){
		result = "";
	}
	
	try{
		eval(frm+"."+obj+".value = '"+result+"';");		
	}catch(e){
		$(obj).value = result;
	}

}

/**
* 강의실 찾기

	인자 설명 :
		codeField : 강의실코드 들어갈 폼의 이름
		nameField : 강의실명 들어갈 폼의 이름
		popnm : 팝업창 이름.
		isclose : 검색추 닫히는지 여부. (true면 닫힘.)

*/
function com_findClassroom(codeField, nameField, popnm, isclose) {


	url = "/commonInc/classRoom.do?mode=list&codeField=" + codeField + "&nameField=" + nameField + "&isclose=" + isclose;
	if (popnm == ''){
		var win = popWin(url, popnm, 400, 600, 1);
	} else {
		var win = popWin(url,'ClassRoom', 400, 600, 1);
	}

}

 /**
 * 이메일 체크
 * EmailForm : 이메일 값
 */
 
function checkEmail(EmailForm)
 {
  //email 체크
  var strEmail = EmailForm;
  var i;
  var strCheck1 = false;
  var strCheck2 = false;
  var iEmailLen = strEmail.length;
  if (iEmailLen > 0) {
   // strEmail 에 '.@', '@.' 이 있는 경우 에러메시지.
   // strEmail의 맨앞 또는 맨뒤에  '@', '.' 이 있는 경우 에러메시지.
   if ((strEmail.indexOf(".@") != -1) || (strEmail.indexOf("@.") != -1) ||
    (strEmail.substring(0,1) == ".") || (strEmail.substring(0,1) == "@") ||
    (strEmail.substring(iEmailLen-1,iEmailLen) == ".") || (strEmail.substring(iEmailLen-1,iEmailLen) == "@"))
   { 
          alert("E-mail을 정확하게 입력하십시오.");
		  return false;
   }
      for ( i=0; i < iEmailLen; i++ ) {
		if ((strEmail.substring(i,i+1) == ".") || (strEmail.substring(i,i+1) == "-") || (strEmail.substring(i,i+1) == "_") ||
			((strEmail.substring(i,i+1) >= "0") && (strEmail.substring(i,i+1) <= "9")) ||
			((strEmail.substring(i,i+1) >= "@") && (strEmail.substring(i,i+1) <= "Z")) ||
		    ((strEmail.substring(i,i+1) >= "a") && (strEmail.substring(i,i+1) <= "z")) ) {
			if (strEmail.substring(i,i+1) == "."){
				strCheck1 = true;
			}
			if (strEmail.substring(i,i+1) == "@"){
				strCheck2 = true;
	       }
		}else {
              alert("E-mail을 정확하게 입력하십시오.");
			  return false;
          }
      }
  
      if ((strCheck1 == false) || (strCheck2 == false)) {
          alert("E-mail을 정확하게 입력하십시오.");
		  return false;
      }
  }
     return true;
 }



/*
*	Ajax 통신 공통으로 사용하는 함수.
*
	objAjax.url				: URL
	objAjax.pars			: 파라미터
	objAjax.aSync			: Asynchronous 유무 (true, false)
	objAjax.targetDiv		: 타겟 div
	objAjax.successMsg		: 성공후 메세지
	objAjax.failMsg			: 실패시 메세지.
	objAjax.successFunc		: 성공후 함수 호출 ex)objAjax.successFunc = "go_reload();";
	objAjax.isProgressYn	: 진행시 이미지 보여주는지 여부.

*/
function go_ajaxCommonObj(objAjax){

	var url				= objAjax.url;
	var pars			= objAjax.pars;
	var aSync			= objAjax.aSync;
	var divId			= objAjax.targetDiv;

	var successMsg		= objAjax.successMsg;
	var failMsg			= objAjax.failMsg;
	var successFunc		= objAjax.successFunc;
	var isLoadingYn		= objAjax.isLoadingYn;

	if(divId != undefined && divId != ""){

		var myAjax = new Ajax.Updater(
			{success:divId},
			url, 
			{
				asynchronous : aSync,
				method: "get", 
				parameters: pars,
				onLoading : function(){				
					
					if(isLoadingYn != undefined && isLoadingYn == "Y"){
						$(document.body).startWaiting('bigWaiting');
					}
				},
				onSuccess : function(){
					
					if(isLoadingYn != undefined && isLoadingYn == "Y"){
						window.setTimeout( $(document.body).stopWaiting.bind( $(document.body) ), 500);
					}

					if(successMsg != undefined && successMsg != "")
						alert(successMsg);

					if(successFunc != undefined && successFunc != "")
						eval(successFunc);
				},
				onFailure : function(){

					if(failMsg == undefined || failMsg == "")
						failMsg = "Ajax통신 오류";
					
					alert(failMsg);
				}
			}
		);

	}else{

		var myAjax = new Ajax.Request(
			url, 
			{
				asynchronous : aSync,
				method: "get", 
				parameters: pars,
				onLoading : function(){				
					
					if(isLoadingYn != undefined && isLoadingYn == "Y"){
						$(document.body).startWaiting('bigWaiting');
					}
				},
				onSuccess : function(){
					
					if(isLoadingYn != undefined && isLoadingYn == "Y"){
						window.setTimeout( $(document.body).stopWaiting.bind( $(document.body) ), 500);
					}

					if(successMsg != undefined && successMsg != "")
						alert(successMsg);

					if(successFunc != undefined && successFunc != "")
						eval(successFunc);
				},
				onFailure : function(){

					if(failMsg == undefined || failMsg == "")
						failMsg = "Ajax통신 오류";
					
					alert(failMsg);
				}
			}
		);

	}


}




//주민등록번호 체크
function realJuminCheck(jumin_no) {
	
	 var jumin_no =jumin_no;
	 a = new Array(13);
	
	 for (var i=0; i < 13; i++) {
		  a[i] = parseInt(jumin_no.charAt(i));
	 }
	
	 var j = a[0]*2 + a[1]*3 + a[2]*4 + a[3]*5 + a[4]*6 + a[5]*7 + a[6]*8 + a[7]*9 + a[8]*2 + a[9]*3 + a[10]*4 + a[11]*5;
	 var j = j % 11;
	 var k = 11 - j;
	 var m = a[0]
	 var n = a[1]
	 if (k > 9) {
	      k = k % 10
	 }
	 if (k != a[12]) {
	  	alert ( jumin_no + " 은 유효하지 않은 주민등록 번호입니다.");
	  	return false;
	 }
	 return true;
}


// 문자열에 특수기호가 있다면 true 를 return...	
function isErrorID_Char(sBuf) {
				
	var sChk = "!@#$%&*()|'[];:\" ^|><~`=+-\\/{}^_,.?";   //Allowed Charater : '_' (under score)
	for ( var i=0; i < sBuf.length; i++ ) {
		if (sChk.indexOf(sBuf.charAt(i)) >= 0) {
			alert("아이디에 특수기호가 있습니다.  아이디는 영문자와 숫자만 가능합니다.");
			return true;
		}
	}
	return false;
}

// 문자열에 특수ID가 있다면 true 를 return...		
function isErrorID_Word(sBuf)	{
					
	sBuf = sBuf.toLowerCase();
	var sChk = "admin,administrator,manager,webmanager,master,webmaster,root,geneye,gvs,ge00".split(",");
			
	for ( var i=0; i<sChk.length; i++ ) {
		if (sBuf.indexOf(sChk[i]) >= 0) {				
			alert("생성할 수 없는 아이디입니다.  다른 아이디를 입력하세요.");
			return true;
		}
	}
	
	//아이디가 세자리미만이면 true 를 return...
	if(sBuf.length<5) {
		alert("아이디는 6 글자 이상만 가능합니다.  다른 아이디를 입력하세요.");
		return true;
	}
	
	if(errChar(sBuf) == true){
		return true;
	}
		
	return false;
}


// 숫자, 영문, 한글 이외의 문자이면 true 리턴함
function errChar(ch){

	if ( ch >= "0" && ch <= "9" ) return false;
	if ( ch >= "a" && ch <= "z" ) return false;
	if ( ch >= "A" && ch <= "Z" ) return false;

	//var sEncode = encodeURI(ch);  //5.0 not supported

	var sEncode = ch;
	if ( sEncode.length==9 ) {
		var sHex = sEncode.substring(1, 3);
		if ( sHex >= "EA" && sHex <= "ED" ) return false;
	}
	
	alert("아이디에 생성할 수 없는 문자가 있습니다.  아이디는 영문자와 숫자만 가능합니다.");
	return true;
}


//checkBox 모두 선택 및 모두 선택 해제.
function allChk(objname){

	var obj = document.getElementsByName(objname);
	
	for(i=0;i<obj.length;i++){

		obj[i].checked = !(obj[i].checked);
	
	}
}


/*
* 공통 직급 검색 팝업

파라미터 설명
	jikFieldName	: 반환 되는 직급코드 Object 명 
	jiknmFieldName	: 반환 되는 직급명 Object 명

	폼이름.obj로
*/
function go_commonSearchJik(jikFieldName, jiknmFieldName){


	var mode = "form";
	var url = "/search/searchDept.do?mode=" + mode + "&t1=" + jikFieldName + "&t2=" + jiknmFieldName;

	popWin(url, "pop_commSearchJik", "546", "340", "1", "");

}


/*
* 공통 기관 검색 팝업

파라미터 설명
	deptFieldName	: 반환 되는 기관코드 Object 명 
	deptnmFieldName	: 반환 되는 기관명 Object 명

*/
function go_commonSearchDept(deptFieldName, deptnmFieldName){

	var mode = "list";
	var url = "/commonInc/searchDept.do?mode=" + mode + "&deptField=" + deptFieldName + "&deptnmField=" + deptnmFieldName;

	popWin(url, "pop_commSearchDept", "418", "270", "1", "");

}


/**
* 체크 박스나 Radio 버튼 체크 여부 확인.

파라미터 설명
	obj	: 검사할 객체

ex)
	if(!go_commonCheckedCheck(pform.ckind)){
		alert("퇴교 구분을 선택하세요!");
		return;
	}
*/
function go_commonCheckedCheck(obj){

	var isSelect = false;

	if(obj.length == undefined || obj.length == 1){
		if(obj.checked)
			isSelect = true;
	}else{
		for( i=0; i < obj.length ; i++){
			if(obj[i].checked == true){
				isSelect = true;
				break;
			}
		}
	}

	return isSelect;
}


// 숫자만 입력
// onkeydown을 사용
function go_commNumCheck() { 
	if (commIsNumeric(event.keyCode) == false){
		alert("숫자만 입력 가능합니다.");
		event.returnValue = false;
	}
}

//숫자 체크
function commIsNumeric( value ){	
	if (value == 8 || value == 9 || value == 13 || (value >= 37 && value <= 40) || value == 46 || value == 27 || value == 116 || (value >= 48 && value <= 57) || (value >= 96 && value <= 105))
		 return true;
	else 
		return false;
}


// 소수점 반올림함수
function exRound(val, pos)
{
    var rtn;
	pos = pos+1;
    rtn = Math.round(val * Math.pow(10, Math.abs(pos)-1))
    rtn = rtn / Math.pow(10, Math.abs(pos)-1)

    return rtn;
}



//MeadCo Security Manager 
function com_printManager1(){
    var return_str;
    return_str = '<object id="secmgr" viewastext style="display:none" '
	+'  classid="clsid:5445be81-b796-11d2-b931-002018654e2e" '
	+'  codebase="/commonInc/scriptX/smsx.cab#Version=6,2,433,70"> '
	+' </object>';

    document.write(return_str);
}

function com_printManager2(){
    var return_str;
    return_str = '<object id="factory" viewastext  style="display:none" '
	+' classid="clsid:1663ed61-23eb-11d2-b92f-008048fdd814"> '
	+' </object> ';

    document.write(return_str);
}

function com_printManager3(){
    var return_str;
    return_str = '<object id="maxipt" viewastext style="display:none" '
	+' classid="clsid:C29F168A-7488-42A0-BDA1-47B3578652BE"> '
	+' </object>';

    document.write(return_str);
}