<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%  
// prgnm : Inno 업로드 컴퍼 넌트 사용시 Include 하는 Jsp페이지.
// date : 2008-05-29
// auth : LYM
%>

<!-- [s] commonImport -->
<%@ include file="/commonInc/include/commonImport.jsp" %>
<!-- [e] commonImport -->

<%
	//업로드 경로
	String innoUploadUrl = "/commonInc/fileUpload.do"; 
	 //Inno Enc (라이센스)
	//String innoEnc = "PwnqnHkmylnB3BzRkOoex08NJ0MEhEDeZ2WzYvRQrWSv890KyFthsPgpelbEGAWGjl5xVuPq9Gj07dKuOJVGxK8Kk7QWE8BdyLyFXamCAdXhczK6UkTQXaR7fpvaeeQsjvnb31k7Mgnea4eIqb1cyLlugBi33wIDp6BV6jyCTni0z+NkPC/+n7FOVkbt6wNMw+t+9yONEt5MAk6uumsvJhLj6YtgbmmgOPB1L4lhfBsHCsG4eaRR2WZK6QAdYZwwHCH3Skxutmr2q0/RonH36dnwCeT/sUjB9avI9sHINzmvqbbQGREH9y6gHEQXMlfij+HcPxz0CdScpbvJxc9bwpn3it0G9FL03nUeRdGO/yQ=";
	String innoEnc = "r6nCJDsKFAjdvuYfu8jutZvA5th7iMxcV40tIIw1Dm4Qvbpg1JqrOnDvJIREO7TVR3aLxBrGu02YwmNTkpIW/YsAEgPmAz2AW2MlYI0SxjegjSUBH4F8XRAgR/uCNaVxzwaCBeLPnk0p9SKFJBnfuvhy77fKRvkSGJRHY9i/pifflYTGruUuZeGrKN5EQ+P3pYorbIr1YxNNNPETBuAqe3gujSd6Mkp2R0hQTOVi+EaCkaTq7pcqAVJ457wkUyWTC2dZZ6hmIzNU1v902/+FYHM6y5inYFBilj1zhmRbrfnKmC7tU0wxzp1edKkcqi2lY38VONgNFarIrdFE+cOlipx4DOvutxL0HMbxqcyztug=";

	//업로드 폴더를 지정한다. 기본(/pds) + 파라미터값(realPath : /inno/common... , /inno/homepage...)
	String innoRealPath			= Util.getValue(request.getParameter("realPath"), Constants.UPLOADDIR_COMMON);
	// ocument.getElementById("style_img_"+i).style.border = "2px solid #A7B6CE";
	// document.InnoDSPreview1.ListStyle = strStyle;

	String innoListStyle		= Util.getValue(request.getParameter("listStyle"), "large icon");
	String innoType				= Util.getValue(request.getParameter("type"), "type0");
	String innoTotalMaxSize		= Util.getValue(request.getParameter("totalMaxSize"), "1024");
	String innoUnitMaxSize		= Util.getValue(request.getParameter("unitMaxSize"), "1024");
	String innoMaxFileCount		= Util.getValue(request.getParameter("maxFileCount"), "200");
	String innoWidth			= Util.getValue(request.getParameter("nWidth"), "600");
	String innoHieght			= Util.getValue(request.getParameter("nHieght"), "200");

%>

<!-- a href="javascript:void(0);" onclick="document.InnoDS.OpenFolder();"><img src="/images/skin1/icon/ds_btn_select.gif" alt="" border="0"></a> &nbsp;
<a href="javascript:void(0);" onclick="document.InnoDS.OpenFile();"><img src="/images/skin1/icon/ap_btn_select.gif" alt="" border="0"></a-->

<script type="text/javascript" language="JavaScript">
<!--

var Enc = "<%= innoEnc %>";

var ListStyle = "<%= innoListStyle %>";
var ActionFilePath = "<%= innoUploadUrl %>?SAVE_DIR=<%= innoRealPath %>";
var FolderUpload = "<%= innoType %>";

InnoDSInit(<%=innoTotalMaxSize%>, <%=innoUnitMaxSize%>, <%=innoMaxFileCount%>, '<%=innoWidth%>', '<%=innoHieght%>');


//-->
</script>
<br>
&nbsp;<a href="javascript:void(0);" onclick="document.InnoDS.OpenFile();"><img src="/images/skin1/icon/ap_btn_select.gif" alt="" border="0"></a>
<br>