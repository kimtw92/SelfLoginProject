<%
/************************** 
/* 설치파일 정보 설정하기 
/* update : 2004.12.20 - by kimtc
**************************/

/************************** 
/* 사이트 정보
**************************/
String MG_SITE_NAME     	= "인천광역시";        // 기관명(시도)
String LINK_APP_CODE            = "APPL000005";        // 어플리케이션 코드
String LINK_APP_GBN_CODE        = "LNK";               // 어플리케이션 구분명
//String LINK_SERVICE_PAGE_URL    = "/sso/sso/Login/App/SessionView.jsp";
String LINK_SERVICE_PAGE_URL    = "/homepage/login.do?mode=sso";

/************************** 
/* 인증서버 정보 
**************************/
//String  AUTH_SERVER_IP    	=  "99.1.2.16"; 	// 인증서버 아이피(L4)
//int     AUTH_SERVER_PORT  	=  40010;               // 인증서버 포트

/************************** 
/* 서버 인증서 정보파일
**************************/
String  MG_CERT_INFO     	= "/app1/apache/htdocs/LOTI/WebRoot/sso/sso/Config/ssoapi.conf";  //DocuementRoot(웹루트)

/************************** 
/* ActiveX 정보 
**************************/
String OBJECT_MAGICLOADERX 	= "<OBJECT ID='MagicLoaderX' CLASSID='CLSID:3D64E58D-CB55-4344-B809-CFE38F900838' width=0 height=0></object>";
String OBJECT_MAGICPASSX 	= "<OBJECT ID='MagicPass' CLASSID='CLSID:AD6870C0-44B7-42FB-A119-C2C6BD9CD005' width=0 height=0></object>";

// [설치된 디렉토리 및 파일 정보]
String PROGRAM_NAME			= "MagicPass";
%>    
