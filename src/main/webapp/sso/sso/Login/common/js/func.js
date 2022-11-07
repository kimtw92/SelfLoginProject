//---------------------------------------------------------------------------//
// FUNCTION 	: Init
// PARAMETER	: _pkiType	- 0 : GPKI, 1 : NPKI
//		  _cryptAlgo	- Crypt Algorithm
//		  _site		- SITE
// RETURN	: 0 : ����, Other : ����
// NOTES	: �ʱ� ���� ����, ����Ʈ �̸��� ��ȣȭ ����� �����Ѵ�.
//---------------------------------------------------------------------------//
function Init(_pkiType, _cryptAlgo, _logonMode, _site)
{
	return document.MagicPass.Init(_pkiType, _cryptAlgo, _logonMode, _site);
}


//---------------------------------------------------------------------------//
// FUNCTION 	: Logout
// PARAMETER	: _site		- SITE
// RETURN	: NONE
// NOTES	: MagicPass�� �α׾ƿ� ��Ų��.
//---------------------------------------------------------------------------//
function Logout(_site)
{
	document.MagicPass.Logout(_site);
}


//---------------------------------------------------------------------------//
// FUNCTION 	: GetLogonEnvKey
// RETURN	: 0 : ����, Other : ����
// NOTES	: ���� �������� Env �� Ű
//---------------------------------------------------------------------------//
function GetLogonEnvKey(_site, _cert)
{
	return document.MagicPass.GetLogonEnvKey(_site, _cert);	
}


//---------------------------------------------------------------------------//
// FUNCTION 	: GetAppEnvKey
// RETURN	: 0 : ����, Other : ����
// NOTES	: ���� �������� Env �� Ű
//---------------------------------------------------------------------------//
function GetAppEnvKey(_site, _appCode, _cert)
{
	return document.MagicPass.GetAppEnvKey(_site, _appCode, _cert);
}

function GetResult()
{
	return document.MagicPass.Result;
}


//---------------------------------------------------------------------------//
// FUNCTION 	: ChangeLogonKey
// RETURN	: 0 : ����, Other : ����
// NOTES	: ����Ű�� ��ȯ�Ѵ�.
//---------------------------------------------------------------------------//
function ChangeLogonKey(_site, _encKey)
{
	return document.MagicPass.ChangeLogonKey(_site, _encKey);
}


//---------------------------------------------------------------------------//
// FUNCTION 	: ChangeAppKey
// RETURN	: 0 : ����, Other : ����
// NOTES	: ����Ű�� ��ȯ�Ѵ�.
//---------------------------------------------------------------------------//
function ChangeAppKey(_site, _appCode, _encKey)
{
	return document.MagicPass.ChangeAppKey(_site, _appCode, _encKey);
}

//---------------------------------------------------------------------------//
// FUNCTION 	: EncryptLogon
// RETURN	: 0 : ����, Other : ����
// NOTES	: �α׿� ������ ��ȣȭ�Ѵ�.
//---------------------------------------------------------------------------//
function EncryptLogon(_site, _logon)
{
	return document.MagicPass.EncryptLogon(_site, _logon);
}


//---------------------------------------------------------------------------//
// FUNCTION 	: ChangeKey
// RETURN	: 0 : ����, Other : ����
// NOTES	: ����Ű�� ��ȯ�Ѵ�.
//---------------------------------------------------------------------------//
function ChangeKey(_site, _appCode, _encKey)
{
	return document.MagicPass.ChangeKey(_site, _appCode, _encKey);
}


//---------------------------------------------------------------------------//
// FUNCTION 	: Encrypt
// RETURN	: 0 : ����, Other : ����
// NOTES	: ����Ű�� �����͸� ��ȣȭ�Ѵ�.
//---------------------------------------------------------------------------//
function DSEncrypt(_site, _txt)
{
	return document.MagicPass.EncryptAuth(_site, _txt);
}

//---------------------------------------------------------------------------//
// FUNCTION 	: EncryptApp
// RETURN	: 0 : ����, Other : ����
// NOTES	: ����Ű�� �����͸� ��ȣȭ�Ѵ�.
//---------------------------------------------------------------------------//
function EncryptApp(_site, _appCode, _txt)
{
	return document.MagicPass.Encrypt(_site, _appCode, _txt);
}

function DecryptApp(_site, _appCode, _enc)
{
	return document.MagicPass.Decrypt(_site, _appCode, _enc);
}


function SetToken(_site, _encToken)
{
	return document.MagicPass.SetToken(_site, _encToken);
}



function GetToken(_site, _appCode)
{
	return document.MagicPass.GetToken(_site, _appCode);
}


