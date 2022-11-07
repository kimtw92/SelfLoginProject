////////////////////////////////////////////////////////////////////////////////
// 				ERROR CODE DEFINE
////////////////////////////////////////////////////////////////////////////////

var ERR_MEMORY_MAP_CREATE		=	100;
var ERR_MEMORY_MAP_READ			=	101;
var ERR_MEMORY_MAP_EXIST		=	102;
var ERR_MPS_NONE_EXECUTE		=	103;

// Comunication Error
var ERR_MPS_RECV_DATA			=	200;	// ���� ������ ����
var ERR_MPS_RECV_DATA_OVERFLOW	=	201;	// ���ŵ� �����Ͱ� �ʹ� Ů�ϴ�.
var ERR_MPS_RECV_DATA_MIN		=	202;	// ���ŵ� �����Ͱ� �ʹ� �۽��ϴ�.
var ERR_MPS_NONE_CONNECTION		=	203;	// ���� ������ �����ϴ�.
var ERR_MPS_NONE_TRANSERVER		=	204; 	// TranServer ������ �����ϴ�.
var ERR_MPS_POLICY_CONFIG		=	205; 	// Policy server�� ���� Config ������ ���� ���� ���Ͽ����ϴ�. Connection Ȯ��
var ERR_MPS_POLICY_ACL			=	206; 	// Policy Server�� ���� ACL ������ ���� ���� ���Ͽ����ϴ�. 
var ERR_MPS_INPUT_ID			=	207; 	// �Է��Ͻ� ID�� Ȯ�ιٶ��ϴ�.
var ERR_MPS_INPUT_PASSWORD		=	208; 	// �Է��Ͻ� PW�� Ȯ�ιٶ��ϴ�.
var ERR_MPS_MESSAGE_HEADER		=	209;	// �������� ���� �� Message�� ���� ������ �߸��Ǿ����ϴ�.
var ERR_MPS_LOGOUT_STATUS		=	210;	// Logout Status
var ERR_MPS_TRAN_SERVER_CERT	=	211;	// Tran Server�� ���� ������. ���� IP������ ���� ���Ͽ����ϴ�.
var ERR_MPS_SESSION_KEY			=	212;	// Tran Server�� ���� Ű ��ȯ�� �����Ͽ����ϴ�.
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
/* Bridge Page���� �������� */
//-----------------------------------------------------------//
var ERR_BRIDGE_POLICY_SERVER_TIMEOUT	= 	700;	// Policy server ���� Ÿ�Ӿƿ� 
var ERR_BRIDGE_SERVER_AGENT_TIMEOUT		= 	701;	// Tran Server ���� Ÿ�Ӿƿ� 


//-----------------------------------------------------------//
/* GPKI API ERROR CODE */
//-----------------------------------------------------------//
var ERR_GPKI_EXPIRED_CERT			= 	1203		// "�ش� �������� ��ȿ�Ⱓ�� ����Ǿ����ϴ�. <br> ��߱� �޽ýñ�ٶ��ϴ�."	
var ERR_GPKI_WRONG_CRL				= 	1211		// "�߸��� ������ ���� ���(CRL)�Դϴ�."	
var ERR_GPKI_EXPIRED_CRL			= 	1212		// "��ȿ�Ⱓ�� ����� ������ ���� ���(CRL)�Դϴ�."	
var ERR_GPKI_HOLDED_CERT			= 	1214		// "ȿ�������� ������ �Դϴ�."	
var ERR_GPKI_REVOKED_CERT			= 	1215		// "������ ������ �Դϴ�."	
var ERR_GPKI_CONNECT_OCSP			= 	1216		// "OCSP ������ �����ϴµ� �����Ͽ����ϴ�."	
var ERR_GPKI_OCSP_REQ_NOT_GRANTED	= 	1221		// "OCSP ��û�� ���ε��� �ʾҽ��ϴ�."	
var ERR_GPKI_NOT_SIGN_CERT			= 	1510		// "�����Ͻ� �������� ������������� �ƴմϴ�."	
var ERR_GPKI_WRONG_URL				= 	2000		// "URL���� ://�� ã�� �� �����ϴ�."	

//-----------------------------------------------------------//
// GPKIAPI RETURN ERROR
//-----------------------------------------------------------//
var ERR_GPKI_ALREADY_INITIALIZED	= 	1000;
var ERR_GPKI_READ_ENTRY				= 	2013;


