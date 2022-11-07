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
						<li><img src='/images/skin4/sub/lecturer_step01_on.gif'alt="�����û 1�ܰ�"></li>
						<li><img src='/images/skin4/sub/lecturer_step02.gif' alt="�����û 2�ܰ�"></li>
						<li><img src='/images/skin4/sub/lecturer_step03.gif' alt="�����û 3�ܰ�"></li>
						<li><img src='/images/skin4/sub/lecturer_step04.gif' alt="�����û 4�ܰ�"></li>
					</ul>
				</div>
				<div class="h30"></div>
				<p class="sub_img_left"><img src="/images/skin4/sub/lecturer_text01.gif" alt="�ȳ��Ͻʴϱ� ��õ�� ���簳�߿��ϴ�."></p>
				<p class="mb15">��õ�� ���簳�߿������� ���������� �缺�� �⿩�� <em>������ �Ϲ� ���� ���� ã��</em> �ֽ��ϴ�.<br/>
				<em>���, �Ⱝ��Ȳ �� ���� �������� ���</em>�Ͻø� ��ü �ɻ縦 ���� �Ⱝ ���� POOL ���� �� �ݿ����� �ϰڽ��ϴ�.</p>
				<p class="mb15">��õ�� ������ ������� ������ ������ν� ��õ�� ����缺�� ���� �����Ʒ� ��ǥ �޼��� �⿩�ϰ��� �մϴ�.<br/>
				������ �Ϲ� ���� �е��� �������� ������ ��� ȯ���մϴ�.</p>
				<div class="h30"></div>
				<p class="sub_img"><a href="javascript:goPage();"><img src="/images/skin4/sub/btn_lecturer01.gif" alt="�������Է�"></a></p>
			</div>
            <!-- //contnet -->
          </div>
        </div>
	</div>
	<form id="pform" name="pform" method="post" action="/homepage/lecturer.do">
		<input type="hidden" name="mode"		value='lecturer2' />
	</form>
    <jsp:include page="/homepage_new/inc/footer.jsp" flush="true" ></jsp:include>
<script language = "javascript"> 
	function goPage() {
		$("pform").submit();
	}
</script>