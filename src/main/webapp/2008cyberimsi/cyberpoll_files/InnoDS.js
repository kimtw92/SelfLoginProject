var Enc = new String();
var Enc = "Nyx4ks5/gi4FDHsOJVEJQ5Xqb/Q8tdWDUh/C+zh8dZdLbDln2rLYqGQYSmIwSZu/E1tPvOJ/itObC2ygJNE3JGdNDZj2UPZ0F/CYRgWjLqGjv+mGgr7KNRoUZmhvGN4XuvkuSeCHkjBE1x9xLMvqhBl8buLwaOasKi9VI3RWSVMynEBpAf6oKVCIrUD7vpTMXkrqKihlvdt8oF8Eml7dEF6NqeQ3a8xD7azSQ2LV+bz8hQSu4aXIrF62oTiTJG70anmdR6pOclhch1y1P4RHBQ=="; 
var Prod = new String();

var UseUnicode = "false";
var ChildMode = "false";

var ActionFilePath = new String("");
var SplitSize = 1024 * 1024 * 2; // 바이트 단위
var MinimumSplitSize = 1024 * 1024 * 2; // 바이트 단위
var FolderUpload = "";

var UniqueID = new String();
var InputType = "fixed";

var DialogListHeight = "";
var ListStyle = new String("");
var ShowFullPath = "false";
var ShowStatus = "true";
var SetStatusWidth = new String("");
var BkImgURL = "";

var InnoDS_Cab = "/commonInc/inno/InnoDS5.cab";
var InnoDS_Version = "5,0,0,2048";

function InnoDS_CheckExt(arLimitExt, strFileName)
{
	var bRet = false;
	if (arLimitExt.length == 0)
	{
		return true;
	}

	var strExt = strFileName.split(".");
	var strExt2 = strExt[strExt.length-1].toLowerCase();
	for (var i = 0; i < arLimitExt.length; i++)
	{
		var limitExt2 = arLimitExt[i].toLowerCase();
		if (strExt2 == limitExt2)
		{
			bRet = true;
			break;
		}
	}

	if (!bRet)
	{
		alert(strExt2 + " 파일은 선택 하실 수 없습니다.");
	}

	return bRet;
}

function InnoDSInitMulti(TotalMaxSize, UnitMaxSize, MaxFileCount, nWidth, nHeight, strID)
{
	TotalMaxSize = TotalMaxSize * 1024;
	UnitMaxSize = UnitMaxSize * 1024;

	if (nWidth == "undefined")
	{
		nWidth = "100%";
	}

	if (nHeight == "undefined")
	{
		nHeight = "100%";
	}

	var codeMSG = "codebase=\"" + InnoDS_Cab + "#version=" + InnoDS_Version + "\" ";

	var tStr = "<div id=\"InnoDSDIV\">" +

				"<object id=\"" + strID + "\" classid=\"CLSID:999206BD-3FD0-4a47-A96E-680E8DB844C2\" " + codeMSG +
				"width=\"" + nWidth + "\" height=\"" + nHeight + "\"" +
				" VIEWASTEXT>" +

				"<param name=\"ENC\" value=\"" + Enc + "\">" +
				"<param name=\"Prod\" value=\"" + Prod + "\">" +

				"<param name=\"UseUnicode\" value=\"" + UseUnicode + "\">" +
				"<param name=\"ChildMode\" value=\"" + ChildMode + "\">" +

				"<param name=\"Action\" value=\"" + ActionFilePath + "\">" +
				"<param name=\"SplitSize\" value=\"" + SplitSize + "\">" +
				"<param name=\"MinimumSplitSize\" value=\"" + MinimumSplitSize + "\">" +
				"<param name=\"FolderUpload\" value=\"" + FolderUpload + "\">" +

				"<param name=\"ListStyle\" value=\"" + ListStyle + "\">" +
				"<param name=\"ShowFullPath\" value=\"" + ShowFullPath + "\">" +
				"<param name=\"ShowStatus\" value=\"" + ShowStatus + "\">" +

				"<param name=\"MaxFileCount\" value=\"" + MaxFileCount + "\">" +
				"<param name=\"MaxUnitFileSize\" value=\"" + UnitMaxSize + "\">" +
				"<param name=\"MaxTotalFileSize\" value=\"" + TotalMaxSize + "\">" +

				"<param name=\"Language\" value=\"ko\">";

    if (BkImgURL != "")
	{
		tStr += "<param name=\"BkImgURL\" value=\"" + BkImgURL + "\">";
	}

	if (DialogListHeight.length > 0)
	{
		tStr += "<param name=\"DialogListHeight\" value=\"" + DialogListHeight + "\">";
	}

	tStr += "</object></div>";

	//alert(tStr);
	document.writeln(tStr);

	////////////////////
	var bAvailable = false;
	var APObject = document.getElementById(strID);
	if (typeof(APObject) == 'object')
	{
		if (APObject.readyState == 4)
		{
			if (APObject.object != null)
			{
				bAvailable = true;
			}
		}
	}

	if (bAvailable)
	{
		try
		{
			if (SetStatusWidth.length > 0)
			{
				var zArr = SetStatusWidth.split('|');

				try
				{
					document.getElementById(strID).SetStatusWidth(0) = zArr[0];
					document.getElementById(strID).SetStatusWidth(1) = zArr[1];
					document.getElementById(strID).SetStatusWidth(2) = zArr[2];			
				}
				catch (ex) { }
			}

			eval("On" + strID + "Load()");
		}
		catch (ex) { }
	}
	else
	{
		// 미설치 혹은 업데이트필요시 처리
	}
	////////////////////
}