//-----------------------------------------------------------//
// DB(DS) Gateway �����ڵ� ����
//-----------------------------------------------------------//
var ERR_GATEWAY_DN_NOT_EXIST			= 	10000;
var ERR_GATEWAY_ID_NOT_EXIST			= 	10001;
var ERR_GATEWAY_POID_NO_MATCH			= 	10002;
var ERR_GATEWAY_PW_NO_MATCH				= 	10003;
var ERR_GATEWAY_USER_DISABLE			= 	10010;    // ��������
var ERR_GATEWAY_USER_WITHDRAW			= 	10011;    // ����Ż��
var ERR_GATEWAY_USER_REQ_JOIN			= 	10012;    // ���Խ�û
var ERR_GATEWAY_PLCY_NO_VALID			= 	10020;    // ����ں�����å�� ����(Msg:Error = User Policy is Empty)
var ERR_GATEWAY_PLCY_NO_AUTHABLE_TIME	= 	10021;   // �����ð����̿��ǽð��������䱸��(Msg:Error = User use not Authentication Service because Authable time)
var ERR_GATEWAY_PLCY_NO_IP_ALLOW		= 	10022;   // ���IP�뿪�̾ƴѰ��(Msg:Error = User IP is disallowed)
var ERR_GATEWAY_LDAP_PROCESS			= 	10100;    // LDAP���� 
var ERR_GATEWAY_LDAP_GW_INTERNAL		= 	10101;    // LDAP����Ʈ���� ���� ����
var ERR_GATEWAY_LDAP_GW_RESP			= 	10102;    // LDAP����Ʈ���� ���� �Ǵ� ���信��
var ERR_GATEWAY_CERT_IDENTITY_SYS		= 	800;

////////////////////////////////////////////////////////////////
// 				ERROR CODE REPORT

