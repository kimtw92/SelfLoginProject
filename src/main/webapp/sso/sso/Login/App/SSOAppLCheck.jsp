<%@ page language="java" contentType="text/html; charset=euc-kr" %>
<%@ page import="com.dreamsecurity.eam.gpki.pmi.*, java.io.*, java.lang.*" %>
<%@ page import="java.util.*" %>
<%@ include file="../common/include/SSOInit.jsp" %>
<%
	/*********************************************************************************/
	int 	MG_SUCCESS              = 0;
	int	nRet 		        = 0;
	String 	strMyRefere 		= "";
	String	SERVICE_PAGE_URL 	= "SERVICE_PAGE_URL";
	String 	strServiceURL 		= "";
	String 	MPS_USER_TOKEN		= "Token";
	//strMyRefere = request.getHeader("REFERER");
	//nRet = REFERER_CHECKURL_AK.indexOf(strMyRefere);

	if( nRet < 0 )
	{ 
%>
	<script LANGUAGE='JavaScript'>
	<!--
		parent.document.errorForm.MSG.value = "[경고-R] 불법 접속자 입니다. 본서비스에 허가되지 않은 불법접속 사용자는 법적 제제를 받습니다.";
		parent.document.errorForm.submit();
	-->	
	</script>
<%
		return;
	}
	/*********************************************************************************/
	// 서비스 페이지 URL을 가져온다.
	/*********************************************************************************/
	strServiceURL = (String)session.getAttribute(SERVICE_PAGE_URL);
	
	if( strServiceURL == null || strServiceURL.length() < 1)
	{
%>
		<script LANGUAGE='JavaScript'>
		<!--
			parent.document.errorForm.MSG.value = "서비스 URL 정보가 없습니다.";
			parent.document.errorForm.submit();
		-->	
		</script>
<%
		return ;
	}
	/*********************************************************************************/
	String 	strKey 		= "";		// 세션 키
	String 	strEncLogon 	= "";		// 암호화된 로그인 정보
	String	strToken	= "";		// 사용자 토큰
	String	strEncToken	= "";		// 암호화된 사용자 토큰
	String	strTimeStampNo	= "";		// TimeStamp No
	
	// 사용자 토큰 정보를 받는다.
	strEncLogon = request.getParameter("ED");
	
	if ( strEncLogon == null || strEncLogon.length() < 5 )
	{ 
%>
		<script LANGUAGE='JavaScript'>
		<!--
			parent.document.errorForm.MSG.value = "암호화된 사용자 토큰 정보가 없습니다.";
			parent.document.errorForm.submit();
		-->	
		</script>
<%
		return;
	}
	
	// 세션키정보를 가져와서 데이터를 복호화 한다.
	strKey = (String)session.getAttribute("SKey");
	
	if( strKey == null || strKey.length() < 1 )
	{ 
%>
			<script LANGUAGE='JavaScript'>
			<!--
				parent.document.errorForm.MSG.value = "데이터 암복호화용 세션키 정보가 없습니다.";
				parent.document.errorForm.submit();
			-->	
			</script>
<%
		return;
	}
	/*********************************************************************************/
	
	// 세션키 교환시 발급한 TimeStamp No를 얻는다.
	strTimeStampNo = (String)session.getAttribute("TimeStampNo");
	session.setAttribute("TimeStampNo", " ");
	if( strTimeStampNo == null || strTimeStampNo.length() < 1 )
	{
%>

		<script LANGUAGE='JavaScript'>
		<!--
			parent.document.errorForm.MSG.value = "세션키 교환시 서버에서 발급한 TimeStamp 값이 존재하지않습니다.";
			parent.document.errorForm.submit();
		-->	
		</script>

<%	
		return ;
	}

	/*********************************************************************************/

	try
	{
		// 복호화 하기
		MGApiJni 	mgApi = new MGApiJni();
	
		// 복호화
		//if( (nRet = mgApi.decryptKeyEx(strKey, strEncLogon ,strTimeStampNo, TMIE_STAMP_SEC)) == RET_SUCCESS )
		if( (nRet = mgApi.decryptKeyEx(strKey, strEncLogon, strTimeStampNo)) == 0 )
		{
			strToken = new String(mgApi.getResult());
			
			if (strToken.length() < 1)
			{ 
	%>
				<script LANGUAGE='JavaScript'>
				<!--
					parent.document.errorForm.MSG.value = "복호화된 사용자 정보가 없습니다.";
					parent.document.errorForm.submit();
				-->	
				</script>
	<%
				return;
			}		
			
			// 세션에 토큰을 저장한다.
			session.setAttribute("Token", strToken);		
		}
		else
		{
%>
			<script LANGUAGE='JavaScript'>
			<!--
				parent.document.errorForm.MSG.value = "사용자 정보를 복호화 하는데 실패하였습니다.";
				parent.document.errorForm.submit();
			-->	
			</script>
<%
			return;
		}
/*********************************************************************************/
		//----------------------------------------------------------------//
		// 적용시 테스트 알맞은 한글 변환을 찾는다. 
		//----------------------------------------------------------------//
		strToken = new String (strToken.getBytes("EUC_KR"),"8859_1");

		// 토큰에서 각 아이템 정보를 얻는다.
		if( mgApi.setToken(strToken) == MG_SUCCESS )
		{
			String	MPS_USER_ID 		= "USERID";     	// SSO 사용자 ID
			String	MPS_USER_EMAIL 		= "USEREMAIL";  	// SSO 사용자 Email			
			String	MPS_USER_USERNAME 	= "USERNAME";   	// SSO 사용자 NAME
			/****

			String	MPS_EMP_NO 	        = "EMPNO";      	// SSO 사원(공무원)번호

			String	MPS_USER_TEL 		= "USERTEL";    	// SSO 사용자 Tel
			String	MPS_DEPT_ID 		= "DEPTID";     	// SSO 부서 ID
			String	MPS_DEPT_NAME 		= "DEPTNAME";   	// SSO 부서 NAME
			String	MPS_DEPT_TEL 		= "DEPTTEL";    	// SSO 부서 Tel
			String	MPS_SIDO_NAME 		= "SIDONAME";   	// 시도이름
			String	MPS_SIDO_CODE 		= "SIDOCODE";   	// 시도코드
			String	MPS_SIDO_GBN 		= "SIDOGUBUN";   	// 시도구분
			String	MPS_APP_CODE 		= "APPLCODE";   	// app code
			String	MPS_SERVICE_GBN 	= "SERVICEGBN"; 	// 시도 구분코드 : appcode와 1대1 매칭됨
			****/            
		                                                                                                  
			String	strUserID 		= "";				// SSO 사용자 ID
			String	strUserName 		= "";				// SSO 사용자 NAME
			String	strUserEmail 		= "";				// SSO 사용자 Email
			/****
			String	strUserName 		= "";				// SSO 사용자 NAME
			String	strEmpNo 		= "";				// SSO 사원(공무원)번호 

			String	strUserTel 		= "";				// SSO 사용자 Tel
			String	strDeptID 		= "";				// SSO 부서 ID
			String	strDeptName 		= "";				// SSO 부서 NAME
			String	strDeptTel 		= "";				// SSO 부서 Tel
			String	strSidoName 		= "";				// 시도이름
			String	strSidoCode 		= "";				// 시도코드
			String	strSidoGbn 		= "";				// 시도구분
			String	strAppCode 		= "";				// app code
			String	strServiceGbn 		= "";				// 시도 구분코드 : appcode와 1대1 매칭됨
			****/
	
			// 사용자 정보 추출하기
			strUserID 	= mgApi.getID();	// SSO 사용자 ID
			strUserName 	= mgApi.getName();	// SSO 사용자 NAME	
			strUserEmail 	= mgApi.getEMail();	// SSO 사용자 Email
			/****
			strUserName 	= mgApi.getName();	// SSO 사용자 NAME
			strEmpNo 	= mgApi.getEmpNo();     // SSO 사원(공무원)번호 

			strUserTel 	= mgApi.getUserTel();	// SSO 사용자 Tel
			strDeptID 	= mgApi.getDeptCode();	// SSO 부서 ID
			strDeptName 	= mgApi.getDeptName();	// SSO 부서 NAME
			strDeptTel 	= mgApi.getDeptTel();	// SSO 부서 Tel
			strSidoCode 	= mgApi.getSidoCode();	// 시도코드
			strSidoName 	= mgApi.getSidoName();	// 시도이름
			strSidoGbn 	= mgApi.getSidoGubun(); // 시도구분 0:광역시,특별시, 1: 일반도, 2:시군구
			strAppCode 	= mgApi.getAppCode();	// app code
			strServiceGbn 	= (String)session.getAttribute(MPS_SERVICE_GBN);	// 시도 구분코드 : appcode와 1대1 매칭됨
			****/
			
	       	        //if( strServiceGbn == null )
	       		    //strServiceGbn = " ";
            
                        /****
			session.setAttribute(MPS_USER_ID, 	new String (strUserID.getBytes("8859_1"),"EUC_KR"));

			//session.setAttribute(MPS_USER_USERNAME, new String (strUserName.getBytes("8859_1"),"EUC_KR"));
			session.setAttribute(MPS_EMP_NO, new String (strEmpNo.getBytes("8859_1"),"EUC_KR"));
			session.setAttribute(MPS_USER_EMAIL, 	new String (strUserEmail.getBytes("8859_1"),"EUC_KR"));
			session.setAttribute(MPS_USER_TEL, 	new String (strUserTel.getBytes("8859_1"),"EUC_KR"));
			session.setAttribute(MPS_DEPT_ID, 	new String (strDeptID.getBytes("8859_1"),"EUC_KR"));
			session.setAttribute(MPS_DEPT_NAME, 	new String (strDeptName.getBytes("8859_1"),"EUC_KR"));
			session.setAttribute(MPS_DEPT_TEL, 	new String (strDeptTel.getBytes("8859_1"),"EUC_KR"));
			session.setAttribute(MPS_SIDO_NAME, 	new String (strSidoName.getBytes("8859_1"),"EUC_KR"));
			session.setAttribute(MPS_SIDO_CODE, 	new String (strSidoCode.getBytes("8859_1"),"EUC_KR"));
			session.setAttribute(MPS_SIDO_GBN, 	new String (strSidoGbn.getBytes("8859_1"),"EUC_KR"));
			session.setAttribute(MPS_SERVICE_GBN, 	new String (strServiceGbn.getBytes("8859_1"),"EUC_KR"));
			session.setAttribute(MPS_APP_CODE, 	new String (strAppCode.getBytes("8859_1"),"EUC_KR"));
			session.setAttribute(MPS_EMP_NO, 	strEmpNo);
                        ****/
                        /****
			session.setAttribute(MPS_USER_ID, 	strUserID);
			session.setAttribute(MPS_USER_USERNAME, strUserName);

			session.setAttribute(MPS_USER_TEL, 	strUserTel);
			session.setAttribute(MPS_DEPT_ID, 	strDeptID);
			session.setAttribute(MPS_DEPT_NAME, 	strDeptName);
			session.setAttribute(MPS_DEPT_TEL, 	strDeptTel);
			session.setAttribute(MPS_SIDO_NAME, 	strSidoName);
			session.setAttribute(MPS_SIDO_CODE, 	strSidoCode);
			session.setAttribute(MPS_SIDO_GBN, 	strSidoGbn);
			session.setAttribute(MPS_SERVICE_GBN, 	strServiceGbn);
			session.setAttribute(MPS_APP_CODE, 	strAppCode);
			
			// 토큰 정보를 세션에 저장한다.	
			strToken = new String (strToken.getBytes("8859_1"),"EUC_KR");
			session.setAttribute(MPS_USER_TOKEN, strToken);
                        ****/
                        
                        // 사용자아이디 세션 생성
			session.setAttribute("sess_resno", strUserID);
			session.setAttribute(MPS_USER_USERNAME, strUserName);
			session.setAttribute(MPS_USER_EMAIL, 	strUserEmail);
            //System.out.println("[SSO] ID:" + strUserID);
		
			// 최종 서비스 페이지로 이동하기
%>
			<script LANGUAGE='JavaScript'>
			<!--
				parent.document.location.href = "<%=strServiceURL%>";
			-->	
			</script>
<%
			return;
		}
		else
		{
%>
			<script LANGUAGE='JavaScript'>
			<!--
				parent.document.errorForm.MSG.value = "토큰 정보분석중 에러가 발생하였습니다.";
				parent.document.errorForm.submit();
			-->	
			</script>
<%
			return;
		}
	}
	catch(Exception e)
	{
	}
%>

