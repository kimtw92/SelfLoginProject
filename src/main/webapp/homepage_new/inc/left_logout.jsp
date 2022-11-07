<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
        
        <!-- loginBox -->
<div class="logout">
	<div class="user">
		<p class="in_check"><label for="idsave"><strong>오세명</strong>(vdream)</label> </p>
		<p class="btn2"><a href="/mypage/myclass.do?mode=personalinfomodify">개인정보변경</a><a href="/">로그아웃</a></p>
        <p class="sel"><select id="cboAuth" name="cboAuth" style="width:165px;height:20px;border:1px solid #d7d7d7;" onchange="fnSelectAuth();"><option value='' selected >수강중인 강좌 바로가기</option></select></p>
        <p class="sel"><select id="cboAuth" name="cboAuth" style="width:165px;height:20px;border:1px solid #d7d7d7;" onchange="fnSelectAuth();"><option value='' selected >교육생</option></select></p>
	</div>
</div>
<!-- //loginBox -->