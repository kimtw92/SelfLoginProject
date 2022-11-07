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
		parent.document.errorForm.MSG.value = "[���-R] �ҹ� ������ �Դϴ�. �����񽺿� �㰡���� ���� �ҹ����� ����ڴ� ���� ������ �޽��ϴ�.";
		parent.document.errorForm.submit();
	-->	
	</script>
<%
		return;
	}
	/*********************************************************************************/
	// ���� ������ URL�� �����´�.
	/*********************************************************************************/
	strServiceURL = (String)session.getAttribute(SERVICE_PAGE_URL);
	
	if( strServiceURL == null || strServiceURL.length() < 1)
	{
%>
		<script LANGUAGE='JavaScript'>
		<!--
			parent.document.errorForm.MSG.value = "���� URL ������ �����ϴ�.";
			parent.document.errorForm.submit();
		-->	
		</script>
<%
		return ;
	}
	/*********************************************************************************/
	String 	strKey 		= "";		// ���� Ű
	String 	strEncLogon 	= "";		// ��ȣȭ�� �α��� ����
	String	strToken	= "";		// ����� ��ū
	String	strEncToken	= "";		// ��ȣȭ�� ����� ��ū
	String	strTimeStampNo	= "";		// TimeStamp No
	
	// ����� ��ū ������ �޴´�.
	strEncLogon = request.getParameter("ED");
	
	if ( strEncLogon == null || strEncLogon.length() < 5 )
	{ 
%>
		<script LANGUAGE='JavaScript'>
		<!--
			parent.document.errorForm.MSG.value = "��ȣȭ�� ����� ��ū ������ �����ϴ�.";
			parent.document.errorForm.submit();
		-->	
		</script>
<%
		return;
	}
	
	// ����Ű������ �����ͼ� �����͸� ��ȣȭ �Ѵ�.
	strKey = (String)session.getAttribute("SKey");
	
	if( strKey == null || strKey.length() < 1 )
	{ 
%>
			<script LANGUAGE='JavaScript'>
			<!--
				parent.document.errorForm.MSG.value = "������ �Ϻ�ȣȭ�� ����Ű ������ �����ϴ�.";
				parent.document.errorForm.submit();
			-->	
			</script>
<%
		return;
	}
	/*********************************************************************************/
	
	// ����Ű ��ȯ�� �߱��� TimeStamp No�� ��´�.
	strTimeStampNo = (String)session.getAttribute("TimeStampNo");
	session.setAttribute("TimeStampNo", " ");
	if( strTimeStampNo == null || strTimeStampNo.length() < 1 )
	{
%>

		<script LANGUAGE='JavaScript'>
		<!--
			parent.document.errorForm.MSG.value = "����Ű ��ȯ�� �������� �߱��� TimeStamp ���� ���������ʽ��ϴ�.";
			parent.document.errorForm.submit();
		-->	
		</script>

<%	
		return ;
	}

	/*********************************************************************************/

	try
	{
		// ��ȣȭ �ϱ�
		MGApiJni 	mgApi = new MGApiJni();
	
		// ��ȣȭ
		//if( (nRet = mgApi.decryptKeyEx(strKey, strEncLogon ,strTimeStampNo, TMIE_STAMP_SEC)) == RET_SUCCESS )
		if( (nRet = mgApi.decryptKeyEx(strKey, strEncLogon, strTimeStampNo)) == 0 )
		{
			strToken = new String(mgApi.getResult());
			
			if (strToken.length() < 1)
			{ 
	%>
				<script LANGUAGE='JavaScript'>
				<!--
					parent.document.errorForm.MSG.value = "��ȣȭ�� ����� ������ �����ϴ�.";
					parent.document.errorForm.submit();
				-->	
				</script>
	<%
				return;
			}		
			
			// ���ǿ� ��ū�� �����Ѵ�.
			session.setAttribute("Token", strToken);		
		}
		else
		{
%>
			<script LANGUAGE='JavaScript'>
			<!--
				parent.document.errorForm.MSG.value = "����� ������ ��ȣȭ �ϴµ� �����Ͽ����ϴ�.";
				parent.document.errorForm.submit();
			-->	
			</script>
<%
			return;
		}
/*********************************************************************************/
		//----------------------------------------------------------------//
		// ����� �׽�Ʈ �˸��� �ѱ� ��ȯ�� ã�´�. 
		//----------------------------------------------------------------//
		strToken = new String (strToken.getBytes("EUC_KR"),"8859_1");

		// ��ū���� �� ������ ������ ��´�.
		if( mgApi.setToken(strToken) == MG_SUCCESS )
		{
			String	MPS_USER_ID 		= "USERID";     	// SSO ����� ID
			String	MPS_USER_EMAIL 		= "USEREMAIL";  	// SSO ����� Email			
			String	MPS_USER_USERNAME 	= "USERNAME";   	// SSO ����� NAME
			/****

			String	MPS_EMP_NO 	        = "EMPNO";      	// SSO ���(������)��ȣ

			String	MPS_USER_TEL 		= "USERTEL";    	// SSO ����� Tel
			String	MPS_DEPT_ID 		= "DEPTID";     	// SSO �μ� ID
			String	MPS_DEPT_NAME 		= "DEPTNAME";   	// SSO �μ� NAME
			String	MPS_DEPT_TEL 		= "DEPTTEL";    	// SSO �μ� Tel
			String	MPS_SIDO_NAME 		= "SIDONAME";   	// �õ��̸�
			String	MPS_SIDO_CODE 		= "SIDOCODE";   	// �õ��ڵ�
			String	MPS_SIDO_GBN 		= "SIDOGUBUN";   	// �õ�����
			String	MPS_APP_CODE 		= "APPLCODE";   	// app code
			String	MPS_SERVICE_GBN 	= "SERVICEGBN"; 	// �õ� �����ڵ� : appcode�� 1��1 ��Ī��
			****/            
		                                                                                                  
			String	strUserID 		= "";				// SSO ����� ID
			String	strUserName 		= "";				// SSO ����� NAME
			String	strUserEmail 		= "";				// SSO ����� Email
			/****
			String	strUserName 		= "";				// SSO ����� NAME
			String	strEmpNo 		= "";				// SSO ���(������)��ȣ 

			String	strUserTel 		= "";				// SSO ����� Tel
			String	strDeptID 		= "";				// SSO �μ� ID
			String	strDeptName 		= "";				// SSO �μ� NAME
			String	strDeptTel 		= "";				// SSO �μ� Tel
			String	strSidoName 		= "";				// �õ��̸�
			String	strSidoCode 		= "";				// �õ��ڵ�
			String	strSidoGbn 		= "";				// �õ�����
			String	strAppCode 		= "";				// app code
			String	strServiceGbn 		= "";				// �õ� �����ڵ� : appcode�� 1��1 ��Ī��
			****/
	
			// ����� ���� �����ϱ�
			strUserID 	= mgApi.getID();	// SSO ����� ID
			strUserName 	= mgApi.getName();	// SSO ����� NAME	
			strUserEmail 	= mgApi.getEMail();	// SSO ����� Email
			/****
			strUserName 	= mgApi.getName();	// SSO ����� NAME
			strEmpNo 	= mgApi.getEmpNo();     // SSO ���(������)��ȣ 

			strUserTel 	= mgApi.getUserTel();	// SSO ����� Tel
			strDeptID 	= mgApi.getDeptCode();	// SSO �μ� ID
			strDeptName 	= mgApi.getDeptName();	// SSO �μ� NAME
			strDeptTel 	= mgApi.getDeptTel();	// SSO �μ� Tel
			strSidoCode 	= mgApi.getSidoCode();	// �õ��ڵ�
			strSidoName 	= mgApi.getSidoName();	// �õ��̸�
			strSidoGbn 	= mgApi.getSidoGubun(); // �õ����� 0:������,Ư����, 1: �Ϲݵ�, 2:�ñ���
			strAppCode 	= mgApi.getAppCode();	// app code
			strServiceGbn 	= (String)session.getAttribute(MPS_SERVICE_GBN);	// �õ� �����ڵ� : appcode�� 1��1 ��Ī��
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
			
			// ��ū ������ ���ǿ� �����Ѵ�.	
			strToken = new String (strToken.getBytes("8859_1"),"EUC_KR");
			session.setAttribute(MPS_USER_TOKEN, strToken);
                        ****/
                        
                        // ����ھ��̵� ���� ����
			session.setAttribute("sess_resno", strUserID);
			session.setAttribute(MPS_USER_USERNAME, strUserName);
			session.setAttribute(MPS_USER_EMAIL, 	strUserEmail);
            //System.out.println("[SSO] ID:" + strUserID);
		
			// ���� ���� �������� �̵��ϱ�
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
				parent.document.errorForm.MSG.value = "��ū �����м��� ������ �߻��Ͽ����ϴ�.";
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

