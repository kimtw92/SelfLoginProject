<%@ page language = "java" contentType = "text/html; charset=EUC-KR"%>

<%!
    String getSession(HttpSession session, String attrName)
    {
        return session.getAttribute(attrName) != null ? (String)session.getAttribute(attrName) : "";
    }
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
	    <meta content="text/html; charset=utf-8" http-equiv="content-type" />
	    <title>GPIN SP - SAMPLE - ����� �������� ��û���</title>
	</head>
	<body>
    <%
    /**
     */

    %>

	    G-Pin SP<br />                                      
	    <br />
	    <table>
	        <tr>
	            <td>����� ��� Ȯ�� ���</td>
	            <td>
	                <%= getSession(session, "coInfo1") %>
	            </td>
	        </tr>
	    </table>

	    <br />
	    <a href="javascript:history.back(-2)">�ڷΰ���</a>
	</body>
</html>