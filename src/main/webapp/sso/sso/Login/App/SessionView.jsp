<%@ page language="java" contentType="text/html; charset=euc-kr" %>
<%@ page import="com.dreamsecurity.eam.gpki.pmi.*, java.util.*, java.io.*, java.lang.*, java.text.*" %>
<%@ page import="java.util.*" %>

<%
	/*
	String strCompCode = "�λ걤����";
	String strIP = "103.22.252.18";
	int    nPort = 40010;
        MGApiJni pmi = new MGApiJni();
	pmi.init(strCompCode, strIP, nPort);
	int nRet = pmi.getApplListByID("7110221022102");
	if( nRet == 0 )
	{
		out.println("Success GetApplListByID...");
		out.println(pmi.getResult());
	}
	else
	{
		out.println("Failed GetApplListByID...");
	}
	out.println("<br>");
	*/

	String	MPS_USER_ID 		= "USERID";     	// SSO ����� ID                           
	String	MPS_USER_USERNAME 	= "USERNAME";   	// SSO ����� NAME                       
	String	MPS_EMP_NO 	        = "EMPNO";   	        // SSO ���(������)��ȣ 
	String	MPS_USER_EMAIL 		= "USEREMAIL";  	// SSO ����� Email                      
	String	MPS_USER_TEL 		= "USERTEL";    	// SSO ����� Tel                             
	String	MPS_DEPT_ID 		= "DEPTID";     	// SSO �μ� ID                            
	String	MPS_DEPT_NAME 		= "DEPTNAME";   	// SSO �μ� NAME                             
	String	MPS_DEPT_TEL 		= "DEPTTEL";    	// SSO �μ� Tel                                
	String	MPS_SIDO_NAME 		= "SIDONAME";   	// �õ��̸�                                    
	String	MPS_SIDO_CODE 		= "SIDOCODE";   	// �õ��ڵ�                                    
	String	MPS_SIDO_GBN 		= "SIDOGUBUN";   	// �õ��ڵ�                                    
	String	MPS_SERVICE_GBN 	= "SERVICEGBN"; 	// �õ� �����ڵ� : appcode�� 1��1 ��Ī��            
	String	MPS_APP_CODE 		= "APPLCODE";   	// app code                                   
%>
<HTML>
<HEAD>
<TITLE>:::: SSO �������� �׽�Ʈ ::::</TITLE>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
</HEAD>

<body>
�������� ���� �׽�Ʈ ������ �Դϴ�. ^^
<br>				session.getAttribute(token)        : <%= session.getAttribute("Token")%> 		
<br>				session.getAttribute(MPS_USER_ID)        : <%= session.getAttribute(MPS_USER_ID)%> 		
<br>				session.getAttribute(MPS_USER_USERNAME)  : <%= session.getAttribute(MPS_USER_USERNAME)%> 		      
<br>				session.getAttribute(MPS_EMP_NO)  : <%= session.getAttribute(MPS_EMP_NO)%> 		      
<br>				session.getAttribute(MPS_USER_EMAIL) 	 : <%= session.getAttribute(MPS_USER_EMAIL)%> 		      
<br>				session.getAttribute(MPS_USER_TEL) 		 : <%= session.getAttribute(MPS_USER_TEL)%> 		      
<br>				session.getAttribute(MPS_DEPT_ID) 		 : <%= session.getAttribute(MPS_DEPT_ID)%> 		      
<br>				session.getAttribute(MPS_DEPT_NAME) 	 : <%= session.getAttribute(MPS_DEPT_NAME)%> 		      
<br>				session.getAttribute(MPS_DEPT_TEL) 		 : <%= session.getAttribute(MPS_DEPT_TEL)%> 		      
<br>				session.getAttribute(MPS_SIDO_NAME) 	 : <%= session.getAttribute(MPS_SIDO_NAME)%> 		      
<br>				session.getAttribute(MPS_SIDO_CODE) 	 : <%= session.getAttribute(MPS_SIDO_CODE)%> 		      
<br>				session.getAttribute(MPS_SIDO_GBN) 	 	 : <%= session.getAttribute(MPS_SIDO_GBN)%> 		      
<br>				session.getAttribute(MPS_SERVICE_GBN) 	 : <%= session.getAttribute(MPS_SERVICE_GBN)%> 		      
<br>				session.getAttribute(MPS_APP_CODE) 		 : <%= session.getAttribute(MPS_APP_CODE)%> 		      
<br>
sess_resno:<%=session.getAttribute("sess_resno")%>
</BODY>
</HTML>
