<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<jsp:useBean id="admin" class= "gabes.Admin" scope="session"/> 
<% 
if(admin.getPass() == null)
{
	response.sendRedirect("../AdminLogout_action.jsp");
}
%>
<html>
<head>
<meta content="text/html; charset=ISO-8859-1"
http-equiv="content-type">
<title>Homepage</title>
<style type="text/css">
.left {
    float: left;
}
.right {
    float: right;
}
</style>
</head>
<body>
<div>
    <div class="left">
    	<a href="AdminMenu.jsp">
  			<img style="width:150px;height:42px;border:0;" alt="GABeS_Logo" src="../img/gabes.png">
		</a>
	</div>
    <div class="right">
    	<form method="post" action="../AdminLogout_action.jsp" name="logout">
    		Logged in as: <%=admin.getUsername()%> <input style = "text-align: right; color: black" name="Logout" value="Logout" type="submit">
    	</form>
    </div>
</div>
<br>
<br>
<br>
<div style="text-align: center;"><b>Admin Homepage</b></div>
<form method="post" action="UserManagement.jsp"
name="UserManagement"><input style = "color: black" name="UserManagement"
value="User Management" type="submit"><br>
</form>
<form method="post" action="ViewReports.jsp"
name="ViewReports"><input style = "color: black" name="ViewReports"
value="View Reports" type="submit"><br>
</form>
<br>
<br>
</body>
</html>