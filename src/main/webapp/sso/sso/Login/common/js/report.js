////////////////////////////////////////////////////////////////////////////////
// 				ERROR CODE DEFINE
////////////////////////////////////////////////////////////////////////////////

var ERR_MEMORY_MAP_CREATE		=	100;
var ERR_MEMORY_MAP_READ			=	101;
var ERR_MEMORY_MAP_EXIST		=	102;
var ERR_MPS_NONE_EXECUTE		=	103;

// Comunication Error
var ERR_MPS_RECV_DATA			=	200;	// 수신 데이터 에러
var ERR_MPS_RECV_DATA_OVERFLOW	=	201;	// 수신된 데이터가 너무 큽니다.
var ERR_MPS_RECV_DATA_MIN		=	202;	// 수신된 데이터가 너무 작습니다.
var ERR_MPS_NONE_CONNECTION		=	203;	// 연결 정보가 없습니다.
var ERR_MPS_NONE_TRANSERVER		=	204; 	// TranServer 정보가 없습니다.
var ERR_MPS_POLICY_CONFIG		=	205; 	// Policy server로 부터 Config 정보를 수신 받지 못하였습니다. Connection 확인
var ERR_MPS_POLICY_ACL			=	206; 	// Policy Server로 부터 ACL 정보를 수신 받지 못하였습니다. 
var ERR_MPS_INPUT_ID			=	207; 	// 입력하신 ID를 확인바랍니다.
var ERR_MPS_INPUT_PASSWORD		=	208; 	// 입력하신 PW를 확인바랍니다.
var ERR_MPS_MESSAGE_HEADER		=	209;	// 서버에서 수신 된 Message의 헤터 포맷이 잘못되었습니다.
var ERR_MPS_LOGOUT_STATUS		=	210;	// Logout Status
var ERR_MPS_TRAN_SERVER_CERT	=	211;	// Tran Server로 부터 인증서. 접소 IP정보를 받지 못하였습니다.
var ERR_MPS_SESSION_KEY			=	212;	// Tran Server와 세션 키 교환에 실패하였습니다.
var ERR_MPS_SYSTEM_NETWORK		=	213;
var ERR_MPS_NONE_MUTEX			=	214;
var ERR_MPS_NONE_SESSION_KEY	= 	215;
var ERR_MPS_PASSWORD_EXPIRE		=	216;

var ERR_ENCRYPT_KEY				= 	300;
var ERR_KEY_USAGE				= 	301;
var ERR_PARSE_CERT				= 	302;
//var ERR_WRONG_CERT			= 	303;
var ERR_ENVELOPED_DATA			= 	304;
//var ERR_DECRYPT_DATA			= 	305;
var ERR_MAKE_HASH_DATA			= 	306;
var ERR_BASE64_ENC				= 	307;
var ERR_BASE64_DEC				= 	308;
var ERR_KEY_EMPTY				= 	309;
var ERR_CERT_EMPTY				= 	310;
var ERR_INPUT_EMPTY				= 	311;
var ERR_NONE_APP_INFO			= 	312;
var ERR_TOKEN_EMPTY				= 	313;
var ERR_NO_MATCH_HASH			= 	314;
var ERR_TIMESTAMP_VALUE			= 	315;
var ERR_HASH_VALUE				= 	316;
var ERR_INPUT_ID_EMPTY			= 	317;
var ERR_INPUT_PASS_EMPTY		= 	318;
var ERR_SAME_ID_PASSWORD		= 	320;
var ERR_SAME_SSN_PASSWORD		= 	321;
var ERR_SAME_MIN_PASSWORD		= 	322;
var ERR_CHANGE_PASSWORD			= 	323;
var ERR_EXPIRED_PASSWORD		= 	323;
var ERR_NO_MATCH_PASS			= 	324;


//-----------------------------------------------------------//
/* Bridge Page관련 에러정의 */
//-----------------------------------------------------------//
var ERR_BRIDGE_POLICY_SERVER_TIMEOUT	= 	700;	// Policy server 와의 타임아웃 
var ERR_BRIDGE_SERVER_AGENT_TIMEOUT		= 	701;	// Tran Server 와의 타임아웃 