function InnoDSInit(TotalMaxSize, UnitMaxSize, MaxFileCount, nWidth, nHeight)
{
    InnoDSInitMulti(TotalMaxSize, UnitMaxSize, MaxFileCount, nWidth, nHeight, "InnoDS");
}

function InnoDSSubmitMulti(_FormObject, _DSObject)
{
	if (_DSObject == "undefined")
	{
		return false;
	}

	if (_DSObject.ItemCount == 0)
	{
		//return false;
	}

	if (typeof(g_ExistFiles) != "undefined")
	{
		var z2 = '';

		for (var i = 0; i < _DSObject.ItemCount; i++)
		{
			if (_DSObject.IsTempFile(i))
			{
				g_ExistFiles[_DSObject.GetFileID(i)] = true;
			}
		}

		var oInput9;

		for (var key in g_ExistFiles)
		{
			if (InputType == 'array') {
				z2 = '[]';
//			} else if (InputType == 'ordernum') {
//				z2 = new String(i+1);
			} else {
				z2 = '';
			}

			if (g_ExistFiles[key] == true)
			{
				oInput9  = document.createElement('<input type="hidden" name="_innods_exist_file' + z2 + '" value="' + key + '">');
				_FormObject.insertAdjacentElement("afterBegin", oInput9);
			}
			else
			{
				oInput9  = document.createElement('<input type="hidden" name="_innods_deleted_file' + z2 + '" value="' + key + '">');
				_FormObject.insertAdjacentElement("afterBegin", oInput9);
			}

			g_ExistFiles[key] = false;
		}
	}

	var FileName = _DSObject.UploadFileName.toArray();
    var FileSize = _DSObject.UploadFileSize.toArray();
    var Folder = _DSObject.UploadFolder.toArray();
    var SendBytes = _DSObject.UploadBytes.toArray();
    var Status = _DSObject.UploadStatus.toArray();
	var z = '';

	for (var i = 0; i < FileName.length; i++)
    {
		if (Status[i] == "temp")
			continue;

		if (InputType == 'array') {
			z = '[]';
		} else if (InputType == 'ordernum') {
			z = new String(i+1);
		} else {
			z = '';
		}

        var oInput1  = document.createElement('<input type="hidden" name="_innods_filename' + z + '" value="' + FileName[i] + '">');
        var oInput2  = document.createElement('<input type="hidden" name="_innods_filesize' + z + '" value="' + FileSize[i] + '">');
        var oInput3  = document.createElement('<input type="hidden" name="_innods_folder' + z + '" value="' + Folder[i] + '">');
        var oInput4  = document.createElement('<input type="hidden" name="_innods_sendbytes' + z + '" value="' + SendBytes[i] + '">');
        var oInput5  = document.createElement('<input type="hidden" name="_innods_status' + z + '" value="' + Status[i] + '">');

        _FormObject.insertAdjacentElement("afterBegin", oInput1);
        _FormObject.insertAdjacentElement("afterBegin", oInput2);
        _FormObject.insertAdjacentElement("afterBegin", oInput3);
        _FormObject.insertAdjacentElement("afterBegin", oInput4);
        _FormObject.insertAdjacentElement("afterBegin", oInput5);
	}

	if (UniqueID.length > 0)
	{
		var oInput  = document.createElement('<input type="hidden" name="_SUB_DIR" value="' + UniqueID + '">');
		_FormObject.insertAdjacentElement("afterBegin", oInput);
	}

	//alert("1");
	_FormObject.submit();
}

function InnoDSSubmit(_FormObject)
{
    InnoDSSubmitMulti(_FormObject, document.getElementById("InnoDS"));
}

function InnoDSGetUniqueID()
{
	return new String(Math.floor(Math.random() * 100000) + 1);
}

function InnoDSStartUploadMulti(_DSObject)
{
//	if (_DSObject.ItemCount == 0)
//	{
//		alert('전송할 파일이 없습니다.');
//		return;
//	}


	UniqueID = InnoDSGetUniqueID();
    _DSObject.AppendPostData('_SUB_DIR', UniqueID);
    _DSObject.StartUpload();
}

function InnoDSStartUpload()
{
	InnoDSStartUploadMulti(document.getElementById("InnoDS"));
}

