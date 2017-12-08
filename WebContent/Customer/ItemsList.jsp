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
<title>My Items</title>
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
<div style="text-align: center;"><b>My Items</b>  <br>
</div>
<br>
<%
String message = "";
String itemID = request.getParameter("itemid");
if (itemID != null){
	message = "You successfully listed item number "+itemID+"!";
	%><div style="text-align: center; "><%=message %></div><br><%
}
	

%>
<table style="text-align: left; width: 100%;" border="2" cellpadding="2"
cellspacing="2">
<tbody>
<tr>
<td style="vertical-align: top;"><b>Item ID</b><br>
</td>
<td style="vertical-align: top;"><b>Item Name</b><br>
</td>
<td style="vertical-align: top;"><b>Category</b><br>
</td>
<td style="vertical-align: top;"><b>Auction Start Time</b><br>
</td>
<td style="vertical-align: top;"><b>Auction End Time</b><br>
</td>
<td style="vertical-align: top;"><b>Start Price</b><br>
</td>
<td style="vertical-align: top;"><b>Current Bid</b><br>
</td>
<td style="vertical-align: top;"><b>Status</b><br>
</td>
<td style="vertical-align: top;"><b>Item Info</b><br>
</td>
<td style="vertical-align: top;"><b>Bidders List</b><br>
</td>
</tr>
<%ResultSet r = null;
try{
r = customer.listMyItems();}
catch(IllegalStateException ise){
        out.println(ise.getMessage());
    }%>
<%while(r.next()){ %>

<tr>
<td style="vertical-align: top;"><%= r.getInt("ITEMID")%><br>
</td>
<td style="vertical-align: top;"><%= r.getString("ITEMNAME")%><br>
</td>
<td style="vertical-align: top;"><%= r.getString("CATEGORIES")%><br>
</td>
<td style="vertical-align: top;"><%= r.getString("STARTDATE").substring(0,10)%><br>
</td>
<td style="vertical-align: top;"><%= r.getString("ENDDATE").substring(0,10)%><br>
</td>
<td style="vertical-align: top;"><%= "$"+r.getString("STARTPRICE")%><br>
</td>
<td style="vertical-align: top;"><%= "$"+r.getString("CURRENTBID")%><br>
</td>
<td style="vertical-align: top;"><%= r.getString("STATUS")%><br>
</td>
<td style="vertical-align: top;"><form method="GET" action="ItemInfo.jsp" name="ItemInfo">
<input  style = "color: black" name="ItemInfo" type="hidden" value="<%=r.getInt("ITEMID") %>"/>
<button style = "color: black" value="Item Info" name="Item Info">Item Info</button><br>
</form><br>
</td>
<td style="vertical-align: top;"><form method="GET" action="BidderList.jsp" name="BidList">
<button style = "color: black" value="<%=r.getInt("ITEMID") %>" name="BidList">Bid History</button><br>
</form><br>
</tr>
<%} r.close(); %>
</tbody>
</table>
<br>
<form method="post" action="SellingManagement.jsp"
name="Return"><input style = "color: black" name="Return"
value="Return to Menu" type="submit"></form>
</body>
</html>