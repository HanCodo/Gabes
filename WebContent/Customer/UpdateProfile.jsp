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
<title></title>
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
<div style="text-align: center;">Update Profile <br>
</div>
<br>
<div class="container">
<form method="post" action="UpdateProfile_action.jsp" name="Update">
<label>Username: </label><input name="username" value = <%=customer.getUsername()%>><br>
<label>First Name: </label><input name="fname" value = <%=customer.getFname()%>><br>
<label>Last Name: </label><input name="lname" value = <%=customer.getLname()%>><br>
<label>Email: </label><input name="email" value = <%=customer.getEmail()%>><br>
<label>Phone: </label><input name="phone" value = <%=customer.getPhone()%>><br>
<label>Seller Rating: </label><b> <%=rs.getString("avgRatings")%></b><br>
<label>Number of Ratings: </label><b> <%=rs.getString("numRatings")%></b><br>
<label>Old Password: </label><input name="oldPass" type="password"><br>
<label>New Password: </label><input name="pass1" type="password"><br>
<label>Retype Password: </label><input name="pass2" type="password"><br>
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