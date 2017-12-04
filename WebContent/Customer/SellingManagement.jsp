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
<title></title>
</head>
<body>
<div style="text-align: right;">
<form method="post" action="../CustomerLogout_action.jsp" name="logout"><input
style = "color: black" name="Logout" value="Logout" type="submit"></form>
</div>
<div style="text-align: center;"><br>
</div>
<form method="post" action="ItemsList.jsp"
name="ItemLists"><input style = "color: black" name="ItemLists"
value="Item Lists" type="submit"><br>
</form>
<form method="post" action="AddItem.jsp"
name="Additem"><input style = "color: black" name="AddItem"
value="Add Item" type="submit"><br>
</form>
<form method="post" action="CustomerMenu.jsp"
name="Return"><input style = "color: black" name="Return"
value="Return to Menu" type="submit"></form>
<br>
<br>
</body>
</html>
