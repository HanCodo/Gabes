<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
<div>
    <div class="left">
    	<a href="AdminMenu.jsp">
  			<img style="width:150px;height:42px;border:0;" alt="GABeS_Logo" src="../img/gabes.png">
		</a>
	</div>
    <div class="right">
    	<form method="post" action="../AdminLogout_action.jsp" name="logout">
    		<input style = "text-align: right; color: black" name="Logout" value="Logout" type="submit">
    	</form>
    </div>
</div>
<br>
<br>
<br>
<form method="post" action="Report/Report1.jsp"
name="Report1"><input style = "color: black" name="Report1"
value="View Sales Summary" type="submit"><br>
</form>
<form method="post" action="Report/Report2.jsp"
name="Report2"><input style = "color: black" name="Report2"
value="View Overall Commision Report" type="submit"><br>
</form>
<form method="post" action="AdminMenu.jsp"
name="Return"><input style = "color: black" name="Return"
value="Return to Menu" type="submit"><br>
</form>