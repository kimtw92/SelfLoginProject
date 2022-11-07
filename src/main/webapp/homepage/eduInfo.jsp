<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%@ include file="/commonInc/include/commonImport.jsp"%>
<%@ include file="/commonInc/include/comInclude.jsp"%>
<%

// 필수, request 데이타
DataMap requestMap = (DataMap)request.getAttribute("REQUEST_DATA");
requestMap.setNullToInitialize(true);

LoginInfo loginInfo = (LoginInfo)request.getAttribute("LOGIN_INFO");

DataMap listMap = (DataMap)request.getAttribute("sess_userid");

DataMap infoMap = (DataMap)request.getAttribute("USER_INFO");
infoMap.setNullToInitialize(true);

String mjiknm = infoMap.getString("mjiknm", 0);
String deptnm = infoMap.getString("deptnm", 0);
String deptsub = infoMap.getString("deptsub", 0);
String ecnmjiknm = infoMap.getString("ecnmjiknm", 0);
String ecndeptnm = infoMap.getString("ecndeptnm", 0);
String ecndeptsub = infoMap.getString("ecndeptsub", 0);
String ecnsex = infoMap.getString("ecnsex", 0);
String ecnuserId = infoMap.getString("ecnuserId", 0);
String ecnuserName = infoMap.getString("ecnuserName", 0);
String ecnuserEmail = infoMap.getString("ecnuserEmail", 0);
String ecnuserDept = infoMap.getString("ecnuserDept", 0);
String ecnuserJik = infoMap.getString("ecnuserJik", 0);
String ecnuserHp = infoMap.getString("ecnuserHp", 0);
String ecnhp1 = infoMap.getString("ecnhp1", 0);
String ecnhp2 = infoMap.getString("ecnhp2", 0);
String ecnhp3 = infoMap.getString("ecnhp3", 0);
String sex = infoMap.getString("sex", 0);


%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
<head>
<title>인천인재개발원</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="keywords" content="" />
<meta name="description" content="" />
<style type="text/css">
<!--
body, div, p, img, ul, li, table, caption, colgroup, thead, tr, th, td,
	tbody, a, input {
	margin: 0;
	padding: 0;
}

body {
	font-size: 11px;
	color: #231f20;
	font-family: "나눔바른고딕", "돋움", NanumBarunGothic, dotum;
}

caption {
	position: absolute;
	left: -999px;
	width: 1px;
	height: 1px;
	font-size: 0;
	line-height: 0;
	overflow: hidden;
	visibility: hidden;
}

ul {
	list-style-type: none;
	margin: 8px 0;
	font-size: 12px;
}

div.popup {
	padding: 15px 9px 23px 30px;
	background: url(images/bg.png) repeat-x 0 0;
	width: 650px;
	height: 450px;
}

table {
	border-top: 5px solid #242021;
	border-bottom: 1px solid #918f8f;
	border-collapse: collapse;
}

table tr {
	height: 20px;
}

table tr.bg {
	background-color: #b0babf;
	font-weight: bold;
}

table th {
	padding: 8px;
	color: #0e78ad;
	border-bottom: 1px solid #918f8f;
}

table td {
	padding: 4px 0 4px 10px;
}

.btn {
	text-align: center;
}

.btn input.it {
	vertical-align: middle;
	margin-top: 22px;
	height: 23px;
}
//
-->
</style>
<title>인천광역시 인재개발원에 오신 것을 환영합니다.</title>


<script type="text/javascript" language="javascript"
	src="/commonInc/js/prototype-1.6.0.2.js"></script>
<script type="text/javascript" language="javascript"
	src="/commonInc/js/NChecker.js"></script>
<script type="text/javascript" language="javascript"
	src="/commonInc/js/protoload.js"></script>
<script type="text/javascript" language="javascript"
	src="/commonInc/js/homeCategory.js"></script>

<script language="javascript" src="/commonInc/js/commonJs.js"></script>

<Script language='javascript'>

