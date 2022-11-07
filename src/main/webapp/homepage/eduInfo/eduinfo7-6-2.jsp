<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commonInc/include/commonImport.jsp" %>
<%@ include file="/commonInc/include/comInclude.jsp" %>
<jsp:include page="/commonInc/include/comHtmlTop.jsp" flush="false">
	<jsp:param name="cssName" value="layout" />
</jsp:include>
<jsp:include page="/homepage_new/inc/header.jsp" flush="true" ></jsp:include>
    
    <div id="subContainer">
    
    <div class="subNavi_area">
    
      <jsp:include page="/homepage_new/inc/left6.jsp" flush="true" ></jsp:include>
    
      </div>
    
        <div id="contnets_area">
          <div class="sub_visual6">인재개발원 소개</div>
            <div class="local">
              <h2>시설현황</h2>
                <div class="navi"><img src="/homepage_new/images/common/icon_home.gif" alt="home"> &gt; 인재개발원 소개 &gt; 시설현황 &gt; <span>층별안내</span></div>
            </div>
            <div class="contnets">
            <!-- contnet -->
			
            <ol class="TabSub">
            <li><a href="javascript:fnGoMenu('7','eduinfo7-6');">시설개요</a></li>
            <li class="TabOn"><a href="javascript:fnGoMenu('7','eduinfo7-6-2');">층별안내</a></li>
            <!-- li><a href="javascript:fnGoMenu('7','eduinfo7-6-3');">편의시설</a></li -->
            <li class="last"><a href="javascript:fnGoMenu('7','eduinfo7-6-4');">시설대관안내</a></li>
          </ol>
			  <form id="pform" name="pform" method="post">
			<div id="content">
			<div class="space"></div>

			<!-- 층별 --> 
			<div class="floorInfoSet">
				<div class="flLeft">
					<div class="flTabSet">
						<ul class="flTab">
						<li>
							<a href="javascript:show_sub_menu(1);" onFocus="this.blur();"><img id="mainimg1" src="/images/skin1/sub/tab_flr01_on.gif" alt="1층" /></a>
						</li>
						<li>
							<a href="javascript:show_sub_menu(2);" onFocus="this.blur();"><img id="mainimg2" src="/images/skin1/sub/tab_flr02.gif" alt="2층" /></a>
						</li>
						<li>
							<a href="javascript:show_sub_menu(3);" onFocus="this.blur();"><img id="mainimg3" src="/images/skin1/sub/tab_flr03.gif" alt="3층" /></a>
						</li>
						<li>
							<a href="javascript:show_sub_menu(4);" onFocus="this.blur();"><img id="mainimg4" src="/images/skin1/sub/tab_flr04.gif" alt="4층" /></a>
						</li>
						</ul>
					</div>

					<!-- 1층 -->
					<div id="1floorsub" class="floor" style="display:''">
						<ul class="flSubMenu">
						<li><a href="javascript:show_main(11);" onFocus="this.blur();">
							<img id="mainimg1_1" src="/images/skin1/sub/menuF0100_on.gif" alt="" /></a>
						</li>
						<li><a href="javascript:show_main(12);" onFocus="this.blur();">
							<img id="mainimg1_2" src="/images/skin1/sub/menuF0101.gif" alt="" /></a>
						</li>
						<li><a href="javascript:show_main(13);" onFocus="this.blur();">
							<img id="mainimg1_3" src="/images/skin1/sub/menuF0102.gif" alt="" /></a>
						</li>
						<li><a href="javascript:show_main(60);" onFocus="this.blur();">
							<img id="mainimg1_11" src="/images/skin1/sub/menuF0111.gif" alt="" /></a>
						</li>
						<li><a href="javascript:show_main(14);" onFocus="this.blur();">
							<img id="mainimg1_4" src="/images/skin1/sub/menuF0103.gif" alt="" /></a>
						</li>
						<li><a href="javascript:show_main(15);" onFocus="this.blur();">
							<img id="mainimg1_5" src="/images/skin1/sub/menuF0104.gif" alt="" /></a>
						</li>
						<li><a href="javascript:show_main(16);" onFocus="this.blur();">
							<img id="mainimg1_6" src="/images/skin1/sub/menuF0105.gif" alt="" /></a>						
						</li>
						<li><a href="javascript:show_main(17);" onFocus="this.blur();">
							<img id="mainimg1_7" src="/images/skin1/sub/menuF0106.gif" alt="" /></a>
						</li>
						<li><a href="javascript:show_main(18);" onFocus="this.blur();">
							<img id="mainimg1_8" src="/images/skin1/sub/menuF0107.gif" alt="" /></a>						
						</li>
						<li><a href="javascript:show_main(19);" onFocus="this.blur();">
							<img id="mainimg1_9" src="/images/skin1/sub/menuF0108.gif" alt="" /></a>
						</li>
						<li><a href="javascript:show_main(20);" onFocus="this.blur();">
							<img id="mainimg1_10" src="/images/skin1/sub/menuF0109.gif" alt="" /></a>
						</li>
						</ul>
					</div>
					<!-- //1층 -->

					<!-- 2층 -->
					<div id="2floorsub" class="floor" style="display:none">
						<ul class="flSubMenu">
						<!-- <li><a href="javascript:show_main(21);" onFocus="this.blur();">
							<img id="mainimg2_1" src="/images/skin1/sub/menuF0200_on.gif" alt="" /></a>
						</li> --><div id="mainimg2_1"></div>
								 <div id="mainimg2_2"></div>
