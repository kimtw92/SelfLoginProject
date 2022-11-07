<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commonInc/include/commonImport.jsp" %>
<%@ include file="/commonInc/include/comInclude.jsp" %>
<jsp:include page="/commonInc/include/comHtmlTop.jsp" flush="false">
	<jsp:param name="cssName" value="layout" />
</jsp:include>
<jsp:include page="../inc/header.jsp" flush="true" ></jsp:include>
    
    <div id="subContainer">
    
    <div class="subNavi_area">
    
     <jsp:include page="/login/main_login.jsp" flush="false"/>
   
      </div>
    
        <div id="contnets_area">
          <div class="sub_visual1">홈페이지 이용안내</div>
            <div class="local">
              <h2>회원가입</h2>
                <div class="navi"><img src="/homepage_new/images/common/icon_home.gif" alt="home"> &gt; <span>회원가입</span></div>
            </div>

            <div class="contnets">
            <!-- contnet -->
			<div id="content">
			
				<!-- data -->
				<div class="dSet02">
					<div class="dch">
						
						<div class="findt">
							<ul><li><a href="/"><img src="/images/skin1/sub/findtab01_on.gif" alt="아이디찾기" /></a></li><li><a href="/"><img src="/images/skin1/sub/findtab02.gif" alt="공공아이핀인증" /></a></li></ul>
						</div>

						<table class="dW">		
						<tr>
							<th class="thdw" width="70">이름</th>
							<td class="tddw"><input type="text" name="NAME" class="input02" style="width:115px;" /></td>
							<td class="td_btn" rowspan="2"><input type="image" src="/images/skin1/button/btn_find02.gif" alt="찾기" /></td>
						</tr>
						<tr>
							<th class="thdw">주민번호</th>
							<td class="tddw"><input type="text" name="EMAIL" class="input02" style="width:115px;" /></td>
						</tr>
						</table>

					</div>
				</div>

				<div class="dSet03">
					<div class="dch">
						
						<div class="findt">
							<ul><li><a href="/"><img src="/images/skin1/sub/findtab03_on.gif" alt="비밀번호찾기" /></a></li><li><a href="/"><img src="/images/skin1/sub/findtab02.gif" alt="공공아이핀인증" /></a></li></ul>
						</div>

						<table class="dW">		
						<tr>
							<th class="thdw" width="70">아이디</th>
							<td class="tddw"><input type="text" name="NAME" class="input02" style="width:115px;" /></td>
							<td class="td_btn" rowspan="3"><input type="image" src="/images/skin1/button/btn_find02.gif" alt="찾기" /></td>
						</tr>
						<tr>
							<th class="thdw">이름</th>
							<td class="tddw"><input type="text" name="EMAIL" class="input02" style="width:115px;" /></td>
						</tr>
						<tr>
							<th class="thdw">주민번호</th>
							<td class="tddw"><input type="text" name="EMAIL" class="input02" style="width:115px;" /></td>
						</tr>
						</table>

					</div>
				</div>
				
			
				<!-- //data -->

				<div class="space"></div>



		<!-- data -->
		<div class="dSet04">
			<div class="dch">
				
				<div class="findt">
					<ul><li><a href="/"><img src="/images/skin1/sub/findtab01.gif" alt="아이디찾기" /></a></li><li><a href="/"><img src="/images/skin1/sub/findtab02_on.gif" alt="공공아이핀인증" /></a></li></ul>
				</div>

				<div class="ipin01">
					<span>공공아이핀(I-PIN)</span>은 인터넷상의 개인식별번호를<br/> 
의미하며, 대면확인이 어려운 인터넷에서 주민등록<br/>
번호를 사용하지 않고도 확인할 수 있는 수단입니다.<br/> 
				</div>
				
				<div class="btn_ipin02">
				<input type="image" src="/images/skin1/button/btn_ipin01.gif" alt="공공아이핀인증" />
				</div>

				<div class="ipin02">
					<span>공공아이핀(I-PIN)관련 문의처</span><br/> 
