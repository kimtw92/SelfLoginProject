<%@ page language="java" contentType="text/html; charset=UTF-8" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
	
	<title>인천광역시인재개발원에 오신 것을 환영합니다.[1]</title>


<link href="/commonInc/css/master_style.css" rel="stylesheet" type="text/css">
<link href="/commonInc/css/style2.css" rel="stylesheet" type="text/css">
<link href="/commonInc/css/protoload.css" rel="stylesheet" type="text/css">

<script language="javascript" src="/commonInc/js/prototype-1.6.0.2.js"></script>
<script language="javascript" src="/commonInc/js/commonJs.js"></script>
<script language="javascript" src="/commonInc/js/NChecker.js"></script>
<script language="javascript" src="/commonInc/js/protoload.js"></script>
<script language="javascript" src="/commonInc/inno/InnoDS.js"></script>
<%
//로그인된 사용자 정보

ut.lib.login.LoginInfo commonTopMemberInfo = (ut.lib.login.LoginInfo)request.getAttribute("LOGIN_INFO");
String categoryJsStr = "category.js";

if(commonTopMemberInfo.getSessClass() != null) {
if( commonTopMemberInfo.getSessClass().equals(ut.lib.util.Constants.ADMIN_SESS_CLASS_COURSE) )
	categoryJsStr = "course_category.js";
else if( commonTopMemberInfo.getSessClass().equals(ut.lib.util.Constants.ADMIN_SESS_CLASS_DEPT) )
	categoryJsStr = "dept_category.js";
else if( commonTopMemberInfo.getSessClass().equals(ut.lib.util.Constants.ADMIN_SESS_CLASS_TEST) )
	categoryJsStr = "test_category.js";
else if( commonTopMemberInfo.getSessClass().equals(ut.lib.util.Constants.ADMIN_SESS_CLASS_TUTOR) )
	categoryJsStr = "tutor_category.js";
else if( commonTopMemberInfo.getSessClass().equals(ut.lib.util.Constants.ADMIN_SESS_CLASS_COURSEMAN) )
	categoryJsStr = "courseman_category.js";
else if( commonTopMemberInfo.getSessClass().equals(ut.lib.util.Constants.ADMIN_SESS_CLASS_HOMEPAGE) )
	categoryJsStr = "homepage_category.js";
else if( commonTopMemberInfo.getSessClass().equals(ut.lib.util.Constants.ADMIN_SESS_CLASS_PART) )
	categoryJsStr = "part_category.js";
else if( commonTopMemberInfo.getSessClass().equals(ut.lib.util.Constants.ADMIN_SESS_CLASS_STUDENT) )
	categoryJsStr = "student_category.js";
}
%>

<script language="javascript" src="/commonInc/js/<%= categoryJsStr %>"></script>

</head>
