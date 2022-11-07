<%@page import="loti.homeFront.service.IndexService"%>
<%@page import="org.springframework.web.context.support.WebApplicationContextUtils"%>
<%@page import="org.springframework.web.context.WebApplicationContext"%>
<%@page import="org.springframework.web.servlet.FrameworkServlet"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.*" %>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%

	String attr = FrameworkServlet.SERVLET_CONTEXT_PREFIX+"dispatcher";
	
	WebApplicationContext context =  WebApplicationContextUtils.getWebApplicationContext(request.getSession().getServletContext(),attr);
	
	IndexService service = context.getBean(IndexService.class);

	// 스트러츠에서는 멀티파트 리퀘스트가 안되서...jsp로 처리함.

	//String path="D:\\workspace\\LOTI\\WebRoot\\inno\\pic"; // 경로지정
	String path=request.getRealPath("/inno/pic/"); // 경로지정
// 	String path="/data1/loti_data/pic/";

	int size = 1024*1024*10;
	MultipartRequest cosReq = new MultipartRequest(request,path,size,"utf-8",new DefaultFileRenamePolicy());
	String fileName= cosReq.getFilesystemName("picfile");
	

	if(fileName == null) {
		out.println("not success");
	}else {
        if(fileName.indexOf(".jpg") != -1 || fileName.indexOf(".JPG") != -1) {
            Integer fileNo = service.getFileNo();
            File oldFile = new File(path + "/" + fileName);      
            System.out.println(oldFile + ">>>>>>>>>>>>>");
            fileName = fileNo + ".jpg"; // 이름 중복으로 인해 넘버로 변경처리 jpg 가능

            File newFile = new File(path + "/" + fileName);
            System.out.println(newFile + ">>>2>>>>>>>>>>");
            oldFile.renameTo(newFile); // 파일명 변경 
            service.setJoinPicture(fileNo.toString(), path, fileName);
            
            out.println("<script>alert('사진이 저장되었습니다.');</script>");
            out.println("<script>opener.document.getElementById('fileno').value="+fileNo+"</script>");
            out.println("<script>opener.document.getElementById('mypicture').src=\"../inno/pic/"+fileName+"\"</script>");
            out.println("<script>self.close();</script>");
        } else {
            out.println("<script>alert('jpg 가 아닙니다. 다시 시도해주세요.');</script>");       
            out.println("<script>self.close();</script>");
        }
	}	
%>

