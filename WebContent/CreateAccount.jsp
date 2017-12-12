<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page language="java" import="java.util.*, java.sql.*, gabes.*"%>
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
<%String message = "";
if(request.getParameter("status")!=null){
if (request.getParameter("status").equals("0"))
	message = "Missmached Passwords, please try again.";
else if(request.getParameter("status").equals("3"))
	message = "Password too long, max length of 15.";
else if(request.getParameter("status").equals("1"))
	message = "Account submitted for approval, Once approved you can use GABES!";
}
%>
<br>
<br>
<br>
<div style="color: red; text-align: center;"><%=message%></div><br>
<form method="post" action="CreateAccount_action.jsp" name="adduser">
User Name: <input name="userName"><br>
First Name: <input name="fName"><br>
Last Name: <input name="lName"><br>
Phone: <input name="phone"><br>
Email: <input name="email"><br>
Password: <input name="password"><br>
Re-Type Password: <input name="password2"><br>
<input style = "color: black" name="Confirm" value="Confirm" type="submit"><br>
</form>
<br>
<form method="post" action="index.jsp"
name="Return"><input style = "color: black" name="Return"
value="Return to Login" type="submit"><br>
</form>
</body>
</html>