function SetDialogListHeightToFit(strID, Count)
{
	if (!strID)
		strID = 'InnoDS';

	var obj = document.getElementById(strID);

	if (!obj)
		return;

	if (!Count)
		Count = obj.ItemCount;

	var size = 20+(Count*17)+20;
	if (size > 200)
		size = 200;

	obj.DialogListHeight = size;
}

function InnoMPInit(nWidth, nHeight, strID)
{
	if (!nWidth)
		nWidth = "100%";

	if (!nHeight)
		nHeight = "100%";

	if (!strID)
		strID = 'InnoMP';

	var tStr = '';
    tStr += '<OBJECT ID="' + strID + '" WIDTH="' + nWidth + '" HEIGHT="' + nHeight + '"';
    tStr += '  CLASSID="CLSID:22D6f312-B0F6-11D0-94AB-0080C74C7E95"';
    tStr += '  codebase="http://activex.microsoft.com/activex/controls/mplayer/en/nsmp2inf.cab#Version=5,1,52,701"';
    tStr += '  STANDBY="Loading Windows Media Player components..." ';
    tStr += '  TYPE="application/x-oleobject">';
    tStr += '<param name="FileName" value="">';
    tStr += '<param name="AudioStream" value="-1">';
    tStr += '<param name="AutoSize" value="true">';
    tStr += '<param name="AutoStart" value="true">';
    tStr += '<param name="AnimationAtStart" value="true">';
    tStr += '<param name="AllowScan" value="true">';
    tStr += '<param name="AllowChangeDisplaySize" value="true">';
    tStr += '<param name="AutoRewind" value="false">';
    tStr += '<param name="Balance" value="0">';
    tStr += '<param name="BufferingTime" value="1">';
    tStr += '<param name="CanSeek" value="true">';
    tStr += '<param name="CanSeekToMarkers" value="true">';
    tStr += '<param name="ClickToPlay" value="true">';
    tStr += '<param name="CursorType" value="0">';
    tStr += '<param name="CurrentPosition" value="0">';
    tStr += '<param name="CurrentMarker" value="0">';
    tStr += '<param name="DisplayBackColor" value="0">';
    tStr += '<param name="DisplayForeColor" value="0">';
    tStr += '<param name="DisplayMode" value="1">';
    tStr += '<param name="DisplaySize" value="1">';
    tStr += '<param name="Enabled" value="true">';
    tStr += '<param name="EnableContextMenu" value="false">';
    tStr += '<param name="EnablePositionControls" value="false">';
    tStr += '<param name="EnableFullScreenControls" value="false">';
    tStr += '<param name="EnableTracker" value="true">';
    tStr += '<param name="InvokeURLs" value="true">';
    tStr += '<param name="Language" value="-1">';
    tStr += '<param name="Mute" value="false">';
    tStr += '<param name="PreviewMode" value="true">';
    tStr += '<param name="Rate" value="1">';
    tStr += '<param name="SelectionStart" value="-1">';
    tStr += '<param name="SelectionEnd" value="-1">';
    tStr += '<param name="SendOpenStateChangeEvents" value="true">';
    tStr += '<param name="SendWarningEvents" value="true">';
    tStr += '<param name="SendErrorEvents" value="true">';
    tStr += '<param name="SendKeyboardEvents" value="false">';
    tStr += '<param name="SendMouseClickEvents" value="false">';
    tStr += '<param name="SendMouseMoveEvents" value="false">';
    tStr += '<param name="SendPlayStateChangeEvents" value="true">';
    tStr += '<param name="ShowCaptioning" value="false">';
    tStr += '<param name="ShowControls" value="true">';
    tStr += '<param name="ShowAudioControls" value="true">';
    tStr += '<param name="ShowDisplay" value="false">';
    tStr += '<param name="ShowGotoBar" value="false">';
    tStr += '<param name="ShowPositionControls" value="false">';
    tStr += '<param name="ShowStatusBar" value="true">';
    tStr += '<param name="ShowTracker" value="true">';
    tStr += '<param name="TransparentAtStart" value="false">';
    tStr += '<param name="VideoBorderWidth" value="0">';
    tStr += '<param name="VideoBorderColor" value="0">';
    tStr += '<param name="VideoBorder3D" value="false">';
    tStr += '<param name="WindowlessVideo" value="false">';
    tStr += '<param name="uiMode" value="none">';
    tStr += '</object>';

	document.writeln(tStr);
}

function InnoMPAutoStart(strID)
{
	if (!strID)
		strID = 'InnoMP';

    var obj = document.getElementById(strID);
    if (obj && typeof(obj) == 'object') {
		if (obj.Duration > 0) {
		    // obj.Play();
		} else {
		    obj.Play();
			setTimeout("InnoMPAutoStart('" + strID + "')", 500);
		}
    }
}

function LoadCM(nUrl, nName, nWidth, nHeight)
{
	var size = 'width=' + nWidth + ',height=' + nHeight;
	var nw = window.open(nUrl, nName, size + ',scrollbars=no,resizable=no');
	nw.focus();
}
