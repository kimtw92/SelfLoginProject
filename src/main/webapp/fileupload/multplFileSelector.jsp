<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%
    	String maxFileCount = request.getParameter("maxFileCount");
    	if(maxFileCount == null || "".equals(maxFileCount)){
    		maxFileCount = "3";
    	}
    %>
<script type="text/javascript" src="/commonInc/js/multifile.js"></script>
<!-- This is where the output will appear -->
<input id="my_file_element" type="file">
<div id="files_list"></div>
<!-- 설정값을 화면에서 Setting -->
<script>
	<!-- Create an instance of the multiSelector class, pass it the output target and the max number of files -->
	var multi_selector = new MultiSelector( document.getElementById( 'files_list' ));
// 	var multi_selector = new MultiSelector( document.getElementById( 'files_list' ), 3 );
	multi_selector.addElement( document.getElementById( 'my_file_element' ), <%=maxFileCount%>);
</script>
