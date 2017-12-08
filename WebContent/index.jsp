<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta content="text/html; charset=ISO-8859-1"
http-equiv="content-type">
<title>GABeS</title>
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
   	<a href="index.jsp">
 			<img style="width:150px;height:42px;border:0;" alt="GABeS_Logo" src="img/gabes.png">
	</a>
</div>
<br>
<form method="post" action="UserLogin.jsp"
name="UserLogin"><input style = "color: black" name="UserLogin"
value="Login as a customer" type="submit"><br>
</form>
<form method="post" action="AdminLogin.jsp"
name="AdminLogin"><input style = "color: black" name="AdminLogin"
value="Login as an administrator" type="submit"><br>
</form>
<br>
<br>
</body>
</html>