<!--
/*
function goCyberKmaContents() {
	if(<%=loginInfo.isLogin()%> == true) {
		var userid = "<%=loginInfo.getSessUserId()%>";
		var name = escape(encodeURIComponent("<%=loginInfo.getSessName() %>"));

		
		var paramname = name;

		if(userid == "" || userid == null || userid == "null") {
			window.open("/homepage/index.do?mode=createid","createId","scrollbars=no,resizable=no,width=460,height=300").focus();
			return;
		}
		var join = "1";
		var memberCheck = false;
		var checkUrl1 = '/commonInc/include/ajaxRequestText.jsp?ID=' + userid + '&NAME=' + paramname + '&JOIN=' + join;
		new Ajax.Request( checkUrl1, {
			method     : 'post',
			parameters : {
			},
			asynchronous:false,
			onSuccess : function(request) {
				try {
					 if(request.responseText.indexOf("TRUE") != -1) { 
						memberCheck = true;
					 } 
				} catch(e) {
					alert(e.description);
				}
			},
			on401: function() {
				alert("세션이 종료되었습니다.");
				return;
			},
			onFailure : function(request) {
				alert("오류 발생");
				return;
			}
		});

		if(memberCheck) {
			document.cyberkmaForwardPage.target = "_blank";
			document.cyberkmaForwardPage.NAME.value = name;
			document.cyberkmaForwardPage.submit();
			return;
		}

		var popupObj = window.showModalDialog("/mypage/myclass.do?mode=memberUpdate&code=1", self, "dialogHeight=790px;dialogWidth=500px; scroll=yes; status=yes; help=no; center=yes");
		
		var hp1 = "";
		var hp2 = "";
		var hp3 = "";
		var email = "";
		var dept = "";
		var deptsub = "";
		var jiknm = "";
		var check = "N";
		var sex = "<%=sex%>";
		var useragent = navigator.userAgent;

		if((useragent.indexOf('MSIE 6')  > 0) || (useragent.indexOf('MSIE 7')  > 0) || (useragent.indexOf('MSIE 8')  > 0)) {
			try {
				hp1 = popupObj.hp1;
				hp2 = popupObj.hp2;
				hp3 = popupObj.hp3;
				email = popupObj.email;
				dept = popupObj.dept_name;
				deptsub = popupObj.deptsub;
				jiknm = popupObj.degreename;
				check = popupObj.close;				
			} catch (e) {
				check = "N";
			}
		} else if((useragent.indexOf('MSIE 9')  > 0) || (useragent.indexOf('MSIE 10')  > 0)) {
			try {
				hp1 = popupObj["hp1"];
				hp2 = popupObj["hp2"];
				hp3 = popupObj["hp3"];
				email = popupObj["email"];
				dept = popupObj["dept_name"];
				deptsub = popupObj["deptsub"];
				jiknm = popupObj["degreename"];
				check = popupObj["close"];
			} catch (e) {
				check = "N";
			}
		} else {
			try {
				hp1 = popupObj.hp1;
				hp2 = popupObj.hp2;
				hp3 = popupObj.hp3;
				email = popupObj.email;
				dept = popupObj.dept_name;
				deptsub = popupObj.deptsub;
				jiknm = popupObj.degreename;
				check = popupObj.close;				
			} catch (e) {
				check = "N";
			}
		}

		deptsub = escape(encodeURIComponent(deptsub));
		jiknm = escape(encodeURIComponent(jiknm));
		dept = escape(encodeURIComponent(dept));

		var join2 = "0";

		if(check == "Y") {			
			var checkUrl2 = '/commonInc/include/ajaxRequestText.jsp?ID=' + userid + '&NAME=' + paramname + '&JOIN='+join2+'&EMAIL=' + email + '&HP1='  + hp1 + '&HP2='  + hp2 + '&HP3='  + hp3 + '&COMPANY_BU='  + deptsub + '&COMPANY_JIKGUB='  + jiknm + "&COMPANY_NAME=" + dept + "&SEX=" + sex;

			new Ajax.Request(checkUrl2, {
				method     : 'post',
				parameters : {
				},
				asynchronous:false,
				onSuccess : function(request) {
					try {
						if(request.responseText.indexOf("TRUE") != -1) {
							document.cyberkmaForwardPage.target = "_blank";
							document.cyberkmaForwardPage.NAME.value = name;
							document.cyberkmaForwardPage.submit();
							return;
						} else {
							alert(request.responseText);
							//window.open("http://hrd.incheon.go.kr/popup/popup7.jsp","newPagodaPopup","width=750px,height=180px,scrollbars=yes,resizable=yes");            
						}
					} catch(e) {
						alert(e.description);
					}
				},
				on401: function() {
					alert("세션이 종료되었습니다.");
					return;
				},
				onFailure : function() {
					alert("오류 발생");
					return;
				}
			});

			return;
		}

	} else {
		alert("로그인후 사용하실수 있습니다.");
		return;
	}    
}

*/



