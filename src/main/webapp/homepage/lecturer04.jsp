<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="euc-kr"%>
<%@ include file="/commonInc/include/commonImport.jsp" %>
<%@ include file="/commonInc/include/comInclude.jsp" %>
<jsp:include page="/commonInc/include/comHtmlTop.jsp" flush="false">
	<jsp:param name="cssName" value="layout" />
</jsp:include>
<jsp:include page="/homepage_new/inc/header.jsp" flush="true" ></jsp:include>
<div id="subContainer">
	<div class="subNavi_area">
		<jsp:include page="/homepage_new/inc/left7.jsp" flush="true" ></jsp:include>
	</div>
	<div id="contnets_area">
		<div class="sub_visual7">Ȩ������ �̿�ȳ�</div>
		<div class="local">
			<h2>������</h2>
			<div class="navi"><img src="/homepage_new/images/common/icon_home.gif" alt="home"> &gt; Ȩ������ �̿�ȳ� &gt; <span>������</span></div>
		</div>
		<div class="contnets">
			<!-- contnet -->
			<div id="content">
				<div class="lecturer_tab01">
					<ul>
						<li><img src='/images/skin4/sub/lecturer_step01.gif'alt="�����û 1�ܰ�"></li>
						<li><img src='/images/skin4/sub/lecturer_step02.gif' alt="�����û 2�ܰ�"></li>
						<li><img src='/images/skin4/sub/lecturer_step03.gif' alt="�����û 3�ܰ�"></li>
						<li><img src='/images/skin4/sub/lecturer_step04_on.gif' alt="�����û 4�ܰ�"></li>
					</ul>
				</div>
				<div class="h30"></div>
				<p class="sub_img_left"><img src="/images/skin4/sub/lecturer_text01.gif" alt="�ȳ��Ͻʴϱ� ��õ�� ���簳�߿��ϴ�."></p>
				<p class="mb15">�����ϿϷ�</p>
				<div class="h30"></div>
			</div>
			<!-- //contnet -->
		</div>
	</div>
</div>
<jsp:include page="/homepage_new/inc/footer.jsp" flush="true" ></jsp:include>