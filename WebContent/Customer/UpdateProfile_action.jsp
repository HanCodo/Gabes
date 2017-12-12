<%@ page language="java" import="java.sql.*, gabes.*"%>
<jsp:useBean id="customer" class= "gabes.Customer" scope="session"/> 
<jsp:setProperty name="customer" property="*"/> 

<%
if(!request.getParameter("oldPass").equals("")){
	if(!request.getParameter("oldPass").equals(customer.getPass())){
		response.sendRedirect("UpdateProfile.jsp?error=1");
	}
	else if (!request.getParameter("pass1").equals(request.getParameter("pass2"))){
		response.sendRedirect("UpdateProfile.jsp?error=2");
	}
	else{
		int result = customer.updateProfile(request.getParameter("username"), request.getParameter("fname"), request.getParameter("lname"), request.getParameter("phone"), request.getParameter("email"), request.getParameter("pass1"));
		response.sendRedirect("UpdateProfile.jsp");
	}
}
else{
	int result = customer.updateProfile(request.getParameter("username"), request.getParameter("fname"), request.getParameter("lname"), request.getParameter("phone"), request.getParameter("email"), customer.getPass());
	response.sendRedirect("UpdateProfile.jsp");
}


%> 