function goKacnetContents() {
	if(<%=loginInfo.isLogin()%> == true) {
		var userid = "<%=loginInfo.getSessUserId()%>";
		var name = escape(encodeURIComponent("<%=loginInfo.getSessName() %>"));
		<%-- var sex = escape(encodeURIComponent("<%=listMap.getString("sex", 0)%>")); --%>
		var sex = "<%=sex%>";
		var email = escape(encodeURIComponent("<%=loginInfo.getSessUserEmail()%>"));
		
		var paramname = name;

		if(userid == "" || userid == null || userid == "null") {
			window.open("/homepage/index.do?mode=createid","createId","scrollbars=no,resizable=no,width=460,height=300").focus();
			return;
		}
		var join = "1";
		var memberCheck = false;
			
		var checkUrl1 = '/commonInc/include/ajaxRequestText.jsp?ID=' + userid + '&NAME=' + paramname + '&JOIN=' + join + '&EMAIL=' + email + '&SEX=' + sex ;
		new Ajax.Request( checkUrl1, {
			method     : 'post',
			parameters : {
			},
			asynchronous:false,
			onSuccess : function(request) {
				try {
					
					if((request.responseText.indexOf("TRUE") != -1)|| userid == "sunhee1715"||userid == "minnow22") {
						memberCheck = true;
					}
				} catch(e) {
					alert(e.description);
				}
			},
			on401: function() {
				alert("세션이 종료되었습니다.");
				return;
			},
			onFailure : function(request) {
				alert("오류 발생");
				return;
			}
		});

		if(memberCheck) {
			document.kacnetForwardPage.target = "_blank";
			//document.kacnetForwardPage.NAME.value = name;
			document.kacnetForwardPage.submit();
			return;
		}

		var popupObj = window.showModalDialog("/mypage/myclass.do?mode=memberUpdate&code=1", self, "dialogHeight=790px;dialogWidth=500px; scroll=yes; status=yes; help=no; center=yes");
		
		var hp1 = "";
		var hp2 = "";
		var hp3 = "";
		var email = "";
		var dept = "";
		var deptsub = "";
		var jiknm = "";
		var check = "N";
		var sex = "<%=sex%>";
		var useragent = navigator.userAgent;

		if((useragent.indexOf('MSIE 6')  > 0) || (useragent.indexOf('MSIE 7')  > 0) || (useragent.indexOf('MSIE 8')  > 0)) {
			try {
				hp1 = popupObj.hp1;
				hp2 = popupObj.hp2;
				hp3 = popupObj.hp3;
				email = popupObj.email;
				dept = popupObj.dept_name;
				deptsub = popupObj.deptsub;
				jiknm = popupObj.degreename;
				check = popupObj.close;	
				
// 				alert(hp1);
// 				alert(hp2);
// 				alert(hp3);
// 				alert(email);
// 				alert(dept);
// 				alert(deptsub);
// 				alert(jiknm);
// 				alert(check);
			} catch (e) {
				check = "N";
			}
		} else if((useragent.indexOf('MSIE 9')  > 0) || (useragent.indexOf('MSIE 10')  > 0) || (useragent.indexOf('MSIE 11')  > 0)) {
			try {
				hp1 = popupObj["hp1"];
				hp2 = popupObj["hp2"];
				hp3 = popupObj["hp3"];
				email = popupObj["email"];
				dept = popupObj["dept_name"];
				deptsub = popupObj["deptsub"];
				jiknm = popupObj["degreename"];
				check = popupObj["close"];
			} catch (e) {
				check = "N";
			}
		} else {
			try {
				hp1 = popupObj.hp1;
				hp2 = popupObj.hp2;
				hp3 = popupObj.hp3;
				email = popupObj.email;
				dept = popupObj.dept_name;
				deptsub = popupObj.deptsub;
				jiknm = popupObj.degreename;
				check = popupObj.close;				
			} catch (e) {
				check = "N";
			}
		}

		deptsub = escape(encodeURIComponent(deptsub));
		jiknm = escape(encodeURIComponent(jiknm));
		dept = escape(encodeURIComponent(dept));

		var join2 = "0";

		if(check == "Y") {			
			var checkUrl2 = '/commonInc/include/ajaxRequestText.jsp?ID=' + userid + '&NAME=' + paramname + '&JOIN='+join2+'&EMAIL=' + email + '&HP1='  + hp1 + '&HP2='  + hp2 + '&HP3='  + hp3 + '&COMPANY_BU='  + deptsub + '&COMPANY_JIKGUB='  + jiknm + "&COMPANY_NAME=" + dept + "&SEX=" + sex;
			new Ajax.Request(checkUrl2, {
				method     : 'post',
				parameters : {
				},
				asynchronous:false,
				onSuccess : function(request) {
					try {
						alert(request.responseText);
						if(request.responseText.indexOf("TRUE") != -1) {
							document.kacnetForwardPage.target = "_blank";
							//document.kacnetForwardPage.NAME.value = name;
							document.kacnetForwardPage.submit();
							return;
						} else {
							alert(request.responseText);
							//window.open("http://hrd.incheon.go.kr/popup/popup7.jsp","newPagodaPopup","width=750px,height=180px,scrollbars=yes,resizable=yes");            
						}
					} catch(e) {
						alert(e.description);
					}
				},
				on401: function() {
					alert("세션이 종료되었습니다.");
					return;
				},
				onFailure : function() {
					alert("오류 발생");
					return;
				}
			});

			return;
		}

	} else {
		alert("로그인후 사용하실수 있습니다.");
		return;
	}    
}



