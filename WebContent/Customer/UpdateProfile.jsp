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
	ResultSet rs = customer.profileInfo();
        //if (!rs.next()){
        //    response.sendRedirect("../Logout_action.jsp");
        //}
        //else {
            	%>
<html>
<head>
<meta content="text/html; charset=ISO-8859-1"
http-equiv="content-type">
<title>Update Profile</title>
<style type="text/css">
.left {
    float: left;
}
.right {
    float: right;
}
.shift {
    text-indent: 300px;
}
</style>
</head>
<body>
<div>
    <div class="left">
    	<a href="CustomerMenu.jsp">
  			<img style="width:150px;height:42px;border:0;" alt="GABeS_Logo" src="../img/gabes.png">
		</a>
	</div>
    <div class="right">
    	<form method="post" action="../CustomerLogout_action.jsp" name="logout">
    		Logged in as: <%=customer.getUsername()%> <input style = "text-align: right; color: black" name="Logout" value="Logout" type="submit">
    	</form>
    </div>
</div>
<br>
<br>
<br>
<% 
String message = "";
String errorParam = request.getParameter("error");
if (errorParam != null){
	int error = Integer.parseInt(errorParam);
	if (error == 1){
		message = "Incorrect password. Try again.";
	}
	else if (error == 2){
		message = "Password match fail. Try again.";
	}
}
%>
<div style="text-align: center;"><b>Update Profile </b><br>
</div>
<br>
<div style="color: red; text-align: center;"><%=message%></div><br>
<div class="container">
<form method="post" action="UpdateProfile_action.jsp" name="Update">
<table>
<tr><td>Username: </td><td><input name="username" value = <%=customer.getUsername()%>></td></tr>
<tr><td>First Name: </td><td><input name="fname" value = <%=customer.getFname()%>></td></tr>
<tr><td>Last Name: </td><td><input name="lname" value = <%=customer.getLname()%>></td></tr>
<tr><td>Email: </td><td><input name="email" value = <%=customer.getEmail()%>></td></tr>
<tr><td>Phone: </td><td><input name="phone" value = <%=customer.getPhone()%>></td></tr>
<tr><td>Seller Rating: </td><td><b> <%=rs.getString("avgRatings")%></b></td></tr>
<tr><td>Number of Ratings: </td><td><b> <%=rs.getString("numRatings")%></b></td></tr>
<tr><td>Old Password: </td><td><input name="oldPass" type="password"></td></tr>
<tr><td>New Password: </td><td><input name="pass1" type="password"></td></tr>
<tr><td>Retype Password: </td><td><input name="pass2" type="password"></td></tr>
</table>
<input style = "color: black" name="Update" value="Update" type="submit">
</form>
</div>
<form method="post" action="CustomerMenu.jsp" name="Return">
	<input style = "color: black" name="Return" value="Return to Menu" type="submit">
</form>
<% 		//}
    }
	catch(IllegalStateException ise){
    	out.println(ise.getMessage());
    }
    %>
</body>
</html>