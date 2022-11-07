<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commonInc/include/commonImport.jsp" %>
<%@ include file="/commonInc/include/comInclude.jsp" %>
<%@ page import="gov.mogaha.gpin.sp.util.StringUtil "%>
<%
	HttpSession newSession = request.getSession();
	
	String userid = newSession.getAttribute("sess_userid").toString();
	String userno = newSession.getAttribute("sess_no").toString();
	
%>
<jsp:include page="/commonInc/include/comHtmlTop.jsp" flush="false">
	<jsp:param name="cssName" value="layout" />
</jsp:include>

<script>window.name="mother"</script>
 
<script language="JavaScript" type="text/JavaScript">


	function pwdchk(){
		
		var pwd1 = document.getElementById("pwd1").value;
		var pwd2 = document.getElementById("pwd2").value;
		var newpwd = document.getElementById("newpwd");
		
		if(pwd1 == "" || pwd2 == ""){			
			alert('비밀번호를 입력해주세요')			
		}else{
			
			if(pwd1 != pwd2){			
				alert('새로운 비밀번호가 일치하지 않습니다 \r\n비밀번호를 재확인 해주세요.');
			}else{
				
				for(i=0; i<pwd1.length; i++){
					Chr = pwd1.charAt(i); 
					if(pwd1.length < 9 || pwd1.length > 12) {
						alert("비밀번호는 9자 에서 12자 이하 이어야 합니다.") ;
						eval("document.pform.pwd1.value = ''") ;
						eval("document.pform.pwd2.value = ''") ;
						eval("document.pform.pwd1.focus()") ;       
						return;     
					}
				}
				
				 var isPW = /^[A-Za-z0-9`\-=\\;',.\/~!@#\$%\^&\*\(\)_\+|\{\}:"<>\?]{6,16}$/;
					if(!isPW.test(pwd1)) {
						alert("비밀번호는 영문/숫자와 특수문자를 혼용하여 입력해주시기 바랍니다.");
						eval("document.pform.pwd1.value = ''") ;
						eval("document.pform.pwd2.value = ''") ;
						eval("document.pform.pwd1.focus()") ;   
						return ;
					}
					var isNumber = /^[0-9]+$/;
					if(isNumber.test(pwd1)) {
						alert("숫자만 입력하실수 없습니다. 다시 입력해주세요.");
						eval("document.pform.pwd1.value = ''") ;
						eval("document.pform.pwd2.value = ''") ;
						eval("document.pform.pwd1.focus()") ;  
						return;
					}
					var isChkPwd = false;
					var comStr = "";
					for (var k=0; k<pwd1.length; k++) {
						comStr = pwd1.charAt(k) + pwd1.charAt(k) + pwd1.charAt(k) + pwd1.charAt(k);
						if (pwd1.indexOf(comStr) != -1) {
							isChkPwd = true;
							break;
						}
					}

					if (isChkPwd) {
						alert("동일한 문자/숫자 4자리/공백은 사용하실 수 없습니다. 다시 입력해주세요.");
						eval("document.pform.pwd1.value = ''") ;
						eval("document.pform.pwd2.value = ''") ;
						eval("document.pform.pwd1.focus()") ;  
						return ;
					}
		 
					if (pwd1.length >= 4) {
						var iUniCode = 0;
						for (var i=0; i <= pwd1.length - 3; i++) {
							iUniCode = pwd1.charCodeAt(i);
							if (pwd1.charCodeAt(i+1) == iUniCode + 1 && pwd1.charCodeAt(i+3) == iUniCode + 3) {
								alert("연속된 문자/숫자 4자리는 사용하실 수 없습니다. 다시 입력해주세요.");
								eval("document.pform.pwd1.value = ''") ;
								eval("document.pform.pwd2.value = ''") ;
								eval("document.pform.pwd1.focus()") ;  
								return ;
							}
						}
					}					
				
					alert('비밀번호가 변경되었습니다. \r\n다시 로그인을 해주세요');					
					newpwd.submit();				
				}		
		}
		
		
		
	}//pwdchk
	
	function noSpaceForm(obj) { // 공백사용못하게
	    var str_space = /\s/;  // 공백체크
	    if(str_space.exec(obj.value)) { //공백 체크
	        alert("비밀번호에는 공백을 사용할수 없습니다.\r\n공백은 자동적으로 제거 됩니다.");
	        obj.focus();
	        obj.value = obj.value.replace(' ',''); // 공백제거
	        return false;
	      } 
	}

</script>
<style>

body{

background-image: url("../homepage_2019/images/common/changepwd.png");
background-repeat: no-repeat;
background-position: center;
}

#maindiv{
size: 100%;
height: 630px;
margin-top: 200px;
text-align: center;
}

#mainpwd{

margin-top: 265px;
text-align: center;

}

#pinfo2,#pwdbt{

margin-top: 5px;
}

#pinfo1{
margin-top: 5px;
margin-left: 10px;
}
#p1{

margin-left: 14px;
}



</style>
<body>

	<div id="maindiv">

	   
	        <form id="newpwd" action="/homepage/renewal.do" method="post">         
		        <div id="mainpwd">        
			         <p  id="p1">새 비밀번호 : <input type="password" name="pwd" id="pwd1" onkeyup="noSpaceForm(this);"> </p> <p id="pinfo1">(영문,숫자,문자 포함 9자 이상 12자 미만)</p>    <br/>   
			         <p  id="p2">비밀번호 확인 : <input type="password" id="pwd2" onkeyup="noSpaceForm(this);" ></p> <p id="pinfo2">(비밀번호를 다시 입력해 주세요) </p>		               
		        </div>	       
		      <input id="pwdbt" type="button" value="변경" onclick="pwdchk();">
		       
	          <input type="hidden" name="mode" value="newPwd">
	          <input type="hidden" name="userid" value="<%=userid %>">
	          <input type="hidden" name="userno" value="<%=userno %>">
	          
	        </form>
	   
   </div> 
    

</body>