function IsLogon(_site)
{
	if( document.MagicPass.GetStatus(_site) == 150 )//LOGON_STATUS )
		return true;

	return false;	
}



function GetLogonType(_site)
{
	return document.MagicPass.GetLogonType(_site);
}


//---------------------------------------------------------------------------//
// FUNCTION 	: GetSerialNo
// RETURN	: 0 : ����, Other : ����
// NOTES	: ������ �α��� ��, SerialNo�� ��´�. 
//---------------------------------------------------------------------------//
function GetSerialNo(_site)
{
	if( document.MagicPass.GetSerialNo(_site) == 0 )
		return document.MagicPass.Result;
	
	return "";
}


//---------------------------------------------------------------------------//
// FUNCTION 	: GetCert
// RETURN	: 0 : ����, Other : ����
// NOTES	: ������ �α��� ��, ����� �������� ��´�. 
//---------------------------------------------------------------------------//
function GetCert(_site)
{
	if( document.MagicPass.GetCert(_site) == 0 )
		return document.MagicPass.Result;
	
	return "";
}


//---------------------------------------------------------------------------//
// FUNCTION 	: GetCertDN
// RETURN	: 0 : ����, Other : ����
// NOTES	: ������ �α��� ��, ����� ������ DN�� ��´�. 
//---------------------------------------------------------------------------//
function GetCertDN(_site)
{
	if( document.MagicPass.GetCertDN(_site) == 0 )
		return document.MagicPass.Result;
	
	return "";
}


function VersionCheckAndDownload(SETUP_CONF_PATH, SETUP_DOWNLOAD_URL)
{
	var varRet;
	if( (varRet = document.MagicLoaderX.VersionCheck(SETUP_CONF_PATH)) == 2 )
	{
		if(confirm("MagicPass ������Ʈ �۾��� �����մϴ�.\nƮ���̾������� MagicPass�� �۾� ���̽� \n��� �������� �����Ͽ��ֽñ� �ٶ��ϴ�.\nȮ���� �����ø� ��ġ�� �����մϴ�."))
		{
			if( document.MagicLoaderX.Download(SETUP_DOWNLOAD_URL) == 0 )
			{
				return true;
			}
			else
			{
				alert("DownLoad Error["+SETUP_DOWNLOAD_URL+"]");
				return false;
			}
		}
		else
		{
			alert("��Ҹ� �����ϼ̽��ϴ�.\n\nMagicPass ������Ʈ �۾��� ����մϴ�.");
			return false;
		}
	}
	else if( varRet == 0 )
		return true;
	alert("VersionCheck Error["+SETUP_CONF_PATH+"]");
	return false;
}

function ProgramCheck(_proName)
{
	if( document.MagicLoaderX.ProgramCheck(_proName) == 0 )
		return true;

	return false;
}

function ProgramRun(_runURL, _arg, _name)
{
	if( document.MagicLoaderX.ProgramRun(_runURL, _arg, _name) == 0 )
		return true;
	
	return false;
}



function MakePlainText(form) {

	var name = new Array(form.elements.length); 
	var value = new Array(form.elements.length); 
	var flag = false;
	var j = 0;
	var plain_text="";


	len = form.elements.length; 
	for (i = 0; i < len; i++) {
		if ((form.elements[i].type != "button") && (form.elements[i].type != "reset") && (form.elements[i].type != "submit")) 
		{
			if (form.elements[i].type == "radio" || form.elements[i].type == "checkbox") 
			{ 
				if (form.elements[i].checked == true) 
				{
					name[j] = form.elements[i].name; 
					value[j] = form.elements[i].value;
					j++;
				}
			}
			else {
				name[j] = form.elements[i].name; 
				if (form.elements[i].type == "select-one") {
					var ind = form.elements[i].selectedIndex;
					if (form.elements[i].options[ind].value != '')
						value[j] = form.elements[i].options[ind].value;
					else
						value[j] = form.elements[i].options[ind].text;
				}
				else {
					value[j] = form.elements[i].value;
				}
				j++;
			}
		}
	}
	
	for (i = 0; i < j; i++) {
		if (flag)
			plain_text += "��";
		else
			flag = true;
		plain_text += name[i] ;
		plain_text += "��";
		plain_text += value[i];
	}
	return plain_text;
}

function DisplayMsg(title, body)
{
	msg = "&nbsp;<font color='blue' class='12p'>\r\n";
	msg = msg + "<img src='/sso/image/ball02.gif' width='9' height='10'>\r\n";
	msg = msg + "<B>" + title +" : </B></font>";
	msg = msg + "<font class='12p'>\r\n";
	msg = msg + body +"</font><br>";
	document.write(msg);
}