function goLearnnrunContents() {
   if(document.getElementById("checkyn").checked){
		if(<%=loginInfo.isLogin()%> == true) {
				var userid = "<%=loginInfo.getSessUserId()%>";
				var name = escape(encodeURIComponent("<%=loginInfo.getSessName() %>"));
				var sex = "<%=sex%>";
				var email = escape(encodeURIComponent("<%=loginInfo.getSessUserEmail()%>"));
				var paramname = name;
				if(userid == "" || userid == null || userid == "null") {
					window.open("/homepage/index.do?mode=createid","createId","scrollbars=no,resizable=no,width=460,height=300").focus();
					return;
				}
				//alert("email => "+ email);
				//alert("sex => "+ sex);
				var join = "1";
				var memberCheck = false;
				var checkUrl1 = '/commonInc/include/ajaxRequestText3.jsp?ID=' + userid + '&NAME=' + paramname + '&JOIN=' + join + '&EMAIL=' + email + '&SEX=' + sex;
				new Ajax.Request( checkUrl1, {
					method     : 'post',
					parameters : {
					},
					asynchronous:false,
					onSuccess : function(request) {
						try {
							if(request.responseText.indexOf("true") != -1) {
								memberCheck = true;
							}
						} catch(e) {
							alert(e.description);
						}
					},
					on401: function() {
						alert("세션이 종료되었습니다.");
						return;
					},
					onFailure : function(request) {
						alert("오류 발생");
						return;
					}
				});
		
				if(memberCheck) {
					
					document.learnnrunForwardPage.target = "_blank";
					/*
					document.learnnrunForwardPage.organ.value = document.learnnrunForwardPage.organ.value;
					document.learnnrunForwardPage.depart.value = document.learnnrunForwardPage.depart.value;
					document.learnnrunForwardPage.position.value = document.learnnrunForwardPage.position.value;
					*/
					document.learnnrunForwardPage.submit();
					return;
					
				}
				
				//var popupObj = window.showModalDialog("/mypage/myclass.do?mode=memberUpdate&code=3", self, "dialogHeight=790px;dialogWidth=500px; scroll=yes; status=yes; help=no; center=yes");
				
				var popupObj;
				if(window.showModalDialog){
					popupObj = window.showModalDialog("/mypage/myclass.do?mode=memberUpdate&code=3", self, "dialogHeight=790px;dialogWidth=500px; scroll=yes; status=yes; help=no; center=yes");
				}else{
					popupObj = window.open('/mypage/myclass.do?mode=memberUpdate&code=3', self, 'height=790, width=500, scroll=yes, status=yes, help=no, center=yes');
				}
				
				
				
				
				var hp1 = "";
				var hp2 = "";
				var hp3 = "";
				var email = "";
				var dept = "";
				var deptsub = "";
				var jiknm = "";
				var check = "N";
				var sex = "<%=sex%>";
		
				var useragent = navigator.userAgent;
				
				if((useragent.indexOf('MSIE 6')  > 0) || (useragent.indexOf('MSIE 7')  > 0) || (useragent.indexOf('MSIE 8')  > 0)) {
					try {
						hp1 = popupObj.hp1;
						hp2 = popupObj.hp2;
						hp3 = popupObj.hp3;
						email = popupObj.email;
						dept = popupObj.dept_name;
						deptsub = popupObj.deptsub;
						jiknm = popupObj.degreename;
						check = popupObj.close;				
					} catch (e) {
						check = "N";
					}
				} else if((useragent.indexOf('MSIE 9')  > 0) || (useragent.indexOf('MSIE 10')  > 0)) {
					try {
						hp1 = popupObj["hp1"];
						hp2 = popupObj["hp2"];
						hp3 = popupObj["hp3"];
						email = popupObj["email"];
						dept = popupObj["dept_name"];
						deptsub = popupObj["deptsub"];
						jiknm = popupObj["degreename"];
						check = popupObj["close"];
					} catch (e) {
						check = "N";
					}
				} else {
					try {
						hp1 = popupObj.hp1;
						hp2 = popupObj.hp2;
						hp3 = popupObj.hp3;
						email = popupObj.email;
						dept = popupObj.dept_name;
						deptsub = popupObj.deptsub;
						jiknm = popupObj.degreename;
						check = popupObj.close;				
					} catch (e) {
						check = "N";
					}
				}
		
				deptsub = escape(encodeURIComponent(deptsub));
				jiknm = escape(encodeURIComponent(jiknm));
				dept = escape(encodeURIComponent(dept));
		
				if(check == "Y") {			
		
					var join2 = "0";
					var checkUrl2 = '/commonInc/include/ajaxRequestText3.jsp?ID=' + userid + '&NAME=' + paramname + '&EMAIL=' + email + '&HP1='  + hp1 + '&HP2='  + hp2 + '&HP3='  + hp3 + '&COMPANY_BU='  + deptsub + '&COMPANY_JIKGUB='  + jiknm + "&COMPANY_NAME=" + dept + "&SEX=" + sex + "&JOIN=" + join2;
		
					new Ajax.Request(checkUrl2, {
						method     : 'post',
						parameters : {
						},
						asynchronous:false,
						onSuccess : function(request) {
							try {
								if(request.responseText.indexOf("true") != -1) {
									document.learnnrunForwardPage.target = "_blank";
									/*
									document.learnnrunForwardPage.organ.value = dept;
									document.learnnrunForwardPage.depart.value = deptsub;
									document.learnnrunForwardPage.position.value = jiknm;
									*/
									document.learnnrunForwardPage.submit();
									return;
								} else {
									alert("등록 실패 관리자에게 문의해주세요.");
								}
							} catch(e) {
								alert(e.description);
							}
						},
						on401: function() {
							alert("세션이 종료되었습니다.");
							return;
						},
						onFailure : function() {
							alert("오류 발생");
							return;
						}
					});
		
					return;
				}
		
			} else {
				alert("로그인후 사용하실수 있습니다.");
				return;
			}  
	   
   }else{
	   alert("동의 체크를 해주세요");
	   return;
   }
   

}

