<%@page import="ut.lib.support.DataMap"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%

DataMap requestMap = (DataMap) request.getAttribute("REQUEST_DATA");

int res = (Integer) request.getAttribute("res");

%>
<%=res%>명의 답안지가 삭제되었습니다.\n
삭제된 답안지를 복구하시려면 삭제된 답안지 목록에서 답안지 복구를 사용하세요.\n
답안지가 삭제된 응시자는 시험 기간중이라면 다시 로그인하여 재 시험을 볼 수 있습니다.