//-----------------------------------------------------------//
/* GPKI API ERROR CODE */
//-----------------------------------------------------------//
var ERR_GPKI_EXPIRED_CERT			= 	1203		// "해당 인증서의 유효기간이 만료되었습니다. <br> 재발급 받시시기바랍니다."	
var ERR_GPKI_WRONG_CRL				= 	1211		// "잘못된 인증서 폐지 목록(CRL)입니다."	
var ERR_GPKI_EXPIRED_CRL			= 	1212		// "유효기간이 만료된 인증서 폐지 목록(CRL)입니다."	
var ERR_GPKI_HOLDED_CERT			= 	1214		// "효력정지된 인증서 입니다."	
var ERR_GPKI_REVOKED_CERT			= 	1215		// "폐지된 인증서 입니다."	
var ERR_GPKI_CONNECT_OCSP			= 	1216		// "OCSP 서버에 접속하는데 실패하였습니다."	
var ERR_GPKI_OCSP_REQ_NOT_GRANTED	= 	1221		// "OCSP 요청이 승인되지 않았습니다."	
var ERR_GPKI_NOT_SIGN_CERT			= 	1510		// "선택하신 인증서가 서명용인증서가 아닙니다."	
var ERR_GPKI_WRONG_URL				= 	2000		// "URL에서 ://을 찾을 수 없습니다."	

//-----------------------------------------------------------//
// GPKIAPI RETURN ERROR
//-----------------------------------------------------------//
var ERR_GPKI_ALREADY_INITIALIZED	= 	1000;
var ERR_GPKI_READ_ENTRY				= 	2013;


//-----------------------------------------------------------//
// DB(DS) Gateway 에러코드 정의
//-----------------------------------------------------------//
var ERR_GATEWAY_DN_NOT_EXIST			= 	10000;
var ERR_GATEWAY_ID_NOT_EXIST			= 	10001;
var ERR_GATEWAY_POID_NO_MATCH			= 	10002;
var ERR_GATEWAY_PW_NO_MATCH				= 	10003;
var ERR_GATEWAY_USER_DISABLE			= 	10010;    // 서비스중지
var ERR_GATEWAY_USER_WITHDRAW			= 	10011;    // 서비스탈퇴
var ERR_GATEWAY_USER_REQ_JOIN			= 	10012;    // 가입신청
var ERR_GATEWAY_PLCY_NO_VALID			= 	10020;    // 사용자보안정책이 빈경우(Msg:Error = User Policy is Empty)
var ERR_GATEWAY_PLCY_NO_AUTHABLE_TIME	= 	10021;   // 인증시간대이외의시간에인증요구시(Msg:Error = User use not Authentication Service because Authable time)
var ERR_GATEWAY_PLCY_NO_IP_ALLOW		= 	10022;   // 허용IP대역이아닌경우(Msg:Error = User IP is disallowed)
var ERR_GATEWAY_LDAP_PROCESS			= 	10100;    // LDAP에러 
var ERR_GATEWAY_LDAP_GW_INTERNAL		= 	10101;    // LDAP게이트웨이 내부 에러
var ERR_GATEWAY_LDAP_GW_RESP			= 	10102;    // LDAP게이트웨이 접속 또는 응답에러
var ERR_GATEWAY_CERT_IDENTITY_SYS		= 	800;

////////////////////////////////////////////////////////////////
// 				ERROR CODE REPORT

