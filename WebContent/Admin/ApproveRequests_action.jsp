<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page language="java" import="java.util.*, java.sql.*, gabes.*"%>
    <jsp:useBean id="admin" class= "gabes.Admin" scope="session"/> 
	<jsp:setProperty name="admin" property="*"/>

    
    
<%
	if(request.getParameter("whatdo").equals("deny")){
		admin.denyUser(request.getParameter("who"));
		response.sendRedirect("ApproveRequests.jsp?status=0");
	}
	else if(request.getParameter("whatdo").equals("accept")){
		if(admin.acceptUser(request.getParameter("who")))
			response.sendRedirect("ApproveRequests.jsp?status=1");
		else
			response.sendRedirect("CreateAccount.jsp?status=2");
	}
	else{
	response.sendRedirect("CreateAccount.jsp?status=2");
	}
%>
