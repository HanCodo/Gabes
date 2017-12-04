<%@ page language="java" import="java.sql.*, gabes.*"%>
<jsp:useBean id="admin" class= "gabes.Admin" scope="session"/> 
<jsp:setProperty name="admin" property="*"/> 

<%
if (admin.login())
    response.sendRedirect("Admin/AdminMenu.jsp");
else
    response.sendRedirect("AdminLogin.jsp?error=1");
%> 