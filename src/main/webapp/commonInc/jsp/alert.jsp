<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page language="java" %> 
<%
	String msg = (String)request.getAttribute("ALERT_MSG");
	String confirmMsg = (String)request.getAttribute("CONFIRM_MSG");
	String confirmTrueAction = (String)request.getAttribute("CONFIRM_TRUE_ACTION");
	String confirmFalseAction = (String)request.getAttribute("CONFIRM_FALSE_ACTION");
	String returnUrl = (String)request.getAttribute("RETURN_URL");
	String redirect = (String)request.getAttribute("REDIRECT");
	
	if (msg != null && !msg.equals("")){
%>
	<script language="javascript">
		alert("<%= msg %>");
	</script>
<%

	}
	
	if ( confirmMsg != null && !confirmMsg.equals("")) {
%>
	<script language="javascript">
		if (confirm("<%= confirmMsg %>")) {
			<%= confirmTrueAction %>
		} else {
			<%= confirmFalseAction %>
		}
	</script>
<%
	}
	
	if (redirect != null) {
		if (redirect.equals("PARENT_RELOAD")) {
%>
		<script language="javascript">
			parent.location.reload();
		</script>
<%		
		} else if (redirect.equals("OPENER_RELOAD")) {
%>
		<script language="javascript">
			
			//alert("���ȭ��ó��");
			
			opener.location.reload();
			self.close();
			
		</script>
<%		
		} else if (redirect.equals("OPENER_NEW_RELOAD")) {
%>
		<script language="javascript">

			opener.location.reload();								
			self.close();
			
		</script>
<%		
		}	 else if (redirect.equals("PARENT_CLOSE")) {
%>
		<script language="javascript">

			parent.close();		
			
		</script>
<%		
		}	
	}
	
	if (returnUrl != null) {
%>
		<script language="javascript">
			location.replace("<%= returnUrl %>");
		</script>
<%
	}
%>