<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commonInc/include/commonImport.jsp" %>
<%@ include file="/commonInc/include/comInclude.jsp" %>

<jsp:include page="/commonInc/include/comHtmlTop.jsp" flush="false">
	<jsp:param name="cssName" value="layout" />
</jsp:include>
<link rel="stylesheet" type="text/css" href="/homepage_new/css/sub.css" charset="euc-kr">
<link rel="stylesheet" type="text/css" href="/homepage_new/css/common.css" />
<link rel="stylesheet" type="text/css" href="/homepage_new/css/login.css" />
<link rel="stylesheet" type="text/css" href="/homepage_new/css/board.css" />
<link rel="stylesheet" type="text/css" href="/homepage_new/css/content.css" />
<style type="text/css">
	/* dataW04 회원탈퇴 */
	table.dataW04	{
		clear:both;
		margin:0;
		padding:0;
		width:300px;
		border-top:1px solid #E6E6E6;
		border-right:1px solid #E6E6E6;
		border-bottom:1px solid #E6E6E6;
		border-left:1px solid #E6E6E6;
		border-left:0;
		border-right:0;
	}
	table.dataW04 th		{height:24px;padding:2px 15px 0px 0;color:#797979;border-left:1px solid #E6E6E6;border-bottom:1px solid #E6E6E6;background:#F6F6F6;font-weight:normal;text-align:right;line-height:15px;}
	table.dataW04 td		{height:24px;padding:2px 0 0px 5px;border-right:1px solid #E6E6E6;border-bottom:1px solid #E6E6E6;color:#686868;line-height:15px;text-align:left;}
	table.dataW04 td input.input02	{height:14px;padding:2px 0 0 3px;margin:0;font-weight:normal;background:#ffffff;border:1px solid #E6E6E6;color:#8D8D8D;font-size:11px;line-height:14px;vertical-align:2px;}
	table.dataW04 td span.ltg		{color:#dddddd;vertical-align:1px;}
</style>

	<script>

		//2011.01.11 - woni82
		//기존의 회원 탈퇴시 회원의 주민등록번호 입력에서 이메일 번호 입력으로 변경함
		//현재 사용함.
		function deleteUser1(){
		    var form1 = document.pform;
		    for(var i =0 ; i < form1.elements.length ; i++){
		        if(form1.elements[i].value==""){
		           alert(form1.elements[i].title+" 부분을 입력하여 주십시오" );
		            form1.elements[i].focus();
		            return ;
		        }
		    }   
			if($F('username').length < 2){
				alert("이름은 2자 이상입니다.");
				return;
			}

			//2011.01.11 - woni82
			//회원탈퇴시 주민등록번호를 사용 안하는 프로세스로 변경함.
			//else if($F('ssn1').length != 6) {
			//	alert("주민등록번호 앞자리는 6자입니다.");
			//	return;
			//}else if($F('ssn2').length != 7) {
			//	alert("주민등록번호 뒷자리는 7자입니다.");
			//	return;
			//}else if($F('ssn2').substr(0,1)!=1 && $F('ssn2').substr(0,1)!=2) {
			//	alert("잘못된 주민등록번호 형식입니다.");
			//	return;
			//}

			else if($F('userpw').length <6) {
				alert("패스워드는 6자 이상입니다.");
				return;
			}	
		    
			name = $F('username');
			
			//ssn = $F('ssn1')+$F('ssn2');
			//var email = $F('emailid')+"@"+$F('mailserv');

			//alert(email);
				
			password = $F('userpw');

			var url = "myclass.do";
			pars = "mode=userdeletecheckajaxEmail&name="+name+"&email=&password="+password;
			
			var myAjax = new Ajax.Request(
				url, 
				{
					method: "post", 
					parameters: pars,
					onComplete: testFunction1
				}				
			);
		}

		//2011.01.11 - woni82
		//회원 탈퇴 프로세스 - 주민등록번호 이용.
		// 사용 안함.
		function deleteUser(){
		    var form1 = document.pform;
		    for(var i =0 ; i < form1.elements.length ; i++){
		        if(form1.elements[i].value==""){
		           alert(form1.elements[i].title+" 부분을 입력하여 주십시오" );
		            form1.elements[i].focus();
		            return ;
		        }
		    }   
			if($F('username').length < 2){
				alert("이름은 2자 이상입니다.");
				return;
			}else if($F('ssn1').length != 6) {
				alert("주민등록번호 앞자리는 6자입니다.");
				return;
			}else if($F('ssn2').length != 7) {
				alert("주민등록번호 뒷자리는 7자입니다.");
				return;
			}else if($F('ssn2').substr(0,1)!=1 && $F('ssn2').substr(0,1)!=2) {
				alert("잘못된 주민등록번호 형식입니다.");
				return;
			}else if($F('userpw').length <6) {
				alert("패스워드는 6자 이상입니다.");
				return;
			}	
		    
			name = $F('username');
			ssn = $F('ssn1')+$F('ssn2');
			password = $F('userpw');
			var url = "myclass.do";
			pars = "mode=userdeletecheckajax&name="+name+"&ssn="+ssn+"&password="+password;
			
			var myAjax = new Ajax.Request(
					url, 
					{
						method: "post", 
						parameters: pars,
						onComplete: testFunction1
					}				
				);
		}
		
		function testFunction1(request){
			var num = request.responseText;
			if(num == 0) {
				alert("존재하지 않는 회원입니다. 확인 후 다시 입력해 주십시요");
				$('username').value='';
				$('ssn1').value='';
				$('ssn2').value='';
				$('userpw').value='';		
			}else {
				alert("회원님의 정보가 삭제되었습니다. 이용하여 주셔서 감사합니다.");
				document.pform.action = "myclass.do?mode=deleteuser";
				document.pform.submit(); 
			}	
		}
	
	</script>
<jsp:include page="/homepage_new/inc/header.jsp" flush="true" ></jsp:include>
    
    <div id="subContainer">
    
    <div class="subNavi_area">
    
	   <jsp:include page="/homepage_new/inc/left1.jsp" flush="true" ></jsp:include>
    
      </div>
    
        <div id="contnets_area">
          <div class="sub_visual1">마이페이지</div>
            <div class="local">
              <h2>회원탈퇴</h2>
                <div class="navi"><img src="/homepage_new/images/common/icon_home.gif" alt="home"> &gt; 마이페이지 &gt; <span>회원탈퇴</span></div>
            </div>
            <form id="pform" name="pform" method="post">
<div class="contnets">
            <!-- contnet -->
              <!--회원탈퇴 시작-->
      <div class="login">
        <div class="top">
          <img src="/homepage_new/images/login/login_02.gif" alt="안녕하세요? 인천광역시 인재개발원입니다. 회원탈퇴 신청에 앞서 안내사항을 공지해 드립니다." class="login_img1" /><br />
          
          <p class="info"><b>회원탈퇴 신청을 하시면 즉시 해지조치 되며, 다시 로그인하실 수 없습니다.<br /> 해지조치 후, 회원정보는 즉각 삭제 되며, 개인교육이력사항은 보존됩니다.</b> <br />보다 나은 서비스를 제공하기 위해서 더욱 더 노력할 것을 약속드립니다.
</p>
          
        </div>
        <div class="bottom">
          
          
          <div class="member_bye">
            <p class="center">
            <div class="h10"></div>
            
            <table class="dW" summary="회원탈퇴 입력폼입니다. 성명, 비밀번호를 입력하시면 처리됩니다." >
				<tr>
					<th class="thdw" width="70">이름</th>
					<td class="tddw"><input type="text" id="username" name="username" class="input02" style="width:170px;" title="이름" /></td>
				</tr>
				<tr>
					<th class="thdw">비밀번호</th>
					<td class="tddw"><input type="password" id="userpw" name="userpw" class="input02" style="width:170px;" title="비밀번호"/></td>
				</tr>
			</table>
            </p>
			<div class="h10"></div>
            <p class="center"><a href="javascript:deleteUser1();"><img src="../images/skin1/button/btn_submit05.gif" alt="확인"></a> <a href="/mypage/myclass.do?mode=main"><img src="../images/skin1/button/btn_cancel04.gif" alt="취소"></a></p><br/>
          </div>
          
          
        </div>
      </div>
              <!--회원탈퇴 마감-->
            <!-- //contnet -->
          </div>

		  </form>
        </div>
    
    
    </div>

    <jsp:include page="/homepage_new/inc/footer.jsp" flush="true" ></jsp:include>