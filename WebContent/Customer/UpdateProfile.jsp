<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@ page language="java" import="java.sql.*, gabes.*"%>
<jsp:useBean id="customer" class= "gabes.Customer" scope="session"/> 
<jsp:setProperty property="*" name="customer"/>

<% 	
if(customer.getUsername() == null)
{
	response.sendRedirect("../CustomerLogout_action.jsp");
}
try{
        //if (!rs.next()){
        //    response.sendRedirect("../Logout_action.jsp");
        //}
        //else {
            	%>
<html>
<head>
<meta content="text/html; charset=ISO-8859-1"
http-equiv="content-type">
<title></title>
</head>
<body>
<div style="text-align: right;">
<form method="post" action="../CustomerLogout_action.jsp" name="logout"><input
style = "color: black" name="Logout" value="Logout" type="submit"></form>
</div>
<div style="text-align: center;">Update Profile <br>
</div>
<form method="post" action="UpdateProfile_action.jsp" name="Update">Username
<input name="username" value = <%=customer.getUsername()%>><br>
First Name <input name="fname" value = <%=customer.getFname()%>><br>
Last Name <input name="lname" value = <%=customer.getLname()%>><br>
Email <input name="email" value = <%=customer.getEmail()%>><br>
Phone <input name="phone" value = <%=customer.getPhone()%>><br>
Seller Rating <br>
Number of Ratings <br>
Old Password <input name="oldPass" type="password"><br>
New Password <input name="pass1" type="password"><br>
Retype Password <input name="pass2" type="password"><br>
<input style = "color: black" name="Update" value="Update" type="submit">
<br>
</form>
<form method="post" action="CustomerMenu.jsp"
name="Return"><input style = "color: black" name="Return"
value="Return to Menu" type="submit"></form>
<% 		//}
    }
	catch(IllegalStateException ise){
    	out.println(ise.getMessage());
    }
    %>
</body>
</html>