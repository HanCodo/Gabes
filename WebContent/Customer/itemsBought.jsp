<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.sql.*"%>
<jsp:useBean id="customer" class= "gabes.Customer" scope="session"/> 
<jsp:setProperty name="customer" property="*"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
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
<div style="text-align: left;"><b><u>Your Purchased Items</u></b>  <br>
</div>
<br>
<table style="text-align: left; width: 100%;" border="2" cellpadding="2"
cellspacing="2">
<tr>
<td><b>ITEM ID</b>
</td>
<td><b>ITEM NAME </b>
</td>
<td><b> CATEGORY </b>
</td>
<td><b> START DATE </b>
</td>
<td><b> END DATE </b>
</td>
<td><b> BUY PRICE </b>
</td>
<td><b> RATE SELLER </b>
</td>
</tr>
<%ResultSet r = customer.listMyBoughtItems();
r.next();
do{%>
<tr>
<td>
<%=r.getInt("ITEMID")
%>
</td>
<td>
<%=r.getString("ITEMNAME")
%>
</td>
<td>
<%=r.getString("CATEGORIES")
%>
</td>
<td>
<%=r.getDate("STARTDATE")
%>
</td>
<td>
<%=r.getDate("ENDDATE")
%>
</td>
<td>
<%=r.getDouble("CURRENTBID")
%>
</td>
<td>
<form method="post" action="RateSeller.jsp" name="Rate">
<input name="ItemID" value=<%=r.getInt("ITEMID")%> type="hidden">
<input name="ItemName" value=<%=r.getString("ITEMNAME")%> type="hidden">
<input style = "color: black" name="Rate" value="Rate" type="submit">
</form>
</td>
</tr>
<%} while(r.next()); %>
</table>
<form method="post" action="CustomerMenu.jsp"
name="Return"><input style = "color: black" name="Return"
value="Return to Menu" type="submit"></form>

</body>
</html>