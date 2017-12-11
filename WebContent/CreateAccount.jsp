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
<br>
<br>
<br>
<form method="post" action="AddUser_action.jsp" name="adduser">
<%ResultSet users = admin.viewUsers();
//out.println(users);
int x=0;
while(users.next()){ x++;
}%>
UserID: <input value=<%=x=10000+x %> name="userID" readonly><br>
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
<form method="post" action="AdminMenu.jsp"
name="Return"><input style = "color: black" name="Return"
value="Return to Menu" type="submit"><br>
</form>
</body>
</html>