function ErrorMsg(varErrCode)
{
	var ERR_MESSAGE = ""

	switch( varErrCode )
	{
	case ERR_MEMORY_MAP_CREATE			:
		ERR_MESSAGE = "매직패스에 요청정보 초기화에 실패하였습니다.";
		break;

	case ERR_MEMORY_MAP_READ			:
		ERR_MESSAGE = "매직패스의 정보 수신에 실패하였습니다.";
		break;

	case ERR_MEMORY_MAP_EXIST			:
		ERR_MESSAGE = "매직패스에 요청정보를 보내는데 실패하였습니다.";
		break;

	case ERR_MPS_NONE_EXECUTE			:
		ERR_MESSAGE = "매직패스가 기동하지 않을 수 있습니다.<br>매직패스 트레이 아이콘을 확인해주세요.";
		break;

	case ERR_MPS_RECV_DATA				:
		ERR_MESSAGE = "수신 데이터 오류입니다.<br>서버로부터 잘못된 정보를 받았습니다.";
		break;

	case ERR_MPS_RECV_DATA_OVERFLOW		:	
		ERR_MESSAGE = "수신 데이터 오류입니다.<br>수신된 데이터가 너무 큽니다.";
		break;

	case ERR_MPS_RECV_DATA_MIN			:	
		ERR_MESSAGE = "수신 데이터 오류입니다.<br>수신된 데이터가 너무 작습니다.";
		break;

	case ERR_MPS_NONE_CONNECTION		:	
		ERR_MESSAGE = "요청하신 정보에대한 연결 정보가 존재하지 않습니다.";
		break;

	case ERR_MPS_NONE_TRANSERVER		:
		ERR_MESSAGE = "접속하려는 사이트에 대한 정보가 없습니다.<br>(사용자 토큰에 어플리케이션 정보가 없습니다.)";
		break;

	case ERR_MPS_POLICY_CONFIG			:
		ERR_MESSAGE = "인증서버로부터 CONFIG 정보를 받지 못하였습니다.<br>(인증서버가 실행되지 않을 수 있습니다.)";
		break;

	case ERR_MPS_POLICY_ACL				: 
		ERR_MESSAGE = "인증서버로부터 ACL 정보를 수신 받지 못하였습니다.";
		break;

	case ERR_MPS_INPUT_ID				:
		ERR_MESSAGE = "입력하신 아이디가 저장소에 존재하지 않습니다.<br>다시 한번 확인해주세요.";
		break;

	case ERR_MPS_INPUT_PASSWORD			:
		ERR_MESSAGE = "입력하신 비밀번호가 정확하지 않습니다.<br>다시 한번 확인해주세요.";
		break;

	case ERR_MPS_MESSAGE_HEADER			:
		ERR_MESSAGE = "서버에서 수신 된 메시지 헤더 형식이 오류를 포함하고 있습니다.";
		break;

	case ERR_MPS_LOGOUT_STATUS			:
		ERR_MESSAGE = "현재 로그아웃 상태입니다.<br>로그인 후 업무를 진행하시기 바랍니다.";
		break;

	case ERR_MPS_TRAN_SERVER_CERT		:
		ERR_MESSAGE = "어플리케이션 서버와 세션 키 교환을 위해 사용되는<br>서버인증서를 받지 못하였습니다.";
		break;

	case ERR_MPS_SESSION_KEY			:
		ERR_MESSAGE = "서버에이전트와 세션 키 교환에 실패하였습니다.";
		break;

	case ERR_MPS_SYSTEM_NETWORK			:
		ERR_MESSAGE = "시스템 혹은 네트웍 장애가 발생하여 서버 연결에 실패하였습니다.";
		break;

	case ERR_MPS_NONE_MUTEX				:
		ERR_MESSAGE = "사이트 정보가 존재하지 않습니다.";
		break;
		
	case ERR_MPS_NONE_SESSION_KEY			:
		ERR_MESSAGE = "세션키가 존재하지 않습니다.";
		break;

	// GPKI API 관련(인증서검증포함)
	case ERR_GPKI_EXPIRED_CERT			:
		ERR_MESSAGE = "해당 인증서의 유효기간이 만료되었습니다. <br>인증서를 재발급 받으세요.";
		break;
			
	case ERR_GPKI_WRONG_CRL				:
		ERR_MESSAGE = "잘못된 인증서 폐지 목록(CRL)입니다.";
		break;
		
	case ERR_GPKI_EXPIRED_CRL			:
		ERR_MESSAGE = "유효기간이 만료된 인증서 폐지 목록(CRL)입니다.";
		break;

	case ERR_GPKI_HOLDED_CERT			:
		ERR_MESSAGE = "효력정지된 인증서 입니다.";
		break;
		
	case ERR_GPKI_REVOKED_CERT			:
		ERR_MESSAGE = "폐지된 인증서 입니다. <br>인증서를 재발급 받으세요.";
		break;		
						
	case ERR_GPKI_CONNECT_OCSP			:
		ERR_MESSAGE = "OCSP 서버에 접속하는데 실패하였습니다. <br>잠시 후 다시 시도해주시기 바랍니다.";
		break;
		
	case ERR_GPKI_OCSP_REQ_NOT_GRANTED		:
		ERR_MESSAGE = "OCSP 요청이 승인되지 않았습니다.";
		break;	
		
	case ERR_GPKI_NOT_SIGN_CERT			:
		ERR_MESSAGE = "선택하신 인증서가 서명용인증서가 아닙니다. <br> 인증서를 확인하여 주시기 바랍니다.";
		break;	
					
	case ERR_GPKI_WRONG_URL				:
		ERR_MESSAGE = "URL에서 ://을 찾을 수 없습니다.";
		break;			
		
	// GateWay와의 통신 오류		
	case ERR_GATEWAY_DN_NOT_EXIST			:
		ERR_MESSAGE = "인증서 DN이 일치하지 않습니다.";
		break;
		
	case ERR_GATEWAY_ID_NOT_EXIST			:
		ERR_MESSAGE = "입력하신 ID가 없거나 비밀번호가 일치하지 않습니다.";
		break;
	case ERR_GATEWAY_POID_NO_MATCH			:
		ERR_MESSAGE = "인증서의 POLICY OID가 일치하지 않습니다.";
		break;
		
	case ERR_GATEWAY_PW_NO_MATCH			:
		ERR_MESSAGE = "입력하신 ID가 없거나 비밀번호가 일치하지 않습니다.<br>다시 입력해주시기 바랍니다.";
		break;
			
	case ERR_GATEWAY_LDAP_PROCESS			: 
		ERR_MESSAGE = "LDAP 에서 오류가 발생했습니다.";
		break;
			
	case ERR_GATEWAY_LDAP_GW_INTERNAL		:
		ERR_MESSAGE = "LDAP 게이트웨이에서 내부 오류가 발생했습니다.";
		break;
			
	case ERR_GATEWAY_LDAP_GW_RESP			:
		ERR_MESSAGE = "LDAP 게이트웨이로 접속/응답 시 오류가 발생했습니다.<br>다시 한번 시도해주시기 바랍니다.";
		break;
			
	case ERR_GATEWAY_USER_DISABLE			:
		ERR_MESSAGE = "현재 서비스 중지 상태이므로 서비스를 제공받을 수 없습니다."; 
		break;
			
	case ERR_GATEWAY_USER_WITHDRAW			:
		ERR_MESSAGE = "현재 회원님은 서비스 탈퇴 상태이므로<br>서비스를 제공받을 수 없습니다.";
		break;
			
	case ERR_GATEWAY_USER_REQ_JOIN			:
		ERR_MESSAGE = "현재 가입신청 중입니다.<br>관리자가 가입신청을 허가한 후 사용하시기 바랍니다.";
		break;
			
	case ERR_GATEWAY_PLCY_NO_VALID			:
		ERR_MESSAGE = "사용자 보안정책이 존재하지 않습니다.<br>관리자에게 문의하시기 바랍니다.<br>(Msg:Error = User Policy is Empty)";
		break;
			
	case ERR_GATEWAY_PLCY_NO_AUTHABLE_TIME	:
		ERR_MESSAGE = "허가되지 않은 인증시간대이므로 서비스를 제공할 수 없습니다.<br>(Msg:Error = User use not Authentication Service because Authable time)";
		break;
			
	case ERR_GATEWAY_PLCY_NO_IP_ALLOW		:
		ERR_MESSAGE = "허용 IP대역이 아닙니다.(Msg:Error = User IP is disallowed)";
		break;
		
	case ERR_GATEWAY_CERT_IDENTITY_SYS		:
		ERR_MESSAGE = "인증서의 본인확인 서비스를 진행하는 과정에 시스템 에러가 발생하였습니다.<br>다시 한번 시도해주시기 바랍니다.";
		break;
		
	case ERR_BRIDGE_POLICY_SERVER_TIMEOUT		:
		ERR_MESSAGE = "사용자가 많아 인증서버가 처리하지 못했습니다. <br>잠시 후 다시 시도해주시기 바랍니다.";
		break; 

	case ERR_BRIDGE_SERVER_AGENT_TIMEOUT		:
		ERR_MESSAGE = "사용자가 많아 권한에이전트가 처리하지 못했습니다. <br>잠시 후 다시 시도해주시기 바랍니다.";
		break;
		
	case ERR_MPS_PASSWORD_EXPIRE			:
		ERR_MESSAGE = "비밀번호 유효기간이 지났습니다.<br>관리자에게 문의하여 비밀번호를 변경하셔야 합니다.";
		break;
		
	case ERR_NONE_APP_INFO				:
		ERR_MESSAGE = "접속하려는 시스템 권한정보가 존재하지 않습니다.";
		break;			

	default						:
		{			
			if( varErrCode >= 801 && varErrCode < 1000 )
			{
				ERR_MESSAGE = "인증서 본인확인에 실패하였습니다.<br>다시 한번 시도해주시기 바랍니다.";
			}
			else if( varErrCode >= ERR_GPKI_ALREADY_INITIALIZED &&  varErrCode <= ERR_GPKI_READ_ENTRY ) // GPKI ERROR
			{
				ERR_MESSAGE = "작업중 표준보안 API에서 오류를 발견하였습니다.";
			}
			else
			{
				ERR_MESSAGE = "알 수없는 오류가 발생했습니다.<br>관리자에게 문의하시기 바랍니다.";
			}
		}
		break;	
	}
	ERR_MESSAGE += " [CODE : " + varErrCode + "]"
	return ERR_MESSAGE;
}