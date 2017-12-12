<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" import="java.sql.*, gabes.*"%>
<jsp:useBean id="customer" class="gabes.Customer" scope="session"/> 
<jsp:setProperty property="*" name="customer"/>
<% 
if(customer.getUsername() == null)
{
	response.sendRedirect("../CustomerLogout_action.jsp");
}
if(customer.hasRated(Integer.parseInt(request.getParameter("ItemID"))))
{
	response.sendRedirect("itemsBought.jsp?error=1");
}
%>
<html>
<head>
<meta content="text/html; charset=ISO-8859-1"
http-equiv="content-type">
<title>Leave Feedback</title>
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
<div style="text-align: center;"><b>Leave Feedback</b><br>
</div>

<form method="post" action="RateSeller_action.jsp" name="Leave">
Item Id:<br> <input name="ItemID" value=<%=request.getParameter("ItemID")%> readonly><br>
Item Name:<br><input name="ItemName" value=<%=request.getParameter("ItemName")%> readonly><br>
Overall Rating:<br><select name="Overall">
    <option value="1">1</option>
    <option value="2">2</option>
    <option value="3">3</option>
    <option value="4">4</option>
    <option value="5">5</option>
    <option value="6">6</option>
    <option value="7">7</option>
    <option value="8">8</option>
    <option value="9">9</option>
    <option value="10">10</option>
</select><br>
Item Quality:<br><select name="Quality">
    <option value="1">1</option>
    <option value="2">2</option>
    <option value="3">3</option>
    <option value="4">4</option>
    <option value="5">5</option>
</select><br>
Delivery:<br><select name="Delivery">
    <option value="1">1</option>
    <option value="2">2</option>
    <option value="3">3</option>
    <option value="4">4</option>
    <option value="5">5</option>
</select><br>
Comments:<br><textarea name="Comments" cols="50" rows="10"></textarea><br>
<input style = "color: black" name="Submit" value="Submit" type="submit"><br>
</form>
<form method="post" action="itemsBought.jsp"
name="Return"><input style = "color: black" name="Return"
value="Return to Your Items" type="submit"></form>
</body>
</html>