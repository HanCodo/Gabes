<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page language="java" import="java.util.*, java.sql.*, gabes.*"%>
<jsp:useBean id="admin" class= "gabes.Admin" scope="session"/> 
    
    
    <%
    ResultSet users = admin.viewUsers();
  	int x=0;
  	while(users.next()){ x++;
  	}%>
   
    <% 
    x=10000+x;
    if(request.getParameter("password").equals(request.getParameter("password2"))){
    	try{
		if (admin.insertUser(""+x, request.getParameter("userName"), request.getParameter("password"), 
				request.getParameter("fName"), request.getParameter("lName"), request.getParameter("phone"),
				request.getParameter("email")))
   			 response.sendRedirect("UserManagement.jsp");
    	else {
        	response.sendRedirect("UserManagement.jsp");
    	}
    	}catch(Exception ex) {
    		System.out.println(ex);
    		response.sendRedirect("UserManagement.jsp");
    	}
    }else {
    	response.sendRedirect("UserManagement.jsp");
	}
%> 