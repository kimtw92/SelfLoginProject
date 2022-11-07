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
	//String innoEnc = "AmX6mY04O72Gh62gX2FRg30VJNgiMFGJKcKkPLYYTRMhZxU7D6WOvRqlk6SzqrmHVRJ1GH9R3CmJ5842c/fZGY/AHhdWpTTCIeNqa5JV5dmezJjwlJG2Z2ySk/fZ+t1YnZJnyvEb7GdqG1i4aHstt3+6cEAptSBRpU+5+WE2clLNrdxQejQQrEmRisWWyTCCMFo2H8SiymTM8R6ZfAzuJCLrx1kAcV05ugH5yOV9jIXDRSTpmbKVvkRSHtZ02aGzSof6DGfRyyzKIDeKMhjedA==";
	//String innoEnc = "lfc3n1ayzPpQFbrbdcL13EYHw52lBg72P4Tu5s2EyNFVpRdsvEOlCixvbTGIBv4mXZ3ik7pLD9cYAfurbBGoV7y6WVhUh7wGp8sbKGAOfZKWTMhZXXSU8dx7vLGcTPse6eSABV37Dz4tOGyL2oMKYQi3i3f7CLMqxbytUIwOyM+4SjxvfiC3gwglE1gnocG0JFUGtHU/Xy8RhODh5P/248QHyPKQ4VkCpf8QN18Yo+dRqynj70FNj0zOQFfIekY9Q1N7rj+0qZdxwF5IqGLXnbwe3kLMxHmTpphuAhVupt2NPQ/s+ujBTWtHNeJgWpwujSRUKYJtqy9THGlut0x1KVYL0DHjh92KQx8NbVk6l3k=";
	String innoEnc = "r6nCJDsKFAjdvuYfu8jutZvA5th7iMxcV40tIIw1Dm4Qvbpg1JqrOnDvJIREO7TVR3aLxBrGu02YwmNTkpIW/YsAEgPmAz2AW2MlYI0SxjegjSUBH4F8XRAgR/uCNaVxzwaCBeLPnk0p9SKFJBnfuvhy77fKRvkSGJRHY9i/pifflYTGruUuZeGrKN5EQ+P3pYorbIr1YxNNNPETBuAqe3gujSd6Mkp2R0hQTOVi+EaCkaTq7pcqAVJ457wkUyWTC2dZZ6hmIzNU1v902/+FYHM6y5inYFBilj1zhmRbrfnKmC7tU0wxzp1edKkcqi2lY38VONgNFarIrdFE+cOlipx4DOvutxL0HMbxqcyztug=";

	//업로드 폴더를 지정한다. 기본(/pds) + 파라미터값(realPath : /inno/common... , /inno/homepage...)
	String innoRealPath			= Util.getValue(request.getParameter("realPath"), Constants.UPLOADDIR_COMMON);


	String innoListStyle		= Util.getValue(request.getParameter("listStyle"), "large icon");
	String innoType				= Util.getValue(request.getParameter("type"), "type0");
	String innoTotalMaxSize		= Util.getValue(request.getParameter("totalMaxSize"), "1024");
	String innoUnitMaxSize		= Util.getValue(request.getParameter("unitMaxSize"), "1024");
	String innoMaxFileCount		= Util.getValue(request.getParameter("maxFileCount"), "200");
	String innoWidth			= Util.getValue(request.getParameter("nWidth"), "500");
	String innoHieght			= Util.getValue(request.getParameter("nHieght"), "200");

%>


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
&nbsp;<a href="javascript:void(0);" onclick="document.InnoDS.OpenFile();"><img src="/images/skin1/icon/ap_btn_select.gif" alt="" border="0" alt="파일선택"></a>
&nbsp;<a href="javascript:void(0);" onclick="document.InnoDS.RemoveAllFiles();"><img src="/images/skin1/icon/btn_all_delete.gif" alt="" border="0"  alt="파일올삭제"></a>
<br>