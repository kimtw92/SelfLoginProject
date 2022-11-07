	//蹂�닔 �좎뼵 諛�珥덇린��
	var nImageInfoCnt = 0;
	var htImageInfo = [];		//image file�뺣낫 ��옣
	var aResult = [];
	
	var rFilter = /^(image\/bmp|image\/gif|image\/jpg|image\/jpeg|image\/png)$/i;  
	var rFilter2 = /^(bmp|gif|jpg|jpeg|png)$/i; 
	var nTotalSize = 0;
	var nMaxImageSize = 10*1024*1024;
	var nMaxTotalImageSize = 50*1024*1024;
	var nMaxImageCount = 10;
	var nImageFileCount = 0;
	var bSupportDragAndDropAPI = false;
	var oFileUploader;
	var bAttachEvent = false;

	//留덊겕�낆뿉 �곕Ⅸ �좊떦
	var elContent= $("pop_content");  
	var elDropArea = jindo.$$.getSingle(".drag_area",elContent);
	var elDropAreaUL = jindo.$$.getSingle(".lst_type",elContent);
	var elCountTxtTxt = jindo.$$.getSingle("#imageCountTxt",elContent);
	var elTotalSizeTxt = jindo.$$.getSingle("#totalSizeTxt",elContent);
	var elTextGuide = $("guide_text");
	var welUploadInputBox = $Element("uploadInputBox");
	var oNavigator = jindo.$Agent().navigator();
	
	//留덊겕��怨듯넻 
	var welBtnConfirm = $Element("btn_confirm");				//�뺤씤 踰꾪듉
	var welBtnCancel= $Element("btn_cancel");				//痍⑥냼 踰꾪듉
	
	//吏꾨룄濡��⑺븨��element
	var welTextGuide = $Element(elTextGuide);
	var welDropArea = $Element(elDropArea);
	var welDropAreaUL = $Element(elDropAreaUL); 
	var fnUploadImage = null;
	
	//File API 吏�썝 �щ�濡�寃곗젙
	function checkDragAndDropAPI(){
		try{
			if( !oNavigator.ie ){
				if(!!oNavigator.safari && oNavigator.version <= 5){
					bSupportDragAndDropAPI = false;
				}else{
					bSupportDragAndDropAPI = true;
				}
			} else {
				bSupportDragAndDropAPI = false;
			}
		}catch(e){
			bSupportDragAndDropAPI = false;
		}
	}
	
	//--------------- html5 誘몄���釉뚮씪�곗��먯꽌 (IE9 �댄븯) ---------------
	/** 
	 * �대�吏�� 泥⑤� ���쒖꽦�붾맂 踰꾪듉 �곹깭
	 */
     function goStartMode(){
    	 var sSrc = welBtnConfirm.attr("src")|| "";
    	 if(sSrc.indexOf("btn_confirm2.png") < 0 ){
    		 welBtnConfirm.attr("src","./img/btn_confirm2.png");
    		 fnUploadImage.attach(welBtnConfirm.$value(), "click");
    	 }
     } 
     /**
      * �대�吏�� 泥⑤� ��鍮꾪솢�깊솕��踰꾪듉 �곹깭
      * @return
      */
     function goReadyMode(){
    	 var sSrc = welBtnConfirm.attr("src")|| "";
    	 if(sSrc.indexOf("btn_confirm2.png") >= 0 ){
    		 fnUploadImage.detach(welBtnConfirm.$value(), "click");
	    	 welBtnConfirm.attr("src","./img/btn_confirm.png");
    	 }
     }   
	
	/**
	 * �쇰컲 �낅줈��
	 * @desc oFileUploader��upload�⑥닔瑜��몄텧�� 
	 */
	function generalUpload(){
		oFileUploader.upload();
	}
	
    /** 
     * �대�吏�泥⑤� ���덈궡 �띿뒪�멸� �섏삤��諛곌꼍�쇰줈 '�ㅼ젙'�섎뒗 �⑥닔.
     * @return
     */
 	function readyModeBG (){
 		var sClass = welTextGuide.className();
 		if(sClass.indexOf('nobg') >= 0){
 			welTextGuide.removeClass('nobg');
 			welTextGuide.className('bg');
 		}
 	}
 	
 	/**
 	 * �대�吏�泥⑤� ���덈궡 �띿뒪�멸� �섏삤��諛곌꼍��'�쒓굅'�섎뒗 �⑥닔. 
 	 * @return
 	 */
 	function startModeBG (){
 		var sClass = welTextGuide.className();
 		if(sClass.indexOf('nobg') < 0){
	 		welTextGuide.removeClass('bg');
	 		welTextGuide.className('nobg');
 		}
 	}

	//--------------------- html5  吏�썝�섎뒗 釉뚮씪�곗��먯꽌 �ъ슜�섎뒗 �⑥닔  --------------------------
 	/**
 	 * �앹뾽���몄텧���낅줈���덉젙 �ъ쭊����
 	 * @param {Object} nCount �꾩옱 �낅줈���덉젙���ъ쭊 �μ닔
 	 * @param {Object} nVariable ��젣�섎뒗 ��
 	 */
 	function updateViewCount (nCount, nVariable){
 		var nCnt = nCount + nVariable;
 		elCountTxtTxt.innerHTML = nCnt +"��";
 		nImageFileCount = nCnt;
 		return nCnt;
 	}
 	
 	/**
 	 * �앹뾽���몄텧���낅줈�쒕맆 �ъ쭊 珥��⑸웾
 	 */
 	function updateViewTotalSize(){
 		var nViewTotalSize = Number(parseInt((nTotalSize || 0), 10) / (1024*1024));
 		elTotalSizeTxt.innerHTML = nViewTotalSize.toFixed(2) +"MB";
 	}
 	
 	/**
 	 * �대�吏��꾩껜 �⑸웾 �ш퀎��
 	 * @param {Object} sParentId
 	 */
 	function refreshTotalImageSize(sParentId){
 		var nDelImgSize = htImageInfo[sParentId].size;
 		if(nTotalSize - nDelImgSize > -1 ){
 			nTotalSize = nTotalSize - nDelImgSize;
 		} 
 	}
	
 	/**
 	 * hash table�먯꽌 �대�吏��뺣낫 珥덇린��
 	 * @param {Object} sParentId
 	 */
 	function removeImageInfo (sParentId){
 		//��젣���대�吏�쓽 怨듦컙��珥덇린���쒕떎.
 		htImageInfo[sParentId] = null;
 	}
 	
 	
 	/**
 	 * byte濡�諛쏆� �대�吏��⑸웾���붾㈃���쒖떆瑜��꾪빐 �щ㎎��
 	 * @param {Object} nByte
 	 */
 	function setUnitString (nByte) {
 		var nImageSize;
 		var sUnit;
 		
 		if(nByte < 0 ){
 			nByte = 0;
 		}
 		
 		if( nByte < 1024) {
 			nImageSize = Number(nByte);
 			sUnit = 'B';
 			return nImageSize + sUnit;
 		} else if( nByte > (1024*1024)) {
 			nImageSize = Number(parseInt((nByte || 0), 10) / (1024*1024));
 			sUnit = 'MB';
 			return nImageSize.toFixed(2) + sUnit;
 		} else {
 			nImageSize = Number(parseInt((nByte || 0), 10) / 1024);
 			sUnit = 'KB';
 			return nImageSize.toFixed(0) + sUnit;
 		}
     }
 	
 	/**
 	 * �붾㈃ 紐⑸줉���곷떦�섍쾶 �대쫫���섎씪���쒖떆.
 	 * @param {Object} sName �뚯씪紐�
 	 * @param {Object} nMaxLng 理쒕� 湲몄씠
 	 */
 	function cuttingNameByLength (sName, nMaxLng) {
 		var sTemp, nIndex;
 		if(sName.length > nMaxLng){
 			nIndex = sName.indexOf(".");
 			sTemp = sName.substring(0,nMaxLng) + "..." + sName.substring(nIndex,sName.length) ;
 		} else {
 			sTemp = sName;
 		}
 		return sTemp;
 	}
 	
 	/**
 	 * Total Image Size瑜�泥댄겕�댁꽌 異붽�濡��대�吏�� �ｌ쓣吏�留먯�瑜�寃곗젙��
 	 * @param {Object} nByte
 	 */
 	function checkTotalImageSize(nByte){
 		if( nTotalSize + nByte < nMaxTotalImageSize){
 			nTotalSize = nTotalSize + nByte;
 			return false;
 		} else {
 			return true;
 		}
 	}
	
 	// �대깽���몃뱾���좊떦
 	function dragEnter(ev) {
 		ev.stopPropagation();
 		ev.preventDefault();
     }
 	
     function dragExit(ev) {
     	ev.stopPropagation();
     	ev.preventDefault();
     }
     
 	function dragOver(ev) {
 		ev.stopPropagation();
 		ev.preventDefault();
     }
 	
	/**
	 * �쒕엻 �곸뿭���ъ쭊���④뎄���쒓컙 諛쒖깮�섎뒗 �대깽��
	 * @param {Object} ev
	 */
    function drop(ev) {
		ev.stopPropagation();
		ev.preventDefault();
		
		if (nImageFileCount >= 10){
			alert("理쒕� 10�κ퉴吏�쭔 �깅줉�����덉뒿�덈떎.");
			return;
		}
		
		if(typeof ev.dataTransfer.files == 'undefined'){
			alert("HTML5瑜�吏�썝�섏� �딅뒗 釉뚮씪�곗��낅땲��");
		}else{
			//蹂�닔 �좎뼵
			var wel,
				files,
				nCount,
				sListTag = '';
			
			//珥덇린��
			files = ev.dataTransfer.files;
			nCount = files.length;
						
			if (!!files && nCount === 0){
				//�뚯씪���꾨땶, �뱁럹�댁��먯꽌 �대�吏�� �쒕옒���볥뒗 寃쎌슦.
				alert("�뺤긽�곸씤 泥⑤�諛⑹떇���꾨떃�덈떎.");
				return ;
			}
			
			for (var i = 0, j = nImageFileCount ; i < nCount ; i++){
				if (!rFilter.test(files[i].type)) {
					alert("�대�吏�뙆��(jpg,gif,png,bmp)留��낅줈��媛�뒫�⑸땲��");
				} else if(files[i].size > nMaxImageSize){
					alert("�대�吏��⑸웾��10MB瑜�珥덇낵�섏뿬 �깅줉�����놁뒿�덈떎.");
				} else {
					//�쒗븳���섎쭔 �낅줈��媛�뒫.
					if ( j < nMaxImageCount ){
						sListTag += addImage(files[i]);
						
						//�ㅼ쓬 �ъ쭊�꾩쐞���뗮똿
						j = j+1;
						nImageInfoCnt = nImageInfoCnt+1;
					} else {
						alert("理쒕� 10�κ퉴吏�쭔 �깅줉�����덉뒿�덈떎.");
						break;			
					}
				}
			}
			if(j > 0){
				//諛곌꼍 �대�吏�蹂�꼍
				startModeBG();
				if ( sListTag.length > 1){
					welDropAreaUL.prependHTML(sListTag);
				}
				//�대�吏�珥앹궗�댁쫰 view update 
				updateViewTotalSize();
				//�대�移�珥���view update
				nImageFileCount = j;
				updateViewCount(nImageFileCount, 0);
				// ��옣 踰꾪듉 �쒖꽦��
				goStartMode();
			}else{
				readyModeBG();
			}
		}
    }
	
    /**
     * �대�吏�� 異붽��섍린 �꾪빐��file����옣�섍퀬, 紐⑸줉��蹂댁뿬二쇨린 �꾪빐��string��留뚮뱶���⑥닔.
     * @param ofile �쒓컻���대�吏��뚯씪
     * @return
     */
    function addImage(ofile){
    	//�뚯씪 �ъ씠利�
		var ofile = ofile,
			sFileSize = 0,
			sFileName = "",
			sLiTag = "",
			bExceedLimitTotalSize = false,
			aFileList = [];
		
		sFileSize = setUnitString(ofile.size);
		sFileName = cuttingNameByLength(ofile.name, 15);
		bExceedLimitTotalSize = checkTotalImageSize(ofile.size);

		if( !!bExceedLimitTotalSize ){
			alert("�꾩껜 �대�吏��⑸웾��50MB瑜�珥덇낵�섏뿬 �깅줉�����놁뒿�덈떎. \n\n (�뚯씪紐�: "+sFileName+", �ъ씠利�: "+sFileSize+")");
		} else {
			//�대�吏��뺣낫 ��옣							
			htImageInfo['img'+nImageInfoCnt] = ofile;
			
    		//List 留덊겕���앹꽦�섍린
			aFileList.push('	<li id="img'+nImageInfoCnt+'" class="imgLi"><span>'+ sFileName +'</span>');
			aFileList.push('	<em>'+ sFileSize +'</em>');
	        aFileList.push('	<a onclick="delImage(\'img'+nImageInfoCnt+'\')"><img class="del_button" src="./img/btn_del.png"  width="14" height="13" alt="泥⑤� �ъ쭊 ��젣"></a>');
			aFileList.push('	</li> ');   
			
			sLiTag = aFileList.join(" ");
			aFileList = [];
		}
		return sLiTag;
    }
    
    /**
     * HTML5 DragAndDrop�쇰줈 �ъ쭊��異붽��섍퀬, �뺤씤踰꾪듉���꾨Ⅸ 寃쎌슦���숈옉�쒕떎.
     * @return
     */
    function html5Upload() {	
    	var tempFile,
    		sUploadURL;
    	
    	sUploadURL= '/commonInc/SE/MultipleImageUpload.do'; 	//upload URL
//    	sUploadURL= 'file_uploader_html5.php'; 	//upload URL
    	
    	//�뚯씪���섎굹��蹂대궡怨� 寃곌낵瑜�諛쏆쓬.
    	for(var j=0, k=0; j < nImageInfoCnt; j++) {
    		tempFile = htImageInfo['img'+j];
    		try{
	    		if(!!tempFile){
	    			//Ajax�듭떊�섎뒗 遺�텇. �뚯씪怨��낅줈�뷀븷 url���꾨떖�쒕떎.
	    			callAjaxForHTML5(tempFile,sUploadURL);
	    			k += 1;
	    		}
	    	}catch(e){}
    		tempFile = null;
    	}
	}
    
    function callAjaxForHTML5 (tempFile, sUploadURL){
    	var oAjax = jindo.$Ajax(sUploadURL, {
			type: 'xhr',
			method : "post",
			onload : function(res){ // �붿껌���꾨즺�섎㈃ �ㅽ뻾��肄쒕갚 �⑥닔
				var sResString = res._response.responseText;
				if (res.readyState() == 4) {
					if(sResString.indexOf("NOTALLOW_") > -1){
						var sFileName = sResString.replace("NOTALLOW_", "");
						alert("�대�吏��뚯씪(jpg,gif,png,bmp)留��낅줈���섏떎 ���덉뒿�덈떎. ("+sFileName+")");
					}else{
						//�깃났 �쒖뿉  responseText瑜�媛��怨�array濡�留뚮뱶��遺�텇.
						makeArrayFromString(res._response.responseText);
					}
				}
			},
			timeout : 3,
			onerror :  jindo.$Fn(onAjaxError, this).bind()
		});
		oAjax.header("contentType","multipart/form-data");
		oAjax.header("file-name",encodeURIComponent(tempFile.name));
		oAjax.header("file-size",tempFile.size);
		oAjax.header("file-Type",tempFile.type);
		oAjax.request(tempFile);
    }
    
    function makeArrayFromString(sResString){
    	var	aTemp = [],
    		aSubTemp = [],
    		htTemp = {}
    		aResultleng = 0;
    	
 		try{
 			if(!sResString || sResString.indexOf("sFileURL") < 0){
 	    		return ;
 	    	}
 			aTemp = sResString.split("&");
	    	for (var i = 0; i < aTemp.length ; i++){
	    		if( !!aTemp[i] && aTemp[i] != "" && aTemp[i].indexOf("=") > 0){
	    			aSubTemp = aTemp[i].split("=");
	    			htTemp[aSubTemp[0]] = aSubTemp[1];
	    		}
	 		}
 		}catch(e){}
 		
 		aResultleng = aResult.length;
    	aResult[aResultleng] = htTemp;
    	
    	if(aResult.length == nImageFileCount){
    		setPhotoToEditor(aResult); 
    		aResult = null;
    		window.close();
    	}
    }
    
    /**
 	 * �ъ쭊 ��젣 �쒖뿉 �몄텧�섎뒗 �⑥닔
 	 * @param {Object} sParentId 
 	 */
 	function delImage (sParentId){
 		var elLi = jindo.$$.getSingle("#"+sParentId);
 		
 		refreshTotalImageSize(sParentId);
 		
 		updateViewTotalSize();
 		updateViewCount(nImageFileCount,-1);
 		//�ъ쭊 file array�먯꽌 �뺣낫 ��젣.
 		removeImageInfo(sParentId);
 		//�대떦 li��젣
 		$Element(elLi).leave();
 		
 		//留덉�留��대�吏�씤寃쎌슦.
 		if(nImageFileCount === 0){
 			readyModeBG();
 			//�ъ쭊 異붽� 踰꾪듉 鍮꾪솢�깊솕
 			goReadyMode();
 		}
 		
 		// drop �곸뿭 �대깽���ㅼ떆 �쒖꽦��
 		if(!bAttachEvent){
 			addEvent();
 		}
 	}

 	/**
     * �대깽���좊떦
     */
	function addEvent() {
		bAttachEvent = true;
		elDropArea.addEventListener("dragenter", dragEnter, false);
		elDropArea.addEventListener("dragexit", dragExit, false);
		elDropArea.addEventListener("dragover", dragOver, false);
		elDropArea.addEventListener("drop", drop, false);
	}
	
	function removeEvent(){
		bAttachEvent = false;
		elDropArea.removeEventListener("dragenter", dragEnter, false);
	    elDropArea.removeEventListener("dragexit", dragExit, false);
	    elDropArea.removeEventListener("dragover", dragOver, false);
	    elDropArea.removeEventListener("drop", drop, false);	
	}
 	
	/**
	 * Ajax �듭떊 ��error媛�諛쒖깮����泥섎━�섎뒗 �⑥닔�낅땲��
	 * @return
	 */
	function onAjaxError (){
		alert("[媛�씠���ъ쭊 �낅줈�뷀븷 �쒕쾭URL�뗮똿���꾩슂�⑸땲��-onAjaxError");
	}

 	/**
      * �대�吏��낅줈���쒖옉
      * �뺤씤 踰꾪듉 �대┃�섎㈃ �몄텧�섎뒗 msg
      */
     function uploadImage (e){
    	 if(!bSupportDragAndDropAPI){
    		 generalUpload();
    	 }else{
    		 html5Upload();
    	 }
     }
     
 	/**
 	 * jindo���뚯씪 �낅줈���ъ슜.(iframe��Form��Submit�섏뿬 由ы봽�덉떆�놁씠 �뚯씪���낅줈�쒗븯��而댄룷�뚰듃)
 	 */
 	function callFileUploader (){
 		oFileUploader = new jindo.FileUploader(jindo.$("uploadInputBox"),{
// 			sUrl  : location.href.replace(/\/[^\/]*$/, '') + '/file_uploader.php',	//�섑뵆 URL�낅땲��
 			sUrl  : '/commonInc/SE/ImageUpload.do',	//�섑뵆 URL�낅땲��
// 	        sCallback : location.href.replace(/\/[^\/]*$/, '') + '/callback.html',	//�낅줈���댄썑��iframe��redirect��肄쒕갚�섏씠吏�쓽 二쇱냼
 	        sCallback : '/se2/sample/photo_uploader/callback.html',	//�낅줈���댄썑��iframe��redirect��肄쒕갚�섏씠吏�쓽 二쇱냼
 	    	sFiletype : "*.jpg;*.png;*.bmp;*.gif",						//�덉슜���뚯씪���뺤떇. ex) "*", "*.*", "*.jpg", 援щ텇��;)	
 	    	sMsgNotAllowedExt : 'JPG, GIF, PNG, BMP �뺤옣�먮쭔 媛�뒫�⑸땲��',	//�덉슜���뚯씪���뺤떇���꾨땶寃쎌슦���꾩썙二쇰뒗 寃쎄퀬李쎌쓽 臾멸뎄
 	    	bAutoUpload : false,									 	//�뚯씪���좏깮�④낵 �숈떆���먮룞�쇰줈 �낅줈�쒕� �섑뻾�좎� �щ� (upload 硫붿냼���섑뻾)
 	    	bAutoReset : true 											// �낅줈�쒗븳 吏곹썑���뚯씪�쇱쓣 由ъ뀑 �쒗궗吏��щ� (reset 硫붿냼���섑뻾)
 	    }).attach({
 	    	select : function(oCustomEvent) {
 	    		//�뚯씪 �좏깮���꾨즺�섏뿀����諛쒖깮
// 		    	 oCustomEvent (�대깽��媛앹껜) = {
// 	    			sValue (String) �좏깮��File Input��媛�
// 	    			bAllowed (Boolean) �좏깮���뚯씪���뺤떇���덉슜�섎뒗 �뺤떇�몄� �щ�
// 	    			sMsgNotAllowedExt (String) �덉슜�섏� �딅뒗 �뚯씪 �뺤떇��寃쎌슦 �꾩썙以�寃쎄퀬硫붿꽭吏�
// 	    		}
//  				�좏깮���뚯씪���뺤떇���덉슜�섎뒗 寃쎌슦留�泥섎━ 
 	    		if(oCustomEvent.bAllowed === true){
 		    		goStartMode();
 		    	}else{
 		    		goReadyMode();
 		    		oFileUploader.reset();
 		    	}
// 	    		bAllowed 媛믪씠 false��寃쎌슦 寃쎄퀬臾멸뎄���④퍡 alert �섑뻾 
// 	    		oCustomEvent.stop(); �섑뻾��bAllowed 媛�false�대뜑�쇰룄 alert���섑뻾�섏� �딆쓬
 	    	},
 	    	success : function(oCustomEvent) {
 	    		// alert("success");
 	    		// �낅줈�쒓� �깃났�곸쑝濡��꾨즺�섏뿀����諛쒖깮
 	    		// oCustomEvent(�대깽��媛앹껜) = {
 	    		//	htResult (Object) �쒕쾭�먯꽌 �꾨떖�댁＜��寃곌낵 媛앹껜 (�쒕쾭 �ㅼ젙���곕씪 �좊룞�곸쑝濡��좏깮媛�뒫)
 	    		// }
 	    		var aResult = []; 
 	    		aResult[0] = oCustomEvent.htResult;
 	    		setPhotoToEditor(aResult); 
 	    		//踰꾪듉 鍮꾪솢�깊솕
 	    		goReadyMode();
 	    		oFileUploader.reset();
 	    		window.close();
 	    	},
 	    	error : function(oCustomEvent) {
 	    		//�낅줈�쒓� �ㅽ뙣�덉쓣 ��諛쒖깮
 	    		//oCustomEvent(�대깽��媛앹껜) = {
 	    		//	htResult : { (Object) �쒕쾭�먯꽌 �꾨떖�댁＜��寃곌낵 媛앹껜. �먮윭諛쒖깮��errstr �꾨줈�쇳떚瑜�諛섎뱶���ы븿�섎룄濡��쒕쾭 �묐떟���ㅼ젙�섏뿬�쇳븳��
 	    		//		errstr : (String) �먮윭硫붿떆吏�
 	    		// 	}
 	    		//}
 	    		//var wel = jindo.$Element("info");
 	    		//wel.html(oCustomEvent.htResult.errstr);
 	    		alert(oCustomEvent.htResult.errstr);
 	    	}
 	    });
 	}
	
    /**
     * �섏씠吏��リ린 踰꾪듉 �대┃
     */
    function closeWindow(){
	   	if(bSupportDragAndDropAPI){
	   		removeEvent();
	   	}
	   	window.close();
    }
    
	window.onload = function(){
  		checkDragAndDropAPI();
  		
  		if(bSupportDragAndDropAPI){
  			$Element("pop_container2").hide();
  			$Element("pop_container").show();
  			
  			welTextGuide.removeClass("nobg");
  			welTextGuide.className("bg");
  			
  			addEvent();
  		} else {
  			$Element("pop_container").hide();
  			$Element("pop_container2").show();
  			callFileUploader();
  		}
  		fnUploadImage = $Fn(uploadImage,this);
  		$Fn(closeWindow,this).attach(welBtnCancel.$value(), "click");
	};

	/**
	 *  �쒕쾭濡쒕���諛쏆� �곗씠��� �먮뵒�곗뿉 �꾨떖�섍퀬 李쎌쓣 �レ쓬.
	 * @parameter aFileInfo [{},{},...] 
	 * @ex aFileInfo = [
	 * 	{
			sFileName : "nmms_215646753.gif",
			sFileURL :"http://static.naver.net/www/u/2010/0611/nmms_215646753.gif",
			bNewLine : true
		},
		{
			sFileName : "btn_sch_over.gif",
			sFileURL :"http://static1.naver.net/w9/btn_sch_over.gif",
			bNewLine : true
		}
	 * ]
	 */
 	function setPhotoToEditor(oFileInfo){
		if (!!opener && !!opener.nhn && !!opener.nhn.husky && !!opener.nhn.husky.PopUpManager) {
			//�ㅻ쭏���먮뵒���뚮윭洹몄씤���듯빐���ｋ뒗 諛⑸쾿 (oFileInfo��Array)
			opener.nhn.husky.PopUpManager.setCallback(window, 'SET_PHOTO', [oFileInfo]);
			//蹂몃Ц��諛붾줈 tag瑜��ｋ뒗 諛⑸쾿 (oFileInfo��String�쇰줈 <img src=....> )
			//opener.nhn.husky.PopUpManager.setCallback(window, 'PASTE_HTML', [oFileInfo]);
		}
	}
 	
 	// 2012.05 �꾩옱] jindo.$Ajax.prototype.request�먯꽌 file怨�form��吏�썝�섏� �덊븿. 
 	jindo.$Ajax.prototype.request = function(oData) {
 		this._status++;
 		var t   = this;
 		var req = this._request;
 		var opt = this._options;
 		var data, v,a = [], data = "";
 		var _timer = null;
 		var url = this._url;
 		this._is_abort = false;

 		if( opt.postBody && opt.type.toUpperCase()=="XHR" && opt.method.toUpperCase()!="GET"){
 			if(typeof oData == 'string'){
 				data = oData;
 			}else{
 				data = jindo.$Json(oData).toString();	
 			}	
 		}else if (typeof oData == "undefined" || !oData) {
 			data = null;
 		} else {
 			data = oData;
 		}
 		
 		req.open(opt.method.toUpperCase(), url, opt.async);
 		if (opt.sendheader) {
 			if(!this._headers["Content-Type"]){
 				req.setRequestHeader("Content-Type", "application/x-www-form-urlencoded; charset=utf-8");
 			}
 			req.setRequestHeader("charset", "utf-8");
 			for (var x in this._headers) {
 				if(this._headers.hasOwnProperty(x)){
 					if (typeof this._headers[x] == "function") 
 						continue;
 					req.setRequestHeader(x, String(this._headers[x]));
 				}
 			}
 		}
 		var navi = navigator.userAgent;
 		if(req.addEventListener&&!(navi.indexOf("Opera") > -1)&&!(navi.indexOf("MSIE") > -1)){
 			/*
 			 * opera 10.60�먯꽌 XMLHttpRequest��addEventListener湲�異붽��섏뿀吏�쭔 �뺤긽�곸쑝濡��숈옉�섏� �딆븘 opera��臾댁“嫄�dom1諛⑹떇�쇰줈 吏�썝��
 			 * IE9�먯꽌��opera��媛숈� 臾몄젣媛��덉쓬.
 			 */
 			if(this._loadFunc){ req.removeEventListener("load", this._loadFunc, false); }
 			this._loadFunc = function(rq){ 
 				clearTimeout(_timer);
 				_timer = undefined; 
 				t._onload(rq); 
 			}
 			req.addEventListener("load", this._loadFunc, false);
 		}else{
 			if (typeof req.onload != "undefined") {
 				req.onload = function(rq){
 					if(req.readyState == 4 && !t._is_abort){
 						clearTimeout(_timer); 
 						_timer = undefined;
 						t._onload(rq);
 					}
 				};
 			} else {
 	            /*
 				 * IE6�먯꽌��onreadystatechange媛��숆린�곸쑝濡��ㅽ뻾�섏뼱 timeout�대깽�멸� 諛쒖깮�덈맖.
 				 * 洹몃옒��interval濡�泥댄겕�섏뿬 timeout�대깽�멸� �뺤긽�곸쑝濡�諛쒖깮�섎룄濡��섏젙. 鍮꾨룞湲�諛⑹떇�쇰븣留�
 		
 	             */
 				if(window.navigator.userAgent.match(/(?:MSIE) ([0-9.]+)/)[1]==6&&opt.async){
 					var onreadystatechange = function(rq){
 						if(req.readyState == 4 && !t._is_abort){
 							if(_timer){
 								clearTimeout(_timer);
 								_timer = undefined;
 							}
 							t._onload(rq);
 							clearInterval(t._interval);
 							t._interval = undefined;
 						}
 					};
 					this._interval = setInterval(onreadystatechange,300);

 				}else{
 					req.onreadystatechange = function(rq){
 						if(req.readyState == 4){
 							clearTimeout(_timer); 
 							_timer = undefined;
 							t._onload(rq);
 						}
 					};
 				}
 			}
 		}

 		req.send(data);
 		return this;
 	};
