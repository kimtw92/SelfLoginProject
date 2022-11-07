<%@ page language = "java" contentType = "text/html; charset=UTF-8"%>

<%@ page import="gov.mogaha.gpin.sp.proxy.*" %>

<%
    /**
     * 이 서비스는 사용자의 주민등록번호와 이용기관에 부여된 이용기관코드(Site Code)를 입력받아 중복가입확인코드를 생성해줍니다.
     * 입력에 사용되는 주민등록번호에 대한 보안에 주의해야합니다.
     */
    GPinProxy proxy = GPinProxy.getInstance(this.getServletConfig().getServletContext());
    String rtnDupValue = "";

    //주민등록번호
    String regNo = request.getParameter("regNo") == null ? "":request.getParameter("regNo");
    //사이트 ID
    String siteId = request.getParameter("siteId") == null? "":request.getParameter("siteId");
    
	//이름
	String username = request.getParameter("username") == null? "":request.getParameter("username");

	if (!regNo.equals("") && !siteId.equals("")) {
        rtnDupValue = proxy.getUserDupValue(regNo, siteId);
    }
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
	    <meta content="text/html; charset=utf-8" http-equiv="content-type" />
	    <title>GPIN SP - SAMPLE - 중복가입확인코드 결과</title>
	    
	    <script type="text/javascript" language="javascript">
	    
	    function returnPage(){ 

			var username = document.getElementById("username").value;
			var regno = document.getElementById("regno").value;
			var dupvalue = document.getElementById("dupvalue").value;

			//alert(dupvalue);
			//opener.isSubmit(dupvalue);
			//opener.makeUserDupValue("end", dupvalue);
			//opener.makeUserDupValue("authCheck1", dupvalue, username, regno);
			
			opener.authCheck1("end", dupvalue, username, regno);

			window.close();
		}	
	    </script>
	    
	</head>
	<body onload="javascript:returnPage()">
		<form method="post" name="dupinfoform">
		    <table>
		        <tr>
		            <td>(이름) : </td>
		            <td>
		                <input type="text" id="username" name="username" value="<%= username %>"/>
		            </td>
		        </tr>
				<tr>
		            <td>(주민등록번호) : </td>
		            <td>
		                <input type="text" id="regno" name="regno" value="<%= regNo %>"/>
		            </td>
		        </tr>
				<tr>
		            <td>(중복가입확인코드) : </td>
		            <td>
		                <input type="text" id="dupvalue" name="dupvalue" value="<%= rtnDupValue %>"/>
		            </td>
		        </tr>
		    </table>
	    </form>
	</body>
</html>