function ErrorMsg(varErrCode)
{
	var ERR_MESSAGE = ""

	switch( varErrCode )
	{
	case ERR_MEMORY_MAP_CREATE			:
		ERR_MESSAGE = "�����н��� ��û���� �ʱ�ȭ�� �����Ͽ����ϴ�.";
		break;

	case ERR_MEMORY_MAP_READ			:
		ERR_MESSAGE = "�����н��� ���� ���ſ� �����Ͽ����ϴ�.";
		break;

	case ERR_MEMORY_MAP_EXIST			:
		ERR_MESSAGE = "�����н��� ��û������ �����µ� �����Ͽ����ϴ�.";
		break;

	case ERR_MPS_NONE_EXECUTE			:
		ERR_MESSAGE = "�����н��� �⵿���� ���� �� �ֽ��ϴ�.<br>�����н� Ʈ���� �������� Ȯ�����ּ���.";
		break;

	case ERR_MPS_RECV_DATA				:
		ERR_MESSAGE = "���� ������ �����Դϴ�.<br>�����κ��� �߸��� ������ �޾ҽ��ϴ�.";
		break;

	case ERR_MPS_RECV_DATA_OVERFLOW		:	
		ERR_MESSAGE = "���� ������ �����Դϴ�.<br>���ŵ� �����Ͱ� �ʹ� Ů�ϴ�.";
		break;

	case ERR_MPS_RECV_DATA_MIN			:	
		ERR_MESSAGE = "���� ������ �����Դϴ�.<br>���ŵ� �����Ͱ� �ʹ� �۽��ϴ�.";
		break;

	case ERR_MPS_NONE_CONNECTION		:	
		ERR_MESSAGE = "��û�Ͻ� ���������� ���� ������ �������� �ʽ��ϴ�.";
		break;

	case ERR_MPS_NONE_TRANSERVER		:
		ERR_MESSAGE = "�����Ϸ��� ����Ʈ�� ���� ������ �����ϴ�.<br>(����� ��ū�� ���ø����̼� ������ �����ϴ�.)";
		break;

	case ERR_MPS_POLICY_CONFIG			:
		ERR_MESSAGE = "���������κ��� CONFIG ������ ���� ���Ͽ����ϴ�.<br>(���������� ������� ���� �� �ֽ��ϴ�.)";
		break;

	case ERR_MPS_POLICY_ACL				: 
		ERR_MESSAGE = "���������κ��� ACL ������ ���� ���� ���Ͽ����ϴ�.";
		break;

	case ERR_MPS_INPUT_ID				:
		ERR_MESSAGE = "�Է��Ͻ� ���̵� ����ҿ� �������� �ʽ��ϴ�.<br>�ٽ� �ѹ� Ȯ�����ּ���.";
		break;

	case ERR_MPS_INPUT_PASSWORD			:
		ERR_MESSAGE = "�Է��Ͻ� ��й�ȣ�� ��Ȯ���� �ʽ��ϴ�.<br>�ٽ� �ѹ� Ȯ�����ּ���.";
		break;

	case ERR_MPS_MESSAGE_HEADER			:
		ERR_MESSAGE = "�������� ���� �� �޽��� ��� ������ ������ �����ϰ� �ֽ��ϴ�.";
		break;

	case ERR_MPS_LOGOUT_STATUS			:
		ERR_MESSAGE = "���� �α׾ƿ� �����Դϴ�.<br>�α��� �� ������ �����Ͻñ� �ٶ��ϴ�.";
		break;

	case ERR_MPS_TRAN_SERVER_CERT		:
		ERR_MESSAGE = "���ø����̼� ������ ���� Ű ��ȯ�� ���� ���Ǵ�<br>������������ ���� ���Ͽ����ϴ�.";
		break;

	case ERR_MPS_SESSION_KEY			:
		ERR_MESSAGE = "����������Ʈ�� ���� Ű ��ȯ�� �����Ͽ����ϴ�.";
		break;

	case ERR_MPS_SYSTEM_NETWORK			:
		ERR_MESSAGE = "�ý��� Ȥ�� ��Ʈ�� ��ְ� �߻��Ͽ� ���� ���ῡ �����Ͽ����ϴ�.";
		break;

	case ERR_MPS_NONE_MUTEX				:
		ERR_MESSAGE = "����Ʈ ������ �������� �ʽ��ϴ�.";
		break;
		
	case ERR_MPS_NONE_SESSION_KEY			:
		ERR_MESSAGE = "����Ű�� �������� �ʽ��ϴ�.";
		break;

	// GPKI API ����(��������������)
	case ERR_GPKI_EXPIRED_CERT			:
		ERR_MESSAGE = "�ش� �������� ��ȿ�Ⱓ�� ����Ǿ����ϴ�. <br>�������� ��߱� ��������.";
		break;
			
	case ERR_GPKI_WRONG_CRL				:
		ERR_MESSAGE = "�߸��� ������ ���� ���(CRL)�Դϴ�.";
		break;
		
	case ERR_GPKI_EXPIRED_CRL			:
		ERR_MESSAGE = "��ȿ�Ⱓ�� ����� ������ ���� ���(CRL)�Դϴ�.";
		break;

	case ERR_GPKI_HOLDED_CERT			:
		ERR_MESSAGE = "ȿ�������� ������ �Դϴ�.";
		break;
		
	case ERR_GPKI_REVOKED_CERT			:
		ERR_MESSAGE = "������ ������ �Դϴ�. <br>�������� ��߱� ��������.";
		break;		
						
	case ERR_GPKI_CONNECT_OCSP			:
		ERR_MESSAGE = "OCSP ������ �����ϴµ� �����Ͽ����ϴ�. <br>��� �� �ٽ� �õ����ֽñ� �ٶ��ϴ�.";
		break;
		
	case ERR_GPKI_OCSP_REQ_NOT_GRANTED		:
		ERR_MESSAGE = "OCSP ��û�� ���ε��� �ʾҽ��ϴ�.";
		break;	
		
	case ERR_GPKI_NOT_SIGN_CERT			:
		ERR_MESSAGE = "�����Ͻ� �������� ������������� �ƴմϴ�. <br> �������� Ȯ���Ͽ� �ֽñ� �ٶ��ϴ�.";
		break;	
					
	case ERR_GPKI_WRONG_URL				:
		ERR_MESSAGE = "URL���� ://�� ã�� �� �����ϴ�.";
		break;			
		
	// GateWay���� ��� ����		
	case ERR_GATEWAY_DN_NOT_EXIST			:
		ERR_MESSAGE = "������ DN�� ��ġ���� �ʽ��ϴ�.";
		break;
		
	case ERR_GATEWAY_ID_NOT_EXIST			:
		ERR_MESSAGE = "�Է��Ͻ� ID�� ���ų� ��й�ȣ�� ��ġ���� �ʽ��ϴ�.";
		break;
	case ERR_GATEWAY_POID_NO_MATCH			:
		ERR_MESSAGE = "�������� POLICY OID�� ��ġ���� �ʽ��ϴ�.";
		break;
		
	case ERR_GATEWAY_PW_NO_MATCH			:
		ERR_MESSAGE = "�Է��Ͻ� ID�� ���ų� ��й�ȣ�� ��ġ���� �ʽ��ϴ�.<br>�ٽ� �Է����ֽñ� �ٶ��ϴ�.";
		break;
			
	case ERR_GATEWAY_LDAP_PROCESS			: 
		ERR_MESSAGE = "LDAP ���� ������ �߻��߽��ϴ�.";
		break;
			
	case ERR_GATEWAY_LDAP_GW_INTERNAL		:
		ERR_MESSAGE = "LDAP ����Ʈ���̿��� ���� ������ �߻��߽��ϴ�.";
		break;
			
	case ERR_GATEWAY_LDAP_GW_RESP			:
		ERR_MESSAGE = "LDAP ����Ʈ���̷� ����/���� �� ������ �߻��߽��ϴ�.<br>�ٽ� �ѹ� �õ����ֽñ� �ٶ��ϴ�.";
		break;
			
	case ERR_GATEWAY_USER_DISABLE			:
		ERR_MESSAGE = "���� ���� ���� �����̹Ƿ� ���񽺸� �������� �� �����ϴ�."; 
		break;
			
	case ERR_GATEWAY_USER_WITHDRAW			:
		ERR_MESSAGE = "���� ȸ������ ���� Ż�� �����̹Ƿ�<br>���񽺸� �������� �� �����ϴ�.";
		break;
			
	case ERR_GATEWAY_USER_REQ_JOIN			:
		ERR_MESSAGE = "���� ���Խ�û ���Դϴ�.<br>�����ڰ� ���Խ�û�� �㰡�� �� ����Ͻñ� �ٶ��ϴ�.";
		break;
			
	case ERR_GATEWAY_PLCY_NO_VALID			:
		ERR_MESSAGE = "����� ������å�� �������� �ʽ��ϴ�.<br>�����ڿ��� �����Ͻñ� �ٶ��ϴ�.<br>(Msg:Error = User Policy is Empty)";
		break;
			
	case ERR_GATEWAY_PLCY_NO_AUTHABLE_TIME	:
		ERR_MESSAGE = "�㰡���� ���� �����ð����̹Ƿ� ���񽺸� ������ �� �����ϴ�.<br>(Msg:Error = User use not Authentication Service because Authable time)";
		break;
			
	case ERR_GATEWAY_PLCY_NO_IP_ALLOW		:
		ERR_MESSAGE = "��� IP�뿪�� �ƴմϴ�.(Msg:Error = User IP is disallowed)";
		break;
		
	case ERR_GATEWAY_CERT_IDENTITY_SYS		:
		ERR_MESSAGE = "�������� ����Ȯ�� ���񽺸� �����ϴ� ������ �ý��� ������ �߻��Ͽ����ϴ�.<br>�ٽ� �ѹ� �õ����ֽñ� �ٶ��ϴ�.";
		break;
		
	case ERR_BRIDGE_POLICY_SERVER_TIMEOUT		:
		ERR_MESSAGE = "����ڰ� ���� ���������� ó������ ���߽��ϴ�. <br>��� �� �ٽ� �õ����ֽñ� �ٶ��ϴ�.";
		break; 

	case ERR_BRIDGE_SERVER_AGENT_TIMEOUT		:
		ERR_MESSAGE = "����ڰ� ���� ���ѿ�����Ʈ�� ó������ ���߽��ϴ�. <br>��� �� �ٽ� �õ����ֽñ� �ٶ��ϴ�.";
		break;
		
	case ERR_MPS_PASSWORD_EXPIRE			:
		ERR_MESSAGE = "��й�ȣ ��ȿ�Ⱓ�� �������ϴ�.<br>�����ڿ��� �����Ͽ� ��й�ȣ�� �����ϼž� �մϴ�.";
		break;
		
	case ERR_NONE_APP_INFO				:
		ERR_MESSAGE = "�����Ϸ��� �ý��� ���������� �������� �ʽ��ϴ�.";
		break;			

	default						:
		{			
			if( varErrCode >= 801 && varErrCode < 1000 )
			{
				ERR_MESSAGE = "������ ����Ȯ�ο� �����Ͽ����ϴ�.<br>�ٽ� �ѹ� �õ����ֽñ� �ٶ��ϴ�.";
			}
			else if( varErrCode >= ERR_GPKI_ALREADY_INITIALIZED &&  varErrCode <= ERR_GPKI_READ_ENTRY ) // GPKI ERROR
			{
				ERR_MESSAGE = "�۾��� ǥ�غ��� API���� ������ �߰��Ͽ����ϴ�.";
			}
			else
			{
				ERR_MESSAGE = "�� ������ ������ �߻��߽��ϴ�.<br>�����ڿ��� �����Ͻñ� �ٶ��ϴ�.";
			}
		}
		break;	
	}
	ERR_MESSAGE += " [CODE : " + varErrCode + "]"
	return ERR_MESSAGE;
}