//-->

// 2018-11-16 다락원 Function 재정의
function goDarakwonContents() {
	if(<%=loginInfo.isLogin()%> == true) {
		var userid = "<%=loginInfo.getSessUserId()%>";
		var name = escape(encodeURIComponent("<%=loginInfo.getSessName()%>"));
		var sex = "<%=sex%>";
		var email = escape(encodeURIComponent("<%=loginInfo.getSessUserEmail()%>"));
		var paramname = name;
		if(userid == "" || userid == null || userid == "null") {
			window.open("/homepage/index.do?mode=createid","createId","scrollbars=no,resizable=no,width=460,height=300").focus();
			return;
		}
		var join = "1";
		var memberCheck = false;
		//다락원 D001
		var checkUrl1 = '/homepage/memberUpdateAgree.do?ssocompany=D001&mode=ajaxUpdate&ID=' + userid + '&NAME=' + paramname + '&JOIN=' + join + '&EMAIL=' + email + '&SEX=' + sex ;
		new Ajax.Request( checkUrl1, {
			method     : 'post',
			parameters : {
			},
			asynchronous:false,
			onSuccess : function(request) {
				try {
					if(request.responseText.trim() == 'AGREE'){
						memberCheck = true;
					}
				} catch(e) {
					alert(e.description);
				}
			},
			on401: function() {
				alert("세션이 종료되었습니다.");
				return;
			},
			onFailure : function(request) {
				alert("오류 발생");
				return;
			}
		});
		if(memberCheck) {
			document.darakwonForwardPage.target = "_blank";
			document.darakwonForwardPage.submit();
			return;
		}
		var popupObj = window.showModalDialog("/mypage/myclass.do?ssocompany=D001&mode=memberUpdate&code=1", self, "dialogHeight=790px;dialogWidth=500px; scroll=yes; status=yes; help=no; center=yes");

		new Ajax.Request( checkUrl1, {
			method     : 'post',
			parameters : {
			},
			asynchronous:false,
			onSuccess : function(request) {
				try {
					if(request.responseText.trim() == 'AGREE'){
						document.darakwonForwardPage.target = "_blank";
						document.darakwonForwardPage.submit();
					}
				} catch(e) {
					alert(e.description);
				}
			},
			on401: function() {
				alert("세션이 종료되었습니다.");
				return;
			},
			onFailure : function(request) {
				alert("오류 발생");
				return;
			}
		});
	} else {
		alert("로그인후 사용하실수 있습니다.");
		return;
	}    
}///다락원