<!-- 						<li><a href="javascript:show_main(22);" onFocus="this.blur();"> -->
<!-- 							<img id="mainimg2_2" src="/images/skin1/sub/menuF0201.gif" alt="" /></a> -->
<!-- 						</li> -->
						<!-- li><a href="javascript:show_main(23);" onFocus="this.blur();">
							<img id="mainimg2_3" src="/images/skin1/sub/menuF0202.gif" alt="" /></a>
						</li -->
						<li><a href="javascript:show_main(24);" onFocus="this.blur();">
							<img id="mainimg2_4" src="/images/skin1/sub/menuF0203.gif" alt="" /></a>
						</li>
						<li><a href="javascript:show_main(25);" onFocus="this.blur();">
							<img id="mainimg2_5" src="/images/skin1/sub/menuF0204.gif" alt="" /></a>
						</li>
						<li><a href="javascript:show_main(26);" onFocus="this.blur();">
							<img id="mainimg2_6" src="/images/skin1/sub/menuF0205.gif" alt="" /></a>						
						</li>
						<li><a href="javascript:show_main(27);" onFocus="this.blur();">
							<img id="mainimg2_7" src="/images/skin1/sub/menuF0206.gif" alt="" /></a>
						</li>
						<li><a href="javascript:show_main(28);" onFocus="this.blur();">
							<img id="mainimg2_8" src="/images/skin1/sub/menuF0207.gif" alt="" /></a>						
						</li>
						<li><a href="javascript:show_main(29);" onFocus="this.blur();">
							<img id="mainimg2_9" src="/images/skin1/sub/menuF0208.gif" alt="" /></a>
						</li>
						</ul>
					</div>
					<!-- //2층 -->

					<!-- 3층 -->
					<div id="3floorsub" class="floor" style="display:none">
						<ul class="flSubMenu">
						<li><a href="javascript:show_main(31);" onFocus="this.blur();">
							<img id="mainimg3_1" src="/images/skin1/sub/menuF0300.gif" alt="" /></a>
						</li>
						<li><a href="javascript:show_main(32);" onFocus="this.blur();">
							<img id="mainimg3_2" src="/images/skin1/sub/menuF0301.gif" alt="" /></a>
						</li>
						<li><a href="javascript:show_main(33);" onFocus="this.blur();">
							<img id="mainimg3_3" src="/images/skin1/sub/menuF0302.gif" alt="" /></a>
						</li>
						<li><a href="javascript:show_main(34);" onFocus="this.blur();">
							<img id="mainimg3_4" src="/images/skin1/sub/menuF0303.gif" alt="" /></a>
						</li>
						<li><a href="javascript:show_main(35);" onFocus="this.blur();">
							<img id="mainimg3_5" src="/images/skin1/sub/menuF0304.gif" alt="" /></a>
						</li>
						<li><a href="javascript:show_main(36);" onFocus="this.blur();">
							<img id="mainimg3_6" src="/images/skin1/sub/menuF0305.gif" alt="" /></a>						
						</li>
						<li><a href="javascript:show_main(37);" onFocus="this.blur();">
							<img id="mainimg3_7" src="/images/skin1/sub/menuF0306.gif" alt="" /></a>
						</li>
						<li><a href="javascript:show_main(38);" onFocus="this.blur();">
							<img id="mainimg3_8" src="/images/skin1/sub/menuF0307.gif" alt="" /></a>						
						</li>
						<li><a href="javascript:show_main(39);" onFocus="this.blur();">
							<img id="mainimg3_9" src="/images/skin1/sub/menuF0308.gif" alt="" /></a>						
						</li>
						
						
						</ul>
					</div>
					<!-- //3층 -->

					<!-- 4층 -->
					<div id="4floorsub" class="floor" style="display:none">
						<ul class="flSubMenu">
						<li><a href="javascript:show_main(41);" onFocus="this.blur();">
							<img id="mainimg4_1" src="/images/skin1/sub/menuF0400_on.gif" alt="" /></a>
						</li>
						<li><a href="javascript:show_main(42);" onFocus="this.blur();">
							<img id="mainimg4_2" src="/images/skin1/sub/menuF0401.gif" alt="" /></a>
						</li>
						<li><a href="javascript:show_main(43);" onFocus="this.blur();">
							<img id="mainimg4_3" src="/images/skin1/sub/menuF0402.gif" alt="" /></a>
						</li>
						<li><a href="javascript:show_main(44);" onFocus="this.blur();">
							<img id="mainimg4_4" src="/images/skin1/sub/menuF0403.gif" alt="" /></a>
						</li>
						<li><a href="javascript:show_main(45);" onFocus="this.blur();">
							<img id="mainimg4_5" src="/images/skin1/sub/menuF0404.gif" alt="" /></a>
						</li>
						<li><a href="javascript:show_main(46);" onFocus="this.blur();">
							<img id="mainimg4_6" src="/images/skin1/sub/menuF0405.gif" alt="" /></a>						
						</li>
						<li><a href="javascript:show_main(47);" onFocus="this.blur();">
							<img id="mainimg4_7" src="/images/skin1/sub/menuF0406.gif" alt="" /></a>
						</li>
						<li><a href="javascript:show_main(48);" onFocus="this.blur();">
							<img id="mainimg4_8" src="/images/skin1/sub/menuF0407.gif" alt="" /></a>						
						</li>
						</ul>
					</div>
					<!-- //4층 -->
				</div>

				<!-- 1층 -->
				<div id="mainlist1-1" style="float:right;width:517px;padding:0 0 0 0;display:'';">
					<div>
						<img src="/images/skin1/sub/img_fl0100.jpg" alt=""/>
					</div>
				</div>
				<div id="mainlist1-2" style="float:right;width:517px;padding:0 0 0 0;display:none">
					<div>
						<img src="/images/skin1/sub/img_fl0101.jpg" alt=""/>
					</div>
				</div>
				<div id="mainlist1-3" style="float:right;width:517px;padding:0 0 0 0;display:none">
					<div>
						<img src="/images/skin1/sub/img_fl0102.jpg" alt=""/>
					</div>
				</div>
				<div id="mainlist1-11" style="float:right;width:517px;padding:0 0 0 0;display:none">
					<div>
						<img src="/images/skin1/sub/img_fl0111.jpg" alt=""/>
					</div>
				</div>
				<div id="mainlist1-4" style="float:right;width:517px;padding:0 0 0 0;display:none">
					<div>
						<img src="/images/skin1/sub/img_fl0103.jpg" alt=""/>
					</div>
				</div>
				<div id="mainlist1-5" style="float:right;width:517px;padding:0 0 0 0;display:none">
					<div>
						<img src="/images/skin1/sub/img_fl0104.jpg" alt=""/>
					</div>
				</div>
				<div id="mainlist1-6" style="float:right;width:517px;padding:0 0 0 0;display:none">
					<div>
						<img src="/images/skin1/sub/img_fl0105.jpg" alt=""/>
					</div>
				</div>
				<div id="mainlist1-7" style="float:right;width:517px;padding:0 0 0 0;display:none">
					<div>
						<img src="/images/skin1/sub/img_fl0106.jpg" alt=""/>
					</div>
				</div>
				<div id="mainlist1-8" style="float:right;width:517px;padding:0 0 0 0;display:none">
					<div>
						<img src="/images/skin1/sub/img_fl0107.jpg" alt=""/>
					</div>
				</div>
				<div id="mainlist1-9" style="float:right;width:517px;padding:0 0 0 0;display:none">
					<div>
						<img src="/images/skin1/sub/img_fl0108.jpg" alt="""/>
					</div>
				</div>
				<div id="mainlist1-10" style="float:right;width:517px;padding:0 0 0 0;display:none">
					<div>
						<img src="/images/skin1/sub/img_fl0109.jpg" alt=""/>
					</div>
				</div>
				<!-- //1층 -->

				<!-- 2층 -->
				<div id="mainlist2-1" style="display:none" style="float:right;width:517px;padding:0 0 0 0;">
					<div>
						<img src="/images/skin1/sub/img_fl0200.jpg" alt=""/>
					</div>
				</div>
				<div id="mainlist2-2" style="float:right;width:517px;padding:0 0 0 0;display:none">
					<div>
						<img src="/images/skin1/sub/img_fl0201.jpg" alt=""/>
					</div>
				</div>
				<div id="mainlist2-3" style="float:right;width:517px;padding:0 0 0 0;display:none">
					<div>
						<img src="/images/skin1/sub/img_fl0202.jpg" alt=""/>
					</div>
				</div>
				<div id="mainlist2-4" style="float:right;width:517px;padding:0 0 0 0;display:none">
					<div>
						<img src="/images/skin1/sub/img_fl0203.jpg" alt=""/>
					</div>
				</div>
				<div id="mainlist2-5" style="float:right;width:517px;padding:0 0 0 0;display:none">
					<div>
						<img src="/images/skin1/sub/img_fl0204.jpg" alt=""/>
					</div>
				</div>
				<div id="mainlist2-6" style="float:right;width:517px;padding:0 0 0 0;display:none">
					<div>
						<img src="/images/skin1/sub/img_fl0205.jpg" alt=""/>
					</div>
				</div>
				<div id="mainlist2-7" style="float:right;width:517px;padding:0 0 0 0;display:none">
					<div>
						<img src="/images/skin1/sub/img_fl0206.jpg" alt=""/>
					</div>
				</div>
				<div id="mainlist2-8" style="float:right;width:517px;padding:0 0 0 0;display:none">
					<div>
						<img src="/images/skin1/sub/img_fl0207.jpg" alt=""/>
					</div>
				</div>
				<div id="mainlist2-9" style="float:right;width:517px;padding:0 0 0 0;display:none">
					<div>
						<img src="/images/skin1/sub/img_fl0208.jpg" alt=""/>
					</div>
				</div>
				<!-- //2층 -->

				<!-- 3층 -->
				<div id="mainlist3-1" style="display:none" style="float:right;width:517px;padding:0 0 0 0;">
					<div class="ml3_1">
						<img src="/images/skin1/sub/img_fl0300.jpg" alt=""/>
					</div>
				</div>
				<div id="mainlist3-2" style="float:right;width:517px;padding:0 0 0 0;display:none">
					<div>
						<img src="/images/skin1/sub/img_fl0301.jpg" alt=""/>
					</div>
				</div>
				<div id="mainlist3-3" style="float:right;width:517px;padding:0 0 0 0;display:none">
					<div>
						<img src="/images/skin1/sub/img_fl0302.jpg" alt=""/>
					</div>
				</div>
				<div id="mainlist3-4" style="float:right;width:517px;padding:0 0 0 0;display:none">
					<div>
						<img src="/images/skin1/sub/img_fl0303.jpg" alt=""/>
					</div>
				</div>
				<div id="mainlist3-5" style="float:right;width:517px;padding:0 0 0 0;display:none">
					<div>
						<img src="/images/skin1/sub/img_fl0304.jpg" alt=""/>
					</div>
				</div>
				<div id="mainlist3-6" style="float:right;width:517px;padding:0 0 0 0;display:none">
					<div>
						<img src="/images/skin1/sub/img_fl0305.jpg" alt=""/>
					</div>
				</div>
				<div id="mainlist3-7" style="float:right;width:517px;padding:0 0 0 0;display:none">
					<div>
						<img src="/images/skin1/sub/img_fl0306.jpg" alt=""/>
					</div>
				</div>
				<div id="mainlist3-8" style="float:right;width:517px;padding:0 0 0 0;display:none">
					<div>
						<img src="/images/skin1/sub/img_fl0307.jpg" alt=""/>
					</div>
				</div>
				<div id="mainlist3-9" style="float:right;width:517px;padding:0 0 0 0;display:none">
					<div>
						<img src="/images/skin1/sub/img_fl0308.jpg" alt=""/>
					</div>
				</div>
				<!-- //3층 -->

				<!-- 4층 -->
				<div id="mainlist4-1" style="display:none" style="float:right;width:517px;padding:0 0 0 0;">
					<div>
						<img src="/images/skin1/sub/img_fl0400.jpg" alt=""/>
					</div>
				</div>
				<div id="mainlist4-2" style="float:right;width:517px;padding:0 0 0 0;display:none">
					<div>
						<img src="/images/skin1/sub/img_fl0401.jpg" alt=""/>
					</div>
				</div>
				<div id="mainlist4-3" style="float:right;width:517px;padding:0 0 0 0;display:none">
					<div>
						<img src="/images/skin1/sub/img_fl0402.jpg" alt=""/>
					</div>
				</div>
				<div id="mainlist4-4" style="float:right;width:517px;padding:0 0 0 0;display:none">
					<div>
						<img src="/images/skin1/sub/img_fl0403.jpg" alt=""/>
					</div>
				</div>
				<div id="mainlist4-5" style="float:right;width:517px;padding:0 0 0 0;display:none">
					<div>
						<img src="/images/skin1/sub/img_fl0404.jpg" alt=""/>
					</div>
				</div>
				<div id="mainlist4-6" style="float:right;width:517px;padding:0 0 0 0;display:none">
					<div>
						<img src="/images/skin1/sub/img_fl0405.jpg" alt=""/>
					</div>
				</div>
				<div id="mainlist4-7" style="float:right;width:517px;padding:0 0 0 0;display:none">
					<div>
						<img src="/images/skin1/sub/img_fl0406.jpg" alt=""/>
					</div>
				</div>
				<div id="mainlist4-8" style="float:right;width:517px;padding:0 0 0 0;display:none">
					<div>
						<img src="/images/skin1/sub/img_fl0407.jpg" alt=""/>
					</div>
				</div>
				<!-- //4층 -->
			</div>
			<!-- //층별 -->

		</div>


			  </form>
              <jsp:include page="/homepage_new/inc/admin_info.jsp" flush="true" ><jsp:param name="menucode" value="M100038" /></jsp:include>
              <div class="h80"></div>   
              
            <!-- //contnet -->
          </div>
        </div>
    
    
    </div>

    <jsp:include page="/homepage_new/inc/footer.jsp" flush="true" ></jsp:include>