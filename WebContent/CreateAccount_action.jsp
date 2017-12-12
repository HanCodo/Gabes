<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page language="java" import="java.util.*, java.sql.*, gabes.*"%>
    <jsp:useBean id="user" class= "gabes.User" scope="session"/> 
	<jsp:setProperty name="user" property="*"/>

    
    
<%
	if(!request.getParameter("password").equals(request.getParameter("password2"))){
		response.sendRedirect("CreateAccount.jsp?status=0");
	}
	else if(request.getParameter("phone").length()!=10){
		response.sendRedirect("CreateAccount.jsp?status=2");
	}
	else if(request.getParameter("password").length()>15){
		response.sendRedirect("CreateAccount.jsp?status=3");
	}
	else if(request.getParameter("password").length()>15){
		response.sendRedirect("CreateAccount.jsp?status=3");
	}
	else{
	user.insertUser(request.getParameter("userName"), request.getParameter("password"), request.getParameter("fName"), request.getParameter("lName"), request.getParameter("phone"), request.getParameter("email"));
	response.sendRedirect("CreateAccount.jsp?status=1");
	}
%>