//2022-01-25 브랜트에듀 Function
function goBrantEduContents() {
	if(<%=loginInfo.isLogin()%> == true) {
		var userid = "<%=loginInfo.getSessUserId()%>";
		var name = escape(encodeURIComponent("<%=loginInfo.getSessName()%>"));
		var sex = "<%=sex%>";
		var email = escape(encodeURIComponent("<%=loginInfo.getSessUserEmail()%>"));
		var paramname = name;
		if(userid == "" || userid == null || userid == "null") {
			window.open("/homepage/index.do?mode=createid","createId","scrollbars=no,resizable=no,width=460,height=300").focus();
			return;
		}
		var join = "1";
		var memberCheck = false;

		var checkUrl1 = '/homepage/memberUpdateAgree.do?ssocompany=D003&mode=ajaxUpdate&ID=' + userid + '&NAME=' + paramname + '&JOIN=' + join + '&EMAIL=' + email + '&SEX=' + sex ;
		new Ajax.Request( checkUrl1, {
			method     : 'post',
			parameters : {
			},
			asynchronous:false,
			onSuccess : function(request) {
				try {
					if(request.responseText.trim() == 'AGREE'){
						memberCheck = true;
					}
				} catch(e) {
					alert(e.description);
				}
			},
			on401: function() {
				alert("세션이 종료되었습니다.");
				return;
			},
			onFailure : function(request) {
				alert("오류 발생");
				return;
			}
		});
		if(memberCheck) {
			document.BrantEduForwardPage.target = "_blank";
			document.BrantEduForwardPage.submit();
			return;
		}
		var popupObj = window.showModalDialog("/mypage/myclass.do?ssocompany=D003&mode=memberUpdate&code=1", self, "dialogHeight=790px;dialogWidth=500px; scroll=yes; status=yes; help=no; center=yes");

		new Ajax.Request( checkUrl1, {
			method     : 'post',
			parameters : {

			},
			asynchronous:false,
			onSuccess : function(request) {
				try {
					if(request.responseText.trim() == 'AGREE'){
						document.BrantEduForwardPage.target = "_blank";
						document.BrantEduForwardPage.submit();
					}
				} catch(e) {
					alert(e.description);
				}
			},
			on401: function() {
				alert("세션이 종료되었습니다.");
				return;
			},
			onFailure : function(request) {
				alert("오류 발생");
				return;
			}
		});
	} else {
		alert("로그인후 사용하실수 있습니다.");
		return;
	}    
}//브랜트에듀


