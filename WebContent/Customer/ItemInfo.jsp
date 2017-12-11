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
%>
<html>
<head>
<meta content="text/html; charset=ISO-8859-1"
http-equiv="content-type">
<title>Item Info</title>
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
<div style = "text-align: center"><b>Item Info</b></div>
<br>

<%ResultSet r = null;
try{
r = customer.viewItem(request.getParameter("ItemInfo"));}
catch(IllegalStateException ise){
        out.println(ise.getMessage());
    }%>
<%while(r.next()){ %>


<div style="color: Black; text-align: center;">Item ID: <%= r.getInt("ITEMID")%></div><br>


<div style="color: Black; text-align: center;">Item Name: <%= r.getString("ITEMNAME")%></div><br>

<div style="color: Black; text-align: center;">Category:<%= r.getString("CATEGORIES")%></div><br>

<div style="color: Black; text-align: center;">Start Date:<%= r.getString("STARTDATE").substring(0,10)%></div><br>

<div style="color: Black; text-align: center;">End Date: <%= r.getString("ENDDATE").substring(0,10)%></div><br>

<div style="color: Black; text-align: center;">Start Price: <%= "$"+r.getString("STARTPRICE")%></div><br>

<div style="color: Black; text-align: center;">Current Price: <%= "$"+r.getString("CURRENTBID")%></div><br>

<div style="color: Black; text-align: center;">Status: <%= r.getString("STATUS")%></div><br>

<div style="color: Black; text-align: center;">Description: <%= r.getString("DESCRIPT")%></div><br>



<%} r.close(); %>

<br>
<form method="post" action="ItemsList.jsp"
name="Return"><input style = "color: black" name="Return"
value="Return to Menu" type="submit"></form>
</body>
</html>