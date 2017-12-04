<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="admin" class= "gabes.Admin" scope="session"/> 
<jsp:setProperty name="admin" property="*"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
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
</style>
</head>
<body>
<<<<<<< HEAD
<form method="post" action="AddUser_action.jsp" name="adduser">
UserID: <input name="userID"><br>
User Name: <input name="userName"><br>
First Name: <input name="fName"><br>
Last Name: <input name="lName"><br>
Phone: <input name="phone"><br>
Email: <input name="email"><br>
Password: <input name="password"><br>
re-Type Password: <input name="password2"><br>
<input style = "color: black" name="Confirm" value="Confirm" type="submit"><br>
</form>
=======
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
<table style="text-align: left; width: 100%;" border="1" cellpadding="2"
cellspacing="2">
<tbody>
<tr>
<td style="vertical-align: top; width: 795px;">UserID<br>
</td>
<td style="vertical-align: top; width: 808px;"><br>
</td>
</tr>
<tr>
<td style="vertical-align: top; width: 795px;">User Name<br>
</td>
<td style="vertical-align: top; width: 808px;"><br>
</td>
</tr>
<tr>
<td style="vertical-align: top; width: 795px;">First Name<br>
</td>
<td style="vertical-align: top; width: 808px;"><br>
</td>
</tr>
<tr>
<td style="vertical-align: top; width: 795px;">Last Name<br>
</td>
<td style="vertical-align: top; width: 808px;"><br>
</td>
</tr>
<tr>
<td style="vertical-align: top; width: 795px;">Phone<br>
</td>
<td style="vertical-align: top; width: 808px;"><br>
</td>
</tr>
<tr>
<td style="vertical-align: top; width: 795px;">Email<br>
</td>
<td style="vertical-align: top; width: 808px;"><br>
</td>
</tr>
<tr>
<td style="vertical-align: top; width: 795px;">Password<br>
</td>
<td style="vertical-align: top; width: 808px;"><br>
</td>
</tr>
<tr>
<td style="vertical-align: top; width: 795px;">re-type Password<br>
</td>
<td style="vertical-align: top; width: 808px;"><br>
</td>
</tr>
</tbody>
</table>
<br>
>>>>>>> branch 'master' of https://github.com/HanCodo/Gabes.git
</body>
</html>