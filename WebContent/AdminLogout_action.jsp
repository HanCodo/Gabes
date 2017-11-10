<%@ page language="java" import="java.sql.*,gabes.*"%>
<jsp:useBean id="admin" class="gabes.Admin" scope="session"/> 
<% 
    try{
        admin.logout();
 		session.invalidate(); 
 
    }
    catch(IllegalStateException ise){
        out.println(ise.getMessage());
    }
    response.sendRedirect("index.jsp");
   %> 