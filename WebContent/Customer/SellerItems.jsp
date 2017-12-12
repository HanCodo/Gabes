<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    %>
    <%@ page language="java" import="java.sql.*, java.text.*,java.sql.Date, gabes.*"%>
<jsp:useBean id="admin" class= "gabes.Admin" scope="session"/> 
<jsp:setProperty name="admin" property="*"/>
<jsp:useBean id="customer" class= "gabes.Customer" scope="session"/> 
<jsp:setProperty name="customer" property="*"/>
<% 
if(customer.getUsername() == null)
{
	response.sendRedirect("../CustomerLogout_action.jsp");
}
int change = customer.updateStatuses();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta content="text/html; charset=ISO-8859-1"
http-equiv="content-type">
<title>All Items</title>
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
<div style="text-align:center;"><b>All Items on Sale</b></div>
<br>
<%
String s = request.getParameter("SellerItems");
int sNum =Integer.parseInt(s);
ResultSet items = customer.sellerItems(sNum); %>
<table style="text-align: left; width: 100%;" border="1" cellpadding="2"
cellspacing="2">
<tbody>
<tr>
<td style="vertical-align: top;"><b>ItemID</b><br>
</td>
<td style="vertical-align: top;"><b>Start Date</b><br>
</td>
<td style="vertical-align: top; width: 253px;"><b>End Date</b><br>
</td>
<td style="vertical-align: top; width: 245px;"><b>Item Name</b><br>
</td>
<td style="vertical-align: top; width: 282px;"><b>Item Description</b><br>
</td>
<td style="vertical-align: top;"><b>Category</b><br>
</td>
<td style="vertical-align: top;"><b>Status</b><br>
</td>
<td style="vertical-align: top;"><b>Current Bid</b><br>
</td>
<td style="vertical-align: top;"><b>Buy Now</b><br>
</td>
</tr>
<%while (items.next()){ 
if(items.getString("STATUS").equals("ON AUCTION")){%>
<tr>
<td>
<%=
items.getInt("ITEMID")
%>
</td>
<td>
<%=
items.getDate("STARTDATE")
%>
</td>
<td>
<%=
items.getDate("ENDDATE")
%>
</td>
<td>
<%=
items.getString("ITEMNAME")
%>
</td>
<td>
<%=
items.getString("DESCRIPT")
%>
</td>
<td>
<%=
items.getString("CATEGORIES")
%>
</td>
<td>
<%=
items.getString("STATUS")
%>
</td>
<td>
<%=
items.getDouble("CURRENTBID")
%>
<form method="post" action="Bid.jsp?i=<%=items.getInt("ITEMID")%>" name="Bid"><input style = "color: black" name="Bid" value="Bid" type="submit">
</form>
</td>
<td>
<%
if(items.getString(10) == null){
	out.println("Buy now not made available by seller");
}
else{
	try{
		out.println("$"+items.getString("buyNow"));
		}
	catch(Exception ex){
		out.println("noo");
		}
	%>
<form method="post" action="BuyNow_action.jsp?i=<%=items.getInt("ITEMID")%>&p=<%=items.getDouble("BUYNOW")%>" name="Buynow">
<input style = "color: black" name="BuyNow" value="Buy Now" type="submit"></form></td>
</tr>
<%}
}
}%>
</tbody>
</table>
<br>
<form method="post" action="FollowSellers.jsp"
name="Return"><input style = "color: black" name="Return"
value="Return to Menu" type="submit"></form>
</body>
</html>
