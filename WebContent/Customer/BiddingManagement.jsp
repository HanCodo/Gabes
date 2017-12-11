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
%>
<html>
<head>
<meta content="text/html; charset=ISO-8859-1"
http-equiv="content-type">
<title>Selling Manager</title>
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
<div style="text-align: center;"><b>Bidding Manager</b>  <br>
</div>
<br>
<form method="post" action="../Search.jsp"
name="Search"><input style = "color: black" name="Search"
value="Search" type="submit"><br>
</form>
<form method="post" action="Featured.jsp"
name="FeaturedItem"><input style = "color: black" name="FeaturedItem"
value="Featured Item" type="submit"><br>
</form>
<form method="post" action="AllItems.jsp"
name="AllItems"><input style = "color: black" name="AllItems"
value="Browse All Items" type="submit"><br>
</form>
<form method="post" action="CustomerMenu.jsp"
name="Return"><input style = "color: black" name="Return"
value="Return to Menu" type="submit"></form>
<br>
<br>
</body>
</html>