*공공 I-PIN서비스센터<br/> 
http://www.gpin.go.kr TEL02-3279-3480~2<br/> 
*인천광역시 정보화담당관실<br/> 
TEL 032-440-2332~4
				</div>

			</div>
		</div>

		<div class="dSet05">
			<div class="dch">
				
				<div class="findt">
					<ul><li><a href="/"><img src="/images/skin1/sub/findtab03.gif" alt="비밀번호찾기" /></a></li><li><a href="/"><img src="/images/skin1/sub/findtab02_on.gif" alt="공공아이핀인증" /></a></li></ul>
				</div>

				<div class="ipin03">
					<span>공공아이핀(I-PIN)</span>은 인터넷상의 개인식별번호를<br/> 
의미하며, 대면확인이 어려운 인터넷에서 주민등록<br/>
번호를 사용하지 않고도 확인할 수 있는 수단입니다.<br/> 
				</div>


				<div class="btn_ipin02">
				<input type="image" src="/images/skin1/button/btn_ipin01.gif" alt="공공아이핀인증" />
				</div>

				<div class="ipin04">
					<span>공공아이핀(I-PIN)관련 문의처</span><br/> 
*공공 I-PIN서비스센터<br/> 
http://www.gpin.go.kr TEL02-3279-3480~2<br/> 
*인천광역시 정보화담당관실<br/> 
TEL 032-440-2332~4
				</div>


			</div>
		</div>
		
	
		<!-- //data --> 
		

<div class="space"></div>
		<!-- search01 -->
		<div class="joinUsMtSet02">
			<div class="joinUsMt02">
				<strong>배미옥</strong> 님의 아이디는 <strong class="txt_blue">test1234567</strong> 입니다.

				<div class="btn_c04">
				<input type="image" src="/images/skin1/button/btn_submit06.gif" alt="확인" />
				</div>
			</div>
			
		</div>
		<!-- //search01 -->

<div class="space"></div>
		<!-- search02 -->
		<div class="joinUsMtSet03">
			<div class="joinUsMt03">
				<div class="pw01">
				<img src="/images/skin1/sub/pw01.gif" alt="비밀번호 재발급" /> <span>아래 방법 중 하나의 인증수단을 선택해서 비밀번호를 재발급 받으시기 바랍니다.</span>
				</div>

				<div class="pw02">
				<dl>
					<dt>질문/답변으로 찾기</dt>
					<dd>회원가입시 입력하신<br/>
					질문과 답변으로 찾습니다.</dd>
				</dl>
				<input class="btn_pw01" type="image" src="/images/skin1/button/btn_submit06.gif" alt="확인" />
				</div>

				<div class="pw03">
					<dl>
						<dt>등록된 연락처 인증</dt>
						<dd>재발급받기를 선택하시면 등록된 연락처로 비밀번호가 발송됩니다.</dd>
					</dl>
					<ul>
						<li><span>휴대폰 번11111호</span> 010-2356-1236 <span class="m02"><img src="/images/skin1/button/btn_pw01.gif" alt="재발급 받기" /></span></li>
						<li><span class="m01">이메일</span> test@naver.com <span class="m03"><img src="/images/skin1/button/btn_pw01.gif" alt="재발급 받기" /></span></li>
					</ul>
					
					<div class="h15"></div>
					<dl>
					<dt>등록된 연락처 인증</dt>
					<dd>재발급받기를 선택하시면 등록된 연락처로 비밀번호가 발송됩니다.</dd>
					</dl>

					<div class="tx03"><span>휴대폰으로 확인</span> <br/>본인 명의로 등록된 휴대폰<br/>번호를 통해 본인 인증과정을<br/>거치게 됩니다.</div>
					<div class="tx04"><img src="/images/skin1/button/btn_pw02.gif" alt="본인인증" /></div>
					</ul>
				</div>
			</div>		
		</div>
		<!-- //search02 -->



		</div>
		<div class="h80"></div>
            <!-- //contnet -->
          </div>

        </div>
    
    
    </div>

     <jsp:include page="../inc/footer.jsp" flush="true" ></jsp:include>