</script>
</head>
<body>
	<form method="post" name="pForm" ID="pForm">
		<input type="hidden" name="userno" id="userno"
			value="<%=requestMap.getString("userno")%>">
			<div class="popup">
				<p>
					<img src="/images/pop_title.gif" alt="" />
				</p>
				<ul class="">
					<li>2022년 공무원 e-러닝(외국어)은 2개 분야로 운영합니다.</li>
					<li>교육안내를 참조하여 희망하는 학습방식을 선택해주세요.</li>
				</ul>
				<table width="640" cellpadding="0" cellspacing="0" class=""
					summary="분야, 동영상강좌, 언어학습 솔루션에 의한 공무원사이버 외국어교육안내 표입니다.">
					<caption>공무원사이버외국어교육안내</caption>
					<colgroup>
						<col width="98" />
						<col width="230" />
						<col width="210" />
					</colgroup>
					<thead>
						<tr>
							<th width="79">분야</th>
							<th colspan="2">동영상 과정</th>
							<th colspan="2">참여형 언어학습 과정</th>
						</tr>
					</thead>
					<tbody>
						<tr class="bg">
							<td>언어수</td>
							<td colspan="2">9개 외국어<br />
							<p style="font-size: 10px;">※영어, 중국어, 일본어, 스페인어, 프랑스어, 독일어,
									러시아어, 베트남어, 태국어</p>
							</td>
							<td colspan="2">9개 외국어<br />
								<p style="font-size: 10px;">※영어, 중국어, 일본어, 스페인어, 프랑스어, 독일어,
									필리핀어, 러시아어, 베트남어</p>
							</td>
						</tr>
						<tr>
							<td>학습주도</td>
							<td colspan="2">강사</td>
							<td colspan="2">학습자</td>
						</tr>
						<tr class="bg">
							<td>학습방법</td>
							<td colspan="2">일방향</td>
							<td colspan="2">양방향</td>
						</tr>
						<tr>
							<td>교육방법</td>
							<td colspan="2">동영상시청</td>
							<td colspan="2">문제 풀이식 학습활동 참여(S/W 양방향 학습)</td>
						</tr>
						<tr class="bg">
							<td>상시학습</td>
							<td colspan="2">학습차시의 50%(1~4강좌)</td>
							<td colspan="2">학습시간100%인정(5~40시간)</td>
						</tr>
						<tr>
							<td>교육수료</td>
							<td colspan="2">진도율 70% + 평가응시 + 설문</td>
							<td colspan="2">5시간이상학습</td>
						</tr>
						<tr class="bg">
							<td>교육취소</td>
							<td colspan="2">본인 취소 가능</td>
							<td colspan="2">신청 후 7일 이내 미수강 / 교육중 7일 연속 미수강</td>
						</tr>
						<tr>
							<td>수강인원</td>
							<td colspan="2">무제한</td>
							<td colspan="2">선착순 200명(교육취소발생시 대기자 교육등록)<br />※ 200명 초과시
								대기자 신청
							</td>
						</tr>
						<tr class="bg">
							<td>이벤트</td>
							<td colspan="2">매 기수 수료자 중 150명에게 1만원상당의 모바일 상품권 증정</td>
							<td colspan="2">매 기수 수료자 중 30명에게 1만원상당의 모바일 상품권 증정</td>
						</tr>

						<tr>
							<td>학습준비물</td>
							<td colspan="2">없음</td>
							<td colspan="2">PC에서 학습할 경우 헤드셋 필요<br />(스마트폰 학습의 경우 불필요)
							</td>
						</tr>
						<tr class="bg">
							<td>수강신청</td>
							<td width="163">교육기간 중 상시 신청 <BR /> <font color="red">※
									개강일 9시 이후</font></td>
							<!-- <td width="66"><a href="javascript:goCyberKmaContents();"><img src="/images/in_btn.png" width="47" height="47" border="0"/></a></td> -->
							<!-- <td width="66"><a href="javascript:goKacnetContents();"><img src="/images/in_btn.png" width="47" height="47" border="0"/></a></td> -->
							<!-- 2022-01-25 브랜트에듀 Function 재정의 -->
							<td width="66"><a href="javascript:goBrantEduContents();"><img
									src="/images/in_btn.png" width="47" height="47" border="0" /></a></td>
							<td width="283">교육기간 중 상시 신청 <BR /> <font color="red">※
									개강일 9시 이후</font></td>
							<td width="57"><a href="javascript:goLearnnrunContents();"><img
									src="/images/in_btn.png" width="47" height="47" border="0" /></a></td>
						</tr>
					</tbody>
				</table>
				<br />
				<div>
					인천광역시 공무원 사이버외국어 위탁교육과 관련하여 인재개발원 홈페이지에 저장되어 있는 교육생의 개인정보를 위탁업체에 제공
					및 활용하는것에 동의합니다.
					<p class="infor_bt_b">
					<input type="hidden" id="checkSSO" name="checkSSO" value="${checkSSO}"/>
						<c:choose>
							<c:when test="${empty checkSSO }">
								<input type="checkbox" id="checkyn" name="checkyn" value="N" />동의 체크<BR />
							</c:when>
							<c:otherwise>
								<input type="checkbox" id="checkyn" name="checkyn" value="Y" checked/>동의 체크<BR />
							</c:otherwise>
						</c:choose>
						
						<!-- 
							function check_checkyn(){
								var f = document.form;
								f.getElementById("checkyn")
							}
						 -->
						 
						
						<!-- <input type="checkbox" id="checkyn" name="checkyn" />동의 체크<BR /> -->
						<BR />
						<!-- span><a href=""><img src="/commonInc/css/img/pop_information_bt_18.gif" alt="동의" /></a></span>
    			<span><a href=""><img src="/commonInc/css/img/pop_information_bt_20.gif" alt="동의안함" /></a></span -->
						<td>○ 개인정보 항목 : ID, 소속기관, 부서명, 직급, 핸드폰번호, 이메일, 성별<br />
						</td>
						<td>○ 이용목적 : 수강생 학습 관리<br />
						</td>
						<td>○ 보유기간 : 위탁교육 종료 시 까지</td>

					</p>
				</div>
				<!--<div class="btn">
		<a href="javascript:window.close();"><img src="/images/pop_btn.gif" class="it" title="닫기" alt="닫기" border="0"/></a>
	</div>-->
			</div>
	</form>
	<%-- <form id="cyberkmaForwardPage" name="cyberkmaForwardPage" target='globalForward' method="post" action="http://incheon.cyberkma.or.kr/ssogate.asp">
		<input type="hidden" id="ID" name="ID" value="<%=loginInfo.getSessUserId()%>" />
		<input type="hidden" id="NAME" name="NAME"/>
		<input type="hidden" id="COMPANY_JIKGUB" name="COMPANY_JIKGUB" value="<%=mjiknm %>"/>
		<input type="hidden" id="COMPANY_BU" name="COMPANY_BU" value="<%=deptsub %>"/>
		<input type="hidden" id="COMPANY_NAME" name="COMPANY_NAME" value="<%=deptnm %>"/>
	</form> --%>
	<form id="kacnetForwardPage" name="kacnetForwardPage"
		target='globalForward' method="post"
		action="https://lms.darakwon.co.kr/incheon/sso.asp">
		<!-- <form id="kacnetForwardPage" name="kacnetForwardPage" target='globalForward' method="post" action="http://lms.darakwon.co.kr/incheon"> -->
		<input type="hidden" id="ID" name="ID"
			value="<%=loginInfo.getSessUserId()%>" /> <input type="hidden"
			id="NAME" name="NAME" value="<%=loginInfo.getSessName()%>" /> <input
			type="hidden" id="MOBILE" name="MOBILE"
			value="<%=loginInfo.getSessUserHp()%>" /> <input type="hidden"
			id="COMPANY_JIKGUB" name="COMPANY_JIKGUB" value="<%=mjiknm%>" /> <input
			type="hidden" id="COMPANY_BU" name="COMPANY_BU" value="<%=deptsub%>" />
		<input type="hidden" id="COMPANY_NAME" name="COMPANY_NAME"
			value="<%=deptnm%>" /> <input type="hidden" id="SEX" name="SEX"
			value="<%=sex%>" /> <input type="hidden" id="EMAIL" name="EMAIL"
			value="<%=loginInfo.getSessUserEmail()%>" />
	</form>

	<!-- <form id="learnnrunForwardPage" name="learnnrunForwardPage" target='learnnrunForward' method="post" action="http://www.learnnrun.com/incheon/sso"> -->
	<form id="learnnrunForwardPage" name="learnnrunForwardPage"
		target='learnnrunForward' method="post"
		action="http://hrd.rosettakorea.com/incheon/sso">
		<input type="hidden" id="id" name="id"
			value="<%=loginInfo.getSessUserId()%>" /> <input type="hidden"
			id="email" name="email" value="<%=loginInfo.getSessUserEmail()%>" />
		<input type="hidden" id="mobile" name="mobile"
			value="<%=loginInfo.getSessUserHp()%>" /> <input type="hidden"
			id="position" name="position" value="<%=mjiknm%>" /> <input
			type="hidden" id="depart" name="depart" value="<%=deptsub%>" /> <input
			type="hidden" id="organ" name="organ" value="<%=deptnm%>" />
	</form>


	<!-- 2018-11-15 다락원 function 재정의 -->
	<form id="darakwonForwardPage" name="darakwonForwardPage"
		target="darakwon" method="post"
		action="https://lms.darakwon.co.kr/incheon/sso.asp">
		<input type="hidden" id="ID" name="ID"
			value="<%=loginInfo.getSessUserId()%>" /> <input type="hidden"
			id="NAME" name="NAME" value="<%=loginInfo.getSessName()%>" /> <input
			type="hidden" id="MOBILE" name="MOBILE"
			value="<%=loginInfo.getSessUserHp()%>" /> <input type="hidden"
			id="COMPANY_JIKGUB" name="COMPANY_JIKGUB" value="<%=mjiknm%>" /> <input
			type="hidden" id="COMPANY_BU" name="COMPANY_BU" value="<%=deptsub%>" />
		<input type="hidden" id="COMPANY_NAME" name="COMPANY_NAME"
			value="<%=deptnm%>" /> <input type="hidden" id="SEX" name="SEX"
			value="<%=sex%>" /> <input type="hidden" id="EMAIL" name="EMAIL"
			value="<%=loginInfo.getSessUserEmail()%>" />
	</form>

	<%
		String hp = loginInfo.getSessUserHp();
		hp = hp.replaceAll("-", "");
	%>

	<!-- 2022-01-25 브랜트에듀 -->
	<form id="BrantEduForwardPage" name="BrantEduForwardPage"
		target="BrantEdu" method="post"
		action="http://cyber.brentphone.kr/incheon/sso.asp">
		<input type="hidden" id="USERId" name="ID"
			value="<%=loginInfo.getSessUserId()%>" /> <input type="hidden"
			id="USERNAME" name="NAME" value="<%=loginInfo.getSessName()%>" /> <input
			type="hidden" id="COMPANY_JIKGUB" name="company_JIKGUB"
			value="<%=mjiknm%>" /> <input type="hidden" id="COMPANY_BU"
			name="COMPANY_BU" value="<%=deptsub%>" /> <input type="hidden"
			id="COMPANY_NAME" name="COMPANY_NAME" value="<%=deptnm%>" /> <input
			type="hidden" id="MOBILE" name="MOBILE" value="<%=hp%>" /> <input
			type="hidden" id="SEX" name="SEX" value="<%=sex%>" /> <input
			type="hidden" id="EMAIL" name="EMAIL"
			value="<%=loginInfo.getSessUserEmail()%>" />
	</form>


</body>
</html>
