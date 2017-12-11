<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page language="java" import="java.sql.*, gabes.*"%>
<jsp:useBean id="admin" class= "gabes.Admin" scope="session"/> 
<jsp:setProperty name="admin" property="*"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<% 	
if(admin.isLoggedIn() == false)
{
	response.sendRedirect("../index.jsp");
}
%>
<html>
<head>
<meta content="text/html; charset=ISO-8859-1"
http-equiv="content-type">
<title>Manage Users</title>
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
<div style="text-align: center;"><b>Manage Users</b></div>

<br>
<table style="text-align: left; width: 100%;" border="1" cellpadding="2"
cellspacing="2">
<tbody>
<tr>
<td style="vertical-align: top;"><b>UserID</b><br>
</td>
<td style="vertical-align: top;"><b>User Name</b><br>
</td>
<td style="vertical-align: top; width: 253px;"><b>First Name</b><br>
</td>
<td style="vertical-align: top; width: 245px;"><b>Last Name</b><br>
</td>
<td style="vertical-align: top; width: 282px;"><b>Password</b><br>
</td>
<td style="vertical-align: top;"><b>Phone</b><br>
</td>
<td style="vertical-align: top;"><b>Email</b><br>
</td>
</tr>
<%try {ResultSet users = admin.viewUsers();
//out.println(users);
while(users.next()){%>
<tr>
<td style="vertical-align: top;"><%try{out.println(users.getString(1));}catch(Exception ex){out.println("noo");} %><br>
</td>
<td style="vertical-align: top;"><%try{out.println(users.getString(2));}catch(Exception ex){out.println("noo");} %><br>
</td>
<td style="vertical-align: top; width: 253px;"><%try{out.println(users.getString(4));}catch(Exception ex){out.println("noo");}  %><br>
</td>
<td  style="vertical-align: top; width: 245px; "><%try{out.println(users.getString(5));}catch(Exception ex){out.println("noo");}  %><br>
</td>
<td style="vertical-align: top;; width: 282px;"><%try{out.println("******");}catch(Exception ex){out.println("noo");} %><br>
</td>
<td style="vertical-align: top;"><%try{out.println(users.getString(6));}catch(Exception ex){out.println("noo");}  %><br>
</td>
<td style="vertical-align: top;"><%try{out.println(users.getString(7));}catch(Exception ex){out.println("noo");} %><br>
</td>
</tr>
<%} }catch(Exception ex){
	out.println(ex);
	}%>
</tbody>
</table>
<form method="post" action="AddUser.jsp"
name="AddUser"><input style = "color: black" name="AddUser"
value="Add User" type="submit"><br>
</form>

<br>
<br>
<form method="post" action="AdminMenu.jsp"
name="Return"><input style = "color: black" name="Return"
value="Return to Menu" type="submit"><br>
</form>
</body>
</html>