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
    <title>GPIN SP - SAMPLE - ����� �������� ���</title>
</head>
<body>
<%
    /**
     * Sample-AuthRequest �� ���� ��������� �Ϸ��� session�� ����� ����������� �������� �������Դϴ�.
     * Sample-AuthRequest���� ������������ ������ ���־�� ����Ǹ� �������� �׸��� ���� ������ ���̵带�����Ͻñ�ٶ��ϴ�.
     */
    // ���� ���Ž� ��ûó�� ������ ��ġ������ session�� ������ ��û�� IP�� ���մϴ�.
	if (request.getRemoteAddr().equals(session.getAttribute("gpinUserIP")))
	{
%>
    <table>
        <tr>
            <td>�ߺ�Ȯ���ڵ�(dupInfo)</td>
            <td><%= getSession(session, "dupInfo") %></td>
        </tr>
        <tr>
            <td>���νĺ���ȣ(virtualNo)</td>
            <td><%= getSession(session, "virtualNo") %></td>
        </tr>
        <tr>
            <td>�̸�(realName)</td>
            <td><%= getSession(session, "realName") %></td>
        </tr>
        <tr>
            <td>����(sex)</td>
            <td><%= getSession(session, "sex") %></td>
        </tr>
        <tr>
            <td>����(age)</td>
            <td><%= getSession(session, "age") %></td>
        </tr>
        <tr>
            <td>�������(birthDate)</td>
            <td><%= getSession(session, "birthDate") %></td>
        </tr>
        <tr>
            <td>����(nationalInfo)</td>
            <td><%= getSession(session, "nationalInfo") %></td>
        </tr>
        <tr>
            <td>�����������(authInfo)</td>
            <td><%= getSession(session, "authInfo") %></td>
        </tr>
    </table>
<%
	}
	else
	{
%>
		<table>
		<tr><td>���ǰ��� ���� ���߽��ϴ�.</td></tr>
		</table>
<%
	}
	%>


    <br />
    <a href="javascript:history.back(-2)">Go Back</a>
    <br />
    <a href="Sample-SessionClear.jsp">Session Clear</a>